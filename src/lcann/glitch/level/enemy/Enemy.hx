package lcann.glitch.level.enemy;
import lcann.glitch.AABB;
import lcann.glitch.level.Entity;
import lcann.glitch.level.Level;

/**
 * ...
 * @author Luke Cann
 */
class Enemy extends AABB implements Entity{

	public function new(x:Float, y:Float, width:Float, height:Float) {
		super( -width / 2, width / 2, -height, 0);
		this.x = x;
		this.y = y;
	}
	
	/* INTERFACE lcann.glitch.level.Entity */
	public function update(level:Level, s:Float):Void {
		Main.c.fillStyle = "red";
		Main.c.fillRect(x + aabbLeft, y + aabbTop, (x + aabbRight) - (x + aabbLeft), (y + aabbBottom) - (y + aabbTop));
	}
}