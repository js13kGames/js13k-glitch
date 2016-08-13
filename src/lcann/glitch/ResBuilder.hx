package lcann.glitch;

#if macro
import haxe.macro.Context;
import htmlparser.HtmlDocument;
import sys.io.File;
#end

/**
 * ...
 * @author Luke Cann
 */
class ResBuilder{
	macro public static function build(){
		var c = macro class R {
			public static var test = "hi";
		}
		Context.defineType(c);
		
		var doc = new HtmlDocument(File.getContent("res/index.html"));
		File.saveContent("bin/index.html", doc.toString());
		return macro null;
	}
}