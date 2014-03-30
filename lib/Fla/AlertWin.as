package
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class AlertWin extends MovieClip
	{
		public var txt:TextField;
		private static var _ins:AlertWin;
		private var callBack:Function;
		public static function getInstance():AlertWin
		{
			if(!_ins) _ins=new AlertWin();
			return _ins;
		}
		public function AlertWin()
		{
			super();
		}
		public function show(str:String,_callBack:Function=null):void
		{
			txt.text=str;
			callBack=_callBack;
		}
	}
}