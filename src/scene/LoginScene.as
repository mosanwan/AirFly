package scene
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Circ;
	import com.greensock.easing.Elastic;
	
	import flash.desktop.NativeApplication;
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.clearInterval;
	import flash.utils.clearTimeout;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import data.GlobalData;
	
	import event.DataEventDispatcher;
	
	import view.ui.Button01;
	

	public class LoginScene extends Sprite implements ISceneBase
	{
		private var cDis:int=100;
		private var pos:Vector.<Point>=new Vector.<Point>();
		private var cs:Vector.<Circle>=new Vector.<Circle>();
		private var lineShape:Shape;
		
		
		private var startBtn:Button01;
		public function LoginScene()
		{
			super();
			trace("Login");
			pos=new Vector.<Point>();
			var center:Point=new Point(GlobalData.gameWidth>>1,(GlobalData.gameHeight>>1)-100);
			var angle1:Number=-90*(Math.PI/180);
			var p1:Point=new Point( Math.sin(angle1)*cDis+center.x,Math.cos(angle1)*cDis+center.y);
			var angle2:Number=30*(Math.PI/180);
			var p2:Point=new Point( Math.sin(angle2)*cDis+center.x,Math.cos(angle2)*cDis+center.y);
			var angle3:Number=-210*(Math.PI/180);
			var p3:Point=new Point( Math.sin(angle3)*cDis+center.x,Math.cos(angle3)*cDis+center.y);
			
			var pc1:Point=new Point( Math.sin(angle1)*cDis*10+center.x,Math.cos(angle1)*cDis*10+center.y);
			var pc2:Point=new Point( Math.sin(angle2)*cDis*10+center.x,Math.cos(angle2)*cDis*10+center.y);
			var pc3:Point=new Point( Math.sin(angle3)*cDis*10+center.x,Math.cos(angle3)*cDis*10+center.y);
			var c1:Circle=new Circle(pc1);this.addChild(c1);c1.x+=200;
			var c2:Circle=new Circle(pc2);this.addChild(c2);c2.y+=200;
			var c3:Circle=new Circle(pc3);this.addChild(c3);c3.x+=100;c3.y+=100;
			cs.push(c1);cs.push(c2);cs.push(c3);
			pos.push(p1);pos.push(p2);pos.push(p3);
			
			
			DataEventDispatcher.addEventListener("BACK",onBack);
			lineShape=new Shape();
			this.addChild(lineShape);
			
			
			var ins:uint=setTimeout(function ():void{
				clearTimeout(ins);
				var tm1:TweenMax=new TweenMax(c1,3,{x:pos[0].x,y:pos[0].y,ease:Elastic.easeOut});
				var tm2:TweenMax=new TweenMax(c2,3,{x:pos[1].x,y:pos[1].y,ease:Elastic.easeOut});
				var tm3:TweenMax=new TweenMax(c3,3,{x:pos[2].x,y:pos[2].y,ease:Elastic.easeOut});
				setpII();
			},100);
			
			SceneMgr.show(this);
			SceneMgr.getInstance().clearnPreScene();
		}
		
		private function setpII():void
		{
			this.addEventListener(Event.ENTER_FRAME,onFrame);
			var ins:uint=setTimeout(function ():void{
				clearTimeout(ins);
				setpIII();
			},2000);
		}
		
		private function setpIII():void
		{
			this.removeEventListener(Event.ENTER_FRAME,onFrame);
			
			startBtn=new Button01("Start Game");
			startBtn.setScaleSize(0.3,0.15);
			startBtn.move(GlobalData.gameWidth-startBtn.width>>1, GlobalData.gameHeight);
			this.addChild(startBtn);
			var tm4:TweenMax=new TweenMax(startBtn,1,{y: GlobalData.gameHeight/2 + 200,ease:Elastic.easeOut});
			
			startBtn.addEventListener(MouseEvent.CLICK,onStartGame);
		}
		
		protected function onStartGame(event:MouseEvent):void
		{
			SceneMgr.getInstance().gotoScene(GameModeSelectScene);
		}
		
		protected function onFrame(event:Event):void
		{
			lineShape.graphics.clear();
			lineShape.graphics.lineStyle(3,0x33cccc);
			lineShape.graphics.moveTo(cs[0].x,cs[0].y);
			lineShape.graphics.lineTo(cs[1].x,cs[1].y);
			lineShape.graphics.lineTo(cs[2].x,cs[2].y);
			lineShape.graphics.lineTo(cs[0].x,cs[0].y);
		}
		
		public function init():void
		{
			SceneMgr.show(this);
		}
		public function remove():void
		{
			trace("clearn Login scene");
			DataEventDispatcher.removeEventListener("BACK",onBack);
			if(startBtn){
				startBtn.removeEventListener(MouseEvent.CLICK,onStartGame);
				this.removeChild(startBtn);
				startBtn=null;
			}
			
			
			for (var i:int = 0; i < cs.length; i++) 
			{
				this.removeChild(cs[i]);
			}
			cs=null;
			pos=null;
			this.parent.removeChild(this);
		}
		public function onBack(e:Event):void
		{
			trace("退出程序");
			NativeApplication.nativeApplication.exit();
		}
	}
	
	
}
import flash.display.Sprite;
import flash.geom.Point;

class Circle extends Sprite
{
	public function Circle(px:Point){
		this.graphics.beginFill(0x33CCCC);
		this.graphics.drawCircle(0,0,40);
		this.graphics.endFill();
		this.x=px.x;
		this.y=px.y;
	}
}