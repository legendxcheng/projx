package MCW.BigWorld.Layers
{
	import MCW.BigWorld.Logic.RenderDirector;
	import MCW.UI.MButtonA;
	import MCW.UI.MDialogWindow;
	import MCW.UI.MRecvTaskWindow;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.aswing.*;
	import org.aswing.EmptyLayout;
	import org.aswing.event.InteractiveEvent;
	import org.aswing.event.ReleaseEvent;
	import org.aswing.skinbuilder.SkinBuilderLAF;
	
	
	public class UILayer extends Sprite
	{
		static public const UI_STATE_NORMAL:int = 0x01;
		static public const UI_STATE_DIALOG:int = 0x02;// showing dialog
		
		private var _state:int;// current state
		private var cc:RenderDirector;
		private var recvTaskWindow:MRecvTaskWindow;
		private var dialogWin:MDialogWindow;

		public function UILayer()
		{
			super();
			
			AsWingManager.initAsStandard( this);
			UIManager.setLookAndFeel(new org.aswing.skinbuilder.SkinBuilderLAF());
			
			recvTaskWindow = new MRecvTaskWindow();
			//recvTaskWindow.show();
			dialogWin = new MDialogWindow();
			dialogWin.visible = false;
			
			this.addChild(dialogWin);
			
			enterDialog(1000);
		}
		
		public function enterDialog(did:int):void
		{
			dialogWin.setNewDialog(did);
			dialogWin.visible = true;
		}
		
		public function leaveDialog():void
		{
			dialogWin.visible = false;
		}
		
		// convey the click message to mainlayer
		public function _onMouseClick(e:Event):void
		{	
			if (cc == null)
			{
				cc = RenderDirector.getInstance();
			}
			cc.mainLayer.dispatchEvent(e);
		}
		
		public function _buttonD(e:Event):void
		{
			
			e.target.setForeground(ASColor.LIGHT_GRAY);
		}
		
		public function _buttonC(e:Event):void
		{
			
			e.target.setForeground(ASColor.DARK_GRAY);
		}
		
		
		public function _buttonB(e:Event):void
		{
			
			e.target.setForeground(ASColor.YELLOW);
		}
		
		public function _buttonA(e:Event):void
		{
			
			e.target.setForeground(ASColor.LIGHT_GRAY);
		}
	}
}