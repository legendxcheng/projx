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
		
		private var _bgLayer:BgLayer;
		private var _mainLayer:MainLayer;
		private var _uiLayer:UILayer;
		
		
		static private var _instance:ControlCenter;

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
			
			_bgLayer = new BgLayer();
			_mainLayer = new MainLayer();
			_uiLayer = new UILayer();
			
			
			
		}
	}
}