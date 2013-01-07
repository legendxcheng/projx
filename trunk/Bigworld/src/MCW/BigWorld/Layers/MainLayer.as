package MCW.BigWorld.Layers
{
	import MCW.BigWorld.Display.BGChar;
	import MCW.BigWorld.Display.Base.MBasic;
	import MCW.BigWorld.Display.Base.MSprite;
	import MCW.BigWorld.Logic.RenderDirector;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	/*
		Main layer
		A loop is run every frame, rendering all animations.
	*/
	public class MainLayer extends Sprite
	{
		private var _bitmap:Bitmap;
		private var _buffer:BitmapData; // all members are drawn here
		private var _members:Array; // an array that stores MSprites
		
		// for performance test
		private var spriteNum:int;
		private var lastFrameMill:int;
		
		private var _mainChar:BGChar; // mainCharacter
		
		/*
			Mouse click handler			
		*/
		private function onMouseClick(e:MouseEvent):void
		{
			var cc:RenderDirector = RenderDirector.getInstance();
			var tx:int = e.stageX + cc.camX;
			var ty:int = e.stageY + cc.camY ;
			var tmp:Number = Math.sin(35/180 * Math.PI);
			var a:Number = tmp/Math.sqrt(1+tmp*tmp);
			var b:Number = 1/Math.sqrt(1+tmp*tmp);
			var nx:Number = (-ty / a + tx / b) / 2;
			var ny:Number = (tx / b + ty / a) / 2;
			var xind :int = Math.floor(nx / cc.gridSideLen);
			var yind :int = Math.floor(ny / cc.gridSideLen);
			
			
			var cy : Number = yind * cc.gridSideLen * a - xind * cc.gridSideLen * a; // circle center x
			var cx : Number = xind * cc.gridSideLen * b + yind * cc.gridSideLen * b + cc.gridSideLen * b; // circle center y
			/*
			trace(e.stageX + "," + e.stageY);
			trace(xind + "," + yind);
			trace(cx + "," + cy);
			*/
			_mainChar.setMoveTarget(cx, cy);
		}
		
		public function MainLayer()
		{
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			_members = new Array();
			// init _buffer
			_buffer = new BitmapData(1200, 600, true);
			_bitmap = new Bitmap(_buffer, "auto", true);
			this.addChild(_bitmap);
			
			spriteNum = 0;
			lastFrameMill = -1;
			
			addMainCharacterTest();
			
			this.addEventListener(MouseEvent.CLICK, onMouseClick);
			
		}
		
		public function addMainCharacterTest():void
		{
			_mainChar = new BGChar(1000);
			++spriteNum;
			_mainChar.requestResource();
			_mainChar.x = 300;
			_mainChar.y = 200;
			
			_mainChar.scaleX  =0.8;
			_mainChar.scaleY = 0.8;
			
			_members.push(_mainChar);
			
		}
		
		/*
			for test
		*/
		public function tempInit():void
		{	
			var ms:BGChar = new BGChar(1000);
			ms.debug = true;
			ms.requestResource();
			ms.x = 200;
			ms.y = 200;
			ms.scaleX = 1;
			ms.scaleY = 0.5;
			ms.rotation = 2.5;
			_members.push(ms);

		}
		
		
		private function draw():void
		{
			// clear _buffer
			_buffer.fillRect(_buffer.rect, 0);
			// TODO: iterate all members to draw
			for (var i:int = 0; i < _members.length; ++i)
			{
				var ele:MBasic = _members[i] as MBasic;
				ele.draw(_buffer, 
					RenderDirector.getInstance().camX, RenderDirector.getInstance().camY);
				
			}
		}
			
		
		private function onEnterFrame(e:Event):void
		{
			/*
			var time:int = flash.utils.getTimer();
			if (lastFrameMill > 0)
			{
				var fr:Number = 1000 / (time - lastFrameMill);
				if (fr >= 24)
				{
					this.addTest();
				}
				else
				{	
					trace(spriteNum);
				}
			}
			lastFrameMill = time;
			*/
			RenderDirector.getInstance().updtate();
			// TODO: iterate all elements, update all of them, then draw all of them onto the graphics
			for (var i:int = 0; i < _members.length; ++i)
			{
				var ele:MSprite = _members[i] as MSprite;
				ele.update();
			}
			draw();
			
			RenderDirector.getInstance().bgLayer.update();
			//_mainChar.setColorOffset(Math.random() * 100, Math.random() * 100, Math.random() * 100);
		}
		
		
	}
}