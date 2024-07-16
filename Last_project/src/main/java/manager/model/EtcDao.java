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
public class EtcDao {
	private final String namespace = "manager.model.Manager";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public int insert(EtcBean etc, String[] selected_mem_num) {
		int cnt =-1;
		 for (String smn : selected_mem_num) {
	            etc.setMem_num(Integer.parseInt(smn));
	            System.out.println("넘어오는 학생번호:"+etc.getMem_num());
	            cnt += sqlSessionTemplate.insert(namespace + ".insertEtc", etc);
	        }
	        return cnt;
	    }

	public List<EtcBean> getEtcList(Paging pageInfo, Map<String, String> map) {
		List<EtcBean> list = new ArrayList<EtcBean>();
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		
		list = sqlSessionTemplate.selectList(namespace+".getEtcList",map,rowBounds);
		
		return list;
	}
	
	public List<EtcBean> getEtcSenderList(Paging pageInfo, Map<String, String> map) {
		List<EtcBean> list = new ArrayList<EtcBean>();
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		
		list = sqlSessionTemplate.selectList(namespace+".getEtcListBySender_num",map,rowBounds);
		
		return list;
	}

	public EtcBean getEtcByNum(int etc_num) {
		EtcBean eb = new EtcBean();
		
		eb= sqlSessionTemplate.selectOne(namespace+".getEtcByNum",etc_num);
		
		return eb;
		
		
	}

	public void selectDelete(String[] rowcheck) {
		sqlSessionTemplate.delete(namespace+".selectDeleteEtc",rowcheck);

	}

	public String fileCount(int etc_num) {
		String str = "";
		str = sqlSessionTemplate.selectOne(namespace+".fileCount",etc_num);
		return str;
	}

//	public List<EtcBean> getEtcListByMem_num(int mem_num) {
//		
//		List<EtcBean> list = sqlSessionTemplate.selectList(namespace+".getEtcListByMem_num", mem_num);
//		
//		return list;
//	}

	public int totalCountEtcBySender_Num(Map<String, String> map) {
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne(namespace+".totalCountEtcBySender_Num",map);
		return cnt;
	}
	
	public int totalCountEtcByMSender_Num(Map<String, String> map) {
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne(namespace+".totalCountEtcByMSender_Num",map);
		return cnt;
	}
	
	public int totalCountEtcByMem_Num(Map<String, String> map) {
		int cnt = -1;
		
		cnt = sqlSessionTemplate.selectOne(namespace+".totalCountEtcByMem_Num",map);
		
		return cnt;
	}
	
	public int totalCountEtcByMmem_Num(Map<String, String> map) {
		int cnt = -1;
		
		cnt = sqlSessionTemplate.selectOne(namespace+".totalCountEtcByMmem_Num",map);
		
		return cnt;
	}

	public EtcBean getEtcBySenderNum(int sender_num, int etc_num) {
		
		EtcBean eb = new EtcBean();
		eb.setSender_num(sender_num);
		eb.setEtc_num(etc_num);
		eb = sqlSessionTemplate.selectOne(namespace+".getEtcBySenderNum",eb);
		
		return eb;
	}

	public String fileCountBySenderNum(int sender_num,int etc_num) {
		String str = "";
		EtcBean eb = new EtcBean();
		eb.setSender_num(sender_num);
		eb.setEtc_num(etc_num);
			str = sqlSessionTemplate.selectOne(namespace+".fileCountBySenderNum",eb);
		return str;
	}

	public int insertReply(EtcBean etc) {
		int cnt =-1;
	          cnt = sqlSessionTemplate.insert(namespace + ".insertEtc", etc);
	    return cnt;
	}
	
	public List<EtcJoinMemberBean> getEtcWithMemberInfo(Paging pageInfo,Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());

        return sqlSessionTemplate.selectList(namespace + ".getEtcWithMemberInfo", map,rowBounds);
	}
	
	public List<EtcJoinMemberBean> getEtcSenderListWithMemberInfo(Paging pageInfo,Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());

		return sqlSessionTemplate.selectList(namespace + ".getEtcSenderListWithMemberInfo", map,rowBounds);
	}
	public List<EtcJoinMemberBean> getEtcStuSenderListWithMemberInfo(Paging pageInfo,Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		
		return sqlSessionTemplate.selectList(namespace + ".getEtcStuSenderListWithMemberInfo", map,rowBounds);
	}


	

}
