package lcann.glitch.resource;

#if macro
import haxe.macro.Expr.Field;
import lcann.glitch.resource.level.Object;

import haxe.macro.Context;
import haxe.macro.Expr.TypeDefinition;
import htmlparser.HtmlDocument;
import sys.io.File;
import sys.FileSystem;
import haxe.Json;

import lcann.glitch.level.LevelDef;
import lcann.glitch.level.PlatformDef;
import lcann.glitch.resource.level.Level;
#end

/**
 * ...
 * @author Luke Cann
 */
class ResBuilder {

	macro public static function build(){
		var levels:Array<LevelDef> = new Array<LevelDef>();
		for (f in FileSystem.readDirectory("res/assets/lvl/")) {
			levels.push(buildLevel("res/assets/lvl/", f));
		}
		
		var c = macro class R {
			public var levels:Array<lcann.glitch.level.LevelDef> = $ { Context.parse(Json.stringify(levels), Context.currentPos()) };
			
			public function new(){}
		}
		
		Context.defineType(c);
		
		var doc = new HtmlDocument(File.getContent("res/index.html"));
		File.saveContent("bin/index.html", doc.toString());
		
		return macro new R();
	}
	
	#if macro
	private static function buildLevel(dir:String, f:String):LevelDef{
		var res:Level = Json.parse(File.getContent(dir + f));
		
		var def:LevelDef = {
			name: f,
			platformLayer: new Array<PlatformDef>(),
			player: new Array<Point>()
		}
		
		for(p in res.properties.player.split(";")){
			var xy:Array<String> = p.split(",");
			def.player.push({
				x: Std.parseInt(xy[0]) * res.tilewidth,
				y: Std.parseInt(xy[1]) * res.tileheight
			});
		}
		
		for(l in res.layers){
			switch(l.name){
				case "platform":
					buildPlatformLayer(l.objects, def);
			}
		}
		
		return def;
	}
	
	private static function buildPlatformLayer(obj:Array<Object>, def:LevelDef) {
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
						cv: o.properties.openVariable
					} );
			}
		}
	}
	#end
}