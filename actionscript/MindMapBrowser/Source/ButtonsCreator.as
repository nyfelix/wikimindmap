/*FreeMind - A Program for creating and viewing Mindmaps
 *Copyright (C) 2000-2005  Joerg Mueller, Daniel Polansky, Christian Foltin, Felix Nyffenegger and others.
 *
 *See COPYING for Details
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either version 2
 *of the License, or (at your option) any later version.
 *
 *This program is distributed in the hope that it will be useful,
 *but WITHOUT ANY WARRANTY; without even the implied warranty of
 *MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *GNU General Public License for more details.
 *
 *You should have received a copy of the GNU General Public License
 *along with this program; if not, write to the Free Software
 *Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 *
 * Created on 25.04.2005
 */
import visorFreeMind.*;
/**
*	Create al the buttons used in the Browser
*/
class visorFreeMind.ButtonsCreator{
	//Buttons
	private var resizer:MovieClip;
	private var bGrow:MovieClip;
	private var bShrink:MovieClip;
	private var bSearch:MovieClip;
	private var bPan:MovieClip;
	private var hidden:MovieClip;
	private var mc_Color;
	private var mc_Color_rollout;
	private var mainColor;
	public static var alfa=100;
	public static var min_alpha_buttons=40;
	public static var max_alpha_buttons=100;
	private var browser:Browser;
	public static var mc_now_over:MovieClip=null;
	public static var listFade={};
	public static var buttonsPos="top";//top|bottom
	public  static var colors=[0xFFFFFF,0xEEEEEE,0xDDDDDD,
							   0xEEFFFF,0xFFEEFF,0xFFFFEE,
								0xFFEEEE,0xEEFFEE,0xEEEEFF];

	public function ButtonsCreator(browser:Browser){
		this.browser=browser;
		resetMainColor();
		//createFading(browser);
		trace("ButtonsCreator created");
	}

	/*private function createFading(browser:Browser){
		this.hidden=browser.mc_container.createEmptyMovieClip("hidden",7800);
		this.hidden.onEnterFrame=function(){
			//disminuimos los que esten en la tabla
			for(var objeto in ButtonsCreator.listFade){
				var mc_aux=ButtonsCreator.listFade[objeto];
				if(ButtonsCreator.mc_now_over!=mc_aux){
					if(mc_aux._alpha>ButtonsCreator.min_alpha_buttons){
						mc_aux._alpha=mc_aux._alpha-2;
					}else{
						delete ButtonsCreator.listFade[objeto];
					}
				}
			}
			
			if(ButtonsCreator.mc_now_over!=null ){
				if( ButtonsCreator.mc_now_over._alpha<ButtonsCreator.max_alpha_buttons){
				ButtonsCreator.mc_now_over._alpha=ButtonsCreator.mc_now_over._alpha+20;
				}
				ButtonsCreator.listFade[ButtonsCreator.mc_now_over._name]=ButtonsCreator.mc_now_over;
			}
		}
	}*/
	
	function resetAlpha(){
		resizer._alpha=min_alpha_buttons;
		bGrow._alpha=min_alpha_buttons;
		bShrink._alpha=min_alpha_buttons;
		bPan._alpha=min_alpha_buttons;
		bSearch._alpha=min_alpha_buttons;
	}
	
	function resetMainColor(){
		/*var color=browser.floor.getBackgroundColor();
		var nRed = (color >> 16)-0x33;
		nRed=nRed>=0?nRed:0;
		var nGreen= ((color >> 8) & 0xff)-0x33;
		nGreen=nGreen>=0?nGreen:0;
		var nBlue= (color & 0xff)-0x33;
		nBlue=nBlue>=0?nBlue:0;
		this.mainColor=(nRed<<16 | nGreen<<8 |nBlue);*/
		//trace(color+"("+nRed+","+nGreen+","+nBlue+")->"+this.mainColor+"\n");
		createSizeButtons(browser.mc_container);
		//createNavigationButtons(browser.mc_container);
		//createHistoryButton(browser.mc_container);
		createSearchButton(browser.mc_container);
		if(Browser.flashVersion>=8)
			createPanButton(browser.mc_container);
		relocateAllButtons();
		//addToolTipsButtons();
		//resetAlpha();
	}
	


	// For resize of Stage
	function relocateAllButtons(){
		var yPos=buttonsPos=="top"?10:Stage.height-10;
		yPos += -5
		var newCenter=Stage.width/2;
		bGrow._x=newCenter-20;
		bGrow._y=yPos;
		bShrink._x=newCenter;
		bShrink._y=yPos;
		//bSearch._y=yPos;
		//bSearch._x=newCenter-112;
		bPan._y=yPos;
		bPan._x=newCenter+32;
	}

	function drawCircle(mc_container:MovieClip,accuracy, x, y, radius)
	{
		var span = Math.PI/accuracy;
		var controlRadius = radius/Math.cos(span);
		var anchorAngle=0, controlAngle=0;
		mc_container.moveTo(x+Math.cos(anchorAngle)*radius, y+Math.sin(anchorAngle)*radius);
		for (var i=0; i<accuracy; ++i) {
			controlAngle = anchorAngle+span;
			anchorAngle = controlAngle+span;
			mc_container.curveTo(   x + Math.cos(controlAngle)*controlRadius,
							y + Math.sin(controlAngle)*controlRadius,
							x + Math.cos(anchorAngle)*radius,
							y + Math.sin(anchorAngle)*radius );
		}
	}
	
	function drawRectangleB(mc_container:MovieClip,mainColor,alfa,alfaLine,s){
		mc_container.lineStyle(1,mainColor,alfaLine);
		mc_container.beginFill(mainColor,alfa);
		mc_container.moveTo(-s,-s);
		mc_container.lineTo(s,-s);
		mc_container.lineTo(s,s);
		mc_container.lineTo(-s,s);
		mc_container.lineTo(-s,-s);
		mc_container.endFill();
	}
	
	function createSearchButton(mc_container:MovieClip){
		bSearch=mc_container.createEmptyMovieClip("bSearch",100000);
		bSearch.browser=browser;
		bSearch.bCreator=this;
		bSearch.info_text="show search dialog";
		bSearch._x = Stage.width/2-170;
		bSearch._y = -10
		browser.searchDialog.show(bSearch,0xFFFFFF);
		browser.historyManager.pt.hide();
		
		bSearch.onRollOver=function(){

			ButtonsCreator.mc_now_over=this;
		}
	}
	
	function createPanButton(mc_container:MovieClip){
		bPan=mc_container.createEmptyMovieClip("bPan",7799);
		bPan.browser=browser;
		bPan.bCreator=this;
		bPan.info_text="show search dialog";

		bPan.lineStyle(2,0x999999,100);
		bPan.beginFill(0x000000,10);
		drawCircle(bPan,10,6,6,6);
		bPan.moveTo(9,11);
		bPan.lineTo(14,16);
		bPan.lineTo(16,14);
		bPan.lineTo(11,9);
		bPan.endFill();
		

		
		
		bPan.onRollOver=function(){
			this.browser.panner.show(this);
			this.browser.historyManager.pt.hide();
			//this.browser.searchDialog.hide();
			ButtonsCreator.mc_now_over=this;
		}
	}
	
	function createSizeButtons(mc_container){
		bGrow=mc_container.createEmptyMovieClip("increase",7788);
		bGrow.browser=browser;
		
		bShrink=mc_container.createEmptyMovieClip("shrink",7789);
		bShrink.browser=browser;

		bGrow.lineStyle(2,0x999999,100);
		bGrow.beginFill(0x000000,10);
		drawCircle(bGrow,10,8,8,8);
		bGrow.endFill();
		bGrow.lineStyle(2,0x999999,100);
		bGrow.moveTo(5,8);
		bGrow.lineTo(11,8);
		bGrow.moveTo(8,5);
		bGrow.lineTo(8,11);
		
		bShrink.lineStyle(2,0x999999,100);
		bShrink.beginFill(0x000000,10);
		drawCircle(bShrink,10,8,8,8);
		bShrink.endFill();
		bShrink.lineStyle(2,0x999999,100);
		bShrink.moveTo(5,8);
		bShrink.lineTo(11,8);
		

		bGrow.onPress=function(){

			this.browser.upscale();

		}
		bShrink.onPress=function(){
			this.browser.downscale();

		}
		

		
	}
}
