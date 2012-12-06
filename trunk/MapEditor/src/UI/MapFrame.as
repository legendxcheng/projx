package UI
{
	import Logic.ControlCenter;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	import org.aswing.EmptyLayout;
	import org.aswing.FlowLayout;
	import org.aswing.JFrame;
	import org.aswing.JLoadPane;
	import org.aswing.JPanel;
	import org.aswing.JScrollPane;
	
	
	public class MapFrame extends JFrame
	{
		
		private var _scrollPane : JScrollPane;
		private var _panel : JPanel;	
		private var _loadPane :JLoadPane;
		private var cc :ControlCenter;
		private var _pgrids :Sprite;
		private var _tgrids:Sprite;
		private var _pflags : Sprite;
		private var _tflags : Sprite;
		
		
		public function MapFrame(owner:*=null, title:String="", modal:Boolean=false)
		{
			super(owner, title, modal);
			cc = ControlCenter.getInstance();
			cc.setMapFrame(this);
			
			_loadPane  = new JLoadPane();
			_panel = new JPanel(new FlowLayout(FlowLayout.LEFT, 0, 0, false));
			_panel.append(_loadPane);
			/*_loadPane.setSizeWH(760, 600);
			_loadPane.x = 0;
			_loadPane.y = 0;*/
			
			
			
			
			_scrollPane = new JScrollPane(_panel);
			_scrollPane.setSizeWH(760, 600);
			
			
			
			this.getContentPane().append(_scrollPane);
			_loadPane.addEventListener(Event.COMPLETE, _onLoadComplete);
			_loadPane.load(new URLRequest("http://i.imgur.com/fVPyH.png"));
			
			_loadPane.addEventListener(MouseEvent.CLICK, onClickMap);
			
		}
		
		
		
		public function setPFlags(aa:Array):void
		{
			var tmp:Number = Math.sin(35/180 * Math.PI);
			var a:Number = tmp/Math.sqrt(1+tmp*tmp);
			var b:Number = 1/Math.sqrt(1+tmp*tmp);
			_panel.removeChild(_pflags);
			_pflags = new Sprite();
			var g:Graphics = _pflags.graphics;
			g.lineStyle(3,  0xFF007F);
			var xind:int;
			var yind:int;
			var cy : Number;
			var cx : Number;
			for (var i:int = 0; i < aa.length; ++i)
			{
				if (aa[i])
				{
					xind = Math.floor(i / cc.nyMax) - cc.nxOffset;
					yind = Math.floor(i % cc.nyMax);
					cy = yind * cc.gridSideLen * a - xind * cc.gridSideLen * a; // circle center x
					cx = xind * cc.gridSideLen * b + yind * cc.gridSideLen * b + cc.gridSideLen * b; // circle center y
					g.drawCircle(cx, cy, 10);
				}
			}
			_panel.addChild(_pflags);
			if (cc.state == 1)
				_pflags.visible  =false;
		}
		
		public function setTFlags(aa:Array):void
		{
			var tmp:Number = Math.sin(35/180 * Math.PI);
			var a:Number = tmp/Math.sqrt(1+tmp*tmp);
			var b:Number = 1/Math.sqrt(1+tmp*tmp);
			_panel.removeChild(_tflags);
			_tflags = new Sprite();
			var g:Graphics = _tflags.graphics;
			g.lineStyle(3,  0xFF007F);
			var xind:int;
			var yind:int;
			var cy : Number;
			var cx : Number;
			for (var i:int = 0; i < aa.length; ++i)
			{
				if (aa[i])
				{
					xind = Math.floor(i / cc.nyMax) - cc.nxOffset;
					yind = Math.floor(i % cc.nyMax);
					cy = yind * cc.gridSideLen * a - xind * cc.gridSideLen * a; // circle center x
					cx = xind * cc.gridSideLen * b + yind * cc.gridSideLen * b + cc.gridSideLen * b; // circle center y
					g.drawCircle(cx, cy, 10);
				}
			}
			_panel.addChild(_tflags);
			if (cc.state == 0)
				_tflags.visible = false;
		}
		
		public function onClickMap(e:MouseEvent):void
		{
			// get the clicked box's index
			
			var tmp:Number = Math.sin(35/180 * Math.PI);
			var a:Number = tmp/Math.sqrt(1+tmp*tmp);
			var b:Number = 1/Math.sqrt(1+tmp*tmp);
			var nx:Number = (-e.localY / a + e.localX / b) / 2;
			var ny:Number = (e.localX / b + e.localY / a) / 2;
			var xind :int = Math.floor(nx / cc.gridSideLen);
			var yind :int = Math.floor(ny / cc.gridSideLen);
			trace(xind + "," + yind);
			var cy : Number = yind * cc.gridSideLen * a - xind * cc.gridSideLen * a; // circle center x
			var cx : Number = xind * cc.gridSideLen * b + yind * cc.gridSideLen * b + cc.gridSideLen * b; // circle center y
			
			
			var g:Graphics;
			var tmp2:Boolean;
			if (cc.state == 0)//passable
			{
				tmp2 = cc.clickPassable(xind, yind);
				g = _pflags.graphics;
				if (tmp2)
					g.lineStyle(3,  0xFF007F);
				else
					g.lineStyle(3, 0xFFFFFF);
				g.drawCircle(cx, cy, 10);
				
			}
			else if (cc.state == 1) // transparent
			{
				tmp2 = cc.clickTransparent(xind, yind);
				g = _tflags.graphics;
				if (tmp2)
					g.lineStyle(3,  0xFF007F);
				else
					g.lineStyle(3, 0xFFFFFF);
				g.drawCircle(cx, cy, 10);
			}
			
			
		}
		
		public function changeState():void
		{
			if (cc.state == 0) //passable
			{
				_tgrids.visible = false;
				_pgrids.visible = true;
				_tflags.visible = false;
				_pflags.visible = true;
			}
			else if (cc.state ==1) // transparent
			{
				_pflags.visible = false;
				_pgrids.visible = false;
				_tgrids.visible = true;	
				_tflags.visible = true;
			}
			
		}
		
		public function showGrid():void
		{
			if (cc.state == 0) //passable
			{
				_tgrids.visible = false;
				_pgrids.visible = !_pgrids.visible;
				_pflags.visible = _pgrids.visible;
			}
			else if (cc.state ==1) // transparent
			{
				_pgrids.visible = false;
				_tgrids.visible = !_tgrids.visible;
				_tflags.visible = _tgrids.visible;
			}
			
		}
		
		private function initGrids(grids:Sprite, color:Number):void
		{
			
			
			var g:Graphics =  grids.graphics;
			var pw : int = cc.mapW;
			var ph : int = cc.mapH;
			var gsl :Number = cc.gridSideLen;
			var tmp:Number = Math.sin(35/180 * Math.PI);
			var a:Number = tmp/Math.sqrt(1+tmp*tmp);
			var b:Number = 1/Math.sqrt(1+tmp*tmp);
			var gw :Number = b * 2;
			var gh :Number = a * 2;
			g.lineStyle(2, color);
			grids.alpha = 0.5;
			
			
			var sx : Number;
			var sy : Number;
			var i:int;
			var wn:int;
			var hn:int;
			var nn:int;
			
			sy = 0;
			sx = 0;
			for (i = 0; i < pw / gsl / gw; ++i)
			{
				sx = i * gsl * gw;
				wn = Math.ceil((pw - sx) / gw / gsl);
				hn = Math.ceil(ph / gh / gsl);
				nn = Math.min(wn, hn);
				g.moveTo(sx, sy);
				g.lineTo(sx + nn * gsl * gw, sy + nn * gsl* gh);
			}
			
			/*
				7 -> 3
			*/
			sx = 0;
			sy = 0;
			for (i = 0; i < ph / gsl / gh; ++i)
			{
				sy = i * gsl * gh;
				wn = Math.ceil(pw / gw / gsl);
				hn = Math.ceil((ph - sy) / gh / gsl);
				nn = Math.min(wn, hn);
				g.moveTo(sx, sy);
				g.lineTo(sx + nn * gsl * gw, sy + nn * gsl* gh);
			}
			
			/*
			1 -> 9
			*/
			
			sy = 0;
			sx = 0;
			for (i = 0; i < pw / gsl / gw; ++i)
			{
				sx = i * gsl * gw;
				wn = Math.ceil(sx / gw / gsl);
				hn = Math.ceil(ph / gh / gsl);
				nn = Math.min(wn, hn);
				g.moveTo(sx, sy);
				g.lineTo(sx - nn * gsl * gw, sy + nn * gsl* gh);
			}
			
			
			sx = Math.ceil(pw / gsl / gw) * gsl * gw;
			sy = 0;
			for (i = 0; i < ph / gsl / gh; ++i)
			{
				sy = i * gsl * gh;
				wn = Math.ceil(pw / gw / gsl);
				hn = Math.ceil((ph - sy) / gh / gsl);
				nn = Math.min(wn, hn);
				g.moveTo(sx, sy);
				g.lineTo(sx - nn * gsl * gw, sy + nn * gsl* gh);
			}
			
			
		}
		
		public function _onLoadComplete(e:Event):void
		{
			
			cc.setMapSize(_loadPane.getLoader().width, _loadPane.getLoader().height);
			if (_pflags != null)
			{
				_panel.removeChild(_pflags);	
			}
			
			if (_tflags != null)
			{
				_panel.removeChild(_tflags);
			}
			_pgrids = new Sprite();
			_tgrids = new Sprite();
			initGrids(_pgrids, 0xFF007F);
			initGrids(_tgrids, 0x1979CA); 
			_panel.addChild(_tgrids);
			_tgrids.x = 0;
			_tgrids.y = 0;
			_panel.addChild(_pgrids);
			_pgrids.x = 0;
			_pgrids.y = 0;
			
			_pflags = new Sprite();	
			_tflags = new Sprite();
			_panel.addChild(_pflags);
			_panel.addChild(_tflags);
		}	
		
		public function loadMapFile(fileName :String):void
		{
			
			_loadPane.load(new URLRequest(fileName));
		}
	}
}