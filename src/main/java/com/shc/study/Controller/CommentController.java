package com.shc.study.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shc.study.dto.CommentDTO;
import com.shc.study.service.CommentService;

@Controller
@RequestMapping("/comment/*")
public class CommentController {
	
	@Autowired
	private CommentService cs;

	@RequestMapping(value="save", method=RequestMethod.POST)
	public @ResponseBody List<CommentDTO> save(@ModelAttribute CommentDTO comment){
		
		cs.save(comment);
		List<CommentDTO> commentList = cs.findAll(comment.getB_number());
		System.out.println(comment);
		return commentList;
		
		
	}
}
