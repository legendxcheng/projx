package MCW.UI
{
	import flash.display.BitmapData;
	
	/*
	Interface for all display object
	*/
	public interface IMSUI
	{
		// Resource load
		function onResLoaded(rtype:int, rid:int):void;
		
		// Request Resource
		function requestResource():void;
	}
}