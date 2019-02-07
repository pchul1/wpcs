<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * @Class Name  : MemberModify.jsp
	 * @Description : 개인정보수정 화면
	 * @Modification Information
	 * @
	 * @  수정일		수정자			수정내용
	 * @ -------	--------	---------------------------
	 * @ 2010.07.09	kisspa		최초 생성
	 * @ 2014.06.13	lkh			리뉴얼
	 * 
	 * @author kisspa
	 * @since 2010.07.09
	 * @version 1.0
	 * @see
	 * 
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>
<title>한국환경공단 수질오염 방제정보 시스템</title>
<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="memberVO" staticJavascript="false" xhtml="true" cdata="false"/>
<c:set var="url" value="<%=request.getRequestURL()%>"/>
<style type="text/css">

.wrapper {
    width: 100%;
    max-height: 140px;
    overflow-y: scroll;
/*     position:relative; */
    margin:20px 0;
}

table {
    width: 100%;
    text-align: left; 
    border-collapse:collapse; 
    table-layout: fixed;
} 

thead {
    margin: -1px 0 0 0;
    table-layout: fixed;
    position: absolute;
    width: 100%;
}


tbody tr:first-child td{
    padding-top: 32px;
}

.wrapper th{ 
    width:323px;
    padding: 6px 0;
} 

.wrapper td {  
    width:323px;
}
</style>
<script type="text/javaScript" language="javascript">
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
	
	$('#email2').change(emailChange);
	userauth_factlist();
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

//비밀번호 변경 체크시
function checkPasswordChange(){
	if ($('#passwordChange').attr('checked')) {
		$('#password').val('');
		$('#password_confirm').val('');
	} else {
		$('#password').val('**********');
		$('#password_confirm').val('**********');
	}
}


function onloadFunc() {
	$('#password').val('**********');
	$('#password_confirm').val('**********');
	
	<c:if test="${not empty resultMsg }">
		alert("${resultMsg}");
	</c:if>
}

/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_Member(){
	
}

/* ********************************************************
 * 비밀번호 입력값 체크 하기
 ******************************************************** */
function checkInputPassword(){
	if($('#password').val() == "") {
		alert("비밀번호는 필수 입력값입니다.");
		return true;
	} else if($('#password_confirm').val() == "") {
		alert("비밀번호 확인은 필수 입력값입니다.");
		return true;
	}
	return false;
}

function fn_check() {
	if ($('#password').val().length < 10) {
		alert("비밀번호에 10자리 이상 입력해주세요");
		return false;
	}

	if(!strCheck($('#password').val())){
		alert("비밀번호는 영대․소문자, 숫자, 특수문자 중 2종류 이상으로 구성해 주세요.");
		return false;
	}

	if($('#password').val() != $('#password_confirm').val()){
		alert("변경할 비밀번호가 일치하지 않습니다.");
		return false;
	}
	return true;
}

/* ********************************************************
 * 비밀번호 입력값 체크 하기
 ******************************************************** */
function strCheck(strValue) {
	var num = 0;	
	var regexp = /[^(가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9)]/gi;  // 숫자,영문,특수문자
	for( var i=0; i<strValue.length; i++){
		if(strValue.charAt(i) != " " && regexp.test(strValue.charAt(i)) == true ){
			num++;
			break;
		}
	}	
		
	var num1 = 0;
	var regexp1 = /[0-9]/; // 숫자만
		
	for( var i=0; i<strValue.length; i++){
		if(strValue.charAt(i) != " " && regexp1.test(strValue.charAt(i)) == true ){
			num1++;
			break;
		}
	}	
		
	var num2 = 0;
	var regexp2 = /[a-zA-Z]/; // 영문만
	
	for( var i=0; i<strValue.length; i++){
		if(strValue.charAt(i) != " " && regexp2.test(strValue.charAt(i)) == true ){
			num2++;
			break;
		}
	}
	
	
	var total = parseInt(num)+parseInt(num1)+parseInt(num2);
		
	if (parseInt(total) >= 2) {
		return true; 
	} else {
		return false;
	}
}

/* ********************************************************
 * 수정 저장처리화면
 ******************************************************** */
 function fn_egov_regist_Member(form){
	var registOK = true;
	if(checkInputPassword()) {
		registOK = false;
		return;
	} else {
		if ($('#passwordChange').attr('checked')) {
			if(!fn_check()) {
				registOK = false;
			}
		}	
	}
	if(registOK) {
		if(confirm("<spring:message code="common.save.msg" />")){
			form.action = "./InfoModifyAction.do"; //운영에서 사용할 것
			<c:if test="${fn:indexOf(url,'waterkorea.or.kr') >= 0 }">
			form.action ="https://www.waterkorea.or.kr:443/common/member/InfoModifyAction.do";
			</c:if>
			form.submit();
		}
	}
}

 function userauth_factlist(){

		$("#all_fact_code_1").attr("checked",false);
		$("#all_fact_code_2").attr("checked",false);
		$("#all_fact_code_3").attr("checked",false);
		$.ajax({
			type: "GET",
			url: "<c:url value='/admin/member/getMemberAuthorFactList.do'/>?member_id="+$("#memberId").val(),
			cache: false,
			dataType:"json",
			success : function(result){
				var html = "";
				for(var i=0;i<result.List.length;i++){
					obj = result.List[i];
					html += "<tr>";
					html += "<td style='padding-left:5px;'>";
					if(obj.FACT_CODE_1 != null){
						html += obj.FACT_NAME_1;
					}
					html += "</td>";
					html += "<td style='padding-left:5px;'>";
					if(obj.FACT_CODE_2 != null){
						html += obj.FACT_NAME_2;
					}
					html += "</td>";
					html += "<td style='padding-left:5px;'>";
					if(obj.FACT_CODE_3 != null){
						html += obj.FACT_NAME_3;
					}
					html += "</td>";
					html += "</tr>";
				}
				$("#auth_member_list").html(html);
			}
		});	
	}
</script>
</head>
<body>
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div id="wrap">
	
		<!-- Head Start-->
		<div id="header">
			<c:import url="/common/menu/header.do" />
		</div>
		<!-- Head End-->
		
		<!-- Body Start-->
		<div id="container">
			<div id="content_wrapper">
			
				<!--left menu Start-->
				<c:import url="/common/menu/left.do" />
				<!--left menu End-->

				<!-- Content Start-->
				<div id="content">
				
					<!-- navi, tab menu Start-->
					<c:import url="/common/menu/navi.do" />
					<!-- navi, tab menu End-->
						
					<!--tab Contnet Start-->
					<div class="tab_container">
						<div class="table_wrapper" style="clear:both;">
							<form:form commandName="memberVO" name="memberVO" method="post" enctype="multipart/form-data">
								<input type="hidden" name="mode" value="Modify"/>
								<form:hidden path="memberId"/>
								<table class="dataTable">
									<colgroup>
										<col width="20%">
										<col>
									</colgroup>
									<tr>
										<th>아이디 <span class="asterisk">*</span></th>
										<td style="text-align:left;padding:10px;">
											${memberVO.memberId}
										</td>
									</tr>
									<tr>
										<th>비밀번호 <span class="asterisk">*</span></th>
										<td style="text-align:left;padding:10px;">
											<input type="password" name="password" id="password" size="26" value="**********" style="height:18px;"/>
											<!--<form:input path="password"/> -->
										</td>
									</tr>
									<tr>
										<th>비밀번호 확인 <span class="asterisk">*</span></th>
										<td style="text-align:left;padding:10px;">
											<input type="password" name="password_confirm" id="password_confirm" size="26" value="**********" style="height:18px;"/>
											<br>
											<!--<form:input path="password_confirm"/><br>
											<span style="color:red"><form:errors path="password"/></span>
											<span style="color:red">${passwordMsg}</span> --> 
											<input type="checkbox" id="passwordChange" name="passwordChange" value="change" onclick="checkPasswordChange()"/> 체크하시면 비밀번호를 변경합니다. 
											<p class="add" style="color:red">
												<c:if test="${fn:length(resultList) > 0}">
													※ 금지 문자열 [<c:forEach var="result" items="${resultList}" varStatus="status"><c:if test="${status.count > 1}">,</c:if><c:out value="${result.keywordNm}"/></c:forEach>] 이 포함되어 있습니다.
												</c:if>
											</p>
										</td>
									</tr>
									<tr>
										<th>이메일 <span class="asterisk">*</span></th>
										<td style="text-align:left;padding:10px;">
											<form:input path="email" cssStyle="height:18px;"/>
											@
											<form:input path="email1" cssStyle="height:18px;"/>
											<form:select path="email2"  cssStyle="height:18px;">
												<form:option value="" label="선택"/>
												<form:option value="hanmail.net" label="hanmail.net"/>
												<form:option value="naver.net" label="naver.net"/>
												<form:option value="nate.com" label="nate.com"/>
												<form:option value="typing" label="직접입력"/>
											</form:select>
											<span style="color:red"><form:errors path="email"/></span>
										</td>
									</tr>
									<tr>
										<th>연락처 <span class="asterisk">*</span></th>
										<td style="text-align:left;padding:0 10px;">
											<div class="tel_spacing">
												<form:input path="officeNo" size="5" cssStyle="height:18px;"/>
												-
												<form:input path="officeNo1" size="5" cssStyle="height:18px;"/>
												-
												<form:input path="officeNo2" size="5" cssStyle="height:18px;"/>
												<span style="color:red"><form:errors path="officeNo"/></span>
											</div>
											<div class="tel_spacing">
												<form:input path="mobileNo" size="5" cssStyle="height:18px;"/>
												-
												<form:input path="mobileNo1" size="5" cssStyle="height:18px;"/>
												-
												<form:input path="mobileNo2" size="5" cssStyle="height:18px;"/>
												<span style="color:red"><form:errors path="mobileNo"/></span>
											</div>
											<div class="tel_spacing">
												<form:input path="faxNum" size="5" cssStyle="height:18px;"/>
												-
												<form:input path="faxNum1" size="5" cssStyle="height:18px;"/>
												-
												<form:input path="faxNum2" size="5" cssStyle="height:18px;"/>
												<span style="color:red"><form:errors path="faxNum"/></span>
											</div>
										</td>
									</tr>
									<tr>
										<th>서명</th>
										<td style="text-align:left;padding:10px;">
											<input name="file_1" id="egovComFileUploader" type="file"  style="width:500px;height:18px;"/>
											<c:if test="${not empty memberVO.signature_file}">
											<br/><br/>
												<c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
													<c:param name="atchFileId" value="${memberVO.signature_file}" />
												</c:import>
											</c:if>
										</td>
									</tr>
								</table>
								<div class="wrapper">
								<table style="width:100%;">
									<thead>
										<tr>
											<th>이동형측정기기</th>
											<th>국가수질자동측정망</th>
											<th>수질 TMS</th>
										</tr>
									</thead>
									<tbody id="auth_member_list">
										<tr>
										</tr>
									</tbody>
								</table>
								</div>
								<input name="cmd" type="hidden" value="<c:out value='save'/>"/>
								<div id="btSmallArea" style="text-align:right;margin-top:5px;">
									<input type="button" id="btnAddNotice" name="btnAddNotice" value="저장" class="btn btn_basic" onclick="JavaScript:fn_egov_regist_Member(document.memberVO);" alt="저장" />
								</div>
							</form:form>
						</div>
					</div>
					<!--tab Contnet End-->
				</div>
				<!-- Content End-->
			</div>
		</div>
		<!-- Body End-->

		<!-- Footer Start-->
		<div id="footer">
			<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
		<!-- Footer End-->
	</div>
</body>