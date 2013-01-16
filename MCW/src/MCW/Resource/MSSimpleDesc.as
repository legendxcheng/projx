package MCW.Resource
{
	import MCW.Resource.Util.ResManager;

	/*
		Simple Desc， a Json Object
		
	*/
	public class MSSimpleDesc extends MSResource
	{

		private var _metaJson:Object;
		
		public function MSSimpleDesc(rtype:int, rid:int)
		{
			_rtype = rtype;
			_rid = rid;
			super();
		}

		public function get metaJson():Object
		{
			return _metaJson;
		}

		public function set metaJson(value:Object):void
		{
			_metaJson = value;
			
			switch (_rtype)
			{
				case ResManager.RES_DESC_NPC:
				{
					// load npc animation
					ResManager.getInstance().getResource(ResManager.RES_IMG_ANIM, _metaJson.anim, null, 1);
					
					// load npc icon
					ResManager.getInstance().getResource(ResManager.RES_IMG_APIC, _metaJson.iconid, null, 1);
				}
					break;
				
				
			}
		}

	}
}