var ID = UnknownEnum.Value_6;
var AI = global.AILevels[ID];
TFScores[UnknownEnum.Value_0] = calc_high_score(120, 45);
TFScores[UnknownEnum.Value_1] = calc_high_score(5, 25);
TFScores[UnknownEnum.Value_2] = calc_high_score(0, 100);
TFScores[UnknownEnum.Value_3] = calc_high_score(10, 30);
TFScores[UnknownEnum.Value_4] = calc_high_score(360, 60);
TFScores[UnknownEnum.Value_5] = calc_high_score(5, 25);
TFScores[UnknownEnum.Value_6] = calc_high_score(10, 30);
TFScores[UnknownEnum.Value_7] = 360;
TFScores[UnknownEnum.Value_8] = calc_high_score(5, 20);
TFScores[UnknownEnum.Value_9] = calc_high_score(50, 200);
TFScores[UnknownEnum.Value_10] = calc_high_score(20, 100);
TFScores[11] = calc_high_score(2400, 12800);

if (Active && AI > 0)
{
    for (var i = 0; i < array_length(TFScores); i++)
    {
        if (BeatenScores[i])
            continue;
        
        if (i == UnknownEnum.Value_0 || i == UnknownEnum.Value_4 || i == UnknownEnum.Value_7)
        {
            if (TFScores[i] > global.HiScores[i])
            {
                BeatenScores[i] = true;
                BeatenAmount++;
                audio_play_sound(sfxChildrenCheering, 5, false);
                
                if (AI == 21)
                    notification((BeatenAmount == 8) ? "0 left! Good job!" : string("{0} more to go!", 8 - BeatenAmount), 2);
            }
        }
        else if (TFScores[i] < global.HiScores[i])
        {
            BeatenScores[i] = true;
            BeatenAmount++;
            audio_play_sound(sfxChildrenCheering, 5, false);
            
            if (AI == 21)
                notification((BeatenAmount == 8) ? "0 left! Good job!" : string("{0} more to go!", 8 - BeatenAmount), 2);
        }
    }
}

if (((AI <= 20 && BeatenAmount > 0) || (AI == 21 && BeatenAmount >= 8)) && Active)
{
    Active = false;
    reverb_sound(voc_ToyFreddy_AwMan, 0, -200);
    fuzz_up(UnknownEnum.Value_7);
    
    if (AI == 21)
        global.Timer = max(global.Timer, 358);
    
    reverb_sound(voc_ToyFreddy_Sobbing, 0, 0, true, 0.75, 1, 0.4, 1);
}

if (global.Cam == UnknownEnum.Value_7 && global.CamUp && !Active && AI > 0)
    audio_sound_gain(voc_ToyFreddy_Sobbing, 0.25, 0);
else
    audio_sound_gain(voc_ToyFreddy_Sobbing, 0, 0);

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
