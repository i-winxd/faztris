var MenuOffset = -224 * (1 - TileSize);
var GameWindowOffset = 400 * (1 - TileSize);
draw_set_font(global.FontW97Black);
draw_set_halign(fa_left);
draw_sprite_stretched(sTextBox_Windows, 0, MenuOffset, 0, 220, 360);
draw_sprite_stretched(sTextBox_Windows, 1, MenuOffset + 28, 4, 188, 22);
draw_text(MenuOffset + 33, 5, "Minigames");
draw_sprite_stretched(sTextBox_Windows, 0, GameWindowOffset + 262, 28, 336, 304);
draw_sprite_stretched(sTextBox_Windows, 2, GameWindowOffset + 268, 34, 324, 292);

if (surface_exists(global.MinigameSurface))
    draw_surface_ext(global.MinigameSurface, GameWindowOffset + 270, 36, 2, 2, 0, c_white, 1);
else
    draw_sprite_ext(sEmilySoftScreen, 0, GameWindowOffset + 270, 36, 2, 2, 0, c_white, 1);

draw_sprite_stretched(sTextBox_Windows, 2, MenuOffset + 4, 28, 212, 158);

for (var i = 0; i < 11; i++)
{
    var YPos = (i * 14) + 30;
    
    if (clicked(MenuOffset + 6, YPos, 208, 14) && global.UnlockedMinigames[i] && TileSize > 0.5 && i != Selected && Active)
    {
        Selected = i;
        instance_destroy(oMinigameParent);
        instance_create_depth(-320, -320, 0, MinigameArray[i]);
        audio_play_sound(sfxCamSwitch, 10, false);
    }
    
    draw_set_font(global.FontW97White);
    var BGColor = 16777215;
    var TextColor = 0;
    
    if (i == Selected)
    {
        BGColor = 0;
        TextColor = 16777215;
    }
    
    draw_rectangle_color(MenuOffset + 6, YPos, MenuOffset + 213, YPos + 14, BGColor, BGColor, BGColor, BGColor, false);
    var Text = MinigameNames[i];
    
    if (!global.UnlockedMinigames[i])
    {
        Text = "-- LOCKED --";
        TextColor = 12632256;
    }
    
    draw_text_color(MenuOffset + 9, -3 + YPos, Text, TextColor, TextColor, TextColor, TextColor, 1);
    draw_set_font(global.FontW97Black);
}

var DescriptionText = "Select a game from the menu above!";
var YourScore = "-";

if (instance_exists(oMinigame_FreddyFazsweep))
{
    DescriptionText = "Clear out all the blank tiles, but watch out for Freddles! The numbers on each tile will let you know how many Freddles are in the tiles adjacent to it. Left click to clear a tile and right click to mark it.";
    YourScore = format_as_timer(global.HiScores[UnknownEnum.Value_0]);
}

if (instance_exists(oMinigame_AirAdventure))
{
    DescriptionText = "Help BB navigate through the clouds! Left click to rise and space to pause. Passing ten clouds in a row will increase your multiplier!";
    YourScore = global.HiScores[UnknownEnum.Value_1];
}

if (instance_exists(oMinigame_ChicasFeedingFrenzy))
{
    DescriptionText = "Hold the left mouse button to eat the pizzas coming your way, but watch out for bombs! Rack up combos to earn tokens! Press space to pause / unpause.";
    YourScore = global.HiScores[UnknownEnum.Value_2];
}

if (instance_exists(oMinigame_PuppetPatrol))
{
    DescriptionText = "Help the Marionette find its assigned child! Click on the kid it requests to earn a point. If you spot a crying child, you can click on it for bonus points! Hold right click to turn on your flashlight, but be sure not to run out of battery.";
    YourScore = global.HiScores[UnknownEnum.Value_3];
}

if (instance_exists(oMinigame_HarePairs))
{
    DescriptionText = "Clear out the deck by matching pairs of cards adjacent to one another! Left click to select a card and then left click a matching card next to it vertically, horizontally, or diagonally. If you clear out the entire board, you win!";
    YourScore = global.HiScores[UnknownEnum.Value_4];
}

if (instance_exists(oMinigame_PiratePlunder))
{
    DescriptionText = "Plunder Seagoon's treasure and get back to your pirate ship! If you get grabbed by Seagoon's tentacles, it's game over. Use the left and right mouse buttons to move. Hold the right mouse button while at the treasure chest to collect treasure.";
    YourScore = global.HiScores[UnknownEnum.Value_5];
}

if (instance_exists(oMinigame_CircusSorter))
{
    DescriptionText = "Drag the Bidybabs to Baby and the Minireenas to Ballora! Left click to pick up either. Taking too long to sort a bot or sorting one to the wrong side will result in a jumpscare.";
    YourScore = global.HiScores[UnknownEnum.Value_6];
}

if (instance_exists(oMinigame_GoldenFazsweep))
{
    DescriptionText = "A harder version of Fredsweeper, with four times the tiles! Beat this game to earn a huge token bonus!";
    YourScore = format_as_timer(global.HiScores[UnknownEnum.Value_7]);
}

if (instance_exists(oMinigame_MangleTangleMania))
{
    DescriptionText = "Collect gears to put Mangle back together! The more you grab, the more tokens you'll earn. Watch out, though - if you run into yourself or a wall, it's game over! Left click to turn counter-clockwise and right click to turn clockwise.";
    YourScore = global.HiScores[UnknownEnum.Value_8];
}

if (instance_exists(oMinigame_CupcakeClicker))
{
    DescriptionText = "Click the cupcake! Every 5 clicks grants 1 token. Be sure to not fill the meter!";
    YourScore = global.HiScores[UnknownEnum.Value_9];
}

if (instance_exists(oMinigame_ScottsSlots))
{
    DescriptionText = "Who doesn't love a good old-fashioned slot machine? Bet your tokens for the chance to win big! The more tokens you bet, the more lines you can score across. Each animatronic has a different token value!";
    YourScore = global.HiScores[UnknownEnum.Value_10];
}

if (instance_exists(oMinigame_Stacker))
{
    DescriptionText = "A familiar stacker. Stack blocks and clear lines to earn points. Clear larger lines to earn tokens. Use J and L to move, I to hard drop, K to soft drop, B to hold, and the arrow keys to rotate.";
    YourScore = global.HiScores[11];
}

draw_sprite_stretched(sTextBox_Windows, 2, MenuOffset + 4, 188, 212, 168);
draw_text_ext(MenuOffset + 10, 190, DescriptionText, 14, 182);

if (Selected != -1)
    draw_text(MenuOffset + 10, 335, string("All-Time Hi-Score: {0}", array_contains([UnknownEnum.Value_0, UnknownEnum.Value_4, UnknownEnum.Value_7], Selected) ? format_as_timer(global.HiScoresOverall[Selected], true) : global.HiScoresOverall[Selected]));

draw_sprite_stretched(sButtonMini, 0, MenuOffset + 4, 4, 22, 22);
draw_sprite(sButtonMini_Icons, 0, MenuOffset + 4 + 11, 15);
var Quit = clicked(MenuOffset + 4, 4, 22, 22) || input_check_pressed(UnknownEnum.Value_1);

if (Active && Quit && TileSize > 0.5)
{
    audio_play_sound(sfxBump, 5, false);
    Active = false;
    oExtras.Active = true;
    instance_destroy(oMinigameParent);
    surface_free(global.MinigameSurface);
}

if (global.CupcakeMeter < 1)
    global.CupcakeMeter = max(global.CupcakeMeter - 0.002, 0);

TileSize += ((Active - TileSize) / 5);

if (TileSize < 0.01 && oExtras.Active)
    instance_destroy();

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
