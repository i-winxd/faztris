TextOrder = "NECimndlesghtuo1234567890 Pa";
FontNightOpening = font_add_sprite_ext(sFontNightOpening, TextOrder, true, 4);
Lock = false;
PreviousOptions = ["Balls", "Nuts"];
CurrentDesc = "";
PreviousDesc = "";
PreviousYOffset = 0;
SelectedOption = 0;
XOffset = array_create(99, 0);
YOffset = -152;
FaceSprites = -1;

if (room == TitleScreenMap)
    FaceSprites = import_sprites("selection.png", sNightGuardFacesSelection, 2);

GuardOffset = array_create(global.GuardAmount, -640);
ContDescOffset = -32;
SetXOffset = 150;
PreviousSetXOffset = 120;
Transitioning = false;
TransitionDegree = 0;
TransitionFrame = 0;
RoomDestination = undefined;
OptionsMenu = -1;
RemapKey = 0;
DescriptionList = [];
DifficultyDescriptions = ["Best for those unfamiliar with the FNaF formula, or just looking for a relatively stress-free experience. Highly recommended for a first playthrough!", "The go-to middle-of-the-road option! Best for those familiar with the FNaF formula but not yet familiar with this game specifically. Might get tough near the end!", "Recommended for Frickbear's veterans looking for a real challenge. Do NOT jump into this one first!", "Do you hate yourself, or are supremely self-confident? If you've got the free time to spare, this is the difficulty level for you."];
Options[0] = [];
Options[1][0] = ["x1", "x2", "x3", "x4"];
Options[1][1] = ["Windowed", "Fullscreen"];
global.ColorModeAmount = array_length(Options[1][1]);
Options[2][0] = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100];
Options[2][1] = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100];
Options[2][2] = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100];
Options[2][3] = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100];
Options[2][4] = ["On", "Off", "Quiet", "Funny"];
Options[2][5] = ["On", "Death Quips Off", "Gameplay-Essential Only", "Death Quips Only", "All Off"];
Options[2][6] = ["On", "Off"];
Options[3][0] = ["No", "Yes"];
Options[3][1] = ["0%", "25%", "50%", "75%", "100%", "125%", "150%", "175%", "200%"];
Options[3][2] = ["Off", "On"];
Options[3][3] = ["Off", "Run Time", "Total Playtime"];

// NEW CODE - TET - ARR (1-5) - DAS (1-20) - DCD (1-20) - SDF (1-100x)
// DEFAULTS: 2, 10, 1, 26
// ARR: Options[3][4], DAS: Options[3][5], DCD: Options[3][6], SDF: Options[3][7]
Options[3][4] = [0, 1, 2, 3, 4, 5];
// DAS
Options[3][5] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];
// DCD
Options[3][6] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];
// SDF
Options[3][7] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70];



function goto_menu(arg0, arg1)
{
    CurMenu = arg0;
    SelectedOption = arg1;
    
    switch (arg0)
    {
        case "Null":
            CurrentOptions = [""];
            CurrentDesc = "";
            break;
        
        case "Title":
            if (room != TitleScreenMap)
            {
                goto_menu("Pause", 0);
            }
            else
            {
                CurrentOptions = ["New Game", "Continue", "Custom Night", "Extras", "Options", "Quit Game"];
                CurrentDesc = "";
                
                if (!global.CanContinue)
                    array_delete(CurrentOptions, 1, 1);
                
                if (!array_contains(global.UnlockedAnimatronics, true) && !global.DevMode)
                    array_delete(CurrentOptions, array_length(CurrentOptions) - 4, 1);
                
                if (!global.UnlockedAnimatronics[UnknownEnum.Value_56] && !global.DevMode)
                    array_delete(CurrentOptions, array_length(CurrentOptions) - 3, 1);
            }
            
            break;
        
        case "Pause":
            CurrentOptions = ["Resume", "Restart Night", "Review Animatronics", "Review Upgrades", "Options", "Quit to Menu", "Quit Game"];
            
            if (in_salvage_location())
                CurrentOptions = ["Resume", "Review Animatronics", "Review Upgrades", "Options", "Quit to Menu", "Quit Game"];
            
            CurrentDesc = "GAME PAUSED";
            break;
        
        case "New Game":
            CurrentOptions = ["Jeremy", "Mike", "Vanessa"];
            
            if (global.UnlockedAnimatronics[UnknownEnum.Value_68] || global.GuardAmount > 4)
                array_push(CurrentOptions, "Fritz");
            
            CurrentDesc = "Select your night guard.";
            
            if (global.GuardAmount > 4)
            {
                for (var i = 4; i < global.GuardAmount; i++)
                    array_push(CurrentOptions, no_brackets(global.GuardNames[i]));
            }
            
            break;
        
        case "Difficulty":
            CurrentOptions = ["Easy", "Normal", "Hard"];
            
            if (global.UnlockedAnimatronics[UnknownEnum.Value_68])
                array_push(CurrentOptions, "Lunatic");
            
            CurrentDesc = "Select a difficulty.";
            break;
        
        case "Options":
            CurrentOptions = ["Remap Controls", "Graphics", "Audio", "Gameplay", "Delete Save Data", "Restore Defaults", "Back"];
            
            if (room != TitleScreenMap)
                array_delete(CurrentOptions, 4, 1);
            
            OptionsMenu = -1;
            CurrentDesc = "";
            break;
        
        case "Remap Controls":
            CurrentOptions = ["Confirm", "Back / Pause", "Up", "Left", "Down", "Right", "Monitor (Office)", "Mask (Office)", "Left Door (Office)", "Right Door (Office)", "Flashlight (Office)", "Fan (Office)", "Hotkey - Cam 01", "Hotkey - Cam 02", "Hotkey - Cam 03", "Hotkey - Cam 04", "Hotkey - Cam 05", "Hotkey - Cam 06", "Hotkey - Cam 07", "Hotkey - Cam 08", "Hotkey - Camera System", "Hotkey - Vents System", "Hotkey - Shop System", "Hotkey - Games System", "Sprint (Freeroam)", "Sneak (Freeroam)", "Rotate 90° CCW (Faztris)", "Rotate 90° CW (Faztris)", "Rotate 180° (Faztris)", "Hold (Faztris)", "Hard Drop (Faztris)", "Soft Drop (Faztris)","Move piece left (Faztris)", "Move piece right (Faztris)", "Restore Defaults", "Back"];
            OptionsMenu = 0;
            CurrentDesc = "";
            break;
        
        case "Graphics":
            CurrentOptions = ["Window Size", "Window Mode", "Back"];
            OptionsMenu = 1;
            CurrentDesc = "";
            break;
        
        case "Audio":
            CurrentOptions = ["Master Volume", "SFX Volume", "Music Volume", "Voice Volume", "Jumpscare Screams", "Voice Lines", "Subtitles", "Back"];
            OptionsMenu = 2;
            CurrentDesc = "";
            break;
// NEW CODE - TET - ARR (1-5) - DAS (1-20) - DCD (1-20) - SDF (1-100x)
        case "Gameplay":
            CurrentOptions = ["Lock Mouse in Window", "Mouse Sensitivity (Freeroam)", "View Bobbing (Freeroam)", "Game Timer", "ARR", "DAS", "DCD", "SDF", "Back"];
            OptionsMenu = 3;
            CurrentDesc = "";
            break;
        
        case "Delete Save Data":
            CurrentOptions = ["Yes", "No"];
            CurrentDesc = "Are you sure you want to delete all save data? This can't be undone!";
            break;
        
        case "Resume":
            with (oPauser)
                Unpause = true;
            
            with (oPersistentPauser)
                Unpause = true;
            
            instance_destroy();
            break;
        
        case "Review Animatronics":
            CurrentDesc = "";
            CurrentOptions = [];
            DescriptionList = [];
            var ActiveArray = [];
            
            if (in_salvage_location())
            {
                ActiveArray = global.SalvagesCurrent;
            }
            else if (numbered_night())
            {
                ActiveArray = global.AllTimeSalvages;
            }
            else
            {
                for (var i = 0; i < array_length(global.AILevels); i++)
                {
                    if (global.AILevels[i] > 0)
                        array_push(ActiveArray, i);
                }
            }
            
            if (boss_fight_night() && global.Route == UnknownEnum.Value_2 && global.BossPhase > 0)
            {
                for (var i = 0; i < global.BossPhase; i++)
                {
                    array_push(CurrentOptions, global.Descriptions[UnknownEnum.Value_50 + i][0]);
                    array_push(DescriptionList, global.Descriptions[UnknownEnum.Value_50 + i][1]);
                }
            }
            
            if (boss_fight_night() && global.Route == UnknownEnum.Value_3 && global.BossPhase > 0)
            {
                array_push(CurrentOptions, "Salvage");
                array_push(DescriptionList, "PHASE 1: Moves from camera to camera, trying to get into your office. Use your flashlight or slam the door on him to deal damage.");
                
                if (global.BossPhase >= 2)
                    DescriptionList[array_length(DescriptionList) - 1] += "\nPHASE 2: Will try to siphon your power from one of four cameras, draining your power and restoring his HP. Use a controlled shock to stop him once the lights go out.";
                
                if (global.BossPhase >= 3)
                    DescriptionList[array_length(DescriptionList) - 1] += "\nPHASE 3: His tendrils will slip into the vents, indicated by a squeaking sound. Click on them in the vent system to stop them before they reach your office.";
                
                if (global.BossPhase >= 4)
                    DescriptionList[array_length(DescriptionList) - 1] += "\nPHASE 4: Wires will descend into your office. Drag them down and release them to get rid of them.";
            }
            
            for (var i = 0; i < array_length(ActiveArray); i++)
            {
                array_push(CurrentOptions, global.Descriptions[ActiveArray[i]][0]);
                array_push(DescriptionList, global.Descriptions[ActiveArray[i]][1]);
            }
            
            CurrentOptions[array_length(CurrentOptions)] = "Back";
            break;
        
        case "Review Upgrades":
            CurrentDesc = "";
            CurrentOptions = [];
            DescriptionList = [];
            var Upgrades = get_upgrades();
            
            for (var i = 0; i < array_length(global.Upgrades); i++)
            {
                CurrentOptions[i] = Upgrades[global.Upgrades[i]].Name;
                DescriptionList[i] = Upgrades[global.Upgrades[i]].Desc;
            }
            
            CurrentOptions[array_length(CurrentOptions)] = "Back";
            break;
    }
}

goto_menu("Title", 0);

enum UnknownEnum
{
    Value_2 = 2,
    Value_3,
    Value_50 = 50,
    Value_56 = 56,
    Value_68 = 68
}
