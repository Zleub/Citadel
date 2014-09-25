part of citadel;

class Game
{
	Player				player;
	Calendar			calendar;
	World				world;

	Character			charmenu;

	DivElement			body;
	DivElement			index;
	DivElement			charlist;
	DivElement			map;
	DivElement			menu;

	int					click_bool = 0;
	int					panel_show = 0;

	keyEvent()
	{
		window.onKeyDown.listen( (event)
		{
//			print(event.keyCode);
			if (event.keyCode == 77)
			{
				if (panel_show == 0)
				{
					charlist.remove();
					body.append(map);
					panel_show = 1;
				}
				else if (panel_show == 1)
				{
					map.remove();
					body.append(charlist);
					panel_show = 0;
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
            		state_span.text = character.state['name'];
            }
		});
	}

	menuWrite()
	{
		if (charmenu != null)
		{
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

			Element strength_span = menu.querySelector('#menu_strength');
			if (strength_span == null)
			{
				strength_span = new SpanElement();
                strength_span.attributes['id'] = 'menu_strength';
                strength_span.attributes['class'] = 'menu_stat_span';
                menu.append(strength_span);
			}
			else
			{
				strength_span.text = '';
                strength_span.appendHtml('Strength: ' + charmenu.strength.toString());
			}

			Element stamina_span = menu.querySelector('#menu_stamina');
			if (stamina_span == null)
			{
				stamina_span = new SpanElement();
                stamina_span.attributes['id'] = 'menu_stamina';
                stamina_span.attributes['class'] = 'menu_stat_span';
                menu.append(stamina_span);
			}
			else
			{
				stamina_span.text = '';
                stamina_span.appendHtml('Stamina: ' + charmenu.stamina.toString());
			}

			Element agility_span = menu.querySelector('#menu_agility');
			if (agility_span == null)
			{
				agility_span = new SpanElement();
                agility_span.attributes['id'] = 'menu_agility';
                agility_span.attributes['class'] = 'menu_stat_span';
                menu.append(agility_span);
			}
			else
			{
				agility_span.text = '';
                agility_span.appendHtml('Agility: ' + charmenu.agility.toString());
			}

			Element dexterity_span = menu.querySelector('#menu_dexterity');
			if (dexterity_span == null)
			{
				dexterity_span = new SpanElement();
                dexterity_span.attributes['id'] = 'menu_dexterity';
                dexterity_span.attributes['class'] = 'menu_stat_span';
                menu.append(dexterity_span);
			}
			else
			{
				dexterity_span.text = '';
                dexterity_span.appendHtml('Dexterity: ' + charmenu.dexterity.toString());
			}

			Element intelligence_span = menu.querySelector('#menu_intelligence');
			if (intelligence_span == null)
			{
				intelligence_span = new SpanElement();
                intelligence_span.attributes['id'] = 'menu_intelligence';
                intelligence_span.attributes['class'] = 'menu_stat_span';
                menu.append(intelligence_span);
			}
			else
			{
				intelligence_span.text = '';
                intelligence_span.appendHtml('Intelligence: ' + charmenu.intelligence.toString());
			}

			Element charisma_span = menu.querySelector('#menu_charisma');
			if (charisma_span == null)
			{
				charisma_span = new SpanElement();
                charisma_span.attributes['id'] = 'menu_charisma';
                charisma_span.attributes['class'] = 'menu_stat_span';
                menu.append(charisma_span);
			}
			else
			{
				charisma_span.text = '';
                charisma_span.appendHtml('Charisma: ' + charmenu.charisma.toString());
			}

			Element wisdom_span = menu.querySelector('#menu_wisdom');
			if (wisdom_span == null)
			{
				wisdom_span = new SpanElement();
                wisdom_span.attributes['id'] = 'menu_wisdom';
                wisdom_span.attributes['class'] = 'menu_stat_span';
                menu.append(wisdom_span);
			}
			else
			{
				wisdom_span.text = '';
                wisdom_span.appendHtml('Wisdom: ' + charmenu.wisdom.toString());
			}

			Element will_span = menu.querySelector('#menu_will');
			if (will_span == null)
			{
				will_span = new SpanElement();
                will_span.attributes['id'] = 'menu_will';
                will_span.attributes['class'] = 'menu_stat_span';
                menu.append(will_span);
			}
			else
			{
				will_span.text = '';
                will_span.appendHtml('Will: ' + charmenu.will.toString());
			}

//			Element dropdown = menu.querySelector('#menu_dropdown');
//			if (dropdown == null)
//			{
//				Element dropdown = new Element.nav();
//				dropdown.attributes['id'] = 'menu_dropdown';
//				dropdown.attributes['class'] = 'dropdown';
//				dropdown.style.float = 'Right';
//				dropdown.appendHtml("Jobs" + '<br');
//				dropdown_listen(dropdown);
//				menu.append(dropdown);
//			}
//			else
//			{
//				charmenu.clean_job_list.forEach( (elem)
//				{
//					Element droppiece = dropdown.querySelector('#menu_' + elem.data['name']);
//					if (droppiece == null)
//					{
//						droppiece = new Element.span();
//						droppiece.attributes['id'] = 'menu_' + elem.data['name'];
//						droppiece.attributes['class'] = 'droppiece';
//						droppiece_listen(droppiece);
//						dropdown.append(droppiece);
//					}
//					else
//					{
//						droppiece.text = elem.data['name'];
//					}
//				});
//			}


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
				map.appendHtml("&nbsp;&nbsp;&nbsp;");
			else
				map.appendHtml("&nbsp;" + elem.toString() + '&nbsp;');
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
//				Element dropdown = menu.querySelector('#menu_dropdown');
//   				if (dropdown != null)
//  				{
//   					dropdown.text = '';
// 					dropdown.appendHtml("Jobs" + '<br');
// 					charmenu.updateJoblist();
//    			}
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
		dropdown.onMouseEnter.listen( (event)
		{
			updateJobMenu();
		});
	}

	droppiece_listen(Element droppiece)
	{
		droppiece.onMouseDown.listen( (event)
		{
			Iterable new_job = charmenu.clean_job_list.where( (job) => job.data['name'] == droppiece.text);
			if (new_job.length == 1)
			{
				charmenu.job = new_job.first;
				charmenu.calendar.Update(charmenu.job, charmenu.rand);
			}
			else
				print("false job selector");
		});
	}

	updateJobMenu()
	{
		Element dropdown = menu.querySelector('#menu_dropdown');
		if (dropdown != null)
		{
			dropdown.text = '';
			dropdown.appendHtml("Jobs" + '<br');
			charmenu.updateJoblist();
		}
	}

	Future GameInit()
	{
		DivElement push;

		return new Future ( ()
			{
				body = document.querySelector('#main_row');
				index = new DivElement();
				charlist = new DivElement();
				map = new DivElement();
				menu = new DivElement();
				push = new DivElement();
			}).then( (event)
			{
				indexInit();
                listInit();
                mapInit();
                menuInit();
                push.attributes['class'] = "push";
//                body.append(push);
			});
	}

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

	Game()
	{
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