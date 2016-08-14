package lcann.glitch.level;

import lcann.glitch.AABB;
import lcann.glitch.level.Entity;
import lcann.glitch.level.Level;

/**
 * ...
 * @author Luke Cann
 */
class Player extends AABB implements Entity {
	private var ySpeed:Float;

	public function new(x:Float, y:Float) {
		super(-8, 8, -16, 0);
		this.x = x;
		this.y = y;
		
		ySpeed = 0;
	}
	
	/* INTERFACE lcann.glitch.Entity */
	public function update(level:Level, s:Float):Void {
		var ground:Bool = false;
		var mx:Float = Main.controls.getMovement() * 64 * s;
		ySpeed += 32 * 9 * s;
		
		for(p in level.platformLayer){
			if(p.checkOverlap(this, mx)){
				mx = 0;
			}
			if (p.checkOverlap(this, 0, ySpeed * s)) {
				if(ySpeed > 0){
					ground = true;
				}
				ySpeed = 0;
			}
		}
		
		if(ground && Main.controls.getJump()){
			ySpeed = -256;
		}
		
		y += ySpeed * s;
		x += mx;
		
		Main.c.fillStyle = "white";
		Main.c.fillRect(x - 8, y - 16, 16, 16);
	}
	
}