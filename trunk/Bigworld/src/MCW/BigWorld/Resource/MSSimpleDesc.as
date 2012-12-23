package MCW.BigWorld.Resource
{
	/*
		Simple Desc， a Json Object
		
	*/
	public class MSSimpleDesc extends MSResource
	{
		private var _metaJson:Object;
		
		
		public function MSSimpleDesc()
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

	}
}