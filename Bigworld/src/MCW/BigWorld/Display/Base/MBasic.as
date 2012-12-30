package MCW.BigWorld.Display.Base
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/*
		basic display class
	*/
	public class MBasic implements IDisplay
	{
		// matrix related properties
		protected var _scaleX:Number;
		protected var _scaleY:Number;
		protected var _x:int;
		protected var _y:int;
		
		protected var _rotation:Number;// in 0~2PI
		
		protected var _visible:Boolean;
		protected var _alpha:Boolean;

		protected var _aBuf:BitmapData;// buffer for advant draw
		protected var _acBuf:BitmapData;
		
		protected var _matrix:Matrix;
		
		protected var _matrixChanged:Boolean;
		
		protected var _debug:Boolean;
		
		protected var _needAdvDraw:Boolean;// scale rotation and color transform
		
		protected var _colorMatrix:Array;// 4 * 5 matrix
		protected var _needColorMatrix:Boolean;
		
		
				
		public function set needColorMatrix(value:Boolean):void
		{
			_colorMatrix = null;
			_needColorMatrix = value;
		}
		
		protected function getColorTransform():BitmapData
		{
			
			if (_needColorMatrix)
			{
				if (_acBuf != null)
				{
					_acBuf.dispose();
				}	
				_acBuf = new BitmapData(_aBuf.width, _aBuf.height);
				_acBuf.applyFilter(_aBuf, _aBuf.rect, new Point(0, 0), new ColorMatrixFilter(_colorMatrix));
				return _acBuf;
			}
			return _aBuf;
		}

		public function setColorOffset(rOff:int, gOff:int, bOff:int):void
		{
			if (_colorMatrix == null)
			{
				_colorMatrix = new Array(1,0,0,0,rOff,
											0,1,0,0, gOff,
											0,0,1,0, bOff,
											0,0,0,1,0);
				
				_needAdvDraw = true;
				
			}
			else
			{
				_colorMatrix[4] = rOff;
				_colorMatrix[9] = gOff;
				_colorMatrix[14] = bOff;
			}
			
			_needColorMatrix = true;
		}
		
		public function MBasic()
		{
			_visible = true;
			_matrix = new Matrix();
			_matrixChanged = false;
			_scaleX = _scaleY = 1.0;
			_rotation = 0;
			_debug = false;
			_needAdvDraw = false;
			_needColorMatrix = false;

		}
		
		
		
		public function get colorMatrix():Array
		{
			return _colorMatrix;
		}

		public function set colorMatrix(value:Array):void
		{
			_colorMatrix = value;
		}

		public function set debug(value:Boolean):void
		{
			_debug = value;
		}

		public function canDisplay():Boolean
		{
			return true;
		}

		public function onResLoaded(rtype:int, rid:int):void
		{
			
		}
		
		public function requestResource():void
		{
			
		}
		
		public function draw(buffer:BitmapData, camX:int, camY:int):void
		{
			
		}
		
		
		public function get rotation():Number
		{
			return _rotation;
		}
		
		public function set rotation(value:Number):void
		{
			_needAdvDraw = true;
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
			_needAdvDraw = true;
			_scaleY = value;
			_matrixChanged = true;
		}
		
		public function get scaleX():Number
		{
			return _scaleX;
			
		}
		
		public function set scaleX(value:Number):void
		{
			_needAdvDraw = true;
			_scaleX = value;
			_matrixChanged = true;
		}
		
		/*
			draw anchor point for debug
		*/
		public function drawAnchor(buffer:BitmapData):void
		{
			for (var i:int =  - 50; i <=   50; ++i)
			{
				buffer.setPixel(i + _x, _y, 0xFF0000);
				buffer.setPixel(_x, _y + i, 0xFF0000);
			}
		}
		
		public function getMatrix():Matrix
		{
			if (_matrixChanged)
			{	
				
				_matrix = new Matrix();
				
				// may be _x, _y
				_matrix.translate(-_x, -_y);
				_matrix.rotate(_rotation);
				_matrix.scale(_scaleX, _scaleY);	
				_matrixChanged = false;	
				
			}
			
			return _matrix;
		}
	
	}
}