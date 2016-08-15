package lcann.glitch.level;
import lcann.glitch.level.Level;

/**
 * ...
 * @author Luke Cann
 */
class Door extends Platform{

	private var variable:String;
	
	public function new(x:Float, y:Float, width:Float, height:Float, variable:String) {
		super(x, y, width, height);
		this.variable = variable;
	}
	
	override public function update(level:Level, s:Float):Void {
		Main.c.fillStyle = "blue";
		Main.c.fillRect(x, y, aabbRight, aabbBottom);
	}
	
}