package UI
{
	import org.aswing.JFrame;
	
	public class NPCAttrFrame extends JFrame
	{
		public function NPCAttrFrame(owner:*=null, title:String="", modal:Boolean=false)
		{
			super(owner, "NPC属性", modal);
			this.getContentPane().append(new NPCAttrPanel());
			this.x = 200;
			this.y = 0;
			this.width = 200;
			this.height = 620;
			this.setDragable(false);
			this.setResizable(false);
			this.setClosable(false);
			
		}
	}
}