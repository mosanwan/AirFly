package scene
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Bounce;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import data.GlobalData;
	
	import event.DataEventDispatcher;

	public class GameModeSelectScene extends Sprite implements ISceneBase
	{
		[Embed(source="../resource/singleBattle.png")]private var singlePlayBmd:Class;
		[Embed(source="../resource/MultiBattle.png")]private var multiPlayBmd:Class;
		private var _sBmp:Bitmap;
		private var _mBmp:Bitmap;
		private var singleBtn:Sprite;
		private var multiBtn:Sprite;
		public function GameModeSelectScene()
		{
			super();
			singleBtn=new Sprite();
			_sBmp=new singlePlayBmd();
			_mBmp=new multiPlayBmd();
			
			_sBmp.width=GlobalData.gameWidth;
			_sBmp.height=GlobalData.gameHeight;
			_mBmp.width=GlobalData.gameWidth;
			_mBmp.height=GlobalData.gameHeight;
			
			singleBtn.addChild(_sBmp);
			this.addChild(singleBtn);
			multiBtn=new Sprite();
			multiBtn.addChild(_mBmp);
			this.addChild(multiBtn);
		}
		public function init():void
		{
			
			singleBtn.x=-singleBtn.width;
			multiBtn.x=multiBtn.width;
			
			var t1:TweenMax=new TweenMax(singleBtn,1,{x:0,ease:Bounce.easeOut});
			var t2:TweenMax=new TweenMax(multiBtn,1,{x:0,ease:Bounce.easeOut});
			
			SceneMgr.show(this);
			SceneMgr.getInstance().clearnPreScene();
			
			this.addEventListener(MouseEvent.CLICK,onSelect);
			DataEventDispatcher.addEventListener("BACK",onBack);
		}
		
		public function onBack(e:Event):void
		{
			SceneMgr.getInstance().gotoScene(LoginScene);
			
		}
		
		protected function onSelect(event:MouseEvent):void
		{
			if(this.mouseX<GlobalData.gameWidth/2)
			{
				SceneMgr.getInstance().gotoScene(SinglePlayScene);
			}else{
				SceneMgr.getInstance().gotoScene(ConnectionModeSelectScene);
			}
		}
		public function remove():void{
			trace("remove Game Select scene");
			this.parent.removeChild(this);
			this.removeChild(singleBtn);
			this.removeChild(multiBtn);
			_sBmp.bitmapData.dispose();
			_mBmp.bitmapData.dispose();
			_sBmp=null;
			_mBmp=null;
			DataEventDispatcher.removeEventListener("BACK",onBack);
		}
	}
}