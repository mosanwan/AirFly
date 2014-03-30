package socketConnection.server
{
	import flash.utils.Dictionary;

	public class RemoteData
	{
		public static var clientList:Dictionary=new Dictionary();;
		public static var roomList:Dictionary=new Dictionary();
		
		private static var room_id:int=0;
		static public function get_room_id():int
		{
			return room_id++;
		}
		public function RemoteData()
		{
		
		}
		public static function init():void
		{
			clientList=new Dictionary();
			roomList=new Dictionary();
		}
	}
}