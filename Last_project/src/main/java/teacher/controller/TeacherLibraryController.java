package teacher.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import library.model.LibraryBean;
import library.model.LibraryDao;
import member.model.MemberBean;
import teacher.model.TeacherDao;
import utility.Paging;

@Controller
public class TeacherLibraryController {							// library.jsp로 넘어간다
	
	final String command = "/library.teacher";
	final String getPage = "library";
	
	@Autowired
	TeacherDao tdao;
	
	@Autowired
	LibraryDao ldao;
	
	@RequestMapping(command)
	public ModelAndView libraryList(@RequestParam(value = "whatColumn", required = false) String whatColumn
								   ,@RequestParam(value = "keyword", required = false) String keyword
								   ,@RequestParam(value = "pageNumber", required = false) String pageNumber
								   ,HttpServletRequest request, HttpSession session) {
		
		String lec_num = ((MemberBean)session.getAttribute("loginInfo")).getLec_num();
		
		System.out.println("강좌 번호 : " + lec_num);
		
		ModelAndView mav = new ModelAndView();
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%" + keyword + "%");
		map.put("pageNumber", pageNumber);
		map.put("lec_num", lec_num);
		                            
		int totalCount = ldao.getTotalCount(map);
		
		String url = request.getContextPath() + this.command;
		
		Paging pageInfo = new Paging(pageNumber, null, totalCount, url, whatColumn, keyword,"","");
		
		List<LibraryBean> list = ldao.getLibraryList(pageInfo, map);
		
		mav.addObject("totalCount", totalCount);
		mav.addObject("list", list);
		mav.addObject("pageInfo", pageInfo);
		
		mav.setViewName(getPage);
		
		return mav;
			
	}
}