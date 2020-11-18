package com.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dto.MemberDTO;
import com.service.MemberService;

@Controller
public class MemberController {
	@Autowired //서비스 자동 주입
	MemberService service;
		
		//회원가입
		@RequestMapping(value = "/memberAdd") 
		public String memberAdd(MemberDTO m,Model model) { //폼에서 넘어온 데이터를 MemberDTO에 자동저장
			service.memberAdd(m); //회원가입 성공
			model.addAttribute("success","회원가입성공"); //main.jsp에서 출력할 success문구 저장
			return "main"; //main.jsp
		}
		
		//마이페이지
		@RequestMapping(value = "/loginCheck/myPage")
		public String myPage(HttpSession session) {
			MemberDTO dto=(MemberDTO)session.getAttribute("login");
			String userid=dto.getUserid();
			service.myPage(userid);
			session.setAttribute("login", dto);
			return "redirect:../myPage";
		}
		
		//아이디 중복체크
		@RequestMapping(value = "/idDuplicateCheck",produces = "text/plain; charset=UTF-8")
		@ResponseBody//비동기 처리
		public String idDuplicateCheck(@RequestParam("id") String userid) {
			MemberDTO dto=service.myPage(userid);
			System.out.println(userid);
			String mesg="아이디 사용가능";
			if(dto!=null) { //기존 id객체가 db에 존재하는 경우
				mesg="아이디 중복";
			}
			return mesg; //메세지전달 리턴페이지가 아님
		}
		
		//마이페이지 수정
		@RequestMapping(value = "/loginCheck/memberUpdate")
		public String memberUpdate(MemberDTO m) {
			System.out.println(m);
			int n=service.memberUpdate(m);
			System.out.println(n);
			return "redirect:../loginCheck/myPage";
		}
		
		
		
		
}
