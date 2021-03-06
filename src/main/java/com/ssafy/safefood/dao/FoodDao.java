package com.ssafy.safefood.dao;

import java.util.List;

import com.ssafy.safefood.vo.FoodVO;

public interface FoodDao {
	List<FoodVO> selectAll() throws Exception;
	List<FoodVO> selectByFoodName(String name) throws Exception;
	List<FoodVO> selectByFoodMaker(String maker) throws Exception;
	List<FoodVO> selectByFoodMaterial(String material) throws Exception;
	FoodVO selectByFoodCode(String code) throws Exception;
	void insertFood(FoodVO vo) throws Exception;
	void updateFood(FoodVO vo) throws Exception;
	void deleteFood(int code) throws Exception;
}
