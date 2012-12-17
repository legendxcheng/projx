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
		static public function parseDescRes(rid:int, data:*):*
		{
			
			
			if (rid >= 0 && rid <1000)// map desc
			{
				var mp:DescMapParser = new DescMapParser(rid, data);	
				mp.parseResource();
				mp = null;
			}
			else if (rid < 2000)// bg char desc
			{
				var sp:DescSimpleParser = new DescSimpleParser(rid, data);
				sp.parseResource();
				sp = null;
			}
			
				
			//return parseAnimation(data);
			
			return null;
		}
		
		// parse image resource
		static public function parseImgRes(rid:int, data:*):*
		{
			if (rid >= 20000 && rid <= 39999)// animation
			{
				var ap:AnimParser = new AnimParser(rid, data);
				ap.parseResource();
				
				//return parseAnimation(data);
			}
			else if (rid >= 40000 && rid <= 49999) 
			{
				if (rid <= 41999) // big world background picture
				{
					var pp:PicParser = new PicParser(rid, data);
					pp.parseResource();	
				}
				
			}
			return null;
		}
		
		static public function parseRes(rtype:int, rid:int, data:*):*
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
					return parseDescRes(rid, data);
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