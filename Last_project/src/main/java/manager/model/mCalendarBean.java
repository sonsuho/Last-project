package manager.model;



import org.hibernate.validator.constraints.NotEmpty;

public class mCalendarBean {

	private int cal_num;
	private int lec_num;
	private String mem_num;
	
	@NotEmpty(message="소속반을 선택하세요.")
	private String lesson_class;
	
	private String name;
	
	@NotEmpty(message="일정제목을 입력하세요.")
	private String title;
	
	@NotEmpty(message="일정내용을 입력하세요.")
	private String content;
	
	@NotEmpty(message="시작날짜를 입력하세요.")
	private String start_date;
	
	@NotEmpty(message="종료날짜를 입력하세요.")
	private String fin_date;
	
	public mCalendarBean() {
		
	}

	public mCalendarBean(int cal_num, int lec_num, String mem_num, String lesson_class, String name, String title,
			String content, String start_date, String fin_date) {
		super();
		this.cal_num = cal_num;
		this.lec_num = lec_num;
		this.mem_num = mem_num;
		this.lesson_class = lesson_class;
		this.name = name;
		this.title = title;
		this.content = content;
		this.start_date = start_date;
		this.fin_date = fin_date;
	}

	public int getCal_num() {
		return cal_num;
	}

	public void setCal_num(int cal_num) {
		this.cal_num = cal_num;
	}

	public int getLec_num() {
		return lec_num;
	}

	public void setLec_num(int lec_num) {
		this.lec_num = lec_num;
	}

	public String getMem_num() {
		return mem_num;
	}

	public void setMem_num(String mem_num) {
		this.mem_num = mem_num;
	}

	public String getLesson_class() {
		return lesson_class;
	}

	public void setLesson_class(String lesson_class) {
		this.lesson_class = lesson_class;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getFin_date() {
		return fin_date;
	}

	public void setFin_date(String fin_date) {
		this.fin_date = fin_date;
	}

}
