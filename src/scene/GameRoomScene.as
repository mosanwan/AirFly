package scene
{
	/**
	 * 游戏房间
	 *author T
	 *2014-3-30下午11:10:42
	 */
	import flash.display.Sprite;
	import flash.events.Event;
	
	import data.GlobalData;
	
	import view.ui.AutoScaleList;
	import view.ui.Button01;
	import view.ui.GameRoomClientCell;
	
	public class GameRoomScene extends Sprite implements ISceneBase
	{
		public function GameRoomScene()
		{
			super();
		}
		private var controlsBtn:Button01;
		private var teamAlist:AutoScaleList;
		private var teamBlist:AutoScaleList;
		public function init():void
		{
			if(GlobalData.isMeRoomMaster)
			{
				controlsBtn=new Button01("解散房间");
			}else{
				controlsBtn=new Button01("退出房间");
			}
			
			controlsBtn.setScaleSize(0.2,0.1);
			this.addChild(controlsBtn);
			controlsBtn.move(GlobalData.gameWidth-controlsBtn.width>>1,GlobalData.gameHeight-controlsBtn.height-10);
			
			teamAlist=new AutoScaleList(GameRoomClientCell);
			teamAlist.setScaleSize(0.5,0.9);
			teamAlist.y=10;
			this.addChild(teamAlist);
			
			teamBlist=new AutoScaleList(GameRoomClientCell);
			teamBlist.setScaleSize(0.5,0.9);
			teamBlist.move(GlobalData.gameWidth-teamBlist.width,10);
			this.addChild(teamBlist);
			
			SceneMgr.show(this);
			SceneMgr.getInstance().clearnPreScene();
		}
		
		public function remove():void
		{
		}
		
		public function onBack(e:Event):void
		{
		}
	}
}