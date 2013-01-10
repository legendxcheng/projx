package MCW.Resource
{
	import flash.display.BitmapData;

	/*
		class for single picture
		maybe with three copies of quality
		for imgAPic imgPic
	*/
	public class MSPic extends MSResource
	{
		private var _metaJson:Object;
		private var _bmd:BitmapData;
		
		
		public function MSPic()
		{
			super();
		}
		
		
		public function get metaJson():Object
		{
			return _metaJson;
		}

		public function set metaJson(value:Object):void
		{
			_metaJson = value;
		}

		public function get bmd():BitmapData
		{
			return _bmd;
		}

		public function set bmd(value:BitmapData):void
		{
			_bmd = value;
		}

		
		override public function release():void
		{
			this._bmd.dispose();
		}
	}
}