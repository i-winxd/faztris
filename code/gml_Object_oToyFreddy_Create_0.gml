TFScores[UnknownEnum.Value_0] = 0;
TFScores[UnknownEnum.Value_1] = 0;
TFScores[UnknownEnum.Value_2] = 0;
TFScores[UnknownEnum.Value_3] = 0;
TFScores[UnknownEnum.Value_4] = 360;
TFScores[UnknownEnum.Value_5] = 0;
TFScores[UnknownEnum.Value_6] = 0;
TFScores[UnknownEnum.Value_7] = 0;
TFScores[UnknownEnum.Value_8] = 0;
TFScores[UnknownEnum.Value_9] = 0;
TFScores[UnknownEnum.Value_10] = 0;
TFScores[11] = 0;
Active = true;
BeatenScores = array_create(array_length(TFScores), false);
BeatenAmount = 0;
audio_sound_gain(voc_ToyFreddy_Sobbing, 0, 0);

function calc_high_score(arg0, arg1)
{
    var Diff = global.AILevels[UnknownEnum.Value_6] / global.NightSpeedup;
    
    if (Diff == 21)
        Diff = 10;
    
    Diff /= 20;
    return round(lerp(arg0, arg1, Diff));
}

if (global.Timer > 348)
    instance_destroy();

function jumpscare_at_6AM()
{
    if (instance_exists(oJumpscare))
        return false;
    
    if (Active && global.AILevels[UnknownEnum.Value_6] > 0)
    {
        jumpscare(UnknownEnum.Value_6, 0);
        return true;
    }
    
    return false;
}

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
