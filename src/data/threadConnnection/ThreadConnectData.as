package data.threadConnnection
{
	public class ThreadConnectData
	{
		public var dataType:String;
		public var data:Array;
		
		public static const start_a_server:String="sas";  //初始化服务器 [ address string ; port int]
		public static const connet_to_server:String="cts";//连接到服务器 [address string ; port int]
		public static const server_list:String = "sl";//下发server列表 [ [address string;port:int]....]		
		
		
		
		public function ThreadConnectData(type:String,_data=null)
		{
			dataType=type;
			data=_data;
		}
	}
}