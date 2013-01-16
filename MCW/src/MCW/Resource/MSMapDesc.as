package MCW.Resource
{
	/*
		map resource 
		desc
	*/
	public class MSMapDesc extends MSResource
	{
		private var _metaJson:Object;
		private var _tArea:Vector.<Boolean>;
		private var _pArea:Vector.<Boolean>;
		
		
		public function MSMapDesc(rtype:int ,rid:int)
		{
			super();
			_rtype = rtype;
			_rid = rid;
		}

		public function get pArea():Vector.<Boolean>
		{
			return _pArea;
		}

		public function set pArea(value:Vector.<Boolean>):void
		{
			_pArea = value;
		}

		public function get tArea():Vector.<Boolean>
		{
			return _tArea;
		}

		public function set tArea(value:Vector.<Boolean>):void
		{
			_tArea = value;
		}

		public function get metaJson():Object
		{
			return _metaJson;
		}

		public function set metaJson(value:Object):void
		{
			_metaJson = value;
		}

	}
}