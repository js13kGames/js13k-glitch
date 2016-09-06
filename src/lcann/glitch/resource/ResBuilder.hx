package lcann.glitch.resource;

#if macro
import haxe.macro.Expr.Field;
import lcann.glitch.resource.level.Object;
import haxe.io.Bytes;
import haxe.macro.Context;
import haxe.macro.Expr.TypeDefinition;
import sys.io.File;
import haxe.io.Path;
import sys.FileSystem;
import haxe.Json;
import haxe.crypto.Base64;

import lcann.glitch.level.LevelDef;
import lcann.glitch.level.PlatformDef;
import lcann.glitch.resource.level.Level;
import lcann.glitch.level.PortalDef;
import lcann.glitch.level.EnemyDef;
import lcann.glitch.level.ItemDef;

import lcann.glitch.SoundDef;
import lcann.glitch.ImgDef;
#end

/**
 * ...
 * @author Luke Cann
 */
class ResBuilder {

	macro public static function build(){
		var levels:Array<LevelDef> = new Array<LevelDef>();
		var levelPath:String = "res/assets/lvl/";
		for (f in FileSystem.readDirectory(levelPath)) {
			var path:Path = new Path(levelPath + f);
			if(path.ext == "json"){
				levels.push(buildLevel(levelPath, path));
			}
		}
		
		var sounds:Array<SoundDef> = new Array<SoundDef>();
		var soundPath:String = "res/assets/snd/";
		for (f in FileSystem.readDirectory(soundPath)) {
			var path:Path = new Path(soundPath + f);
			if(path.ext == "txt"){
				sounds.push(buildSound(path));
			}
		}
		
		var images:Array<ImgDef> = new Array<ImgDef>();
		var imagePath:String = "res/assets/img/min/";
		for (f in FileSystem.readDirectory(imagePath)) {
			var path:Path = new Path(imagePath + f);
			if(path.ext == "svg"){
				images.push(buildImage(path));
			}
		}
		
		var c = macro class R {
			public var levels:Array<lcann.glitch.level.LevelDef> = $v { levels };
			public var snd:Array<lcann.glitch.SoundDef> = $v { sounds };
			public var img:Array<lcann.glitch.ImgDef> = $v { images };
			public function new(){}
		}
		
		Context.defineType(c);
		
		File.saveContent("bin/index.html", File.getContent("res/index.html"));
		
		return macro new R();
	}
	
	#if macro
	private static function buildLevel(dir:String, path:Path):LevelDef {
		var res:Level = Json.parse(File.getContent(path.toString()));
		
		var def:LevelDef = {
			name: path.file,
			platformLayer: new Array<PlatformDef>(),
			player: new Array<Point>(),
			portal: new Array<PortalDef>(),
			enemy: new Array<EnemyDef>(),
			item: new Array<ItemDef>()
		}
		
		for(p in res.properties.player.split(";")){
			var xy:Array<String> = p.split(",");
			def.player.push({
				x: Std.parseInt(xy[0]) * res.tilewidth,
				y: Std.parseInt(xy[1]) * res.tileheight - 1
			});
		}
		
		for(l in res.layers){
			switch(l.name){
				case "platform":
					buildPlatformLayer(l.objects, def, res);
				case "portal":
					buildPortalLayer(l.objects, def);
				case "enemy":
					buildEnemyLayer(l.objects, def);
				case "item":
					buildItemLayer(l.objects, def);
			}
		}
		
		return def;
	}
	
	private static function buildPlatformLayer(obj:Array<Object>, def:LevelDef, res:Level) {
		for (o in obj) {
			switch(o.type) {
				case "platform":
					def.platformLayer.push( { 
						x: o.x,
						y: o.y,
						w: o.width,
						h: o.height,
						t: "p"
					} );
				case "door":
					def.platformLayer.push( { 
						x: o.x,
						y: o.y,
						w: o.width,
						h: o.height,
						t: "d",
						cv: o.properties.variable
					} );
				case "platformSpawner":
					def.platformLayer.push( { 
						x: o.x,
						y: o.y,
						w: o.width,
						h: o.height,
						t: "s",
						cv: Std.string(Std.parseInt(o.properties.variable) * res.tilewidth),
						r: o.properties.direction == "R"
					} );
			}
		}
	}
	
	private static function buildPortalLayer(obj:Array<Object>, def:LevelDef){
		for(o in obj){
			switch(o.type){
				case "portal":
					def.portal.push({
						x: o.x,
						y: o.y,
						w: o.width,
						h: o.height,
						t: o.properties.level,
						l: Std.parseInt(o.properties.spawn)
					});
			}
		}
	}
	
	private static function buildEnemyLayer(obj:Array<Object>, def:LevelDef){
		for(o in obj){
			switch(o.type){
				case "enemy":
					def.enemy.push({
						x: o.x - o.width / 2,
						y: o.y + o.height,
						w: o.width,
						h: o.height,
						t: switch(o.name){
							case "walk":
								"w";
							case "gun":
								"g";
							case "burst":
								"b";
							case "kill":
								"k";
							default:
								"";
						},
						r: o.properties.direction == "R"
					});
			}
		}
	}
	
	private static function buildItemLayer(obj:Array<Object>, def:LevelDef){
		for(o in obj){
			switch(o.type) {
				case "key":
					def.item.push( { 
						x: o.x,
						y: o.y,
						w: o.width,
						h: o.height,
						t: "k",
						v: o.properties.variable
					} );
				case "cable":
					def.item.push({
						x: o.x,
						y: o.y,
						w: o.width,
						h: o.height,
						t: "c",
						v: o.properties.variable
					});
			}
		}
	}
	
	private static function buildSound(path:Path):SoundDef {
		var txt = File.getContent(path.toString());
		
		var arr:Array<Float> = new Array<Float>();

		for(t in txt.split(",")){
			arr.push(t.length > 0 ? Std.parseFloat(t) : 0);
		}
		
		return {
			n: path.file,
			d: arr
		}
	}
	
	private static function buildImage(path:Path):ImgDef {
		return {
			n: path.file,
			d: File.getContent(path.toString())
		}
	}
	#end
}