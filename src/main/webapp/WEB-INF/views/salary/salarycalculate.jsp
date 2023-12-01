<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<title>급여입력</title>
</head>
<body>
<style>
	.table {
		display: block;
		max-height: 430px; 
		overflow-y: scroll;
		white-space: nowrap;  
	}
	
	table {
		width: 100%;
	}
	
	thead th {
		position: sticky; top:0;
		background-color: lightgray;
	}
	
	tfoot th {
		position: sticky; bottom:0;
		background-color: lightgray;
	}
	
	table th, table td {
		border: 1px solid #c0c0c0; 
		padding: 5px;
		text-align: center;
	}	
	
	#table-calcuration input {
		height: 24px;
	}
	
	#auto-calculate, #btn-save, #btn-delete {
		width:80px;
	}
</style>
<c:set var="menu" value="pay" />
<%@ include file="../common/navbar.jsp" %>
<c:set var="side" value="salary-calculate" />
<div class="container">
	<div class="row">
		<div class="col-2 bg-dark mr-3">
			<%@ include file="../common/sidebar.jsp" %>
		</div>
	
		<div class="col-10">
			<div class="row">
				<div class="col-12">
					<h2><strong>급여입력</strong></h2>
					<li>월별, 사원들의 급여정보를 저장, 수정, 삭제할 수 있습니다.</li>
					<li>급여를 입력할 때에는 기준연월, 정산기간, 급여지급일을 지정해주시기 바랍니다.</li>
				</div>
			</div>
			<hr>
			<form id="form-salary" action="/salary/salarycalculate">
				<div class="row mt-3">
					<div class="col-12">
							<label>기준연월</label> <input type="month" name="baseYearMonth" value="${param.baseYearMonth }"/> &nbsp; 
							<label>정산기간</label> <input type="date" name="startDate" value="${param.startDate }"/> ~ <input type="date" name="endDate" value="${param.endDate }"/> &nbsp; 
							<label>급여지급일</label> <input type="date" name="payDate" value="${param.payDate }"/> &nbsp; 
					</div>	
					<div class="row mt-4">
						<div class="col-7">
							<h6><strong>급여대상</strong></h6>
						</div>
						<div class="col-5">
							<h6><strong>급여입력</strong></h6>
						</div>
					</div>
					<div class="row mt-1">
						<div class="col-7">
					        <div class="table" border="3" id="table-salaries">
					        	<table>
									<thead>
										<tr>
											<th>사원번호</th>
											<th>성 명</th>
											<th>부 서</th>
											<th>지급총액</th>
											<th>공제총액</th>
											<th>실지급액</th>
										</tr>
									</thead>  
									<tbody>
										<c:choose>
											<c:when test="${empty TableDto }">
												<tr>
													<td colspan="6" class="text-center">기준연월을 선택해주십시오.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach var="salaryDto" items="${TableDto.salaryDtoLists }">
													<tr>
														<td>${salaryDto.employeeNo }</td>
														<td><a href="" data-employee-no="${salaryDto.employeeNo }" data-salary-calculated="${salaryDto.totalSalary gt 0 ? 'Y' : 'N'}" 
														class="text-decoration-none"> ${salaryDto.name }</a></td>
														<td>${salaryDto.deptName }</td>
														<td><fmt:formatNumber value="${salaryDto.totalSalary }" /></td>
														<td><fmt:formatNumber value="${salaryDto.deductionSalary }" /></td>
														<td><fmt:formatNumber value="${salaryDto.realSalary }" /></td>
													</tr>
												</c:forEach>
											</c:otherwise>	
										</c:choose>	
									</tbody>
									<tfoot>
										<tr>
											<th colspan="3">합&emsp;&emsp;&emsp;계</th>
											<th><fmt:formatNumber value="${TableDto.totalSalary }" /></th>
											<th><fmt:formatNumber value="${TableDto.deductionSalary }" /></th>
											<th><fmt:formatNumber value="${TableDto.realSalary }" /></th>
										</tr>
									</tfoot>	
								</table>	
							</div>
						</div>
					
						<div class="col-5">
							<div class="table" border="3" id="table-calcuration">
							<table>
								<colgroup>  
									<col width="25%">
									<col width="25%">
									<col width="25%">
									<col width="25%">		
								</colgroup>
								<thead>
									<tr>
										<th colspan="2">지급항목</th>
										<th colspan="2">공제항목</th>
									</tr>
								</thead>  
								<tbody>
									<tr>
										<td>기본급</td>
										<td><input type="text" size="6" maxlength="10" id="base-salary"/></td>
										<td>소득세</td>
										<td><input type="text" size="6" maxlength="10" id="income-tax"/></td>
									</tr>
									<tr>
										<td>식대</td>
										<td><input type="text" size="6" maxlength="10" id="meal-salary"/></td>
										<td>주민세</td>
										<td><input type="text" size="6" maxlength="10" id="residence-tax"/></td>
									</tr>
									<tr>
										<td>연장수당</td>
										<td><input type="text" size="6" maxlength="10" id="overtime-salary"/></td>
										<td>국민연금</td>
										<td><input type="text" size="6" maxlength="10" id="national-pension"/></td>
									</tr>
									<tr>
										<td>야간수당</td>
										<td><input type="text" size="6" maxlength="10" id="night-salary"/></td>
										<td>건강보험</td>
										<td><input type="text" size="6" maxlength="10" id="health-insurance"/></td>
									</tr>
									<tr>
										<td>휴일근무수당</td>
										<td><input type="text" size="6" maxlength="10" id="holiday-salary"/></td>
										<td>장기요양보험</td>
										<td><input type="text" size="6" maxlength="10" id="longterm-insurance"/></td>
									</tr>
									<tr>
										<td>보육수당</td>
										<td><input type="text" size="6" maxlength="10" id="care-salary"/></td>
										<td>고용보험</td>
										<td><input type="text" size="6" maxlength="10" id="employment-insurance"/></td>
									</tr>
									<tr>
										<td>출장비</td>
										<td><input type="text" size="6" maxlength="10" id="business-salary"/></td>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td>상여금</td>
										<td><input type="text" size="6" maxlength="10" id="reward-salary"/></td>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<th>지급총액</th>
										<th><input type="text" size="6" id="total-salary"/></th>
										<th>공제총액</th>
										<th><input type="text" size="6" id="deduction-salary"/></th>
									</tr>
								</tbody>	
								<tfoot>
									<tr>
										<th colspan="4"><span>실지급액:</span><span id="real-salary"></span>원</th>
									</tr>
								</tfoot>
							</table>
							</div>
							<button type="button" class="btn btn-warning btn-sm" id="auto-calculate">자동합계</button>
							&emsp;&emsp;&nbsp;
							<button type="button" class="btn btn-primary btn-sm" id="btn-save">저장</button>
							<button type="button" class="btn btn-secondary btn-sm" id="btn-delete">삭제하기</button>
						</div>
					</div>
				</div>	
			</form>
		</div>
	</div>
</div>			
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
$(function() {	
	// 기준연월 변경시 급여대상 테이블에 값 불러오기
	$("input[name=baseYearMonth]").change(function() {
		$("input[name=startDate]").val("");
		$("input[name=endDate]").val("");
		$("input[name=payDate]").val("");
		$("#form-salary").trigger("submit");
	})
	
	// 정산기간 날짜 유효성검사하기
	let $startDate = $("input[name=startDate]");
	let $endDate = $("input[name=endDate]");
	
	$endDate.change(function(){
		if($startDate.val() == "") {
			alert("시작일자를 먼저 선택하세요.");
			$endDate.val("");
		}
		if($startDate.val() > $endDate.val()) {
			alert("종료일자가 시작일자보다 이른 날짜일 수 없습니다.");
			$endDate.val("");
		}
	})
	
	// 전역변수 선언
	let selectedEmployeeNo;
	let selectedMonth;
	let selectedTotalSalary;   
	let selectedDeductionSalary;
	let selectedRealSalary;
	
	// 급여정보 조회하기
	$("#table-salaries a[data-employee-no]").click(function(event) {
		clearTable();
		event.preventDefault();
		$(this).closest("tr").addClass("table-primary")
    	 	   .siblings().removeClass("table-primary");
		let no = $(this).attr('data-employee-no');              
		let month = $("input[name=baseYearMonth]").val();
		let completed = $(this).attr('data-salary-calculated');    
		let totalSalary = $(this).closest("tr").find("td:eq(3)");      
		let deductionSalary = $(this).closest("tr").find("td:eq(4)");  
		let realSalary = $(this).closest("tr").find("td:eq(5)");
		
		if (completed == "Y") {
			setSalaryHistory(no, month);
		} else if (completed == "N") {
			setSalaryBasicInfo(no, month);
		}
		
		// 전역변수에 값 넣기
		selectedEmployeeNo = no;
		selectedMonth = month;
		selectedTotalSalary = totalSalary;  
		selectedDeductionSalary = deductionSalary;
		selectedRealSalary = realSalary;
	})
	
	// 사원 급여 정보 가져오기
	function setSalaryHistory(no, month) {
		$.ajax({
			type: 'GET',
			url: '/salary/calculatedSalary',
			data: {employeeNo : no, baseYearMonth : month},
			dataType: 'json',
			success: function(salary) {
				$("input[name=baseYearMonth]").val(salary.baseYearMonth);
				$("input[name=startDate]").val(salary.startDate);
				$("input[name=endDate]").val(salary.endDate);
				$("input[name=payDate]").val(salary.payDate);
				let baseSalary = new Number(salary.baseSalary).toLocaleString();
				$("#base-salary").val(baseSalary);
				let incomeTax = new Number(salary.incomeTax).toLocaleString();
				$("#income-tax").val(incomeTax);
				let mealSalary = new Number(salary.mealSalary).toLocaleString();
				$("#meal-salary").val(mealSalary);
				let residenceTax = new Number(salary.residenceTax).toLocaleString();
				$("#residence-tax").val(residenceTax);
				let overtimeSalary = new Number(salary.overtimeSalary).toLocaleString();
				$("#overtime-salary").val(overtimeSalary);
				let pension = new Number(salary.pension).toLocaleString();
				$("#national-pension").val(pension);
				let nightSalary = new Number(salary.nightSalary).toLocaleString();
				$("#night-salary").val(nightSalary);
				let healthInsurance = new Number(salary.healthInsurance).toLocaleString();
				$("#health-insurance").val(healthInsurance);
				let holidaySalary = new Number(salary.holidaySalary).toLocaleString();
				$("#holiday-salary").val(holidaySalary);
				let longtermInsurance = new Number(salary.longtermInsurance).toLocaleString();
				$("#longterm-insurance").val(longtermInsurance);
				let careSalary = new Number(salary.careSalary).toLocaleString();
				$("#care-salary").val(careSalary);
				let employmentInsurance = new Number(salary.employmentInsurance).toLocaleString();
				$("#employment-insurance").val(employmentInsurance);
				let businessSalary = new Number(salary.businessSalary).toLocaleString();
				$("#business-salary").val(businessSalary);
				let rewardSalary = new Number(salary.rewardSalary).toLocaleString();
				$("#reward-salary").val(rewardSalary);
				let totalSalary = new Number(salary.totalSalary).toLocaleString();
				$("#total-salary").val(totalSalary);
				let deductionSalary = new Number(salary.deductionSalary).toLocaleString();
				$("#deduction-salary").val(deductionSalary);
				let realSalary = new Number(salary.realSalary).toLocaleString();
				$("#real-salary").text(realSalary);
			}
		})
	}
	
	// 급여내역 없는 사원의 기본정보 가져오기
	function setSalaryBasicInfo(no, month) {
		$.ajax({
			type: 'GET',
			url: '/salary/basicInfo',
			data: {employeeNo : no, baseYearMonth : month},
			dataType: 'json',
			success: function(salaryInfo) {
				let baseSalary = new Number(salaryInfo.baseSalary).toLocaleString();
				$("#base-salary").val(baseSalary);
			}
		})
	}
	
	// input태그 값 리셋하기
	function clearTable() {
		$("#base-salary").val(0);
		$("#income-tax").val(0);
		$("#meal-salary").val(0);
		$("#residence-tax").val(0);
		$("#overtime-salary").val(0);
		$("#national-pension").val(0);
		$("#night-salary").val(0);
		$("#health-insurance").val(0);
		$("#holiday-salary").val(0);
		$("#longterm-insurance").val(0);
		$("#care-salary").val(0);
		$("#employment-insurance").val(0);
		$("#business-salary").val(0);
		$("#reward-salary").val(0);
		$("#total-salary").val(0);
		$("#deduction-salary").val(0);
		$("#real-salary").text(0);
	}
	
	// 자동계산
	$("#auto-calculate").click(function() {
		let baseSalary = parseInt($("#base-salary").val().replaceAll(",", ""));
		let mealSalary = parseInt($("#meal-salary").val().replaceAll(",", ""));
		let overtimeSalary = parseInt($("#overtime-salary").val().replaceAll(",", ""));
		let nightSalary = parseInt($("#night-salary").val().replaceAll(",", ""));
		let holidaySalary = parseInt($("#holiday-salary").val().replaceAll(",", ""));
		let careSalary = parseInt($("#care-salary").val().replaceAll(",", ""));
		let businessSalary = parseInt($("#business-salary").val().replaceAll(",", ""));
		let rewardSalary = parseInt($("#reward-salary").val().replaceAll(",", ""));
		let incomeTax = parseInt($("#income-tax").val().replaceAll(",", ""));
		let residenceTax = parseInt($("#residence-tax").val().replaceAll(",", ""));
		let pension = parseInt($("#national-pension").val().replaceAll(",", ""));
		let healthInsurance = parseInt($("#health-insurance").val().replaceAll(",", ""));
		let longtermInsurance = parseInt($("#longterm-insurance").val().replaceAll(",", ""));
		let employmentInsurance = parseInt($("#employment-insurance").val().replaceAll(",", ""));
		let totalSalary = baseSalary + mealSalary + overtimeSalary + nightSalary + holidaySalary + careSalary + businessSalary + rewardSalary;
		let deductionSalary = incomeTax + residenceTax + pension + healthInsurance + longtermInsurance + employmentInsurance;
		$("#total-salary").val((totalSalary).toLocaleString());
		$("#deduction-salary").val((deductionSalary).toLocaleString());
		$("#real-salary").text((totalSalary-deductionSalary).toLocaleString());
	})
	
	// 급여정보 저장하기 - 입력된 값 읽기
	$("#btn-save").click(function() {
		
		let baseYearMonth = $("input[name=baseYearMonth]").val();
		let startDate = $("input[name=startDate]").val();
		let endDate = $("input[name=endDate]").val();
		let payDate = $("input[name=payDate]").val();
		if (baseYearMonth=="") {
			alert("기준연월을 선택하세요.");
			return false;
		}
		if (startDate=="") {
			alert("정산시작기간을 선택하세요.");
			return false;
		}
		if (endDate=="") {
			alert("정산마감기간을 선택하세요.");
			return false;
		}
		if (payDate=="") {
			alert("급여지급일을 선택하세요.");
			return false;
		}
		let salary = {
			employeeNo : selectedEmployeeNo,	
			baseYearMonth : $("input[name=baseYearMonth]").val(),
			startDate : $("input[name=startDate]").val(),
			endDate : $("input[name=endDate]").val(),
			payDate : $("input[name=payDate]").val(),
			baseSalary : $("#base-salary").val().replaceAll(",", ""),
			mealSalary : $("#meal-salary").val().replaceAll(",", ""),
			overtimeSalary : $("#overtime-salary").val().replaceAll(",", ""),
			nightSalary : $("#night-salary").val().replaceAll(",", ""),
			holidaySalary : $("#holiday-salary").val().replaceAll(",", ""),
			careSalary : $("#care-salary").val().replaceAll(",",""),
			businessSalary : $("#business-salary").val().replaceAll(",", ""),
			rewardSalary : $("#reward-salary").val().replaceAll(",", ""),
			incomeTax : $("#income-tax").val().replaceAll(",", ""),
			residenceTax : $("#residence-tax").val().replaceAll(",", ""),
			pension : $("#national-pension").val().replaceAll(",", ""),
			healthInsurance : $("#health-insurance").val().replaceAll(",", ""),
			longtermInsurance : $("#longterm-insurance").val().replaceAll(",", ""),
			employmentInsurance : $("#employment-insurance").val().replaceAll(",", "")
		}
		
		let saveSalary = JSON.stringify(salary);
		
		// 급여정보 저장하기 - 급여내역 있는 사원의 급여 수정하기와 급여내역 없는 사원의 급여 저장하기
		if ($("#table-salaries tbody tr.table-primary a").attr('data-salary-calculated') == "Y") {
			updateSalary();
		} else if ($("#table-salaries tbody tr.table-primary a").attr('data-salary-calculated') == "N") {
			storeSalary();
		}
		function storeSalary(){
			$.ajax({
				type : 'POST',
				url : '/salary/saveSalary',
				data : saveSalary,
				contentType : 'application/json',
				dataType : 'json',
				success : function(savedSalary) {
				 	let totalSalary = new Number(savedSalary.totalSalary).toLocaleString();       
					selectedTotalSalary.text(totalSalary);           
					$("#total-salary").val(totalSalary);
					let deductionSalary = new Number(savedSalary.deductionSalary).toLocaleString();
					selectedDeductionSalary.text(deductionSalary);
					$("#deduction-salary").val(deductionSalary);
					let realSalary = new Number(savedSalary.realSalary).toLocaleString();
					selectedRealSalary.text(realSalary); 
					$("#real-salary").text(realSalary); 					
										
					// 저장과 동시에 합계 출력하기
					generateTotalSalary();
					
					// 저장버튼 클릭 후에 다시 사원을 클릭해도 저장한 급여가 출력되도록 하기
					$("#table-salaries tbody tr.table-primary a").attr('data-salary-calculated', "Y");   

					alert("저장되었습니다.");
				}
			})
		}	
		
		// 급여정보 수정하기
		function updateSalary(){
			$.ajax({
				type : 'PUT',
				url : '/salary/updateSalary',
				data : saveSalary,
				contentType : 'application/json',
				dataType : 'json',
				success : function(updatedSalary) {
					let totalSalary = new Number(updatedSalary.totalSalary).toLocaleString();        
					selectedTotalSalary.text(totalSalary);    
					$("#total-salary").val(totalSalary);
					let deductionSalary = new Number(updatedSalary.deductionSalary).toLocaleString();
					selectedDeductionSalary.text(deductionSalary);
					$("#deduction-salary").val(deductionSalary);
					let realSalary = new Number(updatedSalary.realSalary).toLocaleString();
					selectedRealSalary.text(realSalary);
					$("#real-salary").text(realSalary);
					
					generateTotalSalary();
					
					alert("수정되었습니다.");	
				}
			})
		}
	})
	
	// 급여내역 삭제하기
	$("#btn-delete").click(function() {
		let answer = confirm('삭제하시겠습니까?');
		if (answer) {
			$.ajax({
				type: "GET",
				url: "/salary/deleteSalary",
				data: {employeeNo : selectedEmployeeNo, baseYearMonth : selectedMonth},
				success: function() {
					$("input[name=startDate]").val("");
					$("input[name=endDate]").val("");
					$("input[name=payDate]").val("");
					$("#base-salary").val(0);
					$("#income-tax").val(0);
					$("#meal-salary").val(0);
					$("#residence-tax").val(0);
					$("#overtime-salary").val(0);
					$("#national-pension").val(0);
					$("#night-salary").val(0);
					$("#health-insurance").val(0);
					$("#holiday-salary").val(0);
					$("#longterm-insurance").val(0);
					$("#care-salary").val(0);
					$("#employment-insurance").val(0);
					$("#business-salary").val(0);
					$("#reward-salary").val(0);
					$("#total-salary").val(0);
					$("#deduction-salary").val(0);
					$("#real-salary").text(0);
					selectedTotalSalary.text(0); 
					selectedDeductionSalary.text(0);
					selectedRealSalary.text(0); 
					
					generateTotalSalary();
					setSalaryBasicInfo(selectedEmployeeNo, selectedMonth);
					
					// 'N'으로 바꿔줘야 사원을 재선택할 경우에도 기본급이 0이 아닌 해당 사원의 기본급이 출력된다.
					$("#table-salaries tbody tr.table-primary a").attr('data-salary-calculated', "N");
				}
			})
		}
	})
	
	// 저장과 동시에 급여대상의 합계 출력하기
	function generateTotalSalary() {
		
		let sum_totalSalary = 0;              
		$("#table-salaries tbody td:nth-child(4)").each(function(index, td) {
			let totalSalary = $(td).text().replaceAll(",",'');
			sum_totalSalary += parseInt(totalSalary);
		})
		$("#table-salaries tfoot th:nth-child(2)").text(sum_totalSalary.toLocaleString());
		
		let sum_deductionSalary = 0;
		$("#table-salaries tbody td:nth-child(5)").each(function(index, td) {
			let deductionSalary = $(td).text().replaceAll(",",'');
			sum_deductionSalary += parseInt(deductionSalary);
		})
		$("#table-salaries tfoot th:nth-child(3)").text(sum_deductionSalary.toLocaleString());
		
		let sum_realSalary = 0;
		$("#table-salaries tbody td:nth-child(6)").each(function(index, td) {
			let realSalary = $(td).text().replaceAll(",",'');
			sum_realSalary += parseInt(realSalary);
		})
		$("#table-salaries tfoot th:nth-child(4)").text(sum_realSalary.toLocaleString());

	}
	
})

</script>
</body>
</html>
