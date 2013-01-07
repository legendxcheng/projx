package UI
{
	import Logic.ControlCenter;
	
	import flash.media.Video;
	
	import flashx.textLayout.events.SelectionEvent;
	
	import org.aswing.ASFont;
	import org.aswing.AbstractButton;
	import org.aswing.AsWingConstants;
	import org.aswing.EmptyLayout;
	import org.aswing.JButton;
	import org.aswing.JFrame;
	import org.aswing.JLabel;
	import org.aswing.JList;
	import org.aswing.JPanel;
	import org.aswing.JScrollPane;
	import org.aswing.VectorListModel;
	import org.aswing.border.CaveBorder;
	import org.aswing.event.AWEvent;
	import org.aswing.util.ObjectUtils;
	
	public class NPCListFrame extends JFrame
	{
		private var _panel:JPanel;
		private var _list:JList;
		private var _sp:JScrollPane;// scroll pane
		private var _addNPCBtn:JButton;
		private var _delNPCBtn:JButton;
		private var _reloadNPCBtn:JButton;
		private var _reloadNPCListBtn:JButton;
		private var cc:ControlCenter;
		
		public function NPCListFrame(owner:*=null, title:String="", modal:Boolean=false)
		{
			super(owner, title, modal);
			this.setTitle("NPC列表");
			this.setDragable(false);
			this.setClosable(false);
			this.setResizable(false);
			
			this.x = 0;
			this.y = 0;
			this.width = 200;
			this.height = 620;
			
			_panel = new JPanel(new EmptyLayout());
			_panel.x = 0;
			_panel.y = 0;
			_panel.setSizeWH(200, 620);
			
			var tl:JLabel = new JLabel("NPC");
			tl.setFont(new ASFont("Tahoma", 11, true, false, false, false));
			tl.x = 0;
			tl.y = 0;
			tl.width = 100;
			tl.height = 20;
			tl.setHorizontalAlignment(AsWingConstants.LEFT);
			_panel.append(tl);
			
			_list = new JList();
			_list.addSelectionListener(onListSelectionChanged);
			
			_sp = new JScrollPane(_list);
			_sp.x = 0;
			_sp.y = 20;
			_sp.width = 180;
			_sp.height = 400;
			
			
			var border1:CaveBorder = new CaveBorder();
			border1.setBeveled(true);
			_sp.setBorder(border1);
			_panel.append(_sp);
			
			_addNPCBtn = new JButton("添加NPC");
			_addNPCBtn.setSizeWH(80, 20);
			_addNPCBtn.x = 0;
			_addNPCBtn.y = 420;
			
			_delNPCBtn = new JButton("删除NPC");
			_delNPCBtn.setSizeWH(80, 20);
			_delNPCBtn.x = 90;
			_delNPCBtn.y = 420;
			
			_reloadNPCBtn = new JButton("重新载入NPC");
			_reloadNPCBtn.setSizeWH(120, 20);
			_reloadNPCBtn.x = 0;
			_reloadNPCBtn.y = 440;
			
			_reloadNPCListBtn = new JButton("重新载入NPC列表");
			_reloadNPCListBtn.setSizeWH(120, 20);
			_reloadNPCListBtn.x = 0;
			_reloadNPCListBtn.y = 460;
			
			
			_addNPCBtn.addActionListener(onAddNPC);
			_delNPCBtn.addActionListener(onDelNPC);
			_panel.append(_addNPCBtn);
			_panel.append(_delNPCBtn);
			_panel.append(_reloadNPCBtn);
			_panel.append(_reloadNPCListBtn);
			
			this.getContentPane().append(_panel);
			

			cc = ControlCenter.getInstance();
			cc.npcListFrame = this;
			
			
		}
		
		private function onListSelectionChanged(e:org.aswing.event.SelectionEvent ):void
		{
			cc.selectNPC(e.getFirstIndex());
		}
		
		public function resetNPCList(nl:Array):void
		{

			if (nl == null)
				return;
			
			var model:VectorListModel = _list.getModel() as VectorListModel;
			model.clear();
			for (var i:int = 0; i < nl.length; ++i)
			{
				model.append(nl[i].npcid.toString());
			}
			
		}
		
		private function onAddNPC(e:AWEvent):void
		{
			
			cc.npcState = 1;// for a new NPC
			// reset npc attrFrame
			cc.nAttrPanel.clearContents();
			cc.tmpNPC = new Object();
			
		}
		
		private function onDelNPC(e:AWEvent):void
		{
			cc.tmpNPC = new Object();
			cc.delNPC();
			
		}
		
		
	}
}