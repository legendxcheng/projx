package MCW.UI
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	import org.aswing.ASColor;
	import org.aswing.Icon;
	import org.aswing.JButton;
	import org.aswing.event.ReleaseEvent;


	
	// first type of button A
	public class MButtonA extends JButton
	{
		public function MButtonA(awidth:int, text:String="", icon:Icon=null)
		{
			super(text, icon);
			
			this.height = 26;
			this.width = awidth;
			
			addEventListener(MouseEvent.ROLL_OVER, _buttonRollOver);
			addEventListener(MouseEvent.ROLL_OUT, _buttonRollOut);
			addEventListener(MouseEvent.MOUSE_DOWN, _buttonMouseDown);
			addEventListener(ReleaseEvent.RELEASE, _buttonRelease);
			addEventListener(MouseEvent.CLICK, _buttonClickStopPropagation);
			setForeground(new ASColor(0xFFC436));
		}
		
		
		// stop propagation
		private function _buttonClickStopPropagation(e:MouseEvent):void
		{
			e.stopPropagation();
		}
		
		private function _buttonRollOver(e:Event):void
		{
			
			e.target.setForeground(ASColor.YELLOW);
		}
		private function _buttonRollOut(e:Event):void
		{
			setForeground(new ASColor(0xFFC436));
		}4
		private function _buttonMouseDown(e:Event):void
		{
			e.target.setForeground(ASColor.DARK_GRAY);	
		}
		private function _buttonRelease(e:Event):void
		{
			e.target.setForeground(ASColor.YELLOW);	
		}
		
	}
}