package lcann.glitch.level;
import lcann.glitch.level.Level;

/**
 * ...
 * @author Luke Cann
 */
class Cable implements Entity {
	private var x:Float;
	private var y:Float;
	private var w:Float;
	private var h:Float;
	
	private var v:String; //variable

	public function new(x:Float, y:Float, w:Float, h:Float, v:String) {
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
		this.v = v;
	}
	
	/* INTERFACE lcann.glitch.level.Entity */
	public function update(level:Level, s:Float):Void {
		Main.c.fillStyle = Main.checkStateFlag(v) ? "grey" : "orange";
		Main.c.fillRect(x, y, w, h);
	}
	
}