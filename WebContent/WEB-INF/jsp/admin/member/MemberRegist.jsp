<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : MemberRegist.jsp
	 * Description : 사용자관리 등록 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2010.07.09	kisspa		최초 생성
	 * 2013.11.28	lkh			리뉴얼
	 * 
	 * author kisspa
	 * since 2010.07.09
	 * version 1.0
	 * see 
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
<%-- <validator:javascript formName="memberVO" staticJavascript="false" xhtml="true" cdata="false"/> --%>
<script type="text/javascript"> 
	$(function () {
// 		adjustGongku();
		$('#sugye').change(function(){
			adjustGongku();
		});
	});

	var bCancel = false; 
	
	function validateMemberVO(form) {
		if (bCancel) 
			return true; 
		else 
			return validateRequired(form);
	}
	
	function required () { 
		this.aa = new Array("deptNoTmp", "관련기관은(는) 필수 입력값입니다.", new Function ("varName", " return this[varName];"));
		this.ab = new Array("gradeName", "직급(위)은(는) 필수 입력값입니다.", new Function ("varName", " return this[varName];"));
		this.ac = new Array("memberName", "이름은(는) 필수 입력값입니다.", new Function ("varName", " return this[varName];"));
		this.ad = new Array("memberId", "아이디은(는) 필수 입력값입니다.", new Function ("varName", " return this[varName];"));
		this.ae = new Array("password", "비밀번호은(는) 필수 입력값입니다.", new Function ("varName", " return this[varName];"));
		this.af = new Array("password_confirm", "비밀번호 확인은(는) 필수 입력값입니다.", new Function ("varName", " return this[varName];"));
		this.ag = new Array("email", "이메일은(는) 필수 입력값입니다.", new Function ("varName", " return this[varName];"));
		this.ah = new Array("officeNo", "사무실연락처 첫자리은(는) 필수 입력값입니다.", new Function ("varName", " return this[varName];"));
		this.ai = new Array("officeNo1", "사무실연락처 둘째자리은(는) 필수 입력값입니다.", new Function ("varName", " return this[varName];"));
		this.aj = new Array("officeNo2", "사무실연락처 셋째자리은(는) 필수 입력값입니다.", new Function ("varName", " return this[varName];"));
		this.ak = new Array("mobileNo", "핸드폰역락처 첫자리은(는) 필수 입력값입니다.", new Function ("varName", " return this[varName];"));
		this.al = new Array("mobileNo1", "핸드폰역락처 둘째자리은(는) 필수 입력값입니다.", new Function ("varName", " return this[varName];"));
		this.am = new Array("mobileNo2", "핸드폰역락처 셋째자리은(는) 필수 입력값입니다.", new Function ("varName", " return this[varName];"));
	}
</script>

<script type="text/javascript">
	
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
//			form.action = "https://www.waterkorea.or.kr:443/admin/member/MemberRegist.do"; //운영에서 사용할 것
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
	
	//목록 으로 가기
	function fn_egov_list_Member(){
		location.href = "<c:url value='/admin/member/MemberList.do'/>";
	}
	
	//비밀번호 입력값 체크 하기
	function fn_check() {
		if ($('#password').val().length < 9) {
			alert("비밀번호에 9자리 이상 입력해주세요");
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
	
	//저장처리화면
	function fn_egov_regist_Member(form){
		var registOK = true;
		
		if(!validateMemberVO(form)){
			registOK = false;
			return;
		} else {
			if(!fn_check()) {
				registOK = false;
			}
		}
		
		if($('input:checkbox[id="tmsUser"]').is(":checked") == true){
			$('#tmsYn').val("Y");
		}else{
			$('#tmsYn').val("N");
		}
		
		if(registOK) {
			if(confirm("<spring:message code="common.save.msg" />")){
				form.action ="./MemberRegistProc.do";
				form.submit();
			}
		}
	}
	
	function onloadFunc() {
		<c:if test="${not empty resultMsg }">
			alert("${resultMsg}");
		</c:if>
	}
	
	function fnTmsList(){
		if($('input:checkbox[id="tmsUser"]').is(":checked") == true){
			$("#sTmsDo").show();
			
			fnTmsCityList();
		}else{
			$('#sTmsDo').hide();
		}
	}
	
	function fnTmsCityList() {
		var tmsDoCode = $("#tmsDoCode option:selected").val();
		var dropDownSet = $('#tmsCtyCode');
		
		$.getJSON("<c:url value='/admin/member/getTmsCityList.do'/>", {tmsDoCode:tmsDoCode}, function (data, status){
			if(status == 'success'){	 
				dropDownSet.loadSelect(data.tmsCityList);
			} else { 
				 alert("정보가져오기 실패");
				return;
			}
		});
	}
</script>
</head>

<body onload="onloadFunc();">
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

						<form:form commandName="memberVO" name="memberVO" method="post" enctype="multipart/form-data">
							<input type="hidden" name="mode" value="register"/>
							<input type="hidden" name="tmsYn" id="tmsYn" value="N"/>
							
							<div class="table_wrapper">
							
								<table style="text-align:left" summary="관리자정보" >
									<colgroup>
										<col width="25%">
										<col>
									</colgroup>
									<tr>
										<th>관련기관 <span class="red">*</span></th>
										<td class="txtL">
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
<!-- 									<tr> -->
<!-- 										<th>담당수계</th> -->
<!-- 										<td class="txtL"> -->
<%-- 											<form:select path="riverId"> --%>
<%-- 												<form:option value="" label="선택"/> --%>
<%-- 												<c:forEach var="result" items="${riverIdCode}" varStatus="status"> --%>
<%-- 												<form:option value="${result.code}" label="${result.codeName}"/> --%>
<%-- 												</c:forEach> --%>
<%-- 											</form:select> --%>
<!-- 										</td> -->
<!-- 									</tr> -->
<!-- 									<tr> -->
<!-- 										<th>관련기관이 방제업체, 시공사일경우 <span class="red">*</span></th> -->
<!-- 										<td class="txtL"> -->
<!-- 											<label for="factCode">수계및공구</label> -->
<%-- 											<form:select path="factCode"> --%>
<%-- 												<c:forEach var="result" items="${factInfoCode}" varStatus="status"> --%>
<%-- 												<form:option value="${result.code}" label="${result.codeName}"/> --%>
<%-- 												</c:forEach>	 --%>
<%-- 											</form:select> --%>
<!-- 										</td> -->
<!-- 									</tr> -->
<!-- 									<tr> -->
<!-- 										<th>그룹</th> -->
<!-- 										<td class="txtL"> -->
<%-- 											<form:select path="groupId"> --%>
<%-- 												<form:option value="" label="선택"/> --%>
<%-- 												<c:forEach var="result" items="${groupCode}" varStatus="status"> --%>
<%-- 												<form:option value="${result.code}" label="${result.codeName}"/> --%>
<%-- 												</c:forEach> --%>
<%-- 											</form:select> --%>
<!-- 										</td> -->
<!-- 									</tr> -->
<!-- 									<tr> -->
<!-- 										<th>TMS담당자 일 경우</th> -->
<!-- 										<td class="txtL"> -->
<!-- 											<input type="checkbox" name="tmsUser" id="tmsUser" onclick="fnTmsList();"/> -->
<!-- 											<span id="sTmsDo" style="display:none;"> -->
<!-- 												<select id="tmsDoCode" name="tmsDoCode" onchange="fnTmsCityList();"> -->
<!-- 													<option value="11" selected="selected">서울특별시</option> -->
<!-- 													<option value="26">부산광역시</option> -->
<!-- 													<option value="27">대구광역시</option> -->
<!-- 													<option value="28">인천광역시</option> -->
<!-- 													<option value="29">광주광역시</option> -->
<!-- 													<option value="30">대전광역시</option> -->
<!-- 													<option value="31">울산광역시</option> -->
<!-- 													<option value="41">경기도</option> -->
<!-- 													<option value="42">강원도</option> -->
<!-- 													<option value="43">충청북도</option> -->
<!-- 													<option value="44">충청남도</option> -->
<!-- 													<option value="45">전라북도</option> -->
<!-- 													<option value="46">전라남도</option> -->
<!-- 													<option value="47">경상북도</option> -->
<!-- 													<option value="48">경상남도</option> -->
<!-- 													<option value="49">제주도</option> -->
<!-- 												</select> -->
<!-- 												<select id="tmsCtyCode" name="tmsCtyCode"> -->
<!-- 													<option value="all">전체</option> -->
<!-- 												</select> -->
<!-- 											</span> -->
<!-- 										</td> -->
<!-- 									</tr> -->
									<tr>
										<th>직급(위) <span class="red">*</span></th>
										<td class="txtL">
											<form:input path="gradeName"/>
											<span style="color:red"><form:errors path="gradeName"/></span>
										</td>
									</tr>
									<tr>
										<th>이름 <span class="red">*</span></th>
										<td class="txtL">
											<form:input path="memberName"/>
											<span style="color:red"><form:errors path="memberName"/></span>
										</td>
									</tr>
			<!--						
									<tr>
										<th>주민번호 <span class="red">*</span></th>
										<td>
											<form:input path="ihidNum" size="5"/>
											-
											<label for="ihidNum1" class="hidden">주민등록번호 나머지 입력</label>
											<form:input path="ihidNum1" size="5"/>
											<span style="color:red"><form:errors path="ihidNum"/></span>
										</td>
									</tr>
			--> 
									<tr>
										<th>아이디 <span class="red">*</span></th>
										<td class="txtL">
											<form:input path="memberId"/>
											<button id="overlapIDCheckBtn" style="display:none" type="button" class="overlap"><span class="hidden">중복확인</span></button>
											<span style="color:red"><form:errors path="memberId"/></span>
											<span style="color:red" id="idMsg"><c:out value="${idMsg}"/></span>
										</td>
									</tr>
									<tr>
										<th>비밀번호 <span class="red">*</span></th>
										<td class="txtL">
											<input type="password" name="password" id="password" size="26" />
											<!--<form:input path="password"/><br>-->
										</td>
									</tr>
									<tr>
										<th>비밀번호 확인 <span class="red">*</span></th>
										<td class="txtL">
											<input type="password" name="password_confirm" id="password_confirm" size="26" />
											<br>
											<!--<form:input path="password_confirm"/>-->
											<span style="color:red"><form:errors path="password"/></span>
											<span style="color:red">${passwordMsg}</span>
										</td>
									</tr>
									<tr>
										<th>이메일 <span class="red">*</span></th>
										<td class="txtL">
											<form:input path="email"/>
											@
											<form:input path="email1"/>
											<form:select path="email2">
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
										<th>연락처 <span class="red">*</span></th>
										<td class="txtL" style="padding-top:5px;padding-bottom:5px;">
											<div>
												<label for="officeNo">사무실:</label>
												<form:input path="officeNo" size="5"/>
												-
<!--												<label for="officeNo1" class="hidden">사무실 연락처 입력</label>  -->
												<form:input path="officeNo1" size="5"/>
												-
<!--												<label for="officeNo2" class="hidden">사무실 나머지 연락처 입력</label>  -->
												<form:input path="officeNo2" size="5"/>
												<span style="color:red"><form:errors path="officeNo"/></span>
											</div>
											<div style="margin-top:5px">
												<label for="mobileNo">핸드폰:</label>
												<form:input path="mobileNo" size="5"/>
												-
<!--												<label for="mobileNo1" class="hidden">핸드폰 연락처 입력</label>  -->
												<form:input path="mobileNo1" size="5"/>
												-
<!--												<label for="mobileNo2" class="hidden">핸드폰 나머지 연락처 입력</label> -->
												<form:input path="mobileNo2" size="5"/>
												<span style="color:red"><form:errors path="mobileNo"/></span>
											</div>
											<div style="margin-top:5px">
												<label for="faxNum">팩&nbsp;&nbsp;&nbsp; 스:</label>
												<form:input path="faxNum" size="5"/>
												-
<!--												<label for="faxNum1" class="hidden">팩스 연락처 입력</label>  -->
												<form:input path="faxNum1" size="5"/>
												-
<!--												<label for="faxNum2" class="hidden">팩스 나머지 연락처 입력</label> -->
												<form:input path="faxNum2" size="5"/>
												<span style="color:red"><form:errors path="faxNum"/></span> 
											</div>
										</td>
									</tr>
									<tr>
										<th>서명</th>
										<td class="txtL">
											<input name="file_1" id="egovComFileUploader" type="file"  style="width:500px;"/>
										</td>
									</tr> 
								</table> 
							</div>
								
							<input name="cmd" type="hidden" value="<c:out value='save'/>"/>
							<!--top Search Start-->
							<div class="topBx">
								<input type="button" id="btnEgovListMember" name="btnEgovListMember" value="목록" class="btn btn_basic" onclick="javascript:fn_egov_list_Member();" alt="목록" />
								<input type="button" id="btnEgovRegistMember" name="btnEgovRegistMember" value="저장" class="btn btn_basic" onclick="javascript:fn_egov_regist_Member(document.memberVO);" alt="저장" />
							</div>
							<!--top Search End-->
						</form:form>

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
</html>