<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : waterPollutionList.jsp
	 * Description : 수질오염접수목록 화면->사고(수동)관리
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2013.04.30	YIK			최초 생성
	 * 2013.10.31	lkh			리뉴얼
	 * 2014.10.27 mypark      페이징처리
	 * 
	 * author YIK
	 * since 2013.04.30
	 *	
	 * Copyright (C) 2013 by YIK  All right reserved.
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
<!-- 실서버-->
<!-- <SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=3728760A-A99F-39F6-96C8-74746BA4A738"></SCRIPT>	 -->
<!--  ????  -->
<!-- <SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=C4246B58-A669-3643-A7FD-F545A61ECE20"></SCRIPT>    -->
<!-- 210.99.81.159:9090-->
<!-- <SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=4EA77A23-29BC-37C9-A4EE-D3BCABCD9846"></SCRIPT> -->
<SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=C4246B58-A669-3643-A7FD-F545A61ECE20"></SCRIPT>	
<script language="javascript" type="text/javascript" src="/js/mobile/Vworld.js"></script>
<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />
<link rel="stylesheet" type="text/css" href="<c:url value='/gis/css/gis_style.css'/>"/>
<script type="text/javascript" charset="utf-8">
$(function(){
	vworldInit("map_canvas");
	goTime();
});

function map_start_function(){
	<c:forEach items="${list }" var="item">
	point = GoogleToVworld('${item.latiude}', '${item.longituded}');
	
	markerkind = "";
	markerStepName = "";
	
	markerText = "<div style='font-family:none;'>";
	
	switch("${item.wpKind}"){
		case "PA" : markerkind = "유류유출"; break;
		case "PB" : markerkind = "물고기폐사"; break; 
		case "PC" : markerkind = "화학물질"; break; 
		case "PD" : markerkind = "기타"; break;
		case "PT" : markerkind = "테스트"; break; 
	}
	
	switch("${item.wpsStep}"){
		case "STA" : markerStepName = "신고"; break;
		case "RCV" : markerStepName = "접수"; break; 
		case "ING" : markerStepName = "수습중"; break; 
		case "END" : markerStepName = "조치완료"; break;
	}
	
	markerText += "<span style='font-size:15px;font-weight:bold;'>"+ markerkind + "</span>";
	markerText += "<div style='height:1px;border-bottom:1px solid #333333;'></div>";
	markerText += "<div style='margin-top:5px;'>사고유형 : " + markerkind + "</div>";
	markerText += "<div>신고일자: ${item.reportDate}</div>";
	markerText += "<div>접수일자 : ${item.receiveDate}</div>";
	markerText += "<div>수계 : ${item.riverDivName}</div>";
	markerText += "<div>주소 : ${item.address}</div>";
	markerText += "<div>처리상태 : " + markerStepName + "</div>";
	
	markerText += "</div>";
	createMarkerNotCenter(point.x,point.y,markerText);
	</c:forEach>
	map.setCenterAndZoom(map.getCenterXY().cx, map.getCenterXY().cy, 8);
	
	$(".olAlphaImg").on("mouseover",function(){
		$(".olPopup").css("display","none");
		$(this).trigger('click');
	});
};

function dataLoad(pageNo){
	showLoading();
	
	var divcsspx = $("#search_result").css("bottom").replace("px","");
	if(Number(divcsspx) < 0) $('#resultToggle').trigger('click');
	var startDate = $("#startDate").val().split('/').join('');
	var endDate = $("#endDate").val().split('/').join('');
	var searchRiverDiv = $("#searchRiverDiv").val();
	var searchWpKind = $("#searchWpKind").val();
	var searchWpsStep = $("#searchWpsStep").val();
	var searchSupportKind = $("#searchSupportKind").val();
	
	if (pageNo == null) pageNo = 1;
	
	$.ajax({
		type:"post",
		url:"<c:url value='/waterpollution/getWaterPollutionList.do'/>",
		data:{
				startDate:startDate,
				endDate:endDate,
				searchRiverDiv:searchRiverDiv,
				searchWpKind:searchWpKind,
				searchWpsStep:searchWpsStep,
				searchSupportKind:searchSupportKind,
				pageIndex:pageNo,
				pageUnit:"10000"
		},
		dataType:"json",
		success:function(result){
			//console.log("결과 값 확인 : ",result);
			
			var tot = result['list'].length;
			var pageInfo = result['paginationInfo'];
			var html = "";
			
			if( tot <= 0 ){
				html += "<tr><td colspan='7'>조회 결과가 없습니다.</td></tr>";
			} else {  
				for(var i=0; i< tot; i++) {
					var obj = result['list'][i];
					
					if(obj.riverDiv == 'R01'){
						obj.riverDivName = '한강';
					}else if(obj.riverDiv == 'R02'){
						obj.riverDivName = '낙동강';
					}else if(obj.riverDiv == 'R03'){
						obj.riverDivName = '금강';
					}else if(obj.riverDiv == 'R04'){
						obj.riverDivName = '영산강';
					}
					
					if(obj.wpKind == 'PA'){
						obj.wpKindName = '유류유출';
					}else if(obj.wpKind == 'PB'){
						obj.wpKindName = '물고기폐사';
					}else if(obj.wpKind == 'PC'){
						obj.wpKindName = '화학물질';
					}else if(obj.wpKind == 'PD'){
						obj.wpKindName = '기타';
					}else if(obj.wpKind == 'PT'){
						obj.wpKindName = '테스트';
					}
					
					if(obj.wpsStep == 'STA'){
						obj.wpsStepName = '신고';
					}else if(obj.wpsStep == 'RCV'){
						obj.wpsStepName = '접수';
					}else if(obj.wpsStep == 'ING'){
						obj.wpsStepName = '수습중';
					}else if(obj.wpsStep == 'END'){
						obj.wpsStepName = '조치완료';
					}
					
					if(obj.supportKind == 'Y'){
						obj.supportKindName = '지원';
					}else if(obj.supportKind == 'N'){
						obj.supportKindName = '접수';
					}else{
						obj.supportKindName = '미정';
					}
					
					var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
					obj.no = no;
					trclass = "";
					if(i % 2 == 1) trclass = "class=\"even\"";
					
					html +="<tr "+trclass+">";
					html += "<td align='center'><a onclick=\"fnGoDetail('"+obj.latiude+"','"+obj.longituded+"'); return false;\" href=\"#\">"+ obj.no +"</a></td>";
					html += "<td align='center'><a onclick=\"fnGoDetail('"+obj.latiude+"','"+obj.longituded+"'); return false;\" href=\"#\">"+ obj.receiveDate +"</a></td>";
					html += "<td align='center'><a onclick=\"fnGoDetail('"+obj.latiude+"','"+obj.longituded+"'); return false;\" href=\"#\">"+ obj.riverDivName +"</a></td>";
					html += "<td align='center'><a onclick=\"fnGoDetail('"+obj.latiude+"','"+obj.longituded+"'); return false;\" href=\"#\">"+ obj.wpKindName +"</a></td>";
					html += "<td align='center'><a onclick=\"fnGoDetail('"+obj.latiude+"','"+obj.longituded+"'); return false;\" href=\"#\">"+ obj.wpContent +"</a></td>";
					html += "<td align='center'><a onclick=\"fnGoDetail('"+obj.latiude+"','"+obj.longituded+"'); return false;\" href=\"#\">"+ obj.wpsStepName +"</a></td>";
					html += "<td align='center'><a onclick=\"fnGoDetail('"+obj.latiude+"','"+obj.longituded+"'); return false;\" href=\"#\">"+ obj.supportKindName +"</a></td>";
					html +="</tr>";
				}
			}
			
			// 페이징 정보
			var pageStr = makePaginationInfo(result['paginationInfo']);
			$("#pagination").empty();
			$("#pagination").append(pageStr);
			
			// 총건수 표시
			var totCnt = result['totCnt'];
			
			$("#p_total_cnt").html("[총 " + totCnt +"건]");
			
			closeLoading();
			$("#dataList").html(html);
		},
		error:function(result){
			var html = "";
			html += "<tr><td colspan='7'>서버 접속에 실패하였습니다.</td></tr>";
			$("#dataList").html(html);
			closeLoading();
		}
	});
}

function fnGoDetail(X,Y){
	var point = GoogleToVworld(X,Y);
	setCenterAndZoom(point.x,point.y);
}
function goTime(){
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
		buttonText: '조회일자'
	});
	
	$("#endDate").datepicker({
		buttonText: '조회일자'
	});
	
	var today = new Date(); 
	today = today.getFullYear()+"/"+ addzero(today.getMonth()+1) + "/" + addzero(today.getDate());
	
	var today2 = new Date(); 
	today2 = today2.getFullYear()+"/"+ addzero(today2.getMonth()+1) + "/01" ;
	
	//var yday = new Date(Date.parse(today) - 1 * 1000 * 60 * 60 * 24);
	//yday = yday.getFullYear()+ addzero(yday.getMonth()+1) + addzero(yday.getDate());
	
	//날짜 초기값 Setting	
	$("#startDate").val(today2);
	$("#endDate").val(today);
}

function addzero(n) {
	return n < 10 ? "0" + n : n + "";
}


function commonWork() {
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
	
	if(endt.value != '' && stdt.value > endt.value) {
		alert("조회 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
		stdt.value = "";
		endt.value = "";
		stdt.focus();
	}
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
					<div class="tab_container" style="position:relative ;overflow: hidden;">
						<div style="position: absolute;z-index: 101;top:605px;left:-150px;">
							<div id="search_result" >
								<div id="resultToggle">
									<img src="/images/renewal2/toggle_bin.png" alt="닫기" />
								</div>
								<div id="result">
									<div id="resultDiv" style="overflow-x: scroll; overflow-y: scroll; width: 703px; height: 205px;">
										<table>
											<col width='45' />
											<col width='90' />
											<col width='70' />
											<col width='100' />
											<col width='*' />
											<col width='80' />
											<col width='80' />
											<thead>
												<tr>
													<th scope='col'>No</th>
													<th scope='col'>일시</th>
													<th scope='col'>수계</th>
													<th scope='col'>유형</th>
													<th scope='col'>내용</th>
													<th scope='col'>단계</th>
													<th scope='col'>지원</th>
												</tr>
											</thead>
											<tbody id="dataList">
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						<div style="position: absolute;z-index: 101;">
							<div id="leftSearchBx2" style="left: 0px;">
								<div id="leftSearch">
									<div class="list-wrap2">
										<div id="siteCase" class="tabCase">
											<div id="search">
												<div id="search_terms">
													<ul>
														<li>
															<span class="point">수계</span>
															<select id="searchRiverDiv"  style="width: 110px">
																<option value="">전체</option>
																<option value="R01">한강</option>
																<option value="R02">낙동강</option>
																<option value="R03">금강</option>
																<option value="R04">영산강</option>
															</select>
														</li>
														<li>
															<span class="point">유형</span>
															<select id="searchWpKind" style="width: 110px">
																<option value="">전체</option>
																<option value="PA">유류유출</option>
																<option value="PB">물고기폐사</option>
																<option value="PC">화학물질</option>
																<option value="PD">기타</option>
															</select>
														</li>
														<li>
															<span class="point">시작기간</span>
															<input type="text" id="startDate" name="startDate" size="13" onchange="commonWork()" alt="조회시작일"/>
														</li>
														<li>
															<span class="point">종료기간</span>
															<input type="text" id="endDate" name="endDate" size="13" onchange="commonWork()" alt="조회종료일"/>
														</li>
														<li>
															<span class="point">단계</span>
															<select id="searchWpsStep" style="width: 110px">
																<option value="">전체</option>
																<option value="STA">신고</option>
																<option value="RCV">접수</option>
																<option value="ING">수습중</option>
																<option value="END">조치완료</option>
															</select>
														</li>
														<li>
															<span class="point">접수/지원</span>
															<select id="searchSupportKind" style="width: 110px">
																<option value="">전체</option>
																<option value="Y">지원</option>
																<option value="N">접수</option>
															</select>
														</li>
													</ul>
													<div style="text-aling: right; padding-top: 10px;">
														<input type="button" id="tmSearBtn" name="tmSearBtn" value="조회" class="btn btn_search" onclick="javascript:dataLoad();" style="float: right;" />
													</div>
												</div>
												<div id="searchToggleTm">
													<img src="/gis/images/toggle_in.png" alt="닫기" />
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div id="ipusnmap" style="height:600px;z-index: 100"> 
							<div id="map_canvas" style="height:100%;"> 
							</div> 
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
</html>