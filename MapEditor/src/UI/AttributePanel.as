package UI{
	
	import Logic.ControlCenter;
	
	import flash.events.Event;
	import flash.net.FileReference;
	
	import org.aswing.*;
	import org.aswing.border.*;
	import org.aswing.colorchooser.*;
	import org.aswing.event.AWEvent;
	import org.aswing.ext.*;
	import org.aswing.geom.*;
	
	/**
	 * AttributePanel
	 */
	public class AttributePanel extends JPanel{
		
		//members define
		private var mapSizeLable1:JLabel;
		private var mapSizeW:JTextField;
		private var label5:JLabel;
		private var mapSizeH:JTextField;
		private var btnSetMapSize:JButton;
		private var btnLoadMap:JButton;
		private var btnChooseMap:JButton;
		private var label16:JLabel;
		private var textfield17:JTextField;
		private var cc : ControlCenter;
		
		
		/**
		 * AttributePanel Constructor
		 */
		public function AttributePanel(){
			//component creation
			setSize(new IntDimension(200, 71));
			var layout0:EmptyLayout = new EmptyLayout();
			setLayout(layout0);
			
			cc = ControlCenter.getInstance();
			
			mapSizeLable1 = new JLabel();
			mapSizeLable1.setLocation(new IntPoint(5, 5));
			mapSizeLable1.setSize(new IntDimension(64, 20));
			mapSizeLable1.setConstraints("Center");
			mapSizeLable1.setText("Map Size:");
			
			mapSizeW = new JTextField();
			mapSizeW.setLocation(new IntPoint(65, 5));
			mapSizeW.setSize(new IntDimension(35, 20));
			
			label5 = new JLabel();
			label5.setLocation(new IntPoint(100, 5));
			label5.setSize(new IntDimension(20, 20));
			label5.setText("x");
			
			mapSizeH = new JTextField();
			mapSizeH.setLocation(new IntPoint(120, 5));
			mapSizeH.setSize(new IntDimension(35, 20));
			
			btnSetMapSize = new JButton();
			btnSetMapSize.setLocation(new IntPoint(160, 5));
			btnSetMapSize.setSize(new IntDimension(39, 20));
			btnSetMapSize.setText("Set");
			
			btnLoadMap = new JButton();
			btnLoadMap.setLocation(new IntPoint(100, 50));
			btnLoadMap.setSize(new IntDimension(60, 20));
			btnLoadMap.setText("Load");
			
			label16 = new JLabel();
			label16.setLocation(new IntPoint(3, 25));
			label16.setSize(new IntDimension(96, 20));
			label16.setText("mapFileName:");
			
			textfield17 = new JTextField();
			textfield17.setLocation(new IntPoint(100, 25));
			textfield17.setSize(new IntDimension(90, 20));
			
			btnChooseMap = new JButton();
			btnChooseMap.setLocation(new IntPoint(5, 50));
			btnChooseMap.setSize(new IntDimension(90, 20));
			btnChooseMap.setText("Choose Map");
			
			//component layoution
			append(mapSizeLable1);
			append(mapSizeW);
			append(label5);
			append(mapSizeH);
			append(btnSetMapSize);
			append(btnLoadMap);
			append(label16);
			append(textfield17);
			append(btnChooseMap);
			
			btnLoadMap.addEventListener(AWEvent.ACT, _onLoadMap);
			btnChooseMap.addEventListener(AWEvent.ACT, _onChooseMap);
					
		}
		
		// handlers
		
		private function _onChooseMap(e:AWEvent) : void
		{
			var mapFile:FileReference = new  FileReference();
			mapFile.addEventListener(Event.SELECT, _onMapSelected);
			mapFile.browse();
			
		}
		
		private function _onMapSelected(e:Event):void
		{
			cc.mapName = e.target.name;
		}
		
		private function _onLoadMap(e:AWEvent) : void
		{
			cc.loadMap(	cc.mapName );
		}
		
		//_________getters_________
		
		
		public function getMapSizeW():JTextField{
			return mapSizeW;
		}
		
		
		public function getMapSizeH():JTextField{
			return mapSizeH;
		}
		
		public function getBtnSetMapSize():JButton{
			return btnSetMapSize;
		}
		
		public function getBtnLoadMap():JButton{
			return btnLoadMap;
		}
		
		
		public function getTextfield17():JTextField{
			return textfield17;
		}
		
		
	}
}
