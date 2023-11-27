<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark mb-3">
	<div class="container">
		<ul class="navbar-nav me-auto">
			<li class="nav-item">
				<a class="nav-link ${menu eq 'home' ? 'active' : '' }" href="/home">인사관리시스템</a>
			</li>
			&emsp;&emsp;
			<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_EMPLOYEE')">
	     		<li class="nav-item">
					<a class="nav-link ${menu eq 'employee' ? 'active' : '' }" href="/hr/info" role="button">
						&emsp;&emsp;&emsp;&emsp;인사
					</a>
				</li>
			</sec:authorize>	
			&nbsp;
			<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_EMPLOYEE')">	
				<li class="nav-item">
					<a class="nav-link ${menu eq 'work' ? 'active' : '' }" href="/work/day" role="button">
						근무
					</a>
				</li>
			</sec:authorize>
			&nbsp;
			<sec:authorize access="hasAnyRole('ROLE_ADMIN')">
				<li class="nav-item">
					<a class="nav-link ${menu eq 'pay' ? 'active' : '' }" href="/salary/salarycalculate" role="button">
						급여
					</a>
				</li>
			</sec:authorize>	
		</ul>
			<sec:authorize access="isAuthenticated()">
				<span class="navbar-text"><strong class="text-white"><sec:authentication property="principal.name"/></strong>님 환영합니다.</span>
			</sec:authorize>
		&emsp;
		<ul class="navbar-nav">
			<sec:authorize access="isAuthenticated()">
				<li class="nav-item"><a class="nav-link" id="logout" onclick="logout(event)">로그아웃</a></li>
			</sec:authorize>
			<sec:authorize access="!isAuthenticated()">
				<li class="nav-item"><a class="nav-link ${menu eq 'login' ? 'active' : '' }" href="/login">로그인</a></li>
			</sec:authorize>
		</ul>
	</div>
</nav>
<form id="form-logout" method="post" action="/logout">
	<sec:csrfInput />
</form>
<script>		
	function logout(event) {
		event.preventDefault();
		document.getElementById("form-logout").submit();
	}
</script>