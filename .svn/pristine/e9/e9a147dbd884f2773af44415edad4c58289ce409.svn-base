<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<title>한국환경공단 수질오염 방제정보 시스템</title>
<link rel="stylesheet" type="text/css" href="/css/init/pass.css" />
<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css" rel="stylesheet'/>" />
<link type="text/css" href="<c:url value='/js/JQuery/css/jquery.validate.customizing.css" rel="stylesheet'/>" />
<script type="text/javascript" src="<c:url value='/js/JQuery/plugin/jquery.validate.customizing.js'/>"></script>
<sec:authorize ifAnyGranted="ROLE_USER">
	<c:set var="user_dept_no">
		<sec:authentication property="principal.userVO.deptNo"/>
	</c:set>
	<script>
		var user_dept_no = '<sec:authentication property="principal.userVO.deptNo"/>';
	</script>
</sec:authorize>

<script type="text/javascript" >
//<![CDATA[
	jQuery( function($) {	
		$('#updateImg').click(function(e){
			//$('#memberFrm').attr("action","/common/updatePassword.do");
			//$('#memberFrm').attr("action","/password.do"); // [DEVENV]
			$('#memberFrm').attr("action","https://www.waterkorea.or.kr/password.do"); //[PRODENV]
			$('#memberFrm').submit();
		});		
		
		$('#memberFrm').validate({
			rules:{
				'password':{
					'minlength' : [10],
					'password2': true
				},
				'password_confirm' :{
					'minlength' : [10],
					'equalTo' : '#password'
				}
			},
			messages:{		
				'password':{
					'minlength' : '비밀번호는 10자 이상으로 입력해 주세요.',
					'password2' : '비밀번호는 영대․소문자, 숫자, 특수문자 중 2종류 이상으로 구성해 주세요.'
				},
				'password_confirm' :{
					'minlength' : '비밀번호는 10자 이상으로 입력해 주세요.',
					'equalTo' : '변경할 비밀번호가 일치하지 않습니다.'
				}
			},
			positions:{
				'passwordOld':{
					'arrow':'left',
					'left':280
				},
				'password':{
					'arrow':'left',
					'left':280
				},
				'password_confirm':{
					'arrow':'left',
					'left':280
				}
			}
		});
	});

	//]]>
</script>
</head>
<body>
	<div id="wrap">
	
		<div class="password">
			<form:form commandName="memberFrm" name="memberFrm" method="post">
				<fieldset>
					<legend>비밀번호 변경</legend>
					<p class="title"><img src="/images/init/title.jpg" alt="비밀번호를 변경해주세요." /></p>
					<p class="sub_title"><img src="/images/init/sub_title.jpg" alt="홍길동님의 개인정보보호를 위해 주기적(최소 3개월)으로 비밀번호를 변경해 주세요." /></p>
					
					<div class="content">
					<p>
							<label for="now_pass" class="label"><span class="icon"><img src="/images/init/icon.jpg" alt="" /></span>현재 비밀번호</label>
							&nbsp;&nbsp;&nbsp;<input type="password" name="passwordOld" id="passwordOld" class="pass" size="26" />
					</p> 
					<p>
						<label for="new_pass" class="lable"><span class="icon"><img src="/images/init/icon.jpg" alt="" /></span>새로운 비밀번호</label>
							<input type="password" name="password" id="password" class="pass" size="26" />
					</p>
					<p class="add">비밀번호는 10자리 이상 영문/대소문자,숫자,특수문자를<br />혼합해서 사용하실 수 있습니다.</p>
					<p class="add" style="color:red";>
					<c:if test="${fn:length(resultList) > 0}">
						※ 금지 문자열 [<c:forEach var="result" items="${resultList}" varStatus="status"><c:if test="${status.count > 1}">,</c:if><c:out value="${result.keywordNm}"/></c:forEach>] 이 포함되어 있습니다.
					</c:if>
					</p>
					<p>
						<label for="check_pass" class="label"><span class="icon"><img src="/images/init/icon.jpg" alt="" /></span>비밀번호 확인</label>
							&nbsp;&nbsp;&nbsp;<input type="password" name="password_confirm" id="password_confirm" class="pass" size="26" />
					</p>
					<p class="add">재확인을 위해서 입력하신 비밀번호를 다시한번 입력해 주세요.</p>
					</div><!--//content-->
					
					<div class="footer">
						<p><img src="/images/init/footer.png" alt="개인정보"/></p>
			<!--			<p><span class="arrow"><img src="/images/init/arrow.png" alt="화살표" /></span>쉬운 비밀번호나 자주 쓰는 사이트의 비밀번호가 같을 경우, 도용되기 쉬우므로 주기적으로 변경하셔서 사용하는 것이 좋습니다.<br /><br /> -->
			<!--				<span class="arrow"><img src="/images/init/arrow.png" alt="화살표" /></span>아이디와 주민등록번호,생일,전화번호 등 개인정보와 숫자 연속된 숫자,반복된 문자 등 다른 사람이 쉽게 알아 낼 수 있는<br />&nbsp;&nbsp;&nbsp;&nbsp;비밀번호는 개인정보 유출의위험이 높으므로 사용을 자제해 주시기 바랍니다. -->
			<!--			</p> -->
					</div><!--//footer-->
					<p class="btn">
						<span><img src="/images/init/now.png" alt="지금변경하기" style="cursor:pointer;" id="updateImg"/></span> 
						<!-- <span><a href='/main.do' ><img src="/images/init/next.png" alt="다음에변경하기" /></a></span> -->
					</p>
					<p class="copy">Copyright &copy; <span>2010 Korea Environment</span> Coporation All rights reserved.</p>
				</fieldset>
			</form:form>
		</div><!--//password-->
	</div><!--//wrap-->
</body>
</html>