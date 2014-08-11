part of citadel;

class Game
{
	Player				player;
	Calendar			calendar;

	BodyElement			body;
	DivElement			index;
	DivElement			list;

	indexCreate()
	{
		index.appendHtml('Hi.<br>What\'s your name ?<br>');
		index.appendHtml('<input id="index" autofocus>');
		index.attributes['class'] = 'index';
    	body.append(index);
	}

	createList()
	{
		new Future( () { list = new Element.div(); })
		..then( (event) {
			list.attributes['id'] = 'charlist';
			list.attributes['class'] = 'charlist';
			player.char_list.forEach( (character)
			{
					list.appendHtml('<br>' + character.toString());
			});
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
		if (player.checkMinLevel(5) == true
				&& player.checkChar('Isaac') == false)
        {
   				player.char_list.add(new Character('Isaac'));
       	}
	}

	runGame(Timer)
	{
		index.remove();
		Future future = new Future(createList)
		..then( (event)
		{
			DivElement	div;
			new Future( () { div = document.querySelector('#charlist'); })
			..then( (event)
			{
				if (div != null)
					div.replaceWith(list);
				else
					body.append(list);
				player.char_list.forEach( (elem) => elem.Increment());
				player.char_list.forEach( (elem) => elem.updateCalendar());
				eventVendredi();
			});
		});
	}

	Game()
	{
		body = document.querySelector('body');

		new Future( () { index = new Element.div(); })
		..then( (event) {
			indexCreate();
			InputElement input = document.querySelector('#index');
	    	input.onChange.listen( (event)
	    	{
				player = new Player(input.value);
				index.text = "Loading";

//						print(calendar.datalist.);
						new Timer.periodic(new Duration(milliseconds: 80), runGame);
			});
	  	});
	}
}