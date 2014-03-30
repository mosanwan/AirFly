package socketConnection.server
{
	import flash.net.Socket;
	import flash.utils.Dictionary;
	
	import socketConnection.CustomBytes;

	/**
	 *解包 打包处理器 
	 * @author T
	 * 
	 */	
	public class UPacker
	{
		private static var packs:Dictionary=new Dictionary();
		public function UPacker()
		{
			
		}
		public static function hand(socket:Socket,data:CustomBytes):void
		{
			var pack:DataPacket;
			if(!packs[socket])
			{
				pack=new DataPacket();
				pack.socket=socket;
				pack.waitingLength=true;
				pack.data=new CustomBytes();
				pack.buffer=new CustomBytes();
				packs[socket]=pack;
			
			}else{
				pack=packs[socket];
			}
//			Main.show("===============================");
//			Main.show("是否等待数据包长度 "+pack.waitingLength)
//			Main.show("现有数据缓冲 lenght="+pack.buffer.length+" 现有数据缓冲position="+pack.buffer.position+" 可读数据"+pack.buffer.bytesAvailable);
			pack.buffer.writeBytes(data);
//			Main.show("写入数据后  现有数据缓冲 lenght="+pack.buffer.length+" 现有数据缓冲position="+pack.buffer.position+" 可读数据"+pack.buffer.bytesAvailable);
			if(pack.waitingLength==true )
			{
//				Main.show("等待数据包长度");
				if(pack.buffer.length>=4){
					pack.buffer.position=0;
					pack.packetLenght=pack.buffer.readInt();
					var reData:CustomBytes=new CustomBytes();
					pack.buffer.readBytes(reData);
					pack.buffer=reData;
					pack.buffer.position=0;
					pack.waitingLength=false;
				}else{
//					Main.show("还是不够呀亲");
					pack.buffer.position=pack.buffer.length;
					pack.waitingLength=true;
					return;
				}
				
			}else{
//				Main.show("不用等待");
				pack.buffer.position=0;
			}
//			Main.show("应该读的长度 "+pack.packetLenght +"当前数据Postion "+pack.buffer.position);

			
			if(pack.buffer.bytesAvailable==pack.packetLenght)
			{
				//数据包正好
//				Main.show("刚好");
				var okData:CustomBytes=new CustomBytes();
				pack.buffer.readBytes(okData);
				DataHandler.hand(pack.socket,okData);
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
			DataHandler.hand(pack.socket,newByte);
//			trace("解包后还剩下"+pack.buffer.bytesAvailable);
			if(pack.buffer.bytesAvailable>=4){
				pack.waitingLength=false;
				pack.packetLenght=pack.buffer.readInt();
//				trace("下一次要读的长度"+pack.packetLenght);
				var nextStepBuff:CustomBytes=new CustomBytes();
				pack.buffer.readBytes(nextStepBuff);
				pack.buffer=nextStepBuff;
				pack.buffer.position=0;
				
				if(pack.buffer.length>=pack.packetLenght){
//					trace("剩下的够");
					unPack(pack);
				}else{
//					trace("剩下的长度不够了");
					pack.buffer.position=nextStepBuff.length;
					return;
				}
			}else{
//				trace("剩下的数据不能获取长度");
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