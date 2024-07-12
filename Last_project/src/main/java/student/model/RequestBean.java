package student.model;

import org.hibernate.validator.constraints.NotEmpty;

public class RequestBean {
	private int req_num;
	private int mem_num;
	private String category;
	
	@NotEmpty(message = "기간을 선택하세요.")
	private String time1;
	private String time2;
	
	@NotEmpty(message = "사유를 입력하세요.")
	private String reason;
	
	private String sign;
	
	public RequestBean() {
		
	}
	
	public RequestBean(int req_num, int mem_num, String category, String time1, String time2, String reason, String sign) {
		super();
		this.req_num = req_num;
		this.mem_num = mem_num;
		this.category = category;
		this.time1 = time1;
		this.time2 = time2;
		this.reason = reason;
		this.sign = sign;
	}

	public int getReq_num() {
		return req_num;
	}
	public void setReq_num(int req_num) {
		this.req_num = req_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTime1() {
		return time1;
	}
	public void setTime1(String time1) {
		this.time1 = time1;
	}
	public String getTime2() {
		return time2;
	}
	public void setTime2(String time2) {
		this.time2 = time2;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	
	
}
