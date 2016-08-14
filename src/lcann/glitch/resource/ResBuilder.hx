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
import lcann.glitch.resource.level.LayerType;
import lcann.glitch.resource.level.ObjectType;
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
			platformLayer: new Array<PlatformDef>()
		}
		
		for(l in res.layers){
			switch(l.name){
				case LayerType.platform:
					buildPlatformLayer(l.objects, def);
			}
		}
		
		return def;
	}
	
	private static function buildPlatformLayer(obj:Array<Object>, def:LevelDef) {
		for (o in obj) {
			def.platformLayer.push( { 
				x: o.x,
				y: o.y,
				width: o.width,
				height: o.height
			} );
		}
	}
	#end
}