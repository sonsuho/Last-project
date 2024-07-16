package teacher.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import library.model.LibraryBean;
import library.model.LibraryDao;
import member.model.MemberBean;
import teacher.model.TeacherDao;

@Controller
public class WriteLibraryController {
	
	final String command = "/writeLibrary.teacher";
	final String getPage = "writeLibraryForm";
	final String gotoPage = "redirect:/library.teacher";
	
	@Autowired
	TeacherDao tdao;
	
	@Autowired
	LibraryDao ldao;
	
	@RequestMapping(command)
	public ModelAndView writeForm(@RequestParam(value="pageNumber", required = false) String pageNumber,
								  @RequestParam(value="whatColumn", required = false) String whatColumn,
								  @RequestParam(value="keyword", required = false) String keyword) {
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("whatColumn", whatColumn);
		mav.addObject("keyword", keyword);
		
		mav.setViewName(getPage);
		
		return mav;
	}
	
	@RequestMapping(value=command, method = RequestMethod.POST)
	public ModelAndView write(  @ModelAttribute("library") @Valid LibraryBean lb, BindingResult result,
								@RequestParam(value="pageNumber", required = false) String pageNumber,
								@RequestParam(value="whatColumn", required = false) String whatColumn,
								@RequestParam(value="keyword", required = false) String keyword,
								@RequestParam("multiFile") List<MultipartFile> multiFileList, 
								HttpServletRequest request, HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("whatColumn", whatColumn);
		mav.addObject("keyword", keyword);
		
		if(result.hasErrors()) {
			
			mav.setViewName(getPage);
			
			return mav;
		}
		
		// 업로드할 여러개 파일 출력해 확인
		System.out.println("multiFileList : " + multiFileList);
		for(int i = 0; i < multiFileList.size(); i++) {			
			System.out.println("업로드할 파일들 내용 : " + multiFileList.get(i).getOriginalFilename());
		}
		
		String path = request.getSession().getServletContext().getRealPath("resources");
		String root = path + "\\" + "libraryFiles";
		
		File fileCheck = new File(root);
		
		if(!fileCheck.exists()) fileCheck.mkdirs();
		
		List<Map<String, String>> fileList = new ArrayList<Map<String, String>>();
		
		String upload = "";
		
		for(int i = 0; i < multiFileList.size(); i++) {
			String originFile = multiFileList.get(i).getOriginalFilename();
			
			upload += originFile;
			
			if(i != multiFileList.size()-1) {
				upload += "/";
			}
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("originFile", originFile);
			
			fileList.add(map);
		}
		
		System.out.println("DB에 저장할 파일 이름 출력 : " + upload);
		
		lb.setUpload(upload);
		lb.setLec_num( ( (MemberBean)session.getAttribute("loginInfo") ).getLec_num() );
		lb.setWriter( ( (MemberBean)session.getAttribute("loginInfo") ).getName() );
		lb.setMem_num( ((MemberBean)session.getAttribute("loginInfo") ).getMem_num() );
		
		//DB 테이블에 추가
		ldao.insertLibrary(lb);
		
		// 파일업로드
		try {
			for(int i = 0; i < multiFileList.size(); i++) {
				File uploadFile = new File(root + "\\" + fileList.get(i).get("originFile"));
				multiFileList.get(i).transferTo(uploadFile);
			}
			
			System.out.println("다중 파일 업로드 성공!");
			
		} catch (IllegalStateException e) {
			System.out.println("다중 파일 업로드 실패");
			// 만약 업로드 실패하면 파일 삭제
			for(int i = 0; i < multiFileList.size(); i++) {
				new File(root + "\\" + fileList.get(i).get("originFile")).delete();
			}
			
			e.printStackTrace();
		} catch (IOException e) {
			System.out.println("다중 파일 업로드 실패");
			// 만약 업로드 실패하면 파일 삭제
			for(int i = 0; i < multiFileList.size(); i++) {
				new File(root + "\\" + fileList.get(i).get("originFile")).delete();
			}
			
			e.printStackTrace();
		}
		
		mav.setViewName(gotoPage);
		
		return mav;
	}
	
}
