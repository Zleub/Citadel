part of citadel;

class Character
{
	String		name;
	List<int>	hash;
	int			experience;
	int			level;
	int			time;
	Calendar	calendar;
	Map			state;
	int			ticks;

	NametoHash()
	{
		SHA256 hash = new SHA256();
		hash.add(name.codeUnits);
		hash.add(new List<int>.filled(1, ticks));
		this.hash = hash.close();

		int i = 0;
//		this.hash.forEach((e) { print(i.toString() + ", " + e.toString() + ' '); i += 1; });
	}

	getRand(int max)
	{
		if (hash == null || hash.isEmpty)
        			NametoHash();
//		int nbr = new Random(hash).nextInt(max);
		int	nbr = hash.last;
		hash.removeLast();
		return (nbr % max);
	}

	Check()
	{
		if (experience == level * 10)
		{
			experience = 0;
			level += 1;
		}
	}

	updateCalendar()
	{
		if (time == state.values.first)
		{
			int index = calendar.datalist.indexOf(state) + 1;
			if (index > calendar.datalist.length - 1)
				index = 0;
			state = calendar.datalist.elementAt(index);
			time = 0;
		}
	}

	Increment()
	{
		if (ticks % 10 == 0)
			experience += 1;
		time += 1;
		ticks += 1;
		Check();
	}

	toString()
	{
		return (name.padLeft(15, "&nbsp;") + ", " + state.keys.first.padLeft(15, "&nbsp;") + ", lvl: " + level.toString()) + ": t: " + ticks.toString().padRight(5, "&nbsp;");
	}

	Character(String this.name)
	{
		new Calendar()
       	.onLoad().then( (Calendar calendar)
        {
        	this.calendar = calendar;
        	this.state = this.calendar.datalist.first;
			experience = 0;
			level = 1;
			time = 0;
			ticks = 0;
        });
	}
}