package lcann.glitch.level.enemy;
import lcann.glitch.AABB;
import lcann.glitch.level.Entity;
import lcann.glitch.level.Level;

/**
 * ...
 * @author Luke Cann
 */
class Enemy extends AABB implements Entity {
	private var ht:Float;
	private var hp:Int;

	public function new(x:Float, y:Float, width:Float, height:Float) {
		super( -width / 2, width / 2, -height, 0);
		this.x = x + width;
		this.y = y;
		
		this.ht = 0;
		this.hp = 1;
	}
	
	/* INTERFACE lcann.glitch.level.Entity */
	public function update(level:Level, s:Float):Void {
		for(b in level.pb){
			if(b.checkOverlap(this)){
				level.pb.remove(b);
				hp--;
				ht = 0.2;
				Main.sound.play("hit");
			}
		}
		
		if(hp == 0){
			level.createDeathParts(this, 0, 0);
			level.enemy.remove(this);
			Main.sound.play("eki");
		}
		
		if(ht > 0){
			ht -= s;
			Main.c.fillStyle = "white";
		}else{
			Main.c.fillStyle = "red";
		}
		Main.c.fillRect(x + aabbLeft, y + aabbTop, (x + aabbRight) - (x + aabbLeft), (y + aabbBottom) - (y + aabbTop));
	}
}