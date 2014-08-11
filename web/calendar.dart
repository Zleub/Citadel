part of citadel;

class Calendar
{
	List<Map>	datalist;
	Completer	_completer;

	Future onLoad()
	{
		_completer = new Completer();
		datalist = new List();
		HttpRequest.getString('data/calendar.json')
			.then( (String string)
			{
				int			i;
				Map			data;

				i = 0;
				string.split('\n').forEach( (elem)
				{
					if (elem[0] != '{' && elem[0] != '}')
					{
						data = JSON.decode('{' + elem.replaceFirst(',', '') + '}');
						datalist.add(data);
					}
					i += 1;
				});
				_completer.complete(this);
			})
			.catchError( (error)
			{
				_completer.completeError(error);
			});
		return _completer.future;
	}
}