package com.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.CartDTO;
import com.dto.GoodsDTO;
import com.dto.OrderDTO;

@Repository //자동 빈 생성
public class GoodsDAO {

	@Autowired
	SqlSessionTemplate template;
	 //카테고리에 맞는 리스트 불러오기
	public List<GoodsDTO> goodsList(String gCategory){
		List<GoodsDTO> list=template.selectList("goodsList",gCategory);
		return list;
	}
	//상세페이지
	public GoodsDTO goodsRetrieve(String gCode) {
		GoodsDTO dto=template.selectOne("goodsRetrieve",gCode);
		return dto;
	}
	
	//장바구니 담기
	public int cartAdd(CartDTO dto) {
		int n=template.insert("cartAdd",dto);
		return n;
	}
	
	//카트 목록보기
	public List<CartDTO> cartList(String userid) {
		List<CartDTO> list=template.selectList("cartList",userid);
		return list;
	}
	//장바구니 수량 수정
	public int cartUpdate(HashMap<String, String> map){
		int n=template.update("cartUpdate",map);
		return n;
	}
	//장바구니 삭제
	public int cartDel(int num) {
		int n=template.delete("cartDel",num);
		return n;
	}
	//체크된것 전체삭제
	public int cartAllDel(ArrayList<String> list) {
		int n=template.delete("cartAllDel",list);
		return n;
	}
	//주문확인
	public CartDTO orderConfirmByNum(int num) {
		CartDTO dto=template.selectOne("cartbyNum",num);
		return dto;
	}
	//주문완료
	public void orderDone(OrderDTO dto) {
		int n=template.insert("orderDone",dto);
	}
	
}
