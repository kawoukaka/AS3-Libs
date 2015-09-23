package com.kaka.utils 
{
	/**
	 * ...
	 * @author kaka
	 */
	public class checkobject
	{
		
		public static function encodeObject(obj : Object, name : String = "") 
		{
			var resultStr:String="";
			var x : *;
			for (var i in obj) 
			{
				x = obj[i];
				if (typeof x == "object") 
				{
					if (obj is Array) 
					{
						resultStr += encodeObject(x, name + "[" + i + "]");
					} 
					else 
					{
						resultStr += encodeObject(x, name + "." + i);
					}
				} 
				else 
				{
					if (obj is Array) 
					{
						resultStr += (name + "[" + i + "]=" + x) + "\n";
					} 
					else 
					{
						resultStr += (name + "." + i + "=" + x) + "\n";
					}
				}
			}
			trace(resultStr);
		}
	}

}