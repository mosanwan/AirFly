package socketConnection.server
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.net.ServerSocket;
	import flash.net.Socket;
	
	import data.GlobalData;
	
	import event.DataEventDispatcher;
	
	import socketConnection.CustomBytes;
	import socketConnection.SocketManager;
	import socketConnection.server.std.Client;

	public class MainServer
	{
		private var  _serverSocket:ServerSocket;
		public function MainServer(adress:String,port:int)
		{
			_serverSocket=new ServerSocket();
			init(port);
		}
		public function init(port:int):void
		{
			Main.show("初始化服务器! 端口:"+port);
			if(_serverSocket.bound)
			{
				_serverSocket.close();
				_serverSocket=new ServerSocket();
				
				
			}
			try{
				_serverSocket.bind(port);
				_serverSocket.listen();
				_serverSocket.addEventListener(ServerSocketConnectEvent.CONNECT,onClientConnect);
				Main.show("初始化服务器成功 " +port);
				GlobalData.serverPort=port;
				DataEventDispatcher.dispatchEvent(new Event(SocketManager.SERVER_INIT_SUCCESS));
			}catch(er:Error){
				//如果报错 换端口重试
				Main.show("初始化服务器失败，开始重试");
				init(Math.random()*65520>>0)
			}
			
			
		}
		protected function onClientConnect(e:ServerSocketConnectEvent):void
		{
			var c:Client=new Client();
			c.socket=e.socket;
			c.nickName=e.socket.remoteAddress;
			c.ip=e.socket.remoteAddress;
			c.socket.addEventListener(ProgressEvent.SOCKET_DATA,onClientData);
			c.socket.addEventListener(Event.CLOSE,onClientClose);
			RemoteData.clientList[e.socket]=c;
			Main.show("客户端连接 "+c.ip);
			
		}
		
		protected function onClientData(e:ProgressEvent):void
		{
			var socket:Socket=e.target as Socket;
			var dat:CustomBytes=new CustomBytes();
			socket.readBytes(dat);
			//dat.uncompress();
			UPacker.hand(socket,dat);
		}
		
		protected function onClientClose(e:Event):void
		{
			var socket:Socket=e.target as Socket;
			Main.show("客户端断开连接 "+socket.remoteAddress);
			delete RemoteData.clientList[socket];
		}
	}
}