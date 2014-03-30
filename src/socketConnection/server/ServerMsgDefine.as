package socketConnection.server
{
	/**
	 *author T
	 *2014-3-29下午3:19:49
	 */
	public class ServerMsgDefine
	{
		
		public static var FIREST_CONNECT:int=0;//客户端第一次连接
		public static var CREATE_ROOM:int=1;//创建房间
		public static var REMOVE_ROOM:int=2;//解散房间
		public static var GET_ROOM_LIST:int=3;//获取房间列表
		public static var JOINT_ROOM:int=4;//加入房间
		public static var OUT_ROOM:int=5;//退出房间
		public static var JOINT_TEAM:int=6;//加入战队
		public static var CREATE_ROOM_RESULT:int=7;//返回创建房间结果
		
		
		public function ServerMsgDefine()
		{
		}
	}
}