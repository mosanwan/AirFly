package scene
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import data.GlobalData;
	
	import event.DataEventDispatcher;
	
	import socketConnection.client.ClientMsgDefine;
	import socketConnection.client.MainClient;
	
	import tools.zxing.BarcodeFormat;
	import tools.zxing.MultiFormatWriter;
	import tools.zxing.common.ByteMatrix;
	
	import view.ui.AutoScaleList;
	import view.ui.Button01;
	import view.ui.RoomLabel;
	
	public class GameHallScene extends Sprite implements ISceneBase
	{
		public function GameHallScene()
		{
			super();
		}
		
		private var serverInfoText:TextField;
		private var shareNetBtn:ShareNetBtn;
		private var shareBmp:Sprite;
		private var roomList:AutoScaleList;
		
		private var createRoomBtn:Button01;
		
		public function init():void
		{
			var format:TextFormat=new TextFormat("微软雅黑",30,0x33cccc,true);
			serverInfoText=new TextField();
			serverInfoText.defaultTextFormat=format;
			serverInfoText.autoSize=TextFieldAutoSize.LEFT;
			serverInfoText.text="服务器IP:"+GlobalData.serverAdress +"  端口:"+GlobalData.serverPort;
			this.addChild(serverInfoText);
			
			shareNetBtn=new ShareNetBtn();
			shareNetBtn.width=GlobalData.gameWidth*0.06;
			shareNetBtn.height=GlobalData.gameHeight*0.1;
			this.addChild(shareNetBtn);
			shareNetBtn.x=GlobalData.gameWidth-shareNetBtn.width-10;
			shareNetBtn.y=10;
			shareNetBtn.addEventListener(MouseEvent.CLICK,onShareMyNet);
			
			
			
			roomList=new AutoScaleList(RoomLabel);
			roomList.setScaleSize(0.5,0.96-(serverInfoText.height/GlobalData.gameHeight));
			roomList.y=GlobalData.gameHeight-roomList.height;
			roomList.x=10;
			
			this.addChild(roomList);
			
			//test
//			roomList.addData(new GameRoomData("M1",0,0,1));
//			roomList.addData(new GameRoomData("M2",0,0,1));
//			roomList.addData(new GameRoomData("M4",0,0,1));
//			roomList.addData(new GameRoomData("M5",0,0,1));
			
			
			createRoomBtn=new Button01("创建房间",0,60);
			createRoomBtn.setScaleSize(0.25,0.15);
			createRoomBtn.move(GlobalData.gameWidth/2+(GlobalData.gameWidth/2-createRoomBtn.width>>1),GlobalData.gameHeight-createRoomBtn.height>>1);
			this.addChild(createRoomBtn);
			createRoomBtn.addEventListener(MouseEvent.CLICK,onCreateRoom);
			DataEventDispatcher.addEventListener(ClientMsgDefine.GET_ROOM_LIST,onRoomListGet);
			
			shareBmp=new Sprite();  //二维码分享网络。要放在最上层所以要最后初始化
			addChild(shareBmp);
			shareBmp.x=GlobalData.gameWidth-400>>1;
			shareBmp.y=GlobalData.gameHeight-400>>1;
			shareBmp.addEventListener(MouseEvent.CLICK,onCloseShareBmp);
			
			SceneMgr.show(this);
			SceneMgr.getInstance().clearnPreScene();
		}
		
		private function onRoomListGet(e:Event):void
		{
			
		}
		
		protected function onCreateRoom(event:MouseEvent):void
		{
			MainClient.createRoom("TEst");
		}
		
		protected function onCloseShareBmp(event:MouseEvent):void
		{
			shareBmp.removeChildAt(0);
		}
		
		protected function onShareMyNet(event:MouseEvent):void
		{
			var textString:String =GlobalData.serverAdress+"."+GlobalData.serverPort;
			var matrix:ByteMatrix;
			var qrEncoder:MultiFormatWriter = new MultiFormatWriter();
			try
			{
				matrix = (qrEncoder.encode(textString,BarcodeFormat.QR_CODE,400,400)) as ByteMatrix;
			}
			catch (e:Error)
			{
				return;
			}
			var bmd:BitmapData = new BitmapData(400, 400, false, 0x808080);
			for (var h:int = 0; h < 400; h++)
			{
				for (var w:int = 0; w < 400; w++)
				{
					if (matrix._get(w, h) == 0)
					{
						bmd.setPixel(w, h, 0x000000);
					}
					else
					{
						bmd.setPixel(w, h, 0xFFFFFF);
					}        
				}
			}
			if(shareBmp.numChildren>0)
			{
				shareBmp.removeChildAt(0);
			}
			var bmp:Bitmap=new Bitmap(bmd);
			shareBmp.addChild(bmp);
		}
		public function onBack(e:Event):void
		{
			SceneMgr.getInstance().gotoScene(LocalNetGameScene);
		}
		public function remove():void
		{
			this.parent.removeChild(this);
			serverInfoText=null;
		}
	}
}