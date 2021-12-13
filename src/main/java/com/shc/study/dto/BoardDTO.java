package com.shc.study.dto;
import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BoardDTO {

	//1. 글쓰기 기능 
    //1. 글쓰기할 때 작성자는 따로 입력하지 않음. 글쓰기 화면 출력되면 로그인 아이디가 작성자 칸에 입력되어 있음. 
    //2. 제목, 내용, 첨부파일을 입력할 수 있음. 
	
	/*
	 *  2. 게시글데이터: 글번호, 제목, 작성자, 내용, 조회수, 작성일자, 첨부파일명
	 */
	private long b_number;
	private String b_writer;
	private String b_password;
	private String b_title;
	private String b_contents;
	private int b_hits;
	private Timestamp b_date;
	private MultipartFile b_file; 
	private String b_filename;
	
	
	
}
