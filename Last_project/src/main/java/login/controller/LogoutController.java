package login.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LogoutController {
	
    @RequestMapping(value ="/logout.in")
    public String logout(HttpServletRequest request) {
    	
        // 세션 무효화
        request.getSession().invalidate();
        
        // 로그인 페이지로 redirect
        return "redirect:/login.in";
    }
}
