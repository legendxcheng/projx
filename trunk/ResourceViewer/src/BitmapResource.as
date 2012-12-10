package
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;

	public class BitmapResource
	{
		protected var resourceID_:int;
		protected var anchorPointX_:int;
		protected var anchorPointY_:int;
		protected var bitmap:Vector.<Bitmap>;
		protected var keyframeSeq:Vector.<int>;
		protected var keyframeDuration:Vector.<int>;
		protected var completeFlag:Boolean;
		protected var bytes:ByteArray;
		protected var bitmapLoader:Loader;
		protected var totalFrame:int;
		
		public var onComplete:Function;
		public var onError:Function;
		
		protected var size_:int;
		
		public function get size():int {
			return size_;
		}
		public function get anchorPointX():int {
			return anchorPointX_;
		}
		public function get anchorPointY():int {
			return anchorPointY_;
		}
		public function get width():int {
			return bitmap[0].width;
		}
		public function get height():int {
			return bitmap[0].height;
		}
		
		public function BitmapResource()
		{
			bitmapLoader = new Loader();
			bitmapLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onFrameLoaded)
		}
		public function load(bytes:ByteArray):void {
			this.bytes = bytes;
			completeFlag = false;
			var jsonStr:String = bytes.readUTF();
			
			/*
			var xml:XML = new XML(xmlStr);
			resourceID_ = xml.id;
			anchorPointX_ = xml.anchorPoint.x;
			anchorPointY_ = xml.anchorPoint.y;
			bitmap = new Vector.<Bitmap>();
			keyframeSeq = new Vector.<int>();
			keyframeDuration = new Vector.<int>();
			totalFrame = 0;
			for (var i:int = 0; i < xml.animation.id.length(); i ++) {
				keyframeSeq.push(xml.animation.id[i]);
				keyframeDuration.push(xml.animation.duration[i]);
				var duration:int = xml.animation.duration[i];
				totalFrame += duration;
			}
			if (resourceID_ == 0 || keyframeDuration.length == 0) {
				returnError();
				return;
			}
			if (keyframeDuration[keyframeDuration.length - 1] == 0)
				totalFrame = 0;
			size_ = 0;
			loadFrame();
			*/
		}
		protected function loadFrame():void {
			if (bitmap.length > keyframeSeq.length) {
				returnError();
				return;
			}
			if (bytes.length - bytes.position < 4) {
				returnError();
				return;
			}
			var length:int = bytes.readInt();
			if (bytes.length - bytes.position < length) {
				returnError();
				return;
			}
			var bitmapData:ByteArray = new ByteArray();
			bytes.readBytes(bitmapData, 0, length);
			bitmapLoader.loadBytes(bitmapData);
		}
		protected function onFrameLoaded(e:Event):void {
			var frame:Bitmap = bitmapLoader.content as Bitmap;
			if (frame.width == 0 || frame.height == 0) {
				returnError();
				return;
			}
			bitmap.push(frame);
			size_ += frame.width * frame.height * 4;
			if (bytes.length - bytes.position > 0) {
				loadFrame();
			} else if (bitmap.length == keyframeSeq.length) {
				bytes = null;
				completeFlag = true;
				if (onComplete != null)
					onComplete(resourceID_);
			} else {
				returnError();
			}
		}
		protected function returnError():void {
			if (onError != null)
				onError(resourceID_);
		}
		public function getFrame(frame:int):Bitmap {
			if (totalFrame > 0) {
				frame %= totalFrame;
			}
			var sum:int = 0;
			for (var i:int = 0; i < bitmap.length; i ++) {
				sum += keyframeDuration[i];
				if (frame < sum) {
					return bitmap[i];
				}
			}
			return bitmap[bitmap.length - 1];
		}
	}
}