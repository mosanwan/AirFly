package scene
{
	import flash.events.Event;

	public interface ISceneBase 
	{
		
		 function init():void
	
		 function remove():void
		function onBack(e:Event):void;

	}
}