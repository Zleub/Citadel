part of citadel;

class Game
{
	Player				player;
//	Game_Map			map;
//	List<Character>		char_list;

	Game()
	{
		Element body = document.querySelector('body');
		body.appendHtml('Game constructor: Hello World<br>');

		Element main = new Element.div();
		main.appendHtml('Hi.<br>What\'s your name ?<br>');
		main.appendHtml('<input id="input">');
		main.attributes['class'] = 'test';

		Element test = document.querySelector('#input');
		test.onInput.listen( (event)
		{
			main.appendHtml('delanderm<br>');
		});

		body.append(main);
	}
}