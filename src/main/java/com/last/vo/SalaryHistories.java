package com.last.vo;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class SalaryHistories {

	private int employeeNo;
	private String baseYearMonth;
	private int baseSalary;
	private int overtimeSalary;
	private int nightSalary;
	private int holidaySalary;
	private int careSalary;
	private int rewardSalary;
	private int mealSalary;
	private int businessSalary;
	private int incomeTax;
	private int residenceTax;
	private int pension;
	private int healthInsurance;
	private int longtermInsurance;
	private int employmentInsurance;
	private String startDate;
	private String endDate;
	private String payDate;
	
}
