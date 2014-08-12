library citadel;

import 'dart:core';
import 'dart:html';
import 'dart:math';
import 'dart:convert';
import 'dart:async';
import 'package:crypto/crypto.dart';

part 'game.dart';
part 'calendar.dart';
part 'player.dart';
part 'character.dart';

void main()
{
	HttpRequest.getString('data/biomes.json')
		.then( (String string)
		{
			Map data = JSON.decode(string);
			print(data['citadel'][0]);
		});


//	new Game();
}
