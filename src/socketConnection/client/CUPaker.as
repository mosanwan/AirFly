package socketConnection.client
{
	import flash.net.Socket;
	
	import socketConnection.CustomBytes;

	/**
	 *author T
	 *2014-3-30下午5:59:29
	 */
	public class CUPaker
	{
		public function CUPaker()
		{
		}
		public static var pack:DataPacket;
		public static function hand(socket:Socket,data:CustomBytes):void
		{
			if(!pack)
			{
				pack=new DataPacket();
				pack.socket=socket;
				pack.waitingLength=true;
				pack.data=new CustomBytes();
				pack.buffer=new CustomBytes();
			}
			pack.buffer.writeBytes(data);
			if(pack.waitingLength==true )
			{
				if(pack.buffer.length>=4){
					pack.buffer.position=0;
					pack.packetLenght=pack.buffer.readInt();
					var reData:CustomBytes=new CustomBytes();
					pack.buffer.readBytes(reData);
					pack.buffer=reData;
					pack.waitingLength=false;
				}else{
					pack.buffer.position=pack.buffer.length;
					pack.waitingLength=true;
					return;
				}
				
			}else{
				pack.buffer.position=0;
			}
			if(pack.buffer.bytesAvailable==pack.packetLenght)
			{
				//数据包正好
				//				Main.show("刚好");
				var okData:CustomBytes=new CustomBytes();
				pack.buffer.readBytes(okData);
				okData.position=0;
				ClientDataHandler.hand(pack.socket,okData);
				pack.packetLenght=0;
				pack.data.clear();
				pack.buffer.clear();
				pack.waitingLength=true;
			}else if(pack.buffer.bytesAvailable>pack.packetLenght){
				//				Main.show("解包吧");
				unPack(pack);
				
			}else if(pack.buffer.bytesAvailable<pack.packetLenght){
				//				Main.show("粘包吧");
				pack.buffer.position=pack.buffer.length;
				pack.waitingLength=false;
				return;
			}
		}
		private static function unPack(pack:DataPacket):void
		{
			var newByte:CustomBytes=new CustomBytes();
			pack.buffer.readBytes(newByte,0,pack.packetLenght);
			ClientDataHandler.hand(pack.socket,newByte);
			if(pack.buffer.bytesAvailable>=4){
				pack.waitingLength=false;
				pack.packetLenght=pack.buffer.readInt();
				var nextStepBuff:CustomBytes=new CustomBytes();
				pack.buffer.readBytes(nextStepBuff);
				pack.buffer=nextStepBuff;
				pack.buffer.position=0;
				
				if(pack.buffer.length>=pack.packetLenght){
					unPack(pack);
				}else{
					pack.buffer.position=nextStepBuff.length;
					return;
				}
			}else{
				var ex:CustomBytes=new CustomBytes();
				pack.buffer.readBytes(ex);
				pack.buffer.position=ex.length;
				pack.waitingLength=true;
				pack.buffer=ex;
			}
		}
	}
}
import flash.net.Socket;

import socketConnection.CustomBytes;

class DataPacket {
	public var waitingLength:Boolean=false;
	public var socket:Socket;
	public var packetLenght:int;
	public var data:CustomBytes;
	public var buffer:CustomBytes;
}