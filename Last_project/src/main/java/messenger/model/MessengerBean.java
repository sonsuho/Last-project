package messenger.model;

public class MessengerBean {
	private int msg_num;	// 메신저 번호 PK
	private int mem_num;	// 회원 번호 FK
	private int group_num;	// 메신저 그룹 번호
	private int recv_num;	// 받는 회원 번호 FK
	private int ogmsg_num;	// 원본 메신저 번호
	private String title;	// 제목
	private String content;	// 내용
	private String msg_upload;	// 파일 첨부
	private String send_time;	// 보낸 시간
	private String read_time;	// 읽은 시간
	private int read_chk;		// 열람 여부
	private String send_name;	// 보낸 사람 이름
	private String recv_name;	// 받는 사람 이름
	private int del_chk;
	
	// 첨부 파일 경로를 배열로 저장
	private String[] uploadList;
 	
	public MessengerBean() {
		
	}
	
	public MessengerBean(int msg_num, int mem_num, int group_num, int recv_num, int ogmsg_num, String title,
			String content, String msg_upload, String send_time, String read_time, int read_chk, String send_name,
			String recv_name) {
		super();
		this.msg_num = msg_num;
		this.mem_num = mem_num;
		this.group_num = group_num;
		this.recv_num = recv_num;
		this.ogmsg_num = ogmsg_num;
		this.title = title;
		this.content = content;
		this.msg_upload = msg_upload;
		this.send_time = send_time;
		this.read_time = read_time;
		this.read_chk = read_chk;
		this.send_name = send_name;
		this.recv_name = recv_name;
		this.del_chk = del_chk;
	}
	public int getMsg_num() {
		return msg_num;
	}
	public void setMsg_num(int msg_num) {
		this.msg_num = msg_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public int getGroup_num() {
		return group_num;
	}
	public void setGroup_num(int group_num) {
		this.group_num = group_num;
	}
	public int getRecv_num() {
		return recv_num;
	}
	public void setRecv_num(int recv_num) {
		this.recv_num = recv_num;
	}
	public int getOgmsg_num() {
		return ogmsg_num;
	}
	public void setOgmsg_num(int ogmsg_num) {
		this.ogmsg_num = ogmsg_num;
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
	public String getMsg_upload() {
		return msg_upload;
	}
	public void setMsg_upload(String msg_upload) {
		this.msg_upload = msg_upload;
	}
	public String getSend_time() {
		return send_time;
	}
	public void setSend_time(String send_time) {
		this.send_time = send_time;
	}
	public String getRead_time() {
		return read_time;
	}
	public void setRead_time(String read_time) {
		this.read_time = read_time;
	}
	public int getRead_chk() {
		return read_chk;
	}
	public void setRead_chk(int read_chk) {
		this.read_chk = read_chk;
	}
	public String getSend_name() {
		return send_name;
	}
	public void setSend_name(String send_name) {
		this.send_name = send_name;
	}
	public String getRecv_name() {
		return recv_name;
	}
	public void setRecv_name(String recv_name) {
		this.recv_name = recv_name;
	}

	// 첨부 파일 경로를 배열로 저장
	public String[] getUploadList() {
		return uploadList;
	}

	public void setUploadList(String[] uploadList) {
		this.uploadList = uploadList;
	}

	public int getDel_chk() {
		return del_chk;
	}

	public void setDel_chk(int del_chk) {
		this.del_chk = del_chk;
	}
	
	
	
}
