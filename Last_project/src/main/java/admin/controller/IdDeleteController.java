package admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberDao;

@Controller
public class IdDeleteController {

	private final String command = "idDelete.admin";
	private final String gotoPage = "redirect:/emplList.admin";
	
	@Autowired
	MemberDao mdao;
	
	// 하나씩 선택 삭제
	@RequestMapping(value=command, method=RequestMethod.GET)
	public String idDelete(@RequestParam("mem_num") int mem_num,
						   @RequestParam("pageNumber") String pageNumber,
						   @RequestParam("whatColumn") String whatColumn,
						   @RequestParam("keyword") String keyword) {
		mdao.idDelete(mem_num);
		return gotoPage;
	}
	
	// 여러개 선택 삭제
	@RequestMapping(value=command, method=RequestMethod.POST)
	public String idDelete(@RequestParam("rowcheck") int[] rowcheck,
						   @RequestParam("pageNumber") String pageNumber,
						   @RequestParam("whatColumn") String whatColumn,
						   @RequestParam("keyword") String keyword) {
		for(int mem_num : rowcheck) {			
			mdao.idDelete(mem_num);
		}
		return gotoPage;
	}
	
}
