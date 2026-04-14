Frame = 0;
FuzzDegree = 1;
global.CamX = x + 240;
global.CamY = y + 32;
global.CamName[0] = "";
global.CamName[1] = "Showroom";

with (instance_create_depth(736, 120, -1, oCamButton))
    CamNumber = 1;

global.CamName[2] = "Dining Area";

with (instance_create_depth(736, 176, -1, oCamButton))
    CamNumber = 2;

global.CamName[3] = "Pirate's Cove";

with (instance_create_depth(656, 129, -1, oCamButton))
    CamNumber = 3;

global.CamName[4] = "Staff Hallway";

with (instance_create_depth(687, 265, -1, oCamButton))
    CamNumber = 4;

global.CamName[5] = "Restroom Hallway";

with (instance_create_depth(785, 265, -1, oCamButton))
    CamNumber = 5;

global.CamName[6] = "Entrance";

with (instance_create_depth(817, 153, -1, oCamButton))
    CamNumber = 6;

global.CamName[7] = "Arcade";

with (instance_create_depth(808, 72, -1, oCamButton))
    CamNumber = 7;

global.CamName[8] = "Parts & Service";

with (instance_create_depth(736, 65, -1, oCamButton))
    CamNumber = 8;

with (instance_create_depth(x + 4, y + 306, -1, oCamButtonSpecial))
{
    Text = "Cameras";
    image_xscale = 0.5043478260869565;
}

with (instance_create_depth(x + 62, y + 306, -1, oCamButtonSpecial))
{
    Text = "Vents";
    image_xscale = 0.5043478260869565;
}

with (instance_create_depth(x + 120, y + 306, -1, oCamButtonSpecial))
{
    Text = "Shop";
    image_xscale = 0.5043478260869565;
}

with (instance_create_depth(x + 178, y + 306, -1, oCamButtonSpecial))
{
    Text = "Games";
    image_xscale = 0.5043478260869565;
}

with (instance_create_depth(x + 245, y + 5, -1, oCamButtonSpecial))
    Text = "Reset Music";

with (instance_create_depth(x + 245, y + 5, -1, oCamButtonSpecial))
    Text = "Controlled Shock";

with (instance_create_depth(x + 264, y + 305, -1, oCamButtonSpecial))
    Text = "Heater (HOLD)";

var AnHour = (global.NightSpeedup == 1) ? "an hour" : string("{0} seconds", round(60 / global.NightSpeedup));

with (instance_create_depth(x + 6 + ((instance_number(oCamButtonShopItem) % 6) * 48), y + 50 + (floor(instance_number(oCamButtonShopItem) / 6) * 64), -1, oCamButtonShopItem))
{
    Text = "Mimic Ball";
    Description = "Gives you a duplicate of the last purchased item.";
    Price = 0;
    Stock = 1;
    MimicItem = "NONE";
}

with (instance_create_depth(x + 6 + ((instance_number(oCamButtonShopItem) % 6) * 48), y + 50 + (floor(instance_number(oCamButtonShopItem) / 6) * 64), -1, oCamButtonShopItem))
{
    Text = "King's Prize";
    Description = "Does...something.";
    Price = 5;
    Stock = 5;
}

with (instance_create_depth(x + 6 + ((instance_number(oCamButtonShopItem) % 6) * 48), y + 50 + (floor(instance_number(oCamButtonShopItem) / 6) * 64), -1, oCamButtonShopItem))
{
    Text = "Rewind Clock";
    Description = string("Winds the clock back {0}.", AnHour);
    Price = 5;
    Stock = 2;
}

with (instance_create_depth(x + 6 + ((instance_number(oCamButtonShopItem) % 6) * 48), y + 50 + (floor(instance_number(oCamButtonShopItem) / 6) * 64), -1, oCamButtonShopItem))
{
    Text = "Battery Pack";
    Description = "Restores 10% of your power.";
    Price = 10;
    Stock = 3;
}

with (instance_create_depth(x + 6 + ((instance_number(oCamButtonShopItem) % 6) * 48), y + 50 + (floor(instance_number(oCamButtonShopItem) / 6) * 64), -1, oCamButtonShopItem))
{
    Text = "Snowcone";
    Description = string("Keeps the office at its lowest possible temperature for {0}.", AnHour);
    Price = 10;
    Stock = 2;
}

with (instance_create_depth(x + 6 + ((instance_number(oCamButtonShopItem) % 6) * 48), y + 50 + (floor(instance_number(oCamButtonShopItem) / 6) * 64), -1, oCamButtonShopItem))
{
    Text = "Golden Cupcake";
    Description = "Increases in value over time. Click it to sell it back for tokens.";
    Price = 15;
    Stock = 2;
}

with (instance_create_depth(x + 6 + ((instance_number(oCamButtonShopItem) % 6) * 48), y + 50 + (floor(instance_number(oCamButtonShopItem) / 6) * 64), -1, oCamButtonShopItem))
{
    Text = "AR Mask";
    Description = string("Will make all animatronics behave as if you have the mask on for {0}.", AnHour);
    Price = 15;
    Stock = 2;
}

with (instance_create_depth(x + 6 + ((instance_number(oCamButtonShopItem) % 6) * 48), y + 50 + (floor(instance_number(oCamButtonShopItem) / 6) * 64), -1, oCamButtonShopItem))
{
    Text = "Laser Doors";
    Description = string("Blocks off both doors for {0}.", AnHour);
    Price = 20;
    Stock = 2;
}

with (instance_create_depth(x + 6 + ((instance_number(oCamButtonShopItem) % 6) * 48), y + 50 + (floor(instance_number(oCamButtonShopItem) / 6) * 64), -1, oCamButtonShopItem))
{
    Text = "Beartrap";
    Description = "Blocks and resets the next animatronic who tries to jumpscare you.";
    Price = 25;
    Stock = 1;
}

with (instance_create_depth(x + 6 + ((instance_number(oCamButtonShopItem) % 6) * 48), y + 50 + (floor(instance_number(oCamButtonShopItem) / 6) * 64), -1, oCamButtonShopItem))
{
    Text = "Deathcoin";
    Description = "Completely deactivate an animatronic of your choice for the rest of the night.";
    Price = 30;
    Stock = 1;
}

with (instance_create_depth(x + 6 + ((instance_number(oCamButtonShopItem) % 6) * 48), y + 50 + (floor(instance_number(oCamButtonShopItem) / 6) * 64), -1, oCamButtonShopItem))
{
    Text = "Distortion Clock";
    Description = string("Skip {0} of the night.", AnHour);
    Price = 35;
    Stock = 2;
}

with (instance_create_depth(x + 6 + ((instance_number(oCamButtonShopItem) % 6) * 48), y + 50 + (floor(instance_number(oCamButtonShopItem) / 6) * 64), -1, oCamButtonShopItem))
{
    Text = "Pickles";
    Description = "Happiness +1.";
    Price = 300;
    Stock = 1;
}

with (oCamButtonShopItem)
{
    if (Text == "Distortion Clock" && array_contains(["The LolzHax Shuffle"], global.ChallengeTitle))
        instance_destroy();
    
    if (Text == "Rewind Clock" && array_contains(["Minute 2 Win It"], global.ChallengeTitle))
        instance_destroy();
}

if (numbered_night())
{
    for (var m = 0; m < array_length(global.SalvagedMinigames); m++)
    {
        if (global.UnlockedMinigames[UnknownEnum.Value_2 + m])
            global.SalvagedMinigames[m] = true;
    }
}

with (instance_create_depth(x + 6, y + 50 + (instance_number(oCamButtonMinigame) * 13), -1, oCamButtonMinigame))
{
    MinigameID = oMinigame_FreddyFazsweep;
    Text = "Fredsweeper";
}

with (instance_create_depth(x + 6, y + 50 + (instance_number(oCamButtonMinigame) * 13), -1, oCamButtonMinigame))
{
    MinigameID = oMinigame_AirAdventure;
    Text = "Air Adventure";
}

with (instance_create_depth(x + 6, y + 50 + (instance_number(oCamButtonMinigame) * 13), -1, oCamButtonMinigame))
{
    MinigameID = oMinigame_Stacker;
    Text = "Faztris";
}

var GFredsweepUnlocked = global.UnlockedMinigames[UnknownEnum.Value_7];
var MinigameUnlocks = array_concat([1, 1], global.SalvagedMinigames, [GFredsweepUnlocked, array_contains(global.Upgrades, UnknownEnum.Value_27), array_contains(global.Upgrades, UnknownEnum.Value_28), array_contains(global.Upgrades, UnknownEnum.Value_29)]);

if (global.Night == "Custom")
    MinigameUnlocks = global.UnlockedMinigames;

if (array_contains(global.Upgrades, UnknownEnum.Value_27))
    global.UnlockedMinigames[UnknownEnum.Value_8] = true;

if (array_contains(global.Upgrades, UnknownEnum.Value_28))
    global.UnlockedMinigames[UnknownEnum.Value_9] = true;

if (array_contains(global.Upgrades, UnknownEnum.Value_29))
    global.UnlockedMinigames[UnknownEnum.Value_10] = true;

if (MinigameUnlocks[UnknownEnum.Value_2])
{
    with (instance_create_depth(x + 6, y + 50 + (instance_number(oCamButtonMinigame) * 13), -1, oCamButtonMinigame))
    {
        MinigameID = oMinigame_ChicasFeedingFrenzy;
        Text = "Chomping With Chica";
    }
}

if (MinigameUnlocks[UnknownEnum.Value_3])
{
    with (instance_create_depth(x + 6, y + 50 + (instance_number(oCamButtonMinigame) * 13), -1, oCamButtonMinigame))
    {
        MinigameID = oMinigame_PuppetPatrol;
        Text = "Puppet Patrol";
    }
}

if (MinigameUnlocks[UnknownEnum.Value_4])
{
    with (instance_create_depth(x + 6, y + 50 + (instance_number(oCamButtonMinigame) * 13), -1, oCamButtonMinigame))
    {
        MinigameID = oMinigame_HarePairs;
        Text = "Hare Pairs";
    }
}

if (MinigameUnlocks[UnknownEnum.Value_5])
{
    with (instance_create_depth(x + 6, y + 50 + (instance_number(oCamButtonMinigame) * 13), -1, oCamButtonMinigame))
    {
        MinigameID = oMinigame_PiratePlunder;
        Text = "Pirate Plunder";
    }
}

if (MinigameUnlocks[UnknownEnum.Value_6])
{
    with (instance_create_depth(x + 6, y + 50 + (instance_number(oCamButtonMinigame) * 13), -1, oCamButtonMinigame))
    {
        MinigameID = oMinigame_CircusSorter;
        Text = "Circus Sorter";
    }
}

if (MinigameUnlocks[UnknownEnum.Value_7])
{
    with (instance_create_depth(x + 6, y + 50 + (instance_number(oCamButtonMinigame) * 13), -1, oCamButtonMinigame))
    {
        MinigameID = oMinigame_GoldenFazsweep;
        Text = "Golden Fredsweeper";
    }
}

if (MinigameUnlocks[UnknownEnum.Value_8])
{
    with (instance_create_depth(x + 6, y + 50 + (instance_number(oCamButtonMinigame) * 13), -1, oCamButtonMinigame))
    {
        MinigameID = oMinigame_MangleTangleMania;
        Text = "Mangle Tangle Mania";
    }
}

if (MinigameUnlocks[UnknownEnum.Value_9])
{
    with (instance_create_depth(x + 6, y + 50 + (instance_number(oCamButtonMinigame) * 13), -1, oCamButtonMinigame))
    {
        MinigameID = oMinigame_CupcakeClicker;
        Text = "Cupcake Clicker";
    }
}

if (MinigameUnlocks[UnknownEnum.Value_10])
{
    with (instance_create_depth(x + 6, y + 50 + (instance_number(oCamButtonMinigame) * 13), -1, oCamButtonMinigame))
    {
        MinigameID = oMinigame_ScottsSlots;
        Text = "Scott's Slots";
    }
}

global.AudioLureX = -99;
global.AudioLureY = 99;

for (var Y = -1; Y <= 1; Y += 1)
{
    for (var X = -2; X <= 2; X += 1)
    {
        var ButtonX = x + 320 + (X * 80);
        var ButtonY = y + 164 + (Y * 80);
        
        with (instance_create_depth(ButtonX, ButtonY, -1, oVentButton))
            ButtonID = [X, Y];
    }
}

global.MinigameWindowX = 313;
global.MinigameWindowY = 37;
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
ShopkeepFrame = 0;
ShopkeepAnim = 0;
instance_create_depth(x, y, 100, oCamBackground);

if (array_contains(global.Upgrades, UnknownEnum.Value_19))
{
    with (oCamButtonShopItem)
        Stock += 2;
}
else if (array_contains(global.Upgrades, UnknownEnum.Value_18))
{
    with (oCamButtonShopItem)
        Stock += 1;
}

ZapAlpha = 0;

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
    Value_10,
    Value_18 = 18,
    Value_19,
    Value_27 = 27,
    Value_28,
    Value_29
}
