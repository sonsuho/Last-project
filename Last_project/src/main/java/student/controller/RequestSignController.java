package student.controller;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import student.model.SRequestDao;

@Controller
public class RequestSignController {
	
	private final String command = "signSave.student";
	
	@Autowired
	SRequestDao requestDao;
	
	@RequestMapping(command)
	public String sign() {
		
		
		return "save";
	}
	
	
}
