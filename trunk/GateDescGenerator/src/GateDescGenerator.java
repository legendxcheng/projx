import java.io.*;
import java.util.ArrayList;




import org.apache.poi.ss.usermodel.*;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/*
 * description of those 1 to 1 gate in the big world 
 * rid
 * name
 * animid
 * atworld
 * atx
 * aty
 * targetid
 * 
 * 
 */
public class GateDescGenerator {
	static boolean hasConfig;
	static int picid;
	static String _picPath = "";
	static String gateName = "";
	static int gateID = 0;
	static int animID;
	static int targetID;
	static ArrayList<Integer> gateX;
	static ArrayList<Integer> gateY;
	static ArrayList<Integer> wID;
	static ArrayList<Integer> gateP;// id list
	static int gNum;
	static String mapDescFolder;
	public static void readPosition()
	{
		hasConfig = false;
		gateX = new ArrayList<Integer>();
		gateY = new ArrayList<Integer>();
		wID = new ArrayList<Integer>();
		gateP = new ArrayList<Integer>();
		gNum = 0;
		File nf = new File("config.txt");
		if (!nf.exists())
			return;
		
    	DataInputStream cs;
		try {
			cs = new DataInputStream(new FileInputStream(nf));
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
	        			JSONArray npl = mj.getJSONArray("gateList");
	        			for (int j = 0; j < npl.length(); ++j)
	        			{
	        				JSONObject np = npl.getJSONObject(j);
	        				++gNum;
	        				gateX.add(np.getInt("xind"));
	        				gateY.add(np.getInt("yind"));
	        				gateP.add(np.getInt("gateid"));
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
	
	
	
	public static String getStr()
	{
		String ret = "";
		JSONArray task = new JSONArray();
		JSONArray func = new JSONArray();
		JSONObject ff;
		
		JSONObject gate = new JSONObject();
		try {
			for (int i = 0; i < gNum; ++i)
			{
				if (gateP.get(i) == gateID)
				{
					gate.put("world", wID.get(i));
					gate.put("xind", gateX.get(i));
					gate.put("yind", gateY.get(i));
					break;
				}
				
			}
			gate.put("npcid", gateID);
			gate.put("anim", animID);
			gate.put("name", gateName);
			
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ret = gate.toString();
		return ret;
	}
	
    public static void main(String[] args) throws Exception 
    {
    	
    	readPosition();
    	InputStream is = new FileInputStream(new File("resource_gate.xls"));
        //System.out.println(is.available());
    	Workbook wb = WorkbookFactory.create(is);
        Sheet sheet = wb.getSheetAt(0);
        int i = 0;

        byte[] pngBuffer = new byte[8 * 2048 * 2048];

        
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
        		case 0:// id
        			gateID = Integer.parseInt(str);
        			break;
        		case 1:// remark
        			
        			break;
        		case 2:// name
        			gateName = str;
        			break;
        		case 3:
        			animID = Integer.parseInt(str);
        			break;
        		case 4:// target gateid
        			targetID = Integer.parseInt(str);
        			break;
        		case 5:// remark2
        			break;
        		default:	
        			break;
        		}
                
                k ++;
            }
            
            // a line read
            // generate three sizes of pic
            DataOutputStream outs = null;
            int ret;
            FileInputStream tpinp;
            outs = new DataOutputStream(new FileOutputStream("51_" + gateID + ".res"));
            outs.writeUTF(getStr());
            outs.close();
            
        }
        is.close();
    }  
}
