package MCW.BigWorld.Logic
{
	import MCW.BigWorld.Layers.BgLayer;
	import MCW.BigWorld.Layers.MainLayer;
	import MCW.BigWorld.Layers.UILayer;
	import MCW.BigWorld.Resource.Util.ResourceLoader;
	
	
	

	/*
		Singleton class that governs all logic related issues.
	 */
	
	public class ControlCenter
	{
		
		/*
			camera position X, and Y
		*/
		private var _camX:int;
		private var _camY:int;
		
		private var _bgLayer:BgLayer;
		private var _mainLayer:MainLayer;
		private var _uiLayer:UILayer;
		
		private var _gridSideLen:int;
		
		static private var _instance:ControlCenter;

		public function get gridSideLen():int
		{
			return _gridSideLen;
		}

		public function get camY():int
		{
			return _camY;
		}

		public function set camY(value:int):void
		{
			_camY = value;
		}

		public function get camX():int
		{
			return _camX;
		}

		public function set camX(value:int):void
		{
			_camX = value;
		}

		public function get uiLayer():UILayer
		{
			return _uiLayer;
		}

		public function get mainLayer():MainLayer
		{
			return _mainLayer;
		}

		public function get bgLayer():BgLayer
		{
			return _bgLayer;
		}

		static public function getInstance():ControlCenter
		{
			if (_instance == null)
			{
				_instance = new ControlCenter();
				
			}
			return _instance;
		}
		
		/*
			function called every frame, the main entry for updates
		*/
		public function updtate():void
		{
			ResourceLoader.getInstance().startALoading();
			
		}
		
		public function ControlCenter()
		{
			_camX = _camY = 0;
			_bgLayer = new BgLayer();
			_mainLayer = new MainLayer();
			_uiLayer = new UILayer();
			_gridSideLen = 50;
		}
	}
}