package manager.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import manager.model.RequestBean;
import manager.model.RequestDao;
import member.model.MemberBean;

@Controller
public class ManagerVacationController {

	private final String command1 = "/vacationDetail.manager";
	private final String getPage = "vacationDetail";

	@Autowired
	RequestDao rdao;

	@RequestMapping(command1)
	public ModelAndView requestList(
			@RequestParam(value = "mem_num", required = true) String mem_num,
			HttpSession session
			) {
		ModelAndView mav = new ModelAndView();

		MemberBean mb = (MemberBean)session.getAttribute("loginInfo");

		List<RequestBean> lists = rdao.getVacationDetailListsByCategory(mb.getMem_num());

		mav.addObject("vacationLists", lists);
		mav.setViewName(getPage);
		return mav;
	}
}