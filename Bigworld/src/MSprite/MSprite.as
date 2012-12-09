package MSprite
{
	import Resource.IResource;
	import Resource.MSAnimation;
	
	import flash.display.BitmapData;
	import flash.geom.Matrix;

	/*
		Logic display elements
		Basic class for all sprites in our system
	*/
	public class MSprite
	{
		/*
			Properties
		*/
		private var _loop: Boolean;
		private var _curFrame:int;
		private var _isPlaying :Boolean;
		
		// matrix related properties
		private var _scaleX:Number;
		private var _scaleY:Number;
		private var _x:int;
		private var _y:int;

		private var _rotation:Number;// in 0~2PI
		
		private var _visible:Boolean;
		private var _alpha:Boolean;
		private var _animation:MSAnimation;
		private var _matrix:Matrix;

		private var _matrixChanged:Boolean;
		

		public function get rotation():Number
		{
			return _rotation;
		}

		public function set rotation(value:Number):void
		{
			_rotation = value;
			_matrixChanged = true;
		}

		public function get y():int
		{
			return _y;
		}

		public function set y(value:int):void
		{
			_y = value;
			_matrixChanged = true;
		}

		public function get x():int
		{
			return _x;
		}

		public function set x(value:int):void
		{
			_x = value;
			_matrixChanged = true;
		}

		public function get scaleY():Number
		{
			return _scaleY;
		}

		public function set scaleY(value:Number):void
		{
			_scaleY = value;
			_matrixChanged = true;
		}

		public function get scaleX():Number
		{
			return _scaleX;
			
		}

		public function set scaleX(value:Number):void
		{
			_scaleX = value;
			_matrixChanged = true;
		}

		
		/*
		get current frame's bitmapData
		*/
		public function getCurFrame():BitmapData
		{
			return _animation.getBitmapData(_curFrame);
		}
		
		public function getMatrix():Matrix
		{
			if (_matrixChanged)
			{
				_matrix = new Matrix();
				_matrix.translate(-_x, -_y);
				_matrix.rotate(_rotation);
				_matrix.scale(_scaleX, _scaleY);	
				_matrixChanged = false;	
			}
			
			return _matrix;
		}
		
		public function MSprite()
		{
			_matrix = new Matrix();
			_matrixChanged = false;
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
		
		public function changeAnimatin(na:MSAnimation, loop:Boolean):void
		{
			_animation = na;
			_loop = loop;
		}
		
		
	}
}