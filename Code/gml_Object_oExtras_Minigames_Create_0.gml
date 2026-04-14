Selected = -1;
MinigameArray = [oMinigame_FreddyFazsweep, oMinigame_AirAdventure, oMinigame_ChicasFeedingFrenzy, oMinigame_PuppetPatrol, oMinigame_HarePairs, oMinigame_PiratePlunder, oMinigame_CircusSorter, oMinigame_GoldenFazsweep, oMinigame_MangleTangleMania, oMinigame_CupcakeClicker, oMinigame_ScottsSlots, oMinigame_Stacker];
MinigameNames = ["Fredsweeper", "Air Adventure", "Chomping With Chica", "Puppet Patrol", "Hare Pairs", "Pirate Plunder", "Circus Sorter", "Golden Fredsweeper", "Mangle Tangle Mania", "Cupcake Clicker", "Scott's Slots", "Stacker"];
global.MinigameWindowX = 270;
global.MinigameWindowY = 36;
global.MinigameWindowScale = 2;
global.HiScores[UnknownEnum.Value_0] = 360;
global.HiScores[UnknownEnum.Value_1] = 0;
global.HiScores[UnknownEnum.Value_2] = 0;
global.HiScores[UnknownEnum.Value_3] = 0;
global.HiScores[UnknownEnum.Value_4] = 360;
global.HiScores[UnknownEnum.Value_5] = 0;
global.HiScores[UnknownEnum.Value_6] = 0;
global.HiScores[UnknownEnum.Value_7] = 360;
global.HiScores[UnknownEnum.Value_8] = 0;
global.HiScores[UnknownEnum.Value_9] = 0;
global.HiScores[UnknownEnum.Value_10] = 0;
global.HiScores[11] = 0;
global.CupcakeMeter = 0;
TileSize = 0;
Active = true;

if (surface_exists(global.MinigameSurface))
    surface_free(global.MinigameSurface);

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_9,
    Value_10
}
