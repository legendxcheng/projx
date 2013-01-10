package MCW.BigWorld.Logic
{
	import MCW.BigWorld.Layers.BgLayer;
	import MCW.BigWorld.Layers.MainLayer;
	import MCW.BigWorld.Layers.UILayer;
	import MCW.Resource.Util.ResourceLoader;
	
	
	

	/*
		Singleton class that governs all logic related issues.
	 */
	
	public class RenderDirector
	{
		
		/*
			camera position X, and Y
		*/
		private var _camX:int;
		private var _camY:int;
		private var _camMoved:Boolean;
		
		private var _bgLayer:BgLayer;
		private var _mainLayer:MainLayer;
		private var _uiLayer:UILayer;
		
		private var _gridSideLen:int;
		private var _crlx:int;// constrain rectangle left x
		private var _crrx:int;
		private var _cruy:int;
		private var _crby:int;
		
		
		static private var _instance:RenderDirector;

		public function get camMoved():Boolean
		{
			return _camMoved;
		}

		public function set camMoved(value:Boolean):void
		{
			_camMoved = value;
		}

		public function get gridSideLen():int
		{
			return _gridSideLen;
		}

		public function get camY():int
		{
			return _camY;
		}

		public function set camY(value:int):void
		{
			_camY = value;
		}

		public function get camX():int
		{
			return _camX;
		}

		public function set camX(value:int):void
		{
			_camX = value;
		}

		public function get uiLayer():UILayer
		{
			return _uiLayer;
		}

		public function get mainLayer():MainLayer
		{
			return _mainLayer;
		}

		public function get bgLayer():BgLayer
		{
			return _bgLayer;
		}

		static public function getInstance():RenderDirector
		{
			if (_instance == null)
			{
				_instance = new RenderDirector();
				
			}
			return _instance;
		}
		
		// // check main char's position
		public function moveCamera():void
		{
			if (!this._bgLayer.isReady())
			{
				return;
			}
		 	var preCamX:int = camX;
			var preCamY:int = camY;
			if (this.mainLayer.mainChar.x > this._crrx + _camX)
			{
				_camX = this.mainLayer.mainChar.x - _crrx;
			}
			else if (this.mainLayer.mainChar.x < this._crlx + _camX)
			{
				_camX = this.mainLayer.mainChar.x - _crlx;
			}
			if (_camX < 0) 
			{
				_camX = 0;
			}
			else if (this._bgLayer.getMapWidth() - 1200 < _camX)
			{
				_camX = this._bgLayer.getMapWidth() - 1200;
			}
			
			if (this.mainLayer.mainChar.y > this._crby + _camY)
			{
				_camY = this.mainLayer.mainChar.y - _crby;
			}
			else if (this.mainLayer.mainChar.y < this._cruy + _camY)
			{
				_camY = this.mainLayer.mainChar.y - _cruy;
			}
			if (_camY < 0) 
			{
				_camY = 0;
			}
			else if (this._bgLayer.getMapHeight() - 600 < _camY)
			{
				_camY = this._bgLayer.getMapHeight() - 600;
			}
			
			if (preCamX != _camX || preCamY != camY)
			{
				this._camMoved = true;
				trace(_camX + "," + _camY);
			}
			
		}
		
		/*
			function called every frame, the main entry for updates
			this function is the [first] function to be called in a update loop
			
		*/
		public function updtate():void
		{
			_camMoved = false;	
			ResourceLoader.getInstance().startALoading();
			moveCamera();		
		}
		
		public function RenderDirector()
		{
			_camX = _camY = 0;
			_bgLayer = new BgLayer();
			_mainLayer = new MainLayer();
			_uiLayer = new UILayer();
			_gridSideLen = 50;
			_crlx = 300;
			_crrx = 900;
			_cruy = 150;
			_crby = 450;
		}
	}
}