package library.model;

import org.hibernate.validator.constraints.NotEmpty;

public class LibraryBean {
	
	private int li_num;
	private String lec_num;
	
	@NotEmpty(message = "자료 제목을 입력하세요.")
	private String title;
	
	private int mem_num;
	private String writer;
	private String day;
	
	@NotEmpty(message = "자료 내용을 입력하세요.")
	private String content;
	
	@NotEmpty(message = "업로드할 자료를 선택하세요.")
	private String upload;
	
	public int getLi_num() {
		return li_num;
	}
	public void setLi_num(int li_num) {
		this.li_num = li_num;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getUpload() {
		return upload;
	}
	public void setUpload(String upload) {
		this.upload = upload;
	}
	
	public String getLec_num() {
		return lec_num;
	}
	public void setLec_num(String lec_num) {
		this.lec_num = lec_num;
	}
	
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
}
