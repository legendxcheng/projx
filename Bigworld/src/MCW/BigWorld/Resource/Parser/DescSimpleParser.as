package MCW.BigWorld.Resource.Parser
{
	import MCW.BigWorld.Resource.MSMapDesc;
	import MCW.BigWorld.Resource.MSSimpleDesc;
	import MCW.BigWorld.Resource.Util.ResManager;
	
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	import mx.core.ByteArrayAsset;
	
	/*
	parser for map desc
	*/
	public class DescSimpleParser implements IParser
	{
		private var _rtype:int;
		private var _rid:int;
		private var _data:ByteArray;
		private var _sdesc:MSSimpleDesc;
		
		
		
		public function DescSimpleParser(rtype:int, rid:int, data:*)
		{
			
			_rtype = rtype;
			_data = data;
			_rid = rid;
		}
		
		/* 
		parse resource
		*/
		public function parseResource():void
		{
			_sdesc = new MSSimpleDesc();
			var ba:ByteArray = _data;
			var jsonStr:String = ba.readUTF();
			var json:Object = JSON.parse(jsonStr);
			
			_sdesc.metaJson = json;
			
			// plug resource	
			ResManager.getInstance().plugResource(_rtype, _rid, _sdesc);
			
		}
		
	}
}