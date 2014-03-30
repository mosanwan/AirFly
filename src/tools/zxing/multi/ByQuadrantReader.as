/*
 * Copyright 2009 ZXing authors
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

package tools.zxing.multi
{

import tools.zxing.BinaryBitmap;
import tools.zxing.Reader;
import tools.zxing.ReaderException;
import tools.zxing.Result;
import tools.zxing.common.flexdatatypes.HashTable;

/**
 * This class attempts to decode a barcode from an image, not by scanning the whole image,
 * but by scanning subsets of the image. This is important when there may be multiple barcodes in
 * an image, and detecting a barcode may find parts of multiple barcode and fail to decode
 * (e.g. QR Codes). Instead this scans the four quadrants of the image -- and also the center
 * 'quadrant' to cover the case where a barcode is found in the center.
 *
 * @see GenericMultipleBarcodeReader
 */
public final class ByQuadrantReader implements Reader {

  private var  delegate:Reader;

  public function ByQuadrantReader(delegate:Reader ) {
    this.delegate = delegate;
  }

  public function decode( image:BinaryBitmap, hints:HashTable=null):Result 
  {

    var width:int = image.getWidth();
    var height:int = image.getHeight();
    var halfWidth:int = width / 2;
    var halfHeight:int = height / 2;

    var topLeft:BinaryBitmap = image.crop(0, 0, halfWidth, halfHeight);
    try {
      return delegate.decode(topLeft, hints);
    } catch (re:ReaderException) {
      // continue
    }

    var topRight:BinaryBitmap = image.crop(halfWidth, 0, width, halfHeight);
    try {
      return delegate.decode(topRight, hints);
    } catch (re:ReaderException) {
      // continue
    }

    var bottomLeft:BinaryBitmap = image.crop(0, halfHeight, halfWidth, height);
    try {
      return delegate.decode(bottomLeft, hints);
    } catch (re:ReaderException) {
      // continue
    }

    var bottomRight:BinaryBitmap = image.crop(halfWidth, halfHeight, width, height);
    try {
      return delegate.decode(bottomRight, hints);
    } catch (re:ReaderException) {
      // continue
    }

    var quarterWidth:int = halfWidth / 2;
    var quarterHeight:int = halfHeight / 2;
    var center:BinaryBitmap = image.crop(quarterWidth, quarterHeight, width - quarterWidth,
        height - quarterHeight);
    return delegate.decode(center, hints);
  }

}
}