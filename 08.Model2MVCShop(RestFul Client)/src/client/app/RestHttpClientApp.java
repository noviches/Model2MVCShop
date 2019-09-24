package client.app;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;

public class RestHttpClientApp {
	
	public static void main(String[] args) throws Exception {
		
		///////////////////////////////////////////////////////////////////////
		// 주석을 하나씩 처리해가며 실습
		///////////////////////////////////////////////////////////////////////
		// UserRestController Test
		///////////////////////////////////////////////////////////////////////
		
		System.out.println("\n====================================\n");
		// 1.1 Http Get 방식 Request : JsonSimple lib 사용
//		RestHttpClientApp.getUserTest_JsonSimple();
		
		System.out.println("\n====================================\n");
		// 1.2 Http Get 방식 Request : CodeHaus lib 사용
//		RestHttpClientApp.getUserTest_Codehaus();
		
		System.out.println("\n====================================\n");
		// 2.1 Http Post 방식 Request : JsonSimple lib 사용
//		RestHttpClientApp.LoginTest_JsonSimple();
		
		System.out.println("\n====================================\n");
		// 2.2 Http Post 방식 Request : CodeHaus lib 사용
//		RestHttpClientApp.LoginTest_Codehaus();
		
		System.out.println("\n====================================\n");
		// 3. Http Post 방식 Request : CodeHaus lib 사용
//		RestHttpClientApp.addUserTest_Codehaus();
		
		System.out.println("\n====================================\n");
		// 4. Http Post 방식 Request : CodeHaus lib 사용
//		RestHttpClientApp.updateUserTest_Codehaus();
		
		System.out.println("\n====================================\n");
		// 5. Http Post 방식 Request : CodeHaus lib 사용
//		RestHttpClientApp.LogoutTest_Codehaus();
		
		System.out.println("\n====================================\n");
		// 6. Http Post 방식 Request : CodeHaus lib 사용
		// RestHttpClientApp.listUserTest_Codehaus();
		
		///////////////////////////////////////////////////////////////////////
		// ProductRestController Test
		///////////////////////////////////////////////////////////////////////
		
		System.out.println("\n====================================\n");
		// 1. Http Post 방식 Request : CodeHaus lib 사용
//		RestHttpClientApp.addProductTest_Codehaus();
		
	}
	
	//================================================================//
	// 1.1 Http Protocol GET Request : JsonSimple 3rd party lib 사용
	public static void getUserTest_JsonSimple() throws Exception {
		
		// HttpClient : Http Protocol 의 client 추상화 
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/user/json/getUser/admin";
		
		// HttpGet : Http Protocol 의 GET 방식 Request
		HttpGet httpGet = new HttpGet(url);
		httpGet.setHeader("Accept", "application/json");
		httpGet.setHeader("Content-Type", "application/json");
		
		// HttpResponse : Http Protocol 응답 Message 추상화
		HttpResponse httpResponse = httpClient.execute(httpGet);
		
		//==> Response 확인
		System.out.println(httpResponse);
		System.out.println();

		//==> Response 중 entity(DATA) 확인
		HttpEntity httpEntity = httpResponse.getEntity();
		
		//==> InputStream 생성
		InputStream is = httpEntity.getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		System.out.println("[ Server 에서 받은 Data 확인 ]");
		String serverData = br.readLine();
		System.out.println(serverData);
		
		//==> 내용읽기(JSON Value 확인)
		JSONObject jsonobj = (JSONObject)JSONValue.parse(serverData);
		System.out.println(jsonobj);
		
	}
	
	// 1.2 Http Protocol GET Request : JsonSimple + codehaus 3rd party lib 사용
	public static void getUserTest_Codehaus() throws Exception {
		
		// HttpClient : Http Protocol 의 client 추상화 
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/user/json/getUser/admin";

		// HttpGet : Http Protocol 의 GET 방식 Request
		HttpGet httpGet = new HttpGet(url);
		httpGet.setHeader("Accept", "application/json");
		httpGet.setHeader("Content-Type", "application/json");
		
		// HttpResponse : Http Protocol 응답 Message 추상화
		HttpResponse httpResponse = httpClient.execute(httpGet);
		
		//==> Response 확인
		System.out.println(httpResponse);
		System.out.println();

		//==> Response 중 entity(DATA) 확인
		HttpEntity httpEntity = httpResponse.getEntity();
		
		//==> InputStream 생성
		InputStream is = httpEntity.getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		//==> 다른 방법으로 serverData 처리 
		// System.out.println("[ Server 에서 받은 Data 확인 ]");
		// String serverData = br.readLine();
		// System.out.println(serverData);
		
		//==> API 확인 : Stream 객체를 직접 전달 
		JSONObject jsonobj = (JSONObject)JSONValue.parse(br);
		System.out.println(jsonobj);
		
		ObjectMapper objectMapper = new ObjectMapper();
		User user = objectMapper.readValue(jsonobj.toString(), User.class);
		System.out.println(user);
		
	}
	//================================================================//
	
	//================================================================//
	// 2.1 Http Protocol POST Request : FromData 전달 / JsonSimple 3rd party lib 사용
	public static void LoginTest_JsonSimple() throws Exception {
		
		// HttpClient : Http Protocol 의 client 추상화 
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/user/json/login";
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Accept", "application/json");
		httpPost.setHeader("Content-Type", "application/json");
		
		// [방법 1 : String 사용]
//		String data = "{\"userId\":\"admin\",\"password\":\"1234\"}";
//		HttpEntity httpEntity01 = new StringEntity(data, "utf-8");
		
		// [방법 2 : JSONObject 사용]
		JSONObject json = new JSONObject();
		json.put("userId", "admin");
		json.put("password", "1234");
		HttpEntity httpEntity01 = new StringEntity(json.toString(), "utf-8");

		httpPost.setEntity(httpEntity01);
		HttpResponse httpResponse = httpClient.execute(httpPost);
		
		//==> Response 확인
		System.out.println(httpResponse);
		System.out.println();

		//==> Response 중 entity(DATA) 확인
		HttpEntity httpEntity = httpResponse.getEntity();
		
		//==> InputStream 생성
		InputStream is = httpEntity.getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		System.out.println("[ Server 에서 받은 Data 확인 ]");
		String serverData = br.readLine();
		System.out.println(serverData);
		
		//==> 내용읽기(JSON Value 확인)
		JSONObject jsonobj = (JSONObject)JSONValue.parse(serverData);
		System.out.println(jsonobj);
	
	}
	
	// 2.2 Http Protocol POST 방식 Request : FromData 전달 / JsonSimple + codehaus 3rd party lib 사용
	public static void LoginTest_Codehaus() throws Exception {
		
		// HttpClient : Http Protocol 의 client 추상화 
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/user/json/login";
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Accept", "application/json");
		httpPost.setHeader("Content-Type", "application/json");
		
		// [방법 1 : String 사용]
//		String data = "{\"userId\":\"admin\",\"password\":\"1234\"}";
//		HttpEntity httpEntity01 = new StringEntity(data, "utf-8");
	
		// [방법 2 : JSONObject 사용]
//		JSONObject json = new JSONObject();
//		json.put("userId", "admin");
//		json.put("password", "1234");
//		HttpEntity httpEntity01 = new StringEntity(json.toString(), "utf-8");
		
		// [방법 3 : codehaus 사용]
		User user01 =  new User();
		user01.setUserId("admin");
		user01.setPassword("1234");
		ObjectMapper objectMapper01 = new ObjectMapper();
		// Object ==> JSON Value 로 변환
		String jsonValue = objectMapper01.writeValueAsString(user01);
		HttpEntity httpEntity01 = new StringEntity(jsonValue, "utf-8");
		
		httpPost.setEntity(httpEntity01);
		HttpResponse httpResponse = httpClient.execute(httpPost);
		
		//==> Response 확인
		System.out.println(httpResponse);
		System.out.println();

		//==> Response 중 entity(DATA) 확인
		HttpEntity httpEntity = httpResponse.getEntity();
		
		//==> InputStream 생성
		InputStream is = httpEntity.getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		//==> 다른 방법으로 serverData 처리 
		// System.out.println("[ Server 에서 받은 Data 확인 ]");
		// String serverData = br.readLine();
		// System.out.println(serverData);
		
		//==> API 확인 : Stream 객체를 직접 전달 
		JSONObject jsonobj = (JSONObject)JSONValue.parse(br);
		System.out.println(jsonobj);
	
		ObjectMapper objectMapper = new ObjectMapper();
		User user = objectMapper.readValue(jsonobj.toString(), User.class);
		System.out.println(user);
		
	}
	//================================================================//
	
	//================================================================//
	
	//================================================================//
	// 3. Http Protocol POST 방식 Request : JsonSimple + codehaus 3rd party lib 사용
	public static void addUserTest_Codehaus() throws Exception {
		
		// HttpClient : Http Protocol 의 client 추상화 
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/user/json/addUser";
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Accept", "application/json");
		httpPost.setHeader("Content-Type", "application/json");
		
		// [방법 : codehaus 사용]
		User user01 =  new User();
		user01.setUserId("testid");
		user01.setUserName("test");
		user01.setPassword("testpwd");
		user01.setAddr("testaddr");
		ObjectMapper objectMapper01 = new ObjectMapper();
		// Object ==> JSON Value 로 변환
		String jsonValue = objectMapper01.writeValueAsString(user01);
		HttpEntity httpEntity01 = new StringEntity(jsonValue, "utf-8");
		
		httpPost.setEntity(httpEntity01);
		HttpResponse httpResponse = httpClient.execute(httpPost);
		
		//==> Response 확인
		System.out.println(httpResponse);
		System.out.println();

		//==> Response 중 entity(DATA) 확인
		HttpEntity httpEntity = httpResponse.getEntity();
		
		//==> InputStream 생성
		InputStream is = httpEntity.getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		//==> 다른 방법으로 serverData 처리 
		// System.out.println("[ Server 에서 받은 Data 확인 ]");
		// String serverData = br.readLine();
		// System.out.println(serverData);
		
		//==> API 확인 : Stream 객체를 직접 전달 
		JSONObject jsonobj = (JSONObject)JSONValue.parse(br);
		System.out.println(jsonobj);
	
		ObjectMapper objectMapper = new ObjectMapper();
		User user = objectMapper.readValue(jsonobj.toString(), User.class);
		System.out.println(user);
		
	}
	
	// 4. Http Protocol POST 방식 Request : JsonSimple + codehaus 3rd party lib 사용
	public static void updateUserTest_Codehaus() throws Exception {
		
		// HttpClient : Http Protocol 의 client 추상화 
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/user/json/updateUser";
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Accept", "application/json");
		httpPost.setHeader("Content-Type", "application/json");
		
		// [방법 : codehaus 사용]
		User user01 =  new User();
		user01.setUserId("testid");
		user01.setUserName("change");
		user01.setPassword("changepwd");
		user01.setAddr("changeaddr");
		ObjectMapper objectMapper01 = new ObjectMapper();
		// Object ==> JSON Value 로 변환
		String jsonValue = objectMapper01.writeValueAsString(user01);
		HttpEntity httpEntity01 = new StringEntity(jsonValue, "utf-8");
		
		httpPost.setEntity(httpEntity01);
		HttpResponse httpResponse = httpClient.execute(httpPost);
		
		//==> Response 확인
		System.out.println(httpResponse);
		System.out.println();

		//==> Response 중 entity(DATA) 확인
		HttpEntity httpEntity = httpResponse.getEntity();
		
		//==> InputStream 생성
		InputStream is = httpEntity.getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		//==> 다른 방법으로 serverData 처리 
		// System.out.println("[ Server 에서 받은 Data 확인 ]");
		// String serverData = br.readLine();
		// System.out.println(serverData);
		
		//==> API 확인 : Stream 객체를 직접 전달 
		JSONObject jsonobj = (JSONObject)JSONValue.parse(br);
		System.out.println(jsonobj);
	
		ObjectMapper objectMapper = new ObjectMapper();
		User user = objectMapper.readValue(jsonobj.toString(), User.class);
		System.out.println(user);
		
	}
	
	// 5. Http Protocol GET Request : JsonSimple + codehaus 3rd party lib 사용
	public static void LogoutTest_Codehaus() throws Exception {
		
		// HttpClient : Http Protocol 의 client 추상화 
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/user/json/logout";
		
		// HttpGet : Http Protocol 의 GET 방식 Request
		HttpGet httpGet = new HttpGet(url);
		httpGet.setHeader("Accept", "application/json");
		httpGet.setHeader("Content-Type", "application/json");
		
		// HttpResponse : Http Protocol 응답 Message 추상화
		HttpResponse httpResponse = httpClient.execute(httpGet);
		
		//==> Response 확인
		System.out.println(httpResponse);
		System.out.println();
		
		//==> Response 중 entity(DATA) 확인
		HttpEntity httpEntity = httpResponse.getEntity();
		
		//==> InputStream 생성
		InputStream is = httpEntity.getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		//==> 다른 방법으로 serverData 처리 
		System.out.println("[ Server 에서 받은 Data 확인 ]");
		String serverData = br.readLine();
		System.out.println(serverData);
		
	}
	//================================================================//
	
	// 6. Http Protocol POST 방식 Request : FromData 전달 / JsonSimple + codehaus 3rd party lib 사용
	public static void listUserTest_Codehaus() throws Exception {
		
		// HttpClient : Http Protocol 의 client 추상화 
		HttpClient httpClient = new DefaultHttpClient();
		
		String url = "http://127.0.0.1:8080/user/json/listUser";
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Accept", "application/json");
		httpPost.setHeader("Content-Type", "application/json");
		
		// [방법 : codehaus 사용]
		User user01 = new User();
		user01.setUserId("admin");
		user01.setPassword("1234");
		ObjectMapper objectMapper01 = new ObjectMapper();
		// Object ==> JSON Value 로 변환
		String jsonValue = objectMapper01.writeValueAsString(user01);
		HttpEntity httpEntity01 = new StringEntity(jsonValue, "utf-8");
		
		httpPost.setEntity(httpEntity01);
		HttpResponse httpResponse = httpClient.execute(httpPost);
		
		//==> Response 확인
		System.out.println(httpResponse);
		System.out.println();
		
		//==> Response 중 entity(DATA) 확인
		HttpEntity httpEntity = httpResponse.getEntity();
		
		//==> InputStream 생성
		InputStream is = httpEntity.getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		//==> 다른 방법으로 serverData 처리
		// System.out.println("[ Server 에서 받은 Data 확인 ]");
		// String serverData = br.readLine();
		// System.out.println(serverData);
		
		//==> API 확인 : Stream 객체를 직접 전달
		JSONObject jsonobj = (JSONObject)JSONValue.parse(br);
		System.out.println(jsonobj);
		
		ObjectMapper objectMapper = new ObjectMapper();
		User user = objectMapper.readValue(jsonobj.toString(), User.class);
		System.out.println(user);
		
	}
	//================================================================//
	
	//================================================================//
	
	//================================================================//
	// 1. Http Protocol POST 방식 Request : JsonSimple + codehaus 3rd party lib 사용
	public static void addProductTest_Codehaus() throws Exception {
		
		// HttpClient : Http Protocol 의 client 추상화 Bean
		HttpClient httpClient = new DefaultHttpClient();
		
		// Request URL Make
		String url = "http://127.0.0.1:8080/product/json/addProduct";
		
		// HttpGet : Http Protocol Post 방식 Request Header 구성
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Accept", "application/json");
		httpPost.setHeader("Content-Type", "application/json");
		
		// POST 방식은 Body에 Data 전송
		//==> QueryString(name=value)으로 전송하지 않고
		//==> JSONData 전송 위해 Data Make [codehaus 사용]
		Product product =  new Product();
		product.setProdName("testProduct");
		product.setProdDetail("testDetail");
		product.setPrice(1000);
		product.setReQuantity(10);
		product.setManuDate("2019-05-16");
		
		ObjectMapper objectMapper01 = new ObjectMapper();
		// Domain Object ==> JSON Value 로 변환
		String jsonValue = objectMapper01.writeValueAsString(product);
		
		//==> Request Header/Body 중 Body에 만들기
		// HttpEntity : Http Protocol Body 추상화 Bean
		HttpEntity requesthttpEntity = new StringEntity(jsonValue, "utf-8");
		httpPost.setEntity(requesthttpEntity);
		
		//==> Request 실행 및 Response 받기
		// HttpResponse : Http Protocol 응답 Message 추상화 Bean
		HttpResponse httpResponse = httpClient.execute(httpPost);
		
		//==> Response 확인
		System.out.println(httpResponse);
		System.out.println();

		//==> Response 중 entity(DATA) 확인
		HttpEntity httpEntity = httpResponse.getEntity();
		
		//==> InputStream 생성
		InputStream is = httpEntity.getContent();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		//==> 다른 방법으로 serverData 처리 
		System.out.println("[ Server 에서 받은 Data 확인 ]");
		// String serverData = br.readLine();
		// System.out.println(serverData);
		
		//==> Server에서 받은 JSONData => JSONObject 객체 생성 
		JSONObject jsonobj = (JSONObject)JSONValue.parse(br);
		System.out.println(jsonobj);
	
		//==> Server에서 받은 JSONData => Domain Object 로 Binding
		ObjectMapper objectMapper = new ObjectMapper();
		Product returnProduct = objectMapper.readValue(jsonobj.toString(), Product.class);
		System.out.println(returnProduct);
		
	}
	
}