package view.ui
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import data.GlobalData;
	
	import event.DataEventDispatcher;
	
	import scene.GameHallScene;
	import scene.SceneMgr;
	
	import socketConnection.SocketManager;
	
	import tools.QREvent;
	import tools.QRreader;

	public class ConnectToServerPan extends AutoScaleUI
	{
		private var bg:Background01;
		private var adressInput:TextField;
		private var portInput:TextField;
		private var connectBtn:Button01;
		private var cancelBtn:Button01;
		private var qrBtn:QRcodeLogo;
		private var qrReader:QRreader;
		public function ConnectToServerPan()
		{
			super();
			bg=new Background01();
			addChild(bg);
			var tf:TextFormat=new TextFormat("微软雅黑",30);
			adressInput=new TextField();
			adressInput.defaultTextFormat=tf;
			adressInput.width=500;
			adressInput.border=true;
			adressInput.type=TextFieldType.INPUT;
			adressInput.borderColor=0x33CCCC;
			adressInput.text="192.168.0.102";
			this.addChild(adressInput);
			
			portInput=new TextField();
			portInput.defaultTextFormat=tf;
			portInput.border=true;
			portInput.width=500;
			portInput.borderColor=0x33CCCC;
			portInput.type=TextFieldType.INPUT;
			portInput.text="8650";
			this.addChild(portInput);
			
			connectBtn=new Button01("Connect");
			this.addChild(connectBtn);
			connectBtn.addEventListener(MouseEvent.CLICK,onConnect);
			
			
			cancelBtn=new Button01("Cancel");
			this.addChild(cancelBtn);
			cancelBtn.addEventListener(MouseEvent.CLICK,onCancel);
			
			qrBtn=new QRcodeLogo();
			qrBtn.width=100;
			qrBtn.height=100;
			this.addChild(qrBtn);
			qrBtn.addEventListener(MouseEvent.CLICK,onQrCode);
			DataEventDispatcher.addEventListener(SocketManager.CONNECT_TO_SERVER_SUCCESS,onConnectSucess);
			setScaleSize(0.6,0.6);
			
		}
		
		protected function onQrCode(event:MouseEvent):void
		{
			qrReader=new QRreader();
			qrReader.init(400,400);
			this.addChild(qrReader);
			qrReader.x=-this.x;
			qrReader.y=-this.y;
			DataEventDispatcher.addEventListener(QREvent.QR_SUCCESS,onQrScueess);
		}
		
		private function onQrScueess(e:QREvent):void
		{
			if(qrReader)
			{
				this.removeChild(qrReader);
				qrReader=null;
				adressInput.text=e.address;
				portInput.text=e.port.toString();
			}
			
		}
		
		private function onConnectSucess(e:Event):void
		{
			connectBtn.removeEventListener(MouseEvent.CLICK,onConnect);
			cancelBtn.removeEventListener(MouseEvent.CLICK,onCancel);
			DataEventDispatcher.removeEventListener(SocketManager.CONNECT_TO_SERVER_SUCCESS,onConnectSucess);
			GlobalData.serverAdress=adressInput.text;
			GlobalData.serverPort=int(portInput.text);
			this.parent.removeChild(this);
			SceneMgr.getInstance().gotoScene(GameHallScene);
		}
		
		protected function onCancel(event:MouseEvent):void
		{
			connectBtn.removeEventListener(MouseEvent.CLICK,onConnect);
			cancelBtn.removeEventListener(MouseEvent.CLICK,onCancel);
			
			this.parent.removeChild(this);
		}
		
		protected function onConnect(event:MouseEvent):void
		{
			SocketManager.getInstance().initAsClient(adressInput.text,int(portInput.text));
		}
		override public function setScaleSize(sw:Number, sh:Number):void
		{
			bg.width=GlobalData.gameWidth*sw;
			bg.height=GlobalData.gameHeight*sh;
			
			connectBtn.setScaleSize(0.2,0.1);
			cancelBtn.setScaleSize(0.2,0.1);
			connectBtn.move((bg.width/2)+30,bg.height-connectBtn.height-40);
			cancelBtn.move((bg.width/2)-cancelBtn.width-30,connectBtn.y);
			
			adressInput.x=bg.width-adressInput.width>>1;
			adressInput.y=60;
			
			portInput.x=adressInput.x;
			portInput.y=adressInput.y+adressInput.height+30;
			
			qrBtn.x=bg.width-qrBtn.width-10;
			qrBtn.y=10;
		}
	}
}