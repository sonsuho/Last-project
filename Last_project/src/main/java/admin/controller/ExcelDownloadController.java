package admin.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ExcelDownloadController {

	private final String lecDown = "lectureExcelDownload.admin";
	private final String emplDown = "emplExcelDownload.admin";
	private final String stuDown = "studentExcelDownload.manager";
	
	@RequestMapping(lecDown)
	public void lecDown(HttpServletResponse response) throws IOException {
	  // Workbook wb = new HSSFWorkbook();
      Workbook wb = new XSSFWorkbook();
      Sheet sheet = wb.createSheet("강좌 개설");
      Row row = null;
      Cell cell = null;
      int rowNum = 0;

      // Header
      row = sheet.createRow(rowNum++);
      cell = row.createCell(0);
      cell.setCellValue("강좌명");
      cell = row.createCell(1);
      cell.setCellValue("매니저");
      cell = row.createCell(2);
      cell.setCellValue("강사");
      cell = row.createCell(3);
      cell.setCellValue("시작일");
      cell = row.createCell(4);
      cell.setCellValue("종료일");
      cell = row.createCell(5);
      cell.setCellValue("학생수");
      cell = row.createCell(6);
      cell.setCellValue("반이름");

      // 컨텐츠 타입과 파일명 지정
      response.setContentType("ms-vnd/excel");
      response.setHeader("Content-Disposition", "attachment; filename=lecture.xlsx");

      // Excel File Output
      wb.write(response.getOutputStream());
      wb.close();
	}
	
	@RequestMapping(emplDown)
	public void emplDown(HttpServletResponse response) throws IOException {
	  // Workbook wb = new HSSFWorkbook();
      Workbook wb = new XSSFWorkbook();
      Sheet sheet = wb.createSheet("직원 아이디 추가");
      Row row = null;
      Cell cell = null;
      int rowNum = 0;

      // Header
      row = sheet.createRow(rowNum++);
      cell = row.createCell(0);
      cell.setCellValue("이름");
      cell = row.createCell(1);
      cell.setCellValue("아이디");
      cell = row.createCell(2);
      cell.setCellValue("비밀번호");
      cell = row.createCell(3);
      cell.setCellValue("카테고리");
      cell = row.createCell(4);
      cell.setCellValue("전화번호");
      cell = row.createCell(5);
      cell.setCellValue("이메일");
      cell = row.createCell(6);
      cell.setCellValue("성별(남/여)");
      cell = row.createCell(7);
      cell.setCellValue("생년월일");

      // 컨텐츠 타입과 파일명 지정
      response.setContentType("ms-vnd/excel");
      response.setHeader("Content-Disposition", "attachment; filename=empl.xlsx");

      // Excel File Output
      wb.write(response.getOutputStream());
      wb.close();
	}
	
	@RequestMapping(stuDown)
	public void stuDown(HttpServletResponse response) throws IOException {
	  // Workbook wb = new HSSFWorkbook();
      Workbook wb = new XSSFWorkbook();
      Sheet sheet = wb.createSheet("학생 아이디 추가");
      Row row = null;
      Cell cell = null;
      int rowNum = 0;

      // Header
      row = sheet.createRow(rowNum++);
      cell = row.createCell(0);
      cell.setCellValue("이름");
      cell = row.createCell(1);
      cell.setCellValue("아이디");
      cell = row.createCell(2);
      cell.setCellValue("비밀번호");
      cell = row.createCell(3);
      cell.setCellValue("전화번호");
      cell = row.createCell(4);
      cell.setCellValue("이메일");
      cell = row.createCell(5);
      cell.setCellValue("성별");
      cell = row.createCell(6);
      cell.setCellValue("생년월일");

      // 컨텐츠 타입과 파일명 지정
      response.setContentType("ms-vnd/excel");
      response.setHeader("Content-Disposition", "attachment; filename=student.xlsx");

      // Excel File Output
      wb.write(response.getOutputStream());
      wb.close();
	}
}
