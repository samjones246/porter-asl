state("porter1.1")
{
    ushort timer: 0x4363FA;
    ushort timerFraction: 0x4363F8;
    ushort level: 0x4363FE;
    bool started: 0x43640E;
}

startup
{
    settings.Add("split_level", true, "Split after level");
    for (int i = 0; i < 28; i++)
    {
        settings.Add("split_level_"+(i+1), true, "Level "+(i+1), "split_level");
    }
}

start
{
    return current.timer == 0 && current.timerFraction > 0 && old.timerFraction == 0;
}

reset
{
    return current.timer < old.timer;
}

gameTime
{
    double fraction = current.timerFraction * 0.0000152587890625; // 1/65536
    return TimeSpan.FromSeconds((double)current.timer + fraction);
}

split
{
    if (current.level != old.level) {
        return settings["split_level_"+old.level];
    }
}

isLoading
{
    return true;
}