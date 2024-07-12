package manager.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import utility.Paging;

@Service
public class RequestDao {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	private final String namespace = "manager.model.Manager";

	public List<RequestBean> requestList() {
		List<RequestBean> rlist = new ArrayList<RequestBean>();

		rlist = sqlSessionTemplate.selectList(namespace+".requestList");

		return rlist;
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

	public int getTotalCountBySitu(Map<String, String> map) {
		int cnt = -1;

		cnt = sqlSessionTemplate.selectOne(namespace+".getTotalCountBySitu",map);

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
	public int rowcheckAp_delete(String[] rowcheck) {
		int cnt = -1;
		
		cnt = sqlSessionTemplate.update(namespace+".ap_delete",rowcheck);
		return cnt;
	}
	public int delReqCheck(String[] rowcheck) {
		int cnt =-1;
		
		cnt = sqlSessionTemplate.selectOne(namespace+".delReqCheck",rowcheck);
		
		return cnt;
	}
	
	public void rowcheckEtc_delete(String[] rowcheck) {
		
		sqlSessionTemplate.update(namespace+".etc_delete",rowcheck);

		
	}
	public int delEtcCheck(String[] rowcheck) {
		int cnt =-1;
		
		cnt = sqlSessionTemplate.selectOne(namespace+".delEtcCheck",rowcheck);
		
		return cnt;
	}



}
