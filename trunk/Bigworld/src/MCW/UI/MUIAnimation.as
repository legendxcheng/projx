package MCW.UI
{
	import MCW.Resource.MSAnimation;
	import MCW.Resource.Util.ResManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	// animatino only UI
	// no scale no color transform
	// attached with only one resource, which is a MSAnimation
	public class MUIAnimation extends Sprite
	{
		private var _animID:int;
		private var _anim:MSAnimation;
		private var _bitmap:Bitmap;
		private var _curFrame:Number;// current frame
		
		public function MUIAnimation(rid:int)
		{
			_curFrame = -1;
			_animID = rid;
			super();
			
			_bitmap = new Bitmap();// render to the bitmap
			this.addChild(_bitmap);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function onEnterFrame(e:Event):void
		{
			++_curFrame;
			
			if (_bitmap.bitmapData != null)
			{
				_bitmap.bitmapData.dispose();
				_bitmap.bitmapData = null;
			}
			_bitmap.bitmapData = _anim.getBitmapData(_curFrame);
		}
		
		public function onResLoaded(rtype:int, rid:int):void
		{
			if (rtype == ResManager.RES_IMG_ANIM)
			{
				_anim = ResManager.getInstance().getResource(ResManager.RES_IMG_ANIM,
					rid, this, 1);		
			}
		}
		
		public function requestResource():void
		{
			_anim = ResManager.getInstance().getResource(ResManager.RES_IMG_UI, 5000, this, 1);
			
		}
	}
}