package lcann.glitch.level;

import lcann.glitch.AABB;
import lcann.glitch.level.Level;

/**
 * ...
 * @author Luke Cann
 */
class Bullet extends AABB implements Entity{
	private var xs:Float;
	private var ys:Float;
	
	public function new(x:Float, y:Float, xs:Float, ys:Float) {
		super(-8, 8, -8, 8);
		this.x = x;
		this.y = y;
		this.xs = xs;
		this.ys = ys;
	}
	
	/* INTERFACE lcann.glitch.level.Entity */
	public function update(level:Level, s:Float):Void {
		this.x += xs * s;
		this.y += ys * s;
		
		if(this.x + aabbRight < 0 || this.x + aabbLeft > Main.canvas.width){
			destroy(level);
			return;
		}
		
		for(p in level.platform){
			if (p.checkOverlap(this)) {
				Main.sound.play("wal");
				destroy(level);
				return;
			}
		}
		
		Main.c.fillStyle = "red";
		Main.c.fillRect(x + aabbLeft, y + aabbTop, (x + aabbRight) - (x + aabbLeft), (y + aabbBottom) - (y + aabbTop));
	}
	
	private function destroy(level:Level):Void{
		
	}
	
}