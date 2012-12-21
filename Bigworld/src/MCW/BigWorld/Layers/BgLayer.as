package MCW.BigWorld.Layers
{
	import MCW.BigWorld.Display.MSBackground;
	import MCW.BigWorld.Logic.ControlCenter;
	import MCW.BigWorld.Resource.MSMapDesc;
	import MCW.BigWorld.Resource.MSPic;
	import MCW.BigWorld.Resource.Util.ResManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class BgLayer extends Sprite
	{
		// Class for background
		private var _mapDesc:MSMapDesc;
		private var _bgPic:Bitmap;// the whold big picture 
		private var _mapShow:Bitmap;
		private var _needRedraw:Boolean;
		/*
		private function onMouseClick(e:MouseEvent):void
		{
			trace("bgLayer");
		}
		*/
		public function BgLayer()
		{
			super();
			
			_bgPic = new Bitmap();
			_mapShow = new Bitmap();
			_mapShow.bitmapData = new BitmapData(1200, 600, false);
			requestResource();
			
			//this.addEventListener(MouseEvent.CLICK, onMouseClick);
			//this.addChild(_bgPic);
			this.addChild(_mapShow);
			//this.addChild(_bgPic);
			
			_needRedraw = true;
		}
		
		/*
			call when map desc is loaded
		*/
		public function onResLoaded(rtype:int, rid:int):void
		{
			if (rtype == ResManager.RES_TYPE_DESC)
			{
				if (_bgPic.bitmapData != null)
					_bgPic.bitmapData.dispose();
				
				_mapDesc = ResManager.getInstance().getDescResByID(2, this, 1);
					
			
			// since map is loaded, start requesting map pic
			
				for (var i:int = 0; i < _mapDesc.metaJson.mapList.pic.length; ++i)
				{
					var tpic:MSPic = ResManager.getInstance().getImgResByID(_mapDesc.metaJson.mapList.pic[i],
						this, 1);
					if (tpic != null)
						addMapPic(tpic);
				}
			}
			else if (rtype == ResManager.RES_TYPE_IMAGE)
			{
				_needRedraw = true;
				 if (rid >= 40000 && rid < 42000) // map Pic
				 {
					 var ttpic:MSPic = ResManager.getInstance().getImgResByID(_mapDesc.metaJson.mapList.pic[i],
						 this, 1);
					 addMapPic(ttpic);
					 if (ttpic.metaJson.quality == "low")
					 {
						 ResManager.getInstance().getImgResByID(ttpic.metaJson.stdid, this, 1);
					 }
					 else if (ttpic.metaJson.quality == "std")
					 {
						 ResManager.getInstance().getImgResByID(ttpic.metaJson.highid, this, 1);
					 }		 
				 }
			}
			
			
		}
		
		public function update():void
		{
			var cc:ControlCenter = ControlCenter.getInstance();
			if (cc.camMoved || _needRedraw)
			{
				
				var trect :Rectangle = new Rectangle(cc.camX, cc.camY, 1200, 600);
				if (_bgPic.bitmapData != null)
				{
					_mapShow.bitmapData.copyPixels(_bgPic.bitmapData, trect, new Point(0,0));
					_needRedraw = false;
				}
			}
		}
		
		public function addMapPic(bgpc:MSPic):void
		{
			if (_bgPic.bitmapData == null)
				_bgPic.bitmapData = new BitmapData(_mapDesc.metaJson.width, _mapDesc.metaJson.height, true);
			var ti:int;
			for (ti = 0; ti < _mapDesc.metaJson.mapList.pic.length; ++ti)
			{
				if (_mapDesc.metaJson.mapList.pic[ti] == bgpc.metaJson.rid)
					break;
			}
			var colNum:int = Math.ceil(_mapDesc.metaJson.width / 1200);
			var row:int = ti / colNum;
			var col:int = ti % colNum;
			
			this._bgPic.bitmapData.copyPixels(bgpc.bmd, bgpc.bmd.rect,
				new Point(col  * 1200, row * 600));
		}
		
		public function requestResource():void
		{
			_mapDesc = ResManager.getInstance().getDescResByID(2, this, 1);
		}
		
	}
}