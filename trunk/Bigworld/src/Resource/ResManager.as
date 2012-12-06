package Resource
{
	// Manager to store all resources
	// Singleton
	public class ResManager
	{
		// Singleton
		static private var _instance:ResManager;
		static public function getInstance():ResManager;
		
		// Image Resources
		private var _imgRes:Array; // 0~65536
		private var _sndRes:Array; // 0~65536
		private var _scrRes:Array; // 0~65536 script
		private var _desRes:Array; // 0~65536 description
		
		
		private function ResManager()
		{
			
		}
		
		/*
			called by resource related elements
		*/
		public function getImgResByID(rid:int, target:Class):Class
		{
			if (_imgRes[rid] == null)
			{
				/* TODO: request the resource from loader
						register callback function using class
				*/
				
				return null;
			}
			else
			{
				return _imgRes[rid];
			}
		}
		
		/*
			TODO: other types of resources' get function
		 */
	}
}