<?php 
/*
	Copyright (C) 2010  Felix Nyffenegger

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

*/

include_once("inc/config.inc.php");

$wiki = "";
$topic = "";
if (isset($_GET["wiki"])) {
	$wiki = $_GET["wiki"];
}
if (isset($_GET["topic"])) {
	$topic = $_GET["topic"];
}
?>
 <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>WikiMindMap</title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1";  charset="iso-8895-1">
        <meta name="keywords" content="Wiki, Wikipedia, Mindmap, Mind-Map, browse, knowledge network">
        <meta name="description" content="WikiMindMap is a tool to browse easily and efficiently in Wiki content, inspired by the mindmap technique">
        <script type="text/javascript" src="js/flashobject.js">
        </script>
        <link rel='stylesheet' type='text/css' href='assets/wmm.css' />
    </head>
    <body>
        <p align="center">
            <img src="assets/logo.gif">
        </p>
        <form name="search" action="viewmap.php" method="get">
            <p align="center">
                Select a Wiki:
                <select name="wiki">
                    <option <?php echo ($wiki == "ca.wikipedia.org" ? "selected" : ""); ?> >ca.wikipedia.org</option>
                    <option <?php echo ($wiki == "de.wikipedia.org" ? "selected" : ""); ?> >de.wikipedia.org</option>
                    <option <?php echo ($wiki == "en.wikipedia.org" ? "selected" : ""); ?> >en.wikipedia.org</option>
                    <option <?php echo ($wiki == "es.wikipedia.org" ? "selected" : ""); ?> >es.wikipedia.org</option>
                    <option <?php echo ($wiki == "fr.wikipedia.org" ? "selected" : ""); ?> >fr.wikipedia.org</option>
                    <option <?php echo ($wiki == "id.wikipedia.org" ? "selected" : ""); ?> >id.wikipedia.org</option>
                    <option <?php echo ($wiki == "it.wikipedia.org" ? "selected" : ""); ?> >it.wikipedia.org</option>
                    <option <?php echo ($wiki == "nl.wikipedia.org" ? "selected" : ""); ?> >nl.wikipedia.org</option>
                    <option <?php echo ($wiki == "pl.wikipedia.org" ? "selected" : ""); ?> >pl.wikipedia.org</option>
                    <option <?php echo ($wiki == "pt.wikipedia.org" ? "selected" : ""); ?> >pt.wikipedia.org</option>
                    <option <?php echo ($wiki == "sv.wikipedia.org" ? "selected" : ""); ?> >sv.wikipedia.org</option>
                </select>
                Enter your Topic:<input name="topic" type="text" value="<?php echo $topic; ?>">&nbsp;<input type="submit" value="Search">
            </p>
        </form>
        <table width="100%" border="0" cellspacing="0">
            <tr>
                <td colspan="3" class="bar">
                    <div align="left" class="menuText">
                        &nbsp;<a href="getfreemind.php?Wiki=<?php echo $wiki; ?>&Topic=<?php echo  urlencode($topic); ?>">Download this mindmap as Freemind file</a>
                    </div>
                </td>
            </tr>
            <tr>
                <td width="5%">
                    &nbsp;
                </td>
                <td width="90%" height="400">
                    <div id="flashcontent">
                        <p>
                            Flash plugin or Javascript are turned off. 
                            Activate both  and reload to view the mindmap 
                        </p>
                    </div>
                    <script type="text/javascript">
                        setTimeout("runFlash()", 1);
                        //runFlash();
                        function getWindowHeight(){
                            var windowHeight = 0;
                            if (typeof(window.innerHeight) == 'number') {
                                windowHeight = window.innerHeight;
                            }
                            else {
                                if (document.documentElement && document.documentElement.clientHeight) {
                                    windowHeight = document.documentElement.clientHeight;
                                }
                                else {
                                    if (document.body && document.body.clientHeight) {
                                        windowHeight = document.body.clientHeight;
                                    }
                                }
                            }
                            return windowHeight;
                        }
                        
                        function runFlash(){
                            var h = getWindowHeight();
                            h = h - 200;
                            
                            document.getElementById("flashcontent").style.height = h;
                            var fo = new FlashObject("visorFreemind.swf", "visorFreeMind", "100%", h, 6, "#9999ff");
                            fo.addParam("quality", "high");
                            fo.addParam("bgcolor", "#ffffff");
                            fo.addVariable("openUrl", "_blank");
                            fo.addVariable("initLoadFile", "getpages.php?Wiki=<?php echo $wiki; ?>&Topic=<?php echo  urlencode($topic); ?>");
                            fo.addVariable("startCollapsedToLevel", "1");
                            fo.addVariable("mainNodeShape", "bubble");
                            fo.write("flashcontent");
                        };
                    </script>
                </td>
                <td width="5%">
                    &nbsp;
                </td>
            </tr>
            <tr class="bar">
                <td colspan="3">
                    <span class="menuText">
                        <?php 
							if ($production) {
								echo '<a href="help.htm">Help</a> <a href="about.htm">About / Support WikiMindMap</a> <a href="contact.htm">Contact</a>';
							} else
							{
								echo 'Development Version';
							}
						?>
                    </span>
                </td>
            </tr>
        </table>
        <div align="center" class="footerText">
            All content of the mindmap is derived from the wiki selected above and is licensed under the terms of <a href="http://www.gnu.org/copyleft/fdl.html" target="_blank">GNU Free Documentaion Licence</a>. You can retrieve the original material by a left click on the topic.
            <br>
            Copyright (c) 2007 by Felix Nyffenegger 
        </div>
        <p>
            &nbsp;
        </p>
        <script type="text/javascript">
            var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
            document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
        </script>
    </body>
</html>
