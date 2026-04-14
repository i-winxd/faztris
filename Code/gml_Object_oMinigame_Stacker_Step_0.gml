if (room == Office)
{
    if (global.MonitorSystem != "Games" || !global.CamUp)
        Paused = true;
    else
        Paused = false;
}


if (Dead)
{
    DeathTimer++;
    
    if (DeathTimer >= 120)
        reset_game();
    
    exit;
}


var PREVENT_ACCIDENTAL_HARD_DROPS = true;
var HARD_DROP_PREVENT_WINDOW = 6;

if (!variable_instance_exists(id, "HardDropLockoutTimer"))
    HardDropLockoutTimer = 0;


if (HardDropLockoutTimer > 0)
    HardDropLockoutTimer--;

KeyLeft =     arr_safe_(global.Settings[0], 32 , ord("J"));
KeyRight =    arr_safe_(global.Settings[0], 33 , ord("L"));
KeySoftDrop = arr_safe_(global.Settings[0], 31, ord("K"));
KeyHardDrop = arr_safe_(global.Settings[0], 30, ord("I"));
KeyCCW =      arr_safe_(global.Settings[0], 26, vk_left);
KeyCW =       arr_safe_(global.Settings[0], 27, vk_right);
Key180Up =    arr_safe_(global.Settings[0], 28, vk_up);
Key180Down =  arr_safe_(global.Settings[0], 12, vk_down);
KeyHold =     arr_safe_(global.Settings[0], 29, ord("B"));
ARR = arr_safe_(global.Settings[3], 4, 2); 
DAS = arr_safe_(global.Settings[3], 5, 10);
DCD = arr_safe_(global.Settings[3], 6, 2); 
SDF = max(arr_safe_(global.Settings[3], 7, 26), 1);


var in_left = keyboard_check(KeyLeft);
var in_right = keyboard_check(KeyRight);
var in_sd = keyboard_check(KeySoftDrop);
var in_hd = keyboard_check_pressed(KeyHardDrop);

if (PREVENT_ACCIDENTAL_HARD_DROPS && HardDropLockoutTimer > 0)
{
    in_hd = false;
}

var in_ccw = keyboard_check_pressed(KeyCCW);
var in_cw = keyboard_check_pressed(KeyCW);
var in_180 = keyboard_check_pressed(Key180Up) || keyboard_check_pressed(Key180Down);
var in_hold = keyboard_check_pressed(KeyHold);
var moved_horizontally = false;
var kicked = false;

if (AllClearTimer > 0)
    AllClearTimer--;

if (in_hold && CanHold)
{
    if (HoldPiece == -1)
    {
        HoldPiece = ActivePiece;
        spawn_piece(array_shift(Bag));
    }
    else
    {
        var temp = HoldPiece;
        HoldPiece = ActivePiece;
        spawn_piece(temp);
    }
    
    CanHold = false;
    
    if (array_length(Bag) <= 7)
        generate_bag();
}

var actual_rot_change = 0;

if (in_180)
    actual_rot_change = 2;
else if (in_cw)
    actual_rot_change = 1;
else if (in_ccw)
    actual_rot_change = 3;

if (actual_rot_change != 0 && ActivePiece != 4)
{
    var new_rot = (ActiveRot + actual_rot_change) % 4;
    
    for (var test = 0; test < 5; test++)
    {
        var kick = get_kick(ActivePiece, ActiveRot, new_rot, test);
        var kx = kick[0];
        var ky = kick[1];
        
        if (!check_collision(ActiveX + kx, ActiveY + ky, new_rot))
        {
            ActiveX += kx;
            ActiveY += ky;
            ActiveRot = new_rot;
            kicked = true;
            LastMoveRotate = true;
            LastKickIndex = test;
            SpinKicked = test > 0;
            var imm_left = check_collision(ActiveX - 1, ActiveY, ActiveRot);
            var imm_right = check_collision(ActiveX + 1, ActiveY, ActiveRot);
            var imm_up = check_collision(ActiveX, ActiveY - 1, ActiveRot);
            var imm_down = check_collision(ActiveX, ActiveY + 1, ActiveRot);
            IsImmobile = imm_left && imm_right && imm_up && imm_down;
            break;
        }
    }
}

var dir = in_right - in_left;

if (dir != 0)
{
    if (DasDir != dir)
    {
        DasTimer = 0;
        DasDir = dir;
        
        if (!check_collision(ActiveX + dir, ActiveY, ActiveRot))
        {
            ActiveX += dir;
            moved_horizontally = true;
            LastMoveRotate = false;
            SpinKicked = false;
            IsImmobile = false;
        }
    }
    else
    {
        DasTimer++;
        
        if (DasTimer >= DAS)
        {
            ArrTimer++;
            
            if (ArrTimer >= ARR)
            {
                ArrTimer = 0;
                
                while (!check_collision(ActiveX + dir, ActiveY, ActiveRot))
                {
                    ActiveX += dir;
                    moved_horizontally = true;
                    LastMoveRotate = false;
                    SpinKicked = false;
                    IsImmobile = false;
                    
                    if (ARR > 0)
                        break;
                }
            }
        }
    }
}
else
{
    DasTimer = 0;
    DasDir = 0;
}

if (moved_horizontally || kicked)
{
    var snd = audio_play_sound(sfxBitThud, 3, false);
    audio_sound_gain(snd, 0.3, 0);
}

var is_touching_ground = check_collision(ActiveX, ActiveY + 1, ActiveRot);

if ((moved_horizontally || kicked) && is_touching_ground)
{
    if (LockResets < 15)
    {
        LockTimer = 0;
        LockResets++;
    }
}

var prev_y = floor(ActiveY);
var sec_per_row = power(max(0.1, 0.8 - ((Level - 1) * 0.007)), Level - 1);
var gravity_speed = 1 / sec_per_row / 60;
var drop_amt = gravity_speed;

if (in_sd)
    drop_amt *= SDF;

var y_steps = floor(drop_amt);
var remainder = drop_amt - y_steps;

for (var i = 0; i < y_steps; i++)
{
    if (!check_collision(ActiveX, ActiveY + 1, ActiveRot))
        ActiveY++;
    else
        break;
}

if (!check_collision(ActiveX, ActiveY + remainder, ActiveRot))
    ActiveY += remainder;
else
    ActiveY = floor(ActiveY);

if (floor(ActiveY) > prev_y)
{
    LockTimer = 0;
    LockResets = 0;
    LastMoveRotate = false;
    SpinKicked = false;
    IsImmobile = false;
}

var locked = false;

if (in_hd)
{
    var hd_dist;
    
    for (hd_dist = 0; !check_collision(ActiveX, ActiveY + 1, ActiveRot); hd_dist++)
        ActiveY++;
    
    if (hd_dist > 0)
    {
        LastMoveRotate = false;
        SpinKicked = false;
        IsImmobile = false;
    }
    
    locked = true;
    audio_play_sound(sfxBitCrunch, 9, false);
}
else if (check_collision(ActiveX, ActiveY + 1, ActiveRot))
{
    LockTimer++;
    
    if (LockTimer >= LockDelayMax)
    {
        locked = true;
        
        if (PREVENT_ACCIDENTAL_HARD_DROPS)
        {
            HardDropLockoutTimer = HARD_DROP_PREVENT_WINDOW;
        }
    }
}

if (locked)
{
    var shape = Pieces[ActivePiece];
    var size = array_length(shape);
    
    for (var r = 0; r < size; r++)
    {
        for (var c = 0; c < size; c++)
        {
            var src_r, src_c;
            
            if (ActiveRot == 0)
            {
                src_r = r;
                src_c = c;
            }
            else if (ActiveRot == 1)
            {
                src_r = size - 1 - c;
                src_c = r;
            }
            else if (ActiveRot == 2)
            {
                src_r = size - 1 - r;
                src_c = size - 1 - c;
            }
            else if (ActiveRot == 3)
            {
                src_r = c;
                src_c = size - 1 - r;
            }
            
            var cell = shape[src_r][src_c];
            
            if (cell != 0)
            {
                var gx = floor(ActiveX) + c;
                var gy = floor(ActiveY) + r;
                
                if (gx >= 0 && gx < BoardWidth && gy >= 0 && gy < BoardHeight)
                    Grid[(gy * BoardWidth) + gx] = cell;
            }
        }
    }
    
    var is_spin = false;
    var is_mini = false;
    
    if (LastMoveRotate)
    {
        if (ActivePiece == 6)
        {
            var front_filled = 0;
            var back_filled = 0;
            var tx = floor(ActiveX);
            var ty = floor(ActiveY);
            var tl = tx < 0 || ty < 0 || Grid[(ty * BoardWidth) + tx] != 0;
            var tr = (tx + 2) >= BoardWidth || ty < 0 || Grid[(ty * BoardWidth) + tx + 2] != 0;
            var bl = tx < 0 || (ty + 2) >= BoardHeight || Grid[((ty + 2) * BoardWidth) + tx] != 0;
            var br = (tx + 2) >= BoardWidth || (ty + 2) >= BoardHeight || Grid[((ty + 2) * BoardWidth) + tx + 2] != 0;
            
            if (ActiveRot == 0)
            {
                front_filled = tl + tr;
                back_filled = bl + br;
            }
            else if (ActiveRot == 1)
            {
                front_filled = tr + br;
                back_filled = tl + bl;
            }
            else if (ActiveRot == 2)
            {
                front_filled = bl + br;
                back_filled = tl + tr;
            }
            else if (ActiveRot == 3)
            {
                front_filled = tl + bl;
                back_filled = tr + br;
            }
            
            if ((front_filled + back_filled) >= 3)
            {
                is_spin = true;
                
                if (front_filled == 1 && LastKickIndex != 4)
                    is_mini = true;
            }
        }
        else if (IsImmobile)
        {
            is_spin = true;
            is_mini = true;
        }
    }
    
    var lines_cleared = 0;
    
    for (var gy = 0; gy < BoardHeight; gy++)
    {
        var row_full = true;
        
        for (var gx = 0; gx < BoardWidth; gx++)
        {
            if (Grid[(gy * BoardWidth) + gx] == 0)
            {
                row_full = false;
                break;
            }
        }
        
        if (row_full)
        {
            lines_cleared++;
            
            for (var shift_y = gy; shift_y > 0; shift_y--)
            {
                for (var gx = 0; gx < BoardWidth; gx++)
                    Grid[(shift_y * BoardWidth) + gx] = Grid[((shift_y - 1) * BoardWidth) + gx];
            }
            
            for (var gx = 0; gx < BoardWidth; gx++)
                Grid[gx] = 0;
        }
    }
    
    var is_all_clear = false;
    
    if (lines_cleared > 0)
    {
        is_all_clear = true;
        
        for (var i = 0; i < (BoardWidth * BoardHeight); i++)
        {
            if (Grid[i] != 0)
            {
                is_all_clear = false;
                break;
            }
        }
        
        if (is_all_clear)
            AllClearTimer = 120;
    }
    
    if (lines_cleared > 0 || is_spin)
    {
        var clear_str = "";
        var base_attack = 0;
        var p_name = "";
        
        if (ActivePiece == 1)
            p_name = "I";
        else if (ActivePiece == 2)
            p_name = "J";
        else if (ActivePiece == 3)
            p_name = "L";
        else if (ActivePiece == 4)
            p_name = "O";
        else if (ActivePiece == 5)
            p_name = "S";
        else if (ActivePiece == 6)
            p_name = "T";
        else if (ActivePiece == 7)
            p_name = "Z";
        
        if (is_spin)
        {
            var s_type = "S";
            
            if (lines_cleared == 2)
                s_type = "D";
            
            if (lines_cleared == 3)
                s_type = "T";
            
            if (lines_cleared == 4)
                s_type = "Q";
            
            if (lines_cleared == 0)
                clear_str = p_name + "S";
            else
                clear_str = p_name + "S" + s_type;
            
            if (is_mini)
                clear_str += "M";
            
            if (!is_mini)
            {
                if (lines_cleared == 1)
                    base_attack = 4;
                else if (lines_cleared == 2)
                    base_attack = 8;
                else if (lines_cleared == 3)
                    base_attack = 12;
            }
            else if (lines_cleared == 1)
            {
                base_attack = 1;
            }
            else if (lines_cleared == 2)
            {
                base_attack = 2;
            }
            else if (lines_cleared == 3)
            {
                base_attack = 4;
            }
            else if (lines_cleared == 4)
            {
                base_attack = 7;
            }
        }
        else if (lines_cleared == 1)
        {
            clear_str = "SING";
            base_attack = 1;
        }
        else if (lines_cleared == 2)
        {
            clear_str = "DOUB";
            base_attack = 2;
        }
        else if (lines_cleared == 3)
        {
            clear_str = "TRIP";
            base_attack = 4;
        }
        else if (lines_cleared == 4)
        {
            clear_str = "QUAD";
            base_attack = 7;
        }
        
        if (is_all_clear)
            base_attack += 14;
        
        var is_difficult = lines_cleared == 4 || is_spin;
        
        if (is_difficult && lines_cleared > 0)
        {
            B2B++;
            var b2b_bonus = 0;
            
            if (B2B >= 2 && B2B <= 3)
                b2b_bonus = 2;
            else if (B2B >= 4 && B2B <= 8)
                b2b_bonus = 4;
            else if (B2B >= 9 && B2B <= 24)
                b2b_bonus = 6;
            else if (B2B >= 25)
                b2b_bonus = 8;
            
            base_attack += b2b_bonus;
        }
        else if (lines_cleared > 0)
        {
            B2B = 0;
        }
        
        var final_attack = 0;
        
        if (base_attack > 0)
            final_attack = floor(base_attack * (1 + (0.5 * Combo)));
        else if (Combo >= 2 && lines_cleared > 0)
            final_attack = floor(2 * ln(1 + (1.25 * Combo)));
        
        if (lines_cleared > 0)
        {
            Combo++;
            ClearText = clear_str;
            ClearAttack = final_attack;
            ClearTextTimer = 60;
            LinesCleared += lines_cleared;
            Level = floor(LinesCleared / 8) + 1;
            Score += (final_attack * 100);
            
            if (lines_cleared == 4)
                Score += 400;
            
            var snd_place = audio_play_sound(sfxBitPlace, 4, false);
            audio_sound_gain(snd_place, 0.4, 0);
            var token_mult = 1 + ((Level - 1) / 7);
            TokenFraction += (final_attack * token_mult);
            var tokens_to_add = floor(TokenFraction);
            
            if (tokens_to_add > 0)
            {
                add_tokens_silently(tokens_to_add);
                TokenFraction -= tokens_to_add;
                audio_play_sound(sfxBitCollect, 5, false);
            }
            
            if (is_difficult)
                audio_play_sound(sfxBitBoost, 8, false);
        }
        else if (is_spin && lines_cleared == 0)
        {
            ClearText = clear_str;
            ClearAttack = 0;
            ClearTextTimer = 60;
        }
    }
    else
    {
        Combo = 0;
    }
    
    CanHold = true;
    spawn_piece(array_shift(Bag));
    
    if (array_length(Bag) <= 7)
        generate_bag();
    
    if (Score > global.HiScores[11])
        global.HiScores[11] = Score;
}
