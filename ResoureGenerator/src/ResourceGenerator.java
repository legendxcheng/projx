import java.io.*;
import java.util.Vector;
import org.apache.poi.ss.usermodel.*;

public class ResourceGenerator {
	
	
    public static void main(String[] args) throws Exception 
    {
    	int _jpgQuality = 0;
    	String _srcFolder = "";
    	int _anchorX = 0;
    	int _anchorY = 0;
    	int _rid = 0;
    		
        InputStream is = new FileInputStream(new File("resource.xls"));
        //System.out.println(is.available());
        Workbook wb = WorkbookFactory.create(is);
        Sheet sheet = wb.getSheetAt(0);
        int i = 0;

        byte[] pngBuffer = new byte[8 * 2024 * 2024];

        
        for(Row row : sheet) 
        {
        	boolean emptyRow = false;
        	i ++;
        	if (i == 1)
        		continue;
        	int k = 0;
        	DataOutputStream out = null;
        	StringBuffer outputJson = new StringBuffer();
            Vector<String> picPath = new Vector<String>();
            Vector<String> frameName = new Vector<String>();
            Vector<Integer> picID = new Vector<Integer>();
            Vector<Integer> frameCount = new Vector<Integer>();
            
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
        		case 0:// resource id
        			outputJson.append("{");
        			_rid = Integer.parseInt(str);
        			outputJson.append("\"rid:\":" + _rid + ",");
        			out = new DataOutputStream(new FileOutputStream("resource_" + _rid + ".res"));
        			break;
        		case 1:// remarks
        			break;
        		case 2:// jpg quality
        			_jpgQuality = Integer.parseInt(str);
        			break;
        		case 3:// source folder
        			_srcFolder = str;
        			break;
        		case 4://anchorX
        			_anchorX = Integer.parseInt(str);
        			outputJson.append("\"anchorX\":" + _anchorX + ",");
        			break;
        		case 5:// anchorY
        			_anchorY = Integer.parseInt(str);
        			outputJson.append("\"anchorY\":" + _anchorY + ",");
        			break;
        		default:
        			if (k % 2 == 0) {
        				picPath.addElement(str);
        			} else {
        				frameCount.addElement((int)(cell.getNumericCellValue()));
        			}
        			break;
        		}
                
                k ++;
                
            }
            int t = 0;
        	boolean flag = true;
        	for (int j = 0; j < picPath.size(); j ++) 
        	{
	        	for (k = 0; k < j; k ++) 
	        	{
	        		if (picPath.elementAt(j).equals(picPath.elementAt(k))) 
	        		{
	        			picID.addElement(picID.elementAt(k));
	        			flag = false;
	        			break;
	        		}
	        	}
	        	if (flag) // new file, allocate a new id to it
	        	{
	        		frameName.addElement(picPath.elementAt(j));
	        		picID.addElement(t);
	        		t ++;
	        	}
        	}
        	
        	// output frameName array to json
        	outputJson.append("\"frameName\":{");
        	for (int j = 0; j < frameName.size(); ++j)
        	{
        		if (j > 0) outputJson.append(",");
        		outputJson.append("\"" + frameName.elementAt(j) + "\"");
        	}
        	outputJson.append("},");
        	
        	// output frameList
        	outputJson.append("\"animation\":{");
        	boolean firstFlag = true;
        	for (int j = 0; j < picPath.size(); ++j)
        	{
        		for (int l = 0; l < frameCount.elementAt(j); ++l)
        		{
        			if (!firstFlag)
        				outputJson.append(",");
        			outputJson.append(picID.elementAt(j));
        			firstFlag = false;
        		}
        	}
        	if (emptyRow)
        		break;
        	outputJson.append("}}");
        	out.writeUTF(outputJson.toString());
        	//TODO: use texture packer
        	// TexturePacker --algorithm MaxRects --sheet xxx.jpg --data xxx.json --format json --trim-sprite-names --allow-free-size --opt RGB888 --jpg-quality 80 
        	// TexturePacker --algorithm MaxRects --sheet xxx_a.jpg --data xxx.json --format json --trim-sprite-names --allow-free-size --opt Alpha --jpg-quality 80
        	String arg1 = "--disable-rotation --algorithm MaxRects --sheet out.jpg --data out.json --format json  --allow-free-size --opt RGB888 --jpg-quality "
        			+ _jpgQuality;
        	String arg2 = "--disable-rotation --algorithm MaxRects --sheet out_a.jpg --data out.json --format json  --allow-free-size --opt Alpha --jpg-quality "
        			+ _jpgQuality;
        	Runtime.getRuntime().exec("D:\\Program Files (x86)\\TexturePacker\\bin\\TexturePacker.exe " + _srcFolder + " " + arg1);
        	Runtime.getRuntime().exec("D:\\Program Files (x86)\\TexturePacker\\bin\\TexturePacker.exe " + _srcFolder + " " + arg2);
        	
        	//TODO: copy .json and put it to out
        	InputStream tpinp = new FileInputStream(new File("out.json"));
        	byte[] jsonBuffer = new byte[tpinp.available()];        	
        	int ret = tpinp.read(jsonBuffer);
        	String str = new String(jsonBuffer);
        	out.writeUTF(str);
            out.writeInt(ret);
            tpinp.close();
            
            //TODO: put 2 jpg file into out
            
            tpinp = new FileInputStream(new File("out.jpg"));
            ret = tpinp.read(pngBuffer);
            out.writeInt(ret);
            out.write(pngBuffer, 0, ret);
            tpinp.close();
            tpinp = new FileInputStream(new File("out_a.jpg"));
            ret = tpinp.read(pngBuffer);
            out.writeInt(ret);
            out.write(pngBuffer, 0, ret);
            tpinp.close();
        	
            out.close();
        	
        }
        is.close();
    }  
}
