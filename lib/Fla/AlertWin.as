package
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.text.TextField;
	
	public class AlertWin extends MovieClip
	{
		public var txt:TextField;
		private static var _ins:AlertWin;
		private var callBack:Function;
		private static  var _stage:Stage;
		public static function getInstance(obj:Stage):AlertWin
		{
			_stage=obj;
			if(!_ins) _ins=new AlertWin();
			return _ins;
		}
		public function AlertWin()
		{
			this.width=_stage.stageWidth*0.7;
			this.height=_stage.stageHeight*0.6;
			this.x=_stage.stageWidth-this.width>>1;
			this.y=_stage.stageHeight-this.height>>1;
			super();
		}
		public function show(str:String,_callBack:Function=null):void
		{
			
			txt.text=str;
			callBack=_callBack;
			_stage.addChild(this);
		}
	}
}