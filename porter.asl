state("porter")
{
    int timer: 0x4363FA;
    int startx: 0x4363EA;
    int starty: 0x4363EE;
}

startup
{
    vars.sectionEnds = new List<Tuple<int, int>>() {
        new Tuple<int, int>(408, 16),
        new Tuple<int, int>(40, 144),
        new Tuple<int, int>(392, 216),
        new Tuple<int, int>(912, 200),
        new Tuple<int, int>(400, 344),
        new Tuple<int, int>(920, 344),
    };

    settings.Add("split_level", false, "Split after each level");
    settings.Add("split_section", true, "Split after each section");
}

start
{
    return current.timer > 0 && old.timer == 0;
}

reset
{
    return current.timer == 0 && old.timer != 0;
}

gameTime
{
    return TimeSpan.FromSeconds((double)current.timer);
}

split
{
    if (current.startx != old.startx || current.starty != old.starty) {
        if (vars.sectionEnds.Contains(new Tuple<int, int>(old.startx, old.starty))) {
            return settings["split_level"] || settings["split_section"];
        } else {
            return settings["split_level"];
        }
    }
}