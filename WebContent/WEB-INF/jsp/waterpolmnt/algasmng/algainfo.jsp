<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : algainfo.jsp
	 * Description : 측정정보입력 화면
	 * Modification Information
	 * 
	 * 수정일        			 수정자                   수정내용
	 * ----------    	--------    ---------------------------
	 * 2013.10.31		lkh         리뉴얼
	 *
	 * author ...
	 * since 2013.10.31
	 *   
	 * Copyright (C) 2010 by ...  All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<c:import url="/WEB-INF/jsp/include/common/include_algaInsertAdmin.jsp" />	<!-- 조류입력권한 -->
<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />			<!-- 로그인여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />	

<script type="text/javascript">

	
	$(function () {	

		var regok = '${param.algareg}';

		if(regok != null)
		{
			if(regok == 'true')
			{
				if(confirm("조류예보 등록에 성공했습니다. 조류예보 목록으로 이동하시겠습니까?"))
				{
					window.location = "<c:url value='/waterpolmnt/waterinfo/goAlgaCast.do'/>";
				}
			}
			else if(regok == 'false')
			{
				alert("조류예보 등록 실패!");
			}
		}
		
		$.datepicker.setDefaults({
		    monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
		    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		    showMonthAfterYear:true,
		    dateFormat: 'yy/mm/dd',
		    showOn: 'both',
		    buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
		    buttonImageOnly: true
		});
		
		$("#survey_time").datepicker({
		    buttonText: '측정일자'
		    
		});
		$("#analysis_time").datepicker({
		    buttonText: '분석일자'
		});


		var today = new Date(); 

		today = today.getFullYear()+"/"+ addzero(today.getMonth()+1) + "/" + addzero(today.getDate());
		
	

		function addzero(n) {
			 return n < 10 ? "0" + n : n + "";
		}

		$("#survey_time").val(today);
		$("#analysis_time").val(today);
		
		selectedSugyeInMemberId(user_riverid , 'river_div');
	});

	function validation()
	{
		var flag = true;
		
		$("td > input").each(function(){
			if($(this).val() == "" && $(this).attr("id") != "checkResult")
			{
				alert("데이터를 입력해 주세요");
				$(this).focus();
				flag = false;
				return false;
			}
		});

		return flag;		
	}
	
	function insert_alga() {

		if(validation())
		{
			if(confirm("조류 예보를 등록하시겠습니까?"))
			{
				document.alga.action = "<c:url value='/waterpolmnt/algasmng/insertAlgas.do'/>";

				$("#survey_time").val($("#survey_time").val2());
				$("#analysis_time").val($("#analysis_time").val2());
				
				document.alga.submit();
			}
		}					
	}


	//지점 목록 가져오기
	function fill_point_selectBox()
	{	
	
	}

	//조류 체크
	function check()
	{
		var chla1 = parseInt($("#chla").val());
		var chla2 = parseInt($("#chla2").val());

		var cyan1 = parseInt($("#cyan").val());
		var cyan2 = parseInt($("#cyan2").val());

		if(isNaN(chla1) || isNaN(chla2) || isNaN(cyan1) || isNaN(cyan2))
		{
			alert('입력이 잘못되었습니다.');
			$("#checkResult").val("Error");
			return;
		}
	
	
		if(((chla1 >= 15 && chla1 <= 25) && (chla2 >= 15 && chla2 <= 25))&& ((cyan1 >= 500 && cyan1 <= 5000) && (cyan2 >= 500 && cyan2 <= 5000)))
		{
			$("#checkResult").val("조류주의보");
		}
		else if(((chla1 > 25 && chla1 < 100) && (chla2 > 25 && chla2 < 100)) && (cyan1 > 5000 && cyan2 > 5000))
		{
			$("#checkResult").val("조류경보");
		}
		else if((chla1 >= 100 && chla2 >= 100) && (cyan1 >= 106 && cyan2 >= 106))
		{
			$("#checkResult").val("조류대경보");
		}
		else if((chla1 < 15 && chla2 < 15) || (cyan1 < 500 && cyan2 < 500))
		{
			$("#checkResult").val("해제");
		}
		else
		{
			$("#checkResult").val("정상");
		}
	}
	function surveyTime() {
		var dateCheck = /^(19[7-9][0-9]|20\d{2})\/(0[0-9]|1[0-2])\/(0[1-9]|[1-2][0-9]|3[0-1])$/;
		var survey_time = document.getElementById("survey_time");
		if(survey_time !=''){
			if(dateCheck.test(survey_time.value)!=true){
				
				var returnValue = commonWork2(survey_time.value, "survey_time");
				
				if(returnValue != 'true'){
					alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
					survey_time.value="";
					survey_time.focus();
					return false;					
				}				
			}
		}else{
			alert("채수일자를 입력하여 주십시오.");			
			survey_time.focus();
		}
	}  
	function analysisTime() {
		var dateCheck = /^(19[7-9][0-9]|20\d{2})\/(0[0-9]|1[0-2])\/(0[1-9]|[1-2][0-9]|3[0-1])$/;
		var survey_time = document.getElementById("analysis_time");
		if(survey_time !=''){
			if(dateCheck.test(survey_time.value)!=true){
				
				var returnValue = commonWork2(survey_time.value, "analysis_time");
				
				//숫자만 입력 체크를 통과못하면.
				if(returnValue != 'true'){
					alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
					survey_time.value="";
					survey_time.focus();
					return false;
				}
			}
		}else{
			alert("검사일자를 입력하여 주십시오.");			
			survey_time.focus();
		}
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
				checkNum    = "true";
			}else{
				returnValue = "false";
				checkNum    = "false";
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

					<form name="alga" method="post" enctype="multipart/form-data">
						
						<div class="table_wrapper">
						
							<div class="topBx">
								<span class="buSqu_tit">일반사항</span>
							</div>
						
							<table summary="일반사항" style="text-align:left">
								<colgroup>
									<col width="140px" />
									<col />
									<col width="140px" />
									<col />
								</colgroup>
								<tr>
									<th scope="row">수계</th>
									<td class="txtL">
										<select style="width:136px" id="river_div" name="river_div">
											<option value="R01">한강</option>
											<option value="R02">낙동강</option>
											<option value="R03">금강</option>
											<option value="R04">영산강</option>
										</select>
									</td>
									<th scope="row">지점</th>
									<td class="txtL">
										<input type="text" name="survey_point" id="survey_point"/>
									</td>
								</tr>
							</table>
							<br />
							<table summary="채수/검사정보" style="text-align:left">
								<colgroup>
									<col width="140px" />
									<col />
									<col width="140px" />
									<col />
									<col width="140px" />
									<col />
								</colgroup>
								<tr>
									<th scope="row">채수지점</th>
									<td class="txtL">
										<input type="text" name="analysis_point" id="analysis_point" maxlength="5"/>
									</td>
									<th scope="row">채수일자</th>
									<td class="txtL">
										<input type="text" id="survey_time" name="survey_time" maxlength="20" onchange="surveyTime()" size="13"/>
									</td>
									<th scope="row">채수자명</th>
									<td class="txtL">
										<input type="text" id="name" name="name" maxlength="20"/>
									</td>
								</tr>
								<tr>
									<th scope="row">검사기관</th>
									<td class="txtL">
										<input type="text" name="org" maxlength="20"/>
									</td>
									<th scope="row">검사일자</th>
									<td class="txtL">
										<input type="text" id="analysis_time" name="analysis_time" maxlength="20" onchange="analysisTime()" size="13"/>
									</td>
									<th scope="row">검사자명</th>
									<td class="txtL">
										<input type="text" name="analysis_name" maxlength="20"/>
									</td>
								</tr>
							</table>
									
							<div class="divisionBx">
								<div class="div50">
									<div class="topBx txtalignL">
										<span class="buSqu_tit">검사정보</span>
									</div>
									<table summary="측정정보">
										<colgroup>
											<col width="110px" />
											<col width="120px" />
											<col width="" />
											<col />
										</colgroup>
										<thead>
											<tr>
												<th scope="col">측정항목</th>
												<th scope="col">단위</th>
												<th scope="col">1회</th>
												<th scope="col">2회</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>chl-a</td>
												<td>(mg/m2)</td>
												<td><input type="text" name="chla" id="chla" onkeypress="inputNumCheck()"/></td>
												<td><input type="text" name="chla2" id="chla2" onkeypress="inputNumCheck()"/></td>
											</tr>
											<tr>
												<td>남조류</td>
												<td>(cells/ml)</td>
												<td><input type="text" name="cyan" id="cyan" onkeypress="inputNumCheck()"/></td>
												<td><input type="text" name="cyan2" id="cyan2" onkeypress="inputNumCheck()"/></td>
											</tr>
											<tr>
												<td>수온</td>
												<td>℃</td>
												<td><input type="text" name="temp" id="temp" onkeypress="inputNumCheck()"/></td>
												<td><input type="text" name="temp2" id="temp2" onkeypress="inputNumCheck()"/></td>
											</tr>
											<tr>
												<td>pH</td>
												<td></td>
												<td><input type="text" name="ph" id="ph" onkeypress="inputNumCheck()"/></td>
												<td><input type="text" name="ph2" id="ph2" onkeypress="inputNumCheck()"/></td>
											</tr>
										</tbody>
									</table>
								</div>
								<!--  
								<div class="div50 last">
									<div class="topBx txtalignL">
										<span class="buSqu_tit">경보발령기준표</span>
									</div>
									<table summary="발령정보">
										<colgroup>
											<col width="90" />
											<col />
										</colgroup>
										<thead>
											<tr>
												<th scope="col">단계</th>
												<th scope="col">발령기준</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>조류주의보</td>
												<td style="text-align:left;padding-top:3px;padding-left:15px;padding-bottom:3px">2회 연속채취시 Chl-a 농도 15～25mg/㎥</br>남조류 세포수 500～5,000세포/㎖</td>
											</tr>
											<tr>
												<td>조류경보</td>
												<td style="text-align:left;padding-top:3px;padding-left:15px;padding-bottom:3px">2회 연속채취시 Chl-a 농도 25mg/㎥ 이상</br>남조류 세포수 5,000세포/㎖ 이상</td>
											</tr>
											<tr>
												<td>조류대발생</td>
												<td style="text-align:left;padding-top:3px;padding-left:15px;padding-bottom:3px">2회 연속채취시 Chl-a 농도 100mg/㎥ 이상</br>남조류 세포수 106세포/㎖ 이상이고 스컴(Scum) 발생시</td>
											</tr>
											<tr>
												<td>해제</td>
												<td style="text-align:left;padding-top:2px;padding-left:15px;padding-bottom:2px">2회 연속채취시 Chl-a 농도 15mg/㎥ 이하</br>남조류 세포수 500세포/㎖ 이하인 경우</td>
											</tr>
										</tbody>
									</table>
								</div>
								-->
								<div class="div50 last">
									<div class="topBx txtalignL">
										<span class="buSqu_tit">경보발령기준표</span>
									</div>
									<table summary="발령정보">
										<colgroup>
											<col width="90" />
											<col />
										</colgroup>
										<thead>
											<tr>
												<th scope="col">구간</th>
												<th scope="col">단계</th>
												<th scope="col">발령기준</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td rowspan="4"><h4>상수원</br>구간</h4></td>
												<td>관심</td>
												<td style="text-align:left;padding-top:3px;padding-left:15px;padding-bottom:3px">2회 연속 채취 시 남조류 세포수가 1,000 세포/mL 이상</br>10,000 세포/mL 미만인 경우</td>
											</tr>
											<tr>
												<td>경계</td>
												<td style="text-align:left;padding-top:3px;padding-left:15px;padding-bottom:3px">2회 연속 채취 시 남조류 세포수가 10,000 세포/mL 이상</br>100,000 세포/mL 미만인 경우</td>
											</tr>
											<tr>
												<td>조류</br>대발생</td>
												<td style="text-align:left;padding-top:3px;padding-left:15px;padding-bottom:3px">2회 연속 채취 시 남조류 세포수가 1,000,000 세포/mL 이상인 경우</td>
											</tr>
											<tr>
												<td>해제</td>
												<td style="text-align:left;padding-top:2px;padding-left:15px;padding-bottom:2px">2회 연속 채취 시 남조류 세포수가 1,000 세포/mL 미만인 경우</td>
											</tr>
											<tr>
												<td rowspan="3"><h4>친수활동</br>구간</h4></td>
												<td>관심</td>
												<td style="text-align:left;padding-top:3px;padding-left:15px;padding-bottom:3px">2회 연속 채취 시 남조류 세포수가 20,000 세포/mL 이상</br>100,000 세포/mL 미만인 경우</td>
											</tr>
											<tr>
												<td>경계</td>
												<td style="text-align:left;padding-top:3px;padding-left:15px;padding-bottom:3px">2회 연속 채취 시 남조류 세포수가 100,000 세포/mL 이상인 경우</td>
											</tr>
											<tr>
												<td>해제</td>
												<td style="text-align:left;padding-top:2px;padding-left:15px;padding-bottom:2px">2회 연속 채취 시 남조류 세포수가 20,000 세포/mL 미만인 경우</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="divisionBx" style="display:inline-block">
								<div class="topBx txtalignL">
									<span class="buSqu_tit">결과확인</span>
								</div>
							
								<table summary="조류정보">
									<colgroup>
										<col width="220px" />
										<col />
									</colgroup>
										<tr>
											<th scope="row">조류검사결과</th>
											<td class="txtL">
												<input id="checkResult" type="text" readonly="readonly" />
												<input type="button" id="btnconform" name="btnconform" value="확인" class="btn btn_search" onclick="javascript:check();"/>
												<span>* 입력된 검사정보의 결과를 보시려면 "확인"버튼을 누르세요.</span>
											</td>
										</tr>
										<tr>
											<th scope="row">연관 취정수장 정보</th>
											<td class="txtL">
												<textarea rows="7" cols="125" class="textArea"></textarea>
											</td>
										</tr>
									</table>
									<!-- 
									<table class="dataTable">
										<colgroup>
											<col width="220px" />
											<col />
										</colgroup>
										<tr>
											<th scope="row">첨부자료</th>
											<td>
												<ul>
													<li><input type="file" id="file" size="105"/></li>
												</ul>
											</td>
										</tr>
									</table>
									 -->
								<br />
								<div id="btArea">
									<input type="button" id="btnRegist" name="btnRegist" value="등록" class="btn btn_basic" onclick="javascript:insert_alga();" />
								</div>
								</div>
							</div>
						</form>
						
					</div>
					<!--tab content End-->
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