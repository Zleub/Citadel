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
//		map.attributes['height'] = '500px';
//		map.attributes['width'] = '500px';
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
//			print('character.print');
			character.Print();
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

	listen()
	{
		ElementList name_span = document.querySelectorAll('.name_span');
   		name_span.forEach( (Element elem)
   		{
   			elem.onClick.listen( (event)
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

   			elem.onMouseMove.listen( (event)
   			{
   				Iterable test = player.char_list.where( (char) => char.name == elem.text.trim() );
				if (test.length == 1)
				{
					charmenu = test.first;
					Element dropdown = menu.querySelector('#menu_dropdown');
       				if (dropdown != null)
      				{
       					dropdown.text = '';
     					dropdown.appendHtml("Jobs" + '<br');
        			}
					menu.hidden = false;
				}
   			});

   			elem.onMouseLeave.listen( (event)
  			{
   				if (click_bool == 0)
   				{
	   				menu.hidden = true;
//   					charlist.style.height = "100%";
   				}
   			});
   		});

   		ElementList droppiece_list = document.querySelectorAll('.droppiece');
   		droppiece_list.forEach( (Element elem)
   		{
   			elem.onMouseDown.listen( (event)
   			{
   				print(charmenu.clean_job_list);
   				Iterable new_job = charmenu.clean_job_list.where( (job) => job.data['name'] == elem.text);
   				if (new_job.length == 1)
   					charmenu.job = new_job.first;
   				else
   					print("false job selector");
   			});
   		});
	}

	runGame(Timer)
	{
		index.remove();
		new Future( () { listWrite(); listen(); menuWrite(); })
		..then( (event)
		{
			player.char_list.forEach( (elem) => elem.Increment());
			player.char_list.forEach( (elem) => elem.updateCalendar());
			player.char_list.forEach( (elem) => elem.updateJoblist());
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
					mapWrite();
					keyEvent();
					new Timer.periodic(new Duration(milliseconds: 80), runGame);

				});
	    	});
    	});
	}
}