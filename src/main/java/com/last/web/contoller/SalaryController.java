package com.last.web.contoller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody; 

@Controller
@RequestMapping("/salary")
public class SalaryController {
	
	@GetMapping("/salarycalculate")
	public String salarycalculate() {
		return "salary/salarycalculate";
	}

	@GetMapping("/salarycheck")
	public String salarycheck() {
		return "salary/salarycheck";
	}
	
   /*
	@GetMapping("/detail.json")
	@ResponseBody
	public PayDetailDto payDetail(@RequestParam("userId") String employeeNo) {
		PayDetailDto dto = payService.getPayDetail(employeeNo);
		
		return dto;
	}
	*/
}