package socketConnection
{
	import socketConnection.client.MainClient;
	import socketConnection.server.MainServer;
	
	public class SocketManager
	{
		private static var _ins:SocketManager;
		public static function getInstance():SocketManager
		{
			if(!_ins) _ins=new SocketManager();
			return _ins;
		}
		public static const SERVER_INIT_SUCCESS:String="ServerInitSucess";
		public static const CONNECT_TO_SERVER_SUCCESS:String="CONNECT_TO_SERVER_SUCCESS";
		public var server:MainServer;
		public var client:MainClient;
		public function SocketManager()
		{
			
		}
		public function initAsServer(adress:String,port:int):void{
			server=new MainServer(adress,port);
		}
		public function initAsClient(adress:String,port:int):void
		{
			client=new MainClient(adress,port);
		}
	}
}