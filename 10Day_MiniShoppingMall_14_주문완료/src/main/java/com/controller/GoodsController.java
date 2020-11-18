package com.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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
import com.dto.OrderDTO;
import com.service.GoodsService;
import com.service.MemberService;

@Controller
public class GoodsController {
	
	
	  @Autowired 
	  GoodsService service;
	  @Autowired
	 MemberService mservice;
	  //카테고리에 맞는 리스트 불러오기
		@RequestMapping("/GoodsList")
		public ModelAndView goodsList(@RequestParam("gCategory") String gCategory) {
			if(gCategory==null) {
				gCategory="top";
			}
			List<GoodsDTO> list=service.goodsList(gCategory);
			ModelAndView mav=new ModelAndView();
			mav.addObject("goodsList",list);
			mav.setViewName("main");
			return mav;
		}

		//상세 페이지
		@RequestMapping(value = "/goodsRetrieve")  //view페이지
		@ModelAttribute("goodsRetrieve") //key 값
		public GoodsDTO goodsRetrieve(@RequestParam("gCode") String gCode) {
			System.out.println(gCode);
			GoodsDTO dto=service.GoodsRetrieve(gCode);
			return dto;
		}
		
		//장바구니 담기
		@RequestMapping(value = "/loginCheck/cartAdd")
		public String cartAdd(CartDTO dto,HttpSession session) {
			
			MemberDTO mdto=(MemberDTO) session.getAttribute("login");
			String userid=mdto.getUserid();
			dto.setUserid(userid);
			session.setAttribute("mesg", dto.getgCode());
			
			int n=service.cartAdd(dto);
			System.out.println(n);

			return "redirect:../goodsRetrieve?gCode="+dto.getgCode();
		}
		
		//카트목록보기
		@RequestMapping(value = "/loginCheck/cartList")
		public String cartList(RedirectAttributes attr, HttpSession session) {
			
			MemberDTO dto=(MemberDTO)session.getAttribute("login");
			String userid=dto.getUserid();
			
			List<CartDTO> list=service.cartList(userid);
			attr.addFlashAttribute("cartList",list);//리다이렉트 시 데이터 유지
			
			return "redirect:../cartList"; //servlet-context.xml등록
		}
		
		//카트수량 수정
		@RequestMapping(value = "/loginCheck/cartUpdate")
		@ResponseBody
		public void cartUpdate(@RequestParam HashMap<String, String> map) {
			service.cartUpdate(map);
			System.out.println(map);
		}
		
		//카트 삭제
		@RequestMapping(value = "/loginCheck/cartDelete")
		@ResponseBody
		public void cartDel(@RequestParam("num") int num) {
			service.cartDel(num);
			System.out.println(num);
		}
		
		//전체삭제
		@RequestMapping(value = "/loginCheck/delAllCart")
		public String delAllCart(@RequestParam("check") ArrayList<String> list) {
			System.out.println(list);
			service.cartAllDel(list);
			return "redirect:../loginCheck/cartList";
		}
		
		//주문확인
		@RequestMapping(value = "/loginCheck/orderConfirm")
		public String orderConfirm(@RequestParam("num") int num,HttpSession session,RedirectAttributes attr) {
			System.out.println(num);
			MemberDTO mDTO=(MemberDTO)session.getAttribute("login");
			String userid=mDTO.getUserid();
			mDTO=mservice.myPage(userid);
			CartDTO cDTO=service.orderConfirmByNum(num);
			attr.addFlashAttribute("mDTO",mDTO);
			attr.addFlashAttribute("cDTO",cDTO);
		
			return "redirect:../orderConfirm";
		}
		
		//주문 완료
		@RequestMapping(value = "/loginCheck/orderDone")
		public String orderDone(int orderNum,OrderDTO oDTO,RedirectAttributes xxx, HttpSession session) {
			System.out.println(orderNum);
			MemberDTO mdto=(MemberDTO)session.getAttribute("login");
			String userid=mdto.getUserid();
			oDTO.setUserid(userid);
			service.orderDone(oDTO, orderNum);
			xxx.addFlashAttribute("oDTO",oDTO);
			
			return "redirect:../orderDone";
		}
		
}
