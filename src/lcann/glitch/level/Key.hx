package lcann.glitch.level;

import lcann.glitch.AABB;
import lcann.glitch.level.Level;

/**
 * ...
 * @author Luke Cann
 */
class Key extends AABB implements Entity{
	private var v:String;
	
	public function new(x:Float, y:Float, w:Float, h:Float, v:String) {
		super(0, w, 0, h);
		this.x = x;
		this.y = y;
		this.v = v;
		
		a = !Main.checkStateFlag(v);
	}
	
	/* INTERFACE lcann.glitch.level.Entity */
	public function update(level:Level, s:Float):Void {
		if (a) {
			Main.c.drawImage(Main.img.get("key"), 0, 0, 100, 100, x + aabbLeft, y + aabbTop, (x + aabbRight) - (x + aabbLeft), (y + aabbBottom) - (y + aabbTop));
			
			if(level.player.checkOverlap(this)){
				Main.state.flags[v] = true;
				a = false;
				Main.sound.play("key");
			}
		}
	}
	
}