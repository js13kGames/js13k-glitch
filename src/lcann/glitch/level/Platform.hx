package lcann.glitch.level;
import lcann.glitch.level.Level;

/**
 * ...
 * @author Luke Cann
 */
class Platform extends AABB implements Entity{
	
	public function new(x:Float, y:Float, width:Float, height:Float) {
		super(0, width, 0, height);
		this.x = x;
		this.y = y;
	}
	
	/* INTERFACE lcann.glitch.Entity */
	public function update(level:Level, s:Float):Void {
		Main.c.fillStyle = "white";
		Main.c.fillRect(x, y, aabbRight, aabbBottom);
	}
}