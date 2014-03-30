package data
{
	import flash.system.Capabilities;
	
	import org.sanwu.wifi.WifiANE;

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
		
		public var wifiAne:WifiANE;
		public function GlobalData()
		{
			wifiAne=new WifiANE();
			hostAdress=wifiAne.getIpAdress();
			
			if(Capabilities.os!="Windows 7"){
				gameWidth=Capabilities.screenResolutionX;
				gameHeight=Capabilities.screenResolutionY;
			}
		}
	}
}