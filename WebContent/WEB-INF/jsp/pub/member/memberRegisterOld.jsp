<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/center.css'/>" />
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
	<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
	<validator:javascript formName="memberVO" staticJavascript="false" xhtml="true" cdata="false"/>
	<script>
	$(function(){

		$('#memberId').keyup(function () { 

				if ($(this).val().length < 4) {
					$('#idMsg').html('4자이상 입력해주세요.');
					return;
				}
				
			    $.getJSON("<c:url value='/pub/member/checkIDJSON.do'/>", {checkID:$(this).val()}, function (data, status){
				     if(status == 'success'){
				    	 if (data.checkID == '1') {
							 $('#idMsg').html('아이디가 중복됩니다.');
					     } else {
					    	 $('#idMsg').empty();
					     }	     
				     } else { 
				        return;
				     }
				}); 
	    });
		
		$('#overlapIDCheckBtn').css('display','none');
		
		<c:if test="${process != 'process'}">		
			$('#ctyCode').attr("disabled", true);
			$('#factCode').attr("disabled", true);
	
			$('#deptNo').css('display','none');	
			$('#deptNo').attr("disabled", true);
	
			$('#ctyCode').css('display','none');
			$('#ctyCode').attr("disabled", true);
		</c:if>
		
		$('#deptNoTmp').change(deptNoChange);

		$('#deptNo').change(getCtyCodeWhereDeptNo);
		
		$('#email2').change(emailChange);

	});

	// 계정신청 처리
	function regist_member(){
		if (!validateMemberVO(document.memberVO)){
			return false;
		}

		if (confirm('<spring:message code="common.regist.msg" />')) {
			form = document.memberVO;
			form.submit();
		}
	} 
	
	function emailChange() {
		var email2Val = $('#email2').val();
		if (email2Val == 'typing') {
			$('#email1').val('');
		} else {
			$('#email1').val(email2Val);
		}
	}

	// 부서정보 선택시...
	function deptNoChange() {

		var deptVal = $('#deptNoTmp').val();

		$('#ctyCode').attr("disabled", true);
		$('#factCode').attr("disabled", true);

		if(deptVal == '7000') {
			// 지자체인 경우..
			$('#ctyCode').attr("disabled", false);
		} else if (deptVal == '8000' || deptVal == '9000'){
			// 시공사 및 방제업체인 경우..
			$('#factCode').attr("disabled", false);
		}
		
		var dropDownSet = $('#deptNo');
		$.getJSON("<c:url value='/pub/member/getDeptCode.do'/>", {upperDeptNo:deptVal}, function (data, status){
		     if(status == 'success'){     

		    	var len = data.deptCode.length;
		    	 
			    dropDownSet.loadSelectDepth2(data.deptCode);

				if (len > 0) {
					$('#deptNo').css('display','inline');
					$('#deptNo').attr("disabled", false);
				} else {
					$('#deptNo').css('display','none');
					$('#deptNo').attr("disabled", true);

					$('#ctyCode').css('display','none');	
					$('#ctyCode').attr("disabled", true);
				}
				
		     } else { 
		        return;
		     }
		});
		
	}

	// 시/도 정보를 가져온다. where deptCode
	function getCtyCodeWhereDeptNo() {

		var deptVal = $('#deptNo').val();

		if (deptVal.substr(0,2) == '70') {//지자체일 경우
		
			var dropDownSet = $('#ctyCode');
			$.getJSON("<c:url value='/pub/member/getAreaCtyCodeWhereDeptNo.do'/>", {deptCode:deptVal}, function (data, status){
			     if(status == 'success'){
				     var len = data.ctyCode.length;
				     dropDownSet.loadSelectDepth(data.ctyCode);
				     if (len > 0) {
				         $('#ctyCode').css('display','inline');	
						 $('#ctyCode').attr("disabled", false);
				     } else {
		    	    	 $('#ctyCode').css('display','none');	
						 $('#ctyCode').attr("disabled", true);
					 }
			        
			     } else { 
			        return;
			     }
			});
		} else {
			$('#ctyCode').css('display','none');	
			$('#ctyCode').attr("disabled", true);
		}
	}

	</script>
</head>
<body class="joinPage">
<div id="wrap">
	<div class="header">
		<h1 class="logo"><img src="<c:url value='/images/center/h1_logo.gif'/>" alt="계정신청" /></h1>
	</div> 
	<div class="container">
		<div class="content_title">
			<h2 class="tit"><img src="<c:url value='/images/center/h_join_tit.gif'/>" alt="" /></h2>
		</div>
		<div class="content">
			<h3><img src="<c:url value='/images/center/h_join_tit2.gif'/>" alt="회원 정보 입력" /></h3>
			<p class="txt">* 아래의 항목을 모두 입력해 주십시요.</p>
			<form:form commandName="memberVO" name="memberVO" method="post">
				<input type="hidden" name="mode" value="register"/>
				<table class="formTable">
					<caption class="hidden_caption">회원 정보 입력 폼</caption>
					<colgroup>
						<col width="200px" />
						<col width="220px" />
						<col width="150px" />
						<col width="" />
					</colgroup>
					<tr>
						<th scope="row"><span><label for="company_flag">관련기관</label></span></th>
						<td colspan="3">
							<form:select path="deptNoTmp">
								<form:option value="" label="선택"/>
								<c:forEach var="result" items="${deptCode}" varStatus="status">
						    	<form:option value="${result.deptNo}" label="${result.deptName}"/>
						      	</c:forEach>
					      	</form:select>
					      	
					      	<form:select path="deptNo">
								<form:option value="" label="선택"/>
								<c:forEach var="result" items="${deptCode}" varStatus="status">
						    	<form:option value="${result.deptNo}" label="${result.deptName}"/>
						      	</c:forEach>
					      	</form:select>
					      	<form:select path="ctyCode">
								<form:option value="" label="선택"/>
								<c:forEach var="result" items="${areaCtyCodeAll}" varStatus="status">
								<form:option value="${result.code}" label="${result.codeName}"/>
								</c:forEach>
							</form:select>
						</td>
					</tr>
					<tr>
						<th>담당수계</th>
						<td>
							<form:select path="riverId">
								<form:option value="" label="선택"/>
								<c:forEach var="result" items="${riverIdCode}" varStatus="status">
								<form:option value="${result.code}" label="${result.codeName}"/>
								</c:forEach>
							</form:select>
						</td>
					</tr>
					<tr>
						<th scope="row"><span>관련기관이 시공사 및 <br/>방제업체인 경우</span></th>
						<td colspan="3">
							<label for="factCode">수계및공구</label>
							<form:select path="factCode">
								<form:option value="" label="선택"/>
								<c:forEach var="result" items="${factInfoCode}" varStatus="status">
								<form:option value="${result.code}" label="${result.codeName}"/>
								</c:forEach>	
							</form:select>
						</td>
					</tr>
					<tr>
						<th>그룹</th>
						<td>
							<form:select path="groupId">
								<form:option value="" label="선택"/>
								<c:forEach var="result" items="${groupCode}" varStatus="status">
								<form:option value="${result.code}" label="${result.codeName}"/>
								</c:forEach>
							</form:select>
						</td>
					</tr>
					<tr>
						<th scope="row"><span><label for="gradeName">직급(위)</label></span></th>
						<td colspan="3">
							<form:input path="gradeName"/>
							<span style="color:red"><form:errors path="gradeName"/></span>
						</td>
					</tr>
					<tr>
						<th scope="row"><span><label for="memberName">이름</label></span></th>
						<td colspan="3">
							<form:input path="memberName"/>
							<span style="color:red"><form:errors path="memberName"/></span>
						</td>
					</tr>
					<tr>
						<th scope="row"><span><label for="ihidNum">주민등록번호</label></span></th>
						<td colspan="3">
							<form:input path="ihidNum"/>
							-
							<label for="ihidNum1" class="hidden">주민등록번호 나머지 입력</label>
							<form:input path="ihidNum1"/>
							<span style="color:red"><form:errors path="ihidNum"/></span>
						</td>
					</tr>
					<tr>
						<th scope="row"><span><label for="memberId">아이디</label></span></th>
						<td colspan="3">
							<form:input path="memberId"/>
							<button id="overlapIDCheckBtn" style="display:none" type="button" class="overlap"><span class="hidden">중복확인</span></button>
							<span style="color:red"><form:errors path="memberId"/></span>
							<span style="color:red" id="idMsg"><c:out value="${idMsg}"/></span>
						</td>
					</tr>
					<tr>
						<th id="uPw"><span><label for="password">비밀번호</label></span></th>
						<td headers="uPw"> 
							<form:input path="password"/>
						</td>
						<th id="uPw1"><span><label for="password_confirm">비밀번호 확인</label></span></th>
						<td headers="uPw1">
							<form:input path="password_confirm"/>
							<span style="color:red"><form:errors path="password"/></span>
							<span style="color:red">${passwordMsg}</span>
						</td>
					</tr>
					<tr>
						<th scope="row"><span><label for="email">E.mail</label></span></th>
						<td colspan="3">
							<form:input path="email"/>
							@
							<label for="office_tel1" class="hidden">E.mail 나머지 입력</label> 
							<form:input path="email1"/>
							<label for="office_tel1" class="hidden">E.mail 나머지 입력2</label> 
							<form:select path="email2">
								<form:option value="" label="선택"/>
								<form:option value="hanmail.net" label="hanmail.net"/>
								<form:option value="naver.com" label="naver.com"/>
								<form:option value="nate.com" label="nate.com"/>
								<form:option value="typing" label="직접입력"/>
							</form:select>
							<span style="color:red"><form:errors path="email"/></span>
						</td>
					</tr>
					<tr>
						<th scope="row"><span>연락처</span></th>
						<td colspan="3" class="tel">
							<div>
								<label for="officeNo" class="label_tit">사무실:</label>
								<form:input path="officeNo" size="5"/>
								-
								<label for="officeNo1" class="hidden">사무실 연락처 입력</label> 
								<form:input path="officeNo1" size="5"/>
								-
								<label for="officeNo2" class="hidden">사무실 나머지 연락처 입력</label> 
								<form:input path="officeNo2" size="5"/>
								<span style="color:red"><form:errors path="officeNo"/></span>
							</div>
							<div class="tel_spacing">
								<label for="mobileNo" class="label_tit">핸드폰:</label>
								<form:input path="mobileNo" size="5"/>
								-
								<label for="mobileNo1" class="hidden">핸드폰 연락처 입력</label> 
								<form:input path="mobileNo1" size="5"/>
								-
								<label for="mobileNo2" class="hidden">핸드폰 나머지 연락처 입력</label> 
								<form:input path="mobileNo2" size="5"/>
								<span style="color:red"><form:errors path="mobileNo"/></span>
							</div>
							<div class="tel_spacing">
								<label for="faxNum" class="label_tit">팩&nbsp;&nbsp;&nbsp;스:</label>
								<form:input path="faxNum" size="5"/>
								-
								<label for="faxNum1" class="hidden">팩스 연락처 입력</label> 
								<form:input path="faxNum1" size="5"/>
								-
								<label for="faxNum2" class="hidden">팩스 나머지 연락처 입력</label> 
								<form:input path="faxNum2" size="5"/>
								<span style="color:red"><form:errors path="faxNum"/></span>
							</div>
						</td>
					</tr>
				</table>
				<ul class="menu_btn">
					<li><input type="image" src="<c:url value='/images/common/btn_regist.gif'/>" alt="등록" onClick="regist_member();return false"/></li>
					<li><a href="<c:url value='/index.jsp'/>"><img src="<c:url value='/images/common/btn_cancel2.gif'/>" alt="취소" /></a></li>
				</ul>
			</form:form>
		</div>
	</div>
	<div id="footer">
		<c:import url="/WEB-INF/jsp/pub/include/footer.jsp" />
	</div><!-- //footer -->
</div>
</body>
</html>