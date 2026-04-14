shader_set(TransparencyShader);
draw_set_font(global.FontW97Black);
draw_set_halign(fa_left);
var CamFlashAlpha = global.Brightness;

if (global.ColorMode == 0 && global.Brightness < 0.99)
    CamFlashAlpha *= 0.5;

var FlashlightX = clamp(oMouseHitbox.x, global.CamX, global.CamX + 400);
var FlashlightY = clamp(oMouseHitbox.y, global.CamY, global.CamY + 300);
draw_sprite_ext(sFlashlight, global.Flashlight, FlashlightX, FlashlightY, oCamera.FlashlightPower, oCamera.FlashlightPower, 0, -1, CamFlashAlpha);
draw_set_alpha(FuzzDegree);
draw_sprite(sStatic, Frame, global.CamX, global.CamY);
draw_sprite_ext(sStatic, 0, global.CamX, global.CamY, 1, 1, 0, c_black, ZapAlpha);
draw_set_alpha(1);

switch (global.MonitorSystem)
{
    case "Cameras":
        image_index = 0;
        break;
    
    case "Vents":
        image_index = 1;
        break;
    
    case "Shop":
        image_index = 2;
        break;
    
    case "Games":
        image_index = 3;
        
        if (surface_exists(global.MinigameSurface))
        {
            draw_rectangle(x + 312, y + 36, 400, 400, false);
            draw_surface_ext(global.MinigameSurface, x + 313, y + 37, 2, 2, 0, c_white, 1);
        }
        
        break;
}

draw_self();

switch (global.MonitorSystem)
{
    case "Cameras":
        draw_text(x + 92, y + 25, global.CamName[global.Cam]);
        break;
    
    case "Vents":
        draw_text(x + 92, y + 25, global.CamName[global.Cam]);
        break;
    
    case "Shop":
        draw_text(x + 92, y + 25, "Spend your tokens for items here.");
        break;
    
    case "Games":
        draw_text(x + 92, y + 25, "Play minigames to earn tokens.");
        break;
}

if (global.MonitorSystem == "Shop")
{
    if (kill_mendo())
    {
        draw_sprite(sMendoOffline, floor(ShopkeepFrame / 30) % 2, x + 301, y + 28);
    }
    else if (instance_exists(oLolbit) && global.AILevels[UnknownEnum.Value_25] > 0)
    {
        if (ShopkeepAnim == 1 && ShopkeepFrame == 0)
            audio_play_sound(choose(voc_Lolbit_Giggle, voc_Lolbit_Giggle2, voc_Lolbit_Giggle3, voc_Lolbit_ItsYours, voc_Lolbit_Lmao, voc_Lolbit_ThanksForBuyin), 10, false);
        
        if (ShopkeepAnim == 1 && ShopkeepFrame >= 15)
        {
            ShopkeepAnim = 2;
            ShopkeepFrame = 0;
        }
        
        if (ShopkeepAnim == 2 && ShopkeepFrame >= 60)
        {
            ShopkeepAnim = 3;
            ShopkeepFrame = 0;
        }
        
        if (ShopkeepAnim == 3 && ShopkeepFrame >= 15)
        {
            ShopkeepAnim = 0;
            ShopkeepFrame = 0;
        }
        
        var LolbitFrame = floor(ShopkeepFrame / 5) % 3;
        draw_sprite(sLolbitShop, LolbitFrame + (ShopkeepAnim * 3), x + 301, y + 28);
    }
}

if (global.MonitorSystem == "Games")
{
    var DescriptionText = "Select a game from the menu above!";
    var YourScore = "-";
    var EnemyScore = "-";
    var ToyFreddyExists = instance_exists(oToyFreddy) && global.AILevels[UnknownEnum.Value_6] > 0;
    
    if (ToyFreddyExists)
    {
        if (!oToyFreddy.Active)
            ToyFreddyExists = false;
    }
    
    if (instance_exists(oMinigame_FreddyFazsweep))
    {
        DescriptionText = "Clear out all the blank tiles, but watch out for Freddles! The numbers on each tile will let you know how many Freddles are in the tiles adjacent to it. Left click to clear a tile and right click to mark it.";
        YourScore = format_as_timer(global.HiScores[UnknownEnum.Value_0]);
        
        if (ToyFreddyExists)
            EnemyScore = format_as_timer(oToyFreddy.TFScores[UnknownEnum.Value_0]);
    }
    
    if (instance_exists(oMinigame_AirAdventure))
    {
        DescriptionText = "Help BB navigate through the clouds! Left click to rise and space to pause. Passing ten clouds in a row will increase your multiplier!";
        YourScore = global.HiScores[UnknownEnum.Value_1];
        
        if (ToyFreddyExists)
            EnemyScore = oToyFreddy.TFScores[UnknownEnum.Value_1];
    }
    
    if (instance_exists(oMinigame_ChicasFeedingFrenzy))
    {
        DescriptionText = "Hold the left mouse button to eat the pizzas coming your way, but watch out for bombs! Rack up combos to earn tokens! Press space to pause / unpause.";
        YourScore = global.HiScores[UnknownEnum.Value_2];
        
        if (ToyFreddyExists)
            EnemyScore = oToyFreddy.TFScores[UnknownEnum.Value_2];
    }
    
    if (instance_exists(oMinigame_PuppetPatrol))
    {
        DescriptionText = "Help the Marionette find its assigned child! Click on the kid it requests to earn a point. If you spot a crying child, you can click on it for bonus points! Hold right click to turn on your flashlight, but be sure not to run out of battery.";
        YourScore = global.HiScores[UnknownEnum.Value_3];
        
        if (ToyFreddyExists)
            EnemyScore = oToyFreddy.TFScores[UnknownEnum.Value_3];
    }
    
    if (instance_exists(oMinigame_HarePairs))
    {
        DescriptionText = "Clear out the deck by matching pairs of cards adjacent to one another! Left click to select a card and then left click a matching card next to it vertically, horizontally, or diagonally. If you clear out the entire board, you win!";
        YourScore = global.HiScores[UnknownEnum.Value_4];
        
        if (ToyFreddyExists)
            EnemyScore = oToyFreddy.TFScores[UnknownEnum.Value_4];
    }
    
    if (instance_exists(oMinigame_PiratePlunder))
    {
        DescriptionText = "Plunder Seagoon's treasure and get back to your pirate ship! If you get grabbed by Seagoon's tentacles, it's game over. Use the left and right mouse buttons to move. Hold the right mouse button while at the treasure chest to collect treasure.";
        YourScore = global.HiScores[UnknownEnum.Value_5];
        
        if (ToyFreddyExists)
            EnemyScore = oToyFreddy.TFScores[UnknownEnum.Value_5];
    }
    
    if (instance_exists(oMinigame_CircusSorter))
    {
        DescriptionText = "Drag the Bidybabs to Baby and the Minireenas to Ballora! Left click to pick up either. Taking too long to sort a bot or sorting one to the wrong side will result in a jumpscare.";
        YourScore = global.HiScores[UnknownEnum.Value_6];
        
        if (ToyFreddyExists)
            EnemyScore = oToyFreddy.TFScores[UnknownEnum.Value_6];
    }
    
    if (instance_exists(oMinigame_GoldenFazsweep))
    {
        DescriptionText = "A harder version of Fredsweeper, with four times the tiles! Beat this game to earn a huge token bonus!";
        YourScore = format_as_timer(global.HiScores[UnknownEnum.Value_7]);
        
        if (ToyFreddyExists)
            EnemyScore = format_as_timer(oToyFreddy.TFScores[UnknownEnum.Value_7]);
    }
    
    if (instance_exists(oMinigame_MangleTangleMania))
    {
        DescriptionText = "Collect gears to put Mangle back together! The more you grab, the more tokens you'll earn. Watch out, though - if you run into yourself or a wall, it's game over! Left click to turn counter-clockwise and right click to turn clockwise.";
        YourScore = global.HiScores[UnknownEnum.Value_8];
        
        if (ToyFreddyExists)
            EnemyScore = oToyFreddy.TFScores[UnknownEnum.Value_8];
    }
    
    if (instance_exists(oMinigame_CupcakeClicker))
    {
        DescriptionText = "Click the cupcake! Every 5 clicks grants 1 token. Be sure to not fill the meter!";
        YourScore = global.HiScores[UnknownEnum.Value_9];
        
        if (ToyFreddyExists)
            EnemyScore = oToyFreddy.TFScores[UnknownEnum.Value_9];
    }
    
    if (instance_exists(oMinigame_ScottsSlots))
    {
        DescriptionText = "Who doesn't love a good old-fashioned slot machine? Bet your tokens for the chance to win big! The more tokens you bet, the more lines you can score across. Each animatronic has a different token value!";
        YourScore = global.HiScores[UnknownEnum.Value_10];
        
        if (ToyFreddyExists)
            EnemyScore = oToyFreddy.TFScores[UnknownEnum.Value_10];
    }
    
    if (instance_exists(oMinigame_Stacker))
    {
        DescriptionText = "A familiar stacker. Stack blocks and clear lines to earn points. Clear larger lines to earn tokens. Use J and L to move, I to hard drop, K to soft drop, B to hold, and the arrow keys to rotate.";
        YourScore = global.HiScores[11];
        
        if (ToyFreddyExists)
            EnemyScore = oToyFreddy.TFScores[11];
    }
    
    draw_text_ext(9 + x, 198 + y, DescriptionText, 14, 294);
    draw_text(9 + x, 283 + y, "HIGH SCORE: " + string(YourScore));
    
    if (EnemyScore != "-")
        EnemyScore = "SCORE TO BEAT: " + string(EnemyScore);
    
    draw_text(161 + x, 283 + y, EnemyScore);
    
    if (!instance_exists(oMinigameParent))
        draw_sprite_ext(sEmilySoftScreen, 0, x + 313, y + 37, 2, 2, 0, c_white, 1);
}

Frame += 0.25;
ShopkeepFrame += 1;
FuzzDegree = max(FuzzDegree - 0.05, 0.15);
shader_reset();

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
    Value_25 = 25
}
