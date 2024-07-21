package login.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import login.model.LoginBean;
import login.model.LoginDao;
import member.model.MemberBean;
import utility.Sha256;

@Controller
public class LoginController {
	
	final String command = "/login.in";
	final String getPage = "loginForm";
	
	@Autowired
	LoginDao ldao;
	
	@RequestMapping(value=command, method=RequestMethod.GET)		// login.in get 요청 받아서 login폴더의 loginForm.jsp로 넘어간다
	public String loginForm() {
		return getPage;
	}
																	// login.in post 요청 받아서 
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView login(@ModelAttribute(value = "login") @Valid LoginBean lb, BindingResult result, HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		
		if(result.hasErrors()) {									// 누락이 있는지 체크
			
			mav.setViewName(getPage);
			
			return mav;
		}
		
		MemberBean mb = ldao.getInfoById(lb.getId());				// 누락이 없다면 id를 가져와 해당하는 회원 정보가 있는지 체크
		
		/* 패스워드 hash 추가 - 20240703 */
		String encryPassword = Sha256.encrypt(lb.getPw());
		System.out.println(encryPassword);
		
		if(mb == null || !( mb.getPw().equals(encryPassword) ) ) {	// 해당하는 회원 정보가 없거나 ... 비밀번호가 해당 회원 비밀번호와 다른경우
			
			String fail = "fail";
			
			mav.addObject("fail", fail);							// fail 변수를 가지고 다시 loginForm.jsp로 돌아간다
			
			mav.setViewName(getPage);
			
			return mav;
		}
		
		session.setAttribute("loginInfo", mb);						// 모든 문제가 없는 경우 세션으로 회원 정보를 지정한다음 result.jsp로 넘어간다!!!
		
		List<MemberBean> mlist = new ArrayList<MemberBean>();
		List<MemberBean> alist = new ArrayList<MemberBean>();
		if(mb.getCategory().equals("student")) {
			
			mlist  = ldao.getInfoListByCategory("manager");
			
		}else if(mb.getCategory().equals("manager")) {
			
			mlist  = ldao.getInfoListByCategory("student");
			alist  = ldao.getInfoListByCategory("admin");
		}
		
		session.setAttribute("alist", alist);
		session.setAttribute("mlist", mlist);
		
		//System.out.println("세션설정:"+mlist.get(0).getLec_num());
		
		mav.setViewName("result");
		
		return mav;
	}
}
