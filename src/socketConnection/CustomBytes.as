package socketConnection
{
	/**
	 *author T
	 *2014-3-29下午4:15:52
	 */
	import flash.utils.ByteArray;
	
	public class CustomBytes extends ByteArray
	{
		public function CustomBytes()
		{
			super();
		}
		public function readCustomString():String
		{
			var $str:String=this.readUTFBytes(20);
			var tempIndex:int = $str.length - 1;
			var tempChar:String = "";
			for(var i:int = $str.length - 1; i >= 0; i--)
			{
				tempChar = $str.charAt(i);
				if(tempChar != " ")
				{
					tempIndex = i;
					break;
				}
			}
			return $str.substring(0, tempIndex + 1);
		}
		public function writeCustomString(str:String):void{
			if(str.length<20)
			{
				var num:int=20-str.length;
				for(var i:int=0;i<num;i++)
				{
					str+=" ";
				}
				this.writeUTFBytes(str);
			}
		}
	}
}