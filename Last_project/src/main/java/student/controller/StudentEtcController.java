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
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import member.model.MemberBean;
import student.model.SEtcBean;
import student.model.SEtcDao;

@Controller
//@ComponentScan({"manager", "member"})
public class StudentEtcController {
    private final String command = "/etc.student";
    private final String getPage = "etcForm";
    private final String gotoPage = "studentHome";

    @Autowired
    SEtcDao edao;

    
    
    @RequestMapping(value = command, method = RequestMethod.GET)
    public ModelAndView Studentrequest(HttpSession session) {
        ModelAndView mav = new ModelAndView();
        List<MemberBean> mlist = (List<MemberBean>) session.getAttribute("mlist");

        MemberBean mb = (MemberBean)session.getAttribute("loginInfo");
        
        System.out.println("mb.getMem_num():"+mb.getMem_num());
        int sender_num = mb.getMem_num();
        mav.addObject("sender_num", sender_num);
        mav.addObject("mlist", mlist);
        mav.setViewName(getPage);
        return mav;
    }
    
    @RequestMapping(value = command, method = RequestMethod.POST)
    public ModelAndView Studentrequest(@ModelAttribute("etc") @Valid SEtcBean etc, BindingResult result,
    		@RequestParam String [] selected_mem_num,HttpServletResponse response, HttpSession session,HttpServletRequest request,
                                @RequestParam("multiFile") List<MultipartFile> multiFileList) throws IOException {
        ModelAndView mav = new ModelAndView();

        for(String i : selected_mem_num) {
        	System.out.println("학생넘버:"+i);
        }
        System.out.println("컨트롤러sender_num:"+etc.getSender_num());
        
        
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


        System.out.println("기타 넘버:" + etc.getMem_num());
        int cnt = edao.insert(etc,selected_mem_num);
        if (cnt > 0) {
            PrintWriter pw = response.getWriter();
            response.setContentType("text/html;charset=UTF-8");
            pw.println("<script> alert('보내기 완료');");
            pw.println("location.href='home.student';");
            pw.println("</script>");
            pw.flush();
        } else {
            mav.setViewName(getPage);
        }
        
        mav.setViewName(gotoPage);

        return mav;
    }
}
