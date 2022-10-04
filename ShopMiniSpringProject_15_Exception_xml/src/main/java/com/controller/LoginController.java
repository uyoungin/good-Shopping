package com.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.dto.MemberDTO;
import com.service.MemberService;

@Controller
public class LoginController {
	
	@Autowired
	MemberService service;
	
	//로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(@RequestParam Map<String, String> map, Model model, HttpSession session) {
		//아이디 확인
		MemberDTO idDTO = service.loginIDcheck(map);
		if (idDTO!=null) { 
			//비밀번호 확인
			MemberDTO dto = service.login(map);
			//dto 있는 경우 : 세션에 "login"키로 dto 저장 => goodsList?gCategory=top으로 주소 요청 => 상품 목록 뿌려주기
			//dto 없는 경우 : model에 mesg "아이디, 비밀번호 없음" => loginform.jsp
			if (dto!=null) {
				session.setAttribute("login", dto);
				return "redirect:/goodsList?gCategory=top"; //로그인 시 top 카테고리 보이도록 작성
			} else {
				model.addAttribute("mesg", "비밀번호 틀림");
				return "loginForm";
			}
		} else { //아이디 없는 경우2
			model.addAttribute("mesg", "해당 아이디 없음");
			return "loginForm";
		}
	}
	
	//로그아웃
	@RequestMapping(value = "/loginCheck/logout")
	public String logout(HttpSession session) {
		System.out.println("logout>>>>>>>>>>>>>>>>");
		session.invalidate();
		//return "../"; .xml에 설정 maim.jsp
		
		//회원전용 페이지는 servlet-context.xml에 주소 등록 후 이용
		//return "main";
		//return "../main";
		return "redirect:../"; //.xml에 설정 main.jsp -> ../을 이용하여 /loginCheck의 상위 주소로 이동
	}
	
}