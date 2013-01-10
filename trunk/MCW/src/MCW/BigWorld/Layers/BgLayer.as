package MCW.BigWorld.Layers
{
	import MCW.BigWorld.Display.MSBackground;
	import MCW.BigWorld.Logic.RenderDirector;
	import MCW.Resource.MSMapDesc;
	import MCW.Resource.MSPic;
	import MCW.Resource.Util.ResManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class BgLayer extends Sprite
	{
		// Class for background
		private var _mapDesc:MSMapDesc;
		private var _bgPic:Bitmap;// the whold big picture 
		private var _mapShow:Bitmap;// the current scrren picture
		private var _needRedraw:Boolean;
		/*
		private function onMouseClick(e:MouseEvent):void
		{
			trace("bgLayer");
		}
		*/
		
		
		public function isReady():Boolean
		{
			return  (_mapDesc != null);
		}
		
		public function getMapWidth():int
		{
			return this._bgPic.bitmapData.width;
		}
		
		public function getMapHeight():int
		{
			return this._bgPic.bitmapData.height;
		}
		
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
			release map pic
		*/
		public function release():void
		{
			
		}
		
		/*
			call when map desc is loaded
		*/
		public function onResLoaded(rtype:int, rid:int):void
		{
			if (rtype == ResManager.RES_DESC_MAP)
			{
				if (_bgPic.bitmapData != null)
				{
					_bgPic.bitmapData.dispose();
					//TODO: release pics
				}
				_mapDesc = ResManager.getInstance().getResource(rtype, rid, this, 1);
				_bgPic.bitmapData = new BitmapData(_mapDesc.metaJson.width, _mapDesc.metaJson.height);
					
			
			// since map is loaded, start requesting map pic
			
				for (var i:int = 0; i < _mapDesc.metaJson.mapList.pic.length; ++i)
				{
					var tpic:MSPic = ResManager.getInstance().getResource(ResManager.RES_IMG_BIGPIC, _mapDesc.metaJson.mapList.pic[i],
						this, 1);
					if (tpic != null)
						addMapPic(i, tpic);
				}
			}
			else if (rtype == ResManager.RES_IMG_BIGPIC)// map picture
			{
				_needRedraw = true;
				
				var ttpic:MSPic = ResManager.getInstance().getResource(ResManager.RES_IMG_BIGPIC,
					rid, this, 1);
				var pico:int = 0;
				for (pico = 0; pico < _mapDesc.metaJson.mapList.pic.length; ++pico)
				{
					if (_mapDesc.metaJson.mapList.pic[pico] == rid)
						break;
				}
				addMapPic(pico, ttpic);
				

			}
			
			
		}
		
		public function update():void
		{
			var cc:RenderDirector = RenderDirector.getInstance();
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
		
		public function addMapPic(pid:int, bgpc:MSPic):void
		{
			
			
			if (_bgPic.bitmapData == null)
				_bgPic.bitmapData = new BitmapData(_mapDesc.metaJson.width, _mapDesc.metaJson.height, true);
			
			var colNum:int = Math.ceil(_mapDesc.metaJson.width / 1200);
			var row:int = pid / colNum;
			var col:int = pid % colNum;
			
			//this._bgPic.bitmapData.copyPixels(bgpc.bmd, bgpc.bmd.rect,
			//	new Point(col  * 1200, row * 600));
			var tma:Matrix = new Matrix();
			tma.translate(col * 1200, row * 600);
			tma.scale(1200 / bgpc.bmd.width,  600 / bgpc.bmd.height);
			this._bgPic.bitmapData.draw(bgpc.bmd, tma, null, null, new Rectangle(col * 1200, row * 600, 1200, 600));
			
			if (bgpc.metaJson.quality == "low")
			{
				_mapDesc.metaJson.mapList.pic[pid] = bgpc.metaJson.stdid;
				ResManager.getInstance().getResource(ResManager.RES_IMG_BIGPIC, bgpc.metaJson.stdid, this, 1);
			}
			else if (bgpc.metaJson.quality == "std")
			{
				_mapDesc.metaJson.mapList.pic[pid] = bgpc.metaJson.highid;
				ResManager.getInstance().getResource(ResManager.RES_IMG_BIGPIC, 
					bgpc.metaJson.highid, this, 1);
			}
			ResManager.getInstance().releaseResource(ResManager.RES_IMG_BIGPIC, bgpc.metaJson.rid);
		}
		
		public function requestResource():void
		{
			_mapDesc = ResManager.getInstance().getResource(ResManager.RES_DESC_MAP, 1000, this, 1);
		}
		
	}
}