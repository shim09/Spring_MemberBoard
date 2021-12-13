package com.shc.study.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.shc.study.dto.BoardDTO;
import com.shc.study.dto.PageDTO;
import com.shc.study.repository.BoardRepository;

@Service
public class BoardService {
	
	@Autowired
	private BoardRepository br;
	
	public String save(BoardDTO board) {
		int result = br.save(board);
		if(result>0) {
			return "redirect:/board/paging";
		} else {
			return "board/save";
		}
	}
	
	public List<BoardDTO> findAll() {
		return br.findAll();
	}

	private static final int PAGE_LIMIT = 5; 
	private static final int BLOCK_LIMIT = 3; 

	
	public List<BoardDTO> pagingList(int page) {
		int pagingStart = (page-1) * PAGE_LIMIT;
		Map<String, Integer> pagingParam = new HashMap<String, Integer>();
		pagingParam.put("start", pagingStart);
		pagingParam.put("limit", PAGE_LIMIT);
		List<BoardDTO> pagingList = br.pagingList1(pagingParam);
		for(BoardDTO b: pagingList) {
			System.out.println(b.toString());
		}
		return pagingList;
	}
	public PageDTO paging(int page) {
		int boardCount = br.boardCount();
		int maxPage = (int)(Math.ceil((double)boardCount / PAGE_LIMIT));
		int startPage = (((int)(Math.ceil((double)page / BLOCK_LIMIT))) - 1) * BLOCK_LIMIT + 1;
		int endPage = startPage + BLOCK_LIMIT - 1;
		if(endPage > maxPage)
			endPage = maxPage; 
		PageDTO paging = new PageDTO();
		paging.setPage(page);
		paging.setStartPage(startPage);
		paging.setEndPage(endPage);
		paging.setMaxPage(maxPage);
		
		System.out.println("paging.toString(): "+ paging.toString());
		
		return paging;
	}
	
	public List<BoardDTO> search(String searchtype, String keyword) {
		Map<String, String> searchParam = new HashMap<String, String>();
		searchParam.put("type", searchtype);
		searchParam.put("word", keyword);
		List<BoardDTO> bList = br.search(searchParam);
		return bList;
	}

	public BoardDTO findById(long b_number) {
		BoardDTO board = br.findById(b_number);
		return board;
	}

	public String update(BoardDTO board, Model model, int page) {
		int result = br.update(board);
		if(result>0) {
			model.addAttribute("board", board);
			return "redirect:/board/detail?b_number="+board.getB_number()+"&page="+page;
		} else {
			return "board/update";
		}
	}

	public BoardDTO detail(long b_number) {
		BoardDTO board = br.detail(b_number);
		return board;
	}

	public String delete(long b_number) {
		int result = br.delete(b_number);
		if(result>0) {
			return "redirect:/board/findAll";
		} else {
			return "board/findAll";			
		}
	}
	

}
