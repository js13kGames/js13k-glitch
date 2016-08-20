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
		
		a = !checkVariable();
	}
	
	private inline function checkVariable(){
		return Main.state.flags.exists(v) ? Main.state.flags[v] : false;
	}
	
	/* INTERFACE lcann.glitch.level.Entity */
	
	public function update(level:Level, s:Float):Void {
		if (a) {
			Main.c.fillStyle = "yellow";
			Main.c.fillRect(x + aabbLeft, y + aabbTop, (x + aabbRight) - (x + aabbLeft), (y + aabbBottom) - (y + aabbTop));
			
			if(level.player.checkOverlap(this)){
				Main.state.flags[v] = true;
				a = false;
			}
		}
	}
	
}