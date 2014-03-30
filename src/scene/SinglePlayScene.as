package scene
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	
	import data.GlobalData;
	
	import event.DataEventDispatcher;
	
	public class SinglePlayScene extends Sprite implements ISceneBase
	{
		private var _centerText:TextField;
		public function SinglePlayScene()
		{
			super();
		}
		
		public function init():void
		{
			trace("SinglePlayerMode");
			SceneMgr.getInstance().clearnPreScene();
			_centerText=new TextField();
			_centerText.defaultTextFormat=new TextFormat("微软雅黑",30,0x33cccc);
			_centerText.text="SingleMode not Available now!";
			_centerText.autoSize=TextFieldAutoSize.LEFT;
			this.addChild(_centerText);
			_centerText.x=GlobalData.gameWidth-_centerText.width>>1;
			_centerText.y=GlobalData.gameHeight-_centerText.height>>1;
			
			DataEventDispatcher.addEventListener("BACK",onBack);
			SceneMgr.show(this);
		}
		
		public function onBack(event:Event):void
		{
			SceneMgr.getInstance().gotoScene(GameModeSelectScene);
		}
		
		public function remove():void
		{
			this.parent.removeChild(this);
			this.removeChild(_centerText);
			_centerText=null;
		}
	}
}