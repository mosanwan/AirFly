package
{
	/**
	 *author T
	 *2014-3-27下午9:49:35
	 */
	import flash.display.MovieClip;
	
	public class SearchButton extends MovieClip
	{
		public function SearchButton()
		{
			super();
			this.stop();
		}
		public function startSearch():void
		{
			this.play();
		}
		public function stopSearch():void
		{
			this.stop();
		}
	}
}