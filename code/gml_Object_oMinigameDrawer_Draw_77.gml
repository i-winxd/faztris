set_target_to_ui();
var AlreadyCleared = global.SalvagedMinigames[global.Night - 1];

if (surface_exists(global.MinigameSurface))
{
    draw_sprite(sMinigameBorder2, 0, 0, YOffset);
    var DescriptionText = "Select a game from the menu above!";
    var YourScore = 0;
    var EnemyScore = [99, 99];
    
    if (instance_exists(oMinigame_ChicasFeedingFrenzy))
    {
        DescriptionText = "Hold the left mouse button to eat the pizzas coming your way, but watch out for bombs! Rack up combos to earn tokens! Press space to pause / unpause.";
        YourScore = global.HiScores[UnknownEnum.Value_2];
        EnemyScore = [50, 100];
    }
    
    if (instance_exists(oMinigame_MangleTangleMania))
    {
        DescriptionText = "Collect gears to put Mangle back together! The more you grab, the more tokens you'll earn. Watch out, though - if you run into yourself or a wall, it's game over! Left click to turn counter-clockwise and right click to turn clockwise.";
        YourScore = global.HiScores[UnknownEnum.Value_8];
        EnemyScore = [15, 30];
    }
    
    if (instance_exists(oMinigame_FreddyFazsweep))
    {
        DescriptionText = "Clear out all the blank tiles, but watch out for Freddles! The numbers on each tile will let you know how many Freddles are in the tiles adjacent to it. Left click to clear a tile and right click to mark it.";
        YourScore = global.HiScores[UnknownEnum.Value_0];
        EnemyScore = [360, 30];
    }
    
    if (instance_exists(oMinigame_PuppetPatrol))
    {
        DescriptionText = "Help the Marionette find its assigned child! Click on the kid it requests to earn a point. If you spot a crying child, you can click on it for bonus points! Hold right click to turn on your flashlight, but be sure not to run out of battery.";
        YourScore = global.HiScores[UnknownEnum.Value_3];
        EnemyScore = [20, 40];
    }
    
    if (instance_exists(oMinigame_HarePairs))
    {
        DescriptionText = "Clear out the deck by matching pairs of cards adjacent to one another! Left click to select a card and then left click a matching card next to it vertically, horizontally, or diagonally. If you clear out the entire board, you win!";
        YourScore = global.HiScores[UnknownEnum.Value_4];
        EnemyScore = [180, 40];
    }
    
    if (instance_exists(oMinigame_PiratePlunder))
    {
        DescriptionText = "Plunder Seagoon's treasure and get back to your pirate ship! If you get grabbed by Seagoon's tentacles, it's game over. Use the left and right mouse buttons to move. Hold the right mouse button while at the treasure chest to collect treasure.";
        YourScore = global.HiScores[UnknownEnum.Value_5];
        EnemyScore = [20, 40];
    }
    
    if (instance_exists(oMinigame_CircusSorter))
    {
        DescriptionText = "Drag the Bidybabs to Baby and the Minireenas to Ballora! Left click to pick up either. Taking too long to sort a bot or sorting one to the wrong side will result in a jumpscare.";
        YourScore = global.HiScores[UnknownEnum.Value_6];
        EnemyScore = [50, 100];
    }
    
    if (instance_exists(oMinigame_GoldenFazsweep))
    {
        DescriptionText = "A harder version of Fredsweeper, with four times the tiles! Beat this game to earn a huge token bonus!";
        YourScore = global.HiScores[5];
        EnemyScore = [360, 360];
    }
    
    if (instance_exists(oMinigame_Stacker))
    {
        DescriptionText = "A familiar stacker. Stack blocks and clear lines to earn points. Clear larger lines to earn tokens. Use J and L to move, I to hard drop, K to soft drop, B to hold, and the arrow keys to rotate.";
        YourScore = global.HiScores[11];
        EnemyScore = [400, 1600];
    }
    
    if (instance_exists(oMinigame_FreddyFazsweep) || instance_exists(oMinigame_HarePairs) || instance_exists(oMinigame_GoldenFazsweep))
    {
        if (YourScore <= EnemyScore[0] && global.MinigameCleared == 0)
            clear_minigame(false);
        
        if (YourScore <= EnemyScore[1] && global.MinigameCleared == 1)
            clear_minigame(true);
        
        YourScore = format_as_timer(YourScore);
        EnemyScore[DisplayScore] = format_as_timer(EnemyScore[DisplayScore]);
    }
    else
    {
        if (YourScore >= EnemyScore[0] && global.MinigameCleared == 0)
            clear_minigame(false);
        
        if (YourScore >= EnemyScore[1] && global.MinigameCleared == 1)
            clear_minigame(true);
    }
    
    draw_set_font(global.FontW97White);
    draw_set_color(#002F33);
    draw_text_ext(40, 35 + YOffset, DescriptionText, 14, 224);
    draw_text(40, 35 + YOffset + 28 + string_height_ext(DescriptionText, 14, 224), "Press space to quit.");
    
    if (FlashFrames > 0)
    {
        FlashFrames--;
        
        if ((floor(FlashFrames / 4) % 2) == 0)
            draw_set_color(#346856);
    }
    
    draw_text(39, 306 + YOffset, "HIGH SCORE: " + string(YourScore));
    EnemyScore = "SCORE TO BEAT: " + string(EnemyScore[DisplayScore]);
    draw_text(161, 306 + YOffset, EnemyScore);
    draw_set_color(c_white);
    global.MinigameWindowX = 284;
    global.MinigameWindowY = 36;
    global.MinigameWindowScale = 2;
    draw_surface_ext(global.MinigameSurface, 284, 324 + YOffset, 2, -2, 0, c_white, 1);
}

surface_reset_target();
YOffset -= (YOffset / 10);

enum UnknownEnum
{
    Value_0,
    Value_2 = 2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_8 = 8
}
