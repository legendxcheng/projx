package MCW.BigWorld.Layers
{
	import MCW.BigWorld.Logic.ControlCenter;
	
	import UI.MSButtonA;
	
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
		private var cc:ControlCenter;
		private var attrFrame:JWindow;
		public function UILayer()
		{
			super();
			
			AsWingManager.initAsStandard( this);
			UIManager.setLookAndFeel(new org.aswing.skinbuilder.SkinBuilderLAF());
			attrFrame = new JWindow();
			attrFrame.setToolTipText("dfsdf");
			
			attrFrame.setSizeWH(240, 110);
			attrFrame.x = 50;
			attrFrame.y = 120;
			attrFrame.width = 1000;
			attrFrame.height = 500;
			attrFrame.show();
			attrFrame.getContentPane().setLayout(new EmptyLayout());
			var tmp = new MSButtonA(150, "战斗交给我！");
			attrFrame.getContentPane().append(tmp);
			
			attrFrame.addEventListener(MouseEvent.CLICK, _onMouseClick);
			
		}
		
		// convey the click message to mainlayer
		public function _onMouseClick(e:Event):void
		{	
			if (cc == null)
			{
				cc = ControlCenter.getInstance();
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