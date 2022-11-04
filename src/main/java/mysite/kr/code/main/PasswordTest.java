package mysite.kr.code.main;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordTest {
	public static void main(String[] args) {
		BCryptPasswordEncoder en = new BCryptPasswordEncoder();
		
		String passwd = "1234";
		String encodePasswd = "";
		encodePasswd =  en.encode(passwd);
		
		System.out.println(encodePasswd);
		
		//앞에는 원본  뒤에는 암호화된 패스워드 
		System.out.println(en.matches(passwd, encodePasswd));

	}

}
