package com.iterms.utils;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Base64;

public class ImgBase64Util {
	/***
	 *
	 * 将图片转换为Base64<br>
	 * 将base64编码字符串解码成img图片
	 * @param imgFile
	 * @return
	 */
	public static String getImgStr(String imgFile){
	    ByteArrayOutputStream data = new ByteArrayOutputStream();
	    System.out.println(imgFile);
	    try {
	        // 创建URL
	        URL url = new URL("http://localhost:8001/img/"+imgFile);
	        byte[] by = new byte[1024];
	        // 创建链接
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setConnectTimeout(5000);
	        InputStream is = conn.getInputStream();
	        // 将内容放到内存中
	        int len = -1;
	        while ((len = is.read(by)) != -1) {
	            data.write(by, 0, len);
	        }
	        is.close();
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    // 对字节数组Base64编码
	    System.out.println(Base64.getEncoder().encodeToString(data.toByteArray()));
	    return Base64.getEncoder().encodeToString(data.toByteArray());
	}
}
