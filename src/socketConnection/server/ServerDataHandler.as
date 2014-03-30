package socketConnection.server
{
	import flash.net.Socket;
	
	import socketConnection.client.Client;
	import socketConnection.CustomBytes;
	

	/**
	 *author T
	 *2014-3-29下午3:15:14
	 */
	public class ServerDataHandler
	{
		
		private var currentSocket:Socket;
		public function hand(socket:Socket,bytesLength:Number):void{
			currentSocket=socket ;
			var pByte:CustomBytes=new CustomBytes();
			currentSocket.readBytes(pByte,0,bytesLength);
			pByte.position=0;
			var msgType:int=pByte.readInt();
			
			switch(msgType)
			{
				case ServerMsgDefine.FIREST_CONNECT:
					doFirestConnect(pByte);
					break;
			}
		}
		
		private function doFirestConnect(byte:CustomBytes):void  //处理玩家第一次连接服务器
		{
			var name:String=byte.readCustomString();
			trace(name+" 加入服务器");
			
		}
	}
}