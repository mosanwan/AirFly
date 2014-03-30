package scene
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import data.GlobalData;
	
	import event.DataEventDispatcher;
	
	import org.sanwu.wifidirect.WifiP2pDevice;
	import org.sanwu.wifidirect.events.WifiDirectConnectEvent;
	import org.sanwu.wifidirect.events.WifiDirectConnectionInfoEvent;
	import org.sanwu.wifidirect.events.WifiDirectFetchOthersEvent;
	import org.sanwu.wifidirect.events.WifiDirectGroupEvent;
	import org.sanwu.wifidirect.events.WifiDirectP2pStateChangeEvent;
	import org.sanwu.wifidirect.events.WifiDirectPeersChangedEvent;
	import org.sanwu.wifidirect.events.WifiDirectThisDeviceInfoEvent;
	
	import p2p.P2PManager;
	
	import view.ui.Button01;
	
	public class MultiPlayScene extends Sprite implements ISceneBase
	{

		private var _searchBtn:SearchButton;
		private var _isSearching:Boolean=false;
		private var _p2pStateLogo:WifiLogo;
		private var _peersList:PeersList;
		private var _invertBtn:InvertBtn;
		private var _myStatePan:MyNetInfoPan;
		private var _createRemoveNetGroupBtn:Button01;//
		private var _disConnectBtn:Button01;
		private var _startGameBtn:StartGameBtn;
		
		public function MultiPlayScene()
		{
			super();
		}
		
		public function init():void
		{
			trace("MuliPlayerMode");
			SceneMgr.getInstance().clearnPreScene();
			initUI();
			initP2p();
			initEvent();
		}
		
		private function initEvent():void
		{
			DataEventDispatcher.addEventListener("BACK",onBack);
			
			DataEventDispatcher.addEventListener(WifiDirectP2pStateChangeEvent.WIFI_P2P_STATE_CHANGED,onWifiStateChange);//P2P功能状态回调
			DataEventDispatcher.addEventListener(WifiDirectPeersChangedEvent.WIFI_P2P_PEERS_CHANGE,onPeerFind);//周末设备变更通知
			DataEventDispatcher.addEventListener(WifiDirectFetchOthersEvent.FETCH_RESPONEDS,onSearchBack);//搜索返回
			DataEventDispatcher.addEventListener(WifiDirectConnectionInfoEvent.CONNECTION_INFO,onConnectInfoData);//连接成功返回网络配置信息
			DataEventDispatcher.addEventListener(WifiDirectConnectEvent.CONNECT_OTHER,onConnectOther);//连接别人返回
			DataEventDispatcher.addEventListener(WifiDirectThisDeviceInfoEvent.THIS_DEVICE_INFO,onThisDevice);//本机信息返回
			DataEventDispatcher.addEventListener(WifiDirectGroupEvent.CREATE_GROUP,onCreateGroupHandler); //创建组结果
			DataEventDispatcher.addEventListener(WifiDirectGroupEvent.REMOVE_GROUP,onRemoveGroupHandler); //创建组结果
		}
		
		public function onBack(e:Event):void
		{
			SceneMgr.getInstance().gotoScene(ConnectionModeSelectScene);
		}
		
		private function onRemoveGroupHandler(e:WifiDirectGroupEvent):void
		{
			if(e.result)
			{
				if(_createRemoveNetGroupBtn)
				{
					_createRemoveNetGroupBtn.label="创建网络组";
				}
			}
		}
		
		private function onCreateGroupHandler(e:WifiDirectGroupEvent):void
		{
			if(e.result)
			{
				if(_createRemoveNetGroupBtn)
				{
					_createRemoveNetGroupBtn.label="移除网络组";
				}
			}
		}
		
		private function onThisDevice(e:WifiDirectThisDeviceInfoEvent):void
		{
			_myStatePan.deviceName.text=e.thisDeviceName;
			_myStatePan.deviceAdress.text=e.thisDeviceAdress;
			switch(e.thisDeviceState)
			{
				case WifiP2pDevice.CONNECTED:
					_myStatePan.netState.text="已连接";
					break;
			}
		}
		
		private function onConnectOther(e:WifiDirectConnectEvent):void
		{
			if(e.result)
			{
				if(_invertBtn)
				{
					this.removeChild(_invertBtn);
				}
			}else{
				
			}
		}
		
		private function onConnectInfoData(e:WifiDirectConnectionInfoEvent):void
		{
			_myStatePan.netState.text="已连接";
			if(e.isMeOwner)
			{
				_p2pStateLogo.gotoAndStop(2);
				_myStatePan.netGroupState.text="组长";
				_createRemoveNetGroupBtn.label="移除网络组";
			}else{
				_p2pStateLogo.gotoAndStop(3);
				_myStatePan.netGroupState.text="组员";
				_createRemoveNetGroupBtn.label="创建网络组";
			}
			
			startGame();
		}
		
		private function startGame():void
		{
			_startGameBtn=new StartGameBtn();
			_startGameBtn.width=GlobalData.gameWidth*0.14;
			_startGameBtn.height=GlobalData.gameHeight*0.1;
			_myStatePan.addChild(_startGameBtn);
			_startGameBtn.x=_myStatePan.width-_startGameBtn.width-10;
			_startGameBtn.y=_myStatePan.height-_startGameBtn.height-10;
			_startGameBtn.addEventListener(MouseEvent.CLICK,onStartGameHandle);
		}
		
		protected function onStartGameHandle(event:MouseEvent):void
		{
			SceneMgr.getInstance().gotoScene(GameHallScene);
		}
		
		private function onSearchBack(e:WifiDirectFetchOthersEvent):void
		{
			trace("Search responds"+e.responds);
			if(e.responds)
			{
				_searchBtn.play();
				_isSearching=true;
				
				//_peersList.addDevice("M2 T3",3,0);
				
			}else{
				_searchBtn.stop();
				_isSearching=false;
			}
		}
		
		private function onPeerFind(e:WifiDirectPeersChangedEvent):void
		{
			_peersList.clear();
			for (var i:int = 0; i < e.peers.length; i++) 
			{
				var p:WifiP2pDevice=e.peers[i];
				_peersList.addDevice(p.deviceName,p.deviceStatus,i);
			}
		}
		private function onWifiStateChange(e:WifiDirectP2pStateChangeEvent):void
		{
			if(e.p2pEnable)
			{
				_p2pStateLogo.gotoAndStop(1);
			}
		}
		private function initUI():void
		{
			_searchBtn=new SearchButton();
			_searchBtn.width=GlobalData.gameWidth*0.18;
			_searchBtn.height=GlobalData.gameHeight*0.1;
			this.addChild(_searchBtn);
			_searchBtn.x=GlobalData.gameWidth-_searchBtn.width-10;
			_searchBtn.y=10;
			SceneMgr.show(this);
			
			_searchBtn.addEventListener(MouseEvent.CLICK,onSearchBtnClick);
			
			
			_p2pStateLogo=new WifiLogo();
			_p2pStateLogo.width=GlobalData.gameWidth*0.08;
			_p2pStateLogo.height=0.08*GlobalData.gameHeight; 
			this.addChild(_p2pStateLogo);
			_p2pStateLogo.x=_searchBtn.x-_p2pStateLogo.width-10;
			_p2pStateLogo.y=10;
			
			_peersList=new PeersList();
			_peersList.width=GlobalData.gameWidth*0.5;
			_peersList.height=GlobalData.gameHeight*(1-20/GlobalData.gameHeight);
			this.addChild(_peersList);
			_peersList.x=10;
			_peersList.y=10;
			_peersList.addEventListener(DeviceClickEvent.DEVICE_LABEL_CLICK,onDeviceClick);
			
			_myStatePan=new MyNetInfoPan();
			_myStatePan.width=GlobalData.gameWidth*0.48;
			_myStatePan.height=GlobalData.gameHeight*0.88;
			_myStatePan.x=GlobalData.gameWidth-_myStatePan.width-10;
			_myStatePan.y=GlobalData.gameHeight-_myStatePan.height-10;
			this.addChild(_myStatePan);
		
			
			if(P2PManager.isOwner)
			{
				_createRemoveNetGroupBtn=new Button01("移除网络组");
			}else{
				_createRemoveNetGroupBtn=new Button01("创建网络组");
			}
			_createRemoveNetGroupBtn.setScaleSize(0.14,0.1);
			_myStatePan.addChild(_createRemoveNetGroupBtn);
			_createRemoveNetGroupBtn.move(10,_myStatePan.height-_createRemoveNetGroupBtn.height-10);
			_createRemoveNetGroupBtn.addEventListener(MouseEvent.CLICK,onCreateOrRemoveGroup);
			
			_disConnectBtn=new Button01("断开连接");
			_disConnectBtn.setScaleSize(0.14,0.1);
			_myStatePan.addChild(_disConnectBtn);
			_disConnectBtn.move(_createRemoveNetGroupBtn.x+_createRemoveNetGroupBtn.width+10,_createRemoveNetGroupBtn.y);
			_disConnectBtn.addEventListener(MouseEvent.CLICK,onDisConnect);
		}
		
		protected function onDisConnect(event:MouseEvent):void
		{
			P2PManager.getInstance().disConnect();
		}
		
		protected function onCreateOrRemoveGroup(e:MouseEvent):void
		{
			if(_createRemoveNetGroupBtn.label=="移除网络组")
			{
				P2PManager.getInstance().removeGroup();
			}else if(_createRemoveNetGroupBtn.label=="创建网络组"){
				P2PManager.getInstance().createGroup();
			}
			
		}
		
		protected function onDeviceClick(e:DeviceClickEvent):void
		{
			_invertBtn=new InvertBtn();
			_invertBtn.x=_peersList.width+10;
			_invertBtn.index=e.index;
			_invertBtn.y=e.dy;
			this.addChild(_invertBtn);
			
			_invertBtn.addEventListener(MouseEvent.CLICK,onInvert);
		}
		
		protected function onInvert(e:MouseEvent):void
		{
			var b:InvertBtn=e.target as InvertBtn;
			P2PManager.getInstance().connectTo(b.index);
		}
		
		protected function onSearchBtnClick(event:MouseEvent):void
		{
			if(!_isSearching)
			{
				_isSearching=true;
				P2PManager.getInstance().search();
			}
		}
		
		private function initP2p():void
		{
			P2PManager.getInstance().init();
			
		}
		public function remove():void
		{
			DataEventDispatcher.removeEventListener("BACK",onBack);
			DataEventDispatcher.removeEventListener(WifiDirectP2pStateChangeEvent.WIFI_P2P_STATE_CHANGED,onWifiStateChange);//P2P功能状态回调
			DataEventDispatcher.removeEventListener(WifiDirectPeersChangedEvent.WIFI_P2P_PEERS_CHANGE,onPeerFind);//周末设备变更通知
			DataEventDispatcher.removeEventListener(WifiDirectFetchOthersEvent.FETCH_RESPONEDS,onSearchBack);//搜索返回
			DataEventDispatcher.removeEventListener(WifiDirectConnectionInfoEvent.CONNECTION_INFO,onConnectInfoData);//连接成功返回网络配置信息
			DataEventDispatcher.removeEventListener(WifiDirectConnectEvent.CONNECT_OTHER,onConnectOther);//连接别人返回
			DataEventDispatcher.removeEventListener(WifiDirectThisDeviceInfoEvent.THIS_DEVICE_INFO,onThisDevice);//本机信息返回
			DataEventDispatcher.removeEventListener(WifiDirectGroupEvent.CREATE_GROUP,onCreateGroupHandler); //创建组结果
			DataEventDispatcher.removeEventListener(WifiDirectGroupEvent.REMOVE_GROUP,onRemoveGroupHandler); //创建组结果
			parent.removeChild(this);
			
		}
	}
}