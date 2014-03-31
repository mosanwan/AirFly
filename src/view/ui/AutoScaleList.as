package view.ui
{
	import flash.display.Sprite;
	
	import data.GlobalData;

	/**
	 *author T
	 *2014-3-28下午9:14:20
	 */
	public class AutoScaleList extends AutoScaleUI
	{
		private var cellClass:Class;
		private var con:Sprite;
		private var bg:Background01;
		
		public function AutoScaleList(cell:Class)
		{
			super();
			
			bg=new Background01();
			this.addChild(bg);
			
			cellClass=cell;
			con=new Sprite();
			con.x=10;
			con.y=10;
			this.addChild(con);
		}
		public function addData(data:Object):void
		{
			var item:RenderCellBase=new cellClass() as RenderCellBase;
			item.y=con.numChildren*item.height+10;
			item.addData(data);
			con.addChild(item);
		}
		public function clear():void
		{
			while(con.numChildren>0)
			{
				con.removeChildAt(0);
				
			}
		}
		override public function setScaleSize(sw:Number, sh:Number):void
		{
			bg.width=GlobalData.gameWidth*sw;
			bg.height=GlobalData.gameHeight*sh;
		}
	}
}