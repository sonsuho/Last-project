package messenger.model;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import member.model.MemberBean;
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
	
	public List<MessengerBean> getMsgSendList(Map<String, Object> map, Paging pageInfo) {
		
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		
		List<MessengerBean> slist = sqlSessionTemplate.selectList(namespace +".getMsgSendList", map, rowBounds);
		return slist;
	}
	
	public int getTotalCount(Map<String, Object>map) {
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne(namespace + ".getTotalCount", map);
		return cnt;
	}
	
	public int getSendTotalCount(Map<String, Object>map) {
		int cnt = -1;
		cnt = sqlSessionTemplate.selectOne(namespace + ".getSendTotalCount", map);
		return cnt;
	}
	
	
	public void insertAllMsg(MessengerBean mb) {
		sqlSessionTemplate.insert(namespace + ".insertAllMsg", mb);
		System.out.println("메시지 보내기 성공!");
		System.out.println("insert mb.get" + mb.getOgmsg_num());
	}
	
	public List<MessengerBean> getRecentlyMsg(int mem_num) {
		List<MessengerBean> reclist = sqlSessionTemplate.selectList(namespace + ".getRecentlyMsg", mem_num);
		
		System.out.println("reclist: "+ reclist);
		
		return reclist;
	}
	
	// messengerMain.jsp에서 상세보기 화면 가져오기 
	public MessengerBean getMsgDetailByNum(int msg_num, MemberBean loginInfo) {

		MessengerBean mb = sqlSessionTemplate.selectOne(namespace + ".getMsgDetailByNum", msg_num);
		
		if(loginInfo.getMem_num() == mb.getRecv_num() ) {
			sqlSessionTemplate.update(namespace + ".updateMsgDetailReadChk", msg_num);
		}
		
		return mb;
	}
	
	// messengerMain.jsp에서 상세보기 -> 답장하기 클릭시 답장하기 폼가져오기 
	public MessengerBean getMsgReplyByNum(int msg_num) {
		MessengerBean mb = sqlSessionTemplate.selectOne(namespace + ".getMsgReplyByNum", msg_num);
		return mb;
	}
	
	// del_chk <=0 일 때 삭제 
	public void deleteMsg(int msg_num) {
		sqlSessionTemplate.delete(namespace + ".deleteMsg", msg_num);
	}
	
	// msg_num 가져와서 Update (보낸사람, 받는사람 둘 다 삭)
	public void updateForDelMsg(MessengerBean mb) {
		sqlSessionTemplate.update(namespace + ".updateForDelMsg", mb);
	}
	
	public MessengerBean getMsgByNum(int msg_num) {
		MessengerBean mb = sqlSessionTemplate.selectOne(namespace + ".getMsgByNum", msg_num);
		return mb;
	}
	
}
