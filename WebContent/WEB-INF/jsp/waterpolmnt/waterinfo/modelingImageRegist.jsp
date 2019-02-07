<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : modelingImageRegist.jsp
	 * Description : 물길정보 이미지 입력화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2018.11.12	assist5		최초 생성
	 * 
	 * author choi hoe seop
	 * since 2018.01.
	 * 
	 * Copyright (C) 2018 by Naturetech All right reserved.
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

<script type="text/javascript">
//<![CDATA[
	$(function () {
		setDate();
	});
	
	function setDate() {
		var date = new Date();
		/* var hour = date.getHours();
		time=hour<10?"0"+hour:hour;
		$("#toTime option[value="+time+"]").attr("selected", "true"); */
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yy/mm/dd',
			showOn: 'both',
			buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly: true
		});
		$("#startDate").datepicker({
			buttonText: '시작일'
		});
		$("#endDate").datepicker({
			buttonText: '종료일'
		});
		var todayObj = new Date();
		var yday = new Date();		
		yday = yday.getFullYear()+ "/" + addzero(yday.getMonth()+1) + "/" + addzero(yday.getDate());
		var today = todayObj.getFullYear()+"/"+ addzero(todayObj.getMonth()+1) +"/"+ addzero(todayObj.getDate());		
		/* var time = todayObj.getHours();
		var timeStr = addzero(time-2);
		if(time <= 0)
			timeStr = "00";
		$("#frTime > option[value=" + timeStr + "]").attr("selected", "selected"); */
		function addzero(n) {
			 return n < 10 ? "0" + n : n + "";
		}		
		$("#startDate").val(yday);
		$("#endDate").val(today);
	}
	
	function commonWork(n) {
		var stdt = document.getElementById("startDate");
		var endt = document.getElementById("endDate");
		var dateCheck = /^(19[7-9][0-9]|20\d{2})\/(0[0-9]|1[0-2])\/(0[1-9]|[1-2][0-9]|3[0-1])$/;
		
		if(stdt.value !=''){
			if(dateCheck.test(stdt.value)!=true){
				
				var returnValue = commonWork2(stdt.value, "startDate");
				
				//숫자만 입력 체크를 통과못하면.
				if(returnValue != 'true'){
					alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
					stdt.value = "";
					stdt.focus;
					return false;
				}
			}
		}
		if(endt.value !=''){
			if(dateCheck.test(endt.value)!=true){
				
				var returnValue = commonWork2(endt.value, "endDate");
				
				//숫자만 입력 체크를 통과못하면.
				if(returnValue != 'true'){
					alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
					endt.value = "";
					endt.focus;
					return false;
				}
			}
		}
		
		var date = new Date(stdt.value).getTime();
		var overdate =  new Date(date + (60*60*24*7)*1000);
		var strdate = overdate.getFullYear()+ "/" + addzero(overdate.getMonth()+1) + "/" + addzero(overdate.getDate());
		
		if(endt.value != '' && stdt.value > endt.value) {
			alert("종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			if($(n).attr("id") == "startDate") {endt.value = ""; endt.focus();}
			if($(n).attr("id") == "endDate") {stdt.value = ""; stdt.focus();}
		}
		
		if(endt.value != '' && strdate < endt.value) {
			alert("등록 기간은 일주일 단위 입니다.\n\n다시 입력해 주십시오.");
			if($(n).attr("id") == "startDate") {endt.value = ""; endt.focus();}
			if($(n).attr("id") == "endDate") {stdt.value = ""; stdt.focus();}
		}
		
		//timeCheck();
	}
	
	//숫자만 입력했을때 자동완성을 위한 함수
	// 1. 8자리 체크
	// 2. 1000 년이후 체크
	// 3. 월 체크
	// 4. 일 체크
	function commonWork2(dateValue, inputId){
		var returnValue = "";
		var checkNum = "";
		
		for(var i=0 ; i<dateValue.length ; i++){
			var checkCode = dateValue.charCodeAt(i);
			
			//숫자로만 이루어져 있는지 여부 체크.
			if( checkCode >= 48 && checkCode <= 57 ){
				checkNum	= "true";
			}else{
				returnValue = "false";
				checkNum	= "false";
				break;
			}
		}
		
		//숫자로만 이루어져 있다면.
		if(checkNum == "true"){
			if( dateValue.length != 8){ //8자리가 아니면 false;
				returnValue = "false";
			}else{
				
				//년 비교
				if( !(1000 < Number(dateValue.substr(0,4)) && Number(dateValue.substr(0,4)) <= 9999 )){
					returnValue = "false";
				}else{
					var month = ["01","02","03","04","05","06","07","08","09","10","11","12"];
					var monthCheck = 'false';
					
					for(var j=0 ; j < month.length ; j++){
						if(Number(dateValue.substr(4,2)) == month[j]){
							monthCheck = 'true';
							break;
						}
					}
					
					//월 비교 통과했다면.
					if(monthCheck == 'true'){
						var day = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"];
						var dayCheck = 'false';
						
						for(var k=0 ; k < day.length ; k++){
							if(Number(dateValue.substr(6,2)) == day[k]){
								dayCheck = 'true';
								break;
							}
						}
						
						//일체크를 통과했다면.
						if(dayCheck == 'true'){
							var tempVar = dateValue.substr(0,4) + '/' + dateValue.substr(4,2) + '/' + dateValue.substr(6,2);
							document.getElementById(inputId).value = tempVar;
							returnValue = 'true';
						}else{
							returnValue = "false";
						}
						
					}else{
						returnValue = "false";
					}
				}
			}
		}
		return returnValue;
	}
	
	function goSubmit(){
		var obj = document.dailyWork;
		var msg = "";
		if('${param.seqNo}'=='' || '${param.seqNo}' == null) {
			msg = "<spring:message code="common.save.msg" />";
		} else {
			msg = "<spring:message code="common.update.msg" />";
		}
		if(confirm(msg)){
			if(obj.startDate.value=="") {
				alert("시작일자를 선택해주세요.");
				obj.startDate.focus();
				return false;
			}
			if(obj.endDate.value=="") {
				alert("종료일자를 선택해주세요.");
				obj.endDate.focus();
				return false;
			}
			if(obj.itemCode.value=="") {
				alert("항목을 선택해주세요.");
				obj.itemCode.focus();
				return false;
			}
			if(!obj.files.value){
				alert("파일을 첨부하십시오.");
				obj.files.focus();
				return false;
			} else {
				ban = obj.files.value.substring(obj.files.value.lastIndexOf('.'),obj.files.value.length).toLowerCase();    
				if(ban != ".mp4" && ban != ".avi"){
					alert("MP4, AVI 파일만 첨부 하실수 있습니다.");
					obj.files.focus();
					return false;
				}
				
				obj.imageDateFrom.value = $("#startDate").val2();
				obj.imageDateTo.value = $("#endDate").val2();
				obj.submit();
			}
		}
		
	}
	
//]]>
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
						<div class="table_wrapper">
							<form:form commandName="dailyWork" name="dailyWork" method="post" action="/waterpolmnt/waterinfo/uploadModelingImage.do" enctype="multipart/form-data" >
								<input type="hidden" name="imageDateFrom" id="imageDateFrom"/>
								<input type="hidden" name="imageDateTo" id="imageDateTo"/>
								<div>
									<div style="clear:both;">
									<table style="text-align:left" summary="관리자정보">
										<colgroup>
											<col width="25%">
											<col>
										</colgroup>	
										<tr>
											<th>일자 <span class="red">*</span></th>
											<td>
												<input type="text" size="13" id="startDate" name="startDate" onchange="commonWork(this)"/>
												<span>~</span>
												<input type="text" size="13" id="endDate" name="endDate" onchange="commonWork(this)"/>
											</td>
										</tr>
										<tr>
											<th>항목선택 <span class="red">*</span></th>
											<td>
												<input type="radio" name="itemCode" value="TMP00" checked="checked"/>수온
												&nbsp;&nbsp;<input type="radio" name="itemCode" value="DOW00"/>DO
												&nbsp;&nbsp;<input type="radio" name="itemCode" value="BOD00"/>CBOD
												&nbsp;&nbsp;<input type="radio" name="itemCode" value="NH400"/>NH<sub>4</sub>
												&nbsp;&nbsp;<input type="radio" name="itemCode" value="NO300"/>NO<sub>3</sub>
												&nbsp;&nbsp;<input type="radio" name="itemCode" value="PO400"/>PO<sub>4</sub>
											</td>
										</tr>
										<tr>
											<th>이미지 <span class="red">*</span></th>
											<td>
												<input type="file" name="image" id="files" size="50" class="tbox03">
											</td>
										</tr>
									</table>
									</div>
									</
									<div id="btSmallArea" style="text-align:right;padding-top:10px;">
										<div style="float:right;">
											<input type="button" id="btnAddNotice" name="btnAddNotice" value="저장" class="btn btn_basic" onclick="goSubmit();" alt="저장" />
										</div>
									</div>
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
	
	<script language="javascript">
	function menuAuth(){
		var menuAuth = ""	;
		
		if(id=='${resultList[0].regId}') {
			menuAuth = "1";
		}		
		return menuAuth;
	}
	if("1" == menuAuth()){
		$("#menuAuth1").show();
	}else{
		$("#menuAuth1").hide();
	}
	</script>
</body>
</html>