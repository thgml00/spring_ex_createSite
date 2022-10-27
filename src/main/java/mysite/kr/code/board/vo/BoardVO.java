package mysite.kr.code.board.vo;

import lombok.Getter;
import lombok.Setter;

// data annotation 이 붙으면
//자동으로 getter 와 setter 가 생성된다.
@Getter   // 모든 맴버변수의 getter 를 생성해라
@Setter  // 모든 맴버변수의 setter 를 생성해라 
//@AllArgsConstructor // 모든 맴버변수를 매개변수로 가지는 생성자를 두어라 
//@NoArgsConstructor  // 파라메터 없는 기본생성자를 두어라
// @RequiredArgsConstructor //생성자를 통한 의존성 주입 또는 필수 값들을 생성자 매개변수를 통해서 받는다 
public class BoardVO {

	private int rn;
	private int boardId;
	private String boardTitle;
	private String boardContents;
	private String boardWriter;
	private int boardCount;
	private String originFileName;
	private String storedFileName;
	private String createTime;
	private String updateTime;

	
}
