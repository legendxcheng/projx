package MCW.Task
{
	/*
		class that stores task information.
	*/
	public class TaskInfo
	{
		public static const TASK_LOCKED:int = 0;
		public static const TASK_ACCEPTABLE:int = 1;
		public static const TASK_ACCEPTED:int = 2;
		public static const TASK_COMPLETED:int = 3;
		
		private var _id:int;
		private var _state:int;
		private var _progress:Vector.<int>;
		
		public function TaskInfo(id:int, state:int)
		{
			_id = id;
			_state = state;
			if (_state == TASK_ACCEPTED)
			{
				_progress = new Vector.<int>(3);
			}
			else
			{
				_progress = null;
			}
		}
		


		public function get id():int
		{
			return _id;
		}
		
		/*
		accept an acceptable task
		*/
		public function accept():void
		{
			_state = TASK_ACCEPTED;
			_progress = new Vector.<int>(3);// new progress
		}
		
		/**
		 * 	Renounce a task
		 */
		public function giveUp():void
		{
			_state = TASK_ACCEPTABLE;
			_progress = null;// progress set to zero
		}
		
		public function complete():void
		{
			_state = TASK_COMPLETED;
			_progress = null;// _progress not used anymore
		}
		
		public function get state():int
		{
			return _state;
		}
		
		public function setProgress(p:Vector.<int>):void
		{
			for (var i:int = 0; i < p.length; ++i)
			{
				_progress[i] = p[i];
			}
		}
	}
}