package socketConnection.server
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.net.ServerSocket;
	import flash.net.Socket;
	import flash.utils.Dictionary;
	
	import event.DataEventDispatcher;
	
	import socketConnection.ISocket;
	import socketConnection.SocketManager;
	import socketConnection.client.Client;
	import socketConnection.CustomBytes;

	/**
	 *author T
	 *2014-3-29上午1:36:19
	 */
	public class MainServer implements ISocket
	{
//		private static var ins:MainServer;
//		public static function getInstance():MainServer
//		{
//			if(!ins) ins=new MainServer();
//			return ins;
//		}
		public var clientList:Dictionary;
		private var serverSocket:ServerSocket;
		private var handler:ServerDataHandler;
		public function MainServer(adress:String,port:int)
		{
			serverSocket=new ServerSocket();
			serverSocket.addEventListener(ServerSocketConnectEvent.CONNECT,onClientConnect);
			clientList=new Dictionary();
			handler=new ServerDataHandler();
			init(adress,port);
		}
		public function init(adress:String,port:int):void{
			try
			{
				serverSocket.bind(port,adress);
				serverSocket.listen();
				DataEventDispatcher.dispatchEvent(new Event(SocketManager.SERVER_INIT_SUCCESS));
				trace("SOCKET服务器初始化成功");
			} 
			catch(error:Error) 
			{
				trace("SOCKET服务器初始化失败");
			}
		}
		protected function onClientConnect(e:ServerSocketConnectEvent):void
		{
			trace("客户端进行连接");
			var socket:Socket=e.socket;
			socket.addEventListener(ProgressEvent.SOCKET_DATA,onClientData);
			socket.addEventListener(Event.CLOSE,onClientClose);
			var client:Client=new Client();
			client.ip=socket.remoteAddress;
			clientList[socket]=client;
			socket.writeInt(0);
			socket.flush();
		}
		
		protected function onClientClose(e:Event):void
		{
			var socket:Socket=e.target as Socket;
			socket.removeEventListener(ProgressEvent.SOCKET_DATA,onClientData);
			socket.removeEventListener(Event.CLOSE,onClientClose);
			trace((clientList[socket] as Client).nickName+" 断开连接");
			delete clientList[e.target];
			
		}
		
		protected function onClientData(e:ProgressEvent):void
		{
			trace("客户端消息 ");
			var socket:Socket=e.target as Socket;
			handler.hand(socket,e.bytesLoaded);
		}
		
		
		
		public function send(data:CustomBytes):void
		{
			
		}
		public function receive(data:CustomBytes):void
		{
			
		}
	}
}