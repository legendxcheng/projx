package Logic
{
	import Layers.BgLayer;
	import Layers.MainLayer;
	import Layers.UILayer;

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
		
		public function ControlCenter()
		{
			_bgLayer = new BgLayer();
			_mainLayer = new MainLayer();
			_uiLayer = new UILayer();
		}
	}
}