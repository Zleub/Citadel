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
		if (ticks % 100 == 0 && state.keys.first == 'spare')
		{
			int		tmp1 = getRand(8);
			int		tmp2 = getRand(2);

			if (tmp1 == 0)
				strength += tmp2;
			if (tmp1 == 1)
   				stamina += tmp2;
			if (tmp1 == 2)
            	agility += tmp2;
			if (tmp1 == 3)
   				dexterity += tmp2;
			if (tmp1 == 4)
				intelligence += tmp2;
			if (tmp1 == 5)
   				charisma += tmp2;
			if (tmp1 == 6)
            	wisdom += tmp2;
			if (tmp1 == 7)
   				will += tmp2;
		}
		if (ticks % 10 == 0)
			experience += 1;
		time += 1;
		ticks += 1;
		Check();
	}

	Print()
	{
		DivElement char_list = document.body.querySelector('#charlist');
		DivElement char_div = char_list.querySelector('#' + name);
		if (char_div == null)
		{
			char_div = new DivElement();
			char_div.attributes['id'] = name;
			char_div.attributes['class'] = 'char_div';
			char_list.append(char_div);
		}
		else
		{
			SpanElement name_span = char_div.querySelector('#name');
			if (name_span == null)
			{
				name_span = new SpanElement();
				name_span.attributes['id'] = 'name';
				name_span.attributes['class'] = 'name_span';
       			char_div.append(name_span);
			}
			else
			{
				name_span.text = '';
				name_span.appendHtml(name.padLeft(15, "&nbsp") + ' ');
			}

			SpanElement job_span = char_div.querySelector('#job');
			{
				if (job_span == null)
    			{
    				job_span = new SpanElement();
                    job_span.attributes['id'] = 'job';
                    job_span.attributes['class'] = 'job_span';
                    char_div.append(job_span);
    			}
    			else
    				job_span.text = job.data['name'] + ' ';
			}

			SpanElement level_span = char_div.querySelector('#level');
   			if (level_span == null)
   			{
   				level_span = new SpanElement();
   				level_span.attributes['id'] = 'level';
   				level_span.attributes['class'] = 'level_span';
                char_div.append(level_span);
   			}
   			else
   				level_span.text = 'level: ' + level.toString() + ' ';

			SpanElement xp_span = char_div.querySelector('#xp');
			if (xp_span == null)
			{
				xp_span = new SpanElement();
                xp_span.attributes['id'] = 'xp';
                xp_span.attributes['class'] = 'xp_span';
                char_div.append(xp_span);
			}
			else
				xp_span.text = experience.toString();
		}
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
		new Calendar()
       	.onLoad().then( (Calendar calendar)
        {
        	this.calendar = calendar;
        	this.state = this.calendar.datalist.first;
        });
		List<String> job_slist = ['rover', 'farmer', 'miner'];
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