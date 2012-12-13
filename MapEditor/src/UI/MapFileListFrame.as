package UI{
	
	import Logic.ControlCenter;
	
	import org.aswing.*;
	import org.aswing.border.*;
	import org.aswing.colorchooser.*;
	import org.aswing.ext.*;
	import org.aswing.geom.*;
	
	/**
	 * FileListPanel
	 */
	public class MapFileListFrame extends JFrame{
		
		//members define
		private var fileList : Array;
		private var cc:ControlCenter;
		
		/**
		 * FileListPanel Constructor
		 */
		public function MapFileListFrame(owner:*=null, title:String="", modal:Boolean=false)
		{
			super(owner, title, modal);
			getContentPane().setLayout(new EmptyLayout());
			//component creation
			
			setSize(new IntDimension(200, 400));
			/*var layout0:EmptyLayout = new EmptyLayout();
			setLayout(layout0);
			*/
			fileList = new Array();
			var tmptf :JTextField;
			
			for (var i:int = 0; i < 16; ++i)
			{
				tmptf = new JTextField();
				tmptf.setLocation(new IntPoint(40, 5 + 22 * i));
				tmptf.setSize(new IntDimension(150, 20));
				fileList.push(tmptf);
				this.getContentPane().append(tmptf);
			}
			cc = ControlCenter.getInstance();
			cc.mapFLFrame = this;
		}
		
		public function setMapFileList( a:Array):void
		{
			for (var i: int = 0; i < a.length; ++i)
			{
				
				fileList[i].setText(a[i]);
			}
			for (i = a.length; i < 16; ++i)
			{
				fileList[i].setText("");
			}
		}
		
		public function generateXML():String
		{
			var ret:String;
			ret = "<mapList>";
		
			for (var i:int = 0; i<16; ++i)
			{
				var kk:String = fileList[i].getText();
				if (kk.length > 0)
				{
					ret += "<pic>" + kk + "</pic>";
				}	
				else break;
			}
			ret += "</mapList>";
			return ret;
		}
		public function generateJson():Object
		{
			var ret:Object = new Object();
			ret.pic = new Array();
			for (var i:int = 0; i<16; ++i)
			{
				var kk:String = fileList[i].getText();
				if (kk.length > 0)
				{
					ret.pic.push(kk);
					
				}	
				else break;
			}
			
			return ret;
		}	
	}
}
