package com.reservation.ex;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.reservation.dto.BoardDto;
import com.reservation.service.IBoardService;
import com.reservation.vo.BoardVo;

@Controller
public class BoardController {
	@Autowired
	private IBoardService boardService;
	
	@RequestMapping(value="/board/listAll", method=RequestMethod.GET)
	public String listAll(@RequestParam(value="bGroupKind", required = false)String bGroupKind,BoardVo vo,Model model)throws Exception{
		 if(bGroupKind==null) {
			 List<BoardDto> searchList = boardService.listSearchCriteria(vo);
				model.addAttribute("list",searchList);
		    }else {
		    	model.addAttribute("list", boardService.listMenu(bGroupKind));
		    	List<BoardDto> searchList = boardService.listSearchCriteria(vo);
		    	model.addAttribute("list",searchList);
		    }
		    	model.addAttribute("category",boardService.menuKind());
		    	vo.setTotalCount(boardService.listSearchCount(vo));
		return "board/listAll";
	}
	@RequestMapping(value="/board/register", method=RequestMethod.GET)
	public String register(@RequestParam(value="bGroupKind", required = false)String bGroupKind,Model model)throws Exception{
		System.out.println("Register.....");
		model.addAttribute("category",boardService.menuKind());
		return "board/register";
	}
	@RequestMapping(value="/board/register", method=RequestMethod.POST)
	public String register(BoardDto dto,Model model)throws Exception{
		System.out.println("Register.....DB"+dto);
		boardService.create(dto);
		return "redirect:/board/listAll";
	}
	@RequestMapping(value="/board/read", method=RequestMethod.GET)
	public String read(@RequestParam("bId") int bId,Model model)throws Exception{
		System.out.println("read...."+bId);
		BoardDto dto=boardService.read(bId);
		System.out.println("read...."+dto);
		model.addAttribute("boardDto",dto);
		boardService.bHitUpdate(bId);
		return "board/read";
	}
	@RequestMapping(value="/board/like", method=RequestMethod.GET)
	public String like(@RequestParam("bId") int bId,Model model,RedirectAttributes rttr)throws Exception{
		System.out.println("like...."+bId);
		boardService.bLike(bId);
		rttr.addFlashAttribute("msg","like");
		return "redirect:/board/listAll";
	}
	@RequestMapping(value="/board/dislike", method=RequestMethod.GET)
	public String dislike(@RequestParam("bId") int bId,Model model,RedirectAttributes rttr)throws Exception{
		System.out.println("dislike...."+bId);
		boardService.bDislike(bId);
		rttr.addFlashAttribute("msg","disike");
		return "redirect:/board/listAll";
	}
	@RequestMapping(value="/board/modify", method=RequestMethod.GET)
	public String modify(@RequestParam("bId") int bId,Model model)throws Exception{
		System.out.println("moidfy...."+bId);
		BoardDto dto =boardService.read(bId);
		model.addAttribute("boardDto",dto);
		return "/board/modify";
	}
	@RequestMapping(value="/board/modify", method=RequestMethod.POST)
	public String modifyDB(BoardDto dto,Model model)throws Exception{
		System.out.println("modify....DB..."+dto);
		boardService.update(dto);
		return "redirect:/board/listAll";
	}
	@RequestMapping(value="/board/remove", method=RequestMethod.GET)
	public String delete(int bId,Model model)throws Exception{
		System.out.println("delete....."+bId);
		boardService.delete(bId);
		return "redirect:/board/listAll";
	}
	
	
	@RequestMapping(value = "board/reply", method = RequestMethod.GET)
	public String replyGet(@RequestParam("bId") int bId, Model model) throws Exception {
		System.out.println("reply....."+bId);
		model.addAttribute(boardService.read(bId));
		BoardDto dto=boardService.read(bId);
		System.out.println(dto);
		return"/board/register_reply";
	}
	
	@RequestMapping(value="board/reply", method=RequestMethod.POST)
	public String replyPost(@RequestParam("bId") int bId, Model model,BoardDto dto, RedirectAttributes rttr) throws Exception {		
		System.out.println("reply....."+dto);
		boardService.updateReply(dto);
		boardService.reply(dto); // 답글 작성
	    
	    return "redirect:/board/listAll";
	}
}
