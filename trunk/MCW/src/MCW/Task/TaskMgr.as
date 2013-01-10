package MCW.Task
{
	/*
		Singleton class
		Task Manager
	*/
	public class TaskMgr
	{
		/*
			singleton
		*/
		static private var _instance:TaskMgr;
		static public function getInstance():TaskMgr
		{
			if (_instance == null)
				_instance = new TaskMgr();
			return _instance;
		}
		
		private var _tasks:Array;
		private var _needSort:Boolean;
		
		public function TaskMgr()
		{
			_tasks = new Array();
		}
		
		private function sortTaskOnID(a:TaskInfo, b:TaskInfo):Number
		{
			var ai:int = a.id;
			var bi:int = b.id;
			if (ai > bi)
			{
				return 1;				
			}
			else if (ai < bi)
			{
				return -1;	
			}
			else
			{
				return 0;
			}
		}
		
		public function sort():void
		{
			_tasks.sort(sortTaskOnID);
		}
		
		//TODO: use MissionUpdateMessage to update _tasks
		
		
		
		public function getTask(id:int):TaskInfo
		{
			var lo:int = 0;
			var hi:int = _tasks.length;
			
			while(lo < hi)
			{
				//int mid = (hi + lo) / 2;
				var mid:int = (hi + lo) >> 1;
				
				if(id < _tasks[mid].id)
					hi = mid;
				else if(id > _tasks[mid].id)
					lo = mid + 1;
				else
					return _tasks[mid];        
			}
			return null;
		}
		
	}
}