library citadel;

import 'dart:core';
import 'dart:html';
import 'dart:math';
import 'dart:convert';
import 'dart:async';
import 'package:crypto/crypto.dart';

part 'game.dart';
part 'calendar.dart';
part 'screen.dart';
part 'player.dart';
part 'character.dart';

create_canvas()
{
	Element elem = document.querySelector('body');
	Element new_elem = new Element.canvas();
	new_elem.setAttribute('height', '200');
	new_elem.setAttribute('width', '200');
	elem.children.add(new_elem);
}

void main()
{
	//	create_canvas();
	new Game();
}
