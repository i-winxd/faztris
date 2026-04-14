global.CurrentVersion = "2-13-25";

function apply_settings(arg0 = false)
{
    if (arg0)
    {
        window_set_size(640 * (global.Settings[1][0] + 1), 360 * (global.Settings[1][0] + 1));
        window_set_fullscreen(global.Settings[1][1]);
    }
    
    set_audio_volumes();
    
    if (global.Settings[3][0])
        display_mouse_lock_auto();
    else
        display_mouse_unlock();
}

function default_settings()
{
    /*
        THE LAST 8 ARE FAZTRIS CONTROLS, being: CCW, CW, 180, H, HD, SD, ML, MR
    */

    global.Settings[0] = [32, 27, 87, 65, 83, 68, 83, 87, 65, 68, 90, 88, 49, 50, 51, 52, 53, 54, 55, 56, 81, 87, 69, 82, 32, 16, vk_left, vk_right, vk_up, ord("B"), ord("I"), ord("K"), ord("J"), ord("L")];
    global.Settings[1] = [0, 0];
    global.Settings[2] = [10, 10, 10, 10, 0, 0, 0];
    global.Settings[3] = [0, 4, 1, 0, 2, 10, 1, 26];
}

function initialize_save_data()
{
    global.Night = 1;
    global.Difficulty = 1;
    global.StartRoom = NightOpening;
    global.AllTimeSalvages = [UnknownEnum.Value_0, UnknownEnum.Value_1, UnknownEnum.Value_2, UnknownEnum.Value_3, UnknownEnum.Value_16];
    global.RunEarnings = 0;
    global.RunEarningsTotal = 0;
    global.Upgrades = [];
    global.SalvagedMinigames = [false, false, false, false, false];
    global.SalvagedMasks = [false, false, false, false];
    global.SalvagedScraps = [false, false, false, false];
    global.CanContinue = false;
    global.Deaths = [0, 0, 0, 0, 0, 0];
    global.Route = UnknownEnum.Value_0;
    global.RunTime = 0;
    global.UnlockedAnimatronics = array_create(70, false);
    global.UnlockedTrophies = array_create(48, false);
    global.UnlockedMinigames = [true, true, false, false, false, false, false, false, false, false, false, false];
    global.DeathRecord = array_create(70, 0);
    global.ClearedChallenges = array_create(30, false);
    global.Playtime = 0;
    global.UnlockFlags = [];
    global.ClearedEndings = array_create(4, array_create(5, 0));
    global.ExtrasNotifs = 
    {
        AnimatronicsNotifs: array_create(80, bool(true)),
        ConceptArtNotifs: array_create(100, bool(true)),
        TrophyNotifs: array_create(80, bool(true))
    };
    global.SalvageRecord = array_create(47, 0);
    global.UpgradeRecord = array_create(51, 0);
    global.TokensPerMinigame = array_create(15, 0);
    global.RunSpeedBest = 999999;
    global.RunEarningsBest = 0;
    global.HiScoresOverall = array_create(11, 0);
    global.BossHiScores = array_create(3, array_create(5, 0));
    global.HiScoresOverall[UnknownEnum.Value_0] = 360;
    global.HiScoresOverall[UnknownEnum.Value_4] = 360;
    global.HiScoresOverall[UnknownEnum.Value_7] = 360;
    global.TipNum = 0;
    global.GameFirstOpened = get_current_date();
    var PossiblePrimes = [179, 283, 421, 547, 673, 811];
    global.FunValue[0] = irandom(99);
    global.FunValue[1] = PossiblePrimes[irandom(5)];
    global.Skins = array_create(70, -1);
    default_settings();
}

initialize_save_data();

function create_save()
{
    var SaveStuff = 
    {
        _Night: global.Night,
        _StartRoom: global.StartRoom,
        _Difficulty: global.Difficulty,
        _Guard: global.Guard,
        _Salvages: global.AllTimeSalvages,
        _Masks: global.SalvagedMasks,
        _Scraps: global.SalvagedScraps,
        _Minigames: global.SalvagedMinigames,
        _Paycheck: global.RunEarnings,
        _PaycheckTotal: global.RunEarningsTotal,
        _CanContinue: global.CanContinue,
        _Upgrades: global.Upgrades,
        _Deaths: global.Deaths,
        _Route: global.Route,
        _RunTime: global.RunTime
    };
    var _string = json_stringify(SaveStuff);
    var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
    buffer_write(_buffer, buffer_string, _string);
    buffer_save(_buffer, "savedata" + global.CurrentVersion + ".wario");
    buffer_delete(_buffer);
    show_debug_message("GAME SAVED! " + _string);
}

function save_permanent_data()
{
    var SaveStuff = 
    {
        _UnlockedAnimatronics: global.UnlockedAnimatronics,
        _UnlockedTrophies: global.UnlockedTrophies,
        _UnlockedMinigames: global.UnlockedMinigames,
        _DeathRecord: global.DeathRecord,
        _ClearedChallenges: global.ClearedChallenges,
        _Playtime: global.Playtime,
        _UnlockFlags: global.UnlockFlags,
        _ClearedEndings: global.ClearedEndings,
        _SalvageRecord: global.SalvageRecord,
        _UpgradeRecord: global.UpgradeRecord,
        _TokensPerMinigame: global.TokensPerMinigame,
        _RunSpeedBest: global.RunSpeedBest,
        _RunEarningsBest: global.RunEarningsBest,
        _HiScoresOverall: global.HiScoresOverall,
        _GameFirstOpened: global.GameFirstOpened,
        _TipNum: global.TipNum,
        _BossHiScores: global.BossHiScores,
        _ExtrasNotifs: global.ExtrasNotifs,
        _Settings: global.Settings,
        _FunValue: global.FunValue
    };
    var _string = json_stringify(SaveStuff);
    var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
    buffer_write(_buffer, buffer_string, _string);
    buffer_save(_buffer, "records" + global.CurrentVersion + ".wario");
    buffer_delete(_buffer);
    show_debug_message("GAME SAVED! " + _string);
}

function load_save()
{
    try
    {
        if (file_exists("savedata" + global.CurrentVersion + ".wario"))
        {
            var _buffer = buffer_load("savedata" + global.CurrentVersion + ".wario");
            var _string = buffer_read(_buffer, buffer_string);
            buffer_delete(_buffer);
            var _LoadData = json_parse(_string);
            global.Night = _LoadData._Night;
            global.StartRoom = _LoadData._StartRoom;
            global.Difficulty = _LoadData._Difficulty;
            global.Guard = _LoadData._Guard;
            global.AllTimeSalvages = _LoadData._Salvages;
            global.SalvagedMasks = _LoadData._Masks;
            global.SalvagedScraps = _LoadData._Scraps;
            global.SalvagedMinigames = _LoadData._Minigames;
            global.RunEarnings = _LoadData._Paycheck;
            global.RunEarningsTotal = _LoadData._PaycheckTotal;
            global.CanContinue = _LoadData._CanContinue;
            global.Upgrades = _LoadData._Upgrades;
            global.Deaths = _LoadData._Deaths;
            global.Route = _LoadData._Route;
            global.RunTime = _LoadData._RunTime;
            show_debug_message("GAME LOADED! " + _string);
        }
        else
        {
            create_save();
        }
    }
    catch (_exception)
    {
        show_message("ERR: Your run data appears to be corrupted. You may need to start a new save file.");
    }
}

function load_permanent_data()
{
    try
    {
        if (file_exists("records" + global.CurrentVersion + ".wario"))
        {
            var _buffer = buffer_load("records" + global.CurrentVersion + ".wario");
            var _string = buffer_read(_buffer, buffer_string);
            buffer_delete(_buffer);
            var _LoadData = json_parse(_string);
            
            if (array_length(_LoadData._Settings[3]) < array_length(global.Settings[3]))
                _LoadData._Settings[3] = global.Settings[3];
            
            if (array_length(_LoadData._ExtrasNotifs.ConceptArtNotifs) < array_length(global.ExtrasNotifs.ConceptArtNotifs))
                _LoadData._ExtrasNotifs.ConceptArtNotifs = global.ExtrasNotifs.ConceptArtNotifs;
            
            global.UnlockedAnimatronics = _LoadData._UnlockedAnimatronics;
            global.UnlockedTrophies = _LoadData._UnlockedTrophies;
            global.UnlockedMinigames = _LoadData._UnlockedMinigames;
            global.DeathRecord = _LoadData._DeathRecord;
            global.ClearedChallenges = _LoadData._ClearedChallenges;
            global.Settings = _LoadData._Settings;
            global.FunValue = _LoadData._FunValue;
            global.Playtime = _LoadData._Playtime;
            global.UnlockFlags = _LoadData._UnlockFlags;
            global.ClearedEndings = _LoadData._ClearedEndings;
            global.SalvageRecord = _LoadData._SalvageRecord;
            global.UpgradeRecord = _LoadData._UpgradeRecord;
            global.TokensPerMinigame = _LoadData._TokensPerMinigame;
            global.RunSpeedBest = _LoadData._RunSpeedBest;
            global.RunEarningsBest = _LoadData._RunEarningsBest;
            global.HiScoresOverall = _LoadData._HiScoresOverall;
            global.GameFirstOpened = _LoadData._GameFirstOpened;
            global.TipNum = _LoadData._TipNum;
            
            if (variable_struct_exists(_LoadData, "_BossHiScores"))
                global.BossHiScores = _LoadData._BossHiScores;
            
            if (variable_struct_exists(_LoadData, "_ExtrasNotifs"))
                global.ExtrasNotifs = _LoadData._ExtrasNotifs;
            
            show_debug_message("GAME LOADED! " + _string);
        }
        else
        {
            save_permanent_data();
        }
    }
    catch (_exception)
    {
        show_message("ERR: Your save data appears to be corrupted. You may need to reset your data.");
    }
}

load_save();
load_permanent_data();
apply_settings();
window_set_cursor(cr_default);
global.CurrentChallenge = undefined;
global.Cheats = array_create(10, false);
global.CallMuted = false;
global.BossPhase = 0;
global.SalvagesCurrent = [];
global.SavedTime = 0;
global.SavedBossTime = 0;
global.ThisBossHiScore = 0;

if (!directory_exists("addons"))
    directory_create("addons");

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_7 = 7,
    Value_16 = 16
}
