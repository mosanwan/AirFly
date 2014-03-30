package
{
	/**
	 *author T
	 *2014-3-28上午1:28:09
	 */
	import flash.events.Event;
	
	public class DeviceClickEvent extends Event
	{
		public static const DEVICE_LABEL_CLICK:String="device_label_click";
		public var dx:int;
		public var dy:int;
		public var index:int;
		public function DeviceClickEvent(type:String, px:int,py:int,ind:int,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			dx=px;
			dy=py;
			index=ind;
			super(type, bubbles, cancelable);
		}
	}
}