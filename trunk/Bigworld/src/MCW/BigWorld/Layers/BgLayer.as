package MCW.BigWorld.Layers
{
	import MCW.BigWorld.Display.MSBackground;
	import MCW.BigWorld.Resource.MSMapDesc;
	import MCW.BigWorld.Resource.Util.ResManager;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class BgLayer extends Sprite
	{
		// Class for background
		private var _mapDesc:MSMapDesc;
		private var _bgPics:Vector.<MSBackground>;
		
		/*
		private function onMouseClick(e:MouseEvent):void
		{
			trace("bgLayer");
		}
		*/
		public function BgLayer()
		{
			super();
			
			_bgPics = new Vector.<MSBackground>;
			
			requestResource();
			
			//this.addEventListener(MouseEvent.CLICK, onMouseClick);
			
		}
		
		/*
			call when map desc is loaded
		*/
		public function onResLoaded(rtype:int, rid:int):void
		{
			_mapDesc = ResManager.getInstance().getDescResByID(2, this, 1);
			// since map is loaded, start requesting map pic
			
			for (var i:int = 0; i < _mapDesc.metaJson.mapList.pic.length; ++i)
			{
				var bgpc:MSBackground =  new MSBackground(_mapDesc.metaJson.mapList.pic[i]);
				_bgPics.push(bgpc);
				this.addChild(bgpc);
			}
			
		}
		
		public function requestResource():void
		{
			_mapDesc = ResManager.getInstance().getDescResByID(2, this, 1);
		}
		
		
		
		
	}
}