package com.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.CartDTO;
import com.dto.GoodsDTO;
import com.dto.MemberDTO;
import com.service.GoodsService;

@Controller
public class GoodsController {

	@Autowired
	GoodsService service;
	
	//상품 목록
	@RequestMapping(value = "/goodsList")
	public ModelAndView goodsList(@RequestParam("gCategory") String gCategory) { //@RequestParam("gCategory")없어도 잘 받아짐!
		if (gCategory == null) { gCategory = "top"; } //gCategory가 없을 경우 기본은 top로 설정
		//goodsList 뽑아오기
		List<GoodsDTO> list = service.goodsList(gCategory);
		//ModelAndView로 반환(model로도 가능)
		ModelAndView mav = new ModelAndView();
		mav.addObject("goodsList", list); //request.setAttribute("goodsList",list)와 동일
		mav.setViewName("main"); //main.jsp
		return mav;
	}
	
	//상품 상세보기
	@RequestMapping(value = "/goodsRetrieve") //goodsRetrieve.jsp => view에 대한 지정이 없음 url=뷰파일.jsp
	@ModelAttribute("goodsRetrieve") //key값 설정 : goodsRetrieve = dto
	public GoodsDTO goodsRetrieve(@RequestParam String gCode) {
		GoodsDTO dto = service.goodsRetrive(gCode);
		return dto;
	}
	
	//장바구니 담기
	@RequestMapping("/loginCheck/cartAdd") //로그인 확인은 interceptor에서(/loginCheck)
	public String cartAdd(CartDTO cart, HttpSession session) {
		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
		cart.setUserid(mDTO.getUserid());
		service.cartAdd(cart);
		session.setAttribute("mesg", cart.getgCode());
		return "redirect:../goodsRetrieve?gCode="+cart.getgCode(); //../로 /loginCheck지우고 goodsRetrieve에 해당 상품 gCode 같이 넘겨줌
	}
	
	//1. 장바구니 목록 : RedirectAttributes
	@RequestMapping("/loginCheck/cartList")
	public String cartList(RedirectAttributes attr, HttpSession session) {
		//*RedirectAttributes 사용 : servlet-context.xml에 annotation-driven 태그 필요
		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
		String userid = mDTO.getUserid();
		List<CartDTO> list = service.cartList(userid);
		attr.addFlashAttribute("cartList", list);
		//↑ 리다이렉트 시 데이터 유지(redirect하면 새로운 요청이므로 request에 정보 저장 불가한데 RedirectAttributes 사용하면 가능)
 		return "redirect:../cartList"; //servlet-context.xml에 등록
	}
	
	//2. 장바구니 목록 : Model
//	@RequestMapping("/loginCheck/cartList")
//	public String cartList(Model model, HttpSession session) {
//		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
//		String userid = mDTO.getUserid();
//		List<CartDTO> list = service.cartList(userid);
//		model.addAttribute("cartList", list);
//		return "cartList"; //cartList.jsp (model은 request.setAttribute와 같음 forward방식으로 넘겨줌)
//	}
	
	//3. 장바구니 목록 : ModelAndView
//	@RequestMapping("/loginCheck/cartList")
//	public ModelAndView cartList(HttpSession session) {
//		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
//		String userid = mDTO.getUserid();
//		List<CartDTO> list = service.cartList(userid);
//		ModelAndView mav = new ModelAndView();
//		mav.addObject("cartList", list);
//		mav.setViewName("cartList");
//		return mav; //cartList.jsp
//	}
	
	//4. 장바구니 목록 : request 
//	@RequestMapping("/loginCheck/cartList")
//	public String cartList(HttpServletRequest request, HttpSession session) {
//		MemberDTO mDTO = (MemberDTO) session.getAttribute("login");
//		String userid = mDTO.getUserid();
//		List<CartDTO> list = service.cartList(userid);
//		request.setAttribute("cartList", list);
//		return "redirect:../cartList";  
////		↑ /cartList 주소 다시 요청(cartList.jsp아님) => 함수 실행 후 jsp를 찾음
////		=> /cartList 주소로 실행한 함수는 request에 binding한 데이터 못 불러옴(새로운 요청으로 실행했기 때문에)
//	}
//	@RequestMapping("/cartList") //위의 함수에서 return "redirect:../cartList";로 넘어온 경우
//	public String test() {
//		System.out.println("/cartList함수 실행===");
//		return "cartList"; //cartList.jsp => request 정보 안 넘어감 => 새로운 요청으로 test함수가 실행됐기 때문!
//	}
	
	//장바구니 수량 수정
	@RequestMapping("/loginCheck/cartUpdate")
	@ResponseBody
	public void cartUpdate(@RequestParam Map<String, String> map) {//@RequestParam으로 map 바로 받기
		System.out.println("cartUpdate map : "+map);
		service.cartUpdate(map);
	}
	
	//장바구니 상품 개별 삭제
	@RequestMapping("/loginCheck/cartDelete")
	@ResponseBody
	public void cartDelete(@RequestParam("num") int num) {
		System.out.println("cartDelete num : "+num);
		service.cartDelete(num);
	}
	
	//장바구니 상품 전체 삭제
	//1. HttpServletRequest request로 받아서 request.getParameterValues("check")로 파싱 가능
	//2. @RequestParam("check") String [] nums 배열로 파싱
	//3. String [] check : @RequestParam없이 변수명 맞춰서 배열로 파싱 가능
	//4. @RequestParam("check") ArrayList<String> list
	@RequestMapping("/loginCheck/delAllCart")
	public String delAllCart(@RequestParam("check") ArrayList<String> list) {
		System.out.println("delAllCart num : "+list);
		service.delAllCart(list);
		return "redirect:../loginCheck/cartList";
	}
	
}