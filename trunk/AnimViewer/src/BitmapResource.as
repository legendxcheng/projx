package
{
	
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
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
		protected var rgbLoader:Loader;
		protected var aLoader:Loader;
		protected var totalFrame:int;
		
		public var onComplete:Function;
		public var onError:Function;
		public var rgbLoaded:Boolean;
		public var alphaLoaded:Boolean;
		public var rgbBuf:Bitmap;
		public var aBuf:Bitmap;
		public var mBuf:Bitmap;
		public var metaJson:Object
		public var tpJson:Object;
		protected var size_:int;
		
		public function get size():int {
			return size_;
		}
		public function get anchorPointX():int {
			return metaJson.anchorX;
		}
		public function get anchorPointY():int {
			return metaJson.anchorY;
		}
		public function get width():int {
			return rgbBuf.bitmapData.width;
		}
		public function get height():int {
			return rgbBuf.bitmapData.height;
		}
		
		public function BitmapResource()
		{
			aLoader = new Loader();
			aLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onRGBLoaded)
			rgbLoader = new Loader();
			rgbLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onALoaded)
		}
		
		
		public function load(bytes:ByteArray):void {
			this.bytes = bytes;
			completeFlag = false;
			var jsonStr:String = bytes.readUTF();
			metaJson = JSON.parse(jsonStr);
			jsonStr = bytes.readUTF();
			tpJson = JSON.parse(jsonStr);
			alphaLoaded = rgbLoaded = false;
			loadImage();
					
			
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
		protected function loadImage():void {
			/*
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
			*/
			
			// load first jpg
			var length:int = bytes.readInt();
			var rgbdata:ByteArray = new ByteArray();
			var adata:ByteArray = new ByteArray();
			bytes.readBytes(rgbdata, 0, length);
			rgbLoader.loadBytes(rgbdata);
			
			// load second jpg
			length = bytes.readInt();
			bytes.readBytes(adata, 0, length);
			aLoader.loadBytes(adata);
			
		}
		protected function onRGBLoaded(e:Event):void {
			rgbBuf = rgbLoader.content as Bitmap;
			if (rgbBuf.width == 0 || rgbBuf.height == 0) {
				returnError();
				return;
			}
			
			size_ += rgbBuf.width * rgbBuf.height * 4;
			rgbLoaded = true;
			
			if (rgbLoaded && alphaLoaded)
			{
				if (onComplete != null)
					onComplete(metaJson.rid);
				// merge them	
				mergeBuf();
			}
		}
		
		
		public function mergeBuf():void
		{
			mBuf = new Bitmap();
			mBuf.bitmapData= new BitmapData(aBuf.bitmapData.width, aBuf.bitmapData.height, true, 0);
			mBuf.bitmapData.copyChannel(aBuf.bitmapData, aBuf.bitmapData.rect, new Point(0, 0), BitmapDataChannel.BLUE, BitmapDataChannel.ALPHA);
			mBuf.bitmapData.merge(rgbBuf.bitmapData, rgbBuf.bitmapData.rect, new Point(0, 0), 255, 255, 255, 0);
			
			aBuf.bitmapData.dispose();
			aBuf = null;
			rgbBuf.bitmapData.dispose();
			rgbBuf = null;
		}
		protected function onALoaded(e:Event):void {
			aBuf = aLoader.content as Bitmap;
			if (aBuf.width == 0 || aBuf.height == 0) {
				returnError();
				return;
			}
			
			
			alphaLoaded = true;
			if (rgbLoaded && alphaLoaded)
			{
				if (onComplete != null)
					onComplete(metaJson.rid);
				// merge them		
				
				mergeBuf();
			}
		}
		
		protected function returnError():void {
			if (onError != null)
				onError(resourceID_);
		}
		public function getFrame(frame:int):Bitmap {
			/*
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
			*/
			frame %= metaJson.animation.length;
			var fid:String = metaJson.frameName[metaJson.animation[frame]];
			var ret:Bitmap = new Bitmap()
			var tmp:Object = tpJson.frames[fid];
			ret.bitmapData = new BitmapData(tmp.sourceSize.w, tmp.sourceSize.h, true);
			
			ret.bitmapData.copyPixels(mBuf.bitmapData, new Rectangle(tmp.frame.x, tmp.frame.y, tmp.frame.w, tmp.frame.h),
				new Point(tmp.spriteSourceSize.x, tmp.spriteSourceSize.y));
			
			return ret;
		}
	}
}