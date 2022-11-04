package mysite.kr.code.login.controller;

import java.security.PrivateKey;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import lombok.RequiredArgsConstructor;
import mysite.kr.code.common.security.ZRsaSecurity;
import mysite.kr.code.login.service.LoginService;
import mysite.kr.code.login.vo.LoginData;

@Controller
@RequestMapping("/login")
@RequiredArgsConstructor
public class LoginController {
	
	private final LoginService  service;
	
	@GetMapping("/form.do")
	public ModelAndView  loginView() throws Exception {
		ModelAndView view = new ModelAndView();
		view.setViewName("login/loginForm");
		
		return view;
	}
	
	
	@PostMapping("/proc.do")
	public ModelAndView loginProc(@ModelAttribute LoginData.LoginRequest loginRequest, HttpServletRequest req) throws Exception {
		ModelAndView view = new ModelAndView();
		ZRsaSecurity security = new ZRsaSecurity();
		PrivateKey privateKey =  null;
	
		int result = 0;
		if(req.getSession().getAttribute("_rsaPrivateKey_") != null) {
			
			  privateKey =   (PrivateKey)req.getSession().getAttribute("_rsaPrivateKey_");
			  //사용자 ID 복호화
			  String userId = security.decryptRSA(privateKey,  loginRequest.getSecuredUserId());
			  //사용자 비밀번호 복호화 
			  String userPasswd = security.decryptRSA(privateKey,  loginRequest.getSecuredUserPasswd());
			 
			  Map<String, Object> param = new HashMap<>();
			  param.put("userId", userId);
			  param.put("userPasswd", userPasswd);
		
			  result = service.loingProcess(param, req.getSession());
			  
			  if(result  > 0) {
				   
					view.setViewName("redirect:/main/main.do");
			  }else {
				
				  view.setViewName("login/error");
				
					if(result == -1) {
						view.addObject("msg", "비밀번호가  옳바르지 않습니다. . ");
					}else if(result == -2) {
						view.addObject("msg", "아이디가 옳바르지 않습니다. ");
					}else {
						view.addObject("msg", "시스템에 문제가 발생했습니다. 관리자에게 말씀하세요.");
					}
			  }
			  
		
		}else {
			view.setViewName("login/error");
			view.addObject("msg", "비정상 접근통한 로그인 시도입니다.");
		}
		
		
		return view;
	}
	
	
	@GetMapping("/get/rsa-key.do")
	@ResponseBody
	public Map<String, Object> getRSAKey(HttpServletRequest request) throws Exception {
		Map<String,  Object> resultMap = new HashMap<>();
		try {
			
			ZRsaSecurity security = new ZRsaSecurity();
			PrivateKey privateKey = security.getPrivateKey();
			
			HttpSession session = request.getSession();
			
			if(session.getAttribute("_rsaPrivateKey_") != null) {
				session.removeAttribute("_rsaPrivateKey_") ;
			}
			
			session.setAttribute("_rsaPrivateKey_", privateKey) ;
			
			String publicKeyModule = security.getRsaPublicKeyModulus();
			String publicKeyExponent = security.getRsaPublicKeyExponent();
			
			resultMap.put("publicKeyModule", publicKeyModule);
			resultMap.put("publicKeyExponent", publicKeyExponent);
			
		
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultMap;
	}
	
	@GetMapping("/out.do")
	public ModelAndView logout(HttpServletRequest request) throws Exception{
		ModelAndView view=new ModelAndView();
		
		HttpSession session=request.getSession();
		
		if(session.getAttribute("userInfo")!=null) {
			session.removeAttribute("userInfo");
		}
		
		//리다이렉트
		view.setViewName("redirect:/login/form.do");
		
		return view;
	}

}
