package messenger.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import member.model.MemberBean;
import member.model.MemberDao;
import messenger.model.MessengerBean;
import messenger.model.MessengerDao;

@Controller
@ComponentScan({"messenger,alarm"})
public class MessengerSendController {
	// 메신저 보내기 
	
	private final String command = "/send.messenger";
	private final String getPage = "messengerForm";
	private final String gotoPage = "redirect:/rlist.messenger";
	
	@Autowired
	MessengerDao messengerDao;
	
	@Autowired
	MemberDao memberDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView send() {
		// AdminDao에서 멤버 리스트 가져오기
		
		ModelAndView mav = new ModelAndView();
		
		List<MemberBean> managerlist = memberDao.getMemberByCate("manager");
		List<MemberBean> teacherlist = memberDao.getMemberByCate("teacher");
		List<MemberBean> studentlist = memberDao.getMemberByCate("student");
		mav.addObject("managerlist", managerlist);
		mav.addObject("teacherlist", teacherlist);
		mav.addObject("studentlist", studentlist);
		mav.setViewName(getPage);
		
		return mav;
	}

	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView send(@RequestParam("msg_upload") List<MultipartFile> multiFileList,
							@RequestParam("title") String title,
							@RequestParam("content") String content,
							@RequestParam("rowcheck") int[] num_arr,
						    HttpServletRequest request,
						    HttpSession session){
		System.out.println("content : " + content);
		
		ModelAndView mav = new ModelAndView();
		System.out.println("메신저 여기");
		
		//업로드할 여러개 파일 출력해 확인
		System.out.println("multiFileList : " + multiFileList);
		
		for(int i=0; i<multiFileList.size(); i++) {
			System.out.println("업로드할 파일들 내용: " + multiFileList.get(i).getOriginalFilename());
		}
		
		String path = request.getSession().getServletContext().getRealPath("resources");
		String root = path + "\\" + "messengerFiles";
		
		File fileCheck = new File(root);
		
		if(!fileCheck.exists()) fileCheck.mkdirs();
		
		List<Map<String, String>> fileList = new ArrayList<Map<String, String>>();
		
		String upload = "";
		
		for(int i=0; i<multiFileList.size(); i++) {
			String orginFile = multiFileList.get(i).getOriginalFilename();
			
			upload += orginFile;
			
			if(i != multiFileList.size()-1) {
				upload += "/";
			}
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("originFile", orginFile);
			
			fileList.add(map);
			
		}
		
		System.out.println("DB에 저장할 파일 이름 출력: " + upload);
		
		MessengerBean mb = new MessengerBean();
		
		mb.setMsg_upload(upload);
		mb.setTitle(title);
		mb.setContent(content);
		mb.setMem_num(((MemberBean)session.getAttribute("loginInfo")).getMem_num());
		mb.setSend_name(((MemberBean)session.getAttribute("loginInfo")).getName() );
		
		List<MemberBean> list = memberDao.getMemberByNum(num_arr);
		for(MemberBean i : list) {
			System.out.println(i.getName());
			mb.setRecv_name(i.getName());
			mb.setRecv_num(i.getMem_num());
			messengerDao.insertAllMsg(mb);
		}
					
		
		//파일 업로드
		try {
			for(int i=0; i<multiFileList.size(); i++) {
				File uploadFile = new File(root + "\\" + fileList.get(i).get("originFile"));
				multiFileList.get(i).transferTo(uploadFile);
			}
			System.out.println("다중 파일 업로드 성공");
		} catch (IllegalStateException e) {
			System.out.println("다중 업로드 실패");
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		mav.setViewName(gotoPage);
		
		return mav;
	}
}
