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
		super(-30, 30, -140, 0);
		this.x = x;
		this.y = y;
		
		ySpeed = 0;
	}
	
	/* INTERFACE lcann.glitch.Entity */
	public function update(level:Level, s:Float):Void {
		ySpeed += 2000 * s;
		
		var ground:Bool = false;
		var mx:Float = Main.controls.getMovement() * 480 * s;
		var my:Float = ySpeed * s;
		
		
		for(p in level.platform){
			if (p.checkOverlap(this, 0, my)) {
				if(ySpeed > 0){
					ground = true;
				}
				//Move to contact
				my = this.moveContactY(p, my);
				my = my > 0 ? my - 0.2 : my + 0.2;
				ySpeed = 0;
			}
			
			if(p.checkOverlap(this, mx)){
				//move to contact
				mx = this.moveContactX(p, mx);
				mx = mx > 0 ? mx - 0.2 : mx + 0.2;
			}
		}
		
		if(ground && Main.controls.getJump()){
			ySpeed = -1100;
			my += ySpeed * s;
		}
		
		x += mx;
		y += my;
		
		for(p in level.portal){
			if(p.checkOverlap(this)){
				Main.loadLevel(p.level, p.spawn);
			}
		}
		
		Main.c.fillStyle = "white";
		Main.c.fillRect(x - 30, y - 140, 60, 140);
	}
	
}