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
		charlist.text = '';
		player.char_list.forEach( (character)
		{
			charlist.appendHtml('<br>' + character.toString());
		});
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
				map.appendHtml("&nbsp;" + elem.toString() + "&nbsp;");
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
		ElementList test = document.querySelectorAll('.character');
   		test.forEach( (Element elem)
   		{
   			elem.onMouseMove.listen( (event)
   			{
   				Iterable test = player.char_list.where( (char) => char.name == elem.text );
				if (test.length == 1)
				{
					charmenu = test.first;
					menu.hidden = false;
				}
   			});

   			elem.onMouseLeave.listen( (event)
  			{
   				Iterable test = player.char_list.where( (char) => char.name == elem.text );
  				if (test.length == 1)
   				{
   					menu.hidden = true;
   				}
   			});
   		});
	}

	menuWrite()
	{
		menu.text = '';
		if (charmenu != null)
		{
			menu.appendHtml(charmenu.name + '<br>');
			menu.appendHtml(charmenu.state.keys.first + '<br>');
			menu.appendHtml('strength: ' + charmenu.strength.toString() + '<br>');
			menu.appendHtml('stamina: ' + charmenu.stamina.toString() + '<br>');
			menu.appendHtml('agility: ' + charmenu.agility.toString() + '<br>');
			menu.appendHtml('dexterity: ' + charmenu.dexterity.toString() + '<br>');
			menu.appendHtml('intelligence: ' + charmenu.intelligence.toString() + '<br>');
			menu.appendHtml('charisma: ' + charmenu.charisma.toString() + '<br>');
			menu.appendHtml('wisdom: ' + charmenu.wisdom.toString() + '<br>');
			menu.appendHtml('will: ' + charmenu.will.toString() + '<br>');
		}
	}

	runGame(Timer)
	{
		index.remove();
		new Future( () { listWrite(); listen(); menuWrite(); })
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
					mapWrite();
					keyEvent();
					new Timer.periodic(new Duration(milliseconds: 80), runGame);

				});
	    	});
    	});
	}
}