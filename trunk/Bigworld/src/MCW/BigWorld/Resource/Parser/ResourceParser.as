package MCW.BigWorld.Resource.Parser
{
	import MCW.BigWorld.Resource.Util.ResManager;
	/*
		class for resource parsing
		only provides static functions
	*/
	public class ResourceParser
	{
		public function ResourceParser()
		{
		}

		
		// parse image resource
		static public function parseImgRes(rid:int, data:Class):Class
		{
			if (rid >= 20000 && rid <= 39999)// animation
			{
				var ap:AnimParser = new AnimParser(rid, data);
				ap.parseResource();
				
				//return parseAnimation(data);
			}
			return null;
		}
		
		static public function parseRes(rtype:int, rid:int, data:Class):Class
		{
			// TODO: parse res due to different types of resources
			switch (rtype)	
			{
				case ResManager.RES_TYPE_IMAGE:
				{
					return parseImgRes(rid, data);
				}
					break;
				case ResManager.RES_TYPE_SOUND:
				{
					
				}
					break;
				case ResManager.RES_TYPE_DESC:
				{
					
				}
					break;
				case ResManager.RES_TYPE_SCRIPT:
				{
					
				}
					break;
			}
			return null;
		}
	}
}