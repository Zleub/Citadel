part of citadel;

class Screen
{
  Completer     _completer;
  Element       canvas;

  Future onLoad()
  {
    _completer = new Completer();
    canvas = new Element.canvas()
    	..onLoad.listen( (event)
    {
      return _completer.isCompleted;
    });
    return _completer.future;
  }
}