Just a personal freemind flash browser.
It does only load jpg's images (limitation of flash),
 it will improve with time.
 
 For the easy of development flashout (http://www.potapenko.com/flashout/) have
 been used with Eclipse.

DIFFERENCE TO THE ORIGINAL VERSION:

The version in front of you is not the original Version of freemind falsh browser, 
written be Juan Pedro de Andres. It is a modified version, which serves special 
purposes of WikiMindMap.org. 

If you want to see the original version, go to: 
	http://freemind.sourceforge.net/wiki/index.php/Flash_browser

If you want to find out mor about WikiMindMap, go to:
	 http://www.wikimindmap.org

If you want to know what the major changes between the two versions are see:
	changes.txt in this directory.



USE:
 - insert in any browser page like in the example.

 CONFIGURATION:
	All this variables can be added in the script. None of then if needed, they all
	have default values.

	//Where to open a link: 
	//default="_self"
		fo.addVariable("openUrl", "_self");

	// IF we want to initiate de freemind with al the nodes collapset from this level
	// =default "-1" that means, do nothing
		fo.addVariable("startCollapsedToLevel","1");

	// Initial mindmap to load
	// default="index.mm"
		fo.addVariable("initLoadFile", "index.mm");

 
CONFIGURATION OLD MODE:
	 		
	For iexplorer
	 <param name="FlashVars" value="initLoadFile=index.mm"/>
	For others
	 <embed FlashVars="initLoadFile=index.mm" 