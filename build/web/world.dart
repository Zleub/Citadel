part of citadel;

class World
{
	int				sizeWorld = 15;
	Player			player;
	List<Biome>		mapWorld;
	Completer		_completer;
	Map				data;

	World(Player this.player);

	getWilderness(List<Map> citadel)
	{
		Iterable 	wilderness;

		wilderness = citadel.where( (elem)
		{
			if (elem['requirement'] == 'none')
				return true;
			else
				return false;
		});
		if (wilderness.length == 1)
			return new Biome (wilderness.first);
		else
			return null;
	}

	getMountain()
   	{
   		Iterable 	mountain;

   		List<Map> ground = data['ground'];
   		mountain = ground.where( (elem)
   		{
   			if (elem['shape'] == 'mountain')
   				return true;
   			else
   				return false;
   		});
   		if (mountain.length == 1)
   			return new Biome (mountain.first);
   		else
   			return null;
   	}

	getfillbiome(List<Map> ground)
   	{
   		Iterable 	fillbiome;

   		fillbiome = ground.where( (elem)
   		{
   			if (elem['shape'] == 'fill')
   				return true;
   			else
   				return false;
   		});
   		if (fillbiome.length == 1)
   		{
   			return (new Biome (fillbiome.first));
   		}
   		else
   			return null;
   	}

	drawCircle(int x, int y, int bonus, Map biome)
	{
		int		i;
		int		j;
		int		radius;

		radius = player.char_list.first.getRand(2) + bonus;
		j = -radius;
		mapWorld[x + y * sizeWorld] = new Biome(biome);
		while (j <= radius)
		{
			i = -radius;
			while (i <= radius)
			{
				if (i*i + j*j <= radius * radius + radius * 0.8
                        && (i + x) + (j + y) * sizeWorld >= 0
                        && (i + x) + (j + y) * sizeWorld < sizeWorld * sizeWorld
                        && mapWorld[(i + x) + (j + y) * sizeWorld] == null)
				{
					mapWorld[(i + x) + (j + y) * sizeWorld] = new Biome(biome);
				}
				i += 1;
			}
			j += 1;
		}
	}

	drawMCircle(List map, int x, int y, int bonus, int index)
    	{
    		int		i;
    		int		j;
    		int		radius;

    		radius = bonus;
    		j = -radius;
    		while (j <= radius)
    		{
    			i = -radius;
    			while (i <= radius)
    			{
    				if (i*i + j*j <= radius * radius + radius * 0.8
                            && (i + x) + (j + y) * sizeWorld >= 0
                            && (i + x) + (j + y) * sizeWorld < sizeWorld * sizeWorld)
    				{
    					map[(i + x) + (j + y) * sizeWorld] = index;
    				}
    				i += 1;
    			}
    			j += 1;
    		}
    	}


	drawMountain()
	{
		List<int> tmp;

		tmp = new List(sizeWorld * sizeWorld);
		int		i = 0;
		while(i < sizeWorld * sizeWorld)
		{
			tmp[i] = 0;
			i += 1;
		}
		i = 1;
		int		biomeNbr = player.char_list.first.getRand(3) + 1;
   		while (biomeNbr != 0)
  		{
   			int		x = player.char_list.first.getRand(sizeWorld);
       		int		y = player.char_list.first.getRand(sizeWorld);
           	drawMCircle(tmp, x, y, 7, i);
           	biomeNbr -= 1;
   		}
   		print(tmp);
   		while(i < sizeWorld * sizeWorld)
        {
   			if ((i + 1 < sizeWorld * sizeWorld && tmp[i] != tmp[i + 1]
   					&& i + sizeWorld < sizeWorld * sizeWorld && tmp[i] != tmp[i + sizeWorld])
   				|| (i - 1 >= 0 && tmp[i] != tmp[i - 1]
	   				&& i - sizeWorld >= 0 && tmp[i] != tmp[i - sizeWorld])
   				|| (i + 1 < sizeWorld * sizeWorld && tmp[i] != tmp[i + 1]
   					&& i - sizeWorld >= 0 && tmp[i] != tmp[i - sizeWorld])
   				|| (i - 1 >= 0 && tmp[i] != tmp[i - 1]
   					&& i + sizeWorld < sizeWorld * sizeWorld && tmp[i] != tmp[i + sizeWorld]))
   			{
				mapWorld[i] = getMountain();
   			}
   			i += 1;
        }
	}

	drawCitadel()
	{
		List<Map>	citadel = data['citadel'];

		Biome	wilderness = getWilderness(citadel);
		mapWorld[(sizeWorld * sizeWorld) ~/ 2] = wilderness;
	}

	drawWater()
	{
		List<Map>	water = data['water'];

   		int		biomeNbr = player.char_list.first.getRand(6) + sizeWorld ~/ 10;
   		while (biomeNbr != 0)
   		{
   			int		x = player.char_list.first.getRand(sizeWorld);
       		int		y = player.char_list.first.getRand(sizeWorld);
           	int		biome = player.char_list.first.getRand(water.length);
//           	if (mapWorld[x + y * sizeWorld] == null)
           		drawCircle(x, y, 1, water[biome]);
           	biomeNbr -= 1;
   		}
	}

	drawGround()
	{
		List<Map>	ground = data['ground'];

        Iterable _ground = ground.where( (elem) => elem['shape'] != 'fill' && elem['shape'] != 'mountain');
        int biomeNbr = player.char_list.first.getRand(6) + sizeWorld ~/ 5;
        while (biomeNbr != 0)
        {
        	int		x = player.char_list.first.getRand(sizeWorld);
            int		y = player.char_list.first.getRand(sizeWorld);
            int		biome = player.char_list.first.getRand(_ground.length);
//            if (mapWorld[x + y * sizeWorld] == null)
            	drawCircle(x, y, 2, _ground.elementAt(biome));
            biomeNbr -= 1;
        }
	}

	Future fillmap()
	{
		return new Future ( ()
		{
			drawMountain();
			drawCitadel();
			drawWater();
			drawGround();
            int i;
            i = 0;
			while (i < sizeWorld * sizeWorld)
			{
	           	if (mapWorld[i] == null)
	           		mapWorld[i] = getfillbiome(data['ground']);
	           	i += 1;
			}
		});
	}

	Future onLoad()
	{
		_completer = new Completer();
		mapWorld = new List(sizeWorld * sizeWorld);

		HttpRequest.getString('data/biomes.json')
			.then( (String string)
			{
				data = JSON.decode(string);
				fillmap().then( (event)
				{
						_completer.complete(this);
				});
			})
			.catchError( (error)
   			{
   				_completer.completeError(error);
   			});
   		return _completer.future;
	}
}