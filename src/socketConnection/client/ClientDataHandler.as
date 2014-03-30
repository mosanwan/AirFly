package socketConnection.client
{
	import flash.events.Event;
	import flash.net.Socket;
	
	import data.GlobalData;
	
	import event.DataEventDispatcher;
	
	import socketConnection.CustomBytes;
	import socketConnection.server.ServerMsgDefine;
	import socketConnection.server.std.Room;

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
				case ServerMsgDefine.CREATE_ROOM_RESULT:
					doCreateRoomResult(cByte);
					break;
			}
		}
		
		private static function doCreateRoomResult(cByte:CustomBytes):void//处理创建房间结果
		{
			var roomName:String=cByte.readCustomString();
			var roomIndex:int=cByte.readInt();
			DataEventDispatcher.dispatchEvent(
		}
		
		private static function doGetRoomList(cByte:CustomBytes):void
		{
			var roomNum:int=cByte.readInt();
			GlobalData.roolList=new Vector.<Room>();
			for (var i:int = 0; i < roomNum; i++) 
			{
				var roomIndex:int=cByte.readInt();
				var roomName:String=cByte.readCustomString();
				var room:Room=new Room();
				room.index=roomIndex;
				room.roomName=roomName;
				GlobalData.roolList.push(room);
				
			}
			DataEventDispatcher.dispatchEvent(new Event(ClientMsgDefine.GET_ROOM_LIST));
		}
	}
}