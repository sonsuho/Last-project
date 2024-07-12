package student.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import manager.model.RequestBean;
import manager.model.RequestJoinMemberBean;
import utility.Paging;

@Component
public class SRequestDao {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	private String namespace = "manager.model.Manager";
	
	public SRequestDao() {
		
	}
	
	public void studentReqInsert(SRequestBean req) {
		sqlSessionTemplate.update(namespace + ".studentReqInsert", req);
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

	public int getAllTotalCount() {
		int cnt = -1;

		cnt = sqlSessionTemplate.selectOne(namespace+".getAllTotalCount");


		return cnt;
	}

	public List<RequestJoinMemberBean> RequestPaging(Paging pageInfo, Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());

		List<RequestJoinMemberBean> list = new ArrayList<RequestJoinMemberBean>();

		list = sqlSessionTemplate.selectList(namespace+".RequestPaging",map,rowBounds);

		return list;
	}

	public void selectDelete(String[] rowcheck) {
		sqlSessionTemplate.delete(namespace+".selectDeleteReq",rowcheck);		
	}

	public int rowcheckSReq_delete(String[] rowcheck) {
		int cnt = -1;
		
		cnt = sqlSessionTemplate.update(namespace+".SReq_delete",rowcheck);
		
		return cnt;
	}

	public int delSReqCheck(String[] rowcheck) {
		int cnt =-1;
		
		cnt = sqlSessionTemplate.selectOne(namespace+".delSReqCheck",rowcheck);
		
		return cnt;
	}

	public void rowcheckEtc_delete(String[] rowcheck) {
		sqlSessionTemplate.update(namespace+".etc_Sdelete",rowcheck);		
	}

	public int delEtcCheck(String[] rowcheck) {
		int cnt =-1;
		
		cnt = sqlSessionTemplate.selectOne(namespace+".delEtcCheck",rowcheck);
		
		return cnt;
	}
}
