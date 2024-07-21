package test.model;

public class TestBean {
	
	private int test_num;
	private int lec_num;
	private String test_name;
	private String test_questions;
	private String test_answer;
	private String test_img;	
	private String test_opt;
	private String questions_point;
	
	public String getTest_img() {
		return test_img;
	}
	public void setTest_img(String test_img) {
		this.test_img = test_img;
	}

	public int getTest_num() {
		return test_num;
	}
	public void setTest_num(int test_num) {
		this.test_num = test_num;
	}
	
	public int getLec_num() {
		return lec_num;
	}
	public void setLec_num(int lec_num) {
		this.lec_num = lec_num;
	}
	
	public String getTest_name() {
		return test_name;
	}
	public void setTest_name(String test_name) {
		this.test_name = test_name;
	}
	
	public String getTest_questions() {
		return test_questions;
	}
	public void setTest_questions(String test_questions) {
		this.test_questions = test_questions;
	}
	
	public String getTest_answer() {
		return test_answer;
	}
	public void setTest_answer(String test_answer) {
		this.test_answer = test_answer;
	}
	
	public String getTest_opt() {
		return test_opt;
	}
	public void setTest_opt(String test_opt) {
		this.test_opt = test_opt;
	}
	
	public String getQuestions_point() {
		return questions_point;
	}
	public void setQuestions_point(String questions_point) {
		this.questions_point = questions_point;
	}
}
