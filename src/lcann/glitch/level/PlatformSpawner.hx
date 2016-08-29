package lcann.glitch.level;
import lcann.glitch.level.Level;

/**
 * ...
 * @author Luke Cann
 */
class PlatformSpawner extends Platform {
	private var r:Bool;//right
	private var l:Float;//Length
	private var c:Float;//countdown
	
	public function new(x:Float, y:Float, width:Float, height:Float, right:Bool, length:Float) {
		super(x, y, width, height);
		this.r = right;
		this.l = length;
		this.c = 0;
	}
	
	override public function update(level:Level, s:Float):Void {
		super.update(level, s);
		
		c -= s;
		if(c < 0){
			c = 10;
			level.platform.push(new MovingPlatform(x, y, aabbRight, aabbBottom, r, l));
		}
	}
}