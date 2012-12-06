package
{
	
	import Logic.ControlCenter;
	
	import flash.display.Sprite;

	[SWF(width="1200", height="600")]
	public class Bigworld extends Sprite
	{
		public function Bigworld()
		{
			var cc:ControlCenter = ControlCenter.getInstance();
			addChild(cc.bgLayer);
			addChild(cc.mainLayer);
			addChild(cc.uiLayer);
		}
	}
}