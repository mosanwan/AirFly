package socketConnection.server.std
{
	import flash.net.Socket;

	public class Room
	{
		public var roomName:String;
		public var members:Vector.<Client>;
		public var index:int;
		public var master:Client;
		public function Room()
		{
			members=new Vector.<Client>();
		}
		public function addMember(mem:Client):void
		{
			members.push(mem);
		}
		public function removeMember(sockt:Socket):void{
			for(var i:int=0;i<members.length;i++)
			{
				if(members[i].socket==sockt)
				{
					members=members.splice(i,1);
				}
			}
		}
		public function get membersNum():int{
			return members.length;
		}
	}
}