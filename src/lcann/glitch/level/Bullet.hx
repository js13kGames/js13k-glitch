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
		
		Main.c.save();
		Main.c.translate(x, y);
		Main.c.rotate(Math.atan2(ys, xs));
		
		Main.c.drawImage(Main.img.get("blt"), 0, 0, 16, 16, aabbLeft, aabbTop, aabbRight - aabbLeft, aabbBottom - aabbTop);
		Main.c.restore();
	}
	
	private function destroy(level:Level):Void{
		
	}
	
}