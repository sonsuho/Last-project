package teacher.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import lecture.model.LectureDao;
import member.model.MemberBean;
import test.model.TestBean;
import test.model.TestDao;
import test.model.TestResultBean;
import test.model.TestResultDao;

@Controller
public class TestResultController {
   
   final String command = "/testList.teacher";
   final String getPage = "testList";
   
   @Autowired
   TestDao tdao;
   
   @Autowired
   LectureDao ldao;
   
   @Autowired
   TestResultDao trdao;
   
   @RequestMapping(command)
   public ModelAndView testList(HttpSession session) {
      
      ModelAndView mav = new ModelAndView();
      
      MemberBean teacher = (MemberBean)session.getAttribute("loginInfo");
      
      int lec_Num = ldao.getLectureByTeacher(teacher.getMem_num());
      
      List<TestBean> tlist = tdao.getAllTest(String.valueOf(lec_Num));
      
      List<TestResultBean> trlist = trdao.getAllTestResultByLec(String.valueOf(lec_Num));
      
      mav.addObject("tlist", tlist);
      mav.addObject("trlist", trlist);
      
      mav.setViewName(getPage);
      
      return mav;
   }
   
}
