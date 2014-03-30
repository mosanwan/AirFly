package socketConnection.server.std
{
	import flash.net.Socket;

	public class Client
	{
		public var mac:String;
		public var nickName:String;
		public var isConnect:Boolean;
		public var socket:Socket;
		public var ip:String;
		public var room:Room=null;
		public var isRoomMaster:Boolean=false;
		public function Client()
		{
		}
	}
}