package com.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.GoodsDAO;
import com.dto.CartDTO;
import com.dto.GoodsDTO;
import com.dto.OrderDTO;

@Service
public class GoodsService {
	
	@Autowired
	GoodsDAO dao;
	
	//카테고리에 맞는 리스트 불러오기
	public List<GoodsDTO> goodsList(String gCategory){
		List<GoodsDTO> list=dao.goodsList(gCategory);
		return list;
	}
	
	//상세페이지
	public GoodsDTO GoodsRetrieve(String gCode) {
		GoodsDTO dto=dao.goodsRetrieve(gCode);
		return dto;
	} 
	
	//장바구니 등록
	public int cartAdd(CartDTO dto) {
		int n=dao.cartAdd(dto);
		return n;
	}
	
	//카트목록보기
	public List<CartDTO> cartList(String userid) {
		List<CartDTO> list=dao.cartList(userid);
		return list;
	}
	
	//장바구니 수량 수정
	public int cartUpdate(HashMap<String , String> map) {
		int n=dao.cartUpdate(map);
		return n;
	}
	
	//장바구니 삭제
	public int cartDel(int num) {
		int n=dao.cartDel(num);
		return n;
	}
	//체크된것 전체삭제
	public int cartAllDel(ArrayList<String> list) {
		int n=dao.cartAllDel(list);
		return n;
	}
	//주문확인
	public CartDTO orderConfirmByNum(int num) {
		CartDTO dto=dao.orderConfirmByNum(num);
		return dto;
	}
	//주문완료
	public void orderDone(OrderDTO dto, int orderNum) {
		dao.orderDone(dto);
		dao.cartDel(orderNum);
	}
	
	
}
