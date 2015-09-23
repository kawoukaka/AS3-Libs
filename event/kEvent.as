package com.kaka.event
{
	import flash.events.Event;
	/**
	 * ...
	 * @author kaka
	 */
	public class kEvent extends Event
	{
		static public const KMSG:String="K_objmsg";
        public var msg:Object;
		public function KEvent(type:String,userstring:Object,bubbles:Boolean = false,cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
            msg = userstring;
			//trace("msg.s:"+msg.s)
        }

        public override function clone():Event {
			return new KEvent(type,msg,bubbles,cancelable);
        }
		public override function toString():String {

			return formatToString("myEveA","type","msg","bubbles","cancelable");
		}
	}
	
}