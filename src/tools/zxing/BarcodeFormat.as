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
package tools.zxing
{
/**
 * Enumerates barcode formats known to this package.
 *
 * @author Sean Owen
 */
	
public class BarcodeFormat
{	   public static var QR_CODE:BarcodeFormat = new BarcodeFormat("QR_CODE");
        public static var DATAMATRIX:BarcodeFormat = new BarcodeFormat("DATAMATRIX");
        public static var UPC_E:BarcodeFormat = new BarcodeFormat("UPC_E");
        public static var UPC_A:BarcodeFormat = new BarcodeFormat("UPC_A");
        public static var EAN_8:BarcodeFormat = new BarcodeFormat("EAN_8");
        public static var EAN_13:BarcodeFormat = new BarcodeFormat("EAN_13");
        public static var CODE_128:BarcodeFormat = new BarcodeFormat("CODE_128");
        public static var CODE_39:BarcodeFormat = new BarcodeFormat("CODE_39");
        public static var ITF:BarcodeFormat = new BarcodeFormat("ITF");
        public static var PDF417:BarcodeFormat = new BarcodeFormat("PDF417");

        private var _name:String;

        public function BarcodeFormat(name:String)
        {
            this._name = name;
        }

        public  function toString():String 
        {
            return this._name;
		}
    }
}