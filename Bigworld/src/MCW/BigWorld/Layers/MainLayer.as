package MCW.BigWorld.Layers
{
	import MCW.BigWorld.Display.BGChar;
	import MCW.BigWorld.Display.Base.MBasic;
	import MCW.BigWorld.Display.Base.MSprite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;

	/*
		Main layer
		A loop is run every frame, rendering all animations.
	*/
	public class MainLayer extends Sprite
	{
		private var _bitmap:Bitmap;
		private var _buffer:BitmapData; // all members are drawn here
		private var _members:Array; // an array that stores MSprites
		
		public function MainLayer()
		{
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			_members = new Array();
			// init _buffer
			_buffer = new BitmapData(1200, 600, true);
			_bitmap = new Bitmap(_buffer, "auto", true);
			this.addChild(_bitmap);
			tempInit();
		}
		
		/*
			for test
		*/
		public function tempInit():void
		{	
			var ms:BGChar = new BGChar(1000);
			ms.requestResource();
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