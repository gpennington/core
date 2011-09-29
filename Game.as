﻿package src.core {	import flash.display.MovieClip;	import flash.events.Event;	import flash.text.TextField;	import flash.utils.setInterval;	import flash.system.System;	import src.core.Input;	public class Game extends MovieClip{		public static var gameRef;		//input class		var input:Input;		//Meta Info		public static var isPaused:Boolean = false;		//Game layers		public static var currentLevel = new MovieClip();		//Debug		var debug:MovieClip;		//TODO Work on making debug tools available to other games.		//Development helpers		public static var text_trace:TextField;		var text_trace2:TextField;		var fpsCount:int = 0;		public function Game(){			gameRef = this;						this.addEventListener(Event.ADDED_TO_STAGE, waitForAdded);								}//game				public function waitForAdded(e:Event):void	{			//Game specific  layer here				addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);			//Add input class			input = new Input();			addChild(input);			//Debug			if ( Settings.debug ){				debug = new MovieClip();				addChild(debug);				createDebug();			}			//FPS counter			setInterval(updateFPSCount, 1000);		}		private function onFrame(e:Event){									if ( Game.isPaused != true ){				//fps				fpsCount++;								//Debug stuff				if ( Settings.debug ){					//text_trace2.text = "Current Level: " + currentLevel + "\n X: " + currentLevel.mouseX + "\n Y: " + currentLevel.mouseY + "\n "; // + currentLevel.player.playerRef.x;				}			} //isPaused											}// onFrame						public function loadLevel(level, stageComplete){			//Old Level			removeChild(currentLevel);			currentLevel = null;		}				public static function remove(whichObject){						//Remove the objects children  //DO I EVEN NEED TO DO THIS?			while ( whichObject.hasOwnProperty("numChildren") && whichObject.numChildren > 0 ){				var child = whichObject.getChildAt(0);				//trace(whichObject + ": " + child + " removed");					whichObject.removeChild(child);				child = null;							}						//Remove the object			//trace(whichObject + " removed");			whichObject.parent.removeChild(whichObject);							whichObject = null;		}		public function pauseGame(){			//empty		}		private function updateFPSCount(){			if ( Settings.debug ){				text_trace.text = "FPS: " + fpsCount + "\n Memory: " + (System.totalMemoryNumber / 1000000).toFixed(2) + "MB \n";				fpsCount=0;			}		}				//Create Debug 		private function createDebug(){			//Trace			text_trace = new TextField();			text_trace.textColor = 0xffffff;			text_trace.x = 0;			text_trace.width = 640;			text_trace.y = 200;			text_trace.mouseEnabled = false;			debug.addChild(text_trace);			//			text_trace2 = new TextField();//			text_trace2.textColor = 0xffffff;//			text_trace2.x = 0;//			text_trace2.width = 640;//			text_trace2.y = 440;//			text_trace2.mouseEnabled = false;//			debug.addChild(text_trace2);		}	}}