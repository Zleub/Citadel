library citadel;

import 'dart:html';

part 'game.dart';

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
