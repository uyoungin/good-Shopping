package com.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.CartDTO;
import com.dto.MemberDTO;
import com.dto.OrderDTO;
import com.service.GoodsService;
import com.service.MemberService;

@Controller
public class OrderController {

	@Autowired
	GoodsService service;
	@Autowired
	MemberService mService;
	
	//주문하기
	@RequestMapping("/loginCheck/orderConfirm")
	public String orderConfirm(@RequestParam("num") int num, HttpSession session, RedirectAttributes m) {
		System.out.println("orderConfirm");
		MemberDTO dto = (MemberDTO)session.getAttribute("login");
		//장바구니 정보 조회
			CartDTO cDTO = service.cartByNum(num);
		//사용자 정보 조회
			String userid = dto.getUserid();
			MemberDTO mDTO = mService.myPage(userid);
			System.out.println(cDTO+"\t"+mDTO);
		m.addFlashAttribute("cDTO", cDTO); //request에 카트 정보 저장
		m.addFlashAttribute("mDTO", mDTO); //request에 회원 정보 저장
		return "redirect:../orderConfirm"; //servlet-context.xml에 등록
	}
	
	//주문 완료 처리
	@RequestMapping("/loginCheck/orderDone")
	public String orderDone(OrderDTO oDTO, @RequestParam("orderNum") int orderNum, HttpSession session, RedirectAttributes m) {
		//dto의 userid 설정 (num은 시퀀스,orderday는 sysdate 사용)
		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
		oDTO.setUserid(mDTO.getUserid());
		//insert+delete
		service.orderDone(oDTO, orderNum);
		m.addFlashAttribute("oDTO", oDTO);
		return "redirect:../orderDone"; 
	}
	
	//주문 완료 페이지
		@RequestMapping("/orderDone")
		public String orderDonePage() {
			return "orderDone"; 
		}

}