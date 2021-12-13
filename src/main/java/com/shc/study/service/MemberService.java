package com.shc.study.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.shc.study.dto.MemberDTO;
import com.shc.study.repository.MemberRepository;

@Service

public class MemberService {

	@Autowired
	private MemberRepository mr;
	@Autowired
	private HttpSession session;
	
	public int insert(MemberDTO member) throws IllegalStateException, IOException {
		MultipartFile m_file = member.getM_file();
		String m_filename = m_file.getOriginalFilename();
		m_filename = System.currentTimeMillis() + "-" + m_filename;
		System.out.println("m_filename: " + m_filename);
		String savePath = "C:\\Users\\Shim\\Desktop\\shim\\development.shc\\source\\spring\\MemberBoard\\src\\main\\webapp\\resources\\upload\\"+m_filename;
		if(!m_file.isEmpty()) {
			m_file.transferTo(new File(savePath)); 
		}
		member.setM_filename(m_filename);
		
		int result = mr.insert(member);
		return result;
	}
	// �α��� �� id�� pw���� �´��� Ȯ�� �� Ʋ����� �ʱ��������� ����, ������� �α�����������
	public String login(MemberDTO check) {
		MemberDTO loginMember = mr.login(check);
		if(loginMember != null){
			if(loginMember.getM_id().equals("SHC")) {
				session.setAttribute("loginId", check.getM_id());
				session.setAttribute("loginNumber",loginMember.getM_number());
				return "member/main";
		}
			session.setAttribute("loginId", check.getM_id());
			session.setAttribute("loginNumber",loginMember.getM_number());
			return "redirect:/board/paging";
		}else {
			// �ᱹ �α��θ���� null�� ������� index�� �Ѿ�� �ƴҰ�� �ٽ� �α��� �������� �̵�.
		}
		return "member/login";
	}
	public List<MemberDTO> findAll() {
		List<MemberDTO>mList =mr.findAll();
		return mList;
	}
	public void delete(long m_number) {
		mr.delete(m_number);
		
	}
	public String idDuplicate(String m_id) {
		String result = mr.idDuplicate(m_id);
		if(result == null) {
			return "ok";
		}else {
			return "no";
		}
	}
	public MemberDTO mypage(long m_number) {
		return mr.mypage(m_number);
	}
	public String update(MemberDTO member) throws IllegalStateException, IOException {
		System.out.println(member);
		MultipartFile m_file = member.getM_file();
		String m_filename = m_file.getOriginalFilename();
		m_filename = System.currentTimeMillis() + "-" + m_filename;
		System.out.println("m_filename: " + m_filename);
		String savePath = "C:\\Users\\Shim\\Desktop\\shim\\development.shc\\source\\spring\\MemberBoard\\src\\main\\webapp\\resources\\upload\\"+m_filename;
		if(!m_file.isEmpty()) {
			m_file.transferTo(new File(savePath)); 
		}
		member.setM_filename(m_filename);
		
		int result = mr.updateFile(member);
		if(result>0) {
			return "redirect:/board/paging";			
		} else {
			return "member/update";
		}
	}
	public MemberDTO findById(long m_number) {
		MemberDTO m = mr.findById(m_number);
		return m;
	}

	
}
