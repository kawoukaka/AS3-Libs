package com.kaka.utils
{
	public class StringLimit 
	{
		public static function cutTxt (num : Number, str: String):Object
		{
			var len=str.length
			var arr = str.split ("");
			var totalLong = 0;
			var limitNum:Number=0
			var over:Boolean=false
			for (var i = 0; i < len; i ++)
			{
				arr [i].charCodeAt (0) <= 208 ? totalLong ++ : totalLong += 2;
				if(totalLong>num+1){
					limitNum=(i-1)==-1?0:i-1
					over=true
					break
				}
				else
				{
					limitNum=totalLong
				}
			}
			var _o:Object=new Object()
			_o.str=str.slice(0,limitNum)
			_o.over=over
			return _o
		}
	}
}