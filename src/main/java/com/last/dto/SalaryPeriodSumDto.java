package com.last.dto;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class SalaryPeriodSumDto {   // 기간별 급여현황-급여총계의 합계

	private List<SalaryPeriodDto> salaryPeriodDtos;
	
	public int getTotalSalaryTtl() {
		int total = 0;
		for (SalaryPeriodDto dto : salaryPeriodDtos) {
			total += dto.getTotalSalary();
		}
		return total;
	}
	
	public int getReductionSalaryTtl() {
		int total = 0;
		for (SalaryPeriodDto dto : salaryPeriodDtos) {
			total += dto.getDeductionSalary();
		}
		return total;
	}
	
	public int getRealSalaryTtl() {
		int total = 0;
		for (SalaryPeriodDto dto : salaryPeriodDtos) {
			total += dto.getRealSalary();
		}
		return total;
	}
}
