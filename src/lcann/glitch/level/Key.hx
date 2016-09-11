package lcann.glitch.level;

import js.html.ImageElement;
import lcann.glitch.AABB;
import lcann.glitch.level.Level;

/**
 * ...
 * @author Luke Cann
 */
class Key extends AABB implements Entity{
	private var v:String;
	private var i:ImageElement;
	
	public function new(x:Float, y:Float, w:Float, h:Float, v:String, i:String) {
		super(0, w, 0, h);
		this.x = x;
		this.y = y;
		this.v = v;
		this.i = Main.img.get(i);
		
		a = !Main.checkStateFlag(v);
	}
	
	/* INTERFACE lcann.glitch.level.Entity */
	public function update(level:Level, s:Float):Void {
		if (a) {
			Main.c.drawImage(i, 0, 0, i.naturalWidth, i.naturalHeight, x + aabbLeft, y + aabbTop, (x + aabbRight) - (x + aabbLeft), (y + aabbBottom) - (y + aabbTop));
			
			if(level.player.checkOverlap(this)){
				Main.state.flags[v] = true;
				a = false;
				Main.sound.play("key");
			}
		}
	}
	
}