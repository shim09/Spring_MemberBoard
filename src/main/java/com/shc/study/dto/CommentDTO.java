package com.shc.study.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class CommentDTO {
	
	private long c_number;
	private long b_number;
	private String c_writer;
	private String c_contents;
	private Timestamp c_date;

}
