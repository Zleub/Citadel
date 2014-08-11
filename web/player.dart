part of citadel;

class Player
{
	String			name;
	List<Character>	char_list;

	checkMinLevel(int level)
	{
		return char_list.any( (elem)
		{
			if (elem.level != null && elem.level >= level)
				return true;
			else
				return false;
		});
	}

	checkChar(String name)
	{
		return char_list.any((elem)
		{
			if (elem.name != null && elem.name == name)
   				return true;
			else
				return false;
		});
	}

	Player(String this.name)
	{
		char_list = new List();
		char_list.add(new Character(name));
	}
}