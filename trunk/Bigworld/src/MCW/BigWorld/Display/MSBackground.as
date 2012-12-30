package MCW.BigWorld.Display
{
	import MCW.Resource.MSPic;
	import MCW.Resource.Util.ResManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	/*
		background buffer
	*/
	public class MSBackground
	{
		private var _bitmap:Bitmap;
		private var _msbg:MSPic;
		private var _rid:int;
		
		public function MSBackground(rid:int)
		{
			super();
			this.requestResource(rid);// first request
			_bitmap = new Bitmap();
			_bitmap.bitmapData = null;

		}
		
		// first request the low quality resource

		public function get bitmap():Bitmap
		{
			return _bitmap;
		}

		public function requestResource(arid:int):void
		{
			var bmd:BitmapData;
			_msbg = ResManager.getInstance().getImgResByID(arid, this, 1) as MSPic;
			if (_msbg != null) //  load Successfully
			{
				_bitmap.bitmapData = _msbg.bmd;
			}
		}
		
		public function onResLoaded(rtype:int, rid:int):void
		{
			if (_msbg == null || rid > _msbg.metaJson.rid) // higher quality res loaded
			{
				_msbg = ResManager.getInstance().getImgResByID(rid, this, 1) as MSPic;
				if (_bitmap.bitmapData != null)
				{
					_bitmap.bitmapData.dispose();
				}
				_bitmap.bitmapData = _msbg.bmd;
				
				// if current quality is not high, then request higher
				if (_msbg.metaJson.quality == "low")
					requestResource(_msbg.metaJson.stdid);
				else if (_msbg.metaJson.quality == "std")
					requestResource(_msbg.metaJson.highid);
				
			}
		}
	}
}