package
{
	/**
	 *author T
	 *2014-3-28上午12:03:50
	 */
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class DeviceLabel extends Sprite
	{
		public var deviceName:TextField;
		public var deviceState:TextField;
		public var btn:MovieClip;
		
		public var dname:String;
		public var dadress:String;
		public var dstate:int;
		public var index:int;
		
		/**
		 * 
		 * @param n name
		 * @param st state
		 * @param ind index
		 * 
		 */		
		public function DeviceLabel(n:String,st:int,ind:int)
		{
			super();
			deviceName.mouseEnabled=false;
			deviceState.mouseEnabled=false;
			
			deviceName.text=n;
			setState(st);
			this.index=ind;
		}
		
		public function setState(_state:int):void
		{
			this.dstate=_state;
			switch(_state)
			{
				case 3:
					deviceState.text="可连接";
					deviceState.textColor=0x0099cc;
					break;
				case 0:
					deviceState.text="已连接";
					deviceState.textColor=0x00ff00;
					break;
				case 0:
					deviceState.text="失败";
					deviceState.textColor=0xff0000;
					break;
				case 1:
					deviceState.text="邀请中";
					deviceState.textColor=0x660099;
					break;
				case 4:
					deviceState.text="未知设备";
					deviceState.textColor=0x60033;
					break;
					
			}
		}
	}
}