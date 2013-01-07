package MCW.UI
{
	/*
		class for translate text into
			htmlcode
	*/
	public class HtmlCodeTranslator
	{
		static public const red:String = "#FF0000";
		static public const blue:String = "#0000FF";
		static public const green:String = "#00FF00";
		static public const yellow:String = "#FFFF00";
		static public const pink:String = "#DE3F59";
		static public const colorNPC:String = "#FF00FF";
		static public const colorGate:String = "#FF3355";
		
		public function HtmlCodeTranslator()
		{
		}
		
		static public function translate(ss:String):String
		{
			/* 	first step
				replace color
				<red><blue><green><yellow><pink>
			*/ 
			ss = ss.replace(/<red>/g, "<font color=\"" + red + "\">");
			ss = ss.replace(/<blue>/g, "<font color=\"" + blue + "\">");
			ss = ss.replace(/<green>/g, "<font color=\"" + green + "\">");
			ss = ss.replace(/<yellow>/g, "<font color=\"" + yellow + "\">");
			ss = ss.replace(/<pink>/g, "<font color=\"" + pink + "\">");
			ss = ss.replace(/<\/red>/g, "</font>");
			ss = ss.replace(/<\/blue>/g, "</font>");
			ss = ss.replace(/<\/green>/g, "</font>");
			ss = ss.replace(/<\/yellow>/g, "</font>");
			ss = ss.replace(/<\/pink>/g, "</font>");
			
			/*
				second step
				replace <target npc=3333> or so on to textevent
			*/
			var ret:Array = ss.match(/<target (\w|=)*>/g);
			var spos:int;
			var ls:String;
			var rs:String;
			var us:String;
			for (var i:int = 0; i < ret.length; ++i)
			{	
				var ts:String = ret[i].substring(8);
				ts = ts.substring(0, ts.length -1);
				spos = ss.indexOf(ret[i]);
				ls = ss.substring(0, spos);
				rs = ss.substr(spos + ret[i].length);
				us = "<a href=\'event:" + ts + "\'>";
				if (ts.charAt(0) == 'n')
				{
					us = "<font color=\"" + colorNPC + "\">" + us;
					
				}
				else if (ts.charAt(0) == 'g')
				{
					us = "<font color=\"" + colorGate + "\">" + us;
				}
				ss = ls + us + rs;
			}
			ss = ss.replace(/<\/target>/g, "</a></font>");
			return ss;
		}
	}
}