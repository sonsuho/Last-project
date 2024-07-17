package admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import lecture.model.LectureDao;

@Controller
public class LectureDeleteController {

	private final String command = "lectureDelete.admin";
	private final String gotoPage = "redirect:/lectureList.admin";
	
	@Autowired
	LectureDao ldao;
	
	// 여러개 선택 삭제
	@RequestMapping(value=command, method=RequestMethod.POST)
	public String idDelete(@RequestParam("rowcheck") int[] rowcheck,
						   @RequestParam(value="pageNumber",required=false) String pageNumber,
						   @RequestParam(value="whatColumn",required=false) String whatColumn,
						   @RequestParam(value="keyword",required=false) String keyword,
						   Model model) {
		
		model.addAttribute("pageNumber",pageNumber);
		model.addAttribute("whatColumn",whatColumn);
		model.addAttribute("keyword",keyword);
		
		for(int lec_num : rowcheck) {			
			int cnt = ldao.deleteLecture(lec_num); 
			if(cnt != -1) {
				// 삭제 성공시 lb.getManager() lb.getTeacher() 에게 각각 lb.getLec_name() 강좌가 취소/삭제? 되었다는 알림 보내주세요!!
				
			}
		}
		
		return gotoPage;
	}
	
}
