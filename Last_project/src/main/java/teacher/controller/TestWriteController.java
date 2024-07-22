package teacher.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import alarm.model.AlarmService;
import member.model.MemberBean;
import student.model.StudentDao;
import test.model.TestBean;
import test.model.TestDao;

@Controller
public class TestWriteController {
	
	final String command = "/testWrite.teacher";
	final String command2 = "/testWrite2.teacher";
	final String getPage = "testWriteForm";
	final String gotoPage1 = "WriteForm";
	final String gotoPage2 = "testWriteSuccess";
	
	@Autowired
	TestDao testDao;
	
	@Autowired
	AlarmService service;
	
	@Autowired
	StudentDao sdao;
	
	@RequestMapping(value = command,  method = RequestMethod.GET)
	public String writeForm() {
		return getPage;
	}
	
	@RequestMapping(value = command2, method = RequestMethod.POST)
    public ModelAndView form(@RequestParam(value = "test_name", required = false) String test_name,
    						 @RequestParam(value = "problem", required = false) String problem,
                             @RequestParam(value = "answer", required = false) String answer,
                             @RequestParam(value = "image", required = false) MultipartFile image,
                             @RequestParam(value = "opt1", required = false) String opt1,
                             @RequestParam(value = "opt2", required = false) String opt2,
                             @RequestParam(value = "opt3", required = false) String opt3,
                             @RequestParam(value = "opt4", required = false) String opt4,
                             @RequestParam(value = "opt5", required = false) String opt5,
                             @RequestParam(value = "problems", required = false) String problems,
                             @RequestParam(value = "answers", required = false) String answers,
				             @RequestParam(value = "images", required = false) String images,
				             @RequestParam(value = "choice", required = false) String choice,
                             @RequestParam(value = "index", required = false, defaultValue = "0") int index,
                             HttpServletRequest request) {

        if (problems == null) {
            problems = "";
        }
        if (answers == null) {
            answers = "";
        }
        if (images == null) {
        	images = "";
        }
        problems += (problem != null ? problem + "/" : "");
        answers += (answer != null ? answer + "/" : "");
        
        String opt;
        
        if(choice == null) {
        	choice = "";
        	opt = "";
        }else {
        	opt = opt1 + "-" + opt2 + "-" + opt3 + "-" + opt4 + "-" + opt5;
        	
        	choice += opt + "/";
        }
        

        
        String path = request.getSession().getServletContext().getRealPath("resources");
        String root = path + File.separator + "testFiles";
        File dir = new File(root);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        String imageName = null;
        if (image != null && !image.isEmpty()) {
            imageName = image.getOriginalFilename();
            File serverFile = new File(root + File.separator + imageName);
            try {
				image.transferTo(serverFile);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
            images += imageName + "/";
        }
        
        ModelAndView mav = new ModelAndView();
        mav.addObject("problems", problems);
        mav.addObject("answers", answers);
        mav.addObject("images", images);
        mav.addObject("choice", choice);
        mav.addObject("index", index + 1);
        mav.addObject("test_name", test_name);

        if (index >= 5) {
            mav.setViewName(command);
        } else {
            mav.setViewName(gotoPage1);
        }
        
        
		//민곤 알림 추가
        return mav;
    }
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView writeTest(@RequestParam(value = "problem", required = false) String problem,
					              @RequestParam(value = "answer", required = false) String answer,
					              @RequestParam(value = "image", required = false) MultipartFile image,
		                          @RequestParam(value = "opt1", required = false) String opt1,
		                          @RequestParam(value = "opt2", required = false) String opt2,
		                          @RequestParam(value = "opt3", required = false) String opt3,
		                          @RequestParam(value = "opt4", required = false) String opt4,
		                          @RequestParam(value = "opt5", required = false) String opt5,
					              @RequestParam(value = "problems", required = false) String problems,
					              @RequestParam(value = "answers", required = false) String answers,
					              @RequestParam(value = "images", required = false) String images,
					              @RequestParam(value = "choice", required = false) String choice,
					              @RequestParam(value = "test_name", required = false) String test_name,
					              HttpSession session, HttpServletRequest request, Map<String, String> paramap) {
		
		ModelAndView mav = new ModelAndView();
		
		MemberBean teacher = (MemberBean)session.getAttribute("loginInfo");
		
		String lec_Num = teacher.getLec_num();
		
		String test_questions = problems + problem;
		String test_answer = answers + answer;
		
		String test_opt = choice + opt1 + "-" + opt2 + "-" + opt3 + "-" + opt4 + "-" + opt5;
		
		String path = request.getSession().getServletContext().getRealPath("resources");
        String root = path + File.separator + "testFiles";
        File dir = new File(root);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        String imageName = null;
        if (!image.isEmpty()) {
            imageName = image.getOriginalFilename();
            File serverFile = new File(root + File.separator + imageName);
            try {
				image.transferTo(serverFile);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
            images += imageName;
        }
		
		String test_img = images;
		
		TestBean tb = new TestBean();
		
		tb.setLec_num(Integer.parseInt(lec_Num));
		tb.setTest_name(test_name);
		tb.setTest_questions(test_questions);
		tb.setTest_answer(test_answer);
		tb.setTest_img(test_img);
		tb.setTest_opt(test_opt);
		tb.setQuestions_point("20/20/20/20/20");
		
		testDao.insertTest(tb);
		
		//민곤 알림 추가
				
				List<MemberBean> slist = sdao.getStudentByLec_Num(lec_Num);	
		        StringBuilder stdList = new StringBuilder();
				for (MemberBean mb : slist) {
				    if (stdList.length() > 0) {
				        stdList.append(",");
				    }
				    stdList.append(mb.getMem_num());
				}
				System.out.println("stdList.toString():"+stdList.toString());
				paramap.put("fk_recipientno", stdList.toString()); // 받는사람 (여러명일때는 ,,으로 구분된 str)
				paramap.put("url", "/testList" );
				paramap.put("url2", ".student");
				paramap.put("alarm_content", teacher.getName() + "님이 시험을 시작했습니다." );
				paramap.put("alarm_type", "8" );
				
				service.addAlarm(paramap);
		
		mav.setViewName(gotoPage2);
		
		return mav;
	}
}
