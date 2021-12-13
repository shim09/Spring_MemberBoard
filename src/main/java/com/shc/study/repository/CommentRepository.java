package com.shc.study.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shc.study.dto.CommentDTO;

@Repository
public class CommentRepository {

	@Autowired
	private SqlSessionTemplate sql;

	public void save(CommentDTO comment) {
		sql.insert("Comment.save",comment);
		
	}

	public List<CommentDTO> findAll(long b_number) {
		return sql.selectList("Comment.findAll", b_number);
	}
}
