part of citadel;

class Game
{
	Player				player;
	Calendar			calendar;
	World				world;

	Character			charmenu;

	BodyElement			body;
	DivElement			index;
	DivElement			charlist;
	DivElement			map;
	DivElement			menu;

	int					click_bool = 0;

	keyEvent()
	{
		window.onKeyDown.listen( (event)
		{
//			print(event.keyCode);
			if (event.keyCode == 77)
			{
				if (map.hidden == true)
				{

					charlist.hidden = true;
					map.hidden = false;
				}
				else
				{
					map.hidden = true;
					charlist.hidden = false;
				}

			}
		});
	}

	indexInit()
	{
		index.appendHtml('Hi.<br>What\'s your name ?<br>');
		index.appendHtml('<input id="index" autofocus>');
		index.attributes['class'] = 'index';
    	body.append(index);
	}

	listInit()
	{
		charlist.attributes['id'] = 'charlist';
        charlist.attributes['class'] = 'charlist';
        body.append(charlist);
	}

	mapInit()
	{
		map.attributes['id'] = 'map';
		map.attributes['class'] = 'map';
		map.hidden = true;
		body.append(map);
	}

	menuInit()
	{
		menu.attributes['id'] = 'menu';
		menu.attributes['class'] = 'menu';
		menu.hidden == true;
		body.append(menu);
	}

	listWrite()
	{
		player.char_list.forEach( (character)
		{
			DivElement char_list = document.body.querySelector('#charlist');
       		DivElement char_div = char_list.querySelector('#' + character.name);
       		if (char_div == null)
       		{
       			char_div = new DivElement();
       			char_div.attributes['id'] = character.name;
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
       				name_span_listen(name_span);
           			char_div.append(name_span);
       			}
       			else
       			{
       				name_span.text = '';
       				name_span.appendHtml(character.name.padLeft(15, "&nbsp") + ' ');
       			}

       			SpanElement job_span = char_div.querySelector('#job');
            	if (job_span == null)
                {
                	job_span = new SpanElement();
                    job_span.attributes['id'] = 'job';
                    job_span.attributes['class'] = 'job_span';
                    char_div.append(job_span);
                }
                else
                	job_span.text = character.job.data['name'] + ' ';

            	SpanElement level_span = char_div.querySelector('#level');
               	if (level_span == null)
               	{
               		level_span = new SpanElement();
               		level_span.attributes['id'] = 'level';
               		level_span.attributes['class'] = 'level_span';
                    char_div.append(level_span);
               	}
               	else
               		level_span.text = 'level: ' + character.level.toString() + ' ';

//			SpanElement xp_span = char_div.querySelector('#xp');
//			if (xp_span == null)
//			{
//				xp_span = new SpanElement();
//                xp_span.attributes['id'] = 'xp';
//                xp_span.attributes['class'] = 'xp_span';
//                char_div.append(xp_span);
//			}
//			else
//				xp_span.text = experience.toString();

            	SpanElement state_span = char_div.querySelector('#state');
            	if (state_span == null)
            	{
            		state_span = new SpanElement();
                    state_span.attributes['id'] = 'state';
                    state_span.attributes['class'] = 'state_span';
                    char_div.append(state_span);
            	}
            	else
            		state_span.text = character.state.keys.first.toString();
            }
		});
	}

	menuWrite()
	{
		if (charmenu != null)
		{
			SpanElement name_span = menu.querySelector('#menu_name');
			if (name_span == null)
			{
				name_span = new SpanElement();
                name_span.attributes['id'] = 'menu_name';
                name_span.attributes['class'] = 'menu_name_span';
                menu.append(name_span);
			}
			else
			{
				name_span.text = '';
                name_span.appendHtml(charmenu.name);
			}

			Element dropdown = menu.querySelector('#menu_dropdown');
			if (dropdown == null)
			{
				Element dropdown = new Element.nav();
				dropdown.attributes['id'] = 'menu_dropdown';
				dropdown.attributes['class'] = 'dropdown';
				dropdown.style.float = 'Right';
				dropdown.appendHtml("Jobs" + '<br');
				dropdown_listen(dropdown);
				menu.append(dropdown);
			}
			else
			{
				charmenu.clean_job_list.forEach( (elem)
				{
					Element droppiece = dropdown.querySelector('#menu_' + elem.data['name']);
					if (droppiece == null)
					{
						droppiece = new Element.span();
						droppiece.attributes['id'] = 'menu_' + elem.data['name'];
						droppiece.attributes['class'] = 'droppiece';
						droppiece_listen(droppiece);
						dropdown.append(droppiece);
					}
					else
					{
						droppiece.text = elem.data['name'];
					}
				});
			}


//			Element dropdown = new Element.nav();
//			dropdown.attributes['id'] = 'dropdown';
//			dropdown.style.float = 'Left';
//			dropdown.appendHtml("Jobs" + '<br');
//
//			charmenu.job_list.forEach( (elem)
//			{
//				Element droppiece = new Element.span();
//				droppiece.attributes['class'] = 'droppiece';
//
//				droppiece.appendText(elem.data['name']);
//				dropdown.append(droppiece);
//			});
//
//			menu.appendHtml(charmenu.name + '<br>');
//			menu.appendHtml(charmenu.state.keys.first + '<br>');
//			menu.appendHtml('strength: ' + charmenu.strength.toString() + '<br>');
//			menu.appendHtml('stamina: ' + charmenu.stamina.toString() + '<br>');
//			menu.appendHtml('agility: ' + charmenu.agility.toString() + '<br>');
//			menu.appendHtml('dexterity: ' + charmenu.dexterity.toString() + '<br>');
//			menu.appendHtml('intelligence: ' + charmenu.intelligence.toString() + '<br>');
//			menu.appendHtml('charisma: ' + charmenu.charisma.toString() + '<br>');
//			menu.appendHtml('wisdom: ' + charmenu.wisdom.toString() + '<br>');
//			menu.appendHtml('will: ' + charmenu.will.toString() + '<br>');
//			menu.append(dropdown);
		}
	}

	mapWrite()
	{
		int		i;
		map.text = '';
		i = 0;

		String test = "";

		world.mapWorld.forEach( (elem)
		{
			if (elem == null)
				map.appendHtml("&nbsp;&nbsp;");
			else
				map.appendHtml("&nbsp;" + elem.toString());
			i += 1;
			if (i % world.sizeWorld == 0)
				map.appendHtml("<br>");
		});
	}

	eventVendredi()
	{
		if (player.char_list.length == 1)
		{
			if (player.char_list.first.getRand(1000) == 0)
			{
				print('at ' + player.char_list.first.ticks.toString());
				player.char_list.add(new Character('Vendredi'));
			}
		}
	}

	eventChars()
	{
		if (player.checkMinLevel(5) == true
				&& player.checkChar('Isaac') == false)
        {
   			player.char_list.add(new Character('Isaac'));
       	}
		if (player.checkMinLevel(10) == true
   				&& player.checkChar('Nadours') == false)
        {
			player.char_list.add(new Character('Nadours'));
        }
		if (player.checkMinLevel(15) == true
        		&& player.checkChar('Mathours') == false)
        {
        	player.char_list.add(new Character('Mathours'));
        }
        if (player.checkMinLevel(20) == true
         		&& player.checkChar('Chosours') == false)
        {
        	player.char_list.add(new Character('Chosours'));
        }
    }

	name_span_listen(Element span)
	{
		span.onClick.listen( (event)
        {
        	click_bool = 1;
        });

//   			elem.onMouseOut.listen( (event)
//   			{
		window.onDoubleClick.listen( (event)
		{
			if (click_bool == 1)
			{
				click_bool = 0;
				menu.hidden = true;
			}
		});
//   			});

		span.onMouseMove.listen( (event)
		{
			Iterable test = player.char_list.where( (char) => char.name == span.text.trim() );
			if (test.length == 1)
			{
				charmenu = test.first;
				Element dropdown = menu.querySelector('#menu_dropdown');
   				if (dropdown != null)
  				{
   					dropdown.text = '';
 					dropdown.appendHtml("Jobs" + '<br');
 					charmenu.updateJoblist();
    			}
				menu.hidden = false;
			}
		});

		span.onMouseLeave.listen( (event)
		{
			if (click_bool == 0)
			{
   				menu.hidden = true;
//   					charlist.style.height = "100%";
			}
		});
	}

	dropdown_listen(Element dropdown)
	{
//		dropdown.onMouseOver.listen( (event)
//		{
//			dropdown.text = '';
//            dropdown.appendHtml("Jobs" + '<br');
//           	charmenu.updateJoblist();
//		});
		;
	}

	droppiece_listen(Element droppiece)
	{
		droppiece.onMouseDown.listen( (event)
		{
			Iterable new_job = charmenu.clean_job_list.where( (job) => job.data['name'] == droppiece.text);
			if (new_job.length == 1)
				charmenu.job = new_job.first;
			else
				print("false job selector");
		});
	}

//	listen()
//	{
//		window.onMouseOver.listen( (event)
//        {
//			Element dropdown = menu.querySelector('#menu_dropdown');
//			if (dropdown != null)
//			{
//				dropdown.text = '';
//				dropdown.appendHtml("Jobs" + '<br');
//				charmenu.updateJoblist();
//			}
//        });
//	}

	runGame(Timer)
	{
		index.remove();
		new Future( () { listWrite(); menuWrite(); })
		..then( (event)
		{
			player.char_list.forEach( (elem) => elem.Increment());
			player.char_list.forEach( (elem) => elem.updateCalendar());
			eventVendredi();
			eventChars();
		});
	}

	Future GameInit()
	{
		return new Future ( ()
			{
				index = new DivElement();
				charlist = new DivElement();
				map = new DivElement();
				menu = new DivElement();
			}).then( (event)
			{
				indexInit();
                listInit();
                mapInit();
                menuInit();
			});
	}

	Game()
	{
		body = document.querySelector('body');

		GameInit().then( (event)
		{
			InputElement input = document.querySelector('#index');
	    	input.onChange.listen( (event)
	    	{
				index.text = "Loading";
				player = new Player(input.value);
				world = new World(player)
				..onLoad().then( (event)
				{
					print('Timer Begin');
//					listen();
					mapWrite();
					keyEvent();
					new Timer.periodic(new Duration(milliseconds: 80), runGame);

				});
	    	});
    	});
	}
}