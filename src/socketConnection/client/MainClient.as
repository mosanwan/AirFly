package socketConnection.client
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	
	import event.DataEventDispatcher;
	
	import socketConnection.CustomBytes;
	import socketConnection.SocketManager;
	import socketConnection.server.ServerMsgDefine;

	/**
	 *author T
	 *2014-3-29上午1:36:30
	 */
	public class MainClient 
	{
		private static var socket:Socket;
		public function MainClient(adress:String,port:int)
		{
			socket=new Socket();
			socket.addEventListener(Event.CONNECT,onConnected);
			socket.addEventListener(ProgressEvent.SOCKET_DATA,onData);
			init(adress,port);
		}
		
		protected function onData(e:ProgressEvent):void
		{
			var socket:Socket=e.target as Socket;
			var data:CustomBytes=new CustomBytes();
			socket.readBytes(data);
			data.uncompress();
			CUPaker.hand(socket,data);
		}
		
		protected function onConnected(e:Event):void
		{
			DataEventDispatcher.dispatchEvent(new Event(SocketManager.CONNECT_TO_SERVER_SUCCESS));
		}
		public function init(adress:String,port:int):void{
			socket.connect(adress,port);
		}
		
		public static function createRoom(roomName:String):void  //创建一个房间
		{
			var bytes:CustomBytes=new CustomBytes();
			bytes.writeInt(ServerMsgDefine.CREATE_ROOM);
			bytes.writeCustomString(roomName);
			
			var sendData:CustomBytes=new CustomBytes();
			sendData.writeInt(bytes.length);
			sendData.writeBytes(bytes);
			sendData.compress();
			socket.writeBytes(sendData);
			socket.flush();
		}
	}
}