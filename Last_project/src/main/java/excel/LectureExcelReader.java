package excel;

import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import lecture.model.LectureBean;

public class LectureExcelReader {

	// xls 파일을 분석하여 List<LectureBean> 객체로 반환
	public List<LectureBean> xlsToList(String filePath) {
	    
		// 반환할 객체를 생성
	    List<LectureBean> list = new ArrayList<LectureBean>();
	    FileInputStream fis = null;
	    HSSFWorkbook workbook = null; // xsl 파일
	    try {
	        
	    	fis = new FileInputStream(filePath);
	    	workbook = new HSSFWorkbook(fis); // HSSFWorkbook : 엑셀파일 전체 내용을 담고 있는 객체
	    	
	    	// 탐색에 사용할 객체들
	        HSSFSheet curSheet;
	        HSSFRow curRow;
	        HSSFCell curCell;
	        LectureBean lb;
	
	        // 현재 sheet
	        curSheet = workbook.getSheetAt(0);
	        // row 탐색 for문
	        for (int rowIndex = 0; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++) {
                // row 0 은 헤더정보이기 때문에 무시
                if (rowIndex != 0) {
                    // 현재 row 반환
                    curRow = curSheet.getRow(rowIndex);
                    if (curRow == null) continue; // null 체크
                    
                    lb = new LectureBean();
                    String value = "";
    
                    // row의 첫번째 cell값이 비어있지 않은 경우에만 cell 탐색
                    if (curRow.getCell(0) != null && !"".equals(curRow.getCell(0).getStringCellValue())) {
                        // cell 탐색 for문
                        for (int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++) {
                            curCell = curRow.getCell(cellIndex);
                            if (curCell != null) {
                                // cell 스타일에 관계없이 String으로 반환받음
                                switch (curCell.getCellType()) {
                                    case FORMULA:
                                        value = curCell.getCellFormula();
                                        break;
                                    case NUMERIC:
                                        value = curCell.getNumericCellValue() + "";
                                        break;
                                    case STRING:
                                        value = curCell.getStringCellValue();
                                        break;
                                    case BLANK:
                                        value = "";
                                        break;
                                    case BOOLEAN:
                                        value = curCell.getBooleanCellValue() + "";
                                        break;
                                    case ERROR:
                                        value = curCell.getErrorCellValue() + "";
                                        break;
                                    default:
                                        value = "";
                                        break;
                                }
                            }
    
                            // 현재 column index에 따라서 입력
                            switch (cellIndex) {
                                case 0: // 강좌명
                                    lb.setLec_name(value);
                                    break;
                                case 1: // 매니저
                                    lb.setManager(value);
                                    break;
                                case 2: // 강사
                                    lb.setTeacher(value);
                                    break;
                                case 3: // 시작일
                                    lb.setLec_start(value);
                                    break;
                                case 4: // 종료일
                                	lb.setLec_end(value);
                                	break;
                                case 5: // 학생수
                                	lb.setStu_cnt((int)Double.parseDouble(value));
                                	break;
                                case 6: // 반이름
                                	lb.setClass_name(value);
                                	break;
                                default:
                                    break;
                            }
                        }
                        list.add(lb);
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (workbook != null) workbook.close();
                if (fis != null) fis.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
	}
	
	// xlsx 파일을 분석하여 List<LectureBean> 객체로 반환
    public List<LectureBean> xlsxToList(String filePath) {
        
        // 반환할 객체를 생성
        List<LectureBean> list = new ArrayList<LectureBean>();
        FileInputStream fis = null;
        XSSFWorkbook workbook = null;
        
        try {
            fis = new FileInputStream(filePath);
            workbook = new XSSFWorkbook(fis); // XSSFWorkbook : 엑셀파일 전체 내용을 담고 있는 객체
            
            // 탐색에 사용할 객체들
            XSSFSheet curSheet;
            XSSFRow curRow;
            XSSFCell curCell;
            LectureBean lb;
    
            // 현재 sheet
            curSheet = workbook.getSheetAt(0);
            // row 탐색 for문
            for (int rowIndex = 0; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++) {
                // row 0 은 헤더정보이기 때문에 무시
                if (rowIndex != 0) {
                    // 현재 row 반환
                    curRow = curSheet.getRow(rowIndex);
                    if (curRow == null) continue; // null 체크
                    
                    lb = new LectureBean();
                    String value = "";
    
                    // row의 첫번째 cell값이 비어있지 않은 경우에만 cell 탐색
                    if (curRow.getCell(0) != null && !"".equals(curRow.getCell(0).getStringCellValue())) {
                        // cell 탐색 for문
                        for (int cellIndex = 0; cellIndex < curRow.getPhysicalNumberOfCells(); cellIndex++) {
                            curCell = curRow.getCell(cellIndex);
                            if (curCell != null) {
                                // cell 스타일에 관계없이 String으로 반환받음
                                switch (curCell.getCellType()) {
                                    case FORMULA:
                                        value = curCell.getCellFormula();
                                        break;
                                    case NUMERIC:
                                    	SimpleDateFormat dbDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                    	if (DateUtil.isCellDateFormatted(curCell)) {
                                            Date date = curCell.getDateCellValue();
                                            value = dbDateFormat.format(date);
                                        } else {
                                            value = curCell.getNumericCellValue() + "";
                                        }
                                        break;
                                    case STRING:
                                        value = curCell.getStringCellValue();
                                        break;
                                    case BLANK:
                                        value = "";
                                        break;
                                    case BOOLEAN:
                                        value = curCell.getBooleanCellValue() + "";
                                        break;
                                    case ERROR:
                                        value = curCell.getErrorCellValue() + "";
                                        break;
                                    default:
                                        value = "";
                                        break;
                                }
                            }
    
                            // 현재 column index에 따라서 입력
                            switch (cellIndex) {
	                            case 0: // 강좌명
	                                lb.setLec_name(value);
	                                break;
	                            case 1: // 매니저
	                                lb.setManager(value);
	                                break;
	                            case 2: // 강사
	                                lb.setTeacher(value);
	                                break;
	                            case 3: // 시작일
	                                lb.setLec_start(value);
	                                break;
	                            case 4: // 종료일
	                            	lb.setLec_end(value);
	                            	break;
	                            case 5: // 학생수
	                            	lb.setStu_cnt((int)Double.parseDouble(value));
	                            	break;
	                            case 6: // 반이름
	                            	lb.setClass_name(value);
	                            	break;
	                            default:
	                                break;
                            }
                        }
                        list.add(lb);
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (workbook != null) workbook.close();
                if (fis != null) fis.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }
	
}