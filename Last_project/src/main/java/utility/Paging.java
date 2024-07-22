package utility;

public class Paging {
   //페이징 관련 변수   
   private int totalCount = 0 ; //총 레코드 건수
   private int totalPage = 0 ; 	//전체 페이지 수
   private int pageNumber = 0 ; //보여줄 페이지 번호
   private int pageSize = 0 ; 	//한 페이지에 보여줄 건수
   private int beginRow = 0 ; 	//현재 페이지의 시작 행
   private int endRow = 0 ; 	//현재 페이지의 끝 행
   private int pageCount = 3 ; 	//한 화면에 보여줄 페이지 링크 수 (페이지 갯수)
   private int beginPage = 0 ; 	//페이징 처리 시작 페이지 번호
   private int endPage = 0 ; 	//페이징 처리 끝 페이지 번호
   private int offset = 0 ;
   private int limit = 0 ;
   private String url = "" ;
   private String pagingHtml = ""; //하단의 숫자 페이지 링크
   
   //검색을 위한 변수 추가
   private String whatColumn = "" ; //검색 모드(작성자, 글제목, 전체 검색은 all) 등등
   private String keyword = "" ; //검색할 단어 
   private String mem_num = "" ; //문서별 페이징
   private String sender_num = "" ; //문서별 페이징
   
   private String read_chk = ""; // 메신저 안 읽은 메시지 보기 페이징 
   
   public int getTotalCount() {
      return totalCount;
   }


   public void setTotalCount(int totalCount) {
      this.totalCount = totalCount;
   }


   public int getTotalPage() {
      return totalPage;
   }


   public void setTotalPage(int totalPage) {
      this.totalPage = totalPage;
   }


   public int getPageNumber() {
      return pageNumber;
   }


   public void setPageNumber(int pageNumber) {
      this.pageNumber = pageNumber;
   }


   public int getPageSize() {
      return pageSize;
   }


   public void setPageSize(int pageSize) {
      this.pageSize = pageSize;
   }


   public int getBeginRow() {
      return beginRow;
   }


   public void setBeginRow(int beginRow) {
      this.beginRow = beginRow;
   }


   public int getEndRow() {
      return endRow;
   }


   public void setEndRow(int endRow) {
      this.endRow = endRow;
   }


   public int getPageCount() {
      return pageCount;
   }


   public void setPageCount(int pageCount) {
      this.pageCount = pageCount;
   }


   public int getBeginPage() {
      return beginPage;
   }


   public void setBeginPage(int beginPage) {
      this.beginPage = beginPage;
   }


   public int getEndPage() {
      return endPage;
   }


   public void setEndPage(int endPage) {
      this.endPage = endPage;
   }


   public int getOffset() {
      return offset;
   }


   public void setOffset(int offset) {
      this.offset = offset;
   }


   public int getLimit() {
      return limit;
   }


   public void setLimit(int limit) {
      this.limit = limit;
   }


   public String getUrl() {
      return url;
   }


   public void setUrl(String url) {
      this.url = url;
   }


   public String getPagingHtml() {
      System.out.println("pagingHtml:"+pagingHtml);
      
      return pagingHtml;
//      pagingHtml:
//         &nbsp;<font color='red'>1</font>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=2&pageSize=2&whatColumn=null&keyword=null'>2</a>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=3&pageSize=2&whatColumn=null&keyword=null'>3</a>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=4&pageSize=2&whatColumn=null&keyword=null'>4</a>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=5&pageSize=2&whatColumn=null&keyword=null'>5</a>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=6&pageSize=2&whatColumn=null&keyword=null'>6</a>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=7&pageSize=2&whatColumn=null&keyword=null'>7</a>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=8&pageSize=2&whatColumn=null&keyword=null'>8</a>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=9&pageSize=2&whatColumn=null&keyword=null'>9</a>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=10&pageSize=2&whatColumn=null&keyword=null'>10</a>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=11&pageSize=2&whatColumn=null&keyword=null'>다음</a>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=22&pageSize=2&whatColumn=null&keyword=null'>맨 끝</a>&nbsp;

   }


   public void setPagingHtml(String pagingHtml) {
      this.pagingHtml = pagingHtml;
   }


   public String getWhatColumn() {
      return whatColumn;
   }


   public void setWhatColumn(String whatColumn) {
      this.whatColumn = whatColumn;
   }


   public String getKeyword() {
      return keyword;
   }


   public void setKeyword(String keyword) {
      this.keyword = keyword;
   }
   
   

   public String getMem_num() {
	return mem_num;
}


public void setMem_num(String mem_num) {
	this.mem_num = mem_num;
}


public String getSender_num() {
	return sender_num;
}


public void setSender_num(String sender_num) {
	this.sender_num = sender_num;
}


public String getRead_chk() {
	return read_chk;
}


public void setRead_chk(String read_chk) {
	this.read_chk = read_chk;
}




/* Notice paging */
public Paging(
	    String _pageNumber, 
	    String _pageSize,  
	    int totalCount,
	    String url, 
	    String whatColumn, 
	    String keyword) {      

	    if (_pageNumber == null || _pageNumber.equals("null") || _pageNumber.equals("")) {
	        _pageNumber = "1";
	    }
	    this.pageNumber = Integer.parseInt(_pageNumber);

	    // 기본 pageSize를 10으로 설정
	    if (_pageSize == null || _pageSize.equals("null") || _pageSize.equals("")) {
	        _pageSize = "10"; // 한 페이지에 보여줄 레코드 갯수
	    }
	    this.pageSize = Integer.parseInt(_pageSize);

	    this.limit = pageSize; // 한 페이지에 보여줄 레코드 갯수

	    this.totalCount = totalCount;

	    this.totalPage = (int) Math.ceil((double) this.totalCount / this.pageSize);
	    // ex) 17.0/2 = 8.5 => 9

	    this.beginRow = (this.pageNumber - 1) * this.pageSize + 1;
	    // 현재 페이지의 시작 행

	    this.endRow = this.pageNumber * this.pageSize;
	    // 현재 페이지의 마지막 행

	    if (this.pageNumber > this.totalPage) {
	        this.pageNumber = this.totalPage;
	    }
	    // 마지막 페이지에 하나 남았다면 그것을 삭제했을 때, 마지막 페이지 없애기 설정

	    this.offset = (pageNumber - 1) * pageSize;
	    
	    if (this.endRow > this.totalCount) {
	        this.endRow = this.totalCount;
	    }

	    this.beginPage = (this.pageNumber - 1) / this.pageCount * this.pageCount + 1;
	    this.endPage = this.beginPage + this.pageCount - 1;
	    /* pageCount=10: 한 화면에 보일 페이지 수,
	       pageNumber(현재 클릭한 페이지 수)가 12이면 beginPage = 11이 되고, endPage=20이 된다. */

	    System.out.println("pageNumber: " + pageNumber + "/totalPage: " + totalPage);

	    if (this.endPage > this.totalPage) {
	        this.endPage = this.totalPage;
	    }

	    System.out.println("pageNumber2: " + pageNumber + "/totalPage2: " + totalPage);
	    this.url = url; //  /ex/list.ab
	    this.whatColumn = whatColumn;
	    this.keyword = keyword;
	    System.out.println("whatColumn: " + whatColumn + "/keyword: " + keyword);

	    this.pagingHtml = getPagingHtml(url);
	}
/* Notice paging */

public Paging(
         String _pageNumber, 	// 보여줄 페이지 번호
         String _pageSize,  	// 한페이지에 보여줄 건수
         int totalCount,		// 총 레코드 건수
         String url, 			// 다음 요청
         String whatColumn, 	// 검색 컬럼
         String keyword,			// 검색 키워드
         String mem_num,			// 받는사람
         String sender_num			// 보낸사람
         ) {      

      if(  _pageNumber == null || _pageNumber.equals("null") || _pageNumber.equals("")  ){
         System.out.println("_pageNumber:"+_pageNumber); // null
         _pageNumber = "1" ;
      }
      this.pageNumber = Integer.parseInt( _pageNumber ) ; 

      if( _pageSize == null || _pageSize.equals("null") || _pageSize.equals("") ){
         _pageSize = "5" ; // 한 페이지에 보여줄 레코드 갯수
      }      
      this.pageSize = Integer.parseInt( _pageSize ) ;
      
      this.limit = pageSize ; // 한 페이지에 보여줄 레코드 갯수

      this.totalCount = totalCount ; 
      
      this.mem_num = mem_num ; 
      
      this.sender_num = sender_num ; 

      this.totalPage = (int)Math.ceil((double)this.totalCount / this.pageSize) ; // ceil 반올림
      
      this.beginRow = ( this.pageNumber - 1 )  * this.pageSize  + 1 ;	// 현재 페이지 시작 건수번호
      this.endRow =  this.pageNumber * this.pageSize ;					// 현제 페이지 끝 건수번호
      // pageNumber가 2이면 beginRow=6, endRow=10
      
      if( this.pageNumber > this.totalPage ){
         this.pageNumber = this.totalPage ;
      }
      // 마지막페이지의 마지막하나레코드 삭제시 하나 적은 페이지로 가도록함
      
      this.offset = ( pageNumber - 1 ) * pageSize ; 
      /*offset : 건너뛰어야할 레코드개수
         한 페이지에 2개씩 출력할 때,
         3페이지 클릭하면 앞에 4개 건너뛰고 5번째 부터 나와야 한다. 
         위의 offset = (3-1)*2 => 4(건너뛸 갯수가 된다.)
      */   
      if( this.endRow > this.totalCount ){
         this.endRow = this.totalCount  ;
      }

      this.beginPage = ( this.pageNumber - 1 ) / this.pageCount * this.pageCount + 1  ;
      this.endPage = this.beginPage + this.pageCount - 1 ;
      /*pageCount=10 : 한 화면에 보일 페이지 수,
      pageNumber(현재 클릭한 페이지 수)가 12이면 beginPage = 11이 되고, endPage=20이 된다. */
      
      System.out.println("pageNumber:"+pageNumber+"/totalPage:"+totalPage);   
      
      if( this.endPage > this.totalPage ){
         this.endPage = this.totalPage ;
      }
      
      System.out.println("pageNumber2:"+pageNumber+"/totalPage2:"+totalPage);   
      this.url = url ; //  /ex/list.ab
      this.whatColumn = whatColumn ;
      this.keyword = keyword ;
      System.out.println("whatColumn:"+whatColumn+"/keyword:"+keyword);
      
      this.pagingHtml = getPagingHtml(url) ;
   
   }
   
<<<<<<< HEAD
   private String getPagingHtml( String url ){ //페이징 문자열을 만든다.
      System.out.println("getPagingHtml url:"+url); 
   
      
      String result = "" ;
      //added_param 변수 : 검색 관련하여 추가되는 파라미터 리스트
      String added_param = "&whatColumn=" + whatColumn + "&keyword=" + keyword+ "&mem_num=" + mem_num+ "&sender_num=" + sender_num + "&read_chk=" + read_chk  ; // &whatColumn=singer&keyword=아
      
      
      if (this.beginPage != 1) { // 앞쪽, pageSize:한 화면에 보이는 레코드 수
         // 처음 목록보기를 하면 pageNumber는 1이 되고 beginPage도 1이 된다. 
         result += "&nbsp;<a href='" + url  
               + "?pageNumber=" + ( 1 ) + "&pageSize=" + this.pageSize 
               + added_param + "'>[맨 처음]</a>&nbsp;" ;
         result += "&nbsp;<a href='" + url 
               + "?pageNumber=" + (this.beginPage - 1 ) + "&pageSize=" + this.pageSize 
               + added_param + "'>[이전]</a>&nbsp;" ;
      }
      
      //가운데
      for (int i = this.beginPage; i <= this.endPage ; i++) {
         if ( i == this.pageNumber ) {
            result += "&nbsp;<font color='red'>" + i + "</font>&nbsp;"   ;
                  
         } else {
            result += "&nbsp;<a href='" + url   
                  + "?pageNumber=" + i + "&pageSize=" + this.pageSize 
                  + added_param + "'>" + i + "</a>&nbsp;" ;
            
         }
      }
      
      System.out.println("result:"+result);
      System.out.println();
      // result:&nbsp;<a href='/ex/list.ab?pageNumber=1&pageSize=2&whatColumn=null&keyword=null'>1</a>&nbsp;&nbsp;<font color='red'>2</font>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=3&pageSize=2&whatColumn=null&keyword=null'>3</a>&nbsp;
      
      if ( this.endPage != this.totalPage) { // 뒤쪽
         // endPage:지금 보는 페이지의 끝(지금 보는 페이지가 13이라면 endPage는 20), totalPage:전체 페이지수
         
         result += "&nbsp;<a href='" + url  
               + "?pageNumber=" + (this.endPage + 1 ) + "&pageSize=" + this.pageSize 
               + added_param + "'>[다음]</a>&nbsp;" ;
         
         result += "&nbsp;<a href='" + url  
               + "?pageNumber=" + (this.totalPage ) + "&pageSize=" + this.pageSize 
               + added_param + "'>[맨 끝]</a>&nbsp;" ;
      }      
      System.out.println("result2:"+result);
      // result2 : <a href='/ex/list.ab?pageNumber=1&pageSize=2'>맨 처음</a>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=3&pageSize=2&whatColumn=null&keyword=null'>이전</a>&nbsp;&nbsp;<font color='red'>4</font>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=5&pageSize=2&whatColumn=null&keyword=null'>5</a>&nbsp;
      
      return result ;
   }
   
   /* 메신저 안읽은 메시지 페이징처리 */
   /* ------- 수진 -------- */
   public Paging(
		    String _pageNumber, 
		    String _pageSize,  
		    int totalCount,
		    String url, 
		    String whatColumn, 
		    String keyword,
		    String read_chk) {      

		    if (_pageNumber == null || _pageNumber.equals("null") || _pageNumber.equals("")) {
		        _pageNumber = "1";
		    }
		    this.pageNumber = Integer.parseInt(_pageNumber);

		    // 기본 pageSize를 10으로 설정
		    if (_pageSize == null || _pageSize.equals("null") || _pageSize.equals("")) {
		        _pageSize = "10"; // 한 페이지에 보여줄 레코드 갯수
		    }
		    this.pageSize = Integer.parseInt(_pageSize);

		    this.limit = pageSize; // 한 페이지에 보여줄 레코드 갯수

		    this.totalCount = totalCount;
		    this.read_chk = read_chk;

		    this.totalPage = (int) Math.ceil((double) this.totalCount / this.pageSize);
		    // ex) 17.0/2 = 8.5 => 9

		    this.beginRow = (this.pageNumber - 1) * this.pageSize + 1;
		    // 현재 페이지의 시작 행

		    this.endRow = this.pageNumber * this.pageSize;
		    // 현재 페이지의 마지막 행

		    if (this.pageNumber > this.totalPage) {
		        this.pageNumber = this.totalPage;
		    }
		    // 마지막 페이지에 하나 남았다면 그것을 삭제했을 때, 마지막 페이지 없애기 설정

		    this.offset = (pageNumber - 1) * pageSize;
		    
		    if (this.endRow > this.totalCount) {
		        this.endRow = this.totalCount;
		    }

		    this.beginPage = (this.pageNumber - 1) / this.pageCount * this.pageCount + 1;
		    this.endPage = this.beginPage + this.pageCount - 1;
		    /* pageCount=10: 한 화면에 보일 페이지 수,
		       pageNumber(현재 클릭한 페이지 수)가 12이면 beginPage = 11이 되고, endPage=20이 된다. */

		    System.out.println("pageNumber: " + pageNumber + "/totalPage: " + totalPage);

		    if (this.endPage > this.totalPage) {
		        this.endPage = this.totalPage;
		    }

		    System.out.println("pageNumber2: " + pageNumber + "/totalPage2: " + totalPage);
		    this.url = url; //  /ex/list.ab
		    this.whatColumn = whatColumn;
		    this.keyword = keyword;
		    System.out.println("whatColumn: " + whatColumn + "/keyword: " + keyword);

		    this.pagingHtml = getPagingHtml(url);
		}
   
=======
private String getPagingHtml(String url) {
    String result = "";
    String added_param = "&whatColumn=" + whatColumn + "&keyword=" + keyword + "&mem_num=" + mem_num + "&sender_num=" + sender_num;

    if (this.beginPage != 1) {
        result += "<li class='page-item'><a class='page-link' href='" + url
                + "?pageNumber=" + (1) + "&pageSize=" + this.pageSize
                + added_param + "' style='color: #C6A2E9;'>&laquo;</a></li>";
        result += "<li class='page-item'><a class='page-link' href='" + url
                + "?pageNumber=" + (this.beginPage - 1) + "&pageSize=" + this.pageSize
                + added_param + "' style='color: #C6A2E9;'>이전</a></li>";
    }

    for (int i = this.beginPage; i <= this.endPage; i++) {
        if (i == this.pageNumber) {
            result += "<li class='page-item active'><a class='page-link' href='#' style='background-color: #C6A2E9; border-color: #C6A2E9;'>" + i + "</a></li>";
        } else {
            result += "<li class='page-item'><a class='page-link' href='" + url
                    + "?pageNumber=" + i + "&pageSize=" + this.pageSize
                    + added_param + "' style='color: #C6A2E9;'>" + i + "</a></li>";
        }
    }

    if (this.endPage != this.totalPage) {
        result += "<li class='page-item'><a class='page-link' href='" + url
                + "?pageNumber=" + (this.endPage + 1) + "&pageSize=" + this.pageSize
                + added_param + "' style='color: #C6A2E9;'>다음</a></li>";
        result += "<li class='page-item'><a class='page-link' href='" + url
                + "?pageNumber=" + (this.totalPage) + "&pageSize=" + this.pageSize
                + added_param + "' style='color: #C6A2E9;'>&raquo;</a></li>";
    }

    return "<nav aria-label='Page navigation'><ul class='pagination justify-content-center'>" + result + "</ul></nav>";
}


//   private String getPagingHtml( String url ){ //페이징 문자열을 만든다.
//      System.out.println("getPagingHtml url:"+url); 
//   
//      
//      String result = "" ;
//      //added_param 변수 : 검색 관련하여 추가되는 파라미터 리스트
//      String added_param = "&whatColumn=" + whatColumn + "&keyword=" + keyword+ "&mem_num=" + mem_num+ "&sender_num=" + sender_num ; // &whatColumn=singer&keyword=아
//      
//      
//      if (this.beginPage != 1) { // 앞쪽, pageSize:한 화면에 보이는 레코드 수
//         // 처음 목록보기를 하면 pageNumber는 1이 되고 beginPage도 1이 된다. 
//         result += "&nbsp;<a href='" + url  
//               + "?pageNumber=" + ( 1 ) + "&pageSize=" + this.pageSize 
//               + added_param + "'>[맨 처음]</a>&nbsp;" ;
//         result += "&nbsp;<a href='" + url 
//               + "?pageNumber=" + (this.beginPage - 1 ) + "&pageSize=" + this.pageSize 
//               + added_param + "'>[이전]</a>&nbsp;" ;
//      }
//      
//      //가운데
//      for (int i = this.beginPage; i <= this.endPage ; i++) {
//         if ( i == this.pageNumber ) {
//            result += "&nbsp;<font color='red'>" + i + "</font>&nbsp;"   ;
//                  
//         } else {
//            result += "&nbsp;<a href='" + url   
//                  + "?pageNumber=" + i + "&pageSize=" + this.pageSize 
//                  + added_param + "'>" + i + "</a>&nbsp;" ;
//            
//         }
//      }
//      
//      System.out.println("result:"+result);
//      System.out.println();
//      // result:&nbsp;<a href='/ex/list.ab?pageNumber=1&pageSize=2&whatColumn=null&keyword=null'>1</a>&nbsp;&nbsp;<font color='red'>2</font>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=3&pageSize=2&whatColumn=null&keyword=null'>3</a>&nbsp;
//      
//      if ( this.endPage != this.totalPage) { // 뒤쪽
//         // endPage:지금 보는 페이지의 끝(지금 보는 페이지가 13이라면 endPage는 20), totalPage:전체 페이지수
//         
//         result += "&nbsp;<a href='" + url  
//               + "?pageNumber=" + (this.endPage + 1 ) + "&pageSize=" + this.pageSize 
//               + added_param + "'>[다음]</a>&nbsp;" ;
//         
//         result += "&nbsp;<a href='" + url  
//               + "?pageNumber=" + (this.totalPage ) + "&pageSize=" + this.pageSize 
//               + added_param + "'>[맨 끝]</a>&nbsp;" ;
//      }      
//      System.out.println("result2:"+result);
//      // result2 : <a href='/ex/list.ab?pageNumber=1&pageSize=2'>맨 처음</a>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=3&pageSize=2&whatColumn=null&keyword=null'>이전</a>&nbsp;&nbsp;<font color='red'>4</font>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=5&pageSize=2&whatColumn=null&keyword=null'>5</a>&nbsp;
//      
//      return result ;
//   }   
>>>>>>> branch 'suho' of https://github.com/sonsuho/Last-project.git
   
}

