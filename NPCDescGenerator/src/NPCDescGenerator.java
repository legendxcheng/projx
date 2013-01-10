import java.io.*;
import java.util.ArrayList;
import java.util.LinkedList;


import org.apache.poi.ss.usermodel.*;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/*
 * Big picture generator, the output is three different qualities of the same picture.
 */
public class NPCDescGenerator {
	
	
	static int npcid;
	static int npcparty;
	static int npcanim;
	static int npcfun1;
	static int npcfun1A;
	static int npcfun2;
	static int npcfun2A;
	static int npcfun3;
	static int npcfun3A;
	static int npcicon;
	static String npcTask;
	static String npcName;
	static String npcSay;
	static String mapDescFolder;
	static int npNum;// npc with position num
	static ArrayList<Integer> npcX;
	static ArrayList<Integer> npcY;
	static ArrayList<Integer> wID;
	static ArrayList<Integer> npcP;// id list
	
	
	public static String getStr()
	{
		String ret = "";
		JSONArray task = new JSONArray();
		JSONArray func = new JSONArray();
		JSONObject ff;
		String[] ta = npcTask.split(",");
		JSONObject npc = new JSONObject();
		try {
			for (int i = 0; i < npNum; ++i)
			{
				if (npcP.get(i) == npcid)
				{
					npc.put("world", wID.get(i));
					npc.put("xind", npcX.get(i));
					npc.put("yind", npcY.get(i));
					break;
				}
				
			}
			npc.put("npcid", npcid);
			npc.put("anim", npcanim);
			npc.put("name", npcName);
			npc.put("iconid", npcicon);
			for (int i = 0; i < ta.length; ++i)
			{
				task.put(Integer.parseInt(ta[i]));
			}
			npc.put("task", task);
			if (npcfun1 != -1)
			{
				ff = new JSONObject();
				ff.put("ftype", npcfun1);
				ff.put("desc", npcfun1A);
				func.put(ff);
			}
			if (npcfun2 != -1)
			{
				ff = new JSONObject();
				ff.put("ftype", npcfun2);
				ff.put("desc", npcfun2A);
				func.put(ff);
			}
			if (npcfun3 != -1)
			{
				ff = new JSONObject();
				ff.put("ftype", npcfun3);
				ff.put("desc", npcfun3A);
				func.put(ff);
			}
			npc.put("func", func);
			
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ret = npc.toString();
		return ret;
	}
	
	public static void readPosition()
	{
		npcX = new ArrayList<Integer>();
		npcY = new ArrayList<Integer>();
		npcP = new ArrayList<Integer>();
		wID = new ArrayList<Integer>();
		npNum = 0;
    	DataInputStream cs;
		try {
			cs = new DataInputStream(new FileInputStream(new File("config.txt")));
			mapDescFolder = cs.readLine();
	        File dir = new File(mapDescFolder);
	        File file[] = dir.listFiles();
	        for (int i = 0; i < file.length; i++) {
	            if (file[i].isDirectory())
	            {
	            	
	            }
	            else
	            {
	            	String fn = file[i].getName();
	            	if (fn.startsWith("48_") && fn.endsWith(".res"))
	            	{
	            		DataInputStream cds = new DataInputStream(new FileInputStream(new File(file[i].getAbsolutePath())));
	        			JSONObject mj = new JSONObject(cds.readUTF());
	        			JSONArray npl = mj.getJSONArray("npcList");
	        			for (int j = 0; j < npl.length(); ++j)
	        			{
	        				JSONObject np = npl.getJSONObject(j);
	        				++npNum;
	        				npcX.add(np.getInt("xind"));
	        				npcY.add(np.getInt("yind"));
	        				npcP.add(np.getInt("npcid"));
	        				wID.add(mj.getInt("rid"));
	        			}
	        			cds.close();
	        			
	            	}
	                //System.out.println(file[i].getAbsolutePath());
	            }
	        }
	    	cs.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    

	}
	
    public static void main(String[] args) throws Exception 
    {
    	readPosition();

    	InputStream is = new FileInputStream(new File("resource_NPC.xls"));
        //System.out.println(is.available());
    	Workbook wb = WorkbookFactory.create(is);
        Sheet sheet = wb.getSheetAt(0);
        int i = 0;


        
        for(Row row : sheet) 
        {
        	boolean emptyRow = false;
        	i ++;
        	if (i == 1)
        		continue;
        	int k = 0;
        	DataOutputStream out = null;
        	StringBuffer outputJson = new StringBuffer();
        	
        
        	
        	
            for(Cell cell : row) 
            {
            	String str = "";
                switch(cell.getCellType()) 
                {  
                    case Cell.CELL_TYPE_NUMERIC:  
                    	str = "" + (int)(cell.getNumericCellValue());
                        break;
                    case Cell.CELL_TYPE_STRING: 
                        str = cell.getRichStringCellValue().toString();
                        break;
                }
                if (str.length() == 0) 
                {
                	if (k == 0)
                		emptyRow = true;
                	break;
                }
                
                
                switch (k) {
        		case 0:// npc id
        			npcid = Integer.parseInt(str);
        			break;
        		case 1:// remark
        			
        			break;
        		case 2:// npc name
        			npcName = str;
        			break;
        		case 3:// npc party
        			npcparty = Integer.parseInt(str);
        			break;
        		case 4:// npc task
        			npcTask = str;
        			break;
        		case 5:
        			npcicon = Integer.parseInt(str);
        			break;
        		
        		case 6:// anim
        			npcanim = Integer.parseInt(str);
        			break;
        		case 7:// defaultDialog
        			npcSay = str;
        			break;
        		case 8:// func1
        			if (str.length() > 0)
        			{
        				npcfun1 = Integer.parseInt(str);
        			}
        			else npcfun1 = -1;
        			break;
        		case 9:// func1 attr
        			if (str.length() > 0)
        			{
        				npcfun1A = Integer.parseInt(str);
        			}
        			else npcfun1A = -1;
        			
        			break;
        		case 10:// func2
        			if (str.length() > 0)
        			{
        				npcfun2 = Integer.parseInt(str);
        			}
        			else npcfun2 = -1;
        			break;
        		case 11:// func2 attr
        			if (str.length() > 0)
        			{
        				npcfun2A = Integer.parseInt(str);
        			}
        			else npcfun2A = -1;
        			break;
        		case 12:// func3 
        			if (str.length() > 0)
        			{
        				npcfun3 = Integer.parseInt(str);
        			}
        			else npcfun3 = -1;
        			break;
        		case 13:// func3 attr
        			if (str.length() > 0)
        			{
        				npcfun3A = Integer.parseInt(str);
        			}
        			else npcfun3A = -1;
        			break;
        		default:	
        			break;
        		}
                
                k ++;
            }
            
            // a line read
            // generate three sizes of pic
            DataOutputStream outs = null;

            outs = new DataOutputStream(new FileOutputStream("50_" + npcid + ".res"));
            outs.writeUTF(getStr());
            outs.close();
            
        }
        is.close();
    }  
}
