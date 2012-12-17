package MCW.BigWorld.Display.Base
{
	import MCW.BigWorld.Layers.MainLayer;
	import MCW.BigWorld.Logic.ControlCenter;
	import MCW.BigWorld.Resource.IResource;
	import MCW.BigWorld.Resource.MSAnimation;
	
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/*
		Logic display elements
		Basic class for all sprites in our system
	*/
	public class MSprite extends MBasic
	{
		/*
			Properties
		*/
		protected var _loop: Boolean;
		protected var _curFrame:int;
		protected var _isPlaying :Boolean;
		protected var _dirty:Boolean;
		
		// matrix related properties
		
		protected var _animation:MSAnimation;

		

		public function set curFrame(value:int):void
		{
			_dirty = true;
			_curFrame = value;
		}

		override public function canDisplay():Boolean
		{
			if (_animation == null)
				return false;
			return true;
		}

		
		/*
		get current frame's bitmapData
		*/
		public function getCurFrame():BitmapData
		{
			return _animation.getBitmapData(_curFrame);
		}
		
		
		
		public function MSprite()
		{
			super();
			_loop = true;
			_isPlaying = true;
		}
		
		public function update():void
		{
			updateAnim();
		}
		
		protected function updateAnim():void
		{
			if (!_isPlaying && !_dirty)
				return;
			if (!canDisplay())
				return;
			if (_isPlaying)
				++_curFrame;
			_matrixChanged = true;
			
			if (_needAdvDraw)
			{
				if (_aBuf != null)
					_aBuf.dispose();
				_aBuf = _animation.getBitmapData(_curFrame);
			}
			
			if (_curFrame == _animation.frameNum())
			{
				if (_loop)
				{
					_curFrame = 0;
				}
				else
				{
					--_curFrame;
					_isPlaying = false;
				}
				
			}
			
			_dirty = false;
			
		}
		
		
		override public function getMatrix():Matrix
		{

			
			if (_matrixChanged)
			{	
				
				_matrix = new Matrix();	
				_matrix.scale(_scaleX, _scaleY);
				_matrix.rotate(_rotation);
				var tp:Point = _animation.getAnchorPoint(_curFrame);
				//_matrix.transformPoint(tp);
				tp = _matrix.transformPoint(tp);

				// _matrix translate (-fx-ax+sssx+x, -fy-ay+sssx+y)
				_matrix.translate(_x - tp.x, _y - tp.y);

				
				//_matrix.translate(20, 20);
				
					
				_matrixChanged = false;	
				
			}
			
			return _matrix;
		}
		
		public function changeAnimatin(na:MSAnimation, loop:Boolean):void
		{
			_animation = na;
			_loop = loop;
		}
		
		
		override public function draw(buffer:BitmapData, camX:int, camY:int):void
		{
			if (!canDisplay())
				return;
			if (!_visible)
				return;
			
			if (_needAdvDraw)
			{
				/*
				var rect:Rectangle;
				//rect = _animation.getClipRect(_curFrame);
				rect = _aBuf.rect;
				
				// calc new rectangle(after rotation)
				
				// four points
				var p1 :Point;
				var p2: Point;
				var p3:Point;
				var p4:Point;
				var ma:Matrix = new Matrix();
				ma.rotate(_rotation);
				ma.scale(_scaleX, scaleY);
				p1 = ma.transformPoint(new Point(rect.x, rect.y));
				p2 = ma.transformPoint(new Point(rect.x, rect.y + rect.height));
				p3 = ma.transformPoint(new Point(rect.x + rect.width, rect.y));
				p4 = ma.transformPoint(new Point(rect.x + rect.width, rect.y + rect.height));
				
				var xmin:Number, xmax:Number, ymin:Number, ymax:Number;
				xmin = Math.min(p1.x, p2.x, p3.x, p4.x);
				ymin = Math.min(p1.y, p2.y, p3.y, p4.y);
				xmax = Math.max(p1.x, p2.x, p3.x, p4.x);
				ymax = Math.max(p1.y, p2.y, p3.y, p4.y);
				rect.x = xmin + _x;
				rect.y = ymin + _y;
				rect.width = xmax - xmin;
				rect.height = ymax - ymin;
				
				rect.width *= _scaleX;
				rect.height *= _scaleY;
				rect.x = _x + rect.x * _scaleX;
				rect.y = _y + rect.y * _scaleY;
				
				*/
				buffer.draw(_aBuf, getMatrix(), null, null, null, true);
			}
			else // basic draw, use copyPixels
			{
				var tt:Point = _animation.getBasicPoint(_curFrame);
				tt.x += _x - camX;
				tt.y += _y - camY;
				buffer.copyPixels(_animation.buffer, _animation.getBasicRect(_curFrame), tt, null, null, true);
			}
			
						
			
			if (_debug)
				drawAnchor(buffer);
		}
		

		
		
		
	}
}