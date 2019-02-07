<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	* Class Name : algacast.jsp
	* Description : 조류측정조회 화면
	* Modification Information
	* 
	* 수정일				수정자			수정내용
	* -------			--------	---------------------------
	* 2010.05.17		최초 생성
	* 2013.11.29		 리뉴얼
	*
	* author khany
	* since 2010.05.17
	*  
	* Copyright (C) 2010 by khany  All right reserved.
	*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<c:import url="/WEB-INF/jsp/include/common/include_algaManager.jsp" />		<!-- 조류정보관리자 -->
<c:import url="/WEB-INF/jsp/include/common/include_algaModifyAdmin.jsp" />	<!-- 조류정보수정권한 -->
<c:import url="/WEB-INF/jsp/include/common/include_adminFlag.jsp" />		<!-- 어드민플레그 -->
<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />			<!-- 로그인여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />

<script type="text/javascript">

	var searchStart;
	var searchEnd;
	var river_div;
	var mode;
	var cast_num;
	
	$(function () {

// 		set_User_deptNo(user_dept_no, "river_div");
		selectedSugyeInMemberId(user_riverid , 'river_div');
		
		searchStart = '${param.searchStart}';
		searchEnd = '${param.searchEnd}';
		river_div = '${param.river_div}';
		
		mode='${param.mode}';
		cast_num = '${param.cast_num}';

		pageIndex = '${param.pageIndex}';

		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yy/mm/dd',
			showOn: 'both',
			buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly: true
		});
		
		dataLoad();

		if(mode != null && mode == 'modify')
		{
			//수정 모드
			$("td>span").css("display", "none");
			$("#info").css("display","block");
			$("#btnModify").attr("alt", "저장");
			$("#btnModify").attr("onclick", "goModifyOk()");
			$("#btnModify").val("저장");
			$("#btnDelete").attr("alt", "취소");
			$("#btnDelete").attr("onclick", "cancelModify()");
			$("#btnDelete").val("취소");
			
			$("#survey_time").datepicker({
				buttonText: '측정일자'
			});
			$("#analysis_time").datepicker({
				buttonText: '분석일자'
			});
		}
		else
		{
			$("#info").css("display","none");
			$("td>input").css("display", "none");
			$("td>select").css("display", "none");
		}
	});
	
	//지점 목록 가져오기
	function fill_point_selectBox()
	{	

	}
	
	function dataLoad()
	{
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getAlgaCast.do'/>",
			data:{cast_num:cast_num},
			dataType:"json",
			success:dataLoad_success,
			error:function(result){
					alert("해당 데이터를 찾을 수 없습니다!");
			}
		});
	}

	function dataLoad_success(result)
	{
		var obj = result['algaData'];

		//수계
		$("#span_river_div").text(getSurveyPoint(obj.river_div));
		$("#river_div").val(getSurveyPoint(obj.river_div));
		

		$("#span_survey_point").text(obj.survey_point);
		$("#survey_point").val(obj.survey_point);

		
		//채취지점
		$("#span_analysis_point").text(getSurveyPoint(obj.analysis_point));
		$("#analysis_point").val(getSurveyPoint(obj.analysis_point));

		//채취일자
		$("#span_survey_time").text(obj.survey_time.substring(0,10));
		$("#survey_time").val(obj.survey_time.substring(0,10));

		//채취자명
		$("#span_name").text(obj.name);
		$("#name").val(obj.name);

		//분석기관
		$("#span_org").text(obj.org);
		$("#org").val(obj.org);

		//분석일자
		$("#span_analysis_time").text(obj.analysis_time.substring(0,10));
		$("#analysis_time").val(obj.analysis_time.substring(0, 10));

		//분석자명
		$("#span_analysis_name").text(obj.analysis_name);
		$("#analysis_name").val(obj.analysis_name);

		//PH
		$("#span_ph").text(obj.ph);
		$("#ph").val(obj.ph);
		$("#span_ph2").text(obj.ph2);
		$("#ph2").val(obj.ph2);

		//temp
		$("#span_temp").text(obj.temp);
		$("#temp").val(obj.temp);
		$("#span_temp2").text(obj.temp2);
		$("#temp2").val(obj.temp2);

		//chla
		$("#span_chla").text(obj.chla);
		$("#chla").val(obj.chla);
		$("#span_chla2").text(obj.chla2);
		$("#chla2").val(obj.chla2);

		//남조류
		$("#span_cyan").text(obj.cyan);
		$("#cyan").val(obj.cyan);
		$("#span_cyan2").text(obj.cyan2);
		$("#cyan2").val(obj.cyan2);
		
		check();
	}

	function getSurveyPoint(value)
	{
		var result;
		switch(value)
		{
		case "R01" :
			result = "한강";
			break;
		case "R02" :
			result = "낙동강";
			break;
		case "R03" :
			result = "금강";
			break;
		case "R04" :
			result = "영산강";
			break;
		default :
			result = value;
		}
		return result;
	}

	function goDelete()
	{
		if(algaManager || adminFlag)
		{
			if(confirm("삭제하시겠습니까?"))
			{
				$.getJSON("<c:url value='/waterpolmnt/waterinfo/deleteAlgaCast.do'/>", {cast_num:cast_num},
					function (data, status){
					if(status == 'success'){	 
							alert("데이터가 삭제되었습니다!");
							
							var param = "pageIndex="+pageIndex+"&cast_num=" + cast_num + "&searchStart=" + searchStart + "&searchEnd=" + searchEnd;
							window.location = "<c:url value='/waterpolmnt/waterinfo/goAlgaCast.do'/>?" + param;
					} else { 
							alert("삭제중 에러가 발생하였습니다.!");
						return;
					}
				});
			}
		}
		else
		{
			alert("해당 조류예보 정보를 삭제할 권한이 없습니다!");
		}
	}

	function goList()
	{
		var pIdx = document.listFrm.pageIndex.value;
		
		var param = "cast_num=" + cast_num + "&river_div=" + river_div + "&searchStart=" + searchStart + "&searchEnd=" + searchEnd + "&pageIndex=" + pIdx;
		window.location = "<c:url value='/waterpolmnt/waterinfo/goAlgaCast.do'/>?" + param;

		
		//var param = "cast_num=" + cast_num + "&survey_point=" + surveyPoint + "&searchStart=" + searchStart + "&searchEnd=" + searchEnd;
		//window.location = "<c:url value='/waterpolmnt/waterinfo/goAlgaCast.do'/>?" + param;

		//document.listFrm.action = "<c:url value='/waterpolmnt/waterinfo/getAlgaCastList.do'/>";

		//var pIdx = document.listFrm.pageIndex.value;

		
		//if(pIdx == "")
		//	document.listFrm.pageIndex.value = 1;
		
		//document.listFrm.submit();
	}
	
	function goModify()
	{

		if(algaManager || adminFlag)
		{
			//window.location = "<c:url value='/waterpolmnt/waterinfo/goAlgaCastView.do'/>?cast_num=" + cast_num + "&mode=modify";
	
			var param = "mode=modify&pageIndex="+pageIndex+"&cast_num=" + cast_num + "&river_div=" + river_div + "&searchStart=" + searchStart + "&searchEnd=" + searchEnd;
			document.listFrm.action = "<c:url value='/waterpolmnt/waterinfo/goAlgaCastView.do'/>?" + param;

			$("#survey_time").val($("#survey_time").val2());
			$("#analysis_time").val($("#analysis_time").val2());
			
			var pIdx = document.listFrm.pageIndex.value;
			
			if(pIdx == "")
				document.listFrm.pageIndex.value = 1;
			
			document.listFrm.submit();
		}
		else
		{
			alert("해당 조류예보 정보를 수정할 권한이 없습니다");
		}
	}


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
	
	function goModifyOk()
	{
		if(validation())
		{
			if(confirm("입력된 정보로 수정하시겠습니까?"))
			{
				var param = "pageIndex=" + pageIndex + "&cast_num=" + cast_num + "&river_div=" + river_div + "&searchStart=" + searchStart + "&searchEnd=" + searchEnd;
				
				document.alga.action = "<c:url value='/waterpolmnt/waterinfo/updateAlgaCast.do'/>?" + param;
	
				$("#survey_time").val($("#survey_time").val2());
				$("#analysis_time").val($("#analysis_time").val2());
				
				document.alga.submit();
			}
		}
	}

	function cancelModify()
	{
		var param = "pageIndex=" + pageIndex + "&cast_num=" + cast_num + "&river_div=" + river_div + "&searchStart=" + searchStart + "&searchEnd=" + searchEnd;
		
		window.location = "<c:url value='/waterpolmnt/waterinfo/goAlgaCastView.do'/>?" + param;
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
			$("#checkResult").val("입력이 잘못되었습니다");
			$("#spanCheckReslut").val("입력이 잘못되었습니다");
			return;
		}

	
	
		if(((chla1 >= 15 && chla1 <= 25) && (chla2 >= 15 && chla2 <= 25))&& ((cyan1 >= 500 && cyan1 <= 5000) && (cyan2 >= 500 && cyan2 <= 5000)))
		{
			$("#checkResult").val("조류주의보");
			$("#spanCheckResult").text("조류주의보");
		}
		else if(((chla1 > 25 && chla1 < 100) && (chla2 > 25 && chla2 < 100)) && (cyan1 > 5000 && cyan2 > 5000))
		{		
			$("#checkResult").val("조류경보");
			$("#spanCheckResult").text("조류경보");
		}
		else if((chla1 >= 100 && chla2 >= 100) && (cyan1 >= 106 && cyan2 >= 106))
		{
			$("#checkResult").val("조류대경보");
			$("#spanCheckResult").text("조류대경보");
		}
		else if((chla1 < 15 && chla2 < 15) || (cyan1 < 500 && cyan2 < 500))
		{
			$("#checkResult").val("해제");
			$("#spanCheckResult").text("해제");
		}
		else
		{
			$("#checkResult").val("정상");
			$("#spanCheckResult").text("정상");
		}
	}
	</script>
</head>

<body>
<%-- 	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div> --%>
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

						<form name="alga" method="post" enctype="multipart/form-data" >
							<input type="hidden" name="pageIndex" value="${alertMngVO.pageIndex}"/>
							<input type="hidden" name="search_date_start" value="${alertMngVO.search_date_start}"/>
							<input type="hidden" name="search_date_end" value="${alertMngVO.search_date_start}"/>
							
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
											<span id="span_river_div"></span>
											<select style="width:136px" id="river_div" name="river_div">
												<option value="R01">한강</option>
												<option value="R02">낙동강</option>
												<option value="R03">금강</option>
												<option value="R04">영산강</option>
											</select>
										</td>
										<th scope="row">지점</th>
										<td class="txtL">
											<span id="span_survey_point"></span>
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
											<span id="span_analysis_point"></span>
											<input type="text" name="analysis_point" id="analysis_point" maxlength="5"/>
										</td>
										<th scope="row">채수일자</th>
										<td class="txtL">
											<span id="span_survey_time"></span>
											<input type="text" id="survey_time" name="survey_time" maxlength="20" onchange="surveyTime()"/>
										</td>
										<th scope="row">채수자명</th>
										<td class="txtL">
											<span id="span_name"></span>
											<input type="text" id="name" name="name" maxlength="20"/>
										</td>
									</tr>
									<tr>
										<th scope="row">검사기관</th>
										<td class="txtL">
											<span id="span_org"></span>
											<input type="text" name="org" maxlength="20"/>
										</td>
										<th scope="row">검사일자</th>
										<td class="txtL">
											<span id="span_analysis_time"></span>
											<input type="text" id="analysis_time" name="analysis_time" maxlength="20" onchange="analysisTime()"/>
										</td>
										<th scope="row">검사자명</th>
										<td class="txtL">
											<span id="span_analysis_name"></span>
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
													<td><span id="span_chla"></span><input type="text" name="chla" id="chla" onkeypress="inputNumCheck()"/></td>
													<td><span id="span_chla2"></span><input type="text" name="chla2" id="chla2" onkeypress="inputNumCheck()"/></td>
												</tr>
												<tr>
													<td>남조류</td>
													<td>(cells/ml)</td>
													<td><span id="span_cyan"></span><input type="text" name="cyan" id="cyan" onkeypress="inputNumCheck()"/></td>
													<td><span id="span_cyan2"></span><input type="text" name="cyan2" id="cyan2" onkeypress="inputNumCheck()"/></td>
												</tr>
												<tr>
													<td>수온</td>
													<td>℃</td>
													<td><span id="span_temp"></span><input type="text" name="temp" id="temp" onkeypress="inputNumCheck()"/></td>
													<td><span id="span_temp2"></span><input type="text" name="temp2" id="temp2" onkeypress="inputNumCheck()"/></td>
												</tr>
												<tr>
													<td>pH</td>
													<td></td>
													<td><span id="span_ph"></span><input type="text" name="ph" id="ph" onkeypress="inputNumCheck()"/></td>
													<td><span id="span_ph2"></span><input type="text" name="ph2" id="ph2" onkeypress="inputNumCheck()"/></td>
												</tr>
											</tbody>
										</table>
									</div>
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
													<span id="spanCheckResult"></span>
													<input style="float:left" id="checkResult" type="text" readonly="readonly" />
													<span style="float:left" id="info">
														<input type="button" id="btnconform" name="btnconform" value="확인" class="btn btn_search" onclick="javascript:check();" alt="확인"/>
														<span style="font-size:11px; padding-left:10px;">* 입력된 검사정보의 결과를 보시려면 "확인"버튼을 누르세요.</span>
													</span>
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
										<input type="button" id="btnModify" name="btnModify" value="수정" class="btn btn_basic" onclick="javascript:goModify();" alt="수정"/>
										<input type="button" id="btnDelete" name="btnDelete" value="삭제" class="btn btn_basic" onclick="javascript:goDelete();" alt="삭제"/>
										<input type="button" id="btnList" name="btnList" value="목록" class="btn btn_basic" onclick="javascript:goList();" alt="목록"/>
									</div>
								</div>
							</div>
						</form>
						<form:form commandName="alertMngVO" name="listFrm" method="post">
							<input type="hidden" name="pageIndex" value="${param.pageIndex}"/>
							<input type="hidden" name="search_date_start" value="${param.searchStart}"/>
							<input type="hidden" name="search_date_end" value="${param.searchEnd}"/>
							<input type="hidden" name="river_div" value="${param.river_div}"/>
						</form:form>
						
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