package com.model2.mvc.framework;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

public class RequestMapping {
	
	private static RequestMapping requestMapping;
	private Map<String, Action> map;
	private Properties properties;
	
	private RequestMapping(String resources) {
		map = new HashMap<String, Action>();
		InputStream in = null;
		
		try {
			in = getClass().getClassLoader().getResourceAsStream(resources); // 파일 불러오기
			properties = new Properties();
			properties.load(in); // InputStream을 Properties 객체로 읽어오기
		}catch(Exception ex) {
			System.out.println(ex);
			throw new RuntimeException("actionmapping.properties 파일 로딩 실패 :"+ex);
		}finally {
			if(in != null) {
				try { in.close(); }catch(Exception ex) {}
			}
		}
	}
	
	public synchronized static RequestMapping getInstance(String resources) {
		if(requestMapping == null) {
			requestMapping = new RequestMapping(resources);
		}
		return requestMapping;
	}
	
	public Action getAction(String path) {
		Action action = map.get(path);
		
		if(action == null) {
			String className = properties.getProperty(path);
			System.out.println("prop : "+properties); // 파일 내용 전부
			System.out.println("path : "+path);
			System.out.println("className : "+className); // path(key)에 대한 value 값
			className = className.trim(); // 공백 제거
			
			try {
				Class c = Class.forName(className); // 메모리에 로드
				Object obj = c.newInstance(); // 객체 생성
				// Object obj = Class.forName(className).newInstance();
				
				if(obj instanceof Action) { // 객체 타입 확인
					map.put(path, (Action)obj);
					action = (Action)obj;
				}else {
					throw new ClassCastException("Class 형변환시 오류 발생 ");
				}
			}catch(Exception ex) {
				System.out.println(ex);
				throw new RuntimeException("Action 정보를 구하는 도중 오류 발생 : "+ex);
			}
		}
		return action;
	}
	
}