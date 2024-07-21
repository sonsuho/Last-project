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
import utility.Paging;

@Controller
public class ContentLibraryController {
	
	final String command = "/contentLibrary.teacher";
	final String getPage = "contentLibrary";
	
	@Autowired
	LibraryDao ldao;
	
	@RequestMapping(command)
	public ModelAndView writeForm(@RequestParam(value="pageNumber", required = false) String pageNumber,
								  @RequestParam(value="whatColumn", required = false) String whatColumn,
								  @RequestParam(value="keyword", required = false) String keyword,
								  @RequestParam(value="li_num") String li_num, HttpSession session, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView();
		
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("whatColumn", whatColumn);
		mav.addObject("keyword", keyword);
		
		LibraryBean library = ldao.getLibraryByNum(li_num);
		
		mav.addObject("library", library);
		
		String[] uploadList = library.getUpload().split("/");
		
		mav.addObject("uploadList", uploadList);
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%" + keyword + "%");
		map.put("pageNumber", pageNumber);
		map.put("lec_num", ( (MemberBean)session.getAttribute("loginInfo") ).getLec_num());
		
		int totalCount = ldao.getTotalCount(map);
		
		String url = request.getContextPath() + this.command;
		
		Paging pageInfo = new Paging(pageNumber, null, totalCount, url, whatColumn, keyword,"","");
		
		List<LibraryBean> list = ldao.getLibraryList(pageInfo, map);
		
		mav.addObject("list", list);
		
		mav.setViewName(getPage);
		
		return mav;
	}
}
