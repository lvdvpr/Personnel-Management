package com.last.service;

import java.util.HashMap; 
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.last.dto.SalaryDto;
import com.last.dto.SalaryContributionDto;
import com.last.dto.SalaryPeriodDto;
import com.last.mapper.SalaryMapper;
import com.last.vo.PayBankInfo;

@Service
public class SalaryService {
	
	@Autowired
	private SalaryMapper salaryMapper;
	
	// 급여대상 
	public List<SalaryDto> getSalaryDtos(String baseYearMonth) {
		
		List<SalaryDto> salaryDtos = salaryMapper.getSalaryLists(baseYearMonth);
		
		return salaryDtos;
	}

	// 사원 급여 정보 가져오기
	public SalaryDto getCalculatedSalaryDto(int employeeNo, String baseYearMonth) {
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("employeeNo", employeeNo);
		param.put("baseYearMonth", baseYearMonth);
		SalaryDto salaryDto = salaryMapper.getCalculatedSalaryDto(param);
		
		return salaryDto;
	}
	
	// 급여내역 없는 사원의 기본정보 가져오기
	public PayBankInfo getBasicSalaryInfo(int employeeNo, String baseYearMonth) {
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("employeeNo", employeeNo);
		param.put("baseYearMonth", baseYearMonth);
		PayBankInfo payBankInfo = salaryMapper.getBasicSalaryInfo(param);
		
		return payBankInfo;
	}
	
	// 급여저장
	public SalaryDto saveSalary (SalaryDto salaryDetail) {
		salaryMapper.insertSalary(salaryDetail);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("employeeNo", salaryDetail.getEmployeeNo());
		param.put("baseYearMonth", salaryDetail.getBaseYearMonth());
		SalaryDto salaryDto = salaryMapper.getCalculatedSalaryDto(param);
		
		return salaryDto;
	}
	
	// 급여수정
	public SalaryDto updateSalary (SalaryDto salaryDetail) {
		salaryMapper.updateSalary(salaryDetail);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("employeeNo", salaryDetail.getEmployeeNo());
		param.put("baseYearMonth", salaryDetail.getBaseYearMonth());
		SalaryDto salaryDto = salaryMapper.getCalculatedSalaryDto(param);
		
		return salaryDto;
	}
	
	// 급여삭제
	public void deleteSalary(int employeeNo, String baseYearMonth) {
		salaryMapper.deleteSalary(employeeNo, baseYearMonth);
	}
	
	// 급여조회
	public List<SalaryDto> getSalaryDtoLists(String baseYearMonth, String opt, String keyword) {
		
		Map<String, Object> param = new HashMap<String, Object>();
		if (!baseYearMonth.isBlank()) {
			param.put("baseYearMonth", baseYearMonth);			
		}
		if (!opt.isBlank() && !keyword.isBlank()) {
			param.put("opt", opt);
			param.put("keyword", keyword);			
		}
		List<SalaryDto> salaryDtoLists = salaryMapper.getSalaryHistories(param);
		
		return salaryDtoLists;
	}
	
	// 급여조회 - 사원 급여 명세 가져오기
	public SalaryDto getSalaryDetailDto(int employeeNo, String payDate) {
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("employeeNo", employeeNo);
		param.put("payDate", payDate);
		SalaryDto salaryDto = salaryMapper.getSalaryDetailDto(param);

		return salaryDto;
	}
	
	// 급여대장
	public List<SalaryDto> getSalaryBookLists(String baseYearMonth) {
		
		Map<String,Object> param = new HashMap<String, Object>();
		if (!baseYearMonth.isBlank()) {
			param.put("baseYearMonth", baseYearMonth);			
		}
		List<SalaryDto> salaryDtoLists = salaryMapper.getSalaryHistories(param);
		
		return salaryDtoLists;
	}
	
	// 기간별 급여현황 - 급여총계
	public List<SalaryPeriodDto> getPeriodDtoLists(String startDate, String endDate) {
		
		Map<String, Object> param = new HashMap<String, Object>();
		if (!startDate.isBlank()) {
			param.put("startDate", startDate);			
		}
		if (!endDate.isBlank()) {
			param.put("endDate", endDate);			
		}
		List<SalaryPeriodDto> periodDtoLists = salaryMapper.getPeriodDtoLists(param);
		
		return periodDtoLists;
	}
	
	// 기간별 급여현황 - 급여 상세내역
	public List<SalaryDto> getPeriodDetails(String startDate, String endDate) {
		
		Map<String, Object> param = new HashMap<String, Object>();
		if (!startDate.isBlank()) {
			param.put("startDate", startDate);			
		}
		if (!endDate.isBlank()) {
			param.put("endDate", endDate);			
		}
		List<SalaryDto> periodDetailLists = salaryMapper.getPeriodDetails(param);
		
		return periodDetailLists;
	}
	
	// 국민연금, 건강보험, 고용보험 기본정보
	public List<SalaryDto> getSalaryDtoInfos(String baseYear, String opt, String keyword) {
		
		Map<String, Object> param = new HashMap<String, Object>();
		if (!baseYear.isBlank()) {
			param.put("baseYear", baseYear);
		}
		if (!opt.isBlank() && !keyword.isBlank()) {
			param.put("opt", opt);
			param.put("keyword", keyword);
		}
		
		List<SalaryDto> salaryDtoInfos = salaryMapper.getSalaryDtoInfos(param);
			
		return salaryDtoInfos;
	}
	
	// 국민연금, 건강보험, 고용보험 납입내역
	public List<SalaryContributionDto> getContributionDetails(int employeeNo, String baseYear) {
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("employeeNo", employeeNo);
		param.put("baseYear", baseYear);
		List<SalaryContributionDto> pensionDto = salaryMapper.getContributionDetails(param);
		
		return pensionDto;
	}
	
}
  