package p2p
{
	import flash.events.Event;
	
	import event.DataEventDispatcher;
	
	import org.sanwu.wifi.WifiANE;
	import org.sanwu.wifidirect.WifiDirectAne;
	import org.sanwu.wifidirect.events.WifiDirectConnectEvent;
	import org.sanwu.wifidirect.events.WifiDirectConnectionInfoEvent;
	import org.sanwu.wifidirect.events.WifiDirectFetchOthersEvent;
	import org.sanwu.wifidirect.events.WifiDirectGroupEvent;
	import org.sanwu.wifidirect.events.WifiDirectP2pStateChangeEvent;
	import org.sanwu.wifidirect.events.WifiDirectPeersChangedEvent;
	import org.sanwu.wifidirect.events.WifiDirectThisDeviceInfoEvent;
	

	public class P2PManager
	{
		private static var _ins:P2PManager;	
		public static function getInstance():P2PManager
		{
			if(!_ins) _ins=new P2PManager();
			return _ins;
		}
		private var context:WifiDirectAne;
		private var context2:WifiANE;//测试用
		public static var ownerAdress:String;
		public static var isOwner:Boolean;
		public function init():void
		{
			context=new WifiDirectAne();
			context.addEventListener(WifiDirectP2pStateChangeEvent.WIFI_P2P_STATE_CHANGED,onWifiStateChange);
			context.addEventListener(WifiDirectPeersChangedEvent.WIFI_P2P_PEERS_CHANGE,onPeerStateChange);
			context.addEventListener(WifiDirectFetchOthersEvent.FETCH_RESPONEDS,onFetchOtherState);
			context.addEventListener(WifiDirectConnectionInfoEvent.CONNECTION_INFO,onConnectInfo);
			context.addEventListener(WifiDirectConnectEvent.CONNECT_OTHER,onConnectOthers);
			context.addEventListener(WifiDirectConnectEvent.DIS_CONNECT_OTHER,onDisConnect);
			context.addEventListener(WifiDirectGroupEvent.CREATE_GROUP,onCreateGroup);
			context.addEventListener(WifiDirectGroupEvent.REMOVE_GROUP,onRemoveGroup);
			context.addEventListener(WifiDirectThisDeviceInfoEvent.THIS_DEVICE_INFO,onThisDevice);
			
			context.initP2pManager();
			
			context2=new WifiANE();
			trace("我的IP地址"+context2.getIpAdress());
		}
		public function disConnect():void
		{
			context.disConnect();
		}
		public function removeGroup():void
		{
			context.removeGroup();
		}
		public function createGroup():void
		{
			context.createGroup();
		}
		public function search():void
		{
			context.disCoverOthers();
		}
		public function connectTo(index:int):void
		{
			context.connect(index);
		}
		protected function onThisDevice(e:WifiDirectThisDeviceInfoEvent):void
		{
			var evt:WifiDirectThisDeviceInfoEvent=new WifiDirectThisDeviceInfoEvent(WifiDirectThisDeviceInfoEvent.THIS_DEVICE_INFO);
			evt.thisDeviceName=e.thisDeviceName;
			evt.thisDeviceAdress=e.thisDeviceAdress;
			evt.thisDeviceState=e.thisDeviceState;
			trace("返回本机信息 "+e.thisDeviceName+"  "+e.thisDeviceAdress+" "+e.thisDeviceState);
			DataEventDispatcher.dispatchEvent(evt);
			
		}
		protected function onRemoveGroup(e:WifiDirectGroupEvent):void
		{
			var evt:WifiDirectGroupEvent=new WifiDirectGroupEvent(WifiDirectGroupEvent.REMOVE_GROUP);
			evt.result=e.result;
			DataEventDispatcher.dispatchEvent(evt);
			trace("移除网络组结果 "+e.result);
		}
		
		protected function onCreateGroup(e:WifiDirectGroupEvent):void
		{
			trace("创建网络组结果 "+e.result);
			var evt:WifiDirectGroupEvent=new WifiDirectGroupEvent(WifiDirectGroupEvent.CREATE_GROUP);
			evt.result=e.result;
			DataEventDispatcher.dispatchEvent(evt);
		}
		
		protected function onDisConnect(e:WifiDirectConnectEvent):void
		{
			trace("断开连接结果 "+e.result);
			var evt:WifiDirectConnectEvent=new WifiDirectConnectEvent(WifiDirectConnectEvent.DIS_CONNECT_OTHER);
			evt.result=e.result;
			DataEventDispatcher.dispatchEvent(evt);
			
		}
		
		protected function onConnectOthers(e:WifiDirectConnectEvent):void
		{
			var evt:WifiDirectConnectEvent=new WifiDirectConnectEvent(WifiDirectConnectEvent.CONNECT_OTHER);
			evt.result=e.result;
			DataEventDispatcher.dispatchEvent(evt);
		}
		
		protected function onConnectInfo(e:WifiDirectConnectionInfoEvent):void
		{
			var evt:WifiDirectConnectionInfoEvent=new WifiDirectConnectionInfoEvent(WifiDirectConnectionInfoEvent.CONNECTION_INFO);
			evt.isMeOwner=e.isMeOwner;
			evt.ownerAdress=e.ownerAdress;
			ownerAdress=e.ownerAdress;
			isOwner=e.isMeOwner;
			DataEventDispatcher.dispatchEvent(evt);
		}
		
		protected function onFetchOtherState(et:WifiDirectFetchOthersEvent):void
		{
			var evt:WifiDirectFetchOthersEvent=new WifiDirectFetchOthersEvent(WifiDirectFetchOthersEvent.FETCH_RESPONEDS);
			evt.responds=et.responds;
			DataEventDispatcher.dispatchEvent(evt);
		}
		
		protected function onPeerStateChange(e:WifiDirectPeersChangedEvent):void //
		{
			trace("peer state change");
			var evt:WifiDirectPeersChangedEvent=new WifiDirectPeersChangedEvent(WifiDirectPeersChangedEvent.WIFI_P2P_PEERS_CHANGE);
			for (var i:int = 0; i < e.peers.length; i++) 
			{
				evt.peers.push(e.peers[i]);
				//trace(e.peers[i].deviceName+e.peers[i].deviceAdress);
			}
			
			DataEventDispatcher.dispatchEvent(evt);
		}
		
		protected function onWifiStateChange(e:WifiDirectP2pStateChangeEvent):void
		{
			
			var evt:WifiDirectP2pStateChangeEvent=new WifiDirectP2pStateChangeEvent(WifiDirectP2pStateChangeEvent.WIFI_P2P_STATE_CHANGED);
			evt.p2pEnable=e.p2pEnable;
			DataEventDispatcher.dispatchEvent(evt);
		}
	}
}