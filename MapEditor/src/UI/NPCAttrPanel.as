package UI{
	
	import Logic.ControlCenter;
	
	import org.aswing.*;
	import org.aswing.border.*;
	import org.aswing.colorchooser.*;
	import org.aswing.event.AWEvent;
	import org.aswing.ext.*;
	import org.aswing.geom.*;
	
	/**
	 * MyPane
	 */
	public class NPCAttrPanel extends JPanel{
		
		private var cc:ControlCenter;
		
		//members define
		private var label2:JLabel;
		private var label3:JLabel;
		private var label4:JLabel;
		private var label5:JLabel;
		private var label6:JLabel;
		private var label7:JLabel;
		private var label8:JLabel;
		private var label9:JLabel;
		private var label10:JLabel;
		private var label11:JLabel;
		private var label12:JLabel;
		private var scrollpane13:JScrollPane;
		private var npcTaskList:JList;
		private var taskIDTF:JTextField;
		private var npcNameTF:JTextField;
		private var npcIDTF:JTextField;
		private var npcPartyTF:JTextField;
		private var npcAnimTF:JTextField;
		private var npcFun1TF:JTextField;
		private var npcFun1ATF:JTextField;
		private var npcFun3TF:JTextField;
		private var npcFun3ATF:JTextField;
		private var npcFun2TF:JTextField;
		private var npcFun2ATF:JTextField;
		private var npcXTF:JTextField;
		private var npcYTF:JTextField;
		private var addTaskBtn:JButton;
		private var delTaskBtn:JButton;
		private var saveNPCBtn:JButton;
		private var label19:JLabel;
		private var togglebutton21:JToggleButton;
		private var label22:JLabel;
		private var button23:JButton;
		private var label24:JLabel;
		private var label25:JLabel;
		
		/**
		 * MyPane Constructor
		 */
		public function NPCAttrPanel(){
			//component creation
			setSize(new IntDimension(180, 620));
			var layout0:EmptyLayout = new EmptyLayout();
			setLayout(layout0);
			
			label2 = new JLabel();
			label2.setLocation(new IntPoint(5, 5));
			label2.setSize(new IntDimension(70, 20));
			label2.setText("ID");
			label2.setHorizontalAlignment(AsWingConstants.RIGHT);
			
			npcIDTF = new JTextField();
			npcIDTF.setLocation(new IntPoint(80, 5));
			npcIDTF.setSize(new IntDimension(100, 20));
			
			label3 = new JLabel();
			label3.setLocation(new IntPoint(5, 25));
			label3.setSize(new IntDimension(70, 20));
			label3.setText("名称");
			label3.setHorizontalAlignment(AsWingConstants.RIGHT);
			label3.setVerticalAlignment(AsWingConstants.TOP);
			
			npcNameTF = new JTextField();
			npcNameTF.setLocation(new IntPoint(80, 25));
			npcNameTF.setSize(new IntDimension(100, 20));
			
			label4 = new JLabel();
			label4.setLocation(new IntPoint(5, 45));
			label4.setSize(new IntDimension(70, 20));
			label4.setText("阵营");
			label4.setHorizontalAlignment(AsWingConstants.RIGHT);
			
			npcPartyTF = new JTextField();
			npcPartyTF.setLocation(new IntPoint(80, 45));
			npcPartyTF.setSize(new IntDimension(100, 20));
			
			label5 = new JLabel();
			label5.setLocation(new IntPoint(5, 65));
			label5.setSize(new IntDimension(70, 20));
			label5.setText("动画ID");
			label5.setHorizontalAlignment(AsWingConstants.RIGHT);
			
			npcAnimTF = new JTextField();
			npcAnimTF.setLocation(new IntPoint(80, 65));
			npcAnimTF.setSize(new IntDimension(100, 20));
			
			label6 = new JLabel();
			label6.setLocation(new IntPoint(5, 85));
			label6.setSize(new IntDimension(70, 20));
			label6.setText("功能1 ID");
			label6.setHorizontalAlignment(AsWingConstants.RIGHT);
			
			npcFun1TF = new JTextField();
			npcFun1TF.setLocation(new IntPoint(80, 85));
			npcFun1TF.setSize(new IntDimension(100, 20));
			
			
			label7 = new JLabel();
			label7.setLocation(new IntPoint(5, 105));
			label7.setSize(new IntDimension(70, 20));
			label7.setText("功能1 参数");
			label7.setHorizontalAlignment(AsWingConstants.RIGHT);
			
			npcFun1ATF = new JTextField();
			npcFun1ATF.setLocation(new IntPoint(80, 105));
			npcFun1ATF.setSize(new IntDimension(100, 20));
			
			label8 = new JLabel();
			label8.setLocation(new IntPoint(5, 125));
			label8.setSize(new IntDimension(70, 20));
			label8.setText("功能2 ID");
			label8.setHorizontalAlignment(AsWingConstants.RIGHT);
			
			npcFun2TF = new JTextField();
			npcFun2TF.setLocation(new IntPoint(80, 125));
			npcFun2TF.setSize(new IntDimension(100, 20));
			
			label9 = new JLabel();
			label9.setLocation(new IntPoint(5, 145));
			label9.setSize(new IntDimension(70, 20));
			label9.setText("功能2 参数");
			label9.setHorizontalAlignment(AsWingConstants.RIGHT);
			
			npcFun2ATF = new JTextField();
			npcFun2ATF.setLocation(new IntPoint(80, 145));
			npcFun2ATF.setSize(new IntDimension(100, 20));
			
			label10 = new JLabel();
			label10.setLocation(new IntPoint(5, 165));
			label10.setSize(new IntDimension(70, 20));
			label10.setText("功能3 ID");
			label10.setHorizontalAlignment(AsWingConstants.RIGHT);
			
			npcFun3TF = new JTextField();
			npcFun3TF.setLocation(new IntPoint(80, 165));
			npcFun3TF.setSize(new IntDimension(100, 20));
			
			label11 = new JLabel();
			label11.setLocation(new IntPoint(5, 185));
			label11.setSize(new IntDimension(70, 20));
			label11.setText("功能3 参数");
			label11.setHorizontalAlignment(AsWingConstants.RIGHT);
			
			npcFun3ATF = new JTextField();
			npcFun3ATF.setLocation(new IntPoint(80, 185));
			npcFun3ATF.setSize(new IntDimension(100, 20));
			
			label12 = new JLabel();
			label12.setFont(new ASFont("Tahoma", 11, true, false, false, false));
			label12.setLocation(new IntPoint(5, 205));
			label12.setSize(new IntDimension(70, 20));
			label12.setText("派发任务");
			label12.setHorizontalAlignment(AsWingConstants.LEFT);
			
			scrollpane13 = new JScrollPane();
			scrollpane13.setLocation(new IntPoint(5, 225));
			scrollpane13.setSize(new IntDimension(108, 250));
			var border1:CaveBorder = new CaveBorder();
			border1.setBeveled(true);
			scrollpane13.setBorder(border1);
			
			npcTaskList = new JList();
			npcTaskList.setLocation(new IntPoint(2, 2));
			npcTaskList.setSize(new IntDimension(104, 246));
						
			taskIDTF = new JTextField();
			taskIDTF.setLocation(new IntPoint(120, 300));
			taskIDTF.setSize(new IntDimension(60, 20));
			
			addTaskBtn = new JButton();
			addTaskBtn.setLocation(new IntPoint(120, 325));
			addTaskBtn.setSize(new IntDimension(60, 20));
			addTaskBtn.setText("增加任务");
			
			delTaskBtn = new JButton();
			delTaskBtn.setLocation(new IntPoint(120, 355));
			delTaskBtn.setSize(new IntDimension(60, 20));
			delTaskBtn.setText("删除任务");
			
			saveNPCBtn = new JButton();
			saveNPCBtn.setLocation(new IntPoint(120, 450));
			saveNPCBtn.setSize(new IntDimension(60, 20));
			saveNPCBtn.setText("保存NPC");
			
			
			label19 = new JLabel();
			label19.setFont(new ASFont("Tahoma", 11, true, false, false, false));
			label19.setLocation(new IntPoint(5, 480));
			label19.setSize(new IntDimension(60, 20));
			label19.setText("位置");
			label19.setHorizontalAlignment(AsWingConstants.LEFT);
			
			togglebutton21 = new JToggleButton();
			togglebutton21.setLocation(new IntPoint(5, 540));
			togglebutton21.setSize(new IntDimension(120, 20));
			togglebutton21.setText("点击选择地图位置");
			
			label22 = new JLabel();
			label22.setLocation(new IntPoint(5, 500));
			label22.setSize(new IntDimension(70, 20));
			label22.setText("大地图ID");
			label22.setHorizontalAlignment(AsWingConstants.RIGHT);
			
			button23 = new JButton();
			button23.setLocation(new IntPoint(5, 520));
			button23.setSize(new IntDimension(70, 20));
			button23.setText("选择参考图");
			
			label24 = new JLabel();
			label24.setLocation(new IntPoint(5, 560));
			label24.setSize(new IntDimension(20, 20));
			label24.setText("x");
			
			npcXTF = new JTextField();
			npcXTF.setLocation(new IntPoint(25, 560));
			npcXTF.setSize(new IntDimension(60, 20));
			npcXTF.setEditable(false);
			
			label25 = new JLabel();
			label25.setLocation(new IntPoint(100, 560));
			label25.setSize(new IntDimension(20, 20));
			label25.setText("y");
			
			npcYTF = new JTextField();
			npcYTF.setLocation(new IntPoint(120, 560));
			npcYTF.setSize(new IntDimension(60, 20));
			npcYTF.setEditable(false);
			
			//component layoution
			append(label2);
			append(label3);
			append(label4);
			append(label5);
			append(label6);
			append(label7);
			append(label8);
			append(label9);
			append(label10);
			append(label11);
			append(label12);
			append(scrollpane13);
			append(taskIDTF);
			append(addTaskBtn);
			append(delTaskBtn);
			append(saveNPCBtn);
			append(label19);
			append(togglebutton21);
			append(label22);
			append(button23);
			append(label24);
			append(label25);
			append(npcIDTF);
			append(npcNameTF);
			append(npcPartyTF);
			append(npcFun1TF);
			append(npcFun2TF);
			append(npcFun3TF);
			append(npcFun1ATF);
			append(npcFun2ATF);
			append(npcFun3ATF);
			append(npcAnimTF);
			append(npcXTF);
			append(npcYTF);
			
			scrollpane13.append(npcTaskList);
			
			cc = ControlCenter.getInstance();
			cc.nAttrPanel = this;
			
			saveNPCBtn.addActionListener(onSaveNPC);
		}
		
		public function fillNPCContent(np:Object):void
		{
			this.clearContents();
			if (np == null)
				return;
			this.npcIDTF.setText(np.npcid);
			this.npcXTF.setText(np.xind);
			this.npcYTF.setText(np.yind);
		}
		
		private function onSaveNPC(e:AWEvent):void
		{
			var ids:String = this.npcIDTF.getText();
			if (ids.length == 0)
			{
				var jop:JOptionPane = JOptionPane.showMessageDialog("NPC ID未填写", "请写入NPC ID");
				return;
			}
			var xs:String = this.npcXTF.getText();
			if (xs.length == 0)
			{
				JOptionPane.showMessageDialog("NPC ID未填写", "请写入NPC ID");
				return;
			}
			cc.tmpNPC = new Object();
			if (cc.npcState == 1)// new NPC
			{
				cc.tmpNPC.xind = cc.npcX;
				cc.tmpNPC.yind = cc.npcY;
				cc.tmpNPC.npcid = parseInt(ids);
				cc.insertTmpNPC();
				cc.npcState = 2;// editing npc
			}
			else // edit NPC
			{
				cc.setNPCPos(parseInt(this.npcXTF.getText()), parseInt(this.npcYTF.getText()));	
				cc.tmpNPC.xind = cc.npcX;
				cc.tmpNPC.yind = cc.npcY;
				cc.tmpNPC.npcid = parseInt(ids);
				cc.saveTmpNPC();
			}
			
		}
		
		public function setNPCPosDisplayed(nx:int, ny:int):void
		{
			this.npcXTF.setText(nx.toString());
			this.npcYTF.setText(ny.toString());
		}
		
		//_________getters_________
		
		// when adding a new NPC
		public function clearContents():void
		{
			taskIDTF.setText("");
			npcNameTF.setText("");
			npcIDTF.setText("");
			npcPartyTF.setText("");
			npcAnimTF.setText("");
			npcFun1TF.setText("");
			npcFun1ATF.setText("");
			npcFun3TF.setText("");
			npcFun3ATF.setText("");
			npcFun2TF.setText("");
			npcFun2ATF.setText("");
		}
		
		
		
		
		
		
		
		
		
		
		public function getNpcTaskList():JList{
			return npcTaskList;
		}
		
		public function getTaskID():JTextField{
			return taskIDTF;
		}
		
		public function getAddTaskBtn():JButton{
			return addTaskBtn;
		}
		
		public function getDelTaskBtn():JButton{
			return delTaskBtn;
		}
		
		
		public function getTogglebutton21():JToggleButton{
			return togglebutton21;
		}
		
		
		public function getButton23():JButton{
			return button23;
		}
		
		
		
		
	}
}
