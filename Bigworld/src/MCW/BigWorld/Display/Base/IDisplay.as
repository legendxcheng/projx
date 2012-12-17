package MCW.BigWorld.Display.Base
{
	import flash.display.BitmapData;

	/*
		Interface for all display object
	*/
	public interface IDisplay
	{
		// draw， called by MainLayer every frame
		function draw(_buffer:BitmapData, camX:int, camY:int):void;
		
		// Resource load
		function onResLoaded(rtype:int, rid:int):void;
		
		// Request Resource
		function requestResource():void;
	}
}