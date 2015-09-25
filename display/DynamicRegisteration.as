
package com.kaka.display
{
	import flash.geom.Point;
	import flash.display.DisplayObject;
	
	public class DynamicRegisteration
	{

		public static function move(target:DisplayObject, registration:Point, x:Number = 0, y:Number = 0):void
		{
			//generate the location of the registration point in the parent
			registration = target.localToGlobal(registration);
			registration = target.parent.globalToLocal(registration);
			
			//move the target and offset by the registration point
			target.x += x - registration.x;
			target.y += y - registration.y;
		}
		
	
		public static function rotate(target:DisplayObject, registration:Point, degrees:Number = 0):void
		{
			changePropertyOnRegistrationPoint(target, registration, "rotation", degrees);
		}
		
	
		public static function scale(target:DisplayObject, registration:Point, scaleX:Number = 0, scaleY:Number = 0):void
		{
			changePropertyOnRegistrationPoint(target, registration, "scaleX", scaleX);
			changePropertyOnRegistrationPoint(target, registration, "scaleY", scaleY);
		}
		
		private static function changePropertyOnRegistrationPoint(target:DisplayObject, registration:Point, propertyName:String, value:Number):void
		{
			//generate the location of the registration point in the parent
			var a:Point = registration.clone();
			a = target.localToGlobal(a);
			a = target.parent.globalToLocal(a);
			
			target[propertyName] = value;
			
			//after the property change, regenerate the location of the registration
			//point in the parent
			var b:Point = registration.clone();
			b = target.localToGlobal(b);
			b = target.parent.globalToLocal(b);
			
			//move the target based on the difference to make it appear the change
			//happened based on the registration point
			target.x -= b.x - a.x;
			target.y -= b.y - a.y;
		}
		
	}
}
