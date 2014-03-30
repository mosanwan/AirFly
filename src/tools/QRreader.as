package tools
{
	import tools.zxing.BarcodeFormat;
	import tools.zxing.BinaryBitmap;
	import tools.zxing.BufferedImageLuminanceSource;
	import tools.zxing.DecodeHintType;
	import tools.zxing.Result;
	import tools.zxing.client.result.ParsedResult;
	import tools.zxing.client.result.ResultParser;
	import tools.zxing.common.GlobalHistogramBinarizer;
	import tools.zxing.common.flexdatatypes.HashTable;
	import tools.zxing.qrcode.QRCodeReader;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import data.GlobalData;
	
	import event.DataEventDispatcher;

	public class QRreader extends Sprite
	{
		
		private var _video:Video;
		private var _camera:Camera;
		private var _reader:QRCodeReader;
		private var _intv:uint;
		private var _bitmapData:BitmapData;
		public function QRreader()
		{
			
		}
		public function init(w:int,h:int):void
		{
			trace("Camera "+w+" "+h);
			if(Camera.isSupported)
			{
				
				_camera=Camera.getCamera();
				_video=new Video(400,400);
				_camera.setMode(400,400,24);
				_video.attachCamera(_camera);
				this.addChild(_video);
				_reader=new QRCodeReader();
				
				_video.x=GlobalData.gameWidth-400>>1;
				_video.y=GlobalData.gameHeight-400>>1;
				
				_intv=setInterval(function ():void{
					decodeSnapshot();
				},1000);
				
			}else{
				trace("Camera is no Supported");
			}
		}
		
		private function decodeSnapshot():void
		{
			_bitmapData=new BitmapData(400,400);
			_bitmapData.draw(_video);
			var bufferedImageLum : BufferedImageLuminanceSource = new BufferedImageLuminanceSource( _bitmapData );
			var binaryBmp : BinaryBitmap = new BinaryBitmap( new GlobalHistogramBinarizer( bufferedImageLum ) );
			var hashTable : HashTable = new HashTable();
			hashTable.Add( DecodeHintType.POSSIBLE_FORMATS, BarcodeFormat.QR_CODE );
			try {
				var result : Result = _reader.decode( binaryBmp, hashTable );
			} catch (event:Error) { 
			}
			if ( result == null ) {
			} else {
				var parsedResult : ParsedResult = ResultParser.parseResult( result );
				handStr(parsedResult.getDisplayResult());
			}
		}
		
		private function handStr(parsedResult:String):void
		{
			if(parsedResult.indexOf("http://")!=-1)
			{
				parsedResult=parsedResult.replace("http://","");
			}
			var sa:Array=parsedResult.split(".");
			if(sa.length==5){
				clearInterval(_intv);
				
				_video.clear();
				this.removeChild( _video );
				_video = null;
				_camera = null;
				_bitmapData.dispose();
				_bitmapData = null;
				var evt:QREvent=new QREvent(QREvent.QR_SUCCESS);
				evt.address=sa[0]+"."+sa[1]+"."+sa[2]+"."+sa[3];
				evt.port=int(sa[4]);
				DataEventDispatcher.dispatchEvent(evt);
			}
		}
	}
}