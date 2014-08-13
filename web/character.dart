part of citadel;

class Character
{
	String		name;
	List<int>	hash;
	int			experience;
	int			level;
	int			age;
	int			time;
	Calendar	calendar;
	Map			state;
	int			ticks;
	Random		rand;

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
//		if (hash == null || hash.isEmpty)
//        			NametoHash();

//		int	nbr = hash.last;
//		hash.removeLast();
		return (rand.nextInt(max));
	}

	Check()
	{
		if (experience >= level * 10)
		{
			experience = 0;
			level += 1;
		}
		if (ticks == 365 * 60)
		{
			age += 1;
			ticks = 0;
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
		return ("<span class=\"character\">" + name.padLeft(15, "&nbsp;") + "</span>, "
				+ state.keys.first.padLeft(7, "&nbsp;")
				+ ", lvl: " + level.toString()
				+ ", xp: " + experience.toString().padRight(6, "&nbsp;")
				+ " age: " + age.toString().padRight(3, "&nbsp;")
				+ "cmp: " + time.toString().padRight(5, "&nbsp;"));
	}

	hashName()
	{
		int				hash;
		int				c;
		int				i;

		hash = 5381;
		i = 0;
		while (i < name.length)
		{
			c = name.codeUnitAt(i);
			hash = ((hash << 5) + hash) ^ c;
			i += 1;
		}
		print("hash: " + hash.toString());
		if (hash < 0)
			return (hash * -1);
		else
			return (hash);
	}

	Character(String this.name)
	{
		new Calendar()
       	.onLoad().then( (Calendar calendar)
        {
        	this.calendar = calendar;
        	this.state = this.calendar.datalist.first;
        });
		experience = 0;
		level = 1;
		age = 15;
		time = 0;
		ticks = 0;
        rand = new Random(hashName());
	}
}