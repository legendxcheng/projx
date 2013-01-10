package MCW.BigWorld.Logic
{
	import MCW.BigWorld.Layers.UILayer;
	
	import flash.display.Sprite;

	// singleton class for controlling UIs
	public class UIMgr
	{
		static public const UI_STATE_NORMAL:int = 0x01;
		static public const UI_STATE_DIALOG:int = 0x02;// showing dialog
		
		static public function getInstance():UIMgr
		{
			if (_instance == null)
			{
				_instance = new UIMgr();
			}
			return _instance;
		}
		
		static private var _instance:UIMgr;
		
		private var _state:int;
		private var _uilayer:UILayer;
		
		
		
		public function UIMgr()
		{
			
		}
		
		
	}
}