<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page import="daewooInfo.common.security.util.TmsUserDetailsHelper" %>
<%@ page import="daewooInfo.common.login.bean.LoginVO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />
	
	<script src="<c:url value='/js/JQuery/jquery-1.3.2.min.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js" type="text/javascript'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>
	
	<link rel="stylesheet" type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>"/>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.datepicker.js'/>"></script>
	
	<script type='text/javascript'>
	
	var riverId;
	
	$(function(){
		riverId = '${param.river_id}';
		
		var riverName = "";
		switch(riverId)
		{
		case "R01" :
			riverName = "한강";
			break;
		case "R02" :
			riverName = "낙동강";
			break;
		case "R03" :
			riverName = "금강";
			break;
		case "R04" :
			riverName = "영산강";
			break;
		}
		
		$("#spanRiver").text(riverName);
		
		$("#weather_kind").change(function(){getWeatherInfo();});
		
		$("#sys").change(function(){getWeatherInfo();});
		
		getWeatherInfo();
	});
	
	function getWeatherInfo()
	{
		var sys = $("#sys").val();
		var weather_kind = $("#weather_kind").val();
		
		$("#dataList").html("");
		$("#dataList").html("<tr><td colspan='8'>데이터를 불러오는 중 입니다...</td></tr>");
		
		$.ajax({
			type:"post",
			url:"<c:url value='/weather/getAreaCode.do?'/>",
			cache:false,
			data:{river_id:riverId, sys_kind:sys, weather_kind:weather_kind},
			dataType:"json",
			success:function(result) { weatherInfo_Load(result.weather); },
			error:function() { $("#dataList").html("<tr><td colspan='8'>서버 접속에 실패하였습니다!</td></tr>"); }
		});
	}
	
	function weatherInfo_Load(data)
	{
		var tot = data.length;
		
		$("#dataList").html("");
		
		if( tot <= "0" ){
				$("#dataList").html("<tr><td colspan='8'>조회 결과가 없습니다</td></tr>");
		}else{
			
				for(var idx = 0 ; idx < data.length ; idx++)
				{
					var obj = data[idx];
					
					var item;
					
					if(obj == null)
					{
						continue;
					}
					
					var anDate = obj.announce_time;
					
					var year = anDate.substring(0,4);
					var month = anDate.substring(4,6);
					var day = anDate.substring(6,8);
					var hour = anDate.substring(8,10);
					var minute = anDate.substring(10, 12);
					
					if(obj.current_weather == "")
					{
						obj.current_weather = obj.weather_sky;
					}
					
// 					item = "<tr style='cursor:pointer' onclick='goWeatherList()'>"
// 					2014-10-30 kys 수정
					item = "<tr>"
							+"<td>"+obj.regionName+"</td>"
							+"<td>"+ obj.branch_name + "</td>"
							+"<td>"+ year +"-" + month + "-" + day + " " + hour + ":" + minute +"</td>"
							+"<td class='num'><span>"+obj.temp+" ℃</span></td>"
							+"<td><img id='weather" + idx + "' align='middle'/></td><td>" +obj.current_weather+"</td>"
							+"<td>"+obj.wind_dir+"</td>"
							+"<td>"+obj.rainfall_probability+" %</td>"
							+"</tr>";
							//+"<td><a href=\"#\" onclick=\"smsPopup('"+obj.factCode+"','"+obj.branch_name+"','"+obj.current_weather+"')\"><img width=18 height=18 src=\"/images/common/sms_ico.gif\" alt=\"SMS 발송\"></td>"
					$("#dataList").append(item);
					
					$("#weather" + idx).attr("src", getWeatherImgSrc(obj.current_weather));
				}
		}
		
		$("#dataList tr:odd").addClass("add");
	}
	
	function goWeatherList()
	{
		window.open("<c:url value='/waterpolmnt/waterinfo/goWeatherInfo.do'/>?clickMenu=232&riverDiv="+riverId);
	}
	
	function getWeatherImgSrc(code)
	{
		var src = "<c:url value='/images/content/'/>";
			switch(code)
			{
			case "맑음" : 
				src += "NB01.png";
				break;
			case "구름조금" :
				src += "NB02.png";
				break;
			case "소나기 끝":
			case "구름많음" :
				src += "NB03.png";
				break;
			case "소낙눈 끝":
			case "진눈개비끝" :
			case "눈 끝남" :
			case "비 끝남" : 
			case "흐림" :
				src += "NB04.png";
				break;
			case "소나기" :
				src += "NB05.png";
				break;
			case "뇌우끝,비" :
			case "약한비단속" :
			case "약한비계속" :
			case "보통비계속" :
			case "보통비단속" :
			case "구름조금 비" :
			case "구름많음 비" :
			case "약한이슬비":
			case "보통이슬비":
			case "보통소나기":
			case "약한소나기":
			case "이슬비 끝":
			case "흐림 비":
			case "비" :
				src += "NB08.png";
				break;
			case "약한눈단속" :
			case "약한눈계속" :
			case "보통눈계속" :
			case "보통눈단속" :
			case "구름조금 눈":
			case "구름많음 눈":
			case "흐림 눈":
			case "눈" :
				src += "NB11.png";
				break;
			case "약진눈개비":
			case "강진눈개비":
			case "구름조금 비/눈":
			case "구름많음 비/눈":
			case "흐림 비/눈":
			case "비 또는 눈" : 
				src += "NB12.png";
				break;
			case "눈 또는 비" : 
				src += "NB13.png";
				break;
			case "뇌우" :
			case "천둥번개" : 
				src += "NB14.png";
				break;
			case "안개강해짐" :
			case "안개변화무" :
			case "안개 끝" :
			case "안개" :
				src += "NB15.png";
				break;
			case "박무" :
				src += "NB17.png";
				break;
			case "황사" :
				src += "NB16.png";
				break;
			case "안개엷어짐":
			case "연무" :
				src += "NB18.png";
				break;
			default :
				src += "NB01_N.png";
				break;
				}
				
			return src;
	}
	
	// SMS 팝업
	function smsPopup(factCode, factName, weatherName) {
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 390;
		var winWidth = 1000;
		var winLeftPost = (sw - winWidth) / 2;var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-40;
		var height = winHeight-40;
		
		document.smsPopupForm.sugye.value = riverId;
		document.smsPopupForm.factCode.value = factCode;
		document.smsPopupForm.factName.value = factName;
		document.smsPopupForm.weatherName.value = weatherName;
		
		window.open('', 
				'smsSendPopup','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
		document.smsPopupForm.target = "smsSendPopup";
		document.smsPopupForm.submit();
	}
	
	</script>
</head>
<body class="subPop"><!-- 추가 및 수정 -->
	<div class="headerWrap">
		<div class="headerBg_r">
			<div class="header">
				<h1>기상데이터 상세정보</h1>
			</div>
		</div>
	</div>
	<div class="contentWrap">
		<div class="contentBg_r">
			<div class="contentBox">
				<div class="contentPad"><!-- //추가 및 수정 -->
					<div class="totalmntPop1" style="padding-top:20px">
							<div class="content">
								<ul class="selectList">
									<li><span class="buArrow_tit">시스템</span> 
										<select id="sys">
											<option value="all">전체</option>
<!-- 											<option value="T">탁수모니터링</option> -->
											<option value="U">이동형측정기기</option>
											<option value="A">국가수질자동측정망</option>
										</select>
									</li>
									<li>&nbsp;&nbsp;<span class="buArrow_tit">구분</span> 
										<select id="weather_kind">
											<option value="C">현재 기상 상태</option>
											<option value="T">내일 오전 예보</option>
										</select>
									</li>
								</ul>
								<table class="dataTable">
									<colgroup>
										<col width="80px" />
										<col width="90px" />
										<col width="140px" />
										<col width="70px" />
										<col width="80px"/>
										<col width="100px" />
										<col width="70px" />
										<!--<col width="60px" />-->
										<col width="" />
									</colgroup>
									<thead id="dataHeader">
										<tr>
											<th scope="col">지역</th>
											<th scope="col">측정소</th>
											<th scope="col">발표시각</th>
											<th scope="col">기온</th>
											<th scope="col" colspan="2">날씨</th>
											<th scope="col">풍향</th>
											<th scope="col">강수확률</th>
											<!--<th scope="col">SMS</th>-->
										</tr>
									</thead>
								</table>
							<div class="overBox" style="border-top:solid 0px white">
								<table class="dataTable">
									<colgroup>
										<col width="80px" />
										<col width="90px" />
										<col width="140px" />
										<col width="70px" />
										<col width="80px"/>
										<col width="100px" />
										<col width="70px" />
										<!--<col width="60px" />-->
										<col width="" />
									</colgroup>
									<tbody id="dataList">
										<tr>
											<td colspan="8">데이터를 불러오는 중 입니다...</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div><!-- 추가 및 수정 -->
			</div>
		</div>
	</div>
	<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div><!-- //추가 및 수정 -->
	<form name="smsPopupForm" method="post" action="/cmmn/alertSmsSend.do">
	<input type="hidden" name="sugye"/>
	<input type="hidden" name="factCode"/>
	<input type="hidden" name="factName"/>
	<input type="hidden" name="weatherName"/>
	</form>
</body>
</html>

