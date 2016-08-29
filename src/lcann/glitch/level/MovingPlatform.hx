package lcann.glitch.level;
import lcann.glitch.level.Level;

/**
 * ...
 * @author Luke Cann
 */
class MovingPlatform extends Platform{
	public var xs(default, null):Float;
	private var l:Float;
	
	public function new(x:Float, y:Float, width:Float, height:Float, right:Bool, length:Float) {
		super(x, y, width, height);
		this.xs = right ? 240 : -240;
		this.l = length;
	}
	
	override public function update(level:Level, s:Float):Void {
		if(aabbRight < l){
			aabbRight += Math.abs(xs) * s;
			if(xs < 0){
				x += xs * s;
			}
		}else{
			x += xs * s;
		}
		
		super.update(level, s);
		
		if(x > Main.canvas.width || x + aabbRight < 0){
			level.platform.remove(this);
		}
	}
	
}