package MCW.Resource
{
	import MCW.Resource.Util.ResManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	// Aniamtion class
	// Just stores frames' bitmapdata.
	public class MSAnimation extends MSResource
	{
	
		private var _frames:Array;// array of int
		
		private var _buffer:BitmapData;// merged buffer
		

		
		// for space utilization
		private var _lastBMD:BitmapData
		private var _lastFrame:int;
		
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
		
		public function checkFrame(frame:int):int
		{
			if (_metaJson.playonce == 1)
			{
				if (frame >= _metaJson.animation.length)
				{
					frame = _metaJson.animation.length - 1;
				}
			}
			else
			{
				frame %= _metaJson.animation.length;
			}
			return frame;
			
		}

		public function set rid(value:int):void
		{
			_rid = value;
		}
		
		public function getAnchorPoint(frame:int):Point
		{

				
			frame = checkFrame(frame);
			var fid:String = _metaJson.frameName[_metaJson.animation[frame]];
			var tmp:Object = _tpJson.frames[fid];
			/*return new Point(tmp.frame.x + _metaJson.anchorX - tmp.spriteSourceSize.x, 
				tmp.frame.y + _metaJson.anchorY - tmp.spriteSourceSize.y);
			*/
			return new Point( _metaJson.anchorX - tmp.spriteSourceSize.x, 
				_metaJson.anchorY - tmp.spriteSourceSize.y);
		
		}

		public function frameNum():int
		{
			return _metaJson.animation.length;
		}
		
		public function MSAnimation()
		{
			_frames = null;
			_lastBMD = null;
			_lastFrame = 0;
		}
		
		//
		public function getBitmapData(frame:int):BitmapData
		{
			// TODO:
			frame = checkFrame(frame);
			
			var fid:String = _metaJson.frameName[_metaJson.animation[frame]];
			var tmp:Object = _tpJson.frames[fid];
			
			/* cannot do this, for maybe there are many msprites which are using this MSAnimation*/
			/*
			if (_lastBMD == null || _metaJson.animation[frame] != _lastFrame)
			{
				_lastFrame = _metaJson.animation[frame];
				if (_lastBMD != null)
					_lastBMD.dispose();
				_lastBMD = new BitmapData(tmp.frame.w, tmp.frame.h);
				_lastBMD.copyPixels(_buffer, new Rectangle(tmp.frame.x, tmp.frame.y, tmp.frame.w, tmp.frame.h), new Point(0, 0));
			}
			
			return _lastBMD;
			*/
			
			var bmd:BitmapData = new BitmapData(tmp.frame.w, tmp.frame.h);
			bmd.copyPixels(_buffer, new Rectangle(tmp.frame.x, tmp.frame.y, tmp.frame.w, tmp.frame.h), new Point(0, 0));
			return bmd;
			
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
		
		override public function getType():int
		{
			return ResManager.RES_IMG_ANIM;
		}
		
		override public function release():void
		{
			//TODO
		}
		
		
		public function getBasicRect(frame:int):Rectangle
		{
			frame = checkFrame(frame);
			
			var fid:String = _metaJson.frameName[_metaJson.animation[frame]];
			var tmp:Object = _tpJson.frames[fid];
			return new Rectangle(tmp.frame.x, tmp.frame.y, tmp.frame.w, tmp.frame.h);
		}
		
		public function getBasicPoint(frame:int):Point
		{
			frame = checkFrame(frame);
			var fid:String = _metaJson.frameName[_metaJson.animation[frame]];
			var tmp:Object = _tpJson.frames[fid];
			return new Point(tmp.spriteSourceSize.x - _metaJson.anchorX, tmp.spriteSourceSize.y - _metaJson.anchorY);
			
		}
		
		
		
		public function getClipRect(frame:int):Rectangle
		{
			
			frame = checkFrame(frame);
			var fid:String = _metaJson.frameName[_metaJson.animation[frame]];
			var tmp:Object = _tpJson.frames[fid];
			return new Rectangle(tmp.spriteSourceSize.x - _metaJson.anchorX, 
				tmp.spriteSourceSize.y - _metaJson.anchorY, tmp.frame.w, tmp.frame.h);
		}
			
	}
}