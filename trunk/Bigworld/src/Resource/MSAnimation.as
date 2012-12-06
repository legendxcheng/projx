package Resource
{
	import flash.display.BitmapData;

	// Aniamtion class
	// Just stores frames' bitmapdata.
	public class MSAnimation
	{
		var _frames:Array;
		
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
			return _frames[frame];
		}
		
		public function clearFrames():void
		{
			_frames = new Array();
		}
		
		public function addFrame(nframe:BitmapData):void
		{
			_frames.push(nframe);
		}
	}
}