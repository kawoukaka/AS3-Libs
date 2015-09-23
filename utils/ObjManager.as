package com.kaka.utils
{
	import com.kaka.debug.Tracer;
	public class ObjManager
	{
		public static var objs:Array=new Array();
		public static function push(_str:String,obj:*):void{
			if(obj!=null){
				objs[_str]=obj
			}
		}
		public static function getObj(_str:String):*{
			return objs[_str]
		}
		public static function check(_str:String):Boolean{
			return objs[_str]!=null
		}
		public static function remove(_str):void{
			delete objs[_str]
		}
		public static function clear():void{
			objs=new Array()
		}
		public static function print():void{
			Tracer.printDline()
			Tracer.print("obj manager list::::")
			Tracer.printObj(objs)
			Tracer.printDline()
		}
	}
}