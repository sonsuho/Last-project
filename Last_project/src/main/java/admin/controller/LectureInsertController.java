package admin.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import excel.LectureExcelReader;
import lecture.model.LectureBean;
import lecture.model.LectureDao;
import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class LectureInsertController {

	private final String command = "lectureInsert.admin";
	private final String command2 = "lectureExcelInsert.admin";
	private final String getPage = "lectureInsertForm";
	private final String gotoPage = "redirect:/lectureList.admin";
	
	@Autowired
	LectureDao ldao;
	
	@Autowired
	MemberDao mdao;
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public String lectureInsert(Model model) {
		
		/* 매니저, 강사 목록 가져오기 */
		List<MemberBean> managerList = mdao.getMemberByCate("manager");
		List<MemberBean> teacherList = mdao.getMemberByCate("teacher");
		model.addAttribute("managerList",managerList);
		model.addAttribute("teacherList",teacherList);
		
		return getPage;
	}
	
	@RequestMapping(value=command, method=RequestMethod.POST)
	public String lectureInsert(LectureBean lecture, Model model,
								@RequestParam("lec_name") List<String> lec_name,
								@RequestParam("manager") List<String> manager,
								@RequestParam("teacher") List<String> teacher,
								@RequestParam("lec_start") List<String> lec_start,
								@RequestParam("lec_end") List<String> lec_end,
								@RequestParam("stu_cnt") List<Integer> stu_cnt,
								@RequestParam("class_name") List<String> class_name ) {
		
		/* 매니저, 강사 목록 가져오기 */
		List<MemberBean> managerList = mdao.getMemberByCate("manager");
		List<MemberBean> teacherList = mdao.getMemberByCate("teacher");
		model.addAttribute("managerList",managerList);
		model.addAttribute("teacherList",teacherList);
		
		List<LectureBean> list = new ArrayList<LectureBean>();
        for (int i = 0; i < lec_name.size(); i++) {
        	LectureBean lb = new LectureBean();
            lb.setLec_name(lec_name.get(i));
            lb.setManager(manager.get(i));
            lb.setTeacher(teacher.get(i));
            lb.setLec_start(lec_start.get(i));
            lb.setLec_end(lec_end.get(i));
            lb.setStu_cnt(stu_cnt.get(i));
            lb.setClass_name(class_name.get(i));
            list.add(lb);
        }
        printList(list);
        
		return gotoPage;
	}
	
	@ResponseBody
	@RequestMapping(value=command2, method=RequestMethod.POST)
	public String excelInsert(MultipartHttpServletRequest request, MultipartFile mfile) {
		System.out.println("lectureExcelInsert.admin POST 요청");
		
		MultipartFile excelFile = request.getFile("excelInput");
		if(excelFile==null||excelFile.isEmpty()){
			System.out.println("엑셀파일을 선택해 주세요");
		}
		String filePath = "C:\\upload\\excelUpload\\"+excelFile.getOriginalFilename();
		File destFile = new File(filePath);
		if(!destFile.exists()) {
			//디렉토리 생성
			destFile.mkdirs();
		}
		try {
			excelFile.transferTo(destFile);
		}catch(Exception e) {
			e.printStackTrace();
		}
		LectureExcelReader excelReader = new LectureExcelReader();
		
		String extention = StringUtils.getFilenameExtension(filePath);
		if(extention.equals("xls")) {
			List<LectureBean> list = excelReader.xlsToList(filePath);
			printList(list);
		} else if(extention.equals("xlsx")) {
			List<LectureBean> list = excelReader.xlsxToList(filePath);
			printList(list);
		}
		
		System.out.println("성공!!!!!!!!");
		return gotoPage;
	}
	
	private void printList(List<LectureBean> list) {
		for(LectureBean lb : list) {
			ldao.insertLecture(lb);
		}
	}
	
}
