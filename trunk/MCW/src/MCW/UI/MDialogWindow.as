package MCW.UI
{
	import MCW.BigWorld.Logic.BWRenderDirector;
	import MCW.Resource.MSPic;
	import MCW.Resource.MSSimpleDesc;
	import MCW.Resource.Util.ResManager;
	import MCW.Scene.SceneDirector;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.geom.Matrix;
	import flash.geom.Matrix3D;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

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
		private var _curD:int;
		private var _talker:TextField;
		private var _say:TextField;
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
		
		// render the npc icon and text onto the mask
		private function renderDialog(dind:int):void
		{
			_bitmap.bitmapData.fillRect(new Rectangle(0, 0, 1200, 600),0);// clear rect
			if (_upMask != null)
				_bitmap.bitmapData.copyPixels(_upMask.bmd, new Rectangle(0, 0, 1200, 102), new Point(0, 0));
			//_bitmap.bitmapData.copyPixels(_upMask.bmd, new Rectangle(0, 0, 1200, 102), new Point(0, 0));
			if (_downMask != null)
				_bitmap.bitmapData.copyPixels(_downMask.bmd, new Rectangle(0, 0, 1200, 126), new Point(0, 474));
			
			var dc:Object = _metaJson.dialog[dind];
			var npc:MSSimpleDesc = ResManager.getInstance().getResource(ResManager.RES_DESC_NPC, dc.npcid, null, 1);
			var npcIcon:MSPic = ResManager.getInstance().getResource(ResManager.RES_IMG_APIC, npc.metaJson.iconid, null, 1);
	
			var ma:Matrix = new Matrix();
			var fma:Matrix = new Matrix();
			
			_talker.htmlText = "<font size=\"12\" color=\"#FFFFFF\">" + npc.metaJson.name + "</font>";
			_say.htmlText = "<font size=\"12\" color=\"#CC9966\">" +
				HtmlCodeTranslator.translate(dc.text) + "</font>";
			
			if (dc.isLeft == 0)
			{
				fma.translate(440, 475);
				fma.a = -1;
				ma.translate(npcIcon.bmd.width, 600 - npcIcon.bmd.height);
				ma.a = -1;
				_bitmap.bitmapData.draw(this._downMaskFx.bmd, fma);
				_bitmap.bitmapData.draw(npcIcon.bmd, ma);
			}
			else
			{
				ma.a = 1;
				fma.a = 1;
				ma.translate(1200 - npcIcon.bmd.width, 600 - npcIcon.bmd.height);
				fma.translate(760, 475);
				_bitmap.bitmapData.draw(this._downMaskFx.bmd, fma);
				_bitmap.bitmapData.draw(npcIcon.bmd, ma);
			}
			
			
			
			
		}
		
		private function _onClickText(e:TextEvent):void
		{
			
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
			
			_talker = new TextField();
			_talker.x = 420;
			_talker.y = 500;
			_talker.selectable = false;
			_talker.multiline = false;
			_talker.width = 400;
			_talker.autoSize = TextFieldAutoSize.LEFT;
			_talker.wordWrap = true;
			//_talker.addEventListener(TextEvent.LINK, _onClickText);
			this.addChild(_talker);
			
			_say = new TextField();
			_say.x = 470;
			_say.y = 500;
			_say.selectable = false;
			_say.multiline = false;
			_say.width = 400;
			_say.autoSize = TextFieldAutoSize.LEFT;
			_say.wordWrap = true;
			_say.addEventListener(TextEvent.LINK, _onClickText);
			this.addChild(_say);
			
			this.addEventListener(MouseEvent.CLICK, onClick);
			this.requestResource();
		
		}
		
		private function onClick(e:MouseEvent):void
		{
			++this._curD;
			if (_curD == this._metaJson.dialog.length)
			{
				_state = 2;
				_talker.visible = false;
				_say.visible = false;
			}
			else
			{
				renderDialog(_curD);	
			}
			
		}
		
		// put a new dialog to it
		public function setNewDialog(did:int):void
		{
			
			var ssd:MSSimpleDesc = ResManager.getInstance().getResource(ResManager.RES_DESC_DIALOG, did, this, 1);
			if (ssd != null)
			{
				_metaJson = ssd.metaJson;
			}
			this._curD = 0;
			_talker.visible = false;
			_say.visible = false;
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
			if (_state == 1)
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
					_talker.visible = true;
					_say.visible = true;
					renderDialog(0);
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
					
					SceneDirector.getInstance().uiLayer.leaveDialog();
				}
				_tmy = (102) / 100.0 * _pct;
				_bmy = 126 / 100.0 * _pct;
				
				

				
			}
			if (_upMask != null)
				_bitmap.bitmapData.copyPixels(_upMask.bmd, new Rectangle(0, 102 - _tmy, 1200, _tmy), new Point(0, 0));
				//_bitmap.bitmapData.copyPixels(_upMask.bmd, new Rectangle(0, 0, 1200, 102), new Point(0, 0));
			if (_downMask != null)
				_bitmap.bitmapData.copyPixels(_downMask.bmd, new Rectangle(0, 0, 1200, _bmy), new Point(0, 600- _bmy));
			
			if (_state == 1)
			{
				renderDialog(2);
			}
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