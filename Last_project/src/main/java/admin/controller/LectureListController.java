package admin.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lecture.model.LectureBean;
import lecture.model.LectureDao;
import member.model.MemberBean;
import member.model.MemberDao;
import utility.Paging;

@Controller
public class LectureListController {

	private final String command = "lectureList.admin";
	private final String getPage = "lectureList";
	
	@Autowired
	LectureDao ldao;
	
	@Autowired
	MemberDao mdao;
	
	@RequestMapping(command)
	public String lectureList(HttpServletRequest request,
							  @RequestParam(value="pageNumber", required=false) String pageNumber,
							  @RequestParam(value="whatColumn", required=false) String whatColumn,
							  @RequestParam(value="keyword", required=false) String keyword) {
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%"+keyword+"%");
		System.out.println("whatColumn : " + whatColumn);
		System.out.println("keyword : " + keyword);
		
		String url = request.getContextPath()+"/"+command;
		int totalCount = ldao.getTotalLecture(map);
		Paging pageInfo = new Paging(pageNumber,"10",totalCount,url,whatColumn,keyword,"","");
		
		List<LectureBean> lectureList = ldao.getLectureList(pageInfo, map);
		for (LectureBean lb : lectureList) {
	        lb.setM_name(mdao.getNameByNum(lb.getManager()).getName());
	        lb.setT_name(mdao.getNameByNum(lb.getTeacher()).getName());
		    int stu_cnt = mdao.getStudent(lb.getLec_num());
		    lb.setStudent(stu_cnt);
		    System.out.println("학생수 : " + stu_cnt);
		    System.out.println("기간 : " + lb.getLec_start() + " ~ " + lb.getLec_end());
		}

		Date currentDate = new Date();
		request.setAttribute("currentDate", currentDate);
		request.setAttribute("lectureList", lectureList);
		request.setAttribute("pageInfo", pageInfo);
		
		return getPage;
	}
<<<<<<< HEAD
}
=======
}
>>>>>>> branch 'suho' of https://github.com/sonsuho/Last-project.git
