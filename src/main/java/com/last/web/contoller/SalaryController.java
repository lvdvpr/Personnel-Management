package com.last.web.contoller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;  

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.last.dto.SalaryBookDto;
import com.last.dto.SalaryDto;
import com.last.dto.SalaryContributionDto;
import com.last.dto.SalaryPeriodDto;
import com.last.dto.SalaryPeriodSumDto;
import com.last.dto.SalaryTableDto;
import com.last.service.SalaryService;
import com.last.vo.PayBankInfo;

@Controller
@RequestMapping("/salary")
public class SalaryController {
	
	@Autowired
	private SalaryService salaryService;
	
	@GetMapping("/salarycalculate")       // 급여대상
	public String getSalaryList(@RequestParam(name="baseYearMonth", required=false) String baseYearMonth, Model model) {
		
		if (baseYearMonth != null) {
			List<SalaryDto> salaryDtoLists = salaryService.getSalaryDtos(baseYearMonth);
			SalaryTableDto tableDto = new SalaryTableDto();
			tableDto.setSalaryDtoLists(salaryDtoLists);
			model.addAttribute("TableDto", tableDto);
		}
				
		return "salary/salarycalculate";
	}

	@GetMapping("/calculatedSalary")     // 사원 급여 정보 가져오기
	@ResponseBody
	public SalaryDto getCalculatedSalary(@RequestParam("employeeNo") int employeeNo, @RequestParam("baseYearMonth") String baseYearMonth) {
		SalaryDto salaryDto = salaryService.getCalculatedSalaryDto(employeeNo, baseYearMonth);
		
		return salaryDto;
	}
	
	@GetMapping("/basicInfo")     // 급여내역 없는 사원의 기본정보
	@ResponseBody
	public PayBankInfo getBasicSalaryInfo(@RequestParam("employeeNo") int employeeNo, @RequestParam("baseYearMonth") String baseYearMonth) {
		PayBankInfo payBankInfo = salaryService.getBasicSalaryInfo(employeeNo, baseYearMonth);
		
		return payBankInfo;
	}
	
	@PostMapping("/saveSalary")       // 급여저장
	@ResponseBody
	public SalaryDto saveSalary(@RequestBody SalaryDto salaryDetail) {
		SalaryDto salaryDto = salaryService.saveSalary(salaryDetail);
		
		return salaryDto;
	}
	
	@PutMapping("/updateSalary")     // 급여수정
	@ResponseBody
	public SalaryDto updateSalary(@RequestBody SalaryDto salaryDetail) {
		SalaryDto salaryDto = salaryService.updateSalary(salaryDetail);
		
		return salaryDto;
	}
	
	@GetMapping("/deleteSalary") 	 // 급여삭제
	@ResponseBody
	public void deleteSalary(@RequestParam("employeeNo") int employeeNo, @RequestParam("baseYearMonth") String baseYearMonth) {
		salaryService.deleteSalary(employeeNo, baseYearMonth);
	}
	
	@GetMapping("/salarycheck")			// 급여조회
	public String checkSalary(@RequestParam(name="baseYearMonth", required=false) String baseYearMonth, 
							  @RequestParam(name="opt", required=false) String opt, 
							  @RequestParam(name="keyword", required=false) String keyword, Model model) {
		
		if (baseYearMonth != null) {
			List<SalaryDto> salaryDtoLists = salaryService.getSalaryDtoLists(baseYearMonth, opt, keyword);
			if (!salaryDtoLists.isEmpty()) {
				SalaryTableDto tableDto = new SalaryTableDto();
				tableDto.setSalaryDtoLists(salaryDtoLists);
				model.addAttribute("TableDto", tableDto);
			}	
		}	
		
		return "salary/salarycheck";
	}
	
	@GetMapping("/salaryDetail")     // 급여조회-사원별 상세 급여내역 
	@ResponseBody
	public SalaryDto getSalaryDetail(@RequestParam("employeeNo") int employeeNo, @RequestParam("payDate") String payDate) {
		SalaryDto salaryDto = salaryService.getSalaryDetailDto(employeeNo, payDate);
		
		return salaryDto;
	}
	
	@GetMapping("/salarybook")      // 급여대장
	public String getSalaryBook(@RequestParam(name="baseYearMonth", required=false) String baseYearMonth, Model model) {
		
		if (baseYearMonth != null) {
			List<SalaryDto> salaryDtoLists = salaryService.getSalaryBookLists(baseYearMonth);
			if (!salaryDtoLists.isEmpty()) {
				SalaryBookDto bookDto = new SalaryBookDto();
				bookDto.setSalaryDtoLists(salaryDtoLists);
				model.addAttribute("SalaryBookDto", bookDto);
			}
		}
		
		return "salary/salarybook";
	}
	
	@GetMapping("/salaryperiod")      // 기간별 급여현황 - 급여총계, 급여상세내역
	public String getSalaryByPeriod(@RequestParam(name="startDate", required=false) String startDate, 
			 				   @RequestParam(name="endDate", required=false) String endDate, Model model) {
		
		if (startDate != null && endDate != null) {
			List<SalaryPeriodDto> periodDtoLists = salaryService.getPeriodDtoLists(startDate, endDate);
			SalaryPeriodSumDto periodSumDto = new SalaryPeriodSumDto();
			periodSumDto.setSalaryPeriodDtos(periodDtoLists);
			model.addAttribute("SalaryPeriodSumDto", periodSumDto);
			
			List<SalaryDto> periodDetailLists = salaryService.getPeriodDetails(startDate, endDate);
			
			SalaryBookDto bookDto = new SalaryBookDto();
			bookDto.setSalaryDtoLists(periodDetailLists);
			model.addAttribute("periodDetailDtos", bookDto);
		}	
		return "salary/salaryperiod";
	}
	
	@GetMapping("/national-pension")      // 국민연금 기본정보
	public String getNationalPension(@RequestParam(name="baseYear", required=false, defaultValue="") String baseYear, 
									 @RequestParam(name="opt", required=false, defaultValue="") String opt, 
									 @RequestParam(name="keyword", required=false, defaultValue="") String keyword, Model model) {
		if (baseYear != null) {
			List<SalaryDto> salaryDtoInfos = salaryService.getSalaryDtoInfos(baseYear, opt, keyword);
			model.addAttribute("SalaryDtos", salaryDtoInfos);
		} else {
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
			baseYear = sdf.format(now);
			List<SalaryDto> salaryDtoInfos = salaryService.getSalaryDtoInfos(baseYear, opt, keyword);
			model.addAttribute("SalaryDtos", salaryDtoInfos);
		}
		
		return "salary/national-pension";
	}
	
	@GetMapping("/health-insurance")      // 건강보험 기본정보
	public String getHealthInsurance(@RequestParam(name="baseYear", required=false, defaultValue="") String baseYear, 
								  @RequestParam(name="opt", required=false, defaultValue="") String opt, 
								  @RequestParam(name="keyword", required=false, defaultValue="") String keyword, Model model) {
		if (baseYear != null) {
			List<SalaryDto> salaryDtoInfos = salaryService.getSalaryDtoInfos(baseYear, opt, keyword);
			model.addAttribute("SalaryDtos", salaryDtoInfos);
		} else {
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
			baseYear = sdf.format(now);
			List<SalaryDto> salaryDtoInfos = salaryService.getSalaryDtoInfos(baseYear, opt, keyword);
			model.addAttribute("SalaryDtos", salaryDtoInfos);
		}	
		
		return "salary/health-insurance";
	}
	
	@GetMapping("/employment-insurance")      // 고용보험 기본정보
	public String getEmploymentInsurance(@RequestParam(name="baseYear", required=false, defaultValue="") String baseYear, 
									  @RequestParam(name="opt", required=false, defaultValue="") String opt, 
									  @RequestParam(name="keyword", required=false, defaultValue="") String keyword, Model model) {
		if (baseYear != null) {
		List<SalaryDto> salaryDtoInfos = salaryService.getSalaryDtoInfos(baseYear, opt, keyword);
		model.addAttribute("SalaryDtos", salaryDtoInfos);
		} else {
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
			baseYear = sdf.format(now);
			List<SalaryDto> salaryDtoInfos = salaryService.getSalaryDtoInfos(baseYear, opt, keyword);
			model.addAttribute("SalaryDtos", salaryDtoInfos);
		}	
		
		return "salary/employment-insurance";
	}
	
	@GetMapping("/contributionDetail")      // 국민연금, 건강보험, 고용보험 납입내역
	@ResponseBody
	public List<SalaryContributionDto> getContributionDetails (@RequestParam("employeeNo") int employeeNo, @RequestParam("baseYear") String baseYear) {
		List<SalaryContributionDto> contributionDetails = salaryService.getContributionDetails(employeeNo, baseYear);
		
		return contributionDetails;
	}
	
}
