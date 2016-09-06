package lcann.glitch.level;
import lcann.glitch.AABB;
import lcann.glitch.level.Entity;
import lcann.glitch.level.Level;
import lcann.glitch.level.enemy.Enemy;
import lcann.glitch.level.enemy.EnemyBurster;
import lcann.glitch.level.enemy.EnemyGun;
import lcann.glitch.level.enemy.EnemyWalker;
import lcann.glitch.level.enemy.KillRegion;

/**
 * ...
 * @author Luke Cann
 */
class Level {
	public var player(default, null):Player;
	
	public var platform(default, null):List<Platform>;
	public var portal(default, null):Array<Portal>;
	public var enemy(default, null):List<Enemy>;
	public var item(default, null):Array<Entity>;
	
	public var pt(default, null):List<Entity>;
	public var pb(default, null):List<Bullet>;
	public var eb(default, null):List<Bullet>;
	
	public function new(levelDef:LevelDef, spawnIndex:Int) {
		player = new Player(levelDef.player[spawnIndex].x, levelDef.player[spawnIndex].y);
		
		platform = new List<Platform>();
		for (p in levelDef.platformLayer) {
			switch(p.t) {
				case "p":
					platform.add(new Platform(p.x, p.y, p.w, p.h));
				case "d":
					platform.add(new Door(p.x, p.y, p.w, p.h, p.cv));
				case "s":
					platform.add(new PlatformSpawner(p.x, p.y, p.w, p.h, p.r, Std.parseFloat(p.cv)));
			}
		}
		
		portal = new Array<Portal>();
		for(p in levelDef.portal){
			portal.push(new Portal(p.x, p.y, p.w, p.h, p.t, p.l));
		}
		
		enemy = new List<Enemy>();
		for(e in levelDef.enemy){
			switch(e.t){
				case "w":
					enemy.add(new EnemyWalker(e.x, e.y, e.w, e.h, e.r));
				case "g":
					enemy.add(new EnemyGun(e.x, e.y, e.w, e.h, e.r));
				case "b":
					enemy.add(new EnemyBurster(e.x, e.y, e.w, e.h, e.r));
				case "k":
					enemy.add(new KillRegion(e.x, e.y, e.w, e.h));
			}
		}
		
		item = new Array<Entity>();
		for(i in levelDef.item){
			switch(i.t){
				case "k":
					item.push(new Key(i.x, i.y, i.w, i.h, i.v));
				case "c":
					item.push(new Cable(i.x, i.y, i.w, i.h, i.v));
			}
		}
		
		pt = new List<Entity>();
		pb = new List<Bullet>();
		eb = new List<Bullet>();
	}
	
	public function update(s:Float):Void{
		for (p in platform) {
			p.update(this, s);
		}
		
		for(e in enemy){
			e.update(this, s);
		}
		
		for(i in item){
			i.update(this, s);
		}
		
		for(b in pb){
			b.update(this, s);
		}
		
		for(b in eb){
			b.update(this, s);
		}
		
		player.update(this, s);
		
		for(p in pt){
			p.update(this, s);
		}
	}
	
	public function createDeathParts(aabb:AABB, minA:Float, maxA:Float){
		var hqty:Int = Std.int(((aabb.x + aabb.aabbRight) - (aabb.x + aabb.aabbLeft)) / 15);
		var vqty:Int = Std.int(((aabb.y + aabb.aabbBottom) - (aabb.y + aabb.aabbTop)) / 15);
		
		for (yi in 0...vqty) {
			var y = (aabb.y + aabb.aabbTop) + yi * 15;
			
			for(xi in 0...hqty){
				var x = (aabb.x + aabb.aabbLeft) + xi * 15;
				
				pt.add(new DeathPart(x, y, -15 + Math.random() * 30, -15 + Math.random() * 30));
			}
		}
	}
}