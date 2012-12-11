package MCW.BigWorld.Resource
{
	/*
		Interface for entities that require resource of any kinds
	*/
	public interface IResource
	{
		/*
			function called when resources have been loaded.
		*/
		//function onResLoaded(rtype:int, rid:int):void;
		
		/*
			release this resource
		*/
		function release():void;
		
		/*
			get resource size
		*/
		function getSize():int;
		
		/*
			get resource id
		*/
		function getID():int;
		
		/*
			get resource type
		*/
		function getType():int;
	}
}