package com.kaka.display 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	//import com.kaka.display.ButtonMCEvent;
	/**
	 * ...
	 * @author kaka
	 */
	public class ButtonMC extends gotoFunction
	{
		private var _isclick:Boolean = false;
		private var target:uint = 1;
		public function ButtonMC()
		{
			stop();
			
			this.buttonMode = true;			
			this.addEventListener(MouseEvent.ROLL_OVER, onRollover)
			this.addEventListener(MouseEvent.ROLL_OUT, onRollout)
			this.addEventListener(ButtonMCEvent.BUTTON_CONTROL,controlgoto)
			//this.addEventListener(MouseEvent.CLICK, onClick )
		}
		private function controlgoto(e:ButtonMCEvent)
		{
			trace(e.target.method)
			switch(e.target.method)
			{
				case "rollover":
				target = totalFrames;
				goto(target);
				break;
				case "rollout":
				target = 1;
				goto(target);
				break;
			}
		}
		private function onRollover(e:MouseEvent)
		{
			target = totalFrames;
			goto(target);
			
		}
		private function onRollout(e:MouseEvent)
		{
			target = 1;
			goto(target);
		}
		public function removeEvent()
		{
			removeEventListener(MouseEvent.ROLL_OVER, onRollover)
			removeEventListener(MouseEvent.ROLL_OUT, onRollout)			
		}
		public function addEvent()
		{
			addEventListener(MouseEvent.ROLL_OVER, onRollover)
			addEventListener(MouseEvent.ROLL_OUT, onRollout)			
		}
		public function get isclick()
		{
			return _isclick;
		}
		public function set isclick(b:Boolean)
		{
			_isclick = b;
		}
	}

}