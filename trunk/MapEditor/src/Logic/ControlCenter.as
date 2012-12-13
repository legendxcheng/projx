package Logic
{

	import UI.MapFileListFrame;
	import UI.MapFrame;
	
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import flash.xml.*;

	public class ControlCenter
	{
		
		static private var _instance : ControlCenter;
		private var _mapW :int;
		private var _mapH :int;
		private var _state :int;// 0 for set passable
		//  1 for set transparent
		private var _nxOffset:int;
		private var _nyMax : int;
		private var _nxMax : int;
		
		private var _mapFrame :MapFrame;
		private var _mapFLFrame :MapFileListFrame;
		
		private var _pArea : Array;
		private var _tArea : Array;
		private var _gridNum :int;
		private var _mapName : String;
		private var _mapList:Array;
		
		private var _fileR :FileReference;
		
		private var _gridSideLen : Number;

		public function get nyMax():int
		{
			return _nyMax;
		}

		public function get nxOffset():int
		{
			return _nxOffset;
		}

		public function set mapFLFrame(value:MapFileListFrame):void
		{
			_mapFLFrame = value;
		}
		
		/*
			reset all UI elements with internal values in ControlCenter
		*/
		public function reset():void
		{
			// map reset
			// parea and tarea
			_mapFrame.setPFlags(_pArea);
			_mapFrame.setTFlags(_tArea);
			
			// map file list
			_mapFLFrame.setMapFileList(_mapList);
			
			
		}
		public function importFile():void
		{
			_fileR = new FileReference();
			_fileR.browse();
			
			_fileR.addEventListener(Event.SELECT, onFileSelected);
		}
		
		public function onFileSelected(e:Event):void
		{
			
			_fileR.load();
			_fileR.addEventListener(Event.COMPLETE, onFileLoadCompleted);
		}
		
		public function onFileLoadCompleted(e:Event):void
		{
			var ba:ByteArray = e.target.data as ByteArray;
			/*
			var xmlL:int = ba.readInt();
			var xmlStr:String = ba.readUTF();
			var xml:XML = XML(xmlStr);
			// update all logic variables
			_nyMax = xml.nyMax;
			_nxMax = xml.nxMax;
			_nxOffset = xml.nxOffset;
			_gridNum = xml.gridNum;
			_mapList = new Array();
			for each(var item:XML in xml.mapList.pic)
			{
				_mapList.push(item.toString());
			}
			*/
			var jsonStr:String = ba.readUTF();
			var json:Object = JSON.parse(jsonStr);
			_nyMax = json.nyMax;
			_nxMax = json.nxMax;
			_nxOffset = json.nxOffset;
			_gridNum = json.gridNum;
			_mapList = new Array();
			for each(var item:String in json.mapList.pic)
			{
				_mapList.push(item.toString());
			}
			
			var i: int;
			var tmp:int;
			var tmp2:int;
			for (i = 0; i < _gridNum; ++i)
			{
				if (i % 8 == 0)
				{
					tmp = ba.readByte();
				}
				tmp2 = (1 << (7- i % 8));
				if ((tmp & tmp2) > 0)
				{
					_pArea[i] = true;	
				}
				else _pArea[i] = false;
				
			}
			for (i = 0; i < _gridNum; ++i)
			{
				if (i % 8 == 0)
				{
					tmp = ba.readByte();
				}
				tmp2 = (1 << (7- i % 8));
				if ((tmp & tmp2) > 0)
				{
					_tArea[i] = true;	
				}
				else _tArea[i] = false;
			
			}
			this.reset();
		}
		
		public function exportFile():void
		{
			var json:String = this.generateJson();
			var ba:ByteArray = new ByteArray();
			ba.writeUTF(json);
			var i :int;
			var tmp :int = 0;
			var nNum:int = Math.ceil(_gridNum / 8) * 8;
			for (i = 0; i < nNum; ++i)
			{
				
				tmp = tmp << 1;
				if (i < _gridNum)
				{
					if (_pArea[i])
						tmp += 1;
				}
				
				if (i % 8 == 7)
				{
					ba.writeByte(tmp);	
					tmp = 0;
				}
				
			}
			tmp = 0;
			for (i = 0; i < nNum; ++i)
			{
				tmp = tmp << 1;
				if (i < _gridNum)
					if (_tArea[i])
						tmp += 1;
				
				if (i % 8 == 7)
				{
					ba.writeByte(tmp);	
					tmp = 0;
				}
			}
			
			var file:FileReference = new FileReference();
			file.save(ba, "mapDesc.res");
			
		}

		private function generateXML():String
		{
			var ret:String;
			ret = "<map>";
			var tmps:String;
			tmps = "<nxMax>" + _nxMax + "</nxMax>";
			ret += tmps;
			tmps = "<nyMax>" + _nyMax + "</nyMax>";
			ret += tmps;
			tmps = "<nxOffset>" + _nxOffset + "</nxOffset>";
			ret += tmps;
			tmps = "<gridNum>" + _gridNum + "</gridNum>";
			ret += tmps;
			ret += _mapFLFrame.generateXML();
			ret += "</map>";
			return ret;
		}
		
		private function generateJson():String
		{
			var ret:Object = new Object();;
			ret.nxMax = _nxMax;
			ret.nyMax = _nyMax;
			ret.nxOffset = _nxOffset;
			ret.gridNum = _gridNum;
			ret.mapList = _mapFLFrame.generateJson();
			/*
			ret = "<map>";
			var tmps:String;
			tmps = "<nxMax>" + _nxMax + "</nxMax>";
			ret += tmps;
			tmps = "<nyMax>" + _nyMax + "</nyMax>";
			ret += tmps;
			tmps = "<nxOffset>" + _nxOffset + "</nxOffset>";
			ret += tmps;
			tmps = "<gridNum>" + _gridNum + "</gridNum>";
			ret += tmps;
			ret += _mapFLFrame.generateXML();
			ret += "</map>";
			*/
			
			return JSON.stringify(ret);
		}
		
		public function get mapName():String
		{
			return _mapName;
		}

		public function set mapName(value:String):void
		{
			_mapName = value;
		}

		public function get state():int
		{
			return _state;
		}
		
		

		public function showGrid():void
		{
			_mapFrame.showGrid();
		}
		
		public function get gridSideLen():Number
		{
			return _gridSideLen;
		}

		public function get mapW():int
		{
			return _mapW;
		}

		public function get mapH():int
		{
			return _mapH;
		}
		
		public function setState(s:int):void
		{
			_state = s;
			_mapFrame.changeState();
			
		}

		static public function getInstance() : ControlCenter
		{
			if (_instance == null)
			{
				_instance = new ControlCenter();
				
			}
			return _instance;
		}
		
		public function setMapFrame(mf :MapFrame):void
		{
			_mapFrame = mf;
		}
		
		public function loadMap(fn:String):void
		{
			_mapFrame.loadMapFile(fn);
			
		}
		
		public function ControlCenter()
		{
			_gridSideLen = 50;
			_mapList = new Array();
		}
		
		public function clickPassable(cx:int, cy:int):Boolean
		{
			var tind : int = (cx + _nxOffset) * _nyMax + cy;
			if (_pArea[tind] == null)
			{
				_pArea[tind] = true;
			}
			else
			{
				_pArea[tind] = !_pArea[tind];
			}
			return _pArea[tind];
		}
		
		public function clickTransparent(cx:int, cy:int):Boolean
		{
			var tind : int = (cx + _nxOffset) * _nyMax + cy;
			
			if (_tArea[tind] == null)
			{
				_tArea[tind] = true;
			}
			else
			{
				_tArea[tind] = !_tArea[tind];
			}
			return _tArea[tind];
		}
		
		public function setMapSize(w:int, h:int):void
		{
			_mapW = w;
			_mapH = h;
			var a:Number = Math.cos(72.5/180 *Math.PI);
			var b:Number = Math.sin(72.5/180 * Math.PI);
			_nxOffset = Math.floor((_mapH / a) / 2 / _gridSideLen);
			_nyMax = Math.floor((_mapW / b + _mapH / a) / 2 / gridSideLen);
			_nxMax = Math.floor(_mapW / b / 2 / gridSideLen);
			// init parea and tarea
			_gridNum = (_nxMax + _nxOffset + 1) * (_nyMax + 1);
			_pArea = new Array(_gridNum);
			_tArea = new Array(_gridNum);
		}
	}
}