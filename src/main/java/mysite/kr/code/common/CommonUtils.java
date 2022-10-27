package mysite.kr.code.common;

import java.util.UUID;

public class CommonUtils {

	//static하지만 final을 넣어서 수정은 못함
	//원하는 경로로 지정해 저장
	public final static String uploadPath="E:\\Project\\K_IT\\BackEnd\\springUpload\\";
	
	//파일저장 이름을 랜덤하게 만들기 위해 사용
	public static String getUUID() {
		String uuid=UUID.randomUUID().toString();
		uuid=uuid.replace("-", "").substring(0,16);
		return uuid;
	}
}
