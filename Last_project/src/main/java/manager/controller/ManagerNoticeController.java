package manager.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import manager.model.ManagerDao;
import manager.model.NoticeBean;
import manager.model.NoticeDao;
import member.model.MemberBean;
import utility.Paging;

@Controller
public class ManagerNoticeController {

	final String getCommand = "/notice.manager";
	final String getPage = "noticeForm";
	
	private final String detailCommand = "/noticeDetail.manager";
	private final String insertCommand = "/noticeInsert.manager";
	private final String updateCommand = "/noticeUpdate.manager";
	private final String deleteCommand = "/noticeDelete.manager";
	private final String deleteAllCommand = "/deleteAllNotice.manager";
	
	private final String detailPage = "noticeDetailForm";
	private final String insertPage = "noticeInsertForm";
	private final String updatePage = "noticeUpdateForm";
	
	private final String gotoPage = "redirect:/notice.manager";	
	
	@Autowired
	ManagerDao mdao;
	
	@Autowired
	NoticeDao ndao;
	
	@RequestMapping(value=getCommand, method = RequestMethod.GET)
	public ModelAndView noticeList(
			@RequestParam(value = "whatColumn", required = false) String whatColumn,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "pageNumber", required = false) String pageNumber,
			HttpServletRequest request,
			HttpSession session
			) {

		String lec_num = ((MemberBean)session.getAttribute("loginInfo")).getLec_num();
		
		System.out.println("강좌 번호 : " + lec_num);
		
		ModelAndView mav = new ModelAndView();
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%" + keyword + "%");
		map.put("pageNumber", pageNumber);
		                            
		int totalCount = ndao.getTotalCount(map);
		
		String url = request.getContextPath() + this.getCommand;
		
		Paging pageInfo = new Paging(pageNumber, null, totalCount, url, whatColumn, keyword);
		
		List<NoticeBean> noticeList = ndao.getNoticeList(pageInfo, map);
		
		mav.addObject("totalCount", totalCount);
		mav.addObject("noticeList", noticeList);
		mav.addObject("pageInfo", pageInfo);
		
		mav.setViewName(getPage);
		
		return mav;
	}
	
	@RequestMapping(insertCommand)
	public ModelAndView writeForm(
			@RequestParam(value="pageNumber", required = false) String pageNumber,
			@RequestParam(value="whatColumn", required = false) String whatColumn,
			@RequestParam(value="keyword", required = false) String keyword
			) {

		ModelAndView mav = new ModelAndView();

		mav.addObject("pageNumber", pageNumber);
		mav.addObject("whatColumn", whatColumn);
		mav.addObject("keyword", keyword);

		mav.setViewName(insertPage);

		return mav;
	}

	@RequestMapping(value=insertCommand, method = RequestMethod.POST)
	public ModelAndView write(  
			@ModelAttribute("notice") @Valid NoticeBean nb, BindingResult result,
			@RequestParam(value="pageNumber", required = false) String pageNumber,
			@RequestParam(value="whatColumn", required = false) String whatColumn,
			@RequestParam(value="keyword", required = false) String keyword,
			HttpServletRequest request, HttpSession session) {

		ModelAndView mav = new ModelAndView();

		mav.addObject("pageNumber", pageNumber);
		mav.addObject("whatColumn", whatColumn);
		mav.addObject("keyword", keyword);

		if(result.hasErrors()) {
			mav.setViewName(insertPage);
			return mav;
		}

		nb.setLec_num( ( (MemberBean)session.getAttribute("loginInfo") ).getLec_num() );
		nb.setWriter( ( (MemberBean)session.getAttribute("loginInfo") ).getName() );
		nb.setMem_num( ((MemberBean)session.getAttribute("loginInfo") ).getMem_num() );

		//DB 테이블에 추가
		ndao.insertNotice(nb);

		mav.setViewName(gotoPage);

		return mav;
	}
	
	@RequestMapping(detailCommand)
	public ModelAndView detailForm(
			@RequestParam(value="pageNumber", required = false) String pageNumber,
			@RequestParam(value="whatColumn", required = false) String whatColumn,
			@RequestParam(value="keyword", required = false) String keyword,
			@RequestParam(value="n_num", required = false) String n_num, 
			HttpSession session, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView();
		
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("whatColumn", whatColumn);
		mav.addObject("keyword", keyword);
		
		if(n_num == null) {
			Map<String, String> map = new HashMap<String, String>();
			
			map.put("whatColumn", whatColumn);
			map.put("keyword", "%" + keyword + "%");
			map.put("pageNumber", pageNumber);
			
			int totalCount = ndao.getTotalCount(map);
			
			String url = request.getContextPath() + this.detailCommand;
			
			Paging pageInfo = new Paging(pageNumber, null, totalCount, url, whatColumn, keyword);
			
			List<NoticeBean> list = ndao.getNoticeList(pageInfo, map);
			
			mav.addObject("noticeList", list);
			mav.addObject("pageInfo", pageInfo);
			
			mav.setViewName(getPage);
			return mav;
		}
		
		NoticeBean notice = ndao.getNoticeByN_num(n_num);
		
		mav.addObject("notice", notice);
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%" + keyword + "%");
		map.put("pageNumber", pageNumber);
		
		int totalCount = ndao.getTotalCount(map);
		
		String url = request.getContextPath() + this.detailCommand;
		
		Paging pageInfo = new Paging(pageNumber, null, totalCount, url, whatColumn, keyword);
		
		List<NoticeBean> list = ndao.getNoticeList(pageInfo, map);
		
		mav.addObject("noticeList", list);
		mav.addObject("pageInfo", pageInfo);
		
		mav.setViewName(detailPage);
		
		return mav;
	}
	
	
	
	@RequestMapping(updateCommand)
	public ModelAndView updateForm(@RequestParam(value="pageNumber", required = false) String pageNumber,
								   @RequestParam(value="whatColumn", required = false) String whatColumn,
								   @RequestParam(value="keyword", required = false) String keyword,
								   @RequestParam(value="n_num") String n_num) {
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("whatColumn", whatColumn);
		mav.addObject("keyword", keyword);
		
		NoticeBean notice = ndao.getNoticeByN_num(n_num);
		
		mav.addObject("notice", notice);
		
		mav.setViewName(updatePage);
		
		return mav;
	}
	
	@RequestMapping(value=updateCommand, method = RequestMethod.POST)
	public ModelAndView update( 
			@ModelAttribute("notice") @Valid NoticeBean nb, BindingResult result,
			@RequestParam(value="pageNumber", required = false) String pageNumber,
			@RequestParam(value="whatColumn", required = false) String whatColumn,
			@RequestParam(value="keyword", required = false) String keyword,
			HttpServletRequest request, HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("whatColumn", whatColumn);
		mav.addObject("keyword", keyword);
		
		if(result.hasErrors()) {
			
			mav.setViewName(updatePage);
			
			mav.addObject("notice", nb);
			
			return mav;
		}

		nb.setLec_num( ( (MemberBean)session.getAttribute("loginInfo") ).getLec_num() );
		nb.setWriter( ( (MemberBean)session.getAttribute("loginInfo") ).getName() );
		nb.setMem_num( ((MemberBean)session.getAttribute("loginInfo") ).getMem_num() );
		
		//DB 테이블에 추가
		ndao.updateNotice(nb);
		
		mav.setViewName(gotoPage);
		
		return mav;
	}
	
	@RequestMapping(deleteCommand)
	public ModelAndView delete(@RequestParam(value="pageNumber", required = false) String pageNumber,
								  @RequestParam(value="whatColumn", required = false) String whatColumn,
								  @RequestParam(value="keyword", required = false) String keyword,
								  @RequestParam(value="n_num") String n_num,
								  HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("whatColumn", whatColumn);
		mav.addObject("keyword", keyword);

		NoticeBean nb = ndao.getNoticeByN_num(n_num);
		
		ndao.deleteNoticeByN_num(n_num);
		
		mav.setViewName(gotoPage);
		
		return mav;
	}
	@RequestMapping(deleteAllCommand)
	public ModelAndView deleteAll(@RequestParam(value="pageNumber", required = false) String pageNumber,
								  @RequestParam(value="whatColumn", required = false) String whatColumn,
								  @RequestParam(value="keyword", required = false) String keyword,
								  HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("whatColumn", whatColumn);
		mav.addObject("keyword", keyword);
		

		String[] rcheck = request.getParameterValues("rowcheck");
		
		for(String r : rcheck) {
			
			NoticeBean nb = ndao.getNoticeByN_num(r);
			
			ndao.deleteNoticeByN_num(r);
		}
		
		mav.setViewName(gotoPage);
		
		return mav;
	}
}
