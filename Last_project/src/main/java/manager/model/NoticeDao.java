package manager.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.Paging;

@Component
public class NoticeDao {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	private String namespace = "manager.model.Manager";
	
	public NoticeDao() {
		System.out.println("NoticeDao 생성");
	}
	
	public int getTotalCount(Map<String, String> map) {
		
		int count = -1;
		
		count = sqlSessionTemplate.selectOne(namespace + ".getTotalCount", map);
		
		System.out.println("Library getTotalCount count : " + count);
		
		return count;
	}
	
	public List<NoticeBean> getNoticeList(Paging pageInfo, Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		
		List<NoticeBean> list = sqlSessionTemplate.selectList(namespace + ".getNoticeList", map, rowBounds);
		
		System.out.println("getNoticeList size : " + list.size());
		
		return list;
	}

	public List<NoticeBean> getNoticeList_all() {
		
		List<NoticeBean> list = sqlSessionTemplate.selectList(namespace + ".getNoticeList_all");
		
		System.out.println("getNoticeList_re size : " + list.size());
		
		return list;
	}
	
	public List<NoticeBean> getNoticeListByLec_Num(Paging pageInfo, Map<String, String> map) {
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		
		List<NoticeBean> list = sqlSessionTemplate.selectList(namespace + ".getNoticeListByLec_Num", map, rowBounds);
		
		System.out.println("getNoticeList size : " + list.size());
		
		return list;
	}

	public int insertNotice(NoticeBean nb) {
		
		int cnt = -1;
		
		cnt = sqlSessionTemplate.insert(namespace + ".insertNotice", nb);
		
		System.out.println("insertNotice cnt : " + cnt);
		
		return cnt;
	}

	public NoticeBean getNoticeByN_num(String n_num) {
		
		NoticeBean nb = sqlSessionTemplate.selectOne(namespace + ".getNoticeByN_num", n_num);
		
		System.out.println("getNoticeByN_num title : " + nb.getTitle());
		
		return nb;
	}
	
	public int updateNotice(NoticeBean nb) {
		
		int cnt = -1;
		
		cnt = sqlSessionTemplate.update(namespace + ".updateNotice", nb);
		
		System.out.println("updateNotice cnt : " + cnt);
		
		return cnt;
	}

	public int deleteNoticeByN_num(String n_num) {
		
		int cnt = -1;
		
		cnt = sqlSessionTemplate.delete(namespace + ".deleteNoticeByN_num", n_num);
		
		System.out.println("deleteNoticeByN_num cnt : " + cnt);
		
		return cnt;
	}

	public NoticeBean getNoticeByClassName(String class_name) {
		
		NoticeBean nb = sqlSessionTemplate.selectOne(namespace+".getNoticeByClassName",class_name);
		
		return nb;
	}

	/*
	 * public NoticeBean getNoticeByLec_Num(String lec_num) { NoticeBean nb =
	 * sqlSessionTemplate.selectOne(namespace+".getNoticeByLec_Num",lec_num); return
	 * nb; }
	 */
}
