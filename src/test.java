/*import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import com.iterms.been.Modell;


public class test {

	static String[] urll = new String[34];
	  static InputStream in;
	  static OutputStream out;
	public static void main(String[] args) throws IOException  {
		// TODO Auto-generated method stub
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSS");
		String res = sdf.format(new Date());
		String fileName = "F:\\test\\1.xlsx";
		
		readExcel(fileName,2);
		String urlstr="F:\\test\\"+urll[12];
			File file =new File(urlstr);
		
			String fname = urll[12];
			//文件类型
			String ftype=fname.substring(fname.lastIndexOf("."));
			res+=ftype;
			// 新文件
			File newFile = new File("F:\\test" + File.separator +res  );
			// 判断目标文件所在目录是否存在
			if( !newFile.getParentFile().exists()) {
				// 如果目标文件所在的目录不存在，则创建父目录
				newFile.getParentFile().mkdirs();
			}
			try {
				  in = new FileInputStream(file);
				 out = new FileOutputStream(newFile);
				byte[] buffer = new byte[1024];  
	            while (true) {  
	                int byteRead = in.read(buffer);  
	                if (byteRead == -1)  
	                    break;  
	                out.write(buffer, 0, byteRead);  
	            }  
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        catch (MalformedURLException ex) {  
	            System.err.println(args[0] + " is not a URL Java understands.");  
	        } 
			finally {  
	            if (in != null)  
	                in.close();  
	            if (out != null) {  
	                out.close();  
	            }  
	        }  
	      
			System.out.println(res);
			
	}

	public static void readExcel(String fileName, int colnum) {
		Workbook workbook = null;
		Row row = null;
		workbook = getWorkbook(fileName);
		Sheet sheet = workbook.getSheetAt(0);
		for (int i = 0; i < 34; i++) {
			row = sheet.getRow(i);
			urll[i]=new String();
			if (row != null) {
					Cell cell = row.getCell(colnum);
					String str = String.valueOf(getValueFromCell(cell));
				urll[i]=str;
				System.out.println(urll[i]);
			}
		}
	}
	
	
	private static Workbook getWorkbook(String fileName) {
		Workbook workbook = null;
		String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
		InputStream in = null;
		try {
			in = new FileInputStream(fileName);
			if ("xls".equals(suffix)) {
				workbook = new HSSFWorkbook(in);
			} else if ("xlsx".equals(suffix)) {
				workbook = new XSSFWorkbook(in);
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return workbook;
	}

	private static Object getValueFromCell(Cell cell) {
		Object value = null;
		if (null == cell) {
			return "";
		}
		// 判断cell类型
		switch (cell.getCellType()) {
		case Cell.CELL_TYPE_NUMERIC: {
			value = String.valueOf(cell.getNumericCellValue());
			break;
		}
		case Cell.CELL_TYPE_FORMULA: {
			// 判断cell是否为日期格式
			if (DateUtil.isCellDateFormatted(cell)) {
				// 转换为日期格式YYYY-mm-dd
				value = cell.getDateCellValue();
			} else {
				// 数字
				value = String.valueOf(cell.getNumericCellValue());
			}
			break;
		}
		case Cell.CELL_TYPE_STRING: {
			value = cell.getRichStringCellValue().getString();
			break;
		}
		default:
			value = "";
		}
		return value;
	}
}
*/