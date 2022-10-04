package com.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.MemberDTO;
import com.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	MemberService service;
	
	//회원가입
	@RequestMapping(value = "/memberAdd", method = RequestMethod.POST)
	public String memberAdd(MemberDTO m, RedirectAttributes ra) {
		service.memberAdd(m);
		ra.addFlashAttribute("success", m.getUsername()+"님 회원가입성공");
		return "redirect:home"; 
	}
	
	//아이디 중복 확인
	@RequestMapping(value = "/idDuplicateCheck", produces = "text/plain;charset=UTF-8") //한글 깨지는 경우
	public @ResponseBody String idDuplicatedCheck(@RequestParam("id") String userid) {
		MemberDTO dto = service.myPage(userid); 
		String mesg = "아이디 사용 가능";
		if (dto!=null) {
			mesg = "아이디 중복";
		}
		return mesg;
	}
	
	//마이페이지 
	@RequestMapping(value = "/loginCheck/mypage") 
	//loginCheck에서 login여부 확인하고 미로그인 시 loginForm으로 리턴, 여기서 로그인 여부 체크안해도됨, 되는 경우에만 이 함수 실행됨
	public String myPage(HttpSession session) {
		MemberDTO dto = (MemberDTO) session.getAttribute("login");
		String userid = dto.getUserid(); //세션에서 id 얻기
		dto = service.myPage(userid);
		System.out.println("mypage dto>> "+dto);
		session.setAttribute("login", dto);
		return "redirect:../myPage"; //주소에 해당하는 페이지를 servlet-context.xml에 등록해서 사용
		//return "myPage"; 주소에 해당하는 페이지를 servlet-context.xml에 등록해서 사용
	}
	
	//마이페이지 정보수정
	@RequestMapping(value = "/loginCheck/memberUpdate", method = RequestMethod.POST)
	 public String memberUpdate(MemberDTO m, HttpSession session) {
		service.memberUpdate(m);
		MemberDTO dto = (MemberDTO) session.getAttribute("login");
		String userid = dto.getUserid(); 
		dto = service.myPage(userid); //
		session.setAttribute("login", dto); //새정보로 세션 덮어쓰기
		return "redirect:../loginCheck/mypage"; //다시 요청
		//return "redirect:../mypage"; //servlet-context.xml 주소 요청
	}
	
}