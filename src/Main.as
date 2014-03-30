package
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	import flash.system.WorkerDomain;
	import flash.ui.Keyboard;
	
	import event.DataEventDispatcher;
	
	public class Main extends Sprite
	{
		[Embed(source="resource/WIFI_AIR_SOCKET.swf",mimeType="application/octet-stream")]
		private var threadClass:Class;
		
		private var _dataWorker:Worker;
		private var _mainToWorkerChannel:MessageChannel;
		private var _workerToMainChannel:MessageChannel;
		
		public static var context:Stage;
		//private var _uiWorker:Worker;
		public function Main()
		{
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT;
			if(stage) init();
			else addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event=null):void
		{
			context=this.stage;
			stage.addEventListener(KeyboardEvent.KEY_DOWN,addMenuBackListenr);
			
			_dataWorker=WorkerDomain.current.createWorker(  new threadClass());
			_dataWorker.addEventListener(Event.WORKER_STATE,onWorkerState);
			_mainToWorkerChannel=Worker.current.createMessageChannel(_dataWorker);
			_workerToMainChannel=_dataWorker.createMessageChannel(Worker.current);
				
			_dataWorker.setSharedProperty("mainToWorker",_mainToWorkerChannel);
			_dataWorker.setSharedProperty("workerToMain",_workerToMainChannel);
			_dataWorker.start();
			var m:MainThread=new MainThread(_mainToWorkerChannel,_workerToMainChannel);
			this.addChild(m);	
		}
		
		private function addMenuBackListenr(e:KeyboardEvent):void
		{
			if(e.keyCode==Keyboard.BACK){
				e.preventDefault();
				DataEventDispatcher.dispatchEvent(new Event("BACK"));
			}
		}
		
		protected function onWorkerState(event:Event):void
		{
			trace(_dataWorker.state);
		}
		public static function show(str:String):void
		{
			
		}
	}
}