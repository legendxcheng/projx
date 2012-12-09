package Resource
{
	
	import flash.display.BitmapData;

	// Aniamtion class
	// Just stores frames' bitmapdata.
	public class MSAnimation extends MSResource
	{
		private var _rid:int; // resource id
		private var _anchorX:int;
		private var _anchorY:int;
		private var _frames:Array;// array of int
		private var _bitmaps:Array;// array of bitmap
		private var _size:int;
		
		public function set rid(value:int):void
		{
			_rid = value;
		}

		public function get anchorY():int
		{
			return _anchorY;
		}

		public function get anchorX():int
		{
			return _anchorX;
		}

		public function frameNum():int
		{
			return _frames.length;
		}
		
		public function MSAnimation()
		{
			_frames = null;
		}
		
		public function getBitmapData(frame:int):BitmapData
		{
			return _bitmaps[_frames[frame]];
		}
		
		public function clearFrames():void
		{
			_frames = new Array();
			_size = 0;
		}
		
		public function addBitmap(bitmap:BitmapData):void
		{
			_bitmaps.push(bitmap);
		}
		
		public function addFrame(fra:int):void
		{
			_frames.push(fra);
		}
		
		/*
			interface IResource
		*/
		override public function onResLoaded(rtype:int, rid:int):void
		{
			//TODO
		}
		
		override public function release():void
		{
			//TODO
		}
			
	}
}