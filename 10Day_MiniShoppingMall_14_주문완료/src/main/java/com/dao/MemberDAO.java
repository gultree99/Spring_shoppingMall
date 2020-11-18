package com.dao;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.MemberDTO;

@Repository //component scan 자동 빈 생성
public class MemberDAO {
	
	@Autowired //template 자동주입
	SqlSessionTemplate template; //(SqlSession과 동일)

	public void memberAdd(MemberDTO m) {
		int n= template.insert("memberAdd",m);
		System.out.println("insert"+n);
	}
	
	public MemberDTO login(HashMap<String, String> map) {
		MemberDTO dto=template.selectOne("login",map);
		return dto;
	}
	
	public MemberDTO myPage(String userid) {
		MemberDTO dto=template.selectOne("mypage",userid);
		return dto;
	}
	
	public int memberUpdate(MemberDTO m) {
		int n=template.update("memberUpdate",m);
		return n;
	}
}
