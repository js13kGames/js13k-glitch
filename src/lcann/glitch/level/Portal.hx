package lcann.glitch.level;

import lcann.glitch.AABB;

/**
 * ...
 * @author Luke Cann
 */
class Portal extends AABB{
	public var level(default, null):String;
	public var spawn(default, null):Int;
	
	public function new(x:Float, y:Float, width:Float, height:Float, level:String, spawn:Int) {
		super(0, width, 0, height);
		this.x = x;
		this.y = y;
		this.level = level;
		this.spawn = spawn;
	}
}