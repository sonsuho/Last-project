package manager.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import excel.StuExcelReader;
import member.model.MemberBean;
import member.model.MemberDao;
import utility.Sha256;

@Controller
public class ManagerStuInsertController {

	private final String command = "stuInsert.manager";
	private final String command2 = "excelInsert.manager";
	private final String getPage = "stuInsertForm";
	private final String gotoPage = "redirect:/lectureList.manager";
	
	@Autowired
	MemberDao mdao;
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public String insert(@RequestParam("lec_num") String lec_num) {
		return getPage;
	}
	
	@RequestMapping(value=command, method=RequestMethod.POST)
	public String insert(	@RequestParam("name") List<String> name,
				            @RequestParam("id") List<String> id,
				            @RequestParam("pw") List<String> pw,
				            @RequestParam("phone") List<String> phone,
				            @RequestParam("email") List<String> email,
				            @RequestParam("lec_num") String lec_num) {
		
		List<MemberBean> list = new ArrayList<MemberBean>();
		for (int i = 0; i < name.size(); i++) {
            MemberBean mb = new MemberBean();
            mb.setName(name.get(i));
            mb.setId(id.get(i));
            mb.setPw(pw.get(i));
            mb.setCategory("student");
            mb.setPhone(phone.get(i));
            mb.setEmail(email.get(i));
            list.add(mb);
        }
        printList(list, lec_num);
        
		return gotoPage;
	}
	
	@ResponseBody
	@RequestMapping(value=command2, method=RequestMethod.POST)
	public String excelInsert(MultipartHttpServletRequest request, MultipartFile mfile,
							  @RequestParam("lec_num") String lec_num) {
		System.out.println("excelInsert.manager POST 요청 lec_num : " + lec_num);
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
		StuExcelReader excelReader = new StuExcelReader();
		
		String extention = StringUtils.getFilenameExtension(filePath);
		if(extention.equals("xlsx")) {
			List<MemberBean> list = excelReader.xlsxToList(filePath);
			printList(list, lec_num);
		}
		
		System.out.println("성공!!!!!!!!");
		return gotoPage;
	}

	
	private void printList(List<MemberBean> list, String lec_num) {
		for(MemberBean mb : list) {
			mb.setLec_num(lec_num); 
			mb.setState("진행");
			String pw = mb.getPw();
			String encryPassword = Sha256.encrypt(pw);
			mb.setPw(encryPassword);
			System.out.println("해시전 PW : " + pw);
            System.out.println("해시후 PW : " + mb.getPw());
			mdao.idInsert(mb);
		}
	}
	
}
