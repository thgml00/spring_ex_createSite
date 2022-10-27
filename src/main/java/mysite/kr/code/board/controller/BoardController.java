package mysite.kr.code.board.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import lombok.RequiredArgsConstructor;
import mysite.kr.code.board.service.BoardService;
import mysite.kr.code.board.vo.BoardData;
import mysite.kr.code.board.vo.BoardVO;
import mysite.kr.code.common.CommonUtils;

@Controller
@RequiredArgsConstructor
@RequestMapping("/board")
public class BoardController {
	
	private final BoardService boardService;
	
	@GetMapping("/list.do")
	 public ModelAndView boardView()  {
		ModelAndView view = new ModelAndView();
		view.setViewName("board/list");
		return view;
	}
	
	//암호화가 되어있다면 postmapping 사용
	@PostMapping("/list.do")
	@ResponseBody
	public Map<String, Object> getBordData(@RequestParam(name="nowPageNumber") int nowPageNumber) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("nowPageNumber", nowPageNumber);
		return boardService.getBoardList(param);
	}
	
	@GetMapping("/detail.do")
	public ModelAndView getBoardDetail(@RequestParam(name="boardId") int boardId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("boardId", boardId);
		BoardVO vo=boardService.getBoardDetail(param);
		
		ModelAndView view=new ModelAndView();
		view.addObject("board",vo);
		view.setViewName("board/detail");
		
		return view;
	}
	
	@GetMapping("/write.do")
	 public ModelAndView boardWriteView()  {
		ModelAndView view = new ModelAndView();
		view.setViewName("board/write");
		return view;
	}
	
	@PostMapping("/write.do")
	@ResponseBody
	public Map<String, Object> writeBoard(@ModelAttribute BoardData.BoardRequest boardRequest) {
		Map<String, Object> resultMap = new HashMap<>();
		try {
			boardService.writeBoard(boardRequest); //글쓰기
			resultMap.put("resultCode", 200);
		}catch(Exception e) {
			resultMap.put("resultCode", 500);
			e.printStackTrace();
		}
		return resultMap;
	}
	
	@GetMapping("/update.do")
	 public ModelAndView updateboardView(@RequestParam(name="boardId") int boardId) throws Exception  {
		ModelAndView view = new ModelAndView();
		
		Map<String, Object> param = new HashMap<>();
		param.put("boardId", boardId);
		BoardVO vo=boardService.getBoardDetail(param);
		
		view.addObject("board",vo);
		view.setViewName("board/modify");
		return view;
	}
	
	@PostMapping("/update.do")
	@ResponseBody
	public Map<String, Object> updateBoard(@ModelAttribute BoardData.BoardRequest boardRequest) {
		Map<String, Object> resultMap = new HashMap<>();
		try {
			boardService.updateBoard(boardRequest); //글쓰기
			resultMap.put("resultCode", 200);
		}catch(Exception e) {
			resultMap.put("resultCode", 500);
			e.printStackTrace();
		}
		return resultMap;
	}
	
	@GetMapping("/down.do")
	public ModelAndView fileDown(@RequestParam(name="boardId") int boardId) throws Exception{
		ModelAndView view=new ModelAndView();
		
		Map<String, Object> param = new HashMap<>();
		param.put("boardId", boardId);
		BoardVO vo=boardService.getBoardDetail(param);
		
		if(vo.getStoredFileName()!=null && vo.getStoredFileName().length()>0) {
			String path=CommonUtils.uploadPath+vo.getStoredFileName();
			
			File file=new File(path);
			
			view.addObject("downFile",file);
			view.addObject("fileName",vo.getOriginFileName());
			view.setViewName("downloadView");
		}
		
		return view;
	}
	
	@GetMapping("/remove.do")
	@ResponseBody
	public Map<String, Object> removeBoard(@RequestParam(name="boardId") int boardId) throws Exception{
		Map<String, Object> resultMap=new HashMap<>();
		int result=boardService.deleteBoard(boardId);
		
		if(result>0) {
			resultMap.put("resultCode", 200);
		}else {
			resultMap.put("resultCode", 500);
		}
		
		return resultMap;
	}
	
	
}
