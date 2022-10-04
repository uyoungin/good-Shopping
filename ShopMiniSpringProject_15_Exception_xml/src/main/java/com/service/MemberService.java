package com.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.MemberDAO;
import com.dto.MemberDTO;

@Service
public class MemberService {
	
	@Autowired
	MemberDAO dao;
	
	//회원가입
	public void memberAdd(MemberDTO m) {
		dao.memberAdd(m);	
	}
	
	//로그인 ID 확인
	public MemberDTO loginIDcheck(Map<String, String> map) {
		MemberDTO idDTO = dao.loginIDcheck(map);
		return idDTO;
	}
	
	//로그인 PW 확인
	public MemberDTO login(Map<String, String> map) {
		MemberDTO dto = dao.login(map);
		return dto;
	}

	//마이페이지 user 확인
	public MemberDTO myPage(String userid) {
		MemberDTO dto = dao.myPage(userid);
		return dto;
	}
	
	//마이페이지 회원 정보 수정
	public void memberUpdate(MemberDTO m) {
		dao.memberUpdate(m);
	}

}