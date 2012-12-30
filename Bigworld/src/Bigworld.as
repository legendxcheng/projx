package
{
	
	import MCW.BigWorld.Logic.RenderDirector;
	
	import flash.display.Sprite;
	
	
	[SWF(width="1200", height="600")]
	public class Bigworld extends Sprite
	{
		public function Bigworld()
		{
			var cc:RenderDirector = RenderDirector.getInstance();
			
			addChild(cc.bgLayer);
			addChild(cc.mainLayer);
			//addChild(cc.uiLayer);

		}
	}
}