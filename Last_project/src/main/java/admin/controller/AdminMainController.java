package admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminMainController {

	private final String command = "home.admin";
	private final String getPage = "adminMain";
	
	@RequestMapping(command)
	public String adminMain() {
		return getPage;
	}
	
}
