package lcann.glitch.level.enemy;
import lcann.glitch.level.Level;

/**
 * ...
 * @author Luke Cann
 */
class EnemyWalker extends Enemy {
	private var r:Bool;

	public function new(x:Float, y:Float, width:Float, height:Float) {
		super(x, y, width, height);
		r = true;
	}
	
	override public function update(level:Level, s:Float):Void {
		super.update(level, s);
		
		var mx = 400 * s;
		if(!r){
			mx = -mx;
		}
		
		for(p in level.platform){
			if (p.checkOverlap(this, mx, -1)) {
				r = mx < 0;
				mx = this.moveContactX(p, mx);
				break;
			}
		}
		
		if(this.x + aabbLeft + mx < 30){
			mx = (this.x + aabbLeft) - 30;
			r = true;
		}
		
		if(this.x + aabbRight + mx > Main.canvas.width - 30){
			mx = (Main.canvas.width - 30) - (this.x + aabbRight);
			r = false;
		}
		
		this.x += mx;
	}
}