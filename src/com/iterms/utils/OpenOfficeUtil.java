package com.iterms.utils;

import java.io.File;
import java.util.regex.Pattern;

import org.jodconverter.OfficeDocumentConverter;
import org.jodconverter.office.DefaultOfficeManagerBuilder;
import org.jodconverter.office.OfficeException;
import org.jodconverter.office.OfficeManager;
import org.springframework.util.StringUtils;

//OpenOffice插件  工具类
public class OpenOfficeUtil {
	
	 /**
	 * 连接OpenOffice.org 并且启动OpenOffice.org
	 *
	 * @return
	 */

	@SuppressWarnings("deprecation")
	public static OfficeManager getOfficeManager() {
	    DefaultOfficeManagerBuilder config = new DefaultOfficeManagerBuilder();
	    // 设置OpenOffice.org 3的安装目录
	    config.setOfficeHome(getOfficeHome());
	    // 启动OpenOffice的服务
	    OfficeManager officeManager = config.build();
	    try {
			officeManager.start();
		} catch (OfficeException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return officeManager;
	}
	/**
	    * 转换文件
	 *
	         * @param inputFile
	 * @param outputFilePath_end
	 * @param inputFilePath
	 * @param outputFilePath_end
	 * @param converter
	 */
	public static File converterFile(File inputFile, String outputFilePath_end, String inputFilePath,
	                                 OfficeDocumentConverter converter) {
	    File outputFile = new File(outputFilePath_end);
	    // 假如目标路径不存在,则新建该路径
	    if (!outputFile.getParentFile().exists()) {
	        outputFile.getParentFile().mkdirs();
	    }
	    try {
			converter.convert(inputFile, outputFile);
		} catch (OfficeException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    System.out.println("文件：" + inputFilePath + "\n转换为\n目标文件：" + outputFile + "\n成功!");
	    return outputFile;
	}


	/**
	 * 使Office2003-2007全部格式的文档(.doc|.docx|.xls|.xlsx|.ppt|.pptx) 转化为pdf文件<br>
	 *
	 * @param inputFilePath
	 *            源文件路径，如："e:/test.docx"
	 *            目标文件路径，如："e:/test_docx.pdf"
	 * @return
	 */
	public static File office2pdf(String inputFilePath,String outputFilePath_end) {
	    OfficeManager officeManager = null;
	    try {
	        if (StringUtils.isEmpty(inputFilePath)) {
	            System.out.println("输入文件地址为空，转换终止!");
	            return null;
	        }
	        File inputFile;
	        String originSourceTxtName = inputFilePath.substring(inputFilePath.lastIndexOf("."));
	        if (originSourceTxtName.equalsIgnoreCase(".txt")) {
	             //是txt则需要转化为odt，然后再转为pdf
	            outputFilePath_end = outputFilePath_end.replaceAll("." + getPostfix(outputFilePath_end), ".txt.pdf");
	            System.out.println(outputFilePath_end);

	         }
	        inputFile = new File(inputFilePath); // 用于处理PDF文档
	        if (!inputFile.exists() && !getPostfix(inputFilePath).equals("txt")) {
	            System.out.println("输入文件不存在，转换终止!");
	            return null;
	        }
	        // 获取OpenOffice的安装路劲
	        officeManager = getOfficeManager();
	        // 连接OpenOffice
	        OfficeDocumentConverter converter = new OfficeDocumentConverter(officeManager);

	        return converterFile(inputFile, outputFilePath_end, inputFilePath, converter);
	    } catch (Exception e) {
	        System.out.println("转化出错!");
	    } finally {
	        // 停止openOffice
	        if (officeManager != null) {
	            try {
					officeManager.stop();
				} catch (OfficeException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        }
	    }
	    return null;
	}
	/**
	 * 根据操作系统的名称，获取OpenOffice.org 3的安装目录<br>
	 * 如我的OpenOffice.org 3安装在：C:/Program Files (x86)/OpenOffice.org 3<br>
	 *
	 * @return OpenOffice.org 3的安装目录
	 */
	public static String getOfficeHome() {
		String osName = System.getProperty("os.name");
		System.out.println("操作系统名称："+osName);
		if(Pattern.matches("Linux", osName)) {
			return "/opt/openoffice.org4";
		}else if(Pattern.matches("Windows.*", osName)) {
			return "D:\\green\\OpenOffice4";
		}else if(Pattern.matches("Windows.*", osName)) {
			return "/Application/OpenOffice.org.app/Contents";
		}
		return null;
	}
	/**
	 * 获取输出文件的路径
	 *
	 * @param inputFilePath
	 * @return
	 */
	public static String getOutputFilePath(String inputFilePath) {
	    String outputFilePath = inputFilePath.replaceAll("." + getPostfix(inputFilePath), ".pdf");
	    return outputFilePath;
	}
	/**
	 * 获取inputFilePath的后缀名，如："e:/test.pptx"的后缀名为："pptx"<br>
	 *
	 * @param inputFilePath
	 * @return
	 */
	public static String getPostfix(String inputFilePath) {
	    return inputFilePath.substring(inputFilePath.lastIndexOf(".") + 1);
	}
}
