package com.shc.study.service;

import java.util.List;

import com.shc.study.dto.CommentDTO;

public interface CommentService {

	void save(CommentDTO comment);

	List<CommentDTO> findAll(long b_number);



}
