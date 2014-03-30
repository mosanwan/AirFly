package socketConnection
{

	/**
	 *author T
	 *2014-3-29上午1:36:44
	 */
	public interface ISocket
	{
		function init(adress:String,port:int):void;
		function send(data:CustomBytes):void;
		function receive(data:CustomBytes):void;
	}
}