/*package com.iterms.utils;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class GetExcel {
	/*public static void getExcel(){
		String fileName = "E://111.xlsx";
        readExcel(fileName);
	}
	public static void readExcel() {
        Workbook workbook = null;
        String fileName = "E://111.xlsx";
        Row row = null;
        Exceldate[] exceldate=new Exceldate[21];
        int colnum=0;
        //获取Excel文档
        workbook = getWorkbook(fileName);
        //获取Excel文档的第一个sheet页
        Sheet sheet = workbook.getSheetAt(1);
        //获取文档中已保存数据的行数
        int rowNum = sheet.getPhysicalNumberOfRows();
        //获取第一行
        row = sheet.getRow(1);        
        //获取当前行已保存数据的最大列数
         colnum = row.getPhysicalNumberOfCells()+1;
         
        for (int i = 3; i < rowNum; i++) {
        	exceldate[i-3]=new Exceldate();
            row = sheet.getRow(i);
            if (row != null)
            {
                for (int j = 0; j < colnum; j++) {
                    Cell cell = row.getCell(j);                 
        //           System.out.println(getValueFromCell(cell));
                    switch(j) {
                    case 0:{
                    	String str=String.valueOf(getValueFromCell(cell));
                    	exceldate[i-3].setDatename(str);
                    }
                    case 1:{
                    	
                    }
                    case 2:{
                    	String str=String.valueOf(getValueFromCell(cell));
                    	exceldate[i-3].setDatemark(str);
                    }
                    case 3:{
                    	exceldate[i-3].setDate(getValueFromCell(cell));
                    }
                    }
                }
            }
        }
    }

    public static Workbook getWorkbook(String fileName) {//根据后缀获取Excel表格
        Workbook workbook = null;
        String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
        InputStream in = null;
        try {
            in = new FileInputStream(fileName);
            if ("xls".equals(suffix))
            {
                workbook = new HSSFWorkbook(in);
            }
            else if ("xlsx".equals(suffix))
            {
                workbook = new XSSFWorkbook(in);
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return workbook;
    }
    
    public static Object getValueFromCell(Cell cell) {//获取单元格的值
        Object value = null;
        if (null == cell)
        {
            return "";
        }
        //判断cell类型
        switch(cell.getCellType()){
        case Cell.CELL_TYPE_NUMERIC:{
            value = String.valueOf(cell.getNumericCellValue());
            break;
        }
        case Cell.CELL_TYPE_FORMULA:{
            //判断cell是否为日期格式
            if(DateUtil.isCellDateFormatted(cell)){
                //转换为日期格式YYYY-mm-dd
                value = cell.getDateCellValue();
            }else{
                //数字
                value = String.valueOf(cell.getNumericCellValue());
            }
            break;
        }
        case Cell.CELL_TYPE_STRING:{
            value = cell.getRichStringCellValue().getString();
            break;
        }
        default:
            value = "";
        }
        return value;
    }
}*/
