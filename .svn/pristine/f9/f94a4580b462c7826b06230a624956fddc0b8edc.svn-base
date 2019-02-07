<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%@page import="daewooInfo.common.util.fcc.StringUtil"%>
<%
	String minTime = StringUtil.getTimeStamp();
%>
<%
  /**
  * @Class Name : alertSms.jsp
  * @Description : Alert SMS 수동발송 화면
  * @Modification Information
  * 
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  *  2010.05.20     khanian        최초 생성
  *
  * author khany
  * since 2010.05.20
  *  
  * Copyright (C) 2010 by khany  All right reserved.
  */
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />		
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
	<sec:authorize ifAnyGranted="ROLE_USER">
		<script  type='text/javascript'>
			var user_dept_no = '<sec:authentication property="principal.userVO.deptNo"/>';
		</script> 
	</sec:authorize>
	
<%-- 	<sec:authorize ifNotGranted="ROLE_USER"> --%>
<!-- 		<script  type='text/javascript'> -->
<!-- 			alert('로그인이 필요한 페이지 입니다'); -->
<%-- 			window.location = "<c:url value='/'/>";  --%>
<!-- 		</script>  -->
<%-- 	</sec:authorize>		 --%>

<script type='text/javascript'>
$(function () {
	
	adjustGongkuDropDown();
	
   $('#sugye')
   	.change(function(){
   		adjustGongkuDropDown();
   	})

   	$('input[name=system]').click(function(){
   		changeSystem($('input[name=system]:checked').val());
   		adjustGongkuDropDown();		
   	})  	

   	changeSystem("T");  	
});

function validation(){
	if( $('#subject').val() == "" ){ alert("제목을 입력하세요"); return false; }
	if( $('#factCode').val() == "" ){ alert("공구를 선택하세요"); return false; }
	if( $('#smsMsg').val() == "" ){ alert("SMS 메세지를 생성하세요"); return false; }
	//if( $('#minVl').val() == "" ){ alert("측정치를 입력하세요"); return false; }

	return true;
}

function changeSystem(str) {
	var itemT = "";
	var itemI = "";
	var optionArrT = new Array;
	var optionArrI = new Array;
	
	var frm = document.detailForm;	
	
	optionArrT.push({CAPTION:"경보",VALUE:"3"});

	optionArrI.push({CAPTION:"관심",VALUE:"1"});
	optionArrI.push({CAPTION:"주의",VALUE:"2"});
	optionArrI.push({CAPTION:"경계",VALUE:"3"});
	optionArrI.push({CAPTION:"심각",VALUE:"4"});
		

	$("#itemBody").html("");
	
	itemT = '<tr class="noLine"><th scope="row"><label for="">항목</label>'
		  + '</th><td><select id="itemCode" name="itemCode">'
		  + '<option value="TUR00">탁도</option>'
		  + '</select></td></tr>'
		  + '<tr><th scope="row"><label for="">측정치</label></th>'
		  + '<td><input type="text" class="inputText" id="minVl" name="minVl"/></td></tr>';
		 
	itemI = '<tr class="noLine"><th scope="row"><label for="">항목</label>'
		  + '</th><td><select id="itemCodeArr" name="itemCodeArr">'
		  + '<option value="PHY00">pH</option>'
		  + '<option value="CON00">EC</option>'
		  + '<option value="DOW00">DO</option>'
		  + '</select></td></tr>'
		  + '<tr><th scope="row"><label for="">측정치</label></th>'
		  + '<td><input type="text" class="inputText" id="minVlArr" name="minVlArr"/></td></tr>';		  	 	
 
	if(str == "T") {
		$('#minOr').loadSelect(optionArrT);		
		$("#itemBody").append(itemT);
	    frm.action = "<c:url value='/alert/addAlert.do'/>";		
	} else if(str == "U") {
		$('#minOr').loadSelect(optionArrI);
		$("#itemBody").append(itemI);
		$("#itemBody").append(itemI);
	    frm.action = "<c:url value='/alert/addAlertUsn.do'/>";		
	}	 				
}

function fncSave() {
	var frm = document.detailForm;
	
	if (validation()){
	    frm.submit();
	}
}

/*
 * 
			// 경보 메시지를 만든다.
			if ("1".equals(minOr) ){
				subject = subject+" 관심";
				smsMsg.append("USN 관심 발생 ");				
			}
			else if ("2".equals(minOr) ){
				subject = subject+" 주의";
				smsMsg.append("USN 주의 발생 ");				
			}
			else if ("3".equals(minOr) ){
				subject = subject+" 경계";
				smsMsg.append("USN 경계 발생 ");				
			}
			else if ("4".equals(minOr) ){
				subject = subject+" 심각";
				smsMsg.append("USN 심각 발생 ");
			}			
			
			smsMsg.append(factName).append(branchNo)
			.append("측정소 ").append(minTime.substring(0, 4))
			.append("/").append(minTime.substring(4, 6))
			.append("/").append(minTime.substring(6, 8))
			.append("/").append(minTime.substring(8, 10))
			.append("/").append(minTime.substring(10, 12))
			.append(" ").append(itemName[0]).append(" ").append(minVlArr[0])
			.append(" ").append(itemName[1]).append(" ").append(minVlArr[1]);
			
 */
function getSmsMsg() {
	var system = $('input[name=system]:checked').val();  
	var minOr = $('#minOr').val();
	var minTime = '<%=minTime%>';	
	var smsMsg = "";

	if(system == "T") {
		if(minOr == "1") {
			smsMsg = smsMsg + "탁도(관심)  ";
		} else if(minOr == "2") {
			smsMsg = smsMsg + "탁도(주의) ";
		} else if(minOr == "3") {
			smsMsg = smsMsg + "탁도(경보) ";
		}
		smsMsg = smsMsg + $(":select[name=factCode]>option:selected").text() + "-" + $('#branchNo').val();
		smsMsg = smsMsg + " ";
		smsMsg = smsMsg + minTime.substring(2, 4);
		smsMsg = smsMsg + "" + minTime.substring(4, 6);
		smsMsg = smsMsg + "" + minTime.substring(6, 8);
		smsMsg = smsMsg + " " + minTime.substring(8, 10);
		smsMsg = smsMsg + ":" + minTime.substring(10, 12);

		$('#smsMsg').attr('value', smsMsg);
	} else if(system == "U") {
		if(minOr == "1") {
			smsMsg = smsMsg + "USN(관심) ";
		} else if(minOr == "2") {
			smsMsg = smsMsg + "USN(주의) ";
		} else if(minOr == "3") {
			smsMsg = smsMsg + "USN(경계) ";
		} else if(minOr == "4") {
			smsMsg = smsMsg + "USN(심각) ";
		}		

		smsMsg = smsMsg + $(":select[name=factCode]>option:selected").text() + "-" + $('#branchNo').val();
		smsMsg = smsMsg + " ";
		smsMsg = smsMsg + minTime.substring(2, 4);
		smsMsg = smsMsg + "" + minTime.substring(4, 6);
		smsMsg = smsMsg + "" + minTime.substring(6, 8);
		smsMsg = smsMsg + " " + minTime.substring(8, 10);
		smsMsg = smsMsg + ":" + minTime.substring(10, 12);
		smsMsg = smsMsg + " " + $(":select[name=itemCodeArr]>option:selected").eq(0).text();
		smsMsg = smsMsg + " " + $("input[name=minVlArr]").eq(0).val();		
		smsMsg = smsMsg + " " + $(":select[name=itemCodeArr]>option:selected").eq(1).text();
		smsMsg = smsMsg + " " + $("input[name=minVlArr]").eq(1).val();
				
		$('#smsMsg').attr('value', smsMsg);
	}
}
</script>
</head>
<body class="popup_sms">
<div id="wrap">
	<div class="smsSection">
		<h1><img src="<c:url value='/images/popup/h1_popupSms.gif'/>" alt="SMS 발송" /></h1>
			<form:form commandName="alertDataVO" name="detailForm" method="post" cssClass="writeForm" onsubmit="return false;">
			<fieldset>
				<legend class="hidden_phrase">SMS 발송 폼</legend>				
				<table class="dataTable">
					<colgroup>
						<col width="70px">
						<col />
					</colgroup>					 
					<tr>
						<th scope="row"><label for="">유형</label></th>
						<td>
							<ul class="smsSelect">
<!-- 								<li> -->
<!-- 									<input type="radio" class="inputRadio" id="system" name="system" value="T" /><label for="">탁수모니터링</label>  -->
<!-- 								</li> -->
								<li>
									<input type="radio" class="inputRadio" id="system" name="system" value="U" checked/><label for="">이동형측정기기</label>
								</li>
							 </ul>																																																											
						</td>
					</tr>			 					 
					<tr>
						<th scope="row"><label for="">제목</th>
						<td><input type="text" class="inputText" id="subject" name="subject" />
							<span class="align">							
							<input type="checkbox" class="inputCheck" id="userId" name="userId" value="1" checked="true"/><label for="">훈련</label>
							</span>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="">장소</label></th>
						<td>
							<select id="sugye" name="riverId">
							   <option value="R01">한강</option>
							   <option value="R02">낙동강</option>
							   <option value="R03">금강</option>
							   <option value="R04">영산강</option>
							</select>
							<span class="space">&gt;</span>
							<select id="factCode" name="factCode">
							   <option value="">선택</option>
							</select>
							<span class="space">&gt;</span>
							<select id="branchNo" name="branchNo">
							   <option value="1">1측정소</option>
							</select>
						</td>
					</tr> 
					<tr>
						<th scope="row"><label for="">단계</label></th>
						<td>
							<select id="minOr" name="minOr"></select>
						</td>
					</tr>					
				</table>
				<table class="dataTable">				
					<colgroup>
						<col width="70px">
						<col />
					</colgroup>				
					<tbody id="itemBody">							
						<tr class="noLine">
							<th scope="row"><label for="">항목</label></th>
							<td>
								<select id="itemCode" name="itemCode">
									<option value="TUR00">탁도</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="">측정치</label></th>
							<td>
								<input type="text" class="inputText" id="minVl" name="minVl"/>
							</td>
						</tr>								
					</tbody>											
				</table>
				<table class="dataTable">				
					<colgroup>
						<col width="70px">
						<col />
					</colgroup>				
					<tbody>											
						<tr class="noLine">
							<th scope="row"><label for="">SMS</label></th>
							<td>
								<input type="text" class="inputText" id="smsMsg" name="smsMsg" style="width:360px"/>
								<input type="button" value="생성" onclick="getSmsMsg()" />
							</td>
						</tr>								
					</tbody>											
				</table>				
				<ul class="btn">
					<li><input type="image" src="<c:url value='/images/common/btn_spread.gif'/>" alt="상황전파" onClick="javascript:fncSave();"/></li>
					<li><a href="javascript:close();"><img src="<c:url value='/images/common/btn_close.gif'/>" alt="취소" /></a></li>
				</ul>					
			</fieldset>
			</form:form>
	</div>
</div>
</body>
</html>
