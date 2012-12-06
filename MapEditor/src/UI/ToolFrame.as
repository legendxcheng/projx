package UI
{
	import Logic.ControlCenter;
	
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import org.aswing.Container;
	import org.aswing.EmptyLayout;
	import org.aswing.JButton;
	import org.aswing.JFrame;
	import org.aswing.JToggleButton;
	import org.aswing.event.AWEvent;
	
	public class ToolFrame extends JFrame
	{
		private var btnShowGrid : JButton;
		private var btnExport : JButton;
		private var btnImport :JButton;
		private var btnReset:JButton;
		
		private var btnPassable : JToggleButton;
		private var btnTransparent : JToggleButton;
		private var btnNoFlag : JToggleButton;
		
		private var cc :ControlCenter;
		
		public function ToolFrame(owner:*=null, title:String="", modal:Boolean=false)
		{
			super(owner, title, modal);
			getContentPane().setLayout(new EmptyLayout());
			
			cc = ControlCenter.getInstance();
			
			var cp : Container = getContentPane();
			
			// add show grid button
			btnShowGrid = new JButton("显示网格");
			btnShowGrid.setSizeWH(60, 30);
			btnShowGrid.x = 5;
			btnShowGrid.y = 10;
			cp.append(btnShowGrid);
			btnShowGrid.addEventListener(AWEvent.ACT, onShowGrid);
			
			// add export button
			btnExport = new JButton("导出");
			btnExport.setSizeWH(40, 30);
			btnExport.x = 70;
			btnExport.y = 10;
			cp.append(btnExport);
			btnExport.addEventListener(AWEvent.ACT, onExport);
			
			btnImport = new JButton("导入");
			btnImport.setSizeWH(40, 30);
			btnImport.x = 115;
			btnImport.y = 10;
			cp.append(btnImport);
			btnImport.addEventListener(AWEvent.ACT, onImport);
			
			btnReset = new JButton("重置UI");
			btnReset.setSizeWH(60, 30);
			btnReset.x = 160;
			btnReset.y = 10;
			cp.append(btnReset);
			btnReset.addEventListener(AWEvent.ACT, onReset);
			
			
			/*btnNoFlag = new JToggleButton("取消标记");
			btnNoFlag.setSizeWH(60, 30);
			btnNoFlag.x = 5;
			btnNoFlag.y = 50;*/
			
			btnPassable = new JToggleButton("标记可通过");
			btnPassable.setSizeWH(80, 30);
			btnPassable.x = 70;
			btnPassable.y = 50;
			btnPassable.addEventListener(AWEvent.ACT, onTogglePassable);
			
			btnTransparent = new JToggleButton("标记透明");
			btnTransparent.setSizeWH(60, 30);
			btnTransparent.x = 5;
			btnTransparent.y = 50;
			btnTransparent.addEventListener(AWEvent.ACT, onToggleTransparent);
			
			
			cp.append(btnPassable);
			cp.append(btnTransparent);
		}
		
		private function onReset(e:AWEvent):void
		{
			cc.reset();
		}
		
		private function onImport(e:AWEvent):void
		{
			cc.importFile();
		}
		
		private function onExport(e:AWEvent):void
		{
			cc.exportFile();
		
		}
		
		private function onShowGrid(e:AWEvent):void
		{
			cc.showGrid();
		}
		
		private function onToggleTransparent(e:AWEvent):void
		{
			btnPassable.setSelected(false);	
			cc.setState(1);
		}
		
		private function onTogglePassable(e:AWEvent):void
		{
			btnTransparent.setSelected(false);
			cc.setState(0);
		}
	}
	
	
}