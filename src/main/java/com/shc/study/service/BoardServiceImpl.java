package com.shc.study.service;

import java.util.List;

import com.shc.study.dto.BoardDTO;

public interface BoardServiceImpl {

	public String save(BoardDTO board);
	
	public List<BoardDTO> findAll();
}
