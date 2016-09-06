package lcann.glitch.level.enemy;

import lcann.glitch.level.Bullet;
import lcann.glitch.level.Level;

/**
 * ...
 * @author Luke Cann
 */
class EnemyBullet extends Bullet{

	public function new(x:Float, y:Float, xs:Float, ys:Float) {
		super(x, y, xs, ys);
	}
	
	override function destroy(level:Level):Void {
		level.eb.remove(this);
	}
	
}