package tools
{
	import flash.events.Event;
	
	public class QREvent extends Event
	{
		public static const QR_SUCCESS:String="QRScucees";
		public var address:String;
		public var port:int;
		public function QREvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}