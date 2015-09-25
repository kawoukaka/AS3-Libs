package com.kaka.display
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class LimitRowTextField extends TextField {
		public var maxRows:int = 0;	// 0 = unlimited rows
		public var moreStr:String = "...";
		private var rawText:String;
		private var enterframeCount:int;
		private var showRows:int = 0;
		
		public function LimitRowTextField(){
			super();
		}
		
		// if no need abbreviation, you call use htmlText directly
		public function set text2(str:String):void {
			removeEventListener(Event.ENTER_FRAME, render);
			rawText = str;
			text = str;
			if (maxRows > 0) {
				enterframeCount = 0;
				addEventListener(Event.ENTER_FRAME, render);
			}
		}
		public function get text2():String {
			return rawText;
		}
		
		/	private function render(evt:Event):void {
			if (enterframeCount == 0) {
				showRows = (numLines > maxRows) ? maxRows : numLines;
				trace ('showRows', showRows, 'numLines', numLines);
			} else if (enterframeCount > 0) {
				if (numLines > showRows){
					var no:int = 0;
					for (var i:int = 0; i < showRows; i++){
						no += getLineLength(i);
					}
					// if you want more accurate result, you should not deduct moreStr.length
					// but it requires more enterframe time to reach the right extractCount
					var extractCount:int = no - moreStr.length - enterframeCount;
					text = rawText.substr(0, extractCount) + moreStr;
				} else {
					removeEventListener(Event.ENTER_FRAME, render);
				}
			}
			enterframeCount++;
		}
	}
}
