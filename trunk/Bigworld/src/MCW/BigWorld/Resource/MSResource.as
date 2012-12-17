package MCW.BigWorld.Resource
{
	/*
		base class of resource
	*/
	
	public class MSResource implements IResource
	{
		private var _size:int;
		private var _rid:int;
		
		
		public function MSResource()
		{
			
		}
		
		/*
			release this resource
		*/
		public function release():void
		{
			
		}
		
		/*
		get resource size
		*/
		public function getSize():int
		{
			return _size;
		}
		
		/*
		get resource id
		*/
		public function getID():int
		{
			return _rid;	
		}
		
		/*
			get resource type
		*/
		public function getType():int
		{
			return 0;
		}
		
		
		
	}
}