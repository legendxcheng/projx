package {
	import Logic.ControlCenter;
	
	import UI.MapAttrPanel;
	import UI.MapFileListFrame;
	import UI.MapFrame;
	import UI.NPCAttrFrame;
	import UI.NPCListFrame;
	import UI.NPCMapFrame;
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
	import org.aswing.JTabbedPane;
	import org.aswing.JToggleButton;
	import org.aswing.JWindow;
	
	[SWF(width="1200", height="650")]
	public class MapEditor extends Sprite{
		private var tabbedPane:JTabbedPane;
		private var topWindow:JWindow;
		private var cc : ControlCenter;
		
		private var mapPanel:JPanel;
			private var toolFrame : ToolFrame;
			private var attrFrame : JFrame;
			private var mapFrame :MapFrame;
			private var mapFLFrame :MapFileListFrame;
			
		private var npcPanel:JPanel;
			private var npcListFrame:NPCListFrame;
			private var npcAttrFrame:NPCAttrFrame;
			private var nMapFrame:NPCMapFrame;
		
		public function MapEditor(){
			
			
			AsWingManager.initAsStandard( this);
			topWindow = new JWindow();
			topWindow.setSizeWH(1200, 650);
			//topWindow.setResizable(false);
			//topWindow.setClosable(false);
			tabbedPane = new JTabbedPane();
			
			initMapTab();
			initNPCTab();
			cc = ControlCenter.getInstance();
			
			topWindow.getContentPane().append(tabbedPane);
			topWindow.show();
			
		}
		
		public function initNPCTab():void
		{
			npcPanel = new JPanel();
			npcPanel.setLayout(new EmptyLayout());
			npcListFrame = new NPCListFrame();
			npcPanel.append(npcListFrame);
			npcListFrame.show();
			npcAttrFrame = new NPCAttrFrame();
			npcPanel.append(npcAttrFrame);
			npcAttrFrame.show();
			nMapFrame = new NPCMapFrame();
			npcPanel.append(nMapFrame);
			nMapFrame.show();
			
			
			tabbedPane.appendTab(npcPanel, "NPC");
			
			
		
			
			
			
		}
		
		public function initMapTab():void
		{
			mapPanel = new JPanel();
			mapPanel.setLayout(new EmptyLayout());
			initToolFrame();
			initAttributeFrame();
			initMapFrame();
			initMapFLFrame();
			tabbedPane.appendTab(mapPanel, "Map");
		}
		public function initMapFLFrame() :void
		{
			mapFLFrame = new MapFileListFrame(this, "地图文件");
			mapFLFrame.setClosable(false);
			mapFLFrame.setResizable(false);
			mapFLFrame.setDragable(false);
			mapFLFrame.setSizeWH(240, 410);
			mapFLFrame.x = 960;
			mapFLFrame.y = 210;
			mapPanel.append(mapFLFrame);
			mapFLFrame.show();
		}
		public function initMapFrame() : void
		{
			mapFrame = new MapFrame(this, "地图");
			mapFrame.setClosable(false);
			mapFrame.setResizable(false);
			mapFrame.setDragable(false);
			mapFrame.setSizeWH(960, 620);
			mapFrame.x = 0;
			mapFrame.y = 0;
			mapPanel.append(mapFrame);
			mapFrame.show();
		}
		
		public function initAttributeFrame() : void
		{
			attrFrame = new JFrame(this, "属性");
			attrFrame.setClosable(false);
			attrFrame.setResizable(false);
			attrFrame.setSizeWH(240, 105);
			attrFrame.x = 960;
			attrFrame.y = 105;
			var tmp:MapAttrPanel = new MapAttrPanel();
			attrFrame.getContentPane().append(tmp);
			mapPanel.append(attrFrame);
			attrFrame.show();
			//cc.attrPanel = tmp;
			ControlCenter.getInstance().attrPanel = tmp;
		}
		
		public function initToolFrame() : void
		{
			// init
			toolFrame = new ToolFrame(this, "功能");
			toolFrame.setClosable(false);
			toolFrame.setResizable(false);
			toolFrame.setSizeWH(240, 105);
			toolFrame.x = 960;
			mapPanel.append(toolFrame);
			toolFrame.show();
			
		}
	}
}