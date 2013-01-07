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
	
	
	public class NPCMapFrame extends JFrame
	{
		
		private var _scrollPane : JScrollPane;
		private var _panel : JPanel;	
		private var _loadPane :JLoadPane;
		private var cc :ControlCenter;
		private var _grids :Sprite;
		private var _nFlags:Sprite;

		
		
		public function NPCMapFrame(owner:*=null, title:String="", modal:Boolean=false)
		{
			super(owner, "Map", modal);
			cc = ControlCenter.getInstance();
			
			_loadPane  = new JLoadPane();
			_panel = new JPanel(new FlowLayout(FlowLayout.LEFT, 0, 0, false));
			_panel.append(_loadPane);
			/*_loadPane.setSizeWH(800, 600);
			_loadPane.x = 0;
			_loadPane.y = 0;*/
			
			_nFlags = new Sprite();
			
			
			
			
			_scrollPane = new JScrollPane(_panel);
			_scrollPane.setSizeWH(760, 600);
			
			
			
			
			this.getContentPane().append(_scrollPane);
			_loadPane.addEventListener(Event.COMPLETE, _onLoadComplete);
			
			
			_loadPane.addEventListener(MouseEvent.CLICK, onClickMap);
			cc.nMapFrame = this;
			
			this.setResizable(false);
			this.setClosable(false);
			this.setDragable(false);
			this.x = 400;
			this.y = 0;
			this.width = 800;
			this.height = 620;
			
		}
		
		
		
		public function loadMapFrame():void
		{
			_loadPane.load(new URLRequest(cc.mapPicPath));
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
			cc.setNPCPos(xind, yind);
			
			var g:Graphics;
			var tmp2:Boolean;
			g = _nFlags.graphics;
			g.clear();
			g.lineStyle(3, 0xFFFFFF);
			g.drawCircle(cx, cy, 10);	
		}
		
		public function changeState():void
		{
			
			
		}
		
		public function showGrid():void
		{
			
			
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
			
			_grids = new Sprite();
			initGrids(_grids, 0xFF007F);
			_panel.addChild(_grids);
			_panel.addChild(_nFlags);
			_grids.x = 0;
			_grids.y = 0;
			
		}	
		
		public function loadMapFile(fileName :String):void
		{
			
			_loadPane.load(new URLRequest(fileName));
		}
	}
}