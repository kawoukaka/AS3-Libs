package com.kaka.display 
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
    import flash.events.ProgressEvent;
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author kaka
	 */
	public class PicMC extends Sprite
	{
		private var _isclick:Function
		private var picurl:String;
		private var picloader:Loader;        
        private var sw:Number;
        private var sh:Number;
		public function PicMC(w:Number,h:Number,purl:String)
		{
			stop();
			this.sw = w;
            this.sh = h;
			this.picurl = purl;		
			this.buttonMode = true;
			this.addEventListener(MouseEvent.CLICK, onClick);
			init()
		}
		private function init()
		{
			picloader = new Loader();            
            picloader.load(new URLRequest(picurl));
            picloader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loaderProgressHandler);
            picloader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderCompleteHandler);
		}
		private function loaderProgressHandler(e:ProgressEvent):void
        {
            var num:uint = (e.bytesLoaded / e.bytesTotal) * 100;
            trace(num+"%");
        }
		private function loaderCompleteHandler(e:Event):void
        {
            var bitmap:Bitmap = e.currentTarget.content as Bitmap;
            trace(bitmap);    
            bitmap.width = this.sw;
            bitmap.height = this.sh;
            bitmap.x = 0;
            bitmap.y = 0;
            addChild(bitmap);
        }
		private function onClick(e:MouseEvent)
		{			
			if (_isclick != null)
			{
				_isclick();
			}
		}

		public function set isclick(b:Function)
		{
			_isclick = b;
		}
		
	}

}