package MCW.BigWorld.Layers
{
	import MCW.BigWorld.Logic.RenderDirector;
	import MCW.UI.MButtonA;
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
		private var cc:RenderDirector;
		private var recvTaskWindow:MRecvTaskWindow;

		public function UILayer()
		{
			super();
			
			AsWingManager.initAsStandard( this);
			UIManager.setLookAndFeel(new org.aswing.skinbuilder.SkinBuilderLAF());
			
			recvTaskWindow = new MRecvTaskWindow();
			recvTaskWindow.show();
			
		
			
			
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