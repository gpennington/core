﻿	package src.core {	import flash.display.MovieClip;	import flash.events.Event;	import flash.geom.Point;	import flash.display.BlendMode;		/* GameObjects are anything that:		-can be hurt		-can break or explode		-can run into walls or obstacles		-can be shot		-has physics				Maybe		-has a counter?		-has an owner shooter?		-has behavior?		-has something happen when kill? (Not juse remove and be gone)		-is or isn't friendly?				So why are drones and Firebirds GOs?				GameObjects:		-makes a sound when it GETS hit. Projectiles don't make sounds when HIT	*/	//Base class for interactive game objects	public class GameObject extends MovieClip {		//Reference to owner, shooter, controller, master, team, etc		public var shooter;		public var friendly:Boolean;		//Basic Stats		public var hp:Number;		public var counter:Number = 0;		//Physics		public var pushSpeed:Number = 0;		public var pushAngle:Number = 0;		//Movement interpolation		protected var predictionPoint:Point;		protected var oldPoint:Point;				//Propertites		protected var isVunerable:Boolean;		//Material				var material:String; // = "wood", "organic", "metal"				public function GameObject(){			//Stage Listeners			addEventListener(Event.ADDED_TO_STAGE, waitForAdded);			function waitForAdded(e:Event):void	{				removeEventListener(Event.ADDED_TO_STAGE, waitForAdded);				addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);  //added weak ref params.  Do this for all Event Listeners			}								}			public function onFrame(e:Event){			this.blendMode = BlendMode.NORMAL; //remove this eventually with better hit graphics						if ( Game.isPaused != true ){				behavior();				counter++;			}		}				public function behavior():void{			//Empty		}		public function hit(damage){						if ( isVunerable ){				hp -= damage;					if ( hp <= 0 ){					hp=0;					kill();				}			}		}		public function kill(){			//Remove Listeners			if ( this.hasEventListener(Event.ENTER_FRAME) ){				removeEventListener(Event.ENTER_FRAME, onFrame);			}		}				public function remove(){			//Remove Listeners			if ( this.hasEventListener(Event.ENTER_FRAME) ){				removeEventListener(Event.ENTER_FRAME, onFrame);			}						Game.remove(this);								}				}}