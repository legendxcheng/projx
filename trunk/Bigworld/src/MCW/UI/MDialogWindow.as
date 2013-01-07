package MCW.UI
{
	import MCW.Resource.MSPic;
	import MCW.Resource.MSSimpleDesc;
	import MCW.Resource.Util.ResManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	// dialog window
	public class MDialogWindow extends Sprite implements IMSUI
	{
		// content
		private var _metaJson:Object;
		
		// display
		private var _upMask:MSPic;
		private var _downMask:MSPic;
		private var _downMaskFx:MSPic;
		private var _bitmap:Bitmap;
		private var _clickAnim:MUIAnimation;
		private var _npcIcon:MSPic;
		
		// logic control
		private var _state:int;// 0 for entering，
								// 1 for working
								// 2 for leaving
		private var _tmy:int;// top mask y
		private var _bmy:int;// bottom mask y
		private var _pct:int;
		private var _pctStep:int;
		private var _done:Boolean;
		private var _leftIconX:int;
		private var _rightIconX:int;
		private var _iconY:int;
		private var _fxX:int;// fx x
		private var _fxY:int;// fx y
		
		public function isReady():Boolean
		{
			if (_downMask == null || _upMask == null || _downMaskFx == null
				|| _metaJson == null)// TODO clickAnim check
			{
				return false;
			}
			return true;
		}
		
		public function MDialogWindow()
		{
			_bitmap = new Bitmap();
			_bitmap.bitmapData = new BitmapData(1200, 600, true);
			this.addChild(_bitmap);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			_state = 0; // entering
			_done = false;
			
			_leftIconX = 100;
			_rightIconX = 800;
			_iconY = 400;
			
			_upMask = null;
			_downMask = null;
			_downMaskFx = null;
			
			_pct = -10;
			_pctStep = 8;
			
			this.requestResource();
		}
		
		// put a new dialog to it
		public function setNewDialog(did:int):void
		{
			
			var ssd:MSSimpleDesc = ResManager.getInstance().getResource(ResManager.RES_DESC_DIALOG, did, this, 1);
			if (ssd != null)
			{
				_metaJson = ssd.metaJson;
			}
		}
		
		public function get done():Boolean
		{
			return _done;
		}

		private function onEnterFrame(e:Event):void
		{
			if (!this.visible)
			{
				return;
			}
			// temp
			if (!this.isReady())
			{
				return;	
			}
			
			_bitmap.bitmapData.fillRect(new Rectangle(0, 0, 1200, 600),0);// clear rect
			if (_state == 0)//(entering)
			{
				_pct += _pctStep;
				if (_pct >= 100)
				{
					_pct = 100;
					_state = 1;
				}
				_tmy = (102) / 100.0 * _pct;
				_bmy = 126 / 100.0 * _pct;
				
			}
			else if (_state == 1) // working
			{
				
				
				// draw npc icon
				// draw text
			}
			else if (_state == 2) // leaving
			{
				_pct -= _pctStep;
				if (_pct <= 0)
				{
					_pct = 0;
					_done = true;
				}
				_tmy = (102) / 100.0 * _pct;
				_bmy = 126 / 100.0 * _pct;

				
			}
			if (_upMask != null)
				_bitmap.bitmapData.copyPixels(_upMask.bmd, new Rectangle(0, 102 - _tmy, 1200, _tmy), new Point(0, 0));
				//_bitmap.bitmapData.copyPixels(_upMask.bmd, new Rectangle(0, 0, 1200, 102), new Point(0, 0));
			if (_downMask != null)
				_bitmap.bitmapData.copyPixels(_downMask.bmd, new Rectangle(0, 0, 1200, _bmy), new Point(0, 600- _bmy));
		}
		
		
		public function onResLoaded(rtype:int, rid:int):void
		{
			if (rtype == ResManager.RES_IMG_UI)
			{
				if (rid == 1002)// up mask
				{
					_upMask = ResManager.getInstance().getResource(ResManager.RES_IMG_UI,
						rid, this, 1);
					
					
				}
				else if (rid  == 1000)// down mask fx
				{
					_downMaskFx = ResManager.getInstance().getResource(ResManager.RES_IMG_UI,
						rid, this, 1);
				}
				else if (rid == 1001)// down mask
				{
					_downMask = ResManager.getInstance().getResource(ResManager.RES_IMG_UI,
						rid, this, 1);	
				}
			
			}
			else if (rtype == ResManager.RES_DESC_DIALOG)
			{
				var ssd:MSSimpleDesc = ResManager.getInstance().getResource(ResManager.RES_DESC_DIALOG,
					rid, this, 1);
				_metaJson = ssd.metaJson;
				for (var i:int = 0; i < _metaJson.dialog.length; ++i)
				{
					ResManager.getInstance().getResource(ResManager.RES_DESC_NPC,
						rid, this, 1);
				}
			}
		}
		
		// basic resource
		public function requestResource():void
		{
			_upMask = ResManager.getInstance().getResource(ResManager.RES_IMG_UI, 1002, this, 1);
			_downMask = ResManager.getInstance().getResource(ResManager.RES_IMG_UI, 1001, this, 1);
			_downMaskFx = ResManager.getInstance().getResource(ResManager.RES_IMG_UI, 1000, this, 1);
		}
	}
}