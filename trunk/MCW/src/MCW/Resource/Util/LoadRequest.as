package MCW.Resource.Util
{
	import flash.events.Event;
	import flash.net.URLLoader;
	
	import mx.resources.ResourceManager;
	import MCW.Resource.Parser.ResourceParser;

	/*
		Stores imformation of a loading request.
	*/
	public class LoadRequest
	{
		
		private var _rtype:int; /*
										1 for image
										2 for sound
										4 for script or xml
										5 for description
									*/
		private var _rid:int; // resource id
		private var _priority :int; // from 0(high) to 9(low)
		private var _url:String;
		private var _data:*;
		
		public function get data():*
		{
			return _data;
		}

		public function get url():String
		{
			_url = "F:\\MCW\\projx\\Resources\\";
			_url += _rtype.toString() + "_" + _rid.toString() + ".res";
			return _url;
		}

		public function get priority():int
		{
			return _priority;
		}

		
		/*
		loading complete handler
		*/
		public function onLoadingComplete(e:Event):void
		{
			var loader:URLLoader = URLLoader(e.target);
			/* TODO:
				parse loader
				attach data onto ResourceManager
				release data
			*/
			var resMgr:ResManager = ResManager.getInstance();
			// resource parser will plug the resource
			ResourceParser.parseRes(_rtype, _rid, loader.data);
			
			var rl:ResourceLoader = ResourceLoader.getInstance();
			rl.doneALoading();
			
		}
		
		
		public function LoadRequest(rtype:int, rid:int, pri:int, target:*)
		{
			_rtype = rtype;
			_priority = pri;
			_rid = rid;
		}
		
		/*
			the request is done, it is time to release it.
		*/
		public function release():void
		{
			_data = null;
			
		}
	}
}