package com.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dto.CartDTO;
import com.dto.GoodsDTO;
import com.dto.OrderDTO;

@Repository
public class GoodsDAO {
	
	@Autowired
	SqlSessionTemplate template;
	
	//상품 목록
	public List<GoodsDTO> goodsList(String gCategory) {
		return template.selectList("GoodsMapper.goodsList", gCategory);
	}
	
	//상품 상세보기
	public GoodsDTO goodsRetrive(String gCode) {
		return template.selectOne("GoodsMapper.goodsRetrive", gCode);
	}
	
	//장바구니 담기
	public void cartAdd(CartDTO cart) {
		int num = template.insert("CartMapper.cartAdd", cart);
		System.out.println("장바구니 insert : "+num);
	}
	
	//장바구니 목록
	public List<CartDTO> cartList(String userid) {
		return template.selectList("CartMapper.cartList", userid);
	}
	
	//장바구니 수량 수정
	public void cartUpdate(Map<String, String> map) {
		int num = template.update("CartMapper.cartUpdate",map);
		System.out.println("장바구니 수량 update : "+num);
	}
	
	//장바구니 상품 개별 삭제
	public void cartDelete(int num) {
		int Dnum = template.update("CartMapper.cartDelete",num);
		System.out.println("장바구니 수량 개별 delete : "+Dnum);
	}
	
	//장바구니 상품 전체 삭제
	public void delAllCart(ArrayList<String> list) {
		int num = template.update("CartMapper.delAllCart",list);
		System.out.println("장바구니 수량 전체 delete : "+num);
	}
	
	//장바구니 정보 조회
	public CartDTO cartByNum(int num) {
		return template.selectOne("CartMapper.cartByNum", num);
	}

	//주문 완료(주문정보 저장 insert)
	public void orderDone(OrderDTO dto, int orderNum) {
		int num = template.insert("CartMapper.orderDone", dto);
		System.out.println("주문정보 저장 insert : "+num);
	}
	
}