package Logic
{

	import UI.Gate.GateListFrame;
	import UI.Gate.GateMapFrame;
	import UI.Map.MapAttrPanel;
	import UI.Map.MapFileListFrame;
	import UI.Map.MapFrame;
	import UI.Map.ToolFrame;
	import UI.NPC.NPCAttrPanel;
	import UI.NPC.NPCListFrame;
	import UI.NPC.NPCMapFrame;
	
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import flash.xml.*;
	
	import org.aswing.JOptionPane;

	public class ControlCenter
	{
		
		static private var _instance : ControlCenter;
		private var _ccState:int; // 0 for map editing, 1 for npc editing, 2 for gate editing
		private var _mapW :int;
		private var _mapH :int;
		private var _mapID:int;
		private var _mapState :int;// 0 for set passable
		//  1 for set transparent // 2 for set rebirth point // 3 for set teleport point
		private var _nxOffset:int;
		private var _nyMax : int;
		private var _nxMax : int;
		
		// teleport position
		// rebirth position
		private var _rbx:int;
		private var _rby:int;
		private var _tpx:int;
		private var _tpy:int;

		private var _mapFrame :MapFrame;
		//private var _mapFLFrame :MapFileListFrame;
		//private var _attrPanel:MapAttrPanel;
		private var _toolFrame:ToolFrame;
		
		private var _mapPicPath:String;
		
		private var _pArea : Array;
		private var _tArea : Array;
		private var _gridNum :int;
		private var _mapName : String;
		private var _mapList:Array;
		
		private var _fileR :FileReference;
		
		private var _gridSideLen : Number;
		
		// npc related
		private var _npcList:Array;
		private var _curNPCID:int;// current NPC

		private var _nMapFrame:NPCMapFrame;
		private var _npcState:int;  //1 for a new npc, 2 for editing an npc.
		private var _npcListFrame:NPCListFrame;
		//private var _nAttrPanel:NPCAttrPanel;
		private var _tmpNPC:Object;// used when add a new NPC
		private var _npcX:int;
		private var _npcY:int;
		
		//gate related
		private var _gMapFrame:GateMapFrame;
		private var _gateListFrame:GateListFrame;
		private var _gateState:int;  //1 for a new gate, 2 for editing a gate.
		private var _tmpGate:Object;// used when add a new NPC
		private var _gateX:int;
		private var _gateY:int;
		private var _gateList:Array;
		private var _curGateID:int;// current NPC

		public function get gateY():int
		{
			return _gateY;
		}

		public function set gateY(value:int):void
		{
			_gateY = value;
		}

		public function get gateX():int
		{
			return _gateX;
		}

		public function set gateX(value:int):void
		{
			_gateX = value;
		}

		public function get gateState():int
		{
			return _gateState;
		}

		public function set gateState(value:int):void
		{
			_gateState = value;
		}

		public function get tmpGate():Object
		{
			return _tmpGate;
		}

		public function set tmpGate(value:Object):void
		{
			_tmpGate = value;
		}

		public function get gateListFrame():GateListFrame
		{
			return _gateListFrame;
		}

		public function set gateListFrame(value:GateListFrame):void
		{
			_gateListFrame = value;
		}

		public function get gMapFrame():GateMapFrame
		{
			return _gMapFrame;
		}

		public function set gMapFrame(value:GateMapFrame):void
		{
			_gMapFrame = value;
		}

		public function get toolFrame():ToolFrame
		{
			return _toolFrame;
		}

		public function set toolFrame(value:ToolFrame):void
		{
			_toolFrame = value;
		}

		public function saveTmpNPC():void
		{
		 	this._npcList[this._curNPCID] = this.tmpNPC;
			this.npcListFrame.resetNPCList(this._npcList);
		}
		
		public function saveTmpGate():void
		{
			this._gateList[this._curGateID] = this._tmpGate;
			this.gateListFrame.resetGateList(this._gateList);
		}
		
		// after saving a new NPC
		public function insertTmpNPC():void
		{
			this._npcList.push(_tmpNPC);
			this.npcListFrame.resetNPCList(this._npcList);
			
		}
		
		public function insertTmpGate():void
		{
			this._gateList.push(_tmpGate);
			this.gateListFrame.resetGateList(this._gateList);
			
		}
		
		public function delNPC():void
		{
			this._npcList.splice(_curNPCID, 1);
			_curNPCID = 0;
			this.npcListFrame.resetNPCList(this._npcList);
		}
		
		public function delGate():void
		{
			this._gateList.splice(_curGateID, 1);
			_curGateID = 0;
			this.gateListFrame.resetGateList(this._gateList);
		}
		
		public function get npcY():int
		{
			return _npcY;
		}
		
		public function selectNPC(nid:int):void
		{
			_curNPCID = nid;
			this.npcListFrame.fillNPCContent(this._npcList[_curNPCID]);
			this.nMapFrame.putNPC(this._npcList[_curNPCID]);
			
		}
		
		public function selectGate(nid:int):void
		{
			_curGateID = nid;
			this.gateListFrame.fillGateContent(this._gateList[_curGateID]);
			this.gMapFrame.putGate(this._gateList[_curGateID]);
			
		}

		public function set npcY(value:int):void
		{
			_npcY = value;
		}

		public function get npcX():int
		{
			return _npcX;
		}

		public function set npcX(value:int):void
		{
			_npcX = value;
		}

		public function get tmpNPC():Object
		{
			return _tmpNPC;
		}

		public function set tmpNPC(value:Object):void
		{
			_tmpNPC = value;
		}

		public function get npcState():int
		{
			return _npcState;
		}

		public function set npcState(value:int):void
		{
			_npcState = value;
		}

		public function get npcListFrame():NPCListFrame
		{
			return _npcListFrame;
		}

		public function set npcListFrame(value:NPCListFrame):void
		{
			_npcListFrame = value;
		}

	

		public function get nMapFrame():NPCMapFrame
		{
			return _nMapFrame;
		}

		public function set nMapFrame(value:NPCMapFrame):void
		{
			_nMapFrame = value;
		}

		public function setNPCPos(xi:int, yi:int):void
		{
			_npcX = xi;
			_npcY = yi;
			this.npcListFrame.setNPCPosDisplayed(xi, yi);
		}
		
		public function setGatePos(xi:int, yi:int):void
		{
			_gateX = xi;
			_gateY = yi;
			this.gateListFrame.setGatePosDisplayed(xi, yi);
		}
		
		public function get mapPicPath():String
		{
			return _mapPicPath;
		}

		public function set mapPicPath(value:String):void
		{
			_mapPicPath = value;
		}


		
		public function getMapID():int
		{
			return _toolFrame.getMapID();
		}
		
		public function setShowMapID(mid:int):void
		{
			_toolFrame.setMapID(mid);
		}
		
		public function get nyMax():int
		{
			return _nyMax;
		}

		public function get nxOffset():int
		{
			return _nxOffset;
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
			_mapFrame.setRbFlags(_rbx, _rby);
			_mapFrame.setTpFlags(_tpx, _tpy);
			
			// map file list
			_toolFrame.setMapFileList(_mapList);
			
			
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
		
		public function updateNPCListFrame():void
		{
			this.npcListFrame.resetNPCList(_npcList);
		}
		
		public function updateGateListFrame():void
		{
			this.gateListFrame.resetGateList(_gateList);
		}
		
		// desc res loaded
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
			_mapID = json.rid;
			_rbx = json.rbx;
			_rby = json.rby;
			_tpx = json.tpx;
			_tpy = json.tpy;
			this.setShowMapID(_mapID);
			_mapList = new Array();	
			_npcList = json.npcList;
			if (_npcList == null)
				_npcList = new Array();
			_gateList = json.gateList;
			if (_gateList == null)
				_gateList = new Array();
			// to fill npc list frame
			updateNPCListFrame();
			updateGateListFrame();
			
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
			_mapID = this.getMapID();
			if (_mapID < 0)
			{
				var jop:JOptionPane = JOptionPane.showMessageDialog("请设置大世界的ID",
					"还未设置大世界ID");
				return;
			}
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
			file.save(ba, "48_" + _mapID + ".res");
			
		}


		
		private function generateJson():String
		{
			var ret:Object = new Object();;
			ret.nxMax = _nxMax;
			ret.nyMax = _nyMax;
			ret.nxOffset = _nxOffset;
			ret.gridNum = _gridNum;
			ret.mapList = _toolFrame.generateFLJson();
			ret.width = _mapW;
			ret.height = _mapH;
			ret.rid = _mapID;
			ret.npcList = _npcList;
			ret.gateList = _gateList;
			ret.rbx = _rbx;
			ret.rby = _rby;
			ret.tpx = _tpx;
			ret.tpy = _tpy;
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

		public function get mapState():int
		{
			return _mapState;
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
		
		public function setMapState(s:int):void
		{
			_mapState = s;
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
			_npcList = new Array();
			_gateList = new Array();
		}
		
		public function clickRebirth(cx:int, cy:int):Boolean
		{
			this._rbx = cx;
			this._rby = cy;
			return true;
		}
		
		public function clickTeleport(cx:int, cy:int):Boolean
		{
			this._tpx = cx;
			this._tpy = cy;
			return true;
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
			this._toolFrame.showMapSize(w, h);
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