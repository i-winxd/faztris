using System;
using System.IO;
using System.Windows;
using Newtonsoft.Json;
using UndertaleModLib;
using UndertaleModLib.Models;

EnsureDataLoaded();


UndertaleModTool.MainWindow mainWindow = Application.Current.MainWindow as UndertaleModTool.MainWindow;
if (mainWindow == null)
{
    ScriptMessage("Error: Could not access the main UI window.");
    return;
}

UndertaleSound currentSound = null;

if (mainWindow.CurrentTab != null && mainWindow.CurrentTab.CurrentObject is UndertaleSound)
{
    currentSound = mainWindow.CurrentTab.CurrentObject as UndertaleSound;
}
else if (mainWindow.Selected is UndertaleSound)
{
    currentSound = mainWindow.Selected as UndertaleSound;
}

if (currentSound == null)
{
    ScriptMessage("No sound is currently open! Please open a sound in a tab and try again.");
    return;
}

string exportBaseDir = PromptChooseDirectory();
if (exportBaseDir == null)
{
    return;
}

string soundName = currentSound.Name.Content;
string soundDir = Path.Combine(exportBaseDir, soundName);
Directory.CreateDirectory(soundDir);

var metadata = new
{
    Name = soundName,
    Flags = (uint)currentSound.Flags,
    Type = currentSound.Type?.Content,
    File = currentSound.File?.Content,
    Effects = currentSound.Effects,
    Volume = currentSound.Volume,
    Pitch = currentSound.Pitch,
    AudioGroup = currentSound.AudioGroup?.Name?.Content ?? "audiogroup_default"
};

string jsonOutput = JsonConvert.SerializeObject(metadata, Formatting.Indented);
File.WriteAllText(Path.Combine(soundDir, "metadata.json"), jsonOutput);


byte[] audioData = null;

if (currentSound.AudioFile != null)
{
    audioData = currentSound.AudioFile.Data;
}

else if (currentSound.GroupID > Data.GetBuiltinSoundGroupID())
{
    string audioGroupName = currentSound.AudioGroup != null ? currentSound.AudioGroup.Name.Content : "audiogroup_default";
    string relativeAudioGroupPath = currentSound.AudioGroup?.Path?.Content ?? $"audiogroup{currentSound.GroupID}.dat";
    string groupFilePath = Path.Combine(Path.GetDirectoryName(FilePath), relativeAudioGroupPath);
    
    if (File.Exists(groupFilePath))
    {
        try
        {
            using (var stream = new FileStream(groupFilePath, FileMode.Open, FileAccess.Read))
            {
                UndertaleData agData = UndertaleIO.Read(stream, (warning, _) => ScriptWarning($"Warning loading {audioGroupName}:\n{warning}"));
                if (agData != null && currentSound.AudioID >= 0 && currentSound.AudioID < agData.EmbeddedAudio.Count)
                {
                    audioData = agData.EmbeddedAudio[currentSound.AudioID].Data;
                }
            }
        }
        catch (Exception e)
        {
            ScriptError($"Failed to extract audio from {audioGroupName}: {e.Message}");
            return;
        }
    }
    else
    {
        ScriptWarning($"Audio group file '{relativeAudioGroupPath}' not found next to data.win. Exporting JSON metadata only.");
    }
}


if (audioData != null)
{
    
    bool isCompressed = currentSound.Flags.HasFlag(UndertaleSound.AudioEntryFlags.IsCompressed);
    bool isEmbedded = currentSound.Flags.HasFlag(UndertaleSound.AudioEntryFlags.IsEmbedded);
    
    string audioExt = ".ogg"; 
    if (isEmbedded && !isCompressed) audioExt = ".wav";
    
    string audioFilePath = Path.Combine(soundDir, $"{soundName}{audioExt}");
    File.WriteAllBytes(audioFilePath, audioData);
}

else if (!currentSound.Flags.HasFlag(UndertaleSound.AudioEntryFlags.IsEmbedded))
{
    string externalFilename = currentSound.File?.Content;
    if (!string.IsNullOrEmpty(externalFilename))
    {
        if (!externalFilename.Contains('.')) externalFilename += ".ogg";
        
        string sourcePath = Path.Combine(Path.GetDirectoryName(FilePath), externalFilename);
        if (File.Exists(sourcePath))
        {
            string destPath = Path.Combine(soundDir, externalFilename);
            File.Copy(sourcePath, destPath, true);
        }
        else
        {
            ScriptWarning($"External audio file '{externalFilename}' not found next to data.win. Exporting JSON metadata only.");
        }
    }
}

ScriptMessage($"Successfully exported {soundName}!");