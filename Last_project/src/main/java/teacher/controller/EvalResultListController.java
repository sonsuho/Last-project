package teacher.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import evaluation.model.EvaluationBean;
import evaluation.model.EvaluationDao;
import evaluation.model.EvaluationResultBean;
import evaluation.model.EvaluationResultDao;
import lecture.model.LectureDao;
import member.model.MemberBean;

@Controller
public class EvalResultListController {
   
   final String command = "/evalResultList.teacher";
   final String getPage = "evalResultList";
   
   @Autowired
   EvaluationDao edao;
   
   @Autowired
   LectureDao ldao;
   
   @Autowired
   EvaluationResultDao erdao;
   
   @RequestMapping(command)
   public ModelAndView evalResultList(HttpSession session) {
      
      ModelAndView mav = new ModelAndView();
      
      MemberBean teacher = (MemberBean)session.getAttribute("loginInfo");
      
      int lec_Num = ldao.getLectureByTeacher(teacher.getMem_num());
      
      List<EvaluationBean> elist = edao.getAllEvalByLec(String.valueOf(lec_Num));
      
      List<EvaluationResultBean> erlist = erdao.getAllEvalResultByLec(String.valueOf(lec_Num));
      
      mav.addObject("elist", elist);
      mav.addObject("erlist", erlist);
      
      mav.setViewName(getPage);
      
      return mav;
   }
}
