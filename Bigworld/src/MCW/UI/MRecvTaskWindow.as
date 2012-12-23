package MCW.UI
{
	import MCW.BigWorld.Resource.MSPic;
	import MCW.BigWorld.Resource.Util.ResManager;
	
	import flash.display.Bitmap;
	
	import org.aswing.EmptyLayout;
	import org.aswing.JWindow;
	
	public class MRecvTaskWindow extends JWindow implements IMSUI
	{
		private var _bg:Bitmap;
		private var _bgPic:MSPic;
		
		private var _recvBtn:MButtonA;
		
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
			
			this.requestResource();
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
		}
		
		public function requestResource():void
		{
			_bgPic = ResManager.getInstance().getResource(ResManager.RES_IMG_UI, 5000, this, 1);
			if (_bgPic != null)
			{
				_bg.bitmapData = _bgPic.bmd;
			}
		}
	}
}