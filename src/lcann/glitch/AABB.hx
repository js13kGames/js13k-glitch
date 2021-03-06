package lcann.glitch;

/**
 * ...
 * @author Luke Cann
 */
class AABB{
	public var x:Float;
	public var y:Float;
	public var a:Bool;
	
	public var aabbLeft(default, null):Float;
	public var aabbRight(default, null):Float;
	public var aabbTop(default, null):Float;
	public var aabbBottom(default, null):Float;
	
	public function new(left:Float = 0, right:Float = 0, top:Float = 0, bottom:Float = 0) {
		aabbLeft = left;
		aabbRight = right;
		aabbTop = top;
		aabbBottom = bottom;
		a = true;
	}
	
	public function checkOverlap(other:AABB, xShift:Float = 0, yShift:Float = 0):Bool {
		return !(
			!a
			|| (this.x + aabbLeft > other.x + other.aabbRight + xShift)
			|| (this.x + aabbRight < other.x + other.aabbLeft + xShift)
			|| (this.y + aabbTop > other.y + other.aabbBottom + yShift)
			|| (this.y + aabbBottom < other.y + other.aabbTop + yShift)
		);
	}
	
	public function moveContactX(other:AABB, max:Float):Float{
		return moveContact(x + aabbLeft, x + aabbRight, other.x + other.aabbLeft, other.x + other.aabbRight, max);
	}
	
	public function moveContactY(other:AABB, max:Float):Float{
		return moveContact(y + aabbTop, y + aabbBottom, other.y + other.aabbTop, other.y + other.aabbBottom, max);
	}
	
	private static function moveContact(low:Float, high:Float, otherLow:Float, otherHigh:Float, max:Float):Float{
		var d:Float = max > 0 ? otherLow - high : otherHigh - low;
		return max > 0 ? Math.min(Math.abs(d), Math.abs(max)) : -Math.min(Math.abs(d), Math.abs(max));
	}
	
	public function checkPoint(px:Float, py:Float):Bool {
		if(!a){
			return false;
		}
		return !(px < x + aabbLeft || px > x + aabbRight || py < y + aabbTop || py > y + aabbBottom);
	}
}