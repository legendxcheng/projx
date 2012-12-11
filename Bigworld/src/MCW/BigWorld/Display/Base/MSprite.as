package MCW.BigWorld.Display.Base
{
	import MCW.BigWorld.Resource.IResource;
	import MCW.BigWorld.Resource.MSAnimation;
	
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;

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
		
		// matrix related properties
		
		protected var _animation:MSAnimation;

		

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

		}
		
		public function update():void
		{
			if (!_isPlaying)
				return;
			++_curFrame;
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
		}
		
		
		override public function getMatrix():Matrix
		{
			if (_matrixChanged)
			{	
				
				_matrix = new Matrix();
				
				// may be _x, _y
				var tp:Point = _animation.getAnchorPoint(_curFrame);
				_matrix.translate(-_x + tp.x, -_y + tp.y);
				_matrix.rotate(_rotation);
				_matrix.scale(_scaleX, _scaleY);	
				_matrixChanged = false;	
				
			}
			
			return _matrix;
		}
		
		public function changeAnimatin(na:MSAnimation, loop:Boolean):void
		{
			_animation = na;
			_loop = loop;
		}
		
		
		override public function draw(buffer:BitmapData):void
		{
			if (!canDisplay())
				return;
			if (!_visible)
				return;
			
			buffer.draw(_animation.buffer, getMatrix(), null, null, _animation.getClipRect(_curFrame), false);
			
			
		}
		
		
		
		
	}
}