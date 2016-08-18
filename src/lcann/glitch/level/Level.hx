package lcann.glitch.level;
import js.html.Point;
import lcann.glitch.level.Platform;
import lcann.glitch.level.enemy.Enemy;

/**
 * ...
 * @author Luke Cann
 */
class Level {
	public var player(default, null):Player;
	
	public var platform(default, null):Array<Platform>;
	public var portal(default, null):Array<Portal>;
	public var enemy(default, null):Array<Enemy>;
	
	
	public function new(levelDef:LevelDef, spawnIndex:Int) {
		player = new Player(levelDef.player[spawnIndex].x, levelDef.player[spawnIndex].y);
		
		platform = new Array<Platform>();
		for (p in levelDef.platformLayer) {
			switch(p.t) {
				case "p":
					platform.push(new Platform(p.x, p.y, p.w, p.h));
				case "d":
					platform.push(new Door(p.x, p.y, p.w, p.h, p.cv));
			}
		}
		
		portal = new Array<Portal>();
		for(p in levelDef.portal){
			portal.push(new Portal(p.x, p.y, p.w, p.h, p.t, p.l));
		}
		
		enemy = new Array<Enemy>();
		
	}
	
	public function update(s:Float):Void{
		for (p in platform) {
			p.update(this, s);
		}
		
		player.update(this, s);
	}
}