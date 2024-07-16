<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>

<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">

<style type="text/css">

	body {
	    font-family: Arial, sans-serif;
	    background-color: #F2EDF3;
	    padding: 20px;
	}
	
    .table {
        width: 100%;
        margin-bottom: 1rem;
        color: #212529;
    }

    .table th, .table td {
        padding: 0.75rem;
        vertical-align: top;
        border-top: 1px solid #dee2e6;
    }

    .table thead th {
        vertical-align: bottom;
        border-bottom: 2px solid #dee2e6;
        background-color: #007bff; /* 배경색 지정 */
        color: #ffffff; /* 글자색 지정 */
    }

    .table tbody + tbody {
        border-top: 2px solid #dee2e6;
    }

    .form-check-input {
        margin: auto;
    }

    .card-body {
        min-height: 70vh; /* viewport 높이의 50% */
    }

    .feedback {
        margin-top: 2rem;
    }

    .btn-primary {
        background-color: #007bff;
        border-color: #007bff;
    }
</style>

<script type="text/javascript">
    function evalCheck() {
        var form = document.forms[0];
        var problems = 9; // 문제의 개수
        var allChecked = true;

        for (var i = 1; i <= problems; i++) {
            var radios = form['problem' + i];
            var isChecked = false;

            for (var j = 0; j < radios.length; j++) {
                if (radios[j].checked) {
                    isChecked = true;
                    break;
                }
            }

            if (!isChecked) {
                alert(i + "번 문항이 누락되었습니다!!");
                radios[0].focus();
                allChecked = false;
                break;
            }
        }

        return allChecked;
    }
</script>

<%
    String[] problems = {
        "강의 내용과 구성은 만족스러운가?",
        "강의실 시설과 환경은 만족스러운가?",
        "강사의 수업 진행 능력은 만족스러운가?",
        "강의 진행 속도가 적당하다고 생각하는가?",
        "강의에서 제공된 학습 자료가 학습에 유효한가?",
        "강의 내용이 실무 환경에 실용적으로 적용 가능한가?",
        "강의 중 학습자의 참여가 충분한가?",
        "과제가 강의 내용을 잘 이해할 수 있게 충분한가?",
        "평가가 강의 내용을 잘 이해하는지 평가 하기에 적절한가?"
    };
%>

<c:set var="problems" value="<%=problems %>" />

<div class="container mt-4">
    <div class="card">
        <div class="card-body">
            <div class="text-center">
                <h1>${eval.eval_content}</h1>
            </div>

            <form action="evalContent.student" method="post" class="mt-4">
                <table class="table table-bordered">
                    <thead>
                        <tr align="center">
                            <th>번호</th>
                            <th>내용</th>
                            <th>매우그렇다</th>
                            <th>그렇다</th>
                            <th>보통이다</th>
                            <th>그렇지않다</th>
                            <th>매우그렇지않다</th>
                        </tr>
                    </thead>
                    <tbody>
						<c:forEach var="i" begin="0" end="8">
						    <tr>
						        <td style="width: 60px;" align="center">${i + 1}번</td>
						        <td class="text-left">${problems[i]}</td>
						        
						        <!-- 조건문을 사용하여 특정 행에만 padding을 2배로 설정 -->
						        <c:choose>
						            <c:when test="${i == 3 or i == 4 or i == 5 or i == 7 or i == 8}">
						                <td style="width: 138px; padding-top: 30px;" class="text-center"><input type="radio" name="problem${i + 1}" value="1" class="form-check-input"></td>
						                <td style="width: 138px; padding-top: 30px;" class="text-center"><input type="radio" name="problem${i + 1}" value="2" class="form-check-input"></td>
						                <td style="width: 138px; padding-top: 30px;" class="text-center"><input type="radio" name="problem${i + 1}" value="3" class="form-check-input"></td>
						                <td style="width: 138px; padding-top: 30px;" class="text-center"><input type="radio" name="problem${i + 1}" value="4" class="form-check-input"></td>
						                <td style="width: 138px; padding-top: 30px;" class="text-center"><input type="radio" name="problem${i + 1}" value="5" class="form-check-input"></td>
						            </c:when>
						            <c:otherwise>
						                <td style="width: 138px; padding-top: 15px;" class="text-center"><input type="radio" name="problem${i + 1}" value="1" class="form-check-input"></td>
						                <td style="width: 138px; padding-top: 15px;" class="text-center"><input type="radio" name="problem${i + 1}" value="2" class="form-check-input"></td>
						                <td style="width: 138px; padding-top: 15px;" class="text-center"><input type="radio" name="problem${i + 1}" value="3" class="form-check-input"></td>
						                <td style="width: 138px; padding-top: 15px;" class="text-center"><input type="radio" name="problem${i + 1}" value="4" class="form-check-input"></td>
						                <td style="width: 138px; padding-top: 15px;" class="text-center"><input type="radio" name="problem${i + 1}" value="5" class="form-check-input"></td>
						            </c:otherwise>
						        </c:choose>
						    </tr>
						</c:forEach>
                        <tr>
                            <td>10번</td>
                            <td colspan="6">
                                <textarea rows="6" class="form-control" name="req" placeholder="강사에게 하고싶은 말을 적어주세요"></textarea>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <input type="hidden" name="eval_num" value="${eval.eval_num}">

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-primary" onclick="return evalCheck()">제출하기</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Include Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
