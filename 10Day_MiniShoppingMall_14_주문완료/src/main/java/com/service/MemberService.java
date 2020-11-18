package com.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.MemberDAO;
import com.dto.MemberDTO;

@Service //component scan으로 자동 빈 생성
public class MemberService {
	
	@Autowired//dao 자동주입
	MemberDAO dao;

	public void memberAdd(MemberDTO m) {
		dao.memberAdd(m); //dto 전달
	}
	
	public MemberDTO login(HashMap<String, String> map) {
		MemberDTO dto=dao.login(map);
		return dto;
	}
	
	public MemberDTO myPage(String userid) {
		MemberDTO dto=dao.myPage(userid);
		return dto;
	}
	
	public int memberUpdate(MemberDTO m) {
		int n=dao.memberUpdate(m);
		return n;
	}
}
