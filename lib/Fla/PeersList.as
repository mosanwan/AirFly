package
{
	/**
	 *author T
	 *2014-3-28上午12:06:09
	 */
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class PeersList extends MovieClip
	{
		public var bg:MovieClip;
		private var con:Sprite;
		public function PeersList()
		{
			super();
			con=new Sprite();
			this.addChild(con);
		}
		public function clear():void
		{
			while(con.numChildren>0)
			{
				var d:DeviceLabel=con.getChildAt(0) as DeviceLabel;
				d..addEventListener(MouseEvent.CLICK,onDeviceClick);
				con.removeChildAt(0);
				
			}
		}
		
		public function addDevice(n:String,st:int,ind:int):void
		{
			var device:DeviceLabel=new DeviceLabel(n,st,ind);
			con.addChild(device);
			device.x=5;
			device.y= (con.numChildren-1) * device.height+5;
			device.btn.addEventListener(MouseEvent.CLICK,onDeviceClick);
		}
		private function onDeviceClick(e:MouseEvent):void
		{
			var d:DeviceLabel=(e.target as MovieClip).parent as DeviceLabel;
			var evt:DeviceClickEvent=new DeviceClickEvent(DeviceClickEvent.DEVICE_LABEL_CLICK,d.x,d.y,d.index);
			this.dispatchEvent(evt);
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