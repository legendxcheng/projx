import java.io.*;


import java.awt.image.BufferedImage;

import java.awt.Graphics;
import java.awt.Image;

import javax.imageio.ImageIO;

import org.apache.poi.ss.usermodel.*;

/*
 * Big picture generator, the output is three different qualities of the same picture.
 */
public class UIPicGenerator {
	
	static int picid;
	public static String getStr()
	{
		String ret = "";
		ret += "{\"rid\":" + picid + "}"; 
		return ret;
	}
	
    public static void main(String[] args) throws Exception 
    {
    	String _picPath = "";
    	
    	InputStream is = new FileInputStream(new File("resource_uipic.xls"));
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
        			picid = Integer.parseInt(str);
        			break;
        		case 1:// remark
        			
        			break;
        		case 2:// file path
        			_picPath = str;
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
            outs = new DataOutputStream(new FileOutputStream("0_" + picid + ".res"));
            tpinp = new FileInputStream(new File(_picPath));
            ret = tpinp.read(pngBuffer);
            outs.writeUTF(getStr());
            outs.writeInt(ret);
            outs.write(pngBuffer, 0, ret);
            outs.close();
            
        }
        is.close();
    }  
}
