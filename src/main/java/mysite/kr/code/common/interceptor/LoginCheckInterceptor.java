package mysite.kr.code.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginCheckInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//세션정보확인
		HttpSession session=request.getSession();
		boolean isPassed=true;
		//로그인 정보가 없다면
		if(session.getAttribute("userInfo")==null) {
			
			if(isAjaxRequest(request)) {
				response.sendError(401);
			}else {
				response.sendRedirect("/login/error/info.do");
			}
			
			isPassed=false;
			
		}else {
			//세션 지속시간을 30분으로 초기화
			session.setMaxInactiveInterval(60*30);
			isPassed=true;
		}
		
		return isPassed;
	}
	
	private boolean isAjaxRequest(HttpServletRequest request) {
		String header=request.getHeader("AJAX");
		
		if("true".equals(header)) {
			return true;
		}else {
			return false;
		}
	}

}
