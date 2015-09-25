package com.kaka.display{
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Video;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.media.Camera;
	import flash.text.TextField;
	
	public class cameraPic extends EventDispatcher{
		
		private var video:Video;
		private var getVideoText:TextField;
		private var recamBt:Sprite;
		private var camBt:Sprite;
		private var camWidth:uint;
		private var camHeight:uint;
		
		private var camBitmapData:BitmapData;
		
		public function cameraPic(_v:Video,_recamBt:Sprite,_camBt:Sprite,_txt:TextField,w:uint = 320,h:uint = 280) {
			
			this.video = _v;
			this.recamBt = _recamBt;
			this.camBt = _camBt;
			this.getVideoText = _txt;
			
			this.camWidth = w;
			this.camHeight = h;
			
			isenabled(this.recamBt,false,regetImageFunc);
			
			initCamera();
			
		}	
		private function initCamera():void {
			
			var camera:Camera=Camera.getCamera();
		
			if (camera==null) {
				this.getVideoText.text = "找不到可用的摄像头!";
				isenabled(this.camBt,false,getImageFunc);
			} else {
				this.getVideoText.text = "找到摄像头,点击拍照!"
				trace("找到摄像头:"+camera.name);
				camera.setMode(this.camWidth,this.camHeight,10,true);
				this.video.attachCamera(camera);
				isenabled(this.camBt,true,getImageFunc);
			}
			
		}
		private function regetImageFunc(e:MouseEvent):void{
			this.video.visible = true;
			
			isenabled(this.recamBt,false,regetImageFunc);
			isenabled(this.camBt,true,getImageFunc);
			
			this.getVideoText.text = "准备就绪，点击拍照!";
		}
		private function getImageFunc(e:MouseEvent):void{
			this.video.visible = false;
			isenabled(this.recamBt,true,regetImageFunc);
			isenabled(this.camBt,false,getImageFunc);
			
			this.getVideoText.text = "拍照完毕!";
			dispatchEvent(new Event("completeCamPic"));
		}
		private function isenabled(btMc:DisplayObject,isable:Boolean,fn:Function):void {
			var bt;
			if (isable) {
				if(btMc is Sprite){bt = btMc as Sprite;bt.buttonMode=true;}else{bt = btMc;}
				bt.addEventListener(MouseEvent.CLICK,fn);
				bt.alpha=1;
			} else {
				if(btMc is Sprite){bt = btMc as Sprite;bt.buttonMode=false;}else{bt = btMc;}
				bt.removeEventListener(MouseEvent.CLICK,fn);
				bt.alpha=0.5;
			}
		}
		
		//------
		public function getPrecamPic():Sprite{
			var precamPic:Sprite = new Sprite();
			var camBitmapData:BitmapData = new BitmapData(this.camWidth, this.camHeight, true, 0);
			camBitmapData.draw(this.video);
			precamPic.addChild(new Bitmap(camBitmapData));
			return precamPic;
		}
	}
}
