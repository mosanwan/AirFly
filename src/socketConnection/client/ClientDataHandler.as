package socketConnection.client
{
	import flash.net.Socket;
	
	import socketConnection.CustomBytes;
	import socketConnection.server.ServerMsgDefine;

	/**
	 *author T
	 *2014-3-29下午9:20:02
	 */
	public class ClientDataHandler
	{
		private static var _ins:ClientDataHandler;
		public static function getInstance():ClientDataHandler
		{
			if(!_ins)_ins=new ClientDataHandler();
			return _ins;
		}
		public function ClientDataHandler()
		{
		}
		public static function hand(socket:Socket,cByte:CustomBytes):void{
			var type:int=cByte.readInt();
			switch(type)
			{
				case ServerMsgDefine.GET_ROOM_LIST:
					doGetRoomList(cByte);
				break;
			}
		}
		
		private static function doGetRoomList(cByte:CustomBytes):void
		{
			var roomNum:int=cByte.readInt();
			for (var i:int = 0; i < roomNum; i++) 
			{
				var roomIndex:int=cByte.readInt();
				var roomName:String=cByte.readCustomString();
				trace("获得房间列表 索引 "+roomIndex +"  房间名  "+roomName);
			}
			
		}
	}
}