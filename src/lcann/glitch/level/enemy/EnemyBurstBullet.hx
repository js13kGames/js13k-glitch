package lcann.glitch.level.enemy;
import lcann.glitch.level.Level;

/**
 * ...
 * @author Luke Cann
 */
class EnemyBurstBullet extends EnemyBullet{
	public function new(x:Float, y:Float, xs:Float, ys:Float) {
		super(x, y, xs, ys);
	}
	
	override public function update(level:Level, s:Float):Void {
		ys += 700 * s;
		super.update(level, s);
	}
}