part of citadel;

class Game
{
	Player				player;
	Calendar			calendar;
	World				world;

	BodyElement			body;
	DivElement			index;
	DivElement			charlist;
	DivElement			map;

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

		document.querySelector('.character').onMouseOver.listen( (event)
		{
			print(event);
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
//		map.attributes['height'] = '500px';
//		map.attributes['width'] = '500px';
		map.hidden = true;
		body.append(map);
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
			if (player.char_list.first.getRand(100) == 0)
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

	runGame(Timer)
	{
		index.remove();
		new Future( () { listWrite(); })
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
			}).then( (event)
			{
				indexInit();
                listInit();
                mapInit();
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