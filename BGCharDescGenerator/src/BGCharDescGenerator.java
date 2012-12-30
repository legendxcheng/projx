import java.io.*;

import org.apache.poi.ss.usermodel.*;

public class BGCharDescGenerator {
	
	static int rid, stopid;
	static int dir[];
	static int speed;
	
	public static String getStr()
	{
		String ret = "";
		ret += "{\"rid\":" + rid + ",\"moveAnim\":[";
		for (int i = 0; i < 8; ++i)
		{
			if (i != 0)
				ret += ",";
			ret += dir[i];
			
		}
		ret += "],\"stopAnim\":" + stopid + ",\"speed\":" + speed + "}";
		
		return ret;
	}
	
    public static void main(String[] args) throws Exception 
    {
    	dir = new int[8];
    	InputStream is = new FileInputStream(new File("resource_BGChar.xls"));
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
        		case 0:// rid
        			rid = Integer.parseInt(str);
        			break;
        		case 1:// remarks
        			
        			break;
        		case 2:// 2id
        			
        			dir[0] = Integer.parseInt(str);
        			break;
        		case 3:// 1id
        			
        			dir[1] = Integer.parseInt(str);
        			break;
        		case 4:// 4id
        			
        			dir[2] = Integer.parseInt(str);
        			break;
        		case 5:// 7id
        			
        			dir[3] = Integer.parseInt(str);
        			break;
        		case 6: // 8id
        			dir[4] = Integer.parseInt(str);
        			break;
        		case 7: // 9id
        			dir[5] = Integer.parseInt(str);
        			break;
        		case 8: // 6id
        			dir[6] = Integer.parseInt(str);
        			break;
        		case 9: // 3id
        			dir[7] = Integer.parseInt(str);
        			break;
        		case 10: // stopid
        			stopid = Integer.parseInt(str);
        			break;
        		case 11: // speed
        			speed = Integer.parseInt(str);
        		default:
        			
        			break;
        		}
                
                k ++;
            }
            
           
            // generate three .res file
            DataOutputStream outs = null;
            outs = new DataOutputStream(new FileOutputStream("49_" + rid + ".res"));
            outs.writeUTF(getStr());
            outs.close();
            
            
        }
        is.close();
    }  
}
