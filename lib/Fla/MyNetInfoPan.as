package
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class MyNetInfoPan extends MovieClip
	{
		public var bg:MovieClip;
		public var netState:TextField;
		public var netGroupState:TextField;
		public var deviceName:TextField;
		public var deviceAdress:TextField;
		public function MyNetInfoPan()
		{
			super();
			netState.mouseEnabled=false;
			netGroupState.mouseEnabled=false;
			deviceAdress.mouseEnabled=false;
			deviceName.mouseEnabled=false;
		}
		override public function set width(value:Number):void
		{
			bg.width=value;
		}
		override public function set height(value:Number):void
		{
			bg.height=value;
		}
	}
}