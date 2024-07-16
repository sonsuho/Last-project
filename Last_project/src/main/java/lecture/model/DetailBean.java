package lecture.model;

import java.util.List;

import member.model.MemberBean;

public class DetailBean {
	
	private LectureBean lecture;
	private List<MemberBean> members;
	
	private MemberBean member;
	private List<LectureBean> lectures;
	
	
	public MemberBean getMember() {
		return member;
	}
	public void setMember(MemberBean member) {
		this.member = member;
	}
	public List<LectureBean> getLectures() {
		return lectures;
	}
	public void setLectures(List<LectureBean> lectures) {
		this.lectures = lectures;
	}
	public LectureBean getLecture() {
		return lecture;
	}
	public void setLecture(LectureBean lecture) {
		this.lecture = lecture;
	}
	public List<MemberBean> getMembers() {
		return members;
	}
	public void setMembers(List<MemberBean> members) {
		this.members = members;
	}
	
}
