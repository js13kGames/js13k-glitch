package lcann.glitch.level;
import lcann.glitch.level.Level;

/**
 * ...
 * @author Luke Cann
 */
class DeathPart implements Entity{
	private var x:Float;
	private var y:Float;
	private var xs:Float;
	private var ys:Float;
	
	private var w:Float;
	private var h:Float;
	private var t:Float;
	
	public function new(x:Float, y:Float, xs:Float, ys:Float) {
		this.x = x;
		this.y = y;
		this.xs = xs;
		this.ys = ys;
		
		w = 15 + Math.random() * 30;
		h = 15 + Math.random() * 30;
		t = 0.5 + Math.random() * 1.5;
	}
	
	/* INTERFACE lcann.glitch.level.Entity */
	public function update(level:Level, s:Float):Void {
		t -= s;
		
		if(t < 0){
			level.pt.remove(this);
		}
		
		x += xs * s;
		y += ys * s;
		
		Main.c.fillStyle = "orange";
		Main.c.fillRect(x, y, w, h);
	}
	
}