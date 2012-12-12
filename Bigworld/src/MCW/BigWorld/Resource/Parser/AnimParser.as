package MCW.BigWorld.Resource.Parser
{
	import MCW.BigWorld.Resource.MSAnimation;
	import MCW.BigWorld.Resource.Util.ResManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.ByteArray;

	/*
		class for parsing animation
	*/
	public class AnimParser implements IParser
	{
		private var _rid:int;
		private var _data:ByteArray;
		private var _anim:MSAnimation;
		
		protected var _rgbLoader:Loader
		protected var _aLoader:Loader;
		
		private var _rgbLoaded:Boolean;// if rgbBuffer loaded
		private var _aLoaded:Boolean;// if alpha Buffer loaded
		
		private var _rgbBuf:BitmapData;
		private var _aBuf:BitmapData;
		
		public function AnimParser(rid:int, data:*)
		{
			_rid = rid;
			_data = data as ByteArray;
			
			_aLoader = new Loader();
			_aLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onRGBLoaded)
			_rgbLoader = new Loader();
			_rgbLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onALoaded)
		}
		
		// parse resource and then plug it
		public function parseResource():void
		{
			_anim = new MSAnimation();
			var jsonStr:String = _data.readUTF();
			_anim.metaJson = JSON.parse(jsonStr);
			jsonStr = _data.readUTF();
			_anim.tpJson = JSON.parse(jsonStr);
			_aLoaded = _rgbLoaded = false;
			
			var length:int = _data.readInt();
			var rgbdata:ByteArray = new ByteArray();
			var adata:ByteArray = new ByteArray();
			_data.readBytes(rgbdata, 0, length);
			_rgbLoader.loadBytes(rgbdata);
			
			// load second jpg
			length = _data.readInt();
			_data.readBytes(adata, 0, length);
			_aLoader.loadBytes(adata);
		}
		
		protected function onRGBLoaded(e:Event):void {
			var tmpBmp:Bitmap = _rgbLoader.content as Bitmap;
			_rgbBuf = tmpBmp.bitmapData;
			
			if (_rgbBuf.width == 0 || _rgbBuf.height == 0) {
				//returnError();
				return;
			}
			
			
			_rgbLoaded = true;
			
			if (_rgbLoaded && _aLoaded)
			{
				//if (onComplete != null)
					//onComplete(metaJson.rid);
				// merge them	
				mergeBuf();
			}
		}

		protected function onALoaded(e:Event):void 
		{
			
			var tmpBmp:Bitmap = _aLoader.content as Bitmap;
			_aBuf = tmpBmp.bitmapData;
			
			if (_aBuf.width == 0 || _aBuf.height == 0) 
			{
				//returnError();
				return;
			}
			
			
			_aLoaded = true;
			
			if (_rgbLoaded && _aLoaded)
			{
				//if (onComplete != null)
				//onComplete(metaJson.rid);
				// merge them	
				mergeBuf();
			}
		
		
		}
		
		
		
		public function mergeBuf():void
		{
			var mBuf:BitmapData = new BitmapData(_aBuf.width, _aBuf.height, true, 0);
			mBuf.copyChannel(_aBuf, _aBuf.rect, new Point(0, 0), BitmapDataChannel.BLUE, BitmapDataChannel.ALPHA);
			mBuf.merge(_rgbBuf, _rgbBuf.rect, new Point(0, 0), 255, 255, 255, 0);
			
			_aBuf.dispose();
			_aBuf = null;
			_rgbBuf.dispose();
			_rgbBuf = null;
			
			_anim.buffer = mBuf;
			
			// after merge, plug _anim to resManager
			var resMgr:ResManager = ResManager.getInstance();
			resMgr.plugResource(ResManager.RES_TYPE_IMAGE, _rid, _anim);
		}
	}
}