state("porter1.2")
{
    ushort timer: 0x4363FA;
    ushort timerFraction: 0x4363F8;
    ushort level: 0x4363FE;
    bool started: 0x43C924;
    bool finished: 0x43C925;
}

state("porterkk")
{
    ushort timer: 0x4363FA;
    ushort timerFraction: 0x4363F8;
    ushort level: 0x4363FE;
    bool started: 0x43C926;
    bool finished: 0x43C927;
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
    return current.started && !old.started;
}

reset
{
    return !current.started && old.started;
}

gameTime
{
    double fraction = current.timerFraction * 0.0000152587890625; // 1/65536
    return TimeSpan.FromSeconds((double)current.timer + fraction);
}

split
{
    if(current.finished && !old.finished) {
        return true;
    }
    
    if (current.level != old.level) {
        return settings["split_level_"+old.level];
    }
}

isLoading
{
    return true;
}