package MCW.BigWorld.Resource.Util
{
	import mx.events.ResourceEvent;

	// Manager to store all resources
	// Singleton
	public class ResManager
	{
		// Singleton
		static private var _instance:ResManager;
		static public function getInstance():ResManager
		{
			if (_instance == null)
			{
				_instance = new ResManager();
				
			}
			return _instance;
		}
		
		// constants
		static public const RES_TYPE_IMAGE:int = 1;
		static public const RES_TYPE_SOUND:int = 2;
		static public const RES_TYPE_SCRIPT:int = 4;
		static public const RES_TYPE_DESC:int = 5;
		
		
		// Image Resources
		private var _imgRes:Array; // 0~65536
		private var _sndRes:Array; // 0~65536
		private var _scrRes:Array; // 0~65536 script
		private var _desRes:Array; // 0~65536 description
		
		// Resource reference count and other properties
		private var _imgResRef:Array;
		private var _sndResRef:Array;
		private var _scrResRef:Array;
		private var _desResRef:Array;
		
		private var _resLoader:ResourceLoader;
		
		private function initResRef():Object
		{
			var ret:Object = new Object();
			ret.isLoading = false;
			ret.loaded = false;
			ret.ref = 0;
			ret.reqTargets = new Array();
			return ret;
		}
		
		public function ResManager()
		{
			_imgResRef = new Array();
			_sndResRef = new Array();
			_scrResRef = new Array();
			_desResRef = new Array();
			
			_imgRes = new Array();
			_sndRes = new Array();
			_scrRes = new Array();
			_desRes = new Array();
			
			_resLoader = ResourceLoader.getInstance();
		}
		
		/*
			called by resource related elements
		*/
		public function getImgResByID(rid:int, target:Class, pr:int):Class
		{
			if (_imgRes[rid] == null)
			{
				/* TODO: request the resource from loader
						register callback function using class
				*/
				if (_imgResRef[rid] == null)
				{
					_imgResRef[rid] = initResRef();
				}
				_imgResRef[rid].reqTargets.push(target);
				if (!_imgResRef[rid].isLoading)
				{
					_resLoader.addLoadRequest(ResManager.RES_TYPE_IMAGE, rid, pr, target);
					_imgResRef[rid].isLoading = true;
				}
				
				return null;
			}
			else
			{
				++_imgResRef[rid].ref;
				return _imgRes[rid];
			}
		}
		
		/*
			plug resource to the 4 arrays
		*/
		public function plugResource(rtype:int, rid:int, res:Class):void
		{
			var rt:Array;
			var i:int;
			switch (rtype)
			{
				case ResManager.RES_TYPE_DESC:
				{
					if (_desResRef[rid] == null)
					{
						_desResRef[rid] = initResRef();
					}
					_desRes[rid] = res;
					// iterate _desResRef[rid].reqTargets
					rt = _desResRef[rid].reqTargets;
					_desResRef[rid].ref = rt.length;
					for (i = 0; i< rt.length; ++i)
					{
						// inform all entities that ever requested for this resource
						rt.onResLoaded(rtype, rid);
					}
					
				}
					break;
				case ResManager.RES_TYPE_IMAGE:
				{
					if (_imgResRef[rid] == null)
					{
						_imgResRef[rid] = initResRef();
					}
					_imgRes[rid] = res;
					// iterate _desResRef[rid].reqTargets
					rt = _imgResRef[rid].reqTargets;
					_imgResRef[rid].ref = rt.length;
					for (i = 0; i< rt.length; ++i)
					{
						// inform all entities that ever requested for this resource
						rt.onResLoaded(rtype, rid);
					}
					
				}
					break;
				case ResManager.RES_TYPE_SOUND:
				{
					
				}
					break;
				case ResManager.RES_TYPE_SCRIPT:
				{
					
				}
					break;
			}
		}
		
		/*
			release resource by id
		*/
		public function releaseImgResByID(rid:int):void
		{
			--_imgResRef[rid].ref;
			if (_imgResRef[rid].ref == 0)
			{
				_imgResRef[rid] = null;
				_imgRes[rid] = null;
			}
		}
		
		/*
			TODO: other types of resources' get function
		 */
	}
}