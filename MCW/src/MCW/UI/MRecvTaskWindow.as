package MCW.UI
{
	import MCW.Resource.MSPic;
	import MCW.Resource.MSSimpleDesc;
	import MCW.Resource.Util.ResManager;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import org.aswing.EmptyLayout;
	import org.aswing.JWindow;
	import org.aswing.event.AWEvent;

	public class MRecvTaskWindow extends JWindow implements IMSUI
	{
		private var _bg:Bitmap;
		private var _bgPic:MSPic;
		private var _closeBtn:MRecvTaskCloseBtn;
		private var _recvBtn:MButtonA;
		private var _taskReqTitle:TextField;
		private var _taskBonusTitle:TextField;
		private var _taskTextDesc:MSSimpleDesc;
		private var _taskReqText:TextField;
		private var _taskDescText:TextField;
		private var _taskNameText:TextField;
		
		
		public function MRecvTaskWindow(owner:*=null, modal:Boolean=false)
		{
			super(owner, modal);
			
			
			_bg = new Bitmap();
			this.addChild(_bg);
			this.x = 299;
			this.y = 150;
			this.width = 603;
			this.height = 316;
			this.getContentPane().setLayout(new EmptyLayout());
			
			_recvBtn = new MButtonA(200, "接受任务");
			_recvBtn.x = 360;
			_recvBtn.y = 255;
			this.getContentPane().append(_recvBtn);
			
			_closeBtn = new MRecvTaskCloseBtn();
			_closeBtn.x = 581;
			_closeBtn.y = 7;
			this.addChild(_closeBtn);
			
			_taskReqTitle = new TextField();
			_taskReqTitle.htmlText = "<font size=\"15\" color=\"#FFC436\">任务要求</fnot>";
			_taskReqTitle.x = 47;
			_taskReqTitle.y = 212;
			_taskReqTitle.selectable = false;			
			this.addChild(_taskReqTitle);
			
			_taskBonusTitle = new TextField();
			_taskBonusTitle.htmlText = "<font size=\"14\" color=\"#BBBBBB\">任务奖励</fnot>";
			_taskBonusTitle.x = 430;
			_taskBonusTitle.y = 18;
			_taskBonusTitle.selectable = false;
			this.addChild(_taskBonusTitle);
			
			_taskReqText = new TextField();
			_taskReqText.x = 55;
			_taskReqText.y = 235;
			_taskReqText.selectable = false;
			_taskReqText.multiline = true;
			this.addChild(_taskReqText);
			
			_taskDescText = new TextField();
			_taskDescText.x = 50;
			_taskDescText.y = 50;
			_taskDescText.selectable = false;
			_taskDescText.multiline = true;
			_taskDescText.width = 240;
			_taskDescText.autoSize = TextFieldAutoSize.LEFT;
			_taskDescText.wordWrap = true;
			_taskDescText.addEventListener(TextEvent.LINK, _onClickText);
			this.addChild(_taskDescText);
			
			_taskNameText = new TextField();
			_taskNameText.x = 122;
			_taskNameText.y = 18;
			_taskNameText.selectable = false;
			_taskNameText.autoSize = TextFieldAutoSize.CENTER;
			this.addChild(_taskNameText);
			
			
			
			
			this.requestResource();
		}
		
		private function _onClickText(e:TextEvent):void
		{
			trace(e.text);
		}
		
		private function fillTaskText():void
		{
			var reqStr:String;
			reqStr = "<font color=\"#ffffff\"><font color=\"#ffff00\">" + _taskTextDesc.metaJson.req[0] + "</font><br>" +_taskTextDesc.metaJson.req[1] + "</font>";
			_taskReqText.htmlText = HtmlCodeTranslator.translate(reqStr);
			_taskDescText.htmlText = "<font size=\"12\" color=\"#CC9966\">" +
				HtmlCodeTranslator.translate(_taskTextDesc.metaJson.desc) + "</font>";
			_taskNameText.htmlText = "<font size=\"14\" color=\"#BBBBBB\">" + _taskTextDesc.metaJson.name + "</fnot>";
			
		}
		
		public function onResLoaded(rtype:int, rid:int):void
		{
			if (rtype == ResManager.RES_IMG_UI)
			{
				if (rid == 5000)// background
				{
					_bgPic = ResManager.getInstance().getResource(ResManager.RES_IMG_UI,
						rid, this, 1);
					_bg.bitmapData = _bgPic.bmd;
				}
			}
			else if (rtype == ResManager.RES_DESC_TASK_TEXT)
			{
				_taskTextDesc = ResManager.getInstance().getResource(ResManager.RES_DESC_TASK_TEXT,
					rid, this, 1);
				fillTaskText();
			}
		}
		
		public function requestResource():void
		{
			_bgPic = ResManager.getInstance().getResource(ResManager.RES_IMG_UI, 5000, this, 1);
			if (_bgPic != null)
			{
				_bg.bitmapData = _bgPic.bmd;
			}
			
			// load task desc text
			this._taskTextDesc = ResManager.getInstance().getResource(ResManager.RES_DESC_TASK_TEXT,
				0, this, 1);
			if (_taskTextDesc !=null)
			{
				fillTaskText();
			}
			
		}
	}
}