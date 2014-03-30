package view.ui  {
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import data.GlobalData;
	
	public class Button01 extends AutoScaleUI {
		
		private var tf:TextField;
		private var format:TextFormat;
		private var bg:Background01;
		public function Button01(label:String,color:uint=0x33cccc,size:int=30) {
			bg=new Background01();
			this.addChild(bg);
			
			format=new TextFormat("微软雅黑",size,color,true);
			
			tf=new TextField();
			tf.defaultTextFormat=format;
			tf.autoSize=TextFieldAutoSize.LEFT;
			tf.text=label;
			tf.mouseEnabled=false;
			
			this.addChild(tf);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN,onDown);
			this.addEventListener(MouseEvent.MOUSE_UP,onUp);
			this.addEventListener(MouseEvent.MOUSE_OUT,onOut);
		}
		
		protected function onOut(event:MouseEvent):void
		{
			this.filters=[];
			
		}
		
		protected function onUp(event:MouseEvent):void
		{
			this.filters=[];
		}
		
		protected function onDown(event:MouseEvent):void
		{
			this.filters=[new GlowFilter(0xff0000,1,20,20)];
			
		}
		override public function setScaleSize(sw:Number, sh:Number):void
		{
			bg.width=GlobalData.gameWidth*sw;
			bg.height=GlobalData.gameHeight*sh;
			tf.x=bg.width-tf.width>>1;
			tf.y=bg.height-tf.height>>1;
		}
		public function set label(str:String):void
		{
			tf.text=str;
			tf.x=bg.width-tf.width>>1;
			tf.y=bg.height-tf.height>>1;
		}
		public function get label():String
		{
			return tf.text;
		}
	}
}
