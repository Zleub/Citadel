part of citadel;

class Job
{
	Completer	_completer;
	String		name;
	String		location;

	Map			data;

	Future onLoad()
	{
		_completer = new Completer();

   		HttpRequest.getString('data/rover.json')
   			.then( (String string)
   			{
				data = JSON.decode(string);
				_completer.complete(this);
   			})
   			.catchError( (error)
   			{
   				_completer.completeError(error);
   			});
   		return _completer.future;
	}
}