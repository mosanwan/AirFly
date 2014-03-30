package view.ui
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import data.GlobalData;
	import data.std.GameRoomData;

	/**
	 *author T
	 *2014-3-28下午8:51:29
	 */
	public class RoomLabel extends RenderCellBase
	{
		private var _name:TextField;
		private var _bg:Background01;
		private var _addBtn:Button01;
		public function RoomLabel()
		{
			super();
			_bg=new Background01();
			addChild(_bg);
			
			_addBtn=new Button01("加入");
			addChild(_addBtn);
			_addBtn.setScaleSize(0.15,0.1);
			_name=new TextField();
			_name.defaultTextFormat=new TextFormat("微软雅黑",30);
			_name.mouseEnabled=false;
			_name.autoSize=TextFieldAutoSize.LEFT;
			_name.text="Test";
			addChild(_name);
			setScaleSize(0.48,0.15);
		}
		override public function addData(data:Object):void
		{
			var d:GameRoomData=data as GameRoomData;
			_name.text=d.roomName;
			
			
		}
		override public function setScaleSize(sw:Number, sh:Number):void
		{
			_bg.width=GlobalData.gameWidth*sw;
			_bg.height=GlobalData.gameHeight*sh;
			
			
			_addBtn.x=_bg.width-_addBtn.width-20;
			_addBtn.y=_bg.height-_addBtn.height>>1;
			_name.x=20;
			_name.y=_bg.height-_name.height>>1;
		}
		public function dispose():void
		{
			
		}
	}
}