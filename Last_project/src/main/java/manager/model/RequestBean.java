package manager.model;

public class RequestBean {
	private int req_num;	//요청 번호
	private int mem_num;	//보내는 사람 번호
	private int app_num;  //결재자 번호
	private String title;  //제목
	private String category;// 조퇴, 휴가, 결석 
	private String time1;	//사용일자
	private String time2;	//마감날짜
	private String reason;	//요청사유
	private String sign;    //서명 파일
	private String ap_situ;	//대기중, 승인, 반려
	private String ap_date; // 결재일자
	
	private String ap_delete;	// 삭제 체크
	
	
	
	public String getAp_delete() {
		return ap_delete;
	}
	public void setAp_delete(String ap_delete) {
		this.ap_delete = ap_delete;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public int getApp_num() {
		return app_num;
	}
	public void setApp_num(int app_num) {
		this.app_num = app_num;
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
	public String getAp_situ() {
		return ap_situ;
	}
	public void setAp_situ(String ap_situ) {
		this.ap_situ = ap_situ;
	}
	public String getAp_date() {
		return ap_date;
	}
	public void setAp_date(String ap_date) {
		this.ap_date = ap_date;
	}
	
	
	
}
