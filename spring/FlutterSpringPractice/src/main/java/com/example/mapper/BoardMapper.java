package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.model.BoardVO;

@Mapper
public interface BoardMapper {
	public void enroll(BoardVO board);

	public List<BoardVO> getList();

	public BoardVO getPage(int bno);

	public int delete(int bno);

	public int modify(BoardVO board);
}
