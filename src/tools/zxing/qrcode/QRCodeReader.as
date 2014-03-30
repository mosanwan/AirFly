/*
 * Copyright 2007 ZXing authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package tools.zxing.qrcode
{
	import tools.zxing.common.BitMatrix;
	import tools.zxing.common.flexdatatypes.HashTable;
	import tools.zxing.DecodeHintType;
	import tools.zxing.Reader;
	import tools.zxing.ReaderException;
	import tools.zxing.Result;
	import tools.zxing.BarcodeFormat;
	import tools.zxing.ResultPoint;
	import tools.zxing.ResultMetadataType;
	import tools.zxing.BinaryBitmap;
	import tools.zxing.common.DecoderResult;
	import tools.zxing.common.DetectorResult;
	import tools.zxing.qrcode.decoder.Decoder;
	import tools.zxing.qrcode.detector.Detector;

    public class QRCodeReader implements Reader
    { 

          private static var  NO_POINTS:Array = new Array(0);
          private var decoder:Decoder = new Decoder();

		  protected function getDecoder():Decoder 
		  {
		    return decoder;
		  }

          /**
           * 定位和解码图像中的QR码
           *
           * @return 一个String，代表QR码编码的内容
           * @throws ReaderException如果QR码可以不被发现，或不能被解码
           */
           
          //public function decode(image:MonochromeBitmapSource):Result 
          //{
          //    try
          //    {
          //      return decode(image, null);
          //    }
          //    catch(e:Exception)
          //    {
          //      throw new ReaderException(e.message);
          //    }
          //  
          //}

          public function decode(image:BinaryBitmap,  hints:HashTable=null):Result{  
                var decoderResult:DecoderResult;
                var points:Array;
                if (hints != null && hints.ContainsKey(DecodeHintType.PURE_BARCODE)) 
                {
                  var bits:BitMatrix = extractPureBits(image.getBlackMatrix());
                  decoderResult = decoder.decode(bits);
                  points = NO_POINTS;
                } 
                else 
                {
                  var detectorResult:DetectorResult = new Detector(image.getBlackMatrix()).detect(hints);
                  decoderResult = decoder.decode(detectorResult.getBits());
                  points = detectorResult.getPoints();
                }

                var result:Result = new Result(decoderResult.getText(), decoderResult.getRawBytes(), points, BarcodeFormat.QR_CODE);
                if (decoderResult.getByteSegments() != null) {
                  result.putMetadata(ResultMetadataType.BYTE_SEGMENTS, decoderResult.getByteSegments());
                }
                return result;
          }

          /**
           * 这种方法检测条码在一个“纯粹”的形象 - 这是，纯黑白图像
           *其中包含只有一个旋转的，unskewed，图像条码一些白色边框，
           *它周围。这是一个专门的工作特别快，在这个特殊的方法，
           *案例。
           */
          private static function extractPureBits(image:BitMatrix):BitMatrix{
            //现在需要确定模块的大小（以像素为单位）

            var height:int = image.getHeight();
            var width:int = image.getWidth();
            var minDimension:int = Math.min(height, width);

            // 首先，跳过跟踪对角线左下顶端和右侧的白色边框：
            var borderWidth:int = 0;
            while (borderWidth < minDimension && !image._get(borderWidth, borderWidth)) {
              borderWidth++;
            }
            if (borderWidth == minDimension) {
              throw new ReaderException("QRCodeReader : extractPureBits : borderWidth == minDimension");
            }

            // 然后保持整个左上角的黑色模块的跟踪，以确定模块的大小
            var moduleEnd:int = borderWidth;
            while (moduleEnd < minDimension && image._get(moduleEnd, moduleEnd)) {
              moduleEnd++;
            }
            if (moduleEnd == minDimension) {
              throw new ReaderException("QRCodeReader : extractPureBits : moduleEnd == minDimension");
            }

            var moduleSize:int = moduleEnd - borderWidth;

            // 现在发现第一排最右边的黑色模块结束
            var rowEndOfSymbol:int = width - 1;
            while (rowEndOfSymbol >= 0 && !image._get(rowEndOfSymbol, borderWidth)) {
              rowEndOfSymbol--;
            }
            if (rowEndOfSymbol < 0) {
              throw new ReaderException("QRCodeReader : extractPureBits : rowEndOfSymbol < 0");
            }
            rowEndOfSymbol++;

            // 请确保条码的宽度是多个模块的大小
            if ((rowEndOfSymbol - borderWidth) % moduleSize != 0) {
              throw new ReaderException("QRCodeReader : extractPureBits : width of barcode is NOT a multiple of module size");
            }
            var dimension:int = (rowEndOfSymbol - borderWidth) / moduleSize;

            // 推进模块宽度的一半，所以，我们开始在“边界”
            //采样在模块中。以防万一的形象是一个
            //小关闭，这将有助于恢复。
            borderWidth += moduleSize >> 1;

            var sampleDimension:int = borderWidth + (dimension - 1) * moduleSize;
            if (sampleDimension >= width || sampleDimension >= height) {
              throw new ReaderException("QRCodeReader : extractPureBits : sampleDimension("+sampleDimension+") larger than width ("+width+") or heigth ("+height+")");
            }

            //现在只要读出的比特
            var bits:BitMatrix = new BitMatrix(dimension);
            for (var i:int = 0; i < dimension; i++) {
              var iOffset:int = borderWidth + i * moduleSize;
              for (var j:int = 0; j < dimension; j++) {
                if (image._get(borderWidth + j * moduleSize, iOffset)) {
                  bits._set(j, i);
                }
              }
            }
            return bits;
          }
    }
}