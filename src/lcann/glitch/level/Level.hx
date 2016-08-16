package lcann.glitch.level;
import js.html.Point;
import lcann.glitch.level.Platform;

/**
 * ...
 * @author Luke Cann
 */
class Level{
	public var platform(default, null):Array<Platform>;
	public var portal(default, null):Array<Portal>;
	public var player(default, null):Player;
	
	public function new(levelDef:LevelDef, spawnIndex:Int) {
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
		
		player = new Player(levelDef.player[spawnIndex].x, levelDef.player[spawnIndex].y);
	}
	
	public function update(s:Float):Void{
		for (p in platform) {
			p.update(this, s);
		}
		
		player.update(this, s);
	}
}