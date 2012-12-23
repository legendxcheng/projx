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
/*
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
			if (rid >= 0 && rid <= 9999)
			{
				var pp:PicParser = new PicParser(rid, data);
				pp.parseResource();
			}
			else if (rid >= 20000 && rid <= 39999)// animation
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
*/
		static public function parseRes(rtype:int, rid:int, data:*):*
		{
			// TODO: parse res due to different types of resources
			switch (rtype)	
			{
				case ResManager.RES_DESC_BWCHAR:
				{
					var sp:DescSimpleParser = new DescSimpleParser(rtype, rid, data);
					sp.parseResource();
					sp = null;
				}
					break;
				case ResManager.RES_DESC_GATE:
				{
					
				}
					break;
				case ResManager.RES_DESC_MAP:
				{
					var mp:DescMapParser = new DescMapParser(rid, data);	
					mp.parseResource();
					mp = null;
				}
					break;
				case ResManager.RES_DESC_NPC:
				{
					
				}
					break;
				case ResManager.RES_DESC_TASK_LOGIC:
				{
					
				}
					break;
				case ResManager.RES_DESC_TASK_TEXT:
				{
					
				}
					break;
				case ResManager.RES_IMG_ANIM:
				{
					var ap:ImgAnimParser = new ImgAnimParser(rid, data);
					ap.parseResource();
				}
					break;
				case ResManager.RES_IMG_BIGPIC:
				{
					var pp:ImgPicParser = new ImgPicParser(rtype, rid, data);
					pp.parseResource();	
				}
					break;
				case ResManager.RES_IMG_ICO:
				{
					
				}
					break;
				case ResManager.RES_IMG_APIC:
				{
					
				}
					break;
				case ResManager.RES_IMG_UI:
				{
					var pp:ImgPicParser = new ImgPicParser(rtype, rid, data);
					pp.parseResource();
				}
					break;
				case ResManager.RES_SCR_BATTLE:
				{
					
				}
					break;
				case ResManager.RES_SCR_DIALOG:
				{
					
				}
					break;
				case ResManager.RES_SCR_ITEM:
				{
					
				}
					break;
				case ResManager.RES_SCR_NPC:
				{
					
				}
					break;
				case ResManager.RES_SCR_TASK:
				{
					
				}
					break;
			
			}
			return null;
		}
	}
}