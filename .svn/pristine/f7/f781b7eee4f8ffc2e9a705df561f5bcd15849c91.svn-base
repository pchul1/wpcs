<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<c:import url="/WEB-INF/jsp/include/common/include_airAdmin.jsp" />		<!-- 항공감시 정보를 수정할 권한 -->
<c:import url="/WEB-INF/jsp/include/common/include_adminFlag.jsp" />	<!-- 어드민 Flag true -->
<c:import url="/WEB-INF/jsp/include/common/include_airManager.jsp" />		<!-- 항공감시관리자 권한 -->
<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />		<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />	
	
<script type="text/javascript">

	var searchStart;
	var searchEnd;
	var sugye;
	var mode;
	var obv_num;
	var pageIndex;
	
	$(function () {

		set_User_deptNo(user_dept_no, "i_sugye");
		
		searchStart = '${param.searchStart}';
		searchEnd = '${param.searchEnd}';
		sugye = '${param.sugye}';
		mode='${param.mode}';
		obv_num = '${param.obv_num}';
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
	    	$("td>span.val").css("display", "none");
	    	$("#btnModify").attr("href", "javascript:goModifyOk()");
	    	$("#imgModify").attr("src", "<c:url value='/images/common/btn_save.gif'/>");
			$("#btnDelete").attr("href", "javascript:cancelModify()");
			$("#imgDelete").attr("src", "<c:url value='/images/common/btn_cancel.gif'/>");
			
	    	$("#i_flight_date").datepicker({
			    buttonText: '운항일자'
			});
		}
		else
		{
			$("td>input[id^=i]").css("display", "none");
			$("td>select").css("display", "none");
			
			$("input[name^=result]").click(function() { return false;});
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
			url:"<c:url value='/waterpolmnt/waterinfo/getAirMnt.do'/>",
			data:{obv_num:obv_num},
			dataType:"json",
			success:dataLoad_success,
	        error:function(result){
					alert("해당 데이터를 찾을 수 없습니다!");
			}
		});
	}

	function dataLoad_success(result)
	{
		var obj = result['airData'];


		//지대
		$("#sugye").text(getSurveyPoint(obj.sugye));
		$("#i_sugye").val(getSurveyPoint(obj.sugye));
		
		//호기
		$("#plane").text(obj.plane);
		$("#i_plane").val(obj.plane);


		//비행구간
		$("#fly_section").text(obj.fly_section);
		$("#i_fly_section").val(obj.fly_section);


		//착륙횟수
		$("#land_cnt").text(obj.land_cnt);
		$("#i_land_cnt").val(obj.land_cnt);

		//출발시간
		$("#start_time").text(obj.start_time);
		$("#i_start_time").val(obj.start_time);

		//도착시간
		$("#reach_time").text(obj.reach_time);
		$("#i_reach_time").val(obj.reach_time);

		//비행시간
		$("#flight_time").text(obj.flight_time);
		$("#i_flight_time").val(obj.flight_time);
		
		//기장
		$("#pilot").text(obj.pilot);
		$("#i_pilot").val(obj.pilot);

		//동승자
		$("#rider").text(obj.rider);
		$("#i_rider").val(obj.rider);

		//운항일자
		$("#flight_date").text(obj.flight_date.substring(0,10));
		$("#i_flight_date").val(obj.flight_date.substring(0,10));

		//특이사항
		$("#note").text(obj.note);
		$("#i_note").val(obj.note);

		//기상
		$("#weather").text(obj.weather);
		$("#i_weather").val(obj.weather);

		//일출
		$("#sunrise").text(obj.sunrise);
		$("#i_sunrise").val(obj.sunrise);

		//일몰
		$("#sunset").text(obj.sunset);
		$("#i_sunset").val(obj.sunset);

		//예보
		$("#forecast").text(obj.forecast);
		$("#i_forecast").val(obj.forecast);

		//시간1
		$("#weather_time1").text(obj.weather_time1);
		$("#i_weather_time1").val(obj.weather_time1);

		//시간2
		$("#weather_time2").text(obj.weather_time2);
		$("#i_weather_time2").val(obj.weather_time2);

		//풍향/풍속1
		$("#wind1").text(obj.wind1);
		$("#i_wind1").val(obj.wind1);

		//풍향/풍속2
		$("#wind2").text(obj.wind2);
		$("#i_wind2").val(obj.wind2);

		//시정1
		$("#sight1").text(obj.sight1);
		$("#i_sight1").val(obj.sight1);

		//시정2
		$("#sight2").text(obj.sight2);
		$("#i_sight2").val(obj.sight2);

		//운량/운고1
		$("#cloud1").text(obj.cloud1);
		$("#i_cloud1").val(obj.cloud1);

		//운량/운고2
		$("#cloud2").text(obj.cloud2);
		$("#i_cloud2").val(obj.cloud2);


		//시간3
		$("#weather_time3").text(obj.weather_time3);
		$("#i_weather_time3").val(obj.weather_time3);

		//시간4
		$("#weather_time4").text(obj.weather_time4);
		$("#i_weather_time4").val(obj.weather_time4);

		//풍향/풍속3
		$("#wind3").text(obj.wind3);
		$("#i_wind3").val(obj.wind3);

		//풍향/풍속4
		$("#wind4").text(obj.wind4);
		$("#i_wind4").val(obj.wind4);

		//시정3
		$("#sight3").text(obj.sight3);
		$("#i_sight3").val(obj.sight3);

		//시정4
		$("#sight4").text(obj.sight4);
		$("#i_sight4").val(obj.sight4);

		//운량/운고3
		$("#cloud3").text(obj.cloud3);
		$("#i_cloud3").val(obj.cloud3);

		//운량/운고4
		$("#cloud4").text(obj.cloud4);
		$("#i_cloud4").val(obj.cloud4);

		
		//결과1
		if(obj.result1 == "Y")
			$("#result1").attr("checked", "checked");

		//결과2
		if(obj.result2 == "Y")
			$("#result2").attr("checked", "checked");

		//결과3
		if(obj.result3 == "Y")
			$("#result3").attr("checked", "checked");

		//결과4
		if(obj.result4 == "Y")
			$("#result4").attr("checked", "checked");

		//결과5
		if(obj.result5 == "Y")
			$("#result5").attr("checked", "checked");

		//결과6
		if(obj.result6 == "Y")
			$("#result6").attr("checked", "checked");

		//결과7
		if(obj.result7 == "Y")
			$("#result7").attr("checked", "checked");

		//결과8
		if(obj.result8 == "Y")
			$("#result8").attr("checked", "checked");

		//결과9
		if(obj.result9 == "Y")
			$("#result9").attr("checked", "checked");

		//결과10
		if(obj.result10 == "Y")
			$("#result10").attr("checked", "checked");

		//결과11
		if(obj.result11 == "Y")
			$("#result11").attr("checked", "checked");
		
		
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
		if(airManager || adminFlag)
		{
			if(confirm("삭제하시겠습니까?"))
			{
				$.getJSON("<c:url value='/waterpolmnt/waterinfo/deleteAirMnt.do'/>", {obv_num:obv_num},
					function (data, status){
				     if(status == 'success'){     
				    		alert("데이터가 삭제되었습니다!");
				    		
				    		var param = "pageIndex="+pageIndex+"&obv_num=" + obv_num + "&sugye=" + sugye + "&searchStart=" + searchStart + "&searchEnd=" + searchEnd;
							window.location = "<c:url value='/waterpolmnt/waterinfo/goAirMnt.do'/>?" + param;
				     } else { 
			    	 		alert("삭제중 에러가 발생하였습니다.!");
				        return;
				     }
				});
			}
		}
		else
		{
			alert("해당 항공감시 정보를 삭제할 권한이 없습니다");
		}
	}

	function goList()
	{
		var pIdx = document.listFrm.pageIndex.value;
		
		var param = "obv_num=" + obv_num + "&sugye=" + sugye + "&searchStart=" + searchStart + "&searchEnd=" + searchEnd + "&pageIndex=" + pIdx;
		window.location = "<c:url value='/waterpolmnt/waterinfo/goAirMnt.do'/>?" + param;

		//document.listFrm.action = "<c:url value='/waterpolmnt/waterinfo/goAirMnt.do'/>";

		
		//if(pIdx == "")
			//document.listFrm.pageIndex.value = 1;		
		
		//document.listFrm.submit();
	}
	
	function goModify()
	{
		if(airManager || adminFlag)
		{
			//window.location = "<c:url value='/waterpolmnt/waterinfo/goAirMntView.do'/>?obv_num=" + obv_num + "&mode=modify";.
		
			var param = "mode=modify&pageIndex="+pageIndex+"&obv_num=" + obv_num + "&sugye=" + sugye + "&searchStart=" + searchStart + "&searchEnd=" + searchEnd;
			document.listFrm.action = "<c:url value='/waterpolmnt/waterinfo/goAirMntView.do'/>?" + param;

			$("#i_flight_date").val($("#i_flight_date").val2());

			
			var pIdx = document.listFrm.pageIndex.value;
			
			if(pIdx == "")
				document.listFrm.pageIndex.value = 1;
			
			document.listFrm.submit();
		}
		else
		{
			alert("해당 항공감시 정보를 수정할 권한이 없습니다");
		}
	}


	function validation()
	{
		var flag = true;
		
		$("td > input").each(function(){
			if($(this).val() == "")
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
				var param = "pageIndex=" + pageIndex + "&obv_num=" + obv_num + "&sugye=" + sugye + "&searchStart=" + searchStart + "&searchEnd=" + searchEnd;
	
				$("#i_flight_date").val($("#i_flight_date").val2());
				
				document.airmnt.action = "<c:url value='/waterpolmnt/waterinfo/updateAirMnt.do'/>?" + param;
				document.airmnt.submit();
			}
		}
	}

	function cancelModify()
	{
		var param = "pageIndex=" + pageIndex + "&obv_num=" + obv_num + "&sugye=" + sugye + "&searchStart=" + searchStart + "&searchEnd=" + searchEnd;

		window.location = "<c:url value='/waterpolmnt/waterinfo/goAirMntView.do'/>?" + param;
	}


	function goPrint() {
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 600;
		var winWidth = 900;
		var winLeftPost = (sw - winWidth) / 2;var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-40;
		var height = winHeight-40;

		var mrdFile = "AirObv";
		var param = "/rp ["+obv_num+"]";

		document.report.mrdpath.value = mrdFile;
		document.report.param.value = param;
				
		window.open("", 
				'reportView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);

		document.report.target = "reportView";
		document.report.submit();			
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

						<!-- 운항 및 감시 일지 조회 현황 -->
						<form name="airmnt" method="post" enctype="multipart/form-data">
							<input type="hidden" name="pageIndex" value="${alertMngVO.pageIndex}"/>
							<input type="hidden" name="search_date_start" value="${alertMngVO.search_date_start}"/>
							<input type="hidden" name="search_date_end" value="${alertMngVO.search_date_start}"/>
							
					
						<h4 class="buSqu_tit">운항 및 감시 일지</h4>
						<br/><br/>
					
						<table class="dataTable" style="width:254px">
							<tr>
								<th>지대</th>
								<td>
									<span id="sugye" class='val'></span>
									<select id="i_sugye" name="sugye" style="width:98px">
											<option value="R01">한강</option>
											<option value="R02">낙동강</option>
											<option value="R03">금강</option>
											<option value="R04">영산강</option>
									</select>
								</td>
							</tr>
						</table>
						<br/><br/>
						<table class="dataTable">
							<colgroup>
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
								<col />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">호기</th>
									<th scope="col">비행구간</th>
									<th scope="col">착륙횟수</th>
									<th scope="col">출발시간</th>
									<th scope="col">도착시간</th>
									<th scope="col">비행시간</th>
									<th scope="col">기장</th>
									<th scope="col">동승자</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>
										<span id="plane" class='val'></span>
										<input id="i_plane" type="text" name="plane" maxlength="20" size="10" />
									</td>
									<td>
										<span id="fly_section" class='val'></span>
										<input id="i_fly_section" type="text" name="fly_section" style="width:86px" maxlength="5" />
									</td>
									<td>
										<span id="land_cnt" class='val'></span>
										<input id="i_land_cnt" type="text" name="land_cnt" maxlength="20" size="10" />
									</td>
									<td>
										<span id="start_time" class='val'></span>
										<input id="i_start_time" type="text" name="start_time"  maxlength="20" size="10"/>
									</td>
									<td>
										<span id="reach_time" class='val'></span>
										<input id="i_reach_time" type="text" name="reach_time" maxlength="20" size="10"/>
									</td>
									<td>
										<span id="flight_time" class='val'></span>
										<input id="i_flight_time" type="text" name="flight_time" maxlength="20" size="10"/>
									</td>
									<td>
										<span id="pilot" class='val'></span>
										<input id="i_pilot" type="text" name="pilot" maxlength="20" size="10"/>
									</td>
									<td>
										<span id="rider" class='val'></span>
										<input id="i_rider" type="text" name="rider" maxlength="20" size="10"/>
									</td>
								</tr>
								<tr>
									<th scope="row">운항일자</th>
									<td>
										<span id="flight_date" class='val'></span>
										<input id="i_flight_date" type="text" name="flight_date" readonly="readonly" maxlength="20" size="10"/>
									</td>
									<th scope="row">특이사항</th>
									<td colspan="5">
										<span id="note" class='val'></span>
										<input id="i_note" type="text" name="note"size="95" maxlength="50"/>
									</td>
								</tr>
								<tr>
									<th scope="row">기상</th>
									<td>
										<span id="weather" class='val'></span>
										<select id="i_weather" name="weather" style="width:86px">
												<option>맑음</option>
												<option>구름조금</option>
												<option>흐림</option>
												<option>비</option>
										</select>
									</td>
									<th scope="row">일출</th>
									<td>
										<span id="sunrise" class='val'></span>
										<input id="i_sunrise" type="text" name="sunrise" maxlength="20" size="10"/>
									</td>
									<th scope="row">일몰</th>
									<td>
										<span id="sunset" class='val'></span>
										<input id="i_sunset" type="text" name="sunset" maxlength="20" size="10"/>
									</td>
									<th scope="row">예보</th>
									<td>
										<span id="forecast" class='val'></span>
										<select id="i_forecast" name="forecast" style="width:86px">
											<option>맑음</option> 
											<option>구름조금</option>
											<option>흐림</option>
											<option>비</option>
										</select>
									</td>
								</tr>
							</tbody>
						</table>
						<table class="dataTable spacing1">
							<colgroup>
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="3px" />
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
								<col />
							</colgroup>
							<tr>
								<th scope="col" colspan="9" class="bgStyle">시간대별 기상상태</th>
							</tr>
							<tr>
								<th scope="col">시간</th>
								<th scope="col">풍향/풍속</th>
								<th scope="col">시정</th>
								<th scope="col">운량/운고</th>
								<th scope="col" rowspan="3" class="bgStyle"></th>
								<th scope="col">시간</th>
								<th scope="col">풍향/풍속</th>
								<th scope="col">시정</th>
								<th scope="col">운량/운고</th>
							</tr>
							<tr>
								<td>
									<span id="weather_time1" class='val'></span>
									<input id="i_weather_time1" type="text" name="weather_time1" maxlength="20" size="9"/>
								</td>
								<td>
									<span id="wind1" class='val'></span>
									<input id="i_wind1" type="text" name="wind1" maxlength="20" size="9"/>
								</td>
								<td>
									<span id="sight1" class='val'></span>
									<input id="i_sight1" type="text" name="sight1" maxlength="20" size="9"/>
								</td>
								<td>
									<span id="cloud1" class='val'></span>
									<input id="i_cloud1" type="text" name="cloud1" maxlength="20" size="9"/>
								</td>
								<td>
									<span id="weather_time2" class='val'></span>
									<input id="i_weather_time2" type="text" name="weather_time2" maxlength="20" size="9"/>
								</td>
								<td>
									<span id="wind2" class='val'></span>
									<input id="i_wind2" type="text" name="wind2" maxlength="20" size="9"/>
								</td>
								<td>
									<span id="sight2" class='val'></span>
									<input id="i_sight2" type="text" name="sight2" maxlength="20" size="9"/>
								</td>
								<td>
									<span id="cloud2" class='val'></span>
									<input id="i_cloud2" type="text" name="cloud2" maxlength="20" size="9"/>
								</td>
							</tr>
							<tr>
								<td>
									<span id="weather_time3" class='val'></span>
									<input id="i_weather_time3" type="text" name="weather_time3" maxlength="20" size="9"/>
								</td>
								<td>
									<span id="wind3" class='val'></span>
									<input id="i_wind3" type="text" name="wind3" maxlength="20" size="9"/>
								</td>
								<td >
									<span id="sight3" class='val'></span>
									<input id="i_sight3" type="text" name="sight3" maxlength="20" size="9"/>
								</td>
								<td>
									<span id="cloud3" class='val'></span>
									<input id="i_cloud3" type="text" name="cloud3" maxlength="20" size="9"/>
								</td>
								<td>
									<span id="weather_time4" class='val'></span>
									<input id="i_weather_time4" type="text" name="weather_time4" maxlength="20" size="9"/>
								</td>
								<td>
									<span id="wind4" class='val'></span>
									<input id="i_wind4" type="text" name="wind4" maxlength="20" size="9"/>
								</td>
								<td>
									<span id="sight4" class='val'></span>
									<input id="i_sight4" type="text" name="sight4" maxlength="20" size="9"/>
								</td>
								<td>
									<span id="cloud4" class='val'></span>
									<input id="i_cloud4" type="text" name="cloud4" maxlength="20" size="9"/>
								</td>
							</tr>
						</table>
						<table class="dataTable spacing2">
							<colgroup>
								<col width="140px"/>
								<col />
								<col width="90px" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col" colspan="3" class="bgStyle">환경 항공 감시 결과</th>
								</tr>
								<tr>
									<th scope="col">구   분</th>
									<th scope="col">확인사항</th>
									<th scope="col">이상유무</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td rowspan="4">하천수질<br/>오    염</td>
									<td class='txtP'><span>○ 유류(기름띠) 및 공장 축산폐수 무단방류행위</span></td>
									<td><input id="result1" name="result1" type="checkbox" class="inputCheck" value="Y"/></td>
								</tr>
								<tr>
									<td class='txtP'><span>○ 물고기폐사, 물색깔 변화(녹조 또는 부영양화현상 등)</span></td>
									<td>
										<input id="result2" name="result2" type="checkbox" class="inputCheck" value="Y"/>
									</td>
								</tr>
								<tr>
									<td class='txtP'><span>○ 하천에서의 세차, 골재채취, 공사등으로 인한 부유물질 확산여부</span></td>
									<td><input id="result3" name="result3" type="checkbox" class="inputCheck" value="Y"/></td>
								</tr>
								<tr>
									<td class='txtP'><span>○ 육상의 쓰레기 하천유입, 행락지 낙시터 등 쓰레기투기 여부</span></td>
									<td><input id="result4" name="result4" type="checkbox" class="inputCheck" value="Y"/></td>
								</tr>
								<tr>
									<td rowspan="6">하천주변<br/>환    경</td>
									<td class='txtP'><span>○ 하천변 임야에서 건설폐기물, 산업폐기물 등 투기행위</span></td>
									<td><input id="result5" name="result5" type="checkbox" class="inputCheck" value="Y"/></td>
								</tr>
								<tr>
									<td class='txtP'><span>○ 골프장, 채석장 등에서의 토사유출</span></td>
									<td><input id="result6" name="result6" type="checkbox" class="inputCheck" value="Y"/></td>
								</tr>
								<tr>
									<td class='txtP'><span>○ 하천변에서의 폐선박, 폐차 등 방치행위</span></td>
									<td><input id="result7" name="result7" type="checkbox" class="inputCheck" value="Y"/></td>
								</tr>
								<tr>
									<td class='txtP'><span>○ 타이어, 폐비닐 등 불법소각행위</span></td>
									<td><input id="result8" name="result8" type="checkbox" class="inputCheck" value="Y"/></td>
								</tr>
								<tr>
									<td class='txtP'><span>○ 산불발생, 산림훼손 등 자연환경 훼손 행위</span></td>
									<td><input id="result9" name="result9" type="checkbox" class="inputCheck" value="Y"/></td>
								</tr>
								<tr>
									<td class='txtP'><span>○ 어류불법포획 등 하천생태계 파괴행위 </span></td>
									<td><input id="result10" name="result10" type="checkbox" class="inputCheck" value="Y"/></td>
								</tr>
								<tr>
									<td>기    타</td>
									<td class='txtP'><span>○ 하천관리실태 및 철새도래 관찰 등</span></td>
									<td><input id="result11" name="result11" type="checkbox" class="inputCheck" value="Y"/></td>
								</tr>
							</tbody>
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
										<li><a href="#">오염상태.jpg</a></li>
									</ul>
								</td>
							</tr>
						</table>
						 -->
						 
						 <!-- 확인필요사항 -->
						<div id="btArea">
							<input type="button" id="btnPrint" name="btnPrint" value="인쇄" class="btn btn_basic" onclick="javascript:goPrint();" />
							<input type="button" id="btnModify" name="btnModify" value="수정" class="btn btn_basic" onclick="javascript:goModify();" />
							<input type="button" id="btnDelete" name="btnDelete" value="삭제" class="btn btn_basic" onclick="javascript:goDelete();" />
							<input type="button" id="btnList" name="btnList" value="목록" class="btn btn_basic" onclick="javascript:goList();" />
						</div>
					</form>
					</div>
					<!--tab Contnet End-->
				</div>
				<!-- Content End-->
			</div>
		</div>
		<!-- Body End-->
	
		<form:form commandName="alertMngVO" name="listFrm" method="post">		
			<input type="hidden" name="pageIndex" value="${param.pageIndex}"/>
			<input type="hidden" name="search_date_start" value="${param.searchStart}"/>
			<input type="hidden" name="search_date_end" value="${param.searchEnd}"/>
			<input type="hidden" name="sugye" value="${param.sugye}"/>
		</form:form>
	
		<form name="report" method="post" action="<c:url value='/common/rdView.do'/>">
			<input type="hidden" name="mrdpath" />
			<input type="hidden" name="param" />
		</form>

		<!-- Footer Start-->
		<div id="footer">
			<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
		<!-- Footer End-->
	</div>
</body>
</html>