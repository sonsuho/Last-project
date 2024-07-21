package manager.model;

import org.hibernate.validator.constraints.NotEmpty;

public class NoticeBean {

	private int n_num;
	private String lec_num;
	
	@NotEmpty(message = "제목은 필수 입력입니다.")
	private String title;
	
	private int mem_num;
	private String writer;
	private String day;
	
	@NotEmpty(message = "내용은 필수 입력입니다.")
	private String content;
	
	@NotEmpty(message = "반은 필수 입력입니다.")
	private String class_name;

	public NoticeBean() {

	}

	public NoticeBean(int n_num, String lec_num, String title, int mem_num, String writer, String day, String content,
			String class_name) {
		super();
		this.n_num = n_num;
		this.lec_num = lec_num;
		this.title = title;
		this.mem_num = mem_num;
		this.writer = writer;
		this.day = day;
		this.content = content;
		this.class_name = class_name;
	}

	public String getClass_name() {
		return class_name;
	}

	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}

	public int getN_num() {
		return n_num;
	}

	public void setN_num(int n_num) {
		this.n_num = n_num;
	}

	public String getLec_num() {
		return lec_num;
	}

	public void setLec_num(String lec_num) {
		this.lec_num = lec_num;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
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

}
