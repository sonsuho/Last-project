package alarm.model;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Service;

@Service
public class AlarmService implements InterAlarmService {

    @Autowired
    private InterAlarmDAO adao;

    // AOP 알람추가하기
    @Override
    public void addAlarm(Map<String, String> paraMap) {
        Calendar currentDate = Calendar.getInstance();
        SimpleDateFormat dateft = new SimpleDateFormat("yyyyMMddHHmmssSSS");

        String time = dateft.format(currentDate.getTime());
        
        Random random = new Random();
        int min = 1;
        int max = 20000;

        // Generate a random number between min (inclusive) and max (inclusive)
        int randomNumber = random.nextInt(max - min + 1) + min;

        String str_fk_recipientno = paraMap.get("fk_recipientno");
        paraMap.put("writedate", time);
        if (str_fk_recipientno == null || str_fk_recipientno.isEmpty()) {
            return;
        }

        String str_url2 = paraMap.get("url2");
        System.out.println("str_url2:"+str_url2);
        String[] arr_fk_recipientno = str_fk_recipientno.split(",");
        String[] arr_url2 = str_url2.split(",");

        String alarmType = "";

        if ("1".equals(paraMap.get("alarm_type"))) alarmType = "&#9200;";//시계이미지
        if ("2".equals(paraMap.get("alarm_type"))) alarmType = "&#10071;";//느낌표이미지
        if ("3".equals(paraMap.get("alarm_type"))) alarmType = "&#9989;";//메시지 이미지
        if ("4".equals(paraMap.get("alarm_type"))) alarmType = "&#128161;";// 전구 이미지
        if ("5".equals(paraMap.get("alarm_type"))) alarmType = "&#128226;";//공지 이미지
        if ("6".equals(paraMap.get("alarm_type"))) alarmType = "&#128178;";//돈 이미지

        StringBuilder sb = new StringBuilder();
        sb.append(" INSERT ALL ");

        String startLine = " into alarm (pk_alarmno, fk_recipientno, url2, url, alarm_content, alarm_type ,view_status, writedate ) values (";
        String endLine = paraMap.get("url") + "', '" + paraMap.get("alarm_content") + "', '" + alarmType + "','" + "0" + "',"+ "sysdate)";

        	if(arr_url2.length>1) {
			
			for( int i=0; i<arr_fk_recipientno.length; i++) {
				sb.append(startLine);
				sb.append( randomNumber+i +" , " + arr_fk_recipientno[i] + " , '" + arr_url2[i] + "', '");
				sb.append(endLine);
			}
			
		} else {
			
			for( int i=0; i<arr_fk_recipientno.length; i++) {
				sb.append(startLine);
				sb.append( randomNumber+i +" , " + arr_fk_recipientno[i] + " , '" + str_url2 + "', '");
				sb.append(endLine);
			}
			
		}

        sb.append(" SELECT * FROM DUAL ");
        
        adao.addAlarm( sb.toString());
    }

	// 알람 조회하기
	@Override
	public List<AlarmBean> getAlarmList(int mem_num) {
		System.out.println("getAlarmListServiceMEM_num:"+mem_num);
		List<AlarmBean> alarmList = adao.getAlarmList(mem_num);
		return alarmList;
	}
	
	
	// 지난 알람 조회하기
	@Override
	public List<AlarmBean> getPastAlarmList(int mem_num) {
		List<AlarmBean> alarmList = adao.getPastAlarmList(mem_num);
		return alarmList;
	}


	// 알람 읽기
	@Override
	public void readAlarm(String alarmno) {
		adao.readAlarm(alarmno);
	}
	
	
	// 모든 알람 읽기
	@Override
	public void readAllAlarm(int mem_num) {
		adao.readAllAlarm(mem_num);
	}


	// 안 읽은 소식 개수 알아오기
	@Override
	public int getUnreadAlarmCnt(int mem_num) {
		int cnt = adao.getUnreadAlarmCnt(mem_num);
		return cnt;
	}
}