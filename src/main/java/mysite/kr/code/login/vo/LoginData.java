package mysite.kr.code.login.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

public class LoginData {

	@Getter
	@AllArgsConstructor
	public static class LoginRequest {
		
		private String securedUserId;
		private String securedUserPasswd;
		
	}
	
	
	@Getter
	@Setter
	@NoArgsConstructor
	public static class LoginUserInfo implements Serializable{

		private static final long serialVersionUID = 1L;
		private String userId;
		private String userPasswd;
		private String userName;
		private String userBirth;
		private String userGender;
		private String userAddr1;
		private String userAddr2;
		private String userRoleId;
		private String createTime;
		
	}
	
	
	
}
