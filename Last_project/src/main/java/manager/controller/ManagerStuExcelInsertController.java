package manager.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ManagerStuExcelInsertController {

	private final String download = "emplExcelDownload.manager";
	
	@RequestMapping(download)
	public void download(HttpServletResponse response) throws IOException {
      Workbook wb = new XSSFWorkbook();
      Sheet sheet = wb.createSheet("학생 등록");
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

      // 컨텐츠 타입과 파일명 지정
      response.setContentType("ms-vnd/excel");
      response.setHeader("Content-Disposition", "attachment; filename=student.xlsx");

      // Excel File Output
      wb.write(response.getOutputStream());
      wb.close();
	}
}
