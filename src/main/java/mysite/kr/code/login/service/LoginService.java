package mysite.kr.code.login.service;

import java.util.HashMap;
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
	
	/**
	 * 아이디 중복체크
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int userIdCheck(String userId) throws Exception{
		Map<String, Object> param=new HashMap<>();
		param.put("userId", userId);
		return mapper.userIdCheck(param);
	}
	
	/**
	 * 사용자 등록
	 * @param userInfo
	 * @return
	 * @throws Exception
	 */
	public int insertUserInfo(LoginData.LoginUserInfo userInfo){
		int result=0;
		try {
			//사용자 비밀번호 암호화
			String encodePasswd=passwordEncoder.encode(userInfo.getUserPasswd());
			
			//암호화된 패스워드로 치환
			userInfo.setUserPasswd(encodePasswd);
			result=mapper.insertUserInfo(userInfo);
		}catch(Exception e) {
			result=-1;
			e.printStackTrace();
		}
		
		return result;
	}
}
