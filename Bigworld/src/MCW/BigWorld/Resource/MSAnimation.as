package MCW.BigWorld.Resource
{
	import MCW.BigWorld.Resource.Util.ResManager;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	// Aniamtion class
	// Just stores frames' bitmapdata.
	public class MSAnimation extends MSResource
	{
		private var _rid:int; // resource id
		private var _frames:Array;// array of int
		
		private var _buffer:BitmapData;// merged buffer
		
		private var _size:int;
		
		// json data
		private var _metaJson:Object;
		private var _tpJson:Object;
		
		public function get buffer():BitmapData
		{
			return _buffer;
		}

		public function set tpJson(value:Object):void
		{
			_tpJson = value;
		}

		public function set metaJson(value:Object):void
		{
			_metaJson = value;
		}

		public function set buffer(value:BitmapData):void
		{
			_buffer = value;
			_size = _buffer.width * _buffer.height * 4;

		}

		public function set rid(value:int):void
		{
			_rid = value;
		}
		
		public function getAnchorPoint(frame:int):Point
		{
			frame %= _metaJson.animation.length;
			var fid:String = _metaJson.frameName[_metaJson.animation[frame]];
			var tmp:Object = _tpJson.frames[fid];
			return new Point(_metaJson.anchorX - tmp.spriteSrouceSize.x, _metaJson.anchorY - tmp.spriteSrouceSize.y);
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
			// TODO:
			return null;
		}
		
		public function clearFrames():void
		{
			_frames = new Array();
			_size = 0;
		}
		
		public function addBitmap(bitmap:BitmapData):void
		{
			// TODO:
			//_bitmaps.push(bitmap);
		}
		
		public function addFrame(fra:int):void
		{
			_frames.push(fra);
		}
		
		override public function release():void
		{
			//TODO
		}
		
		override public function getType():int
		{
			return ResManager.RES_TYPE_IMAGE;
		}
		
		public function getClipRect(frame:int):Rectangle
		{
			frame %= _metaJson.animation.length;
			var fid:String = _metaJson.frameName[_metaJson.animation[frame]];
			var tmp:Object = _tpJson.frames[fid];
			return new Rectangle(tmp.frame.x, tmp.frame.y, tmp.frame.w, tmp.frame.h);
		}
			
	}
}