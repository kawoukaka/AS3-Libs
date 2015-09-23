package com.kaka.utils
{
	public class randomExpand
	{
		public function randomExpand()
		{
			
		}
		public static function toInteger(numberMin:int = 0, numberMax:int = 0) : int 
		{
			return Math.round(Math.random() * ((numberMax - numberMin) + numberMin));
		}
	}
}