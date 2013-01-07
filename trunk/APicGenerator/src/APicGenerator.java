import java.io.*;
import java.util.Vector;
import org.apache.poi.ss.usermodel.*;

public class APicGenerator {
	
	
    public static void main(String[] args) throws Exception 
    {
    	int _jpgQuality = 0;
    	String _srcFolder = "";
    	
    	int _rid = 0;
    		
        InputStream is = new FileInputStream(new File("resource_apic.xls"));
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
        			outputJson.append("\"rid:\":" + _rid);
        			out = new DataOutputStream(new FileOutputStream("4_" + _rid + ".res"));
        			break;
        		case 1:// remarks
        			break;
        		case 2:// jpg quality
        			_jpgQuality = Integer.parseInt(str);
        			break;
        		case 3:// source path
        			_srcFolder = str;
        			break;
        		default:        		
        			break;
        		}
                
                k ++;
                
            }
            
        	outputJson.append("}");
        	out.writeUTF(outputJson.toString());
        	
        	//TODO: use texture packer
        	// TexturePacker --algorithm MaxRects --sheet xxx.jpg --data xxx.json --format json --trim-sprite-names --allow-free-size --opt RGB888 --jpg-quality 80 
        	// TexturePacker --algorithm MaxRects --sheet xxx_a.jpg --data xxx.json --format json --trim-sprite-names --allow-free-size --opt Alpha --jpg-quality 80
        	String name1 = "out_" + _rid;
        	String arg1 = "--disable-rotation --algorithm MaxRects --sheet " + name1 + ".jpg --data " +
        			name1 + ".json --format json  --allow-free-size --opt RGB888 --jpg-quality "
        			+ _jpgQuality;
        	String arg2 = "--disable-rotation --algorithm MaxRects --sheet " + name1 + "_a.jpg --data " +
        			name1 + ".json --format json  --allow-free-size --opt Alpha --jpg-quality "
        			+ _jpgQuality;
        	/*
        	Runtime.getRuntime().exec("del out.json");
        	Runtime.getRuntime().exec("del out.jpg");
        	Runtime.getRuntime().exec("del out_a.jpg");
        	*/
        	Process proc;
        	//_srcFolder = "F:\\MCW\\misc\\tempImg\\dialogUI\\portrait1.png";
        	//proc = Runtime.getRuntime().exec("D:\\Program Files (x86)\\TexturePacker\\bin\\TexturePacker.exe " +  + " " + arg1);
        	proc = Runtime.getRuntime().exec("D:\\Program Files (x86)\\TexturePacker\\bin\\TexturePacker.exe " + _srcFolder + " " + arg1);
        	proc.waitFor();
        	proc = Runtime.getRuntime().exec("D:\\Program Files (x86)\\TexturePacker\\bin\\TexturePacker.exe " + _srcFolder + " " + arg2);
        	proc.waitFor();
        	
        	//TODO: copy .json and put it to out
        	InputStream tpinp = new FileInputStream(new File(name1 + ".json"));
        	byte[] jsonBuffer = new byte[tpinp.available()];        	
        	int ret = tpinp.read(jsonBuffer);
        	String str = new String(jsonBuffer);
        	out.writeUTF(str);
            
            tpinp.close();
            
            //TODO: put 2 jpg file into out
            
            tpinp = new FileInputStream(new File(name1 + ".jpg"));
            ret = tpinp.read(pngBuffer);
            out.writeInt(ret);
            out.write(pngBuffer, 0, ret);
            tpinp.close();
            tpinp = new FileInputStream(new File(name1 + "_a.jpg"));
            ret = tpinp.read(pngBuffer);
            out.writeInt(ret);
            out.write(pngBuffer, 0, ret);
            tpinp.close();
            out.close();
        	
        }
        is.close();
    }  
}
