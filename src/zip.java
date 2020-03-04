/*import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.charset.Charset;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

public class zip {
	
	private static final int buffer = 2048;

	public static void main(String[] args) throws IOException {

		File zipFile = new File("F:/test.zip");
	    String path = "F:/zipfile/";
	    unZipFiles(zipFile, path);
	}

	/**
	   * 解压到指定目录
	   
	  public static void unZipFiles(String zipPath,String descDir)throws IOException
	  {
	    unZipFiles(new File(zipPath), descDir);
	  }
	  /**
	   * 解压文件到指定目录
	   
	  @SuppressWarnings("rawtypes")
	  public static void unZipFiles(File zipFile,String descDir)throws IOException
	  {
	    File pathFile = new File(descDir);
	    if(!pathFile.exists())
	    {
	      pathFile.mkdirs();
	    }
	    //解决zip文件中有中文目录或者中文文件
	    ZipFile zip = new ZipFile(zipFile, Charset.forName("GBK"));
	    for(Enumeration entries = zip.entries(); entries.hasMoreElements();)
	    {
	      ZipEntry entry = (ZipEntry)entries.nextElement();
	      String zipEntryName = entry.getName();
	      InputStream in = zip.getInputStream(entry);
	     // System.out.println((descDir+zipEntryName));
	      String outPath = (descDir+zipEntryName).replaceAll("\\*", "/");
	      //判断路径是否存在,不存在则创建文件路径
	   //   System.out.println(outPath.substring(0, outPath.lastIndexOf('/')));
	      File file = new File(outPath.substring(0, outPath.lastIndexOf('/')));
	      if(!file.exists())
	      {
	        file.mkdirs();
	      }
	      //判断文件全路径是否为文件夹,如果是上面已经上传,不需要解压
	      if(new File(outPath).isDirectory())
	      {
	        continue;
	      }
	      //输出文件路径信息
	      System.out.println(outPath);
	      OutputStream out = new FileOutputStream(outPath);
	      byte[] buf1 = new byte[buffer];
	      int len;
	      while((len=in.read(buf1))>0)
	      {
	        out.write(buf1,0,len);
	      }
	      in.close();
	      out.close();
	     
	    }
	    System.out.println("******************解压完毕********************");
	    zip.close();
	  }
}*/
