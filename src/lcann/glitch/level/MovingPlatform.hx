package lcann.glitch.level;
import lcann.glitch.level.Level;

/**
 * ...
 * @author Luke Cann
 */
class MovingPlatform extends Platform{
	public var xs(default, null):Float;
	private var l:Float;
	private var g:Bool;
	
	public function new(x:Float, y:Float, width:Float, height:Float, right:Bool, length:Float) {
		super(x, y, width, height);
		this.xs = right ? 240 : -240;
		this.l = length;
		this.g = false;
	}
	
	override public function update(level:Level, s:Float):Void {
		if(g && Main.doClear){
			if (aabbRight > l) {
				if(xs > 0){
					x += (aabbRight - l);
				}	
				aabbRight = l;
			}
		}
		g = !Main.doClear;
		
		if(aabbRight < l || g){
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