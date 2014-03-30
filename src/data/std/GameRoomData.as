package data.std
{
	/**
	 *author T
	 *2014-3-28下午11:46:23
	 */
	public class GameRoomData
	{
		public static const ROOM_STATE_FREE:int=0;
		public static const ROOM_STATE_BUSY:int=1;
		
		public var roomName:String;
		public var roomId:int;
		public var roomState:int;
		public var peopleNum:int;
		public function GameRoomData(_roomName:String,_roomId:int,_roomState:int,_peopleNum:int):void
		{
			this.roomName=_roomName;
			this.roomId=_roomId;
			this.roomState=_roomState;
			this.peopleNum=_peopleNum;
		}
		
	}
}