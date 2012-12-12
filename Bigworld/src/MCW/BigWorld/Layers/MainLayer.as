package MCW.BigWorld.Layers
{
	import MCW.BigWorld.Display.BGChar;
	import MCW.BigWorld.Display.Base.MBasic;
	import MCW.BigWorld.Display.Base.MSprite;
	import MCW.BigWorld.Logic.ControlCenter;
	
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
		
			
			
			
		}
		
		public function addTest():void
		{
			var tt:BGChar = new BGChar(1);
			++spriteNum;
			tt.requestResource();
			tt.x = Math.random() * 1200;
			tt.y = Math.random() * 600;
			/*tt.scaleX = Math.random() * 3;
			tt.scaleY = Math.random() * 3;
			tt.rotation = Math.random() * Math.PI * 2;*/
			tt.debug = true;
			_members.push(tt);
			
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
			ms.scaleY = 1;
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
				ele.draw(_buffer);
				
			}
		}
			
		
		private function onEnterFrame(e:Event):void
		{
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
			
			ControlCenter.getInstance().updtate();
			// TODO: iterate all elements, update all of them, then draw all of them onto the graphics
			for (var i:int = 0; i < _members.length; ++i)
			{
				var ele:MSprite = _members[i] as MSprite;
				ele.update();
			}
			draw();
		}
		
		
	}
}