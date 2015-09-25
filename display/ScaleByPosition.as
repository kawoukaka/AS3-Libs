package  com.kaka.display
{
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 *
	 * @author kaka
	 */
	 
	public class ScaleByPosition extends Sprite
	{
		private var _scalePosition:Point;
		
		public function ScaleByPosition() 
		{
			_scalePosition = new Point();
		}
		
		public function scaleByPosition(scalePos:Point, newScaleX:Number, newScaleY:Number):void
		{
			trace(scalePos , newScaleX,newScaleY)
			var scalePosInParent_Before:Point = parent.globalToLocal(this.localToGlobal(scalePos));
			scaleX = newScaleX;
			scaleY = newScaleY;
			
			var scalePosInParent_After:Point = parent.globalToLocal(this.localToGlobal(scalePos));
			
			var scalePosDisplacement:Point = scalePosInParent_After.subtract(scalePosInParent_Before);
			
			x -= scalePosDisplacement.x;
			y -= scalePosDisplacement.y;
		}
	}

}
