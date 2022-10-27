package mysite.kr.code.board.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import mysite.kr.code.board.vo.BoardData;
import mysite.kr.code.board.vo.BoardVO;

@Mapper
public interface BoardMapper {

	/**
	 * 게시판 전체 리스트 수 
	 * @param param
	 * @return
	 * @throws SQLException
	 */
	int totalBoardCount(Map<String,  Object> param) throws SQLException;
	
	/**
	 * 한페이지에 보여줄 리스트 목록 
	 * @param param
	 * @return
	 * @throws SQLException
	 */
	List<BoardVO> getBoardList(Map<String,  Object> param) throws SQLException;
	
	/**
	 * 게시판 상세글 보기 
	 * @param param
	 * @return
	 * @throws SQLException
	 */
	BoardVO getBoardDetail(Map<String,  Object> param) throws SQLException;
	
	/**
	 * 게시글 쓰기 
	 * @param param
	 * @return
	 * @throws SQLException
	 */
	int writeBoard(BoardData.BoardCreate boardCreate) throws SQLException;
	
	/**
	 * 조회수 변경 
	 * @param param
	 * @return
	 * @throws SQLException
	 */
	int updateBoardCount(Map<String,  Object> param) throws SQLException;
	
	/**
	 * 게시판 수정 
	 * @param boardCreate
	 * @return
	 * @throws SQLException
	 */
	int updateBoard(BoardData.BoardCreate boardCreate) throws SQLException;
	
	/**
	 * 게시글 삭제 
	 * @param param
	 * @return
	 * @throws SQLException
	 */
	int deleteBoard(Map<String,  Object> param) throws SQLException;
}
