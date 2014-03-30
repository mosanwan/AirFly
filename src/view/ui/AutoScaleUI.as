package view.ui
{
	import flash.display.Sprite;
	
	import data.GlobalData;
	
	public class AutoScaleUI extends Sprite
	{
		public function AutoScaleUI()
		{
			super();
		}
		public function move(px:int,py:int):void
		{
			this.x=px;
			this.y=py;
		}
		public function setScaleSize(sw:Number,sh:Number):void
		{
			this.width=GlobalData.gameWidth*sw;
			this.height=GlobalData.gameHeight*sh;
		}
	}
}