package student.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import student.model.SRequestBean;
import member.model.MemberBean;
import student.model.SRequestDao;

@Controller
public class StudentVacationDetailController {

	private final String command1 = "/vacationDetail.student";
	private final String getPage = "vacationDetail";

	@Autowired
	SRequestDao studnetRequestDao;

	@RequestMapping(command1)
	public ModelAndView requestList(
			@RequestParam(value = "mem_num", required = true) String mem_num,
			HttpSession session
			) {
		ModelAndView mav = new ModelAndView();

		MemberBean mb = (MemberBean)session.getAttribute("loginInfo");

		List<SRequestBean> lists = studnetRequestDao.getVacationDetailListsByCategory(mb.getMem_num());

		mav.addObject("vacationLists", lists);
		mav.setViewName(getPage);
		return mav;
	}
}