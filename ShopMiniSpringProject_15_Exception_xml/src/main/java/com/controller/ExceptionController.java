package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ExceptionController {
	
	@RequestMapping("/error404")
	public String error1() {
		System.out.println("error404");
		return "error/error404";
	}
	
	@RequestMapping("/error405")
	public String error2() {
		System.out.println("error405");
		return "error/error405";
	}
	
	@RequestMapping("/error500")
	public String error3() {
		System.out.println("error500");
		return "error/error500";
	}
	
}
