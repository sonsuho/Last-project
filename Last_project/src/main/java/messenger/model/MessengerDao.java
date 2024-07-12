package messenger.model;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.Paging;


@Component
public class MessengerDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	@Autowired
	HttpSession session;
	
	private String namespace = "messenger.model.Messenger";
	
	public MessengerDao() {
		
	}
	
	public List<MessengerBean> getMsgRecvList(Map<String, Object> map, Paging pageInfo) {
		
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		
		List<MessengerBean> rlist = sqlSessionTemplate.selectList(namespace +".getMsgRecvList", map, rowBounds);
		return rlist;
	}
	
	public List<MessengerBean> getMsgSendList(int mem_num) {
		
		List<MessengerBean> slist = sqlSessionTemplate.selectList(namespace +".getMsgSendList", mem_num);
		return slist;
	}
	
	public int getTotalCount(Map<String, Object>map) {
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne(namespace + ".getTotalCount", map);
		return cnt;
	}
	
	
	public void insertAllMsg(MessengerBean mb) {
		sqlSessionTemplate.insert(namespace + ".insertAllMsg", mb);
	}
	
	public List<MessengerBean> getRecentlyMsg(int mem_num) {
		List<MessengerBean> reclist = sqlSessionTemplate.selectList(namespace + ".getRecentlyMsg", mem_num);
		
		System.out.println("reclist: "+ reclist);
		return reclist;
	}
	
	public MessengerBean getMsgDetailByNum(int msg_num) {
		MessengerBean mb = sqlSessionTemplate.selectOne(namespace + ".getMsgDetailByNum", msg_num);
		return mb;
	}
	
}
