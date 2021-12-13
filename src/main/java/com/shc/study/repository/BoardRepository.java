package com.shc.study.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shc.study.dto.BoardDTO;



@Repository
public class BoardRepository {

	@Autowired
	private SqlSessionTemplate sql;
	
	public int save(BoardDTO board) {
//		System.out.println("R : "+board);
		return sql.insert("Board.insert",board);
	}
	
	public List<BoardDTO> findAll() {
		return sql.selectList("Board.findAll");
	}

	public List<BoardDTO> pagingList1(Map<String, Integer> pagingParam) {
		return sql.selectList("Board.pagingList1", pagingParam);
	}

	public int boardCount() {
		return sql.selectOne("Board.count");
	}

	public List<BoardDTO> search(Map<String, String> searchParam) {
		return sql.selectList("Board.search", searchParam);
	}

	public BoardDTO findById(long b_number) {
		return sql.selectOne("Board.detail",b_number);
	}

	public int update(BoardDTO board) {
		return sql.update("Board.update",board);
	}

	public BoardDTO detail(long b_number) {
		sql.update("Board.hits",b_number);
		BoardDTO board = sql.selectOne("Board.detail",b_number);
		return board;
	}

	public int delete(long b_number) {
		return sql.delete("Board.delete", b_number);
	}
	
}
