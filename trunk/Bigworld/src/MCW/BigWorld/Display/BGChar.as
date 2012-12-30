package MCW.BigWorld.Display
{
	import MCW.BigWorld.Display.Base.MSprite;
	import MCW.Resource.MSAnimation;
	import MCW.Resource.MSSimpleDesc;
	import MCW.Resource.Util.ResManager;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import mx.resources.ResourceManager;
	
	// big world character
	public class BGChar extends MSprite
	{
		
		/*
			@param ctype character type
			@more attributes may be added in the future.
		*/
		
		private var _curDir:int;
		private var _isMoving:Boolean;
		private var _targetX:int;
		private var _targetY:int;
		private var _speed:Number;	
		private var _dirAnim:Vector.<MSAnimation>;
		private var _stopAnim:MSAnimation;
		private var _ctype:int;
		private var _desc:MSSimpleDesc;
		
		
		public function BGChar(ctype:int)
		{
			super();
			_speed = 3.0;
			_targetX = -100;
			_targetY = -100;
			_ctype = ctype;
			_dirAnim = new Vector.<MSAnimation>;
			_stopAnim = null;
			_isMoving = false;
		}
		
		private function calcDir(p:Point):int
		{
			if (p.x < 0)
			{
				if (p.y < 0)
				{
					return 3;	
				}
				else if (p.y == 0)
				{
					return 2;
				}
				else
				{
					return 1;
				}
			}
			else if (p.x == 0)
			{
				if (p.y < 0)
				{
					return 4;
				}
				else if (p.y == 0)
				{
					return 0;
				}	
				else
				{
					
				}
			}
			else
			{
				if (p.y < 0)
				{
					return 5;	
				}
				else if (p.y == 0)
				{
					return 6;
				}
				else
				{
					return 7;
				}	
			}
			return 0;
		}
		
		override public function update():void
		{
			if (!_isMoving)
				return;
			
			if (_targetX < 0)
				return;
			var p:Point = new Point(_targetX - _x, _targetY - _y);	
			var len:Number = p.length;
			if (len > _speed)
			{
				p.x = p.x / len * _speed;
				p.y = p.y / len * _speed;
				
				

				var tmp:int = this.calcDir(p);
				
				if (tmp != _curDir)
				{
					_curDir = tmp;
					
					

				}
				_animation = _dirAnim[_curDir];
				_isPlaying = true;
				_x += p.x;
				_y += p.y;
				
			}
			else
			{
				_x = _targetX;
				_y = _targetY;
				_isMoving = false;
				_isPlaying = false;
				_animation = _stopAnim;
				this.curFrame = _curDir;
				
			}
			updateAnim();
		}
		
		public function setMoveTarget(ax:int, ay:int):void
		{
			_targetX = ax;
			_targetY = ay;
			_isMoving = true;
		}
		
		override public function requestResource():void
		{
			var resMgr:ResManager = ResManager.getInstance();
			_desc = resMgr.getResource(ResManager.RES_DESC_BWCHAR, 1000, this, 1) as MSSimpleDesc;
		}
		
		override public function onResLoaded(rtype:int, rid:int):void
		{
			if (rtype == ResManager.RES_DESC_BWCHAR && rid == _ctype) //character desc
			{
				_desc = ResManager.getInstance().getResource(rtype, rid, this, 1);
				for (var i:int = 0; i < _desc.metaJson.moveAnim.length; ++i)
				{
					_dirAnim[i] = ResManager.getInstance().getResource(ResManager.RES_IMG_ANIM,
						_desc.metaJson.moveAnim[i], this, 1);
				}
				_stopAnim = ResManager.getInstance().getResource(ResManager.RES_IMG_ANIM,
					_desc.metaJson.stopAnim, this, 1);
				
				
			}
			if (rtype == ResManager.RES_IMG_ANIM) // temp
			{
				if (rid == _desc.metaJson.stopAnim)
				{
					_stopAnim = ResManager.getInstance().getResource(ResManager.RES_IMG_ANIM,
						_desc.metaJson.stopAnim, this, 1);
				}
				else
				{
					for (var i:int = 0; i < _desc.metaJson.moveAnim.length; ++i)
					{
						if (_desc.metaJson.moveAnim[i] == rid)
						{
							_dirAnim[i] = ResManager.getInstance().getResource(ResManager.RES_IMG_ANIM,
								_desc.metaJson.moveAnim[i], this, 1);	
							break;
						}
						
					} 
				}				
			}
		}
		

	}
}