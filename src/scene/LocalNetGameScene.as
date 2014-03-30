package scene
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import data.GlobalData;
	import data.threadConnnection.ThreadConnectData;
	
	import event.DataEventDispatcher;
	
	import socketConnection.SocketManager;
	
	import view.ui.Button01;
	import view.ui.ConnectToServerPan;
	
	public class LocalNetGameScene extends Sprite implements ISceneBase
	{
		public function LocalNetGameScene()
		{
			super();
		}
		
		private var createNetWork:Button01;
		private var joinOthers:Button01;
		
		public function init():void
		{
			createNetWork=new Button01("创建服务器",0x33CCCC,50);
			createNetWork.setScaleSize(0.3,0.2);
			createNetWork.move(GlobalData.gameWidth/2 - createNetWork.width-20,GlobalData.gameHeight-createNetWork.height>>1);
			this.addChild(createNetWork);
			
			createNetWork.addEventListener(MouseEvent.CLICK,onCreateServer);
			
			joinOthers=new Button01("加入服务器",0x33CCCC,50);
			joinOthers.setScaleSize(0.3,0.2);
			joinOthers.move(GlobalData.gameWidth/2+ 20,GlobalData.gameHeight-createNetWork.height>>1);
			this.addChild(joinOthers);
			joinOthers.addEventListener(MouseEvent.CLICK,onConnectToServer);
			
			DataEventDispatcher.addEventListener("BACK",onBack);
			DataEventDispatcher.addEventListener(SocketManager.CONNECT_TO_SERVER_SUCCESS,onConnectedToServer);
			
			SceneMgr.show(this);
			SceneMgr.getInstance().clearnPreScene();
			
		}
		
		private function onConnectedToServer(e:Event):void//连接服务器成功 进入房间场景
		{
			SceneMgr.getInstance().gotoScene(GameHallScene);
		}
		
		protected function onConnectToServer(event:MouseEvent):void
		{
			var pan:ConnectToServerPan=new ConnectToServerPan();
			pan.x=GlobalData.gameWidth-pan.width>>1;
			pan.y=GlobalData.gameHeight-pan.height>>1;
			this.addChild(pan);
			
			
		}
		
		protected function onCreateServer(event:MouseEvent):void
		{
			DataEventDispatcher.addEventListener(SocketManager.SERVER_INIT_SUCCESS,onServerCreated);
			SocketManager.getInstance().initAsServer(GlobalData.hostAdress,GlobalData.hostPort);
			
		}
		
		private function onServerCreated(e:Event):void
		{
			GlobalData.serverAdress=GlobalData.hostAdress;
			GlobalData.serverPort=GlobalData.hostPort;
			SocketManager.getInstance().initAsClient(GlobalData.serverAdress,GlobalData.serverPort);
			
			
		}
		
		public function onBack(e:Event):void
		{
			SceneMgr.getInstance().gotoScene(ConnectionModeSelectScene);
		}
		
		public function remove():void
		{
			parent.removeChild(this);
			this.removeChild(createNetWork);
			this.removeChild(joinOthers);
		}
	}
}