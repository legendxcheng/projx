package {
	import Logic.ControlCenter;
	
	import UI.AttributePanel;
	import UI.MapFileListFrame;
	import UI.MapFrame;
	import UI.ToolFrame;
	
	import flash.display.Sprite;
	
	import org.aswing.AsWingManager;
	import org.aswing.Container;
	import org.aswing.EmptyLayout;
	import org.aswing.FlowLayout;
	import org.aswing.JButton;
	import org.aswing.JFrame;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.JToggleButton;
	
	[SWF(width="1200", height="650")]
	public class MapEditor extends Sprite{
		private var toolFrame : ToolFrame;
		private var attrFrame : JFrame;
		private var mapFrame :MapFrame;
		private var mapFLFrame :MapFileListFrame;
		private var cc : ControlCenter;	
		
		
		
		
		public function MapEditor(){
			
			
			AsWingManager.initAsStandard( this);
			initToolFrame();
			initAttributeFrame();
			initMapFrame();
			initMapFLFrame();
			cc = ControlCenter.getInstance();
			
		}
		
		public function initMapFLFrame() :void
		{
			mapFLFrame = new MapFileListFrame(this, "地图文件");
			mapFLFrame.setClosable(false);
			mapFLFrame.setResizable(false);
			mapFLFrame.setDragable(false);
			mapFLFrame.setSizeWH(240, 400);
			mapFLFrame.x = 960;
			mapFLFrame.y = 230;
			mapFLFrame.show();
		}
		public function initMapFrame() : void
		{
			mapFrame = new MapFrame(this, "地图");
			mapFrame.setClosable(false);
			mapFrame.setResizable(false);
			mapFrame.setDragable(false);
			mapFrame.setSizeWH(960, 650);
			mapFrame.x = 0;
			mapFrame.y = 0;
			mapFrame.show();
		}
		
		public function initAttributeFrame() : void
		{
			attrFrame = new JFrame(this, "属性");
			attrFrame.setClosable(false);
			attrFrame.setResizable(false);
			attrFrame.setSizeWH(240, 110);
			attrFrame.x = 960;
			attrFrame.y = 120;
			attrFrame.show();
			attrFrame.getContentPane().append(new AttributePanel());
		}
		
		public function initToolFrame() : void
		{
			// init
			toolFrame = new ToolFrame(this, "功能");
			toolFrame.setClosable(false);
			toolFrame.setResizable(false);
			toolFrame.setSizeWH(240, 120);
			toolFrame.x = 960;
			toolFrame.show();
			
		}
	}
}