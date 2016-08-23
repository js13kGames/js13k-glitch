package lcann.glitch.level;
import lcann.glitch.level.Level;

/**
 * ...
 * @author Luke Cann
 */
class Door extends Platform{
	private var v:String;
	
	public function new(x:Float, y:Float, w:Float, h:Float, v:String) {
		super(x, y, w, h);
		this.v = v;
		this.a = !Main.checkStateFlag(v);
	}
	
	override public function update(level:Level, s:Float):Void {
		if(a){
			Main.c.fillStyle = "blue";
			Main.c.fillRect(x, y, aabbRight, aabbBottom);
			
			a = !Main.checkStateFlag(v);
		}
	}
	
}