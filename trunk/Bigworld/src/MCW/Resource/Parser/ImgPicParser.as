package MCW.Resource.Parser
{
	import MCW.Resource.MSPic;
	import MCW.Resource.Util.ResManager;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import org.osmf.media.LoadableElementBase;

	/*
		parser for parsing picture with different quality
		png format
	*/
	public class ImgPicParser implements IParser
	{
		private var _rtype:int;
		private var _rid:int;
		private var _data:ByteArray;
		private var _mpic:MSPic;
		private var _pLoader:Loader;
		public function ImgPicParser(rtype:int, rid:int, data:*)
		{
			_rtype = rtype;
			_rid = rid;
			_data = data;
		}
		
		public function parseResource():void
		{
			/*
			{
			“rid”: ,
			“Quality”: “low” “std” “high”
			“low_rid”:
			“std_rid”:
			“high_rid”:
			}
			*/
			_mpic = new MSPic();
			var jsonStr:String = _data.readUTF();
			var json:Object = JSON.parse(jsonStr);
			_mpic.metaJson = json;
			
			var length:int = _data.readInt();
			var pdata:ByteArray = new ByteArray();
			_data.readBytes(pdata, 0, length);
			
			_pLoader = new Loader();
			_pLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onPLoaded);
			_pLoader.loadBytes(pdata);

			
		}
		
		private function onPLoaded(e:Event):void
		{
			var tmpBmp:Bitmap = _pLoader.content as Bitmap;
			_mpic.bmd = tmpBmp.bitmapData;
			
			if (_mpic.bmd.width == 0 || _mpic.bmd.height == 0) {
				//returnError();
				return;
			}
			
			// plug resource	
			ResManager.getInstance().plugResource(_rtype, _rid, _mpic);
		}
	}
}