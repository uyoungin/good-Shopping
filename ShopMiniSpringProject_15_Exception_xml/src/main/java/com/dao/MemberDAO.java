package com.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.MemberDTO;

@Repository
public class MemberDAO {
	
	@Autowired
	SqlSessionTemplate template; //자동주입
	
	//회원가입
	public void memberAdd(MemberDTO m) {
		int n = template.insert("MemberMapper.memberAdd", m);
		System.out.println("memberAdd record>> "+n);
	}
	
	//로그인 ID 확인
	public MemberDTO loginIDcheck(Map<String, String> map) {
		return template.selectOne("MemberMapper.IDcheck", map);
	}
	
	//로그인 PW 확인
	public MemberDTO login(Map<String, String> map) {
		return template.selectOne("MemberMapper.login", map);
	}
	
	//마이페이지 user 확인
	public MemberDTO myPage(String userid) {
		return template.selectOne("MemberMapper.myPage", userid);
	}
	
	//마이페이지 회원 정보 수정
	public void memberUpdate(MemberDTO m) {
		int n = template.update("MemberMapper.memberUpdate", m);
		System.out.println("memberUpdate record>> "+n);
	}

}