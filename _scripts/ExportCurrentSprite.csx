using System;
using System.IO;
using System.Threading.Tasks;
using System.Windows;
using Newtonsoft.Json;
using UndertaleModLib.Models;
using UndertaleModLib.Util;

EnsureDataLoaded();


UndertaleModTool.MainWindow mainWindow = Application.Current.MainWindow as UndertaleModTool.MainWindow;
if (mainWindow == null)
{
    ScriptMessage("Error: Could not access the main UI window.");
    return;
}

UndertaleSprite currentSpr = null;

if (mainWindow.CurrentTab != null && mainWindow.CurrentTab.CurrentObject is UndertaleSprite)
{
    currentSpr = mainWindow.CurrentTab.CurrentObject as UndertaleSprite;
}
else if (mainWindow.Selected is UndertaleSprite)
{
    currentSpr = mainWindow.Selected as UndertaleSprite;
}

if (currentSpr == null)
{
    ScriptMessage("No sprite is currently open! Please open a sprite in a tab and try again.");
    return;
}

string exportBaseDir = PromptChooseDirectory();
if (exportBaseDir == null) return;


string spriteName = currentSpr.Name.Content;
string spriteDir = Path.Combine(exportBaseDir, spriteName);
Directory.CreateDirectory(spriteDir);


bool padded = ScriptQuestion("Export sprite frames with padding?");

var metadata = new
{
    Name = spriteName,
    Width = currentSpr.Width,
    Height = currentSpr.Height,
    MarginLeft = currentSpr.MarginLeft,
    MarginRight = currentSpr.MarginRight,
    MarginBottom = currentSpr.MarginBottom,
    MarginTop = currentSpr.MarginTop,
    BBoxMode = currentSpr.BBoxMode,
    SepMasks = (int)currentSpr.SepMasks, 
    OriginX = currentSpr.OriginX,
    OriginY = currentSpr.OriginY,
    
    
    IsSpecialType = currentSpr.IsSpecialType,
    SVersion = currentSpr.SVersion,
    GMS2PlaybackSpeed = currentSpr.GMS2PlaybackSpeed,
    GMS2PlaybackSpeedType = (int)currentSpr.GMS2PlaybackSpeedType
};

string jsonOutput = JsonConvert.SerializeObject(metadata, Formatting.Indented);
File.WriteAllText(Path.Combine(spriteDir, "metadata.json"), jsonOutput);


SetProgressBar(null, "Exporting frames...", 0, currentSpr.Textures.Count);
StartProgressBarUpdater();

TextureWorker worker = null;
using (worker = new TextureWorker())
{
    await Task.Run(() => 
    {
        for (int i = 0; i < currentSpr.Textures.Count; i++)
        {
            if (currentSpr.Textures[i]?.Texture != null)
            {
                
                string fileName = $"{spriteName}_{i}.png";
                worker.ExportAsPNG(currentSpr.Textures[i].Texture, Path.Combine(spriteDir, fileName), null, padded);
            }
            IncrementProgress();
        }
    });
}

await StopProgressBarUpdater();
HideProgressBar();

ScriptMessage($"Successfully exported {spriteName} ({currentSpr.Textures.Count} frames)!");


