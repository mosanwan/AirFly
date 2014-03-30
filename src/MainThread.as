package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.MessageChannel;
	
	import data.GlobalData;
	
	import scene.SceneMgr;
	
	public class MainThread extends Sprite
	{
		private static  var threadToMe:MessageChannel;
		private static var meToThread:MessageChannel;
		public function MainThread(c1:MessageChannel,c2:MessageChannel){
			threadToMe=c2;
			meToThread=c1;
			threadToMe.addEventListener(Event.CHANNEL_MESSAGE,onThreadMessage);
			
		}
		public function init():void
		{
			GlobalData.getInstance();
			SceneMgr.getInstance().init();
			
		}
		/**向数据线程发送数据*/
		public static function sendToThread(data:Object):void
		{
			meToThread.send(data);
		}
		
		private function onThreadMessage(event:Event):void //当线程发送数据时调试
		{
			trace(threadToMe.receive()=="threadReay")
			{
				init();
			}
			
		}
	}
}