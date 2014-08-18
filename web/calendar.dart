part of citadel;

class Calendar
{
	Map			data;
	List<Map>	calendar;
	Completer	_completer;

	Future Update(Job job, Random rand)
	{
		List<Map> spare_case = new List();
		List<Map> job_case;
		int			job_sum;

		return this.onLoad().then( (event)
		{
			job_sum = 0;
			job_case = job.data['actions'];
			job_case.forEach( (elem)
			{
				job_sum += elem['time'];
			});
			print(job_sum);

			calendar.forEach( (elem)
			{
				if (elem['name'] != 'Spare')
					spare_case.add(elem);
				else
				{
					int times = elem['time'] ~/ job_sum;
					while (times != 0)
					{
						job_case.forEach( (Map elem)
						{
							spare_case.add(new Map.from(elem));
						});
						job_case.shuffle(rand);
						times -= 1;
					}
				}
			});
			calendar = spare_case;
			calendar.forEach( (elem)
			{
				print(elem);
			});
		});
	}

	Future onLoad()
	{
		_completer = new Completer();
		HttpRequest.getString('data/calendar.json')
			.then( (String string)
			{
				data = JSON.decode(string);
//				print(data);

				calendar = data['calendar'];
//				calendar.forEach( (elem)
//				{
//					print (elem);
//				});
				_completer.complete(this);
			})
			.catchError( (error)
			{
				_completer.completeError(error);
			});
		return _completer.future;
	}
}