package login.model;

import org.hibernate.validator.constraints.NotEmpty;

public class LoginBean {
	
	@NotEmpty(message = "아이디를 입력해주세요.")
	private String id;
	
	@NotEmpty(message = "비밀번호를 입력해주세요.")
	private String pw;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
}
