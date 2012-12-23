package MCW.BigWorld.Resource.Parser
{
	import MCW.BigWorld.Resource.MSMapDesc;
	import MCW.BigWorld.Resource.Util.ResManager;
	
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	import mx.core.ByteArrayAsset;

	/*
		parser for map desc
	*/
	public class DescMapParser implements IParser
	{
		private var _rid:int;
		private var _data:ByteArray;
		private var _map:MSMapDesc;
		
		
		
		public function DescMapParser(rid:int, data:*)
		{
			
			_data = data;
			_rid = rid;
		}
		
		/* 
			parse resource
		*/
		public function parseResource():void
		{
			_map = new MSMapDesc();
			var ba:ByteArray = _data;
			var jsonStr:String = ba.readUTF();
			var json:Object = JSON.parse(jsonStr);
			
			_map.metaJson = json;
			
			var i: int;
		    
			var tmp:int;
			var tmp2:int;
			
			var tArea:Vector.<Boolean> = new Vector.<Boolean>;
			var pArea:Vector.<Boolean> = new Vector.<Boolean>;
			
			for (i = 0; i < json.gridNum; ++i)
			{
				if (i % 8 == 0)
				{
					tmp = ba.readByte();
				}
				tmp2 = (1 << (7- i % 8));
				if ((tmp & tmp2) > 0)
				{
					pArea[i] = true;	
				}
				else pArea[i] = false;
				
			}
			for (i = 0; i < json.gridNum; ++i)
			{
				if (i % 8 == 0)
				{
					tmp = ba.readByte();
				}
				tmp2 = (1 << (7- i % 8));
				if ((tmp & tmp2) > 0)
				{
					tArea[i] = true;	
				}
				else tArea[i] = false;
				
			}
			
			_map.pArea = pArea;
			_map.tArea = tArea;
			
			// plug resource	
			ResManager.getInstance().plugResource(ResManager.RES_DESC_MAP, _rid, _map);
				
		}
		
	}
}