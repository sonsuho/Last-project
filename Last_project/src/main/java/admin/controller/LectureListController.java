package admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lecture.model.LectureBean;
import lecture.model.LectureDao;
import utility.Paging;

@Controller
public class LectureListController {

	private final String command = "lectureList.admin";
	private final String getPage = "lectureList";
	
	@Autowired
	LectureDao ldao;
	
	@RequestMapping(command)
	public String lectureList(Model model, HttpServletRequest request,
							  @RequestParam(value="pageNumber", required=false) String pageNumber,
							  @RequestParam(value="whatColumn", required=false) String whatColumn,
							  @RequestParam(value="keyword", required=false) String keyword) {
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%"+keyword+"%");
		
		String url = request.getContextPath()+"/"+command;
		int totalCount = ldao.getTotalLecture(map);
		Paging pageInfo = new Paging(pageNumber,"10",totalCount,url,whatColumn,keyword);
		
		List<LectureBean> lectureList = ldao.getLectureList(pageInfo, map);
		model.addAttribute("lectureList",lectureList);
		model.addAttribute("pageInfo",pageInfo);
		
		return getPage;
	}
	
}
