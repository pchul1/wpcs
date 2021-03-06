<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : MemberModify.jsp
	 * Description : 사용자관리 화면
	 * Modification Information
	 * 
	 * 수정일			 수정자		수정내용
	 * -------		--------	---------------------------
	 * 2010.07.09	kisspa		최초 생성
	 * 2013.11.06	lkh			리뉴얼
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
<validator:javascript formName="memberVO" staticJavascript="false" xhtml="true" cdata="false"/>
<style type="text/css">

.wrapper {
    width: 718px;
    height: 140px;
    overflow-y: scroll;
}

table {
    width: 100%;
    text-align: left; 
    border-collapse:collapse; 
    table-layout: fixed;
} 

thead {
    margin: -1px 0 0 -1px;
/*     display: table;  */
    table-layout: fixed;
    position: absolute;
    width:700px;
}


tbody tr:first-child td{
    padding-top: 32px;
}

th, td { 
    padding: 6px; 
} 

.wrapper th{
    width:232px;
    padding: 5px 0;
} 

.wrapper td { 
    width:232px;
}

</style>
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
		
		$('#deptNoTmp').change(deptNoChange);
	
		$('#deptNo').change(getCtyCodeWhereDeptNo);
		
		$('#email2').change(emailChange);
	
		$('#riverId').val('${memberVO.riverId}');
		

		$("#registlayerid").draggable({
			containment: 'body',
			scroll: false
		});
		
		fnTmsList();
		userauth_factlist();
		
		$("#all_fact_code_1").change(function(i){
			if($(this).attr("checked") == "checked") $("input[name='fact_code_1']").attr("checked",true);
			else $("input[name='fact_code_1']").attr("checked",false);
		});
		
		$("#all_fact_code_2").change(function(i){
			if($(this).attr("checked") == "checked") $("input[name='fact_code_2']").attr("checked",true);
			else $("input[name='fact_code_2']").attr("checked",false);
		});
		
		$("#all_fact_code_3").change(function(i){
			if($(this).attr("checked") == "checked") $("input[name='fact_code_3']").attr("checked",true);
			else $("input[name='fact_code_3']").attr("checked",false);
		});
		userMenuAuthList();
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
	
	function onloadFunc() {
		$('#password').val('**********');
		$('#password_confirm').val('**********');
		
		deptNoChange2();
		
		<c:if test="${not empty resultMsg }">
			alert("${resultMsg}");
		</c:if>
	}
	
	//부서정보 선택시... 자동 선택되게 하기 위해서..
	function deptNoChange2() {
	
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
	
				$('#deptNo').val('${memberVO.deptNo}');
				
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
	
	/* ********************************************************
	 * 목록 으로 가기
	 ******************************************************** */
	function fn_egov_list_Member(){
		location.href = "<c:url value='/admin/member/MemberList.do'/>";
	}
	
	/* ********************************************************
	 * 비밀번호 입력값 체크 하기
	 ******************************************************** */
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
	
	/* ********************************************************
	 * 수정 저장처리화면
	 ******************************************************** */
	function fn_egov_regist_Member(form){
		 var registOK = true;
		 if(!validateMemberVO(form)){
			registOK = false;
			return;
		 } else {
			if ($('#passwordChange').attr('checked')) {
				if(!fn_check()) {
					registOK = false;
				}
			}
		}
		 
		 if($('input:checkbox[id="tmsUser"]').is(":checked") == true){
				$('#tmsYn').val("Y");
			}else{
				$('#tmsYn').val("N");
			}
		 
		if(registOK) {
			if(confirm("저장하시겠습니까?")){
				form.action="/admin/member/MemberModifyProc.do";
				form.submit();
			}
		}
	}
	
	function fn_egov_app_Refusal(form){
		if(confirm("승인거부 하시겠습니까?")){
			form.action="/admin/member/MemberAppRefusalProc.do";
			form.submit();
		}
		
	}
	
	function fn_egov_app(form){
		if(confirm("승인 하시겠습니까?")){
			form.action="/admin/member/MemberAppProc.do";
			form.submit();
		}
		
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
		
		var tmsCtyCode = "${memberVO.tmsCtyCode}";
		
		$.getJSON("<c:url value='/admin/member/getTmsCityList.do'/>", {tmsDoCode:tmsDoCode}, function (data, status){
			if(status == 'success'){	 
				dropDownSet.loadSelect(data.tmsCityList);
				
				$("#tmsCtyCode > option[value=" + tmsCtyCode + "]").attr("selected", "selected");

			} else { 
				 alert("정보가져오기 실패");
				return;
			}
		});
	}
	

	function layerPopCloseAll() {
	}
	
	function btnAuth_syskind(n)
	{
		layerPopOpen("registlayerid");
//			$('#registlayerid').css('display','');
		$("#auth_riverdiv option").remove();
		$("#auth_factNo option").remove();
		$("#auth_myFactNo option").remove();
		$("#auth_syskind").val(n);
		switch(n)
		{
			case "U" :
			case "A" :
				var html = "<option value='R01'>한강</option>";
				html += "<option value='R02'>낙동강</option>";
				html += "<option value='R03'>금강</option>";
				html += "<option value='R04'>영산강</option>";
				$("#auth_title").html("수계");
				$("#auth_riverdiv").append(html);
				break;
			case "W" : 
				var html = "<option value='11'>서울특별시</option>";
				html += "<option value='26'>부산광역시</option>";
				html += "<option value='27'>대구광역시</option>";
				html += "<option value='28'>인천광역시</option>";
				html += "<option value='29'>광주광역시</option>";
				html += "<option value='30'>대전광역시</option>";
				html += "<option value='31'>울산광역시</option>";
				html += "<option value='41'>경기도</option>";
				html += "<option value='42'>강원도</option>";
				html += "<option value='43'>충청북도</option>";
				html += "<option value='44'>충청남도</option>";
				html += "<option value='45'>전라북도</option>";
				html += "<option value='46'>전라남도</option>";
				html += "<option value='47'>경상북도</option>";
				html += "<option value='48'>경상남도</option>";
				html += "<option value='49'>제주도</option>";
				$("#auth_title").html("지역");
				$("#auth_riverdiv").append(html);
				break;
		}
	}
	
	
	function auth_factlist()
	{
		var _auth_syskind = $("#auth_syskind").val();
		var _auth_riverdiv = $('#auth_riverdiv').val();
		var dropDownSet = $('#auth_factNo');
		
		$.ajax({
			type: "GET",
			url: "<c:url value='/admin/member/getAuthorFactList.do'/>?au_syskind="+_auth_syskind + "&au_riverdiv="+_auth_riverdiv,
			dataType:"json",
			success : function(result){
				dropDownSet.loadSelect(result.List);
			}
		});											
	}
	 
	function add(){
		$("#auth_factNo option:selected").each(function(i){
			var addOpt = document.createElement('option'); // 옵션을 설정한다..
			addOpt.value = $(this).val();
			addOpt.appendChild(document.createTextNode($(this).text())); // 셀렉트 박스의 text 를 설정한다.
			
			var flag = false;
			$("#auth_myFactNo option").each(function(i){
				if($(this).val() == addOpt.value){
					flag = true;
					return false;//break;
				}
			});
			
			if(!flag){
				$("#auth_myFactNo").append(addOpt);
			}
		});
	}
	
	//SMS 보낼 직원 삭제
	function del(){
		$("#auth_myFactNo option:selected").each(function(i){
			//$(this).appendTo('#person');
			$(this).remove();
		});
	}
	
	function goSave(){
		var myFactList = new Array;	
		var cnt = 0;
		
		$("#auth_myFactNo option").each(function() {
			myFactList.push($(this).val());
			cnt++;
		});
		$("#auth_myFactList").val(myFactList);
		
		if(cnt == 0) {
			alert("대상자를 선택하여 주십시요.");
			return false;
		}
		
		if(confirm("등록하시겠습니까?"))
		{
			$.ajax({
				type:"post",
				url: "<c:url value='/admin/member/InsertMyAuthorFact.do'/>",
				data:{
					member_id:$("#memberId").val(),
					auth_myFactList:$("#auth_myFactList").val(),
					auth_syskind:$("#auth_syskind").val()
				},
				dataType:"json",
				success:function(result){
					alert("등록하였습니다.");
					userauth_factlist();
					layerPopClose('registlayerid');
				},
				error:function(result){
					alert(result.responseText);
				}
			});				
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
						$("#all_fact_code_1").attr("checked",true);
						html += "<input type='checkbox' name='fact_code_1' value='" + obj.FACT_CODE_1 + "'> ";
						html += obj.FACT_NAME_1;
					}
					html += "</td>";
					html += "<td style='padding-left:5px;'>";
					if(obj.FACT_CODE_2 != null){
						$("#all_fact_code_2").attr("checked",true);
						html += "<input type='checkbox' name='fact_code_2' value='" + obj.FACT_CODE_2 + "'> ";
						html += obj.FACT_NAME_2;
					}
					html += "</td>";
					html += "<td style='padding-left:5px;'>";
					if(obj.FACT_CODE_3 != null){
						$("#all_fact_code_3").attr("checked",true);
						html += "<input type='checkbox' name='fact_code_3' value='" + obj.FACT_CODE_3 + "'> ";
						html += obj.FACT_NAME_3;
					}
					html += "</td>";
					html += "</tr>";
				}
				$("#auth_member_list").html(html);
			}
		});	
	}
	
	function btnAuthDel(n){
		var myFactList = new Array;	
		var cnt = 0;
		
		$("input[name='"+n+"']").each(function() {
			if($(this).attr("checked") == "checked")
			{
				myFactList.push($(this).val());
				cnt++;
			}
		});
		
		$("#auth_myFactList").val(myFactList);
		
		if(cnt == 0) {
			alert("대상자를 선택하여 주십시요.");
			return false;
		}
		
		if(confirm("삭제하시겠습니까?"))
		{
			$.ajax({
				type:"post",
				url: "<c:url value='/admin/member/DeleteMyAuthorFact.do'/>",
				data:{
					member_id:$("#memberId").val(),
					auth_myFactList:$("#auth_myFactList").val()
				},
				dataType:"json",
				success:function(result){
					alert("삭제하였습니다.");
					userauth_factlist();
					layerPopClose('registlayerid');
				},
				error:function(result){
					alert(result.responseText);
				}
			});				
		}
	}
	
	
	
	
	function userMenuAuthList(){
		$.ajax({
			type:"post",
			url: "<c:url value='/admin/member/getUserMenuAuthorList.do'/>",
			dataType:"json",
			data:{
				member_id:$("#memberId").val()
				
			},
			success : function(result){
				var tot = result['userMenuAuthList'].length;
				
				var html = "";
				var group1; 
				var group2 ;
				var group3 ;
				
				for(var i=0;i< tot ;i++){
					obj =  result['userMenuAuthList'][i];
					$("#userMenuAuthList").html(html);
					html += "<tr>";
					
					if(group1 == obj.menuGroup1){
						html += "<th></th>";
					}else{
						group1 =obj.menuGroup1;
						html += "<th>"+obj.menuGroup1+"</th>";
					}
					if(group2 == obj.menuGroup2){
						html += "<th></th>";
					}else{
						group2 =obj.menuGroup2;
						html += "<th>"+obj.menuGroup2+"</th>";
					}
					if(group3 == obj.menuGroup3){
						html += "<th></th>";
					}else{
						group3 =obj.menuGroup3;
						html += "<th>"+obj.menuGroup3+"</th>";
					}
					html += "<th>"+obj.menuName+"</th>";
					
						html += "<td style='text-align:center; padding:5px;'>";
						if(obj.authCUse == "Y"){
							html += "<input type='checkbox' ";
							html += "id='C"+obj.menuId+"'";
							if(obj.authC != null){
									userMenuAuthSetName="수정";
									if(obj.authC == "Y"){
										html += "checked='true'";
									}
							}else{
								userMenuAuthSetName="입력";
							}
							html += "/> "
						}
						html += "</td>";
						
						html += "<td style='text-align:center; padding:5px;'>";
						if(obj.authUUse == "Y"){
							html += "<input type='checkbox' ";
							html += "id='U"+obj.menuId+"'";
							if(obj.authU != null){
									if(obj.authU == "Y"){
										html += "checked='true'";
									}
							}
							html += "/> "
						}
						html += "</td>";
						
						html += "<td style='text-align:center; padding:5px;'>";
						if(obj.authDUse == "Y"){
							html += "<input type='checkbox' ";
							html += "id='D"+obj.menuId+"'";
							if(obj.authD != null){
									if(obj.authD == "Y"){
										html += "checked='true'";
									}
							}
							html += "/> "
						}
						html += "</td>";
					html += "</tr>";
				}
				$("#userMenuAuthList").html(html);
			},
			error:function(result){
				alert(result.responseText);
			}
		});	
		
	}
	
	function userMenuAuthSave(){
		showLoading();
		$.ajax({
			type:"post",
			url: "<c:url value='/admin/member/getUserMenuAuthorList.do'/>",
			dataType:"json",
			data:{
				member_id:$("#memberId").val()
			},
			success : function(result){
				var tot = result['userMenuAuthList'].length;
				for(var i=0;i< tot ;i++){
					obj =  result['userMenuAuthList'][i];
					// T_USER_MENU_AUTH 에 memberid 와 menuid 가 일치하는 count가있는지 
					userMenuAuthSaveLow(obj.menuId);
				}
			},
			error:function(result){
				alert(result.responseText);
			}
		});
		alert("사용자 메뉴권한을 "+userMenuAuthSetName+" 했습니다.");
		closeLoading();
		userMenuAuthList();
	}
	var userMenuAuthSetName ="";
	function userMenuAuthSaveLow(menuId){
		var tott = 0;
		$.ajax({
			type:"post",
			url: "<c:url value='/admin/member/getUserAuthorCnt.do'/>",
			dataType:"json",
			data:{
				userId:$("#memberId").val(),
				menuId:menuId
			},
			success : function(result){
				var tot = 0;
				 tot = result['getUserMenuAuthorCount'];
				 //alert(tot);
				var authC =  document.getElementById('C'+menuId);
				var authU =  document.getElementById('U'+menuId);
				var authD =  document.getElementById('D'+menuId);
				if(isNaN(authC)){
					authC = authC.checked;
				}else{
					authC = false;
				}
				if(isNaN(authU)){
					authU = authU.checked;
				}else{
					authU = false;
				}
				if(isNaN(authD)){
					authD = authD.checked;
				}else{
					authD = false;
				}
					if(tot == 1){
					 	// update
						userMenuAuthSet("U",authC,authU,authD,menuId);
					}else{
						// insert 
						userMenuAuthSet("I",authC,authU,authD,menuId);
					}
			}
		});
	}
	
	function userMenuAuthSet(divi,authC,authU,authD,menuId){
		//authC,authU,authD
		//alert(authC+"/"+authU+"/"+authD+"/"+menuId);
		var divurl = "";
		if(divi == "U"){
			divurl = "<c:url value='/admin/member/userMenuAuthSaveu.do'/>";
		}else{
			divurl = "<c:url value='/admin/member/userMenuAuthSavei.do'/>";
		}
		var authCyn = "";
		var authUyn = "";
		var authDyn = "";
		if(authC == true){
			authCyn = "Y";
		}else{
			authCyn = "N";
		}
		if(authU == true){
			authUyn = "Y";
		}else{
			authUyn = "N";
		}
		if(authD == true){
			authDyn = "Y";
		}else{
			authDyn = "N";
		}
		$.ajax({
			type:"post",
			url: divurl,
			dataType:"json",
			data:{
				userId:$("#memberId").val(),
				menuId:menuId,
				authC:authCyn,
				authU:authUyn,
				authD:authDyn
			},
			success : function(result){
			}
			,
			error:function(result){
				alert(result.responseText);
			}
		});
	}
	
	// 휴면 계정 해제
	function fn_egov_unlock_Member(form){ 
		if(confirm("계정의 휴면 상태를 해제하시겠습니까?")){
			form.action="/admin/member/UnlockDormancy.do";
			form.submit();
		}
	}
	
	// 비밀번호 오류 초기화
	function fn_egov_unlock_Password(form){ 
		if(confirm("계정의 비밀번호 잠금을 해제하시겠습니까?")){
			form.action="/admin/member/UnlockPassword.do";
			form.submit();
		}
	}
	
	// 계정 삭제
	function fn_egov_remove_Member(form){ 
		if(confirm("계정을 삭제하시겠습니까? 삭제된 계정은 복구할 수 없습니다.")){
			form.action="/admin/member/MemberRemove.do";
			form.submit();
		}
	}	
	
</script>
</head>
<body onload="onloadFunc();">
	<div id="layerFullBgDiv"></div>
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
					
						<form:form commandName="memberVO" name="memberVO" method="post"  enctype="multipart/form-data" >
							<input type="hidden" name="mode" value="Modify"/>
							<input type="hidden" name="tmsYn" id="tmsYn" value="${memberVO.tmsYn}"/>
							<input type="hidden" id="userMenuAuthSetName" name="userMenuAuthSetName" />
							<form:hidden path="memberId"/>
							<form:hidden path="uniq_id"/>
							<div class="table_wrapper">
								
								<table summary="유저정보" style="text-align:left">
									<colgroup>
										<col width="250px">
										<col />
									</colgroup>
									<tr>
										<th style="padding-top:0;">관련기관 <span class="red">*</span></th>
										<td class="txtL" style="padding-top:0;">
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
									<tr>
<!-- 									<tr> -->
<!-- 										<th>관련기관이 방제업체, 시공사일경우 <span class="red">*</span></th> -->
<!-- 										<td style="padding-left:5px;"> -->
<!-- 											<label for="factCode">수계및공구</label> -->
<%-- 											<form:select path="factCode"> --%>
<%-- 												<c:forEach var="result" items="${factInfoCode}" varStatus="status"> --%>
<%-- 												<form:option value="${result.code}" label="${result.codeName}"/> --%>
<%-- 												</c:forEach> --%>
<%-- 											</form:select> --%>
<!-- 										</td> -->
<!-- 									</tr> -->
<!-- 									<tr> -->
<!-- 										<th>그룹</th> -->
<!-- 										<td style="padding-left:5px;"> -->
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
<%-- 											<input type="checkbox" name="tmsUser" id="tmsUser" onclick="fnTmsList();" <c:if test="${memberVO.tmsYn == 'Y'}">checked</c:if>/> --%>
<!-- 											<span id="sTmsDo" style="display:none;"> -->
<!-- 												<select id="tmsDoCode" name="tmsDoCode" onchange="fnTmsCityList();"> -->
<%-- 													<option value="11" <c:if test="${memberVO.tmsDoCode == '11'}">selected="selected"</c:if>>서울특별시</option> --%>
<%-- 													<option value="26" <c:if test="${memberVO.tmsDoCode == '26'}">selected="selected"</c:if>>부산광역시</option> --%>
<%-- 													<option value="27" <c:if test="${memberVO.tmsDoCode == '27'}">selected="selected"</c:if>>대구광역시</option> --%>
<%-- 													<option value="28" <c:if test="${memberVO.tmsDoCode == '28'}">selected="selected"</c:if>>인천광역시</option> --%>
<%-- 													<option value="29" <c:if test="${memberVO.tmsDoCode == '29'}">selected="selected"</c:if>>광주광역시</option> --%>
<%-- 													<option value="30" <c:if test="${memberVO.tmsDoCode == '30'}">selected="selected"</c:if>>대전광역시</option> --%>
<%-- 													<option value="31" <c:if test="${memberVO.tmsDoCode == '31'}">selected="selected"</c:if>>울산광역시</option> --%>
<%-- 													<option value="41" <c:if test="${memberVO.tmsDoCode == '41'}">selected="selected"</c:if>>경기도</option> --%>
<%-- 													<option value="42" <c:if test="${memberVO.tmsDoCode == '42'}">selected="selected"</c:if>>강원도</option> --%>
<%-- 													<option value="43" <c:if test="${memberVO.tmsDoCode == '43'}">selected="selected"</c:if>>충청북도</option> --%>
<%-- 													<option value="44" <c:if test="${memberVO.tmsDoCode == '44'}">selected="selected"</c:if>>충청남도</option> --%>
<%-- 													<option value="45" <c:if test="${memberVO.tmsDoCode == '45'}">selected="selected"</c:if>>전라북도</option> --%>
<%-- 													<option value="46" <c:if test="${memberVO.tmsDoCode == '46'}">selected="selected"</c:if>>전라남도</option> --%>
<%-- 													<option value="47" <c:if test="${memberVO.tmsDoCode == '47'}">selected="selected"</c:if>>경상북도</option> --%>
<%-- 													<option value="48" <c:if test="${memberVO.tmsDoCode == '48'}">selected="selected"</c:if>>경상남도</option> --%>
<%-- 													<option value="49" <c:if test="${memberVO.tmsDoCode == '49'}">selected="selected"</c:if>>제주도</option> --%>
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
											${memberVO.memberId}
										</td>
									</tr>
									<tr>
										<th>비밀번호 <span class="red">*</span></th>
										<td class="txtL">
											<input type="password" name="password" id="password" size="26" />
											<!--<form:input path="password"/>--> 
										</td>
									</tr>
									<tr>
										<th>비밀번호 확인 <span class="red">*</span></th>
										<td class="txtL">
											<input type="password" name="password_confirm" id="password_confirm" size="26" />
											<br>
											<!--<form:input path="password_confirm"/><br>--> 
											<span style="color:red"><form:errors path="password"/></span>
											<span style="color:red">${passwordMsg}</span>
											<input type="checkbox" id="passwordChange" name="passwordChange" value="change" onclick="checkPasswordChange()"/> 체크하시면 비밀번호를 초기화합니다.
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
												<form:option value="naver.com" label="naver.com"/>
												<form:option value="nate.com" label="nate.com"/>
												<form:option value="typing" label="직접입력"/>
											</form:select>
											<span style="color:red"><form:errors path="email"/></span>
										</td>
									</tr>
									<tr>
										<th>연락처 <span class="red">*</span></th>
										<td class="txtL">
											<div>
												<label for="officeNo">-사무실 :</label>
												<form:input path="officeNo" size="5"/>
												-
												<form:input path="officeNo1" size="5"/>
												-
												<form:input path="officeNo2" size="5"/>
												<span style="color:red"><form:errors path="officeNo"/></span>
											</div>
											<div class="tel_spacing">
												<label for="mobileNo">-핸드폰 :</label>
												<form:input path="mobileNo" size="5"/>
												-
												<form:input path="mobileNo1" size="5"/>
												-
												<form:input path="mobileNo2" size="5"/>
												<span style="color:red"><form:errors path="mobileNo"/></span>
											</div>
											<div>
												<label for="faxNum"><span style="padding-right:11px">-팩</span>스 :</label>
												<form:input path="faxNum" size="5"/>
												-
<!--												<label for="faxNum1" class="hidden">팩스 연락처 입력</label>  -->
												<form:input path="faxNum1" size="5"/>
												-
<!--												<label for="faxNum2" class="hidden">팩스 나머지 연락처 입력</label>  -->
												<form:input path="faxNum2" size="5"/>
												<span style="color:red"><form:errors path="faxNum"/></span>
											</div>
										</td>
									</tr>
									<tr>
										<th>비고</th>
										<td class="txtL">
											${memberVO.bigo}
										</td>
									</tr>
									<tr>
										<th>서명</th>
										<td class="txtL">
											<input name="file_1" id="egovComFileUploader" type="file"  style="width:500px;"/>
											<c:if test="${not empty memberVO.signature_file}">
											<br/><br/>
												<c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
													<c:param name="atchFileId" value="${memberVO.signature_file}" />
												</c:import>
											</c:if>
										</td>
									</tr>
									<tr>
										<th>관리 시스템</th>
										<td class="txtL">
											<c:if test="${memberVO.author_code eq 'ROLE_ADMIN'}">
											관리자 권한 입니다.
											</c:if>
											<c:if test="${memberVO.author_code ne 'ROLE_ADMIN'}">
											<div class="wrapper">
											<table>
												<thead>
													<tr>
														<th><input type='checkbox' id='all_fact_code_1' disabled="disabled"> 이동형측정기기 <input type="button" value="추가" class="btn btn_basic" onclick="btnAuth_syskind('U')" alt="추가"/> <input type="button" value="삭제" class="btn btn_basic" onclick="btnAuthDel('fact_code_1')" alt="삭제"/></th>
														<th><input type='checkbox' id='all_fact_code_2' disabled="disabled"> 국가수질자동측정망 <input type="button" value="추가" class="btn btn_basic" onclick="btnAuth_syskind('A')" alt="추가"/> <input type="button" value="삭제" class="btn btn_basic" onclick="btnAuthDel('fact_code_2')" alt="삭제"/></th>
														<th><input type='checkbox' id='all_fact_code_3' disabled="disabled"> 수질 TMS <input type="button" value="추가" class="btn btn_basic" onclick="btnAuth_syskind('W')" alt="추가"/> <input type="button" value="삭제" class="btn btn_basic" onclick="btnAuthDel('fact_code_3')" alt="삭제"/></th>
													</tr>
												</thead>
												<tbody id="auth_member_list">
													<tr>
													</tr>
												</tbody>
											</table>
											</div>
											</c:if>
										</td>
									</tr>
								</table>
							</div>
							<!--top Search Start-->
							<div class="topBx">
								<input type="button" id="btnEgovListMember" name="btnEgovListMember" value="목록" class="btn btn_basic" onclick="javascript:fn_egov_list_Member();" alt="목록"/>
								<c:choose>
									<c:when test="${memberVO.approvalFlag == 'S' || memberVO.approvalFlag == 'N'}">
						    			<input type="button" id="btnEgovAppRefusal" name="btnEgovAppRefusal" value="승인거부" class="btn btn_basic" onclick="javascript:fn_egov_app_Refusal(document.memberVO);" alt="승인거부"/>
										<input type="button" id="btnEgovApp" name="btnEgovApp" value="승인" class="btn btn_basic" onclick="javascript:fn_egov_app(document.memberVO);" alt="승인"/>
						    		</c:when>
						    		<c:otherwise>
						    			<input type="button" id="btnEgovRegistMember" name="btnEgovRegistMember" value="저장" class="btn btn_basic" onclick="javascript:fn_egov_regist_Member(document.memberVO);" alt="저장"/>
						    			<input type="button" id="btnEgovUnlockMember" name="btnEgovUnlockMember" value="계정휴면해제" class="btn btn_basic" onclick="javascript:fn_egov_unlock_Member(document.memberVO);" alt="계정휴면해제"/>
						    			<input type="button" id="btnEgovUnlockWrongCnt" name="btnEgovUnlockPassword" value="비밀번호잠금해제" class="btn btn_basic" onclick="javascript:fn_egov_unlock_Password(document.memberVO);" alt="비밀번호잠금해제"/>
						    			<input type="button" id="btnEgovRemoveMember" name="btnEgovRemoveMember" value="계정삭제" class="btn btn_basic" onclick="javascript:fn_egov_remove_Member(document.memberVO);" alt="계정삭제"/>
						    		</c:otherwise>
						    	</c:choose>
						    </div>
							<!--top Search End-->
							<div  class="table_wrapper" >
								<table summary="유저정보">
									<colgroup>
										<col width="250px">
										<col />
									</colgroup>
									<tr>
										<th style="padding-top:0;">사용자 메뉴권한 <span class="red"></span></th>
										<td style="padding:0px;">
										<div class="wrapper" style="height: auto; overflow: auto; width: 740px;">
												<table>
													<colgroup>
														<col width="19%">
														<col width="19%">
														<col width="19%">
														<col width="19%">
														<col width="8%">
														<col width="8%">
														<col width="8%">
													</colgroup>
													<tr height="5px">
														<th>대분류</th>
														<th>중분류</th>
														<th>소분류</th>
														<th>텝이하</th>
														<th>C</th>
														<th>U</th>
														<th>D</th>
													</tr>
													<tbody id="userMenuAuthList">
														
													</tbody>
											</table>
											</div>
										</td>
									</tr>
								</table>
								<div class="topBx">
									<input type="button" value="저장" class="btn btn_basic" 
									onclick="javascript:userMenuAuthSave();" alt="저장"/>
								</div>
							</div>
							<input name="cmd" type="hidden" value="<c:out value='save'/>"/>
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
	
<div id="registlayerid" class="divPopup">
	<div id="xbox">
		<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
		<input type="button" id="btnSysRegXbox" name="btnSysRegXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('registlayerid');" alt="닫기"/>

	</div>
	<div>
		<div class="gBox" style="width:205px">
			<input type="hidden" id="auth_syskind"/>
			<input type="hidden" id="auth_myFactList"/>
			<span class="ptit" id="auth_title">
				수계
			</span>
			<select multiple="multiple" id="auth_riverdiv" style="padding:7px;width:205px;height:190px" onchange="auth_factlist()"></select>
		</div>
		
		<div style="padding-top:25px;float:left"><img src="/images/renewal/parrow.gif" alt="다음단계"/></div>
		
		<div class="gBox" style="width:220px">
			<span class="ptit">
				측정소
			</span>
			<select multiple="multiple" id="auth_factNo" style="padding:7px;width:220px;height:190px"></select>
		</div>
		
		<ul class="arrbx">
			<li style="padding-top:70px;"><a href="javascript:add()"><img src="<c:url value='/images/renewal/bt_arradd.gif'/>" alt="추가" /></a></li><br/>
			<li><a href="javascript:del()"><img src="<c:url value='/images/renewal/bt_arrdel.gif'/>" alt="삭제" /></a></li>
		</ul>
		
		<div class="gBox" style="width:220px">
			<span class="ptit">
				담당 측정소
			</span>
			<select multiple="multiple" id="auth_myFactNo" style="padding:7px;width:220px;height:190px"></select>
		</div>
	</div>
	
	<div class="btnSearchDiv" style="clear:both;padding-top:10px;">
		<div style="padding-right:10px;float:right;">
			<input type="button" id="btnEgovRegistMember" name="btnEgovRegistMember" value="저장" class="btn btn_search" onclick="return goSave();" alt="저장" />
		</div>
	</div>
</div>
</body>
</html>