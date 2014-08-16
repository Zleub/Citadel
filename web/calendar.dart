part of citadel;

class Calendar
{
	Map			data;
	Completer	_completer;

	Future onLoad()
	{
		_completer = new Completer();
		HttpRequest.getString('data/calendar.json')
			.then( (String string)
			{
				data = JSON.decode(string);
				print(data);
				_completer.complete(this);
			})
			.catchError( (error)
			{
				_completer.completeError(error);
			});
		return _completer.future;
	}
}