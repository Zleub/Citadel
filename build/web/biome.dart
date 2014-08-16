part of citadel;

class Biome
{
	String	name;
	String	graphic;
	String	shape;

	Biome(Map biome)
	{
		name = biome['name'];
		graphic = biome['graphic'];
		shape = biome['shape'];
	}

	toString()
	{
		return ('<span class="' + name + '">' + graphic + '</span>');
	}
}