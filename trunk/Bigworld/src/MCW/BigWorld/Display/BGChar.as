package MCW.BigWorld.Display
{
	import MCW.BigWorld.Display.Base.MSprite;
	import MCW.BigWorld.Resource.MSAnimation;
	import MCW.BigWorld.Resource.Util.ResManager;
	
	import flash.display.BitmapData;
	
	import mx.resources.ResourceManager;
	
	// big world character
	public class BGChar extends MSprite
	{
		/*
			@param ctype character type
			@more attributes may be added in the future.
		*/
		public function BGChar(ctype:int)
		{
			super();
		}
		
		
		override public function requestResource():void
		{
			var resMgr:ResManager = ResManager.getInstance();
			_animation = resMgr.getImgResByID(29101, this, 1) as MSAnimation;
		}
		
		override public function onResLoaded(rtype:int, rid:int):void
		{
			if (rtype == ResManager.RES_TYPE_IMAGE && rid == 29101) // temp
			{
				_animation = ResManager.getInstance().getImgResByID(rid, this, 1 ) as MSAnimation;
			}
		}
		

	}
}