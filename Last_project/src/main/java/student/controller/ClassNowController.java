package student.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import lecture.model.On_going_lectureBean;
import lecture.model.On_going_lectureDao;
import member.model.MemberBean;

@Controller
public class ClassNowController {
	
	final String command = "/classNow.student";
	final String getPage = "classNow";
	final String gotoPage = "classNowSuccess";
	
	@Autowired
	On_going_lectureDao on_going_lectureDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public ModelAndView classNow(HttpSession session, HttpServletResponse response) {
		
		response.setContentType("text/html;charset=utf-8");
		
		ModelAndView mav = new ModelAndView();
		
		MemberBean student = (MemberBean)session.getAttribute("loginInfo");
		
		On_going_lectureBean lecture = on_going_lectureDao.getLectureByLec(student.getLec_num());
		
		if(lecture.getOnoff().equals("off")) {
			
			try {
				PrintWriter out = response.getWriter();
				
				out.println("<script>");
                out.println("alert('진행중인 수업이 없습니다!!!');");
                out.println("location.href='home.student';"); // 이동할 페이지 설정
                out.println("</script>");
                
                out.flush();
                out.close();
				
                return null;
                
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}else {
			
			mav.addObject("lecture", lecture.getLink());
			
			mav.setViewName(getPage);
		}
		
		return mav;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView NOW(HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("lecture", request.getParameter("lecture"));
		
		mav.setViewName(gotoPage);
		
		return mav;
	}
}