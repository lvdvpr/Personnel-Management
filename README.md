Personnel-Management
======================================

## 프로젝트 소개
사내 인사/근태/급여관리 기능을 포함한 인사관리프로그램입니다.

- 프로젝트 기간 : 2023. 01. 30. ~ 2023. 03. 03.
- 참여 인원 : 6명

## 사용기술
- FrontEnd : HTML, CSS, JavaScript, jQuery, BootStrap
- BackEnd : Java, SpringBoot, SpringSecurity, JSP, Mybatis
- DataBase : Oracle

## 개발환경
- IDE : Eclipse
- Version Control : Git/Github
- Build Tool : Maven

## ERD
![ERD](https://github.com/lvdvpr/Personnel-Management/assets/116501324/46b3c50b-d49a-4dbd-b72f-abef9019287d)

## 담당기능
### 1. 급여입력
![급여입력](https://github.com/lvdvpr/Personnel-Management/assets/116501324/20d356ac-90b6-43d7-ae6f-76b8097fae83)|![급여수정,삭제](https://github.com/lvdvpr/Personnel-Management/assets/116501324/c49ca95d-81d6-46b2-9ea5-0175f3d77457)
:---:|:---:
급여저장|급여수정,삭제
- 재직 중인 사원들의 급여를 입력하고 저장, 수정, 삭제할 수 있습니다.
- 급여가 저장되지 않은 사원을 선택하면, 급여입력 칸에 해당 사원의 기본급이 자동으로 출력됩니다.
- 급여가 이미 저장된 사원을 선택하면, 급여입력 칸에 기존에 저장한 급여가 출력되며, 이를 수정하거나 삭제할 수 있습니다.
- 자동합계 버튼을 클릭하면, 지급총액과 공제총액이 계산되어 출력됩니다.
- 날짜 입력을 누락하거나 종료일자를 시작일자보다 빠른 날짜로 입력하는 경우, 유효성 검사를 실행합니다.
- 급여 저장, 수정, 삭제 버튼을 클릭하면, 지급총액, 공제총액, 실지급액, 합계 금액이 변경됩니다.
- 관련 주요 코드 : [JSP](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/webapp/WEB-INF/views/salary/salarycalculate.jsp), [Controller](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/java/com/last/web/contoller/SalaryController.java#L34-L83), [Service](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/java/com/last/service/SalaryService.java#L22-L79), [SQL](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/resources/mybatis/mappers/salaries.xml#L5-L157), DTO - [SalaryDto](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/java/com/last/dto/SalaryDto.java), [SalaryTableDto](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/java/com/last/dto/SalaryTableDto.java)

### 2. 급여조회
![급여조회](https://github.com/lvdvpr/Personnel-Management/assets/116501324/506308ed-28c7-45bc-b7c6-e2618b630397)|![급여조회-급여명세서](https://github.com/lvdvpr/Personnel-Management/assets/116501324/0fda5550-a2bb-449a-8479-ea3f69e69a5f)
:---:|:---:
급여검색|급여상세정보
- 기준연월, 성명, 사원번호, 부서명으로 급여내역을 검색할 수 있습니다.
- 급여목록의 행을 클릭하면, 해당하는 사원의 급여 세부 내역이 급여명세서에 출력됩니다.
- 관련 주요 코드 : [JSP](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/webapp/WEB-INF/views/salary/salarycheck.jsp), [Controller](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/java/com/last/web/contoller/SalaryController.java#L85-L108), [Service](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/java/com/last/service/SalaryService.java#L81-L106), [SQL](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/resources/mybatis/mappers/salaries.xml#L159-L250), DTO - [SalaryDto](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/java/com/last/dto/SalaryDto.java), [SalaryTableDto](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/java/com/last/dto/SalaryTableDto.java)

### 3. 급여대장
<img width="60%" src="https://github.com/lvdvpr/Personnel-Management/assets/116501324/545beb56-8c3e-4d05-ac7c-535ccd26c97b"/>

- 기준연월을 선택하여 급여 내역이 있는 전체 사원의 급여 세부 정보와 합계를 확인할 수 있습니다.
- 스크롤 기능을 사용하여 페이지 이동 없이 한 페이지에서 확인할 수 있습니다.
- 관련 주요 코드 : [JSP](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/webapp/WEB-INF/views/salary/salarybook.jsp), [Controller](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/java/com/last/web/contoller/SalaryController.java#L110-L123), [Service](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/java/com/last/service/SalaryService.java#L108-L118), [SQL](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/resources/mybatis/mappers/salaries.xml#L159-L212), DTO - [SalaryDto](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/java/com/last/dto/SalaryDto.java), [SalaryBookDto](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/java/com/last/dto/SalaryBookDto.java)

### 4. 기간별 급여현황
<img width="60%" src="https://github.com/lvdvpr/Personnel-Management/assets/116501324/ad68f09a-1c2d-44ea-b300-501ea37bf263"/>

- 급여 총계에서는 급여기간을 지정하여 사원별 급여 총액을 조회할 수 있습니다.
- 급여 상세내역에서는 지정한 급여기간 동안의 급여 종류별 합계를 월별로 확인할 수 있습니다.
- 관련 주요 코드 : [JSP](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/webapp/WEB-INF/views/salary/salaryperiod.jsp), [Controller](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/java/com/last/web/contoller/SalaryController.java#L125-L142), [Service](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/java/com/last/service/SalaryService.java#L120-L148), [SQL](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/resources/mybatis/mappers/salaries.xml#L252-L318), DTO - [SalaryDto](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/java/com/last/dto/SalaryDto.java), [SalaryBookDto](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/java/com/last/dto/SalaryBookDto.java), [SalaryPeriodDto](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/java/com/last/dto/SalaryPeriodDto.java), [SalaryPeriodSumDto](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/java/com/last/dto/SalaryPeriodSumDto.java)

### 5. 국민연금/건강보험/고용보험
<img width="60%" src="https://github.com/lvdvpr/Personnel-Management/assets/116501324/6ddcbb2d-ad3b-4136-9b3d-c886698b8c85)"/>

- 기준년도, 성명, 사원번호, 부서명으로 국민연금, 건강보험, 고용보험 납입내역을 검색할 수 있습니다.
- 관련 주요 코드 : [JSP](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/webapp/WEB-INF/views/salary/national-pension.jsp), [Controller](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/java/com/last/web/contoller/SalaryController.java#L144-L204), [Service](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/java/com/last/service/SalaryService.java#L150-L176), [SQL](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/resources/mybatis/mappers/salaries.xml#L320-L382), DTO- [SalaryDto](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/java/com/last/dto/SalaryDto.java), [SalaryContributionDto](https://github.com/lvdvpr/Personnel-Management/blob/main/src/main/java/com/last/dto/SalaryContributionDto.java)
