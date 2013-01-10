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
	static int[] lowids;
	static int[] stdids;
	static int[] highids;
	static String[] gFiles;// name of files that have been generated
	
	public static void imgSplit(String srcImageFile, String attr)
	{
		int[] ids = null;
		double ts = 0;
		int w;	
		int h;
		
		BufferedImage src = null;
		try {
			src = ImageIO.read(new File(srcImageFile));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} // 读入文件
		int width = src.getWidth(); // 得到源图宽
		int height = src.getHeight(); // 得到源图长
		
		if (attr.equals("low"))
		{
			ids = lowids;
			ts = lowS;
		}
		else if (attr.equals("std"))
		{
			ids = stdids;
			ts = stdS;
		}
		else if (attr.equals("high"))
		{
			ids = highids;
			ts = highS;
		}
		h = (int) Math.ceil(600 * ts);
		w = (int) Math.ceil(1200 * ts);
		
		int c = -1;
		for (int hi = 0; hi < Math.round(height / h); ++hi)
			for (int wi = 0; wi < Math.round(width / w); ++ wi)
			{
				++c;
				
				BufferedImage tag = src.getSubimage(wi * w, hi *h, w, h);
				try {
					ImageIO.write(tag, "JPEG", new File(String.valueOf(ids[c]) + ".jpg"));
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		
	}
	
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
	 
	public static String getStr(String qu, int ii)
	{
		String ret = "";
		if (qu.equals("low")) //  low
		{
			ret += "{\"rid\":" + lowids[ii] + ",\"quality\": \"low\"," + "\"lowid\":" + lowids[ii]
					+ ",\"stdid\":" + stdids[ii] + ",\"highid\":" + highids[ii] + "}";
			
		}
		else if (qu.equals("std")) // std
		{
			ret += "{\"rid\":" + stdids[ii] + ",\"quality\": \"std\"," + "\"lowid\":" + lowids[ii]
					+ ",\"stdid\":" + stdids[ii] + ",\"highid\":" + highids[ii] + "}";
		}
		else if (qu.equals("high"))// high
		{
			ret += "{\"rid\":" + highids[ii] + ",\"quality\": \"high\"," + "\"lowid\":" + lowids[ii]
					+ ",\"stdid\":" + stdids[ii] + ",\"highid\":" + highids[ii] + "}";
		}
		
		return ret;
	}
	
    public static void main(String[] args) throws Exception 
    {
    	String _picPath = "";
    	gFiles = new String[1000];// 1000 is enough
 
    		
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
                
                String[] idstrs;
                switch (k) {
        		case 0:// remark
        			break;
        		case 1:// picPath
        			_picPath = str;
        			break;
        		case 2:// low id
        			idstrs = str.split(",");
        			lowids = new int[idstrs.length];
        			for (int l = 0; l < idstrs.length; ++l)
        			{
        				lowids[l] = Integer.parseInt(idstrs[l]);
        			}
        			break;
        		case 3:// low scale
        			lowS = Integer.parseInt(str) * 1.0 / 100;
        			break;
        		case 4:// std id
        			
        			idstrs = str.split(",");
        			stdids = new int[idstrs.length];
        			for (int l = 0; l < idstrs.length; ++l)
        			{
        				stdids[l] = Integer.parseInt(idstrs[l]);
        			}
        			break;
        		case 5:// std scale
        			
        			stdS = Integer.parseInt(str) * 1.0 / 100;
        			break;
        		case 6: // high id
        			idstrs = str.split(",");
        			highids = new int[idstrs.length];
        			for (int l = 0; l < idstrs.length; ++l)
        			{
        				highids[l] = Integer.parseInt(idstrs[l]);
        				
        			}
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
            DataOutputStream outs = null;
            FileInputStream tpinp;
            int ret;
            if (lowS > 0) 
            {
            	imgScale(_picPath, "low.jpg", lowS);
            	imgSplit("low.jpg", "low");
            	for (int p = 0; p < highids.length; ++p)
            	{
            		 outs = new DataOutputStream(new FileOutputStream("3_" + String.valueOf(lowids[p]) + ".res"));
                     tpinp = new FileInputStream(new File(String.valueOf(lowids[p]) + ".jpg"));
                     ret = tpinp.read(pngBuffer);
                     outs.writeUTF(getStr("low", p));
                     outs.writeInt(ret);
                     outs.write(pngBuffer, 0, ret);
                     outs.close();
                     tpinp.close();
                     File fs =new File(lowids[p] + ".jpg");
             		 if (fs.exists())
             			fs.delete();
            	}
            }
            if (stdS > 0) 
            {
            	imgScale(_picPath, "std.jpg", stdS);
            	imgSplit("std.jpg", "std");
            	for (int p = 0; p < highids.length; ++p)
            	{
            		 outs = new DataOutputStream(new FileOutputStream("3_" + String.valueOf(stdids[p]) + ".res"));
                     tpinp = new FileInputStream(new File(String.valueOf(stdids[p]) + ".jpg"));
                     ret = tpinp.read(pngBuffer);
                     outs.writeUTF(getStr("std", p));
                     outs.writeInt(ret);
                     outs.write(pngBuffer, 0, ret);
                     outs.close();
                     tpinp.close();
                     File fs =new File(stdids[p] + ".jpg");
             		if (fs.exists())
             			fs.delete();
            	}
            }
            if (highS > 0)
            {
            	imgScale(_picPath, "high.jpg", highS);
	            imgSplit("high.jpg", "high");
	            for (int p = 0; p < highids.length; ++p)
	        	{
	        		 outs = new DataOutputStream(new FileOutputStream("3_" + String.valueOf(highids[p]) + ".res"));
	                 tpinp = new FileInputStream(new File(String.valueOf(highids[p]) + ".jpg"));
	                 ret = tpinp.read(pngBuffer);
	                 outs.writeUTF(getStr("high", p));
	                 outs.writeInt(ret);
	                 outs.write(pngBuffer, 0, ret);
	                 outs.close();
	                 tpinp.close();
	                 File fs =new File(highids[p] + ".jpg");
	            		if (fs.exists())
	            			fs.delete();
	        	}
            }
	            

            
            
        }
        is.close();
    }  
}
