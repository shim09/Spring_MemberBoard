package com.shc.study.dto;
import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BoardDTO {

	//1. �۾��� ��� 
    //1. �۾����� �� �ۼ��ڴ� ���� �Է����� ����. �۾��� ȭ�� ��µǸ� �α��� ���̵� �ۼ��� ĭ�� �ԷµǾ� ����. 
    //2. ����, ����, ÷�������� �Է��� �� ����. 
	
	/*
	 *  2. �Խñ۵�����: �۹�ȣ, ����, �ۼ���, ����, ��ȸ��, �ۼ�����, ÷�����ϸ�
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
