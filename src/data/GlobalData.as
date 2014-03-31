package data
{
	import flash.system.Capabilities;
	
	import org.sanwu.other.OtherUtils;
	import org.sanwu.wifi.WifiANE;
	
	import socketConnection.server.std.Room;

	public class GlobalData
	{
		private static var _ins:GlobalData;
		public static function getInstance():GlobalData
		{
			if(!_ins)_ins=new GlobalData();
			return _ins;
		}
		
		public static var gameWidth:int=1280;
		public static var gameHeight:int=720;
		
		public static var serverAdress:String;
		public static var serverPort:int;
		
		public static var hostAdress:String;
		public static var hostPort:int=8650;
		public static var deviceName:String;
		
		public static var roomList:Vector.<Room>=new Vector.<Room>();
		public static var myRoom:Room;
		public static var isMeRoomMaster:Boolean=false;
		public static var myTeam:String="A";
		
		public var wifiAne:WifiANE;
		public var otherTools:OtherUtils;
		public function GlobalData()
		{
			wifiAne=new WifiANE();
			otherTools=new OtherUtils();
			hostAdress=wifiAne.getIpAdress();
			deviceName=otherTools.getDeviceName();
			trace("我的手机名： "+deviceName);
			
			if(Capabilities.os!="Windows 7"){
				gameWidth=Capabilities.screenResolutionX;
				gameHeight=Capabilities.screenResolutionY;
			}
		}
	}
}