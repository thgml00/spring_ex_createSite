package mysite.kr.code.board.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import mysite.kr.code.board.dao.BoardMapper;
import mysite.kr.code.board.vo.BoardData;
import mysite.kr.code.board.vo.BoardVO;
import mysite.kr.code.common.CommonUtils;
import mysite.kr.code.common.page.PagingVO;

@Service
@RequiredArgsConstructor  // 생성자를 통한 의존성 주입 
public class BoardService {

	private final  BoardMapper mapper;
	
	public Map<String, Object> getBoardList(Map<String,  Object> param) throws Exception{
		
		  //이동할 페이지 
		int nowPageNumber =  (int)param.get("nowPageNumber");
		//전체 게시판 글 개수 
		int totalCount = mapper.totalBoardCount(param);
		
		//결과를 담을 객체 선언 
		Map<String, Object> resultMap = new HashMap<>();
		
		//현재 페이지와 전체 개수를 가지고 계산하는 페이지 객체를 선언
		PagingVO  page = new PagingVO(nowPageNumber, totalCount);
		
		//가져 올 데이터의 범위를 저장 
		param.put("start", page.getBeginPage());
		param.put("end", page.getEndPage());
		
		//한페이지에 보여줄 데이터를 가져옴
		List<BoardVO>  list = mapper.getBoardList(param);
		
		resultMap.put("dataList", list);  //리스트 저장
		resultMap.put("nowPageNumber",  nowPageNumber);  // 이동할 페이지번호
		resultMap.put("pageHtml", page.pageHTML()); // 페이징 html 
		
		return resultMap;
	}
	
	public BoardVO getBoardDetail(Map<String, Object>param) throws Exception{
		//조회수 증가
		mapper.updateBoardCount(param);
		return mapper.getBoardDetail(param);
	}
	
	public void writeBoard(BoardData.BoardRequest boardRequest) throws Exception{
		BoardData.BoardCreate boardCreate= BoardData.BoardCreate
										.builder()
										.boardTitle(boardRequest.getBoardTitle())
										.boardContents(boardRequest.getBoardContents())
										.boardWriter("관리자")
										.build();
		this.uploadFile(boardRequest, boardCreate);
		this.mapper.writeBoard(boardCreate);
		
	}
	
	public void updateBoard(BoardData.BoardRequest boardRequest) throws Exception{
		BoardData.BoardCreate boardCreate= BoardData.BoardCreate
										.builder()
										.boardTitle(boardRequest.getBoardTitle())
										.boardContents(boardRequest.getBoardContents())
										.boardId(boardRequest.getBoardId())
										.build();
		
		Map<String, Object> param = new HashMap<>();
		param.put("boardId",boardRequest.getBoardId());
		//기존 정보 가져오기
		BoardVO vo=this.getBoardDetail(param);
		
		//수정할 데이터에 파일 객체가 존재한다면 기존 파일은 지워야 함
		if(boardRequest.getFile()!=null && !boardRequest.getFile().isEmpty()) {
			String fullPath=CommonUtils.uploadPath+vo.getStoredFileName();
			File file=new File(fullPath);
			//해당경로에 진짜 존재한다면
			if(file.exists()) {
				//지운다
				file.delete();
			}
			this.uploadFile(boardRequest, boardCreate);
		}
		
		this.mapper.updateBoard(boardCreate);
		
	}
	
	/*
	 *파일을 업로드하기
	 *@param boardRequest
	 *@throws Exception
	 */
	public void uploadFile(BoardData.BoardRequest boardRequest, BoardData.BoardCreate boardCreate) throws Exception{
		MultipartFile file=boardRequest.getFile();
		
		//파일 객체가 존재할 경우
		if(file!=null && !file.isEmpty()) {
			String originFileName=file.getOriginalFilename();
			//확장자
			String ext=originFileName.substring(originFileName.lastIndexOf(".")+1);
			//중복되지 않는 이름을 가져온다.
			String randomName=CommonUtils.getUUID();
			
			//저장할 파일 명 만들기
			String storedFileName=randomName+"."+ext;
			//저장할 파일의 전체 경로 만들기
			String fullPath=CommonUtils.uploadPath+storedFileName;
			
			//파일객체 만들기 - 파일을 컨트롤하기 위함
			File newFile=new File(fullPath);
			
			//저장할 경로가 존재하지 않는다면 우선 만듦
			if(!newFile.getParentFile().exists()) {
				//전체 폴더경로를 생성함
				//mkdir()로 한다면 상위 폴더 하나만 만들어지기 때문에 mkdirs() 사용
				newFile.getParentFile().mkdirs();
			}
			
			//기존 파일을 복사할 빈 파일 만들기
			newFile.createNewFile();
			//기존 파일을 생성된 새로운 빈 파일로 복사
			file.transferTo(newFile);
			
			//등록할 파일 이름들을 객체에 저장
			boardCreate.setOriginFileName(originFileName);
			boardCreate.setStoredFileName(storedFileName);
		}
	}
}
