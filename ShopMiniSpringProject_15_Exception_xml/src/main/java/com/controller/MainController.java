package com.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dto.GoodsDTO;
import com.service.GoodsService;

@Controller
public class MainController {
	
	@Autowired
	GoodsService service;
	
	@RequestMapping("/") //리스트 무조건 뿌리기
	public ModelAndView main() {
//		int result = 10/0;  405 에러 확인
		List<GoodsDTO> list = service.goodsList("top");
		ModelAndView mav = new ModelAndView();
		mav.addObject("goodsList", list);
		mav.setViewName("main");
		return mav;
	}
	
	@RequestMapping("/home") //리스트 무조건 뿌리기
	public ModelAndView home() {
		List<GoodsDTO> list = service.goodsList("top");
		ModelAndView mav = new ModelAndView();
		mav.addObject("goodsList", list);
		mav.setViewName("main");
		return mav;
	}
}