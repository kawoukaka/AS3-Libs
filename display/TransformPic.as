package com.kaka.display{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.geom.Point;
	import com.kaka.map.DynamicRegisteration;

	/**
	 * @author kaka
	 */
	public class TransformPic extends Sprite {
		private var picMc:Sprite;
		private var moveBt:Sprite;
		private var scaleBt:Sprite;
		private var rotateBt:Sprite;
		
		private var transPlane:Sprite;
		private var transBtMc:Sprite;

		private var oldy:Number;
		private var nowx:Number;
		private var vy:Number=0;
		private var sc:int=0;
		private var ro:int=0;
		private var p:Point;
				
		public function TransformPic($picMc:Sprite,$moveBt:Sprite = null,$scaleBt:Sprite = null,$rotateBt:Sprite = null) {
			//用于编辑的图片，与此图片的中心点
			picMc=$picMc;
			p = new Point(picMc.width/2,picMc.height/2);
			
			//用于侦测鼠标操作编辑动作的按钮
			transPlane=makeArea(picMc.width,picMc.height,0.2);
			addChild(transPlane);
			transPlane.x = picMc.x;
			transPlane.y = picMc.y;
			
			//切换编辑状态的按钮
			transBtMc = new Sprite();
			addChild(transBtMc);
			if($moveBt){moveBt=$moveBt;transBtMc.addChild(moveBt);}
			if($scaleBt){scaleBt=$scaleBt;transBtMc.addChild(scaleBt);}
			if($rotateBt){rotateBt=$rotateBt;transBtMc.addChild(rotateBt);}

			addEvent();
			tomove(null);
		}

		private function addEvent():void {
			if(moveBt){this.moveBt.addEventListener(MouseEvent.CLICK, tomove);}
			if(scaleBt){this.scaleBt.addEventListener(MouseEvent.CLICK, toscale);}
			if(rotateBt){this.rotateBt.addEventListener(MouseEvent.CLICK, torotate);}
			transPlane.addEventListener(MouseEvent.MOUSE_OUT, transout);
		}
		private function transout(e:MouseEvent):void {
			picMc.stopDrag();
			transPlane.removeEventListener(MouseEvent.MOUSE_MOVE, scalehd);
			transPlane.removeEventListener(MouseEvent.MOUSE_MOVE, rotatehd);
		}
		private function tomove(e:MouseEvent):void {
			transformType("move");
		}
		private function toscale(e:MouseEvent):void {
			transformType("scale");
		}
		private function torotate(e:MouseEvent):void {
			transformType("rotate");
		}
		
		//move
		private function toDrag(e:Event):void {
			picMc.startDrag();
		}
		private function toStopDrag(e:Event):void {
			picMc.stopDrag();
		}
		
		//scale
		private function scaleon(e:MouseEvent):void {
			transPlane.addEventListener(MouseEvent.MOUSE_MOVE, scalehd);
			oldy=mouseY;
		}
		private function scaleoff(e:MouseEvent):void {
			transPlane.removeEventListener(MouseEvent.MOUSE_MOVE, scalehd);
		}
		private function scalehd(e:MouseEvent):void {
			e.updateAfterEvent();
			vy=transPlane.mouseY-oldy;
			oldy=transPlane.mouseY;
			
			if (vy>0) {
				if (sc < -90) {
					sc = -91;
				} else {
					sc--;
				}
			}
			if (vy<0) {
				if (sc>200) {
					sc=201;
				} else {
					sc++;
				}
			}
			DynamicRegistration.scale(picMc,p,1+sc*0.01,1+sc*0.01);
		}
		
		//rotate
		private function rotateon(e:MouseEvent):void {
			transPlane.addEventListener(MouseEvent.MOUSE_MOVE, rotatehd);
			oldy=mouseY;
		}
		private function rotateoff(e:MouseEvent):void {
			transPlane.removeEventListener(MouseEvent.MOUSE_MOVE, rotatehd);
		}
		private function rotatehd(e:MouseEvent):void {
			e.updateAfterEvent();
			vy=transPlane.mouseY-oldy;
			oldy=transPlane.mouseY;
			nowx=transPlane.mouseX;
			
			if (nowx<transPlane.width/2) {
				if (vy>0) {
					if (ro < -180) {
					ro = -181;
					} else {
					ro--;
					}
				}
				if (vy<0) {
					if (ro>180) {
						ro=181;
					} else {
						ro++;
					}
				}
			} else {
				if (vy<0) {
					if (ro < -180) {
					ro = -181;
					} else {
					ro--;
					}
				}
				if (vy>0) {
					if (ro>180) {
						ro=181;
					} else {
						ro++;
					}
				}
			}
			DynamicRegistration.rotate(picMc,p,ro);
		}


		/**************************************
		** makeArea
		** 一些辅助方法
		***************************************/
		public function makeArea(w:uint,h:uint,alpha:Number= 0.5):Sprite {

			var area:Sprite=new Sprite  ;
			area.alpha=alpha;
			area.graphics.beginFill(0x000000,1);
			area.graphics.drawRect(0,0,w,h);
			area.graphics.endFill();
			return area;

		}
		private function transformType(type:String):void{
			transPlane.removeEventListener(MouseEvent.MOUSE_DOWN, toDrag);
			transPlane.removeEventListener(MouseEvent.MOUSE_UP, toStopDrag);
			transPlane.removeEventListener(MouseEvent.MOUSE_DOWN, scaleon);
			transPlane.removeEventListener(MouseEvent.MOUSE_UP, scaleoff);
			transPlane.removeEventListener(MouseEvent.MOUSE_DOWN, rotateon);
			transPlane.removeEventListener(MouseEvent.MOUSE_UP, rotateoff);
			
			if(type == "move"){
				transPlane.addEventListener(MouseEvent.MOUSE_DOWN, toDrag);
				transPlane.addEventListener(MouseEvent.MOUSE_UP, toStopDrag);
			}else if(type == "scale"){
				transPlane.addEventListener(MouseEvent.MOUSE_DOWN, scaleon);
				transPlane.addEventListener(MouseEvent.MOUSE_UP, scaleoff);
			}else if(type == "rotate"){
				transPlane.addEventListener(MouseEvent.MOUSE_DOWN, rotateon);
				transPlane.addEventListener(MouseEvent.MOUSE_UP, rotateoff);
			}
		}
		
	}
}