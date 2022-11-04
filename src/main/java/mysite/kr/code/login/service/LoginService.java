package mysite.kr.code.login.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import mysite.kr.code.login.dao.LoginMapper;
import mysite.kr.code.login.vo.LoginData;

@Service
@RequiredArgsConstructor
public class LoginService {
	//생성자를 통한 의존성 주입 - final 변수로 선언 해야합니다.
	private final LoginMapper mapper;
	private final PasswordEncoder passwordEncoder;
	
	public int loingProcess(Map<String, Object> param, HttpSession session) {
		int result = 0;  // 로직에러 

		try {
			LoginData.LoginUserInfo user   = mapper.getUserInfo(param);
			String userPasswd = param.get("userPasswd").toString();
			
			if(user !=   null) {
				if(passwordEncoder.matches(userPasswd, user.getUserPasswd())) {
					result = 1;  // 성공
					user.setUserPasswd("");
					session.setAttribute("userInfo", user);
				}else {
					result  = -1;  // passwd 잘못
				}
			}else {
				result = -2;  // userId 잘못
			}
	
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
