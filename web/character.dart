part of citadel;

class Character
{
	String		name;
	List<int>	hash;

	int			experience;
	int			level;
	int			age;
	Job			job;
	List<Job>	job_list;
	List<Job>	clean_job_list;

	int			time;
	Calendar	calendar;
	Map			state;
	int			ticks;
	Random		rand;

	int			strength;
	int			stamina;
	int			agility;
	int			dexterity;
	int			intelligence;
	int			charisma;
	int			wisdom;
	int			will;

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
		if (level != strength + stamina + agility + dexterity
				+ intelligence + charisma + wisdom + will)
			level = strength + stamina + agility + dexterity
					+ intelligence + charisma + wisdom + will;
		if (ticks == 365 * 60)
		{
			age += 1;
			ticks = 0;
		}
	}

	updateCalendar()
	{
		time += 1;
		if (time == state['time'])
		{
			String skill_shape = state['skill_shape'];
			int skill_chance = getRand(2);

			if (state['skill_rand'] == 'none')
				;
			else
			{
				if (skill_shape.contains(' ', 0))
				{
					List<String> skill_list = skill_shape.split(' ');
					if (state['skill_loot'] == 'random')
					{
						int stat_nbr = getRand(8);
						int rand_loot = getRand(state['skill_rand']);

						if (stat_nbr == 0)
							strength += rand_loot;
						else if (stat_nbr == 1)
							stamina += rand_loot;
						else if (stat_nbr == 2)
	   						agility += rand_loot;
						else if (stat_nbr == 3)
							dexterity += rand_loot;
						else if (stat_nbr == 4)
							intelligence += rand_loot;
						else if (stat_nbr == 5)
							charisma += rand_loot;
						else if (stat_nbr == 6)
							wisdom += rand_loot;
						else if (stat_nbr == 7)
							will += rand_loot;
					}
					else if (state['skill_loot'] == 'all')
					{
						skill_list.forEach( (elem)
						{
							int rand_loot = getRand(state['skill_rand']);

							if (elem == 'strength')
								strength += rand_loot;
							else if (elem == 'stamina')
								stamina += rand_loot;
							else if (elem == 'agility')
		   						agility += rand_loot;
							else if (elem == 'dexterity')
								dexterity += rand_loot;
							else if (elem == 'intelligence')
								intelligence += rand_loot;
							else if (elem == 'charisma')
								charisma += rand_loot;
							else if (elem == 'wisdom')
								wisdom += rand_loot;
							else if (elem == 'will')
								will += rand_loot;
						});
					}
				}
				else if (skill_shape == 'all')
				{
					if (state['skill_loot'] == 'random')
					{
						int stat_nbr = getRand(8);
						int rand_loot = getRand(state['skill_rand']);

						if (stat_nbr == 0)
							strength += rand_loot;
						else if (stat_nbr == 1)
							stamina += rand_loot;
						else if (stat_nbr == 2)
	   						agility += rand_loot;
						else if (stat_nbr == 3)
							dexterity += rand_loot;
						else if (stat_nbr == 4)
							intelligence += rand_loot;
						else if (stat_nbr == 5)
							charisma += rand_loot;
						else if (stat_nbr == 6)
							wisdom += rand_loot;
						else if (stat_nbr == 7)
							will += rand_loot;
					}
				}
				else
				{
					int rand_loot = getRand(state['skill_rand']);

					if (skill_shape == 'strength')
						strength += rand_loot;
					else if (skill_shape == 'stamina')
						stamina += rand_loot;
					else if (skill_shape == 'agility')
							agility += rand_loot;
					else if (skill_shape == 'dexterity')
						dexterity += rand_loot;
					else if (skill_shape == 'intelligence')
						intelligence += rand_loot;
					else if (skill_shape == 'charisma')
						charisma += rand_loot;
					else if (skill_shape == 'wisdom')
						wisdom += rand_loot;
					else if (skill_shape == 'will')
						will += rand_loot;
				}
			}
			int index = calendar.calendar.indexOf(state) + 1;
			if (index > calendar.calendar.length - 1)
				index = 0;
			state = calendar.calendar.elementAt(index);
			time = 0;
		}
	}

	updateJoblist()
	{
		job_list.forEach( (job)
		{
			if (clean_job_list.contains(job))
				;
			else if (job.data['requirement'] != 'none')
			{
				List<Map> test = job.data['requirement'];
				test.forEach( (test)
				{
					if (test.keys.first == 'level')
					{
						String demerde = test.values.first;
						int nbr = int.parse(demerde);
						if (nbr <= level)
						{
							clean_job_list.add(job);
						}
					}
				});
			}
			else
				clean_job_list.add(job);
		});
	}

	Increment()
	{
		ticks += 1;
		Check();
	}

//	toString()
//	{
//		return (("<span class=\"character\">" + name + "</span>").padLeft(40, "&nbsp;") + ", "
//				+ state.keys.first.padLeft(7, "&nbsp;")
//				+ ", lvl: " + level.toString()
//				+ ", xp: " + experience.toString().padRight(6, "&nbsp;")
//				+ " age: " + age.toString().padRight(3, "&nbsp;")
//				+ "cmp: " + time.toString().padRight(5, "&nbsp;"));
//	}

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
//		new Calendar()
//       	.onLoad().then( (Calendar calendar)
//        {
//        	this.calendar = calendar;
////        	this.state = this.calendar.calendar.first;
//
//        });
		List<String> job_slist = ['rover', 'farmer', 'miner', 'hunter', 'priest', 'chief'];
		List<Future> job_flist = new List();
		job_list = new List();
		clean_job_list = new List();

		Future.forEach(job_slist, (str)
		{
			Job tmp = new Job(str);
			job_list.add(tmp);
			job_flist.add(tmp.onLoad());
		}).then( (event)
		{
			Future.wait(job_flist)
			.then( (elem)
			{
				job = job_list.first;
				calendar = new Calendar()
				..onLoad().then( (event)
				{
					calendar.Update(job, rand).then ( (event)
					{
						state = calendar.calendar.first;
					});
				});
			});
		});

		experience = 0;
		level = 1;
		age = 15;
		time = 0;
		ticks = 0;
		strength = 0;
    	stamina = 0;
    	agility = 0;
    	dexterity = 0;
    	intelligence = 0;
    	charisma = 0;
    	wisdom = 0;
    	will = 0;
    	rand = new Random(hashName());
	}
}