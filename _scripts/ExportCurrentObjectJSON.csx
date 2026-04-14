using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using Newtonsoft.Json;
using UndertaleModLib.Models;

EnsureDataLoaded();

UndertaleModTool.MainWindow mainWindow = Application.Current.MainWindow as UndertaleModTool.MainWindow;
if (mainWindow == null)
{
    ScriptMessage("Error: Could not access the main UI window.");
    return;
}

UndertaleGameObject currentObj = null;

if (mainWindow.CurrentTab != null && mainWindow.CurrentTab.CurrentObject is UndertaleGameObject)
{
    currentObj = mainWindow.CurrentTab.CurrentObject as UndertaleGameObject;
}
else if (mainWindow.Selected is UndertaleGameObject)
{
    currentObj = mainWindow.Selected as UndertaleGameObject;
}

if (currentObj == null)
{
    ScriptMessage("No object is currently open! Please open an object in a tab (or select one in the list) and try again.");
    return;
}

string exportDir = PromptChooseDirectory();
if (exportDir == null)
{
    return;
}


var eventsList = new List<object>();
for (int i = 0; i < currentObj.Events.Count; i++)
{
    var subEvents = currentObj.Events[i];
    if (subEvents != null && subEvents.Count > 0)
    {
        foreach (var ev in subEvents)
        {
            string codeName = null;
            
            var action = ev.Actions.FirstOrDefault();
            if (action != null && action.CodeId != null)
            {
                codeName = action.CodeId.Name?.Content;
            }

            eventsList.Add(new
            {
                EventType = ((EventType)i).ToString(), 
                EventSubtype = ev.EventSubtype,        
                CodeName = codeName                    
            });
        }
    }
}

var jsonObject = new
{
    Name = currentObj.Name?.Content,
    Sprite = currentObj.Sprite?.Name?.Content,
    Visible = currentObj.Visible,
    Solid = currentObj.Solid,
    Depth = currentObj.Depth,
    Persistent = currentObj.Persistent,
    Parent = currentObj.ParentId?.Name?.Content,
    TextureMask = currentObj.TextureMaskId?.Name?.Content,
    UsesPhysics = currentObj.UsesPhysics,
    IsSensor = currentObj.IsSensor,
    CollisionShape = (int)currentObj.CollisionShape,
    Density = currentObj.Density,
    Restitution = currentObj.Restitution,
    Group = currentObj.Group,
    LinearDamping = currentObj.LinearDamping,
    AngularDamping = currentObj.AngularDamping,
    Friction = currentObj.Friction,
    Awake = currentObj.Awake,
    Kinematic = currentObj.Kinematic,
    Events = eventsList
};

string jsonOutput = JsonConvert.SerializeObject(jsonObject, Formatting.Indented);
string filePath = Path.Combine(exportDir, $"{currentObj.Name.Content}.json");

File.WriteAllText(filePath, jsonOutput);

ScriptMessage($"Successfully exported {currentObj.Name.Content} to JSON!");

