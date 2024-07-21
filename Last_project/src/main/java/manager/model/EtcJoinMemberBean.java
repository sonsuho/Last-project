package manager.model;

public class EtcJoinMemberBean {
    private int etc_num; // 서류 번호
    private int mem_num; // 회원번호
    private int sender_num; // 받는사람번호
    private String etc_title; // 서류제목
    private String etc_content; // 서류내용
    private String etc_sdate; // 요청날짜
    private String etc_delete; // 
    private String memberName; // 회원 이름

    
    
    public String getEtc_delete() {
		return etc_delete;
	}

	public void setEtc_delete(String etc_delete) {
		this.etc_delete = etc_delete;
	}

	public int getEtc_num() {
        return etc_num;
    }

    public void setEtc_num(int etc_num) {
        this.etc_num = etc_num;
    }

    public int getMem_num() {
        return mem_num;
    }

    public void setMem_num(int mem_num) {
        this.mem_num = mem_num;
    }

    public int getSender_num() {
        return sender_num;
    }

    public void setSender_num(int sender_num) {
        this.sender_num = sender_num;
    }

    public String getEtc_title() {
        return etc_title;
    }

    public void setEtc_title(String etc_title) {
        this.etc_title = etc_title;
    }

    public String getEtc_content() {
        return etc_content;
    }

    public void setEtc_content(String etc_content) {
        this.etc_content = etc_content;
    }

    public String getEtc_sdate() {
        return etc_sdate;
    }

    public void setEtc_sdate(String etc_sdate) {
        this.etc_sdate = etc_sdate;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }
}
