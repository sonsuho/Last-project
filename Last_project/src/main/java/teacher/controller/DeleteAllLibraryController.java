package teacher.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import library.model.LibraryBean;
import library.model.LibraryDao;

@Controller
public class DeleteAllLibraryController {
	
	final String command = "/deleteAllLibrary.teacher";
	final String getPage = "redirect:/library.teacher";

	@Autowired
	LibraryDao ldao;
	
	@RequestMapping(command)
	public ModelAndView deleteAll(@RequestParam(value="pageNumber", required = false) String pageNumber,
								  @RequestParam(value="whatColumn", required = false) String whatColumn,
								  @RequestParam(value="keyword", required = false) String keyword,
								  HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("whatColumn", whatColumn);
		mav.addObject("keyword", keyword);
		
		String path = request.getSession().getServletContext().getRealPath("resources");
		String root = path + "\\" + "libraryFiles";
		
		String[] rcheck = request.getParameterValues("rowcheck");
		
		for(String r : rcheck) {
			
			LibraryBean lb = ldao.getLibraryByNum(r);
			
			String[] files = lb.getUpload().split("/");
			
			for(String file : files) {
				
				File deleteFile = new File(root + "\\" + file);
				if(deleteFile.delete()) {
					System.out.println("파일 삭제 성공");
				}else {				
					System.out.println("파일 삭제 실패");
				}
			}
			
			ldao.deleteByNum(r);
		}
		
		mav.setViewName(getPage);
		
		return mav;
	}
}
