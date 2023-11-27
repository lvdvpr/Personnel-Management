package com.last.dto;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Alias("periodDto")
@Setter
@Getter
public class SalaryPeriodDto {	 // 기간별 급여현황 - 급여총계
	
	private int employeeNo;      // 사원번호
	private String name;         // 사원명
	private int totalSalary;     // 지급총액 
	private int deductionSalary; // 공제총액
	private int realSalary;      // 실지급액
}
