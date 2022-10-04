package com.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.GoodsDAO;
import com.dto.CartDTO;
import com.dto.GoodsDTO;
import com.dto.OrderDTO;

@Service
public class GoodsService {
	
	@Autowired
	GoodsDAO dao;
	
	//상품 목록
	public List<GoodsDTO> goodsList(String gCategory) {
		return dao.goodsList(gCategory);
	}
	
	//상품 상세보기
	public GoodsDTO goodsRetrive(String gCode) {
		return dao.goodsRetrive(gCode);
	}
	
	//장바구니 담기
	public void cartAdd(CartDTO cart) {
		dao.cartAdd(cart);
	}
	
	//장바구니 목록
	public List<CartDTO> cartList(String userid) {
		return dao.cartList(userid);
	}
	
	//장바구니 수량 수정
	public void cartUpdate(Map<String, String> map) {
		dao.cartUpdate(map);
	}
	
	//장바구니 상품 개별 삭제
	public void cartDelete(int num) {
		dao.cartDelete(num);
	}
	
	//장바구니 상품 전체 삭제
	public void delAllCart(ArrayList<String> list) {
		dao.delAllCart(list);
	}
	
	//장바구니 정보 조회
	public CartDTO cartByNum(int num) {
		return dao.cartByNum(num);
	}
	
	//주문 완료(insert+delete : 2가지 작업을 tx 처리함->root.context.xml에 txManager 등록 필요)
	@Transactional
	public void orderDone(OrderDTO dto, int orderNum) {
		//주문 추가 : 주문정보 저장 insert
		dao.orderDone(dto, orderNum);
		//장바구니 삭제 
		dao.cartDelete(orderNum);
	}
	
}