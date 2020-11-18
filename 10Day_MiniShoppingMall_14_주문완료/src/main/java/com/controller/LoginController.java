package com.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dto.MemberDTO;
import com.service.MemberService;

@Controller
public class LoginController {
	
	@Autowired
	MemberService service;
	
	//로그인
	@RequestMapping(value = "/login")
	public String login(@RequestParam HashMap<String, String> map,Model model,HttpSession session){
		System.out.println(map);
		MemberDTO dto=service.login(map);
		System.out.println(dto);
		String nextPage="";
		if(dto!=null) {
			session.setAttribute("login", dto);
			nextPage="redirect:/GoodsList?gCategory=top"; //로그인시 상품목록 가져오기
		}else {
			model.addAttribute("mesg","가입 정보가 없습니다.");
			nextPage="loginForm";
		}
		return nextPage;
	}
	
	//로그아웃
	@RequestMapping(value = "loginCheck/logout")
	public String logout (HttpSession session) {
		session.invalidate();
		return "redirect:../";
	}
	
	
}
