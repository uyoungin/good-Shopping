package com.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
	
	// /loginCheck
	//주의 ) servlet-context.xml에서 주소처리 등록해야 함!

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("LoginCheckInterceptor preHandle========");
		HttpSession session = request.getSession();
		//boolean result = true;
		if (session.getAttribute("login") == null) { //로그인 안 된 경우
			System.out.println("Interceptor 로그인 정보 없음");
			response.sendRedirect("../loginForm"); //그냥 /loginForm으로 요청하면  /loginCheck/loginForm으로 요청되므로 ../ 으로 요청(한단계 위로 올라가서  /loginCheck 지워버림)
			// /loginCheck 주소 시 /loginCheck 남아 있게 되어 /loginCheck/loginForm 주소 요청이 됨
			return false;
		} else { //로그인 된 경우
			return true; //계속 진행
		}
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
		System.out.println("postHandle");
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		super.afterCompletion(request, response, handler, ex);
		System.out.println("afterCompletion");
	}

	@Override
	public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		super.afterConcurrentHandlingStarted(request, response, handler);
		System.out.println("afterConcurrentHandlingStarted");
		
	}
	
}