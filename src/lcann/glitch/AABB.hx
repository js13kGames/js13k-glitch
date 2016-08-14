package lcann.glitch;

/**
 * ...
 * @author Luke Cann
 */
class AABB{
	public var x:Float;
	public var y:Float;
	
	public var aabbLeft(default, null):Float;
	public var aabbRight(default, null):Float;
	public var aabbTop(default, null):Float;
	public var aabbBottom(default, null):Float;
	
	public function new(left:Float = 0, right:Float = 0, top:Float = 0, bottom:Float = 0) {
		aabbLeft = left;
		aabbRight = right;
		aabbTop = top;
		aabbBottom = bottom;
	}
	
	public function checkOverlap(other:AABB, xShift:Float = 0, yShift:Float = 0):Bool{
		if(this.x + aabbLeft > other.x + other.aabbRight + xShift){
			return false;
		}
		
		if(this.x + aabbRight < other.x + other.aabbLeft + xShift){
			return false;
		}
		
		if(this.y + aabbTop > other.y + other.aabbBottom){
			return false;
		}
		
		if(this.y + aabbBottom < other.y + other.aabbTop){
			return false;
		}
		
		return true;
	}
}