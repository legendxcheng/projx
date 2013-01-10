package MCW.UI
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	
	
	
	
	
	public class MRecvTaskCloseBtn extends Sprite
	{
		
		private var _normalPic1:Bitmap;
		private var _pressPic1:Bitmap;
	
		[Embed(source="assets/recvPanelCloseBtn_normal.png")]
		private var _normalPic:Class;
		
		[Embed(source="assets/recvPanelCloseBtn_pressed.png")]
		private var _pressPic:Class;
		
		public function MRecvTaskCloseBtn()
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
			_normalPic1 = new _normalPic;
			_pressPic1 = new _pressPic;
			this.addChild(_pressPic1);
			this.addChild(_normalPic1);
			_pressPic1.visible = false;
	
		}
		
			
	
		private function _onMouseDown(e:MouseEvent):void
		{
			_pressPic1.visible = true;
			_normalPic1.visible = false;
			
		}
	
		private function _onMouseUp(e:MouseEvent):void
		{
			_pressPic1.visible = false;
			_normalPic1.visible = true;
		}
	}
}
