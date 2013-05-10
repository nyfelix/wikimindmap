============================================================================

                     	     WIKIMINDMAP 1.0


Author:
Felix Nyffenegger, Nova Innovation Solutions GmbH (www.nova-innovation.com)

Copyright (c) 2009 by Nova Innovation Solutions GmbH
Licence: GNU GPL Version 3

============================================================================

1. Introduction
2. Requirements
3. Installation
4. Configuration
4.1 Server-Side
4.2 Client-Side
5. Contributions



1. Introduction
---------------

WikiMindMap is a tool to browse easily and efficiently in Wiki content, 
inspired by the mindmap technique. Wiki pages in large public wiki's, 
such as wikipedia, have become rich and complex documents. Thus, it is not 
allways straight forward to find the information you are really looking for. 
This tool aims to support users to get a good structured and easy 
understandable overview of the topic you are looking for.

WikiMidMap is licenced unter GNU GPL Version 3

For more information see: http://www.wikimindmap.org

The flashbrowser is an adaped version of the freemind flash browser, written
by Juan Pedro de Andres. For details and source code see subfolder 
/actionscript/MindMapBrowser
http://freemind.sourceforge.net/wiki/index.php/Flash_browser
. 


2. Requirements
---------------

WikiMindMap requires the following Components:

- Webserver (e.g. Apache)
- PHP 5.2   (earlier versions might work, but are not tested)
- Flash 8.0 (earlier versions might work, but are not tested)


3. Intallation
--------------

This packages contains the follwing files and folders:
   /actionscript/MindMapBrowser     : Contains the Sourcefiles of the flash browser
   /public	                    : Contains all files needed to run WikiMindMap
   /public/getpages.php		    : This is the core of WikiMindMap
   /public/visorFreemind.swf	    : The binary of the flash browser
   /public/js/flashobject.js        : Needed by the flash browser

To install Wikiminmap, copy the files of subfolder /ServerScripts to any 
directory of your webserver. And set parameters according to 4.

4. Configuration
----------------

   4.1 Server-Side:
   ----------------
   In getpages.php you will find the follwing section:

        //-------------------------------------------------------------------------------------------
        // 	Wiki-Specific Settings
        //	======================
        //	This is the one and only place, where you have to configure something.
        //	This settings depend on the media-wiki installation
        //	Please note, that the URL to the wiki is passed from the client via GET method.
        //	If you intend to access more then one wiki, you will have to set these settings, based
        //	on the wiki you recieved from $_GET['Wiki'].
        //-------------------------------------------------------------------------------------------
	
	
        $viewerURL   = "viewmap.php";        // This is the local file, where your WikiBrowser is included 
        $index_path  = "/w";                 // This is the path to the index.php of the Mediawiki installation,
                                             // relative to the wiki URL (usually it is "")
        $access_path = "/wiki";              // This is where you can show a wiki page, specific to the topic.
                                             // relative to the wiki URL  (usually it is $index_path.'/index.php?title=')
        // The URL encrypte the the path where the raw data of a wiki topic can be accessed.
        $url = 'http://'.$wiki.$index_path.'/index.php?title='.$topic.'&action=raw'; 

   You have to change these settings according to your local wiki-installation. 
   These values will work with wikipedia. However, typical media-wiki installations
   use the settings, mentioned in the comment.

  4.2 Clientside
  --------------

  viewmap.php shows, how the flashbrowser is linked to getpages.php to retriev 
  the mindmap data. Most important is the following line, here you tell the server, 
  which topic and which wiki to address:

  fo.addVariable("initLoadFile", "getpages.php?Wiki=en.wikipedia.org&Topic=<?php echo  urlencode($_GET['topic']); ?>");

  
5. Contribution
---------------

Every contriubiton to wikimindmap.org is welcome. For more details visit:
http://www.wikimindmap.org
http://github.com/nyfelix/wikimindmap
