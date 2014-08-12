part of citadel;

class Game
{
	Player				player;
	Calendar			calendar;

	BodyElement			body;
	DivElement			index;
	DivElement			charlist;
	CanvasElement		map;

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
		map.attributes['height'] = '500px';
		map.attributes['width'] = '500px';
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
		if (player.checkMinLevel(5) == true
   				&& player.checkChar('Nadours') == false)
        {
			player.char_list.add(new Character('Nadours'));
        }
		if (player.checkMinLevel(5) == true
        		&& player.checkChar('Mathours') == false)
        {
        	player.char_list.add(new Character('Mathours'));
        }
        if (player.checkMinLevel(5) == true
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

//	printMap(Timer)
//	{
//		charlist.hidden = true;
//		new Future( () { mapWrite(); })
//	}

	Game()
	{
		body = document.querySelector('body');

		new Future( () { index = new DivElement(); charlist = new DivElement(); map = new CanvasElement(); })
		..then( (event)
		{
			indexInit();
			listInit();
			mapInit();
			InputElement input = document.querySelector('#index');
	    	input.onChange.listen( (event)
	    	{
				player = new Player(input.value);
				index.text = "Loading";
				new Timer.periodic(new Duration(milliseconds: 80), runGame);
			});
	  	});
	}
}