import java.io.*;

import org.apache.poi.ss.usermodel.*;
import java.awt.image.BufferedImage;

import java.awt.Graphics;
import java.awt.Image;

import javax.imageio.ImageIO;

/*
 * Big picture generator, the output is three different qualities of the same picture.
 */
public class BigPicGenerator {
	
	static int lowid, stdid, highid;
	static double lowS, stdS, highS;// scale
	
	public static void imgScale(String srcImageFile, String result,
            double scale) 
	{
		try 
		{
			BufferedImage src = ImageIO.read(new File(srcImageFile)); // 读入文件
			int width = src.getWidth(); // 得到源图宽
			int height = src.getHeight(); // 得到源图长
			
			width = (int) Math.ceil(width * scale);
			height =(int) Math.ceil(height * scale);
			
			Image image = src.getScaledInstance(width, height,
					Image.SCALE_DEFAULT);
			BufferedImage tag = new BufferedImage(width, height,
					BufferedImage.TYPE_INT_RGB);
			Graphics g = tag.getGraphics();
			g.drawImage(image, 0, 0, null); // 绘制缩小后的图
			g.dispose();
			ImageIO.write(tag, "JPEG", new File(result));// 输出到文件流
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
		}
	}
	 
	public static String getStr(int flag)
	{
		String ret = "";
		if (flag == 1) //  low
		{
			ret += "{\"rid\":" + lowid + ",\"quality\": \"low\"," + "\"lowid\":" + lowid
					+ ",\"stdid\":" + stdid + ",\"highid\":" + highid + "}";
			
		}
		else if (flag == 2) // std
		{
			ret += "{\"rid\":" + stdid + ",\"quality\": \"std\"," + "\"lowid\":" + lowid
					+ ",\"stdid\":" + stdid + ",\"highid\":" + highid + "}";
		}
		else if (flag == 3)// high
		{
			ret += "{\"rid\":" + highid + ",\"quality\": \"high\"," + "\"lowid\":" + lowid
					+ ",\"stdid\":" + stdid + ",\"highid\":" + highid + "}";
		}
		
		return ret;
	}
	
    public static void main(String[] args) throws Exception 
    {
    	String _picPath = "";
    	
 
    		
        InputStream is = new FileInputStream(new File("resource_bigpic.xls"));
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
        	
        	lowS = stdS = highS = 0;
        	
        	
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
        		case 0:// remark
        			break;
        		case 1:// picPath
        			_picPath = str;
        			break;
        		case 2:// low id
        			
        			lowid = Integer.parseInt(str);
        			break;
        		case 3:// low scale
        			
        			lowS = Integer.parseInt(str) * 1.0 / 100;
        			break;
        		case 4:// std id
        			
        			stdid = Integer.parseInt(str);
        			break;
        		case 5:// std scale
        			
        			stdS = Integer.parseInt(str) * 1.0 / 100;
        			break;
        		case 6: // high id
        			highid = Integer.parseInt(str);
        			break;
        		case 7: // high scale
        			highS = Integer.parseInt(str) * 1.0 / 100;
        			break;
        		default:
        			
        			break;
        		}
                
                k ++;
            }
            
            // a line read
            // generate three sizes of pic
            if (lowS > 0) 
            	imgScale(_picPath, "low.jpg", lowS);
            if (stdS > 0) 
            	imgScale(_picPath, "std.jpg", stdS);
            imgScale(_picPath, "high.jpg", highS);
            
            // generate three .res file
            DataOutputStream outs = null;
            int ret;
            FileInputStream tpinp;
            if (lowS > 0)
            {
            
            outs = new DataOutputStream(new FileOutputStream("3_" + lowid + ".res"));
            tpinp = new FileInputStream(new File("low.jpg"));
            ret = tpinp.read(pngBuffer);
            outs.writeUTF(getStr(1));
            outs.writeInt(ret);
            outs.write(pngBuffer, 0, ret);
            outs.close();
            }
            if (stdS > 0)
            {
            outs = new DataOutputStream(new FileOutputStream("3_" + stdid + ".res"));
            tpinp = new FileInputStream(new File("std.jpg"));
            ret = tpinp.read(pngBuffer);
            outs.writeUTF(getStr(2));
            outs.writeInt(ret);
            outs.write(pngBuffer, 0, ret);
            outs.close();
            }
            
            outs = new DataOutputStream(new FileOutputStream("3_" + highid + ".res"));
            tpinp = new FileInputStream(new File("high.jpg"));
            ret = tpinp.read(pngBuffer);
            outs.writeUTF(getStr(3));
            outs.writeInt(ret);
            outs.write(pngBuffer, 0, ret);
            outs.close();
            
        }
        is.close();
    }  
}
