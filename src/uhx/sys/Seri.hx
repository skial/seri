package uhx.sys;

import uhx.sys.seri.*;
import uhx.sys.seri.Unicode;

/**
 * ...
 * @author Skial Bainn
 * Haitian Creole for range
 */
class Seri {

	public static var version(default, null):Version = Unicode.version;
	
	public static inline function getCategory(category:Category):Ranges {
		return (category:Ranges);
	}
	
	public static inline function getScript(script:Script):Ranges {
		return (script:Ranges);
	}
	
	public static inline function getBlock(block:Block):Range {
		return (block:Range);
	}

	public static final categories:Array<Category> = Unicode.categories;
	public static final blocks:Array<Block> = Unicode.blocks;
	public static final scripts:Array<Script> = Unicode.scripts;
	
}