package evaluation.model;

public class EvaluationResultBean {
	
	private int eval_num;
	private int lec_num;
	private int stu_num;
	private String eval_result;
	
	public int getEval_num() {
		return eval_num;
	}
	public void setEval_num(int eval_num) {
		this.eval_num = eval_num;
	}
	
	public int getLec_num() {
		return lec_num;
	}
	public void setLec_num(int lec_num) {
		this.lec_num = lec_num;
	}
	
	public int getStu_num() {
		return stu_num;
	}
	public void setStu_num(int stu_num) {
		this.stu_num = stu_num;
	}
	
	public String getEval_result() {
		return eval_result;
	}
	public void setEval_result(String eval_result) {
		this.eval_result = eval_result;
	}
}
