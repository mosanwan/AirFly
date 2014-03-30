package scene
{
	import flash.display.DisplayObject;

	public class SceneMgr
	{
		private static var _ins:SceneMgr;
		public static function getInstance():SceneMgr{
			if(!_ins) _ins=new SceneMgr();
			return _ins;
		}
		private var preScene:ISceneBase;
		private var currentScene:ISceneBase;
		public function init():void
		{
			gotoScene(LoginScene);
		}
		public function gotoScene(scene:Class):void
		{
			preScene=currentScene;
			var s:ISceneBase=new scene();
			currentScene=s;
			s.init();
			
		}
		public function clearnPreScene():void
		{
			if(preScene)
			{
				preScene.remove();
			}
			
		}
		public static function show(s:ISceneBase):void
		{
			Main.context.addChild(s as DisplayObject);
		}
	}
}