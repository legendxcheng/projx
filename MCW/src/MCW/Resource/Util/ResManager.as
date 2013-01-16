package MCW.Resource.Util
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
		static public const RES_IMG_UI:int = 0x00;
		static public const RES_IMG_ICO:int = 0x01;
		static public const RES_IMG_ANIM:int = 0x02;
		static public const RES_IMG_BIGPIC:int = 0x03;
		static public const RES_IMG_APIC:int = 0x04;
		static public const RES_SND_MUSIC:int = 0x10;
		static public const RES_SND_FX:int = 0x11;
		static public const RES_SND_VOICE:int = 0x12;
		static public const RES_SCR_DIALOG:int = 0x20;
		static public const RES_SCR_BATTLE:int = 0x21;
		static public const RES_SCR_ITEM:int = 0x22;
		static public const RES_SCR_TASK:int = 0x23;
		static public const RES_SCR_NPC:int = 0x24;
		static public const RES_DESC_MAP:int = 0x30;
		static public const RES_DESC_BWCHAR:int = 0x31;
		static public const RES_DESC_NPC:int = 0x32;
		static public const RES_DESC_GATE:int = 0x33;
		static public const RES_DESC_TASK_LOGIC:int = 0x34;
		static public const RES_DESC_TASK_TEXT:int = 0x35;
		static public const RES_DESC_DIALOG:int = 0x36;
		static public const RES_DESC_BATTLEUNIT:int = 0x37;
		static public const RES_DESC_MISSLE:int = 0x38;
		static public const RES_DESC_SUMONSKILL:int = 0x39;
		
		/*
		static public const RES_TYPE_IMAGE:int = 1;
		static public const RES_TYPE_SOUND:int = 2;
		static public const RES_TYPE_SCRIPT:int = 4;
		static public const RES_TYPE_DESC:int = 5;
		*/
		// an object that stores all resources and keeps track of all resourceses
		private var _res:Object;
		
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
			_res = new Object();
			/*
				_res[resourceid].data
				_res[resourceid].ref
			*/
		
			/*
			_imgResRef = new Array();
			_sndResRef = new Array();
			_scrResRef = new Array();
			_desResRef = new Array();
			
			_imgRes = new Array();
			_sndRes = new Array();
			_scrRes = new Array();
			_desRes = new Array();
			*/
			_resLoader = ResourceLoader.getInstance();
		}
		
		private function initResObj():Object
		{
			var ret:Object = new Object();
			ret.isLoading = false;
			ret.loaded = false;
			ret.ref = 0;
			ret.reqTargets = new Array();
			return ret;
		}
		
		// target can be null
		public function getResource(rtype:int, rid:int, target:*, pr:int):*
		{
			var rind :int = (rtype << 16) + rid;
			if (_res[rind] == null)
			{
				_res[rind] = initResObj();
				if (target != null)
					_res[rind].reqTargets.push(target);
				if (!_res[rind].isLoading)
				{
					_resLoader.addLoadRequest(rtype, rid, pr, target);
					_res[rind].isLoading = true;
				}
				return null;

			}
			else if (_res[rind].data == null)// has requested, but not loaded yet
			{
				if (target != null)
					_res[rind].reqTargets.push(target);
				if (!_res[rind].isLoading)
				{
					_resLoader.addLoadRequest(rtype, rid, pr, target);
					_res[rind].isLoading = true;
				}
				return null;
			}
			else // has loaded, just return.
			{
				if (target != null)
					++_res[rind].ref;
				return _res[rind].data;
			}
		}
		
		
		/*
			called by resource related elements
		*/
		/*
		public function getImgResByID(rid:int, target:*, pr:int):*
		{
			if (_imgRes[rid] == null)
			{
				/* TODO: request the resource from loader
						register callback function using class
				
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
		*/
		/*
		called by resource related elements
		
		public function getDescResByID(rid:int, target:*, pr:int):*
		{
			if (_desRes[rid] == null)
			{
				/* TODO: request the resource from loader
				register callback function using class
				if (_desResRef[rid] == null)
				{
					_desResRef[rid] = initResRef();
				}
				_desResRef[rid].reqTargets.push(target);
				if (!_desResRef[rid].isLoading)
				{
					_resLoader.addLoadRequest(ResManager.RES_TYPE_DESC, rid, pr, target);
					_desResRef[rid].isLoading = true;
				}
				
				return null;
			}
			else
			{
				++_desResRef[rid].ref;
				return _desRes[rid];
			}
		}
		*/
		/*
			plug resource to the 4 arrays
		*/
		public function plugResource(rtype:int, rid:int, res:*):void
		{
			var rt:Array;
			var i:int;
			var rind:int = (rtype << 16) + rid; 
			_res[rind].data = res;
			rt = _res[rind].reqTargets;
			for (i = 0; i< rt.length; ++i)
			{
				// inform all entities that ever requested for this resource
				rt[i].onResLoaded(rtype, rid);
			}
			trace(rtype + "_" + rid + " loaded.");
		}
			/*
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
						rt[i].onResLoaded(rtype, rid);
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
						rt[i].onResLoaded(rtype, rid);
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
		*/
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
		
		public function releaseResource(rtype:int, rid:int):void
		{
			var rind:int = (rtype << 16) + rid;
			--_res[rind].ref;
			if (_res[rind].ref == 0)
			{
				_res[rind].data.release();
				_res[rind] = null;
			}
		}
		
		/*
			TODO: other types of resources' get function
		 */
	}
}