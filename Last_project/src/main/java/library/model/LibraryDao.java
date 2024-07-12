package library.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.Paging;

@Component
public class LibraryDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public LibraryDao() {
		System.out.println("LibraryDao 생성");
	}
	
	public int getTotalCount(Map<String, String> map) {
		
		int count = -1;
		
		count = sqlSessionTemplate.selectOne("library.model.Library.getTotalCount", map);
		
		System.out.println("Library getTotalCount count : " + count);
		
		return count;
	}

	public List<LibraryBean> getLibraryList(Paging pageInfo, Map<String, String> map) {
		
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		
		List<LibraryBean> list = sqlSessionTemplate.selectList("library.model.Library.getLibraryList", map, rowBounds);
		
		System.out.println("getLibraryList size : " + list.size());
		
		return list;
	}

	public int insertLibrary(LibraryBean lb) {
		
		int cnt = -1;
		
		cnt = sqlSessionTemplate.insert("library.model.Library.insertLibrary", lb);
		
		System.out.println("insertLibrary cnt : " + cnt);
		
		return cnt;
	}

	public LibraryBean getLibraryByNum(String li_num) {
		
		LibraryBean lb = sqlSessionTemplate.selectOne("library.model.Library.getLibraryByNum", li_num);
		
		System.out.println("getLibraryByNum title : " + lb.getTitle());
		
		return lb;
	}

	public int deleteByNum(String li_num) {
		
		int cnt = -1;
		
		cnt = sqlSessionTemplate.delete("library.model.Library.deleteByNum", li_num);
		
		System.out.println("deleteByNum cnt : " + cnt);
		
		return cnt;
	}

	public int updateLibrary(LibraryBean lb) {
		
		int cnt = -1;
		
		cnt = sqlSessionTemplate.update("library.model.Library.updateLibrary", lb);
		
		System.out.println("updateLibrary cnt : " + cnt);
		
		return cnt;
	}

}
