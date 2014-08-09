import 'dart:html';

create_canvas()
{
  Element elem = document.querySelector('body');
  Element new_elem = new Element.canvas();
  new_elem.setAttribute('height', elem.documentOffset.x);
  new_elem.setAttribute('width', elem.documentOffset.y);
  
  
  elem.insertAdjacentElement('beforeEnd', new_elem);
}

void main()
{
  create_canvas();
}
