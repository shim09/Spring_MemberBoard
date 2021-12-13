package com.shc.study.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.shc.study.dto.BoardDTO;
import com.shc.study.dto.CommentDTO;
import com.shc.study.dto.PageDTO;
import com.shc.study.service.BoardService;
import com.shc.study.service.CommentService;


@Controller
@RequestMapping(value="/board/*")
public class BoardController {
	
	@Autowired
	private BoardService bs;
	@Autowired
	private CommentService cs;

	
	@RequestMapping(value = "save", method = RequestMethod.GET)
	public String saveForm() {
		return "board/save";
	}
	
	@RequestMapping(value="findAll", method=RequestMethod.GET)
	public String findAll(Model model) {
		List<BoardDTO> bList = bs.findAll();
//		System.out.println(bList);
		model.addAttribute("bList",bList);
		return "board/findAll";
	}
	
	@RequestMapping(value="save",method=RequestMethod.POST)
	public String save(@ModelAttribute BoardDTO board) {
//		System.out.println("C : "+board);
		String result = bs.save(board);
		return result;
	}
	
	@RequestMapping(value="delete",method=RequestMethod.GET)
	public String delete(@RequestParam("b_number") long b_number) {
		String result = bs.delete(b_number);
		return result;
	}
	
	@RequestMapping(value="update",method=RequestMethod.GET)
	public String updateForm(@RequestParam("b_number") long b_number, Model model, @RequestParam(value="page", required=false, defaultValue="1")int page) {
		BoardDTO board = bs.findById(b_number);
		model.addAttribute("board",board);
		model.addAttribute("page", page);
		return "board/update";
	}
	
	@RequestMapping(value="update",method=RequestMethod.POST)
	public String update(@ModelAttribute BoardDTO board, Model model, @RequestParam(value="page", required=false, defaultValue="1")int page) {
		String result = bs.update(board, model, page);
		return result;
	}
	
	
	@RequestMapping(value="paging", method=RequestMethod.GET)
	public String paging(@RequestParam(value="page", required=false, defaultValue="1")int page, Model model) {
		List<BoardDTO> boardList = bs.pagingList(page);
		PageDTO paging = bs.paging(page);
		model.addAttribute("bList", boardList);
		model.addAttribute("paging", paging);
		return "board/findAll";
	}
	@RequestMapping(value="search", method=RequestMethod.GET)
	public String search(@RequestParam("searchtype") String searchtype, @RequestParam("keyword") String keyword, Model model) {
		List<BoardDTO> bList = bs.search(searchtype, keyword);
		model.addAttribute("bList", bList);
		return "board/findAll";
	}
	@RequestMapping(value="detail", method=RequestMethod.GET)
	public String detail(@RequestParam("b_number") long b_number, Model model, @RequestParam(value="page", required=false, defaultValue="1")int page) {
		BoardDTO board = bs.detail(b_number);
		model.addAttribute("board",board);
		model.addAttribute("page",page);
		List<CommentDTO> commentList = cs.findAll(b_number);
		model.addAttribute("commentList",commentList);
		return "board/detail";
	}
}
