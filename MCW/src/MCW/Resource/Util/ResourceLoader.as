package MCW.Resource.Util
{
	import flash.events.*;
	import flash.net.*;
	import flash.net.URLLoader;
	/*
		Singleton class governing all loading issues
	*/
	public class ResourceLoader
	{
		/*
			pending list, elements are loadRequest	
		*/
		private var _pending:Array; // loading Array
		private var _loadingNum:int; // number of requests being loaded currently
		static private var _maxLoadingNum:int = 10; // max number of loadings that can be loaded in the same time.
		
		static private var _instance:ResourceLoader;
		static public function getInstance():ResourceLoader
		{
			if (_instance == null)
				_instance = new ResourceLoader();
			return _instance;
		}
		
		// function for sort loading request in the order of priority
		private function sortOnPriority(a:LoadRequest, b:LoadRequest):Number {
			
			if(a.priority > b.priority) {
				return -1;
			} else if(a.priority < b.priority) {
				return 1;
			} else  {
				//aPrice == bPrice
				return 0;
			}
		}
		
		/*
			start a loading,
			picking a loadrequest from pendingList, and load it
			update 
			
			called every frame by ControlCenter's update function
		*/
		public function startALoading():void
		{
			if (_pending.length == 0)
			{
				return;
			}
			
			if (_loadingNum < _maxLoadingNum)
			{
				_pending.sort(sortOnPriority);
			}
			
			while (_loadingNum < _maxLoadingNum)
			{
				if (_pending.length > 0)
				{
					try{
					var lr :LoadRequest = _pending[0] as LoadRequest;
					_pending.shift();
					
					
					var loader:URLLoader = new URLLoader();
					loader.dataFormat = URLLoaderDataFormat.BINARY;
					loader.addEventListener(Event.COMPLETE, lr.onLoadingComplete);
					loader.load(new URLRequest(lr.url));
					loader.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onLoaderError);
					loader.addEventListener(ErrorEvent.ERROR, onLoaderError);
					loader.addEventListener(IOErrorEvent.IO_ERROR, onLoaderError);
					}
					catch (e:ErrorEvent)
					{
						trace(e);
					}
				}
				++_loadingNum;
			}
		}
		
		private function onLoaderError(e:ErrorEvent):void
		{
			trace(e);
		}
		
		
		
		/*
			add a load request in the _pending list
			@target the unit who wants the resource
			@rid resource id
			@pr priority
		*/
		public function addLoadRequest(rtype:int, rid: int, pr: int, target:*):void
		{
			// tmp url
			var lr:LoadRequest = new LoadRequest(rtype, rid, pr, target);
			_pending.push(lr);
			
		}
		
		/*
			called when a loading process is done
		*/
		public function doneALoading():void
		{
			--_loadingNum;
		}
		
		public function ResourceLoader()
		{
			_pending = new Array(); // init pending list
		}
	}

}