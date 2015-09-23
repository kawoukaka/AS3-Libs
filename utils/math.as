package com.kaka.utils 
{
	/**
	 * ...
	 * @author kaka
	 */
	public class math
	{
		public static function angleToRadian(angle:Number):Number 
		{ 
    		return angle*(Math.PI/180); 
		} 
		//弧度转换为角度 
		public static function radianToAngle(radian:Number):Number 
		{ 
			return radian*(180/Math.PI); 
		} 
		//修正角度在360度以内 
		public static function fixAngle(angle:Number):Number 
		{ 
			return (angle %= 360)<0 ? angle+360 : angle; 
		} 
		//以角度为单位计算三角函数值 
		public static function sinD(angle:Number):Number 
		{ 
			return Math.sin(angleToRadian(angle)); 
		} 
		public static function cosD(angle:Number):Number 
		{ 
			return Math.cos(angleToRadian(angle)); 
		} 
		public static function tanD(angle:Number):Number 
		{ 
			return Math.tan(angleToRadian(angle)); 
		} 
		//返回的值是以角度为单位 
		public static function asinD(radian:Number):Number 
		{ 
			return radianToAngle(Math.acos(radian)); 
		} 
		public static function acosD(radian:Number):Number 
		{ 
			return radianToAngle(Math.acos(radian)); 
		} 
		public static function atanD(radian:Number):Number 
		{ 
			return radianToAngle(Math.acos(radian)); 
		} 
		public static function atan2D(y:Number, x:Number):Number 
		{ 
			return radianToAngle(Math.atan2(y, x)); 
		} 
	}
}