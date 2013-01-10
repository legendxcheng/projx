package {
	import Logic.ControlCenter;
	
	import UI.Gate.GateListFrame;
	import UI.Gate.GateMapFrame;
	import UI.Map.MapAttrPanel;
	import UI.Map.MapFileListFrame;
	import UI.Map.MapFrame;
	import UI.Map.ToolFrame;
	import UI.NPC.NPCAttrFrame;
	import UI.NPC.NPCListFrame;
	import UI.NPC.NPCMapFrame;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.FileReference;
	
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
	import org.aswing.event.AWEvent;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntPoint;
	
	[SWF(width="1200", height="650")]
	public class MapEditor extends Sprite{
		private var tabbedPane:JTabbedPane;
		private var topWindow:JWindow;
		private var cc : ControlCenter;
		
			
		private var _btnChooseRefPic:JButton;
		private var _btnExport:JButton;
		private var _btnImport:JButton;
			
		private var mapPanel:JPanel;
			private var toolFrame : ToolFrame;
			private var attrFrame : JFrame;
			private var mapFrame :MapFrame;
			private var mapFLFrame :MapFileListFrame;
			
		private var npcPanel:JPanel;
			private var npcListFrame:NPCListFrame;
			private var npcAttrFrame:NPCAttrFrame;
			private var nMapFrame:NPCMapFrame;
			
		private var gatePanel:JPanel;
			private var gateListFrame:GateListFrame;
			private var gMapFrame:GateMapFrame;
		
		public function MapEditor(){
			
			
			AsWingManager.initAsStandard( this);
			topWindow = new JWindow();
			topWindow.setSizeWH(1200, 650);
			topWindow.getContentPane().setLayout(new EmptyLayout);
			//topWindow.setResizable(false);
			//topWindow.setClosable(false);
			tabbedPane = new JTabbedPane();
			tabbedPane.setSizeWH(1200, 650);
			tabbedPane.setLocationXY(0, 0);
			
			initMapTab();
			initNPCTab();
			initGateTab();
			cc = ControlCenter.getInstance();
			
			topWindow.getContentPane().append(tabbedPane);
			topWindow.show();
			
			_btnChooseRefPic = new JButton();
			_btnChooseRefPic.setLocation(new IntPoint(1100, 5));
			_btnChooseRefPic.setSize(new IntDimension(100, 30));
			_btnChooseRefPic.setText("选择参考图");
			_btnChooseRefPic.addEventListener(AWEvent.ACT, _onChooseRefPic);
			
			topWindow.getContentPane().append(_btnChooseRefPic);
			
			_btnExport = new JButton("导出");
			_btnExport.setSizeWH(40, 30);
			_btnExport.x = 1055;
			_btnExport.y = 5;
			topWindow.getContentPane().append(_btnExport);
			_btnExport.addEventListener(AWEvent.ACT, _onExport);
			
			_btnImport = new JButton("导入");
			_btnImport.setSizeWH(40, 30);
			_btnImport.x = 1010;
			_btnImport.y = 5;
			topWindow.getContentPane().append(_btnImport);
			_btnImport.addEventListener(AWEvent.ACT, _onImport);
			
			//initRefWin();
			
		}
		
		private function _onImport(e:AWEvent):void
		{
			cc.importFile();
		}
		
		private function _onExport(e:AWEvent):void
		{
			cc.exportFile();
		}
		
		private function _onChooseRefPic(e:AWEvent) : void
		{
				
			var mapFile:FileReference = new  FileReference();
			mapFile.addEventListener(Event.SELECT, _onRefPicSelected);
			mapFile.browse();
			
		}
		
		private function _onRefPicSelected(e:Event):void
		{
			cc.mapName = e.target.name;
			
			cc.loadMap(	cc.mapName );
		}
		
		public function initGateTab():void
		{
			gatePanel = new JPanel();
			gatePanel.setLayout(new EmptyLayout());
			gateListFrame = new GateListFrame();
			gatePanel.append(gateListFrame);
			gateListFrame.show();
			gMapFrame = new GateMapFrame();
			gatePanel.append(gMapFrame);
			gMapFrame.show();
			
			
			tabbedPane.appendTab(gatePanel, "Gate");
		}
		
		public function initNPCTab():void
		{
			npcPanel = new JPanel();
			npcPanel.setLayout(new EmptyLayout());
			npcListFrame = new NPCListFrame();
			npcPanel.append(npcListFrame);
			npcListFrame.show();
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
			//initAttributeFrame();
			initMapFrame();
			//initMapFLFrame();
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

		}
		
		public function initToolFrame() : void
		{
			// init
			toolFrame = new ToolFrame(this, "功能");
			toolFrame.setClosable(false);
			toolFrame.setResizable(false);
			toolFrame.setSizeWH(240, 650);
			toolFrame.x = 960;
			mapPanel.append(toolFrame);
			toolFrame.show();
			
		}
	}
}