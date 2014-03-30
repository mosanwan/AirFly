package scene
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import data.GlobalData;
	
	import event.DataEventDispatcher;
	
	import view.ui.Button01;
	
	public class ConnectionModeSelectScene extends Sprite implements ISceneBase
	{
		public function ConnectionModeSelectScene()
		{
			super();
		}
		private var _localNetBtn:Button01;
		private var _internetBtn:Button01;
		private var _wifiDirectBtn:Button01;
		
		public function init():void
		{
			_localNetBtn=new Button01("局域网联机",null,50);
			_internetBtn=new Button01("互联网联机",null,50);
			_wifiDirectBtn=new Button01("WIFI-直联",null,50);
			
			var ws:Number=0.25;
			var hs:Number=0.2;
			_localNetBtn.setScaleSize(ws,hs);
			_internetBtn.setScaleSize(ws,hs);
			_wifiDirectBtn.setScaleSize(ws,hs);
			this.addChild(_localNetBtn);
			this.addChild(_internetBtn);
			this.addChild(_wifiDirectBtn);
			
			_internetBtn.move(GlobalData.gameWidth-_internetBtn.width>>1,GlobalData.gameHeight-_internetBtn.height>>1);
			_localNetBtn.move(_internetBtn.x-_localNetBtn.width-30,GlobalData.gameHeight-_internetBtn.height>>1);
			_wifiDirectBtn.move(_internetBtn.x+_internetBtn.width+30,GlobalData.gameHeight-_internetBtn.height>>1);
			
			_wifiDirectBtn.addEventListener(MouseEvent.CLICK,onWifi);
			_internetBtn.addEventListener(MouseEvent.CLICK,onInternet);
			_localNetBtn.addEventListener(MouseEvent.CLICK,onLocal);
			
			SceneMgr.show(this);
			SceneMgr.getInstance().clearnPreScene();
			
			DataEventDispatcher.addEventListener("BACK",onBack);
		}
		
		public function onBack(e:Event):void
		{
			SceneMgr.getInstance().gotoScene(GameModeSelectScene);	
		}
		
		protected function onLocal(event:MouseEvent):void
		{
			SceneMgr.getInstance().gotoScene(LocalNetGameScene);
		}
		
		protected function onInternet(event:MouseEvent):void
		{
			
		}
		
		protected function onWifi(event:MouseEvent):void
		{
			SceneMgr.getInstance().gotoScene(MultiPlayScene);
		}
		
		public function remove():void
		{
			_wifiDirectBtn.removeEventListener(MouseEvent.CLICK,onWifi);
			_localNetBtn=null;
			_internetBtn=null;
			_wifiDirectBtn=null;
			parent.removeChild(this);
		}
	}
}