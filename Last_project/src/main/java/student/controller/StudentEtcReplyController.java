package student.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import manager.model.EtcBean;
import manager.model.EtcDao;
import member.model.MemberBean;
import member.model.MemberDao;

@Controller
@ComponentScan({"manager", "member","student"})
public class StudentEtcReplyController {
	private final String command="/replyEtc.student";
	private final String getPage="replyEtcForm";
	private final String gotoPage="studentHome";

	@Autowired
	EtcDao edao;

	@Autowired
	MemberDao mdao;

	@RequestMapping(value = command , method = RequestMethod.GET)
	public ModelAndView rply(@RequestParam int etc_num,@RequestParam int mem_num,@RequestParam int sender_num) {
		ModelAndView mav = new ModelAndView();


		MemberBean mb = mdao.getNameByNum(mem_num);//받는사람정보 가져오기
		
		EtcBean eb = edao.getEtcByNum(etc_num);
		
		

		mav.addObject("eb",eb);
		mav.addObject("mb",mb);
		mav.addObject("sender_num",sender_num);
		mav.setViewName(getPage);

		return mav;

	}

	@RequestMapping(value = command , method = RequestMethod.POST)
	public ModelAndView rplyform(@ModelAttribute("etc") @Valid EtcBean etc, BindingResult result,
			HttpServletResponse response, HttpSession session,HttpServletRequest request,
			@RequestParam("multiFile") List<MultipartFile> multiFileList) throws IOException {
		ModelAndView mav = new ModelAndView();

		if (result.hasErrors()) {
			System.out.println("오류");
			mav.addObject("sender_num",etc.getSender_num());
			mav.setViewName(getPage);
			return mav;
		}

		// 업로드할 여러개 파일 출력해 확인
		System.out.println("multiFileList : " + multiFileList);
		for(int i = 0; i < multiFileList.size(); i++) {			
			System.out.println("업로드할 파일들 내용 : " + multiFileList.get(i).getOriginalFilename());
		}

		String path = request.getSession().getServletContext().getRealPath("resources");
		String root = path + "\\" + "files";

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

		etc.setEtc_file(upload);

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


		System.out.println("보내는 회원넘버:" + etc.getMem_num());
		int cnt = edao.insertReply(etc);
		if (cnt > 0) {
			PrintWriter pw = response.getWriter();
			response.setContentType("text/html;charset=UTF-8");
			pw.println("<script> alert('회신 완료');");
			pw.println("location.href='home.manager';");
			pw.println("</script>");
			pw.flush();
		} else {
			mav.setViewName(getPage);
		}

		mav.setViewName(gotoPage);

		return mav;

	}


}
