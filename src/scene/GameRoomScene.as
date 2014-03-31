package scene
{
	/**
	 * 游戏房间
	 *author T
	 *2014-3-30下午11:10:42
	 */
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import data.GlobalData;
	
	import socketConnection.client.MainClient;
	
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
		private var addA:Button01;
		private var addB:Button01;
		
		public function init():void
		{
			if(GlobalData.isMeRoomMaster)
			{
				controlsBtn=new Button01("解散房间");
			}else{
				controlsBtn=new Button01("退出房间");
			}
			
			teamAlist=new AutoScaleList(GameRoomClientCell);
			teamAlist.setScaleSize(0.5,0.9);
			teamAlist.y=10;
			this.addChild(teamAlist);
			
			teamBlist=new AutoScaleList(GameRoomClientCell);
			teamBlist.setScaleSize(0.5,0.9);
			teamBlist.move(GlobalData.gameWidth-teamBlist.width,10);
			this.addChild(teamBlist);
			
			controlsBtn.setScaleSize(0.2,0.1);
			this.addChild(controlsBtn);
			controlsBtn.move(GlobalData.gameWidth-controlsBtn.width>>1,GlobalData.gameHeight-controlsBtn.height-10);
			
			addA=new Button01("加入A队");
			addB=new Button01("加入B队");
			addA.setScaleSize(0.2,0.1);
			this.addChild(addA);
			addB.setScaleSize(0.2,0.1);
			this.addChild(addB);
			addA.move(controlsBtn.x-addA.width-20,controlsBtn.y);
			addB.move(controlsBtn.x+controlsBtn.width+20,controlsBtn.y);
			
			SceneMgr.show(this);
			SceneMgr.getInstance().clearnPreScene();
			initEvent();
		}
		
		private function initEvent():void
		{
			addA.addEventListener(MouseEvent.CLICK,onAddA);
			addB.addEventListener(MouseEvent.CLICK,onAddB);
			controlsBtn.addEventListener(MouseEvent.CLICK,onControlsRoom);
		}
		
		protected function onControlsRoom(event:MouseEvent):void
		{
			if(GlobalData.isMeRoomMaster)
			{
				//解散房间
				MainClient.removeRoom(GlobalData.myRoom.index);
			}else{
				//退出房间
			}
		}
		
		protected function onAddB(event:MouseEvent):void
		{
			if(GlobalData.myTeam=="B")
			{
				return ;
			}else{
				
			}
		}
		
		protected function onAddA(event:MouseEvent):void
		{
			if(GlobalData.myTeam=="A")
			{
				return ;
			}else{
				
			}
		}
		
		public function remove():void
		{
			addA.removeEventListener(MouseEvent.CLICK,onAddA);
			addB.removeEventListener(MouseEvent.CLICK,onAddB);
			controlsBtn.removeEventListener(MouseEvent.CLICK,onControlsRoom);
			this.parent.removeChild(this);
		}
		
		public function onBack(e:Event):void
		{
		}
	}
}