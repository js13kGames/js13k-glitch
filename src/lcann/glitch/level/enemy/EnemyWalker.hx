package lcann.glitch.level.enemy;
import lcann.glitch.level.Level;

/**
 * ...
 * @author Luke Cann
 */
class EnemyWalker extends Enemy {
	private var r:Bool;
	private var xs:Float;
	private var i:String;

	public function new(x:Float, y:Float, w:Float, h:Float, r:Bool ) {
		super(x, y, w, h);
		this.r = r;
		xs = 400;
		hp = 2;
		
		i = h > w ? "wlkt" : "wlk";
	}
	
	override public function update(level:Level, s:Float):Void {
		super.update(level, s);
		
		var mx = xs * s;
		if(!r){
			mx = -mx;
		}
		
		var ledge = true;
		
		for (p in level.platform) {
			if(p.checkOverlap(this, mx > 0 ? mx - this.aabbLeft*2 : mx - this.aabbRight*2, 10)){
				ledge = false;
			}
			
			if(p.checkOverlap(this, mx, -1)){
				r = mx < 0;
				mx = this.moveContactX(p, mx);
				break;
			}
			
			
		}
		
		if(ledge){
			r = !r;
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
	
	override public function draw():Void {
		Main.c.drawImage(Main.img.get(ht > 0 ? i + "_h" : i), this.x + aabbLeft, this.y + aabbTop);
	}
}