package manager.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import member.model.MemberBean;
import student.model.SRequestBean;
import utility.Paging;

@Service("managerRequestDao")
public class RequestDao {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	private final String namespace = "manager.model.Manager";

	public List<RequestBean> requestList() {
		List<RequestBean> rlist = new ArrayList<RequestBean>();

		rlist = sqlSessionTemplate.selectList(namespace+".requestList");

		return rlist;
	}
	public RequestBean getRequestList_re(int mem_num) {

		RequestBean rb = sqlSessionTemplate.selectOne(namespace+".getRequestList_re", mem_num);

		return rb;
	}
	
	public List<RequestBean> getVacationDetailListsByCategory(int mem_num) {

		List<RequestBean> lists = sqlSessionTemplate.selectList(namespace+".getVacationDetailListsByCategory", mem_num);

		return lists;
	}
	
	public List<RequestJoinMemberBean> RequestPaging1(Paging pageInfo, Map<String, String> map) {

		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());

		List<RequestJoinMemberBean> list = new ArrayList<RequestJoinMemberBean>();

		list = sqlSessionTemplate.selectList(namespace+".RequestPaging1",map,rowBounds);

		return list;
	}

	public List<RequestJoinMemberBean> RequestPaging2(Paging pageInfo, Map<String, String> map) {

		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());

		List<RequestJoinMemberBean> list = new ArrayList<RequestJoinMemberBean>();

		list = sqlSessionTemplate.selectList(namespace+".RequestPaging2",map,rowBounds);

		return list;
	}
	
	public List<RequestJoinMemberBean> RequestAdminPaging(Paging pageInfo, Map<String, String> map) {
		
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		
		List<RequestJoinMemberBean> list = new ArrayList<RequestJoinMemberBean>();
		
		list = sqlSessionTemplate.selectList(namespace+".RequestAdminPaging",map,rowBounds);
		
		return list;
	}
	public List<RequestJoinMemberBean> RequestAdminPaging2(Paging pageInfo, Map<String, String> map) {
		
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		
		List<RequestJoinMemberBean> list = new ArrayList<RequestJoinMemberBean>();
		
		list = sqlSessionTemplate.selectList(namespace+".RequestAdminPaging2",map,rowBounds);
		
		return list;
	}

	public List<RequestJoinMemberBean> RequestPaging3(Paging pageInfo, Map<String, String> map) {

		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());

		List<RequestJoinMemberBean> list = new ArrayList<RequestJoinMemberBean>();

		list = sqlSessionTemplate.selectList(namespace+".RequestPaging3",map,rowBounds);

		return list;
	}
	
	public void updateSitu(RequestBean rb) {

		sqlSessionTemplate.update(namespace + ".updateSitu",rb);
	}

	public void selectDelete(String[] rowcheck) {
		sqlSessionTemplate.delete(namespace+".selectDeleteReq",rowcheck);
	}
	
	public RequestBean getRequestByNum(int req_num) {
		RequestBean rb = sqlSessionTemplate.selectOne(namespace+".getRequestByNum",req_num);
		return rb;
	}

	public int getTotalCountBySitu(Map<String, String> map) {//결재null , mem_num 값을 조건으로
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne(namespace+".getTotalCountBySitu",map);

		return cnt;
	}
	
	public int getTotalCountBySitu2(Map<String, String> map) {//결재null , mem_num 값을 조건으로
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne(namespace+".getTotalCountBySitu2",map);
		
		return cnt;
	}
	
	public int getTotalCountBySitu3(Map<String, String> map) {//결재null , mem_num 값을 조건으로
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne(namespace+".getTotalCountBySitu3",map);
		
		return cnt;
	}
	

	
	public int getTotalCountByApproval(Map<String, String> map) {
		int cnt = -1;
		
		cnt = sqlSessionTemplate.selectOne(namespace+".getTotalCountByApproval",map);
		
		return cnt;
	}
	
	public int getTotalCountByApprovalByMem_Num(Map<String, String> map) {
		int cnt = -1;
		
		cnt = sqlSessionTemplate.selectOne(namespace+".getTotalCountByApprovalByMem_Num",map);
		
		return cnt;
	}
	
	public int getTotalCountByApprovalByApp_Num(Map<String, String> map) {
		int cnt = -1;
		
		cnt = sqlSessionTemplate.selectOne(namespace+".getTotalCountByApprovalByApp_Num",map);
		
		return cnt;
	}
	
	public int getAllTotalCount() {
		int cnt = -1;

		cnt = sqlSessionTemplate.selectOne(namespace+".getAllTotalCount");


		return cnt;
	}
	public List<RequestBean> getRequestList(Paging pageInfo, Map<String, String> map) {

		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());

		List<RequestBean> list = sqlSessionTemplate.selectList(namespace+".getRequestList",map,rowBounds);

		return list;
	}
	public int rowcheckAp_delete(String[] rowcheck) {//매니저 결재승인 삭제
		int cnt = -1;
		
		cnt = sqlSessionTemplate.update(namespace+".ap_delete",rowcheck);
		return cnt;
	}
	public int SReq_delete(String[] rowcheck) {//학생 결재승인 삭제
		int cnt = -1;
		
		cnt = sqlSessionTemplate.update(namespace+".SReq_delete",rowcheck);
		return cnt;
	}
	public int AReq_delete(String[] rowcheck) {//관리자 결재승인 삭제
		int cnt = -1;
		
		cnt = sqlSessionTemplate.update(namespace+".AReq_delete",rowcheck);
		return cnt;
	}
	public int delReqCheck(String[] rowcheck) {//결재승인  삭제
		int cnt =-1;
		
		cnt = sqlSessionTemplate.selectOne(namespace+".delReqCheck",rowcheck);
		
		return cnt;
	}
	public void rowcheckEtc_delete(String[] rowcheck) {//학생 삭제
		
		sqlSessionTemplate.update(namespace+".etc_delete",rowcheck);
		
		
	}
	
	public int delEtcCheck(String[] rowcheck) {//기타 삭제
		int cnt =-1;
		
		cnt = sqlSessionTemplate.selectOne(namespace+".delEtcCheck",rowcheck);
		
		return cnt;
	}
	public void managerReqInsert(RequestBean req) {
		sqlSessionTemplate.insert(namespace + ".ReqInsert", req);

	}



}
