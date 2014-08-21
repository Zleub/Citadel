part of citadel;

class Index extends DivElement
{
	Index()
	{
		this.appendHtml('Hi.<br>What\'s your name ?<br>');
		this.appendHtml('<input id="index" autofocus>');
	}
}