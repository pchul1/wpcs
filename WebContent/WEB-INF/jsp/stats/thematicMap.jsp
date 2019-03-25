<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.Calendar" %>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
/**
 * Class Name : thematicMap.jsp
 * Description : 주제도 화면
 * Modification Information
 * 
 * 수정일			수정자			수정내용
 * -------		--------	---------------------------
 * 2014.10.31	yrkim			최초생성
 * 
 * author yrkim
 * since 2014.10.31
 * 
 * Copyright (C) 2014 by yrkim All right reserved.
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

<link rel="stylesheet" type="text/css" href="<c:url value='/gis/css/gis_style.css'/>"/>
<link rel="stylesheet" href="http://js.arcgis.com/3.8/js/dojo/dijit/themes/claro/claro.css">
<link rel="stylesheet" href="http://js.arcgis.com/3.8/js/esri/css/esri.css">
<!-- <script type="text/javascript" src="/gis/gis/jsapi_vsdoc10_v36.js"></script> -->

<!-- <script src="http://js.arcgis.com/3.8/"></script> -->

<script src="/gis/js/xml2json.js"></script>
<script src="/gis/js/common.js"></script>
<script src="/gis/js/new_kecoMap.js"></script>
<script src="/gis/js/thematicMap.js"></script>


<script type="text/javascript" src="/gis/new_js/lib/proj4.js" ></script>
<script type="text/javascript" src="/gis/new_js/lib/mapEventBus.js" ></script>
<!-- <script type="text/javascript" src="/gis/new_js/lib/ol/ol.js"></script> -->
<script type="text/javascript" src="http://tsauerwein.github.io/ol3/mapbox-gl-js/build/ol.js"></script>
 
<script type="text/javascript" src="/gis/new_js/lib/jsts/jsts.min.js"></script>

<script type="text/javascript" src="/gis/new_js/mapService.js"></script>
<script type="text/javascript" src="/gis/new_js/lib/vworldLayer.js"></script>
<script type="text/javascript" src="/gis/new_js/lib/coreMap.js"></script>
<script type="text/javascript" src="/gis/new_js/lib/jquery-ui.js"></script>

<script type="text/javascript">
	//관리자 외에 등록 된 측정소가 없을 경우 메인으로 이동
	if(user_roleCode != 'ROLE_ADMIN'){
		if(user_u_cnt == 0){
// 			alert('권한이 없습니다. 측정소를 등록해주세요.');
// 			window.location = "<c:url value='/main.do'/>";
		}
	}
	
//<![CDATA[       
	$(function() {
		
		_CoreMap.init('map',{
			satellite: true
		});
		
		//user 측정소권한에 따른 수계 고정
		if(user_roleCode == 'ROLE_ADMIN'){
			selectedSugyeInMemberId(user_riverid, 'searchSugye');
		}else{
			selectedSugyeInMemberIdNew(id, 'U', 'searchSugye');
		}
		
		//시간셋팅
 		setTime();

		dataLoad_weatherWarn();
		
		dataLoad_bermSettingInfo();
		
		dataSetSugye();
		
	});
	
	function adjustGongku(){
		
	}
	
	
	function dataSetSugye(){
		var memFactCode = "${member.factCode}";
		var memRiverDiv = "${member.riverId}";
		selectedSugyeInMemberId(user_riverid , 'searchSugye');
		if(memFactCode != null && memFactCode != ""){
			$("#searchSugye > option[value="+memRiverDiv+"]").attr("selected", "true");
			$("#searchSugye").attr("disabled", "disabled");
		}
	}

	function setTime() {
		//============================= 달 력 Start ======================================
		/* shows the loading div every time we have an Ajax call */
		$.datepicker.setDefaults({
			monthNames : [ '년 1월', '년 2월', '년 3월', '년 4월', '년 5월', '년 6월',
					'년 7월', '년 8월', '년 9월', '년 10월', '년 11월', '년 12월' ],
			dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
			showMonthAfterYear : true,
			dateFormat : 'yy/mm/dd',
			showOn : 'both',
			buttonImage : "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly : true
		});

		$("#searchDays").datepicker({
			buttonText : '날짜'
		});

		var today = new Date();
		today = today.getFullYear() + "/" + addzero(today.getMonth() + 1) + "/"
				+ addzero(today.getDate());

		function addzero(n) {
			return n < 10 ? "0" + n : n + "";
		}

// 		for ( var i = 0; i < 24; i++) {
// 			var temp = addzero(i);
// 			var item = "<option value='"+temp+"'>" + temp + "</option>";
// 			$("#searchTime").append(item);
// 		}

		$("#searchDays").val(today);

// 		var today2 = new Date();

// 		var yArr = new Array();
// 		for ( var i = 6; i >= 0; i--) {
// 			var tmp = Number(today2.getFullYear()) - i;
// 			yArr.push({
// 				CAPTION : tmp + "년",
// 				VALUE : tmp
// 			});
// 		}
// 		$('#searchCompareYear').loadSelect(yArr);
// 		$('#searchCompareYear').attr('value', today2.getFullYear());

	}

	/*******************************************************
	 *  기상특보
	 *******************************************************/
	var warnIdx = 1;
	var weatherWarnList;
	var weatherWarnInfo;

	function dataLoad_weatherWarn() {
		$.ajax({
			type : "post",
			url : "<c:url value='/weather/getWeatherWarning.do'/>",
			dataType : "json",
			success : dataLoad_weatherWarn_success,
			error : function(result) {
				$("#weather_warn").html("기상청 접속 실패!");
			}
		});
	}
	
	

	function dataLoad_weatherWarn_success(result) {
		if (result != null) {
			var obj = result["warningData"];

			if (obj != null && obj.warning_content != 'o 없 음'
					&& obj.warning_content != '') {
				weatherWarnList = obj.warning_content.split('o ');

				var length = weatherWarnList.length;

				///*
				//idx 1부터 [ 0번째는 비어있음 ]
				for ( var idx = 1; idx < length; idx++) {
					//1. xx주의보 : [경보지역]에서 경보지역 표시 안함
					if (weatherWarnList[idx] != "")
						weatherWarnList[idx] = weatherWarnList[idx].split(':')[0];
				}
				//*/

				weatherWarn_roll();
			} else {
				$("#weather_warn").text("현재 발효중인 기상특보 없음");
				//$("#weather_warn").attr("onclick","");
			}
		}
	}

	function weatherWarn_roll() {
		if (weatherWarnList.length > 2) {
			weatherWarn_show(warnIdx);

			warnIdx++;
			if (warnIdx > weatherWarnList.length - 1)
				warnIdx = 1;

			setTimeout("weatherWarn_roll()", (1000 * 10));
		} else {
			weatherWarn_show(1);
		}
	}

	function weatherWarn_show(idx) {
		$("#weather_warn")
				.fadeOut(
						"fast",
						function() {
							$("#weather_warn").text(
									(idx) + ". " + weatherWarnList[idx] + " ["
											+ idx + "/"
											+ (weatherWarnList.length - 1)
											+ "]");
							$("#weather_warn").fadeIn("fast");
						});
	}

	function weatherWarnPopup() {
		var sw = screen.width;
		var sh = screen.height;
		var winHeight = 427;
		var winWidth = 687;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;

		window
				.open(
						"<c:url value='/waterpolmnt/situationctl/goWeatherWarn.do?'/>",//
						'WeatherWarn',
						'width='
								+ winWidth
								+ ',height='
								+ winHeight
								+ ',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='
								+ winLeftPost + ',top=' + winTopPost);
	}

	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("layerBermModify");
	}

	function fnBermSet() {
		getBermSettingInfo();

		layerPopOpen("layerBermModify");
	}

	function noData() {

	}
	
	//사용자별 범례정보 가져오기
	function dataLoad_bermSettingInfo() {
		showLoading();
		var item = $("#searchItem").val();

		$.ajax({
			async : false,
			type : "post",
			url : "<c:url value='/stats/getBermSettingInfo.do'/>",
			data : {
				item : item
			},
			dataType : "json",
			success : function(result) {
				var tot = result['getBermSettingInfo'].length;
				
				if (tot <= 0) {
					$("#bermList").html("범례설정을<br/>해주세요.");
				} else {
					var obj = result['getBermSettingInfo'][0];
					var bermData;
					
					bermData = "<ul>"
					if(obj.berm6=='Y'){
						bermData += "<li><span class='point6'></span>&nbsp;~"+obj.berm6Set+"</li>";
					}
					if(obj.berm5=='Y'){
						bermData += "<li><span class='point5'></span>&nbsp;~"+obj.berm5Set+"</li>";
					}
					if(obj.berm4=='Y'){
						bermData += "<li><span class='point4'></span>&nbsp;~"+obj.berm4Set+"</li>";
					}
					if(obj.berm3=='Y'){
						bermData += "<li><span class='point3'></span>&nbsp;~"+obj.berm3Set+"</li>";
					}
					if(obj.berm2=='Y'){
						bermData += "<li><span class='point2'></span>&nbsp;~"+obj.berm2Set+"</li>";
					}
					if(obj.berm1=='Y'){
						bermData += "<li><span class='point1'></span>&nbsp;~"+obj.berm1Set+"</li>";
					}
					bermData += "</ul>";
					
					$("#bermList").html(bermData);
				}
				closeLoading();
				
				$("#item > option[value="+item+"]").attr("selected", "ture");
			},
			error : function(result) {
				var oraErrorCode = "";
				if (result.responseText != null) {
					var matchedValue = result.responseText
							.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				closeLoading();
			}
		});
	}
	
	//사용자별 범례정보 가져오기
	function getBermSettingInfo() {
		showLoading();
		var item = $("#searchItem").val();

		$.ajax({
			async : false,
			type : "post",
			url : "<c:url value='/stats/getBermSettingInfo.do'/>",
			data : {
				item : item
			},
			dataType : "json",
			success : function(result) {
				var tot = result['getBermSettingInfo'].length;
				if (tot <= 0) {
					$("#checkBerm6").attr("checked", false);
					$("#checkBerm5").attr("checked", false);
					$("#checkBerm4").attr("checked", false);
					$("#checkBerm3").attr("checked", false);
					$("#checkBerm2").attr("checked", false);
					$("#checkBerm1").attr("checked", false);

					$("#berm6Set").val("");
					$("#berm5Set").val("");
					$("#berm4Set").val("");
					$("#berm3Set").val("");
					$("#berm2Set").val("");
					$("#berm1Set").val("");

					$("#checkItemR").attr("checked", false);
					$("#checkItemH").attr("checked", false);
					$("#checkItemT").attr("checked", false);
					$("#checkItemWs").attr("checked", false);
					$("#checkItemWd").attr("checked", false);
				} else {
					var obj = result['getBermSettingInfo'][0];
					if (obj.berm6 == "Y") {
						$("#checkBerm6").attr("checked", true);
					} else {
						$("#checkBerm6").attr("checked", false);
					}

					if (obj.berm5 == "Y") {
						$("#checkBerm5").attr("checked", true);
					} else {
						$("#checkBerm5").attr("checked", false);
					}

					if (obj.berm4 == "Y") {
						$("#checkBerm4").attr("checked", true);
					} else {
						$("#checkBerm4").attr("checked", false);
					}

					if (obj.berm3 == "Y") {
						$("#checkBerm3").attr("checked", true);
					} else {
						$("#checkBerm3").attr("checked", false);
					}

					if (obj.berm2 == "Y") {
						$("#checkBerm2").attr("checked", true);
					} else {
						$("#checkBerm2").attr("checked", false);
					}

					if (obj.berm1 == "Y") {
						$("#checkBerm1").attr("checked", true);
					} else {
						$("#checkBerm1").attr("checked", false);
					}

					$("#berm6Set").val(obj.berm6Set);
					$("#berm5Set").val(obj.berm5Set);
					$("#berm4Set").val(obj.berm4Set);
					$("#berm3Set").val(obj.berm3Set);
					$("#berm2Set").val(obj.berm2Set);
					$("#berm1Set").val(obj.berm1Set);

					if (obj.itemR == "Y") {
						$("#checkItemR").attr("checked", true);
					} else {
						$("#checkItemR").attr("checked", false);
					}

					if (obj.itemH == "Y") {
						$("#checkItemH").attr("checked", true);
					} else {
						$("#checkItemH").attr("checked", false);
					}

					if (obj.itemT == "Y") {
						$("#checkItemT").attr("checked", true);
					} else {
						$("#checkItemT").attr("checked", false);
					}

					if (obj.itemWs == "Y") {
						$("#checkItemWs").attr("checked", true);
					} else {
						$("#checkItemWs").attr("checked", false);
					}

					if (obj.itemWd == "Y") {
						$("#checkItemWd").attr("checked", true);
					} else {
						$("#checkItemWd").attr("checked", false);
					}

				}
				closeLoading();
			},
			error : function(result) {
				var oraErrorCode = "";
				if (result.responseText != null) {
					var matchedValue = result.responseText
							.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				closeLoading();
			}
		});
	}

	//사용자별 범례정보 가져오기
	function getBermSettingInfoChange(val) {
		var item = val;

		$.ajax({
			async : false,
			type : "post",
			url : "<c:url value='/stats/getBermSettingInfo.do'/>",
			data : {
				item : item
			},
			dataType : "json",
			success : function(result) {
				var tot = result['getBermSettingInfo'].length;
				if (tot <= 0) {
					$("#checkBerm6").attr("checked", false);
					$("#checkBerm5").attr("checked", false);
					$("#checkBerm4").attr("checked", false);
					$("#checkBerm3").attr("checked", false);
					$("#checkBerm2").attr("checked", false);
					$("#checkBerm1").attr("checked", false);

					$("#berm6Set").val("");
					$("#berm5Set").val("");
					$("#berm4Set").val("");
					$("#berm3Set").val("");
					$("#berm2Set").val("");
					$("#berm1Set").val("");

					$("#checkItemWt").attr("checked", false);
					$("#checkItemA").attr("checked", false);
					$("#checkItemAop").attr("checked", false);
					$("#checkItemWd").attr("checked", false);
					$("#checkItemH").attr("checked", false);
					$("#checkItemWs").attr("checked", false);
				} else {
					var obj = result['getBermSettingInfo'][0];
					if (obj.berm6 == "Y") {
						$("#checkBerm6").attr("checked", true);
					} else {
						$("#checkBerm6").attr("checked", false);
					}

					if (obj.berm5 == "Y") {
						$("#checkBerm5").attr("checked", true);
					} else {
						$("#checkBerm5").attr("checked", false);
					}

					if (obj.berm4 == "Y") {
						$("#checkBerm4").attr("checked", true);
					} else {
						$("#checkBerm4").attr("checked", false);
					}

					if (obj.berm3 == "Y") {
						$("#checkBerm3").attr("checked", true);
					} else {
						$("#checkBerm3").attr("checked", false);
					}

					if (obj.berm2 == "Y") {
						$("#checkBerm2").attr("checked", true);
					} else {
						$("#checkBerm2").attr("checked", false);
					}

					if (obj.berm1 == "Y") {
						$("#checkBerm1").attr("checked", true);
					} else {
						$("#checkBerm1").attr("checked", false);
					}

					$("#berm6Set").val(obj.berm6Set);
					$("#berm5Set").val(obj.berm5Set);
					$("#berm4Set").val(obj.berm4Set);
					$("#berm3Set").val(obj.berm3Set);
					$("#berm2Set").val(obj.berm2Set);
					$("#berm1Set").val(obj.berm1Set);

					if (obj.itemWt == "Y") {
						$("#checkItemWt").attr("checked", true);
					} else {
						$("#checkItemWt").attr("checked", false);
					}

					if (obj.itemA == "Y") {
						$("#checkItemA").attr("checked", true);
					} else {
						$("#checkItemA").attr("checked", false);
					}

					if (obj.itemAop == "Y") {
						$("#checkItemAop").attr("checked", true);
					} else {
						$("#checkItemAop").attr("checked", false);
					}

					if (obj.itemWd == "Y") {
						$("#checkItemWd").attr("checked", true);
					} else {
						$("#checkItemWd").attr("checked", false);
					}

					if (obj.itemH == "Y") {
						$("#checkItemH").attr("checked", true);
					} else {
						$("#checkItemH").attr("checked", false);
					}

					if (obj.itemWs == "Y") {
						$("#checkItemWs").attr("checked", true);
					} else {
						$("#checkItemWs").attr("checked", false);
					}

				}
				closeLoading();
			},
			error : function(result) {
				var oraErrorCode = "";
				if (result.responseText != null) {
					var matchedValue = result.responseText
							.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
			}
		});
	}

	//범례정보 등록
	function saveBermInfo() {

		if ($('input:checkbox[name=checkBerm6]').is(':checked') == true) {
			$("#berm6").val("Y");
		} else {
			$("#berm6").val("N");
		}

		if ($('input:checkbox[name=checkBerm5]').is(':checked') == true) {
			$("#berm5").val("Y");
		} else {
			$("#berm5").val("N");
		}

		if ($('input:checkbox[name=checkBerm4]').is(':checked') == true) {
			$("#berm4").val("Y");
		} else {
			$("#berm4").val("N");
		}

		if ($('input:checkbox[name=checkBerm3]').is(':checked') == true) {
			$("#berm3").val("Y");
		} else {
			$("#berm3").val("N");
		}

		if ($('input:checkbox[name=checkBerm2]').is(':checked') == true) {
			$("#berm2").val("Y");
		} else {
			$("#berm2").val("N");
		}

		if ($('input:checkbox[name=checkBerm1]').is(':checked') == true) {
			$("#berm1").val("Y");
		} else {
			$("#berm1").val("N");
		}

		if ($('input:checkbox[name=checkItemR]').is(':checked') == true) {
			$("#itemR").val("Y");
		} else {
			$("#itemR").val("N");
		}

		if ($('input:checkbox[name=checkItemH]').is(':checked') == true) {
			$("#itemH").val("Y");
		} else {
			$("#itemH").val("N");
		}

		if ($('input:checkbox[name=checkItemT]').is(':checked') == true) {
			$("#itemT").val("Y");
		} else {
			$("#itemT").val("N");
		}

		if ($('input:checkbox[name=checkItemWs]').is(':checked') == true) {
			$("#itemWs").val("Y");
		} else {
			$("#itemWs").val("N");
		}

		if ($('input:checkbox[name=checkItemWd]').is(':checked') == true) {
			$("#itemWd").val("Y");
		} else {
			$("#itemWd").val("N");
		}

		if (confirm("저장 하시겠습니까?")) {
			$('#bermForm').ajaxForm({
				success : function(result) {
					alert("저장되었습니다.");
					layerPopCloseAll();
				}
			}).submit();

						document.frm.action = "<c:url value='/stats/thematicMap.do'/>";
						document.frm.submit();	

		}
	}

	function reloadData() {

		showLoading();
		
		$kecoMap.model.markerClear();

		var searchSugye = $("#searchSugye").val();
		var searchSystem = $("#searchSystem").val();
		var searchItem = $("#searchItem").val();
		var searchDays = $("#searchDays").val();
		var searchTime = $("#searchTime").val();
		var searchCompareYear = $("#searchCompareYear").val();
		var searchData = $("#searchData").val();
		
		if (searchSystem == 'U' || searchSystem == 'A') {
			if (btToggle_flag)
				$('#resultToggle').trigger('click');
				$.ajax({
						type : "post",
						url : '/stats/getThematicMapDetail.do',
						data : {
							searchSugye : searchSugye,
							searchSystem : searchSystem,
							searchItem : searchItem,
							searchDays : searchDays,
							searchTime : searchTime,
							searchCompareYear : searchCompareYear,
							searchData : searchData,
						},
						dataType : "json",
						async : true,
						success : function(result) {
							var tot = result['detailViewList'].length;
							var b_tot = result['bermDataList'].length;
							
							var item;
							var trClass;
							
							$("#dataList").html("");

							if (tot <= "0") {
								$("#dataList").html("<tr><td style='text-align:center;'>조회 결과가 없습니다</td></td>");
								closeLoading();
							} else {
								var tempWidth = (tot * 180) + 80;
								$("#dataTable").css('width', tempWidth + 'px');
								
								item = "<tr>";
								item += "<th scope='col' rowspan='2' style='width:80px;'>항목</th>";
								
								
								for ( var i = 0; i < tot; i++) {

									var obj = result['detailViewList'][i];

									item += "<th scope='col' colspan='2'>"
											+ obj.branchNameN + "</th>";
							
								}
								item += "</tr>";

								item += "<tr>";

								for ( var i = 0; i < tot; i++) {
									item += "<th scope='col' style='width:90px;'>검색데이터</th>";
									item += "<th scope='col' style='width:90px;'>비교데이터</th>";
								}

								item += "</tr>";
								
								//항목데이터 조회
								item += "<tr>";
								
								var itempNm="";
								if(searchItem=="T"){
									itempNm = "탁도";
								}else if(searchItem=="W"){
									itempNm = "수온";
								}else if(searchItem=="P"){
									itempNm = "ph";
								}else if(searchItem=="D"){
									itempNm = "DO";
								}else if(searchItem=="E"){
									itempNm = "EC";
								}else if(searchItem=="C"){
									itempNm = "Chl-a";
								}
								item += "<td style='text-align:center;'>"+itempNm+"</th>";

								for ( var i = 0; i < tot; i++) {
									var obj = result['detailViewList'][i];
									
									var img = "";
									
									var tempValN = "";
									var tempValC = "";
									
									//지도표시 Start
									if(searchItem=="T"){
										tempValN =  obj.turN;
										tempValC =  obj.turC;
									}else if(searchItem=="W"){
										tempValN =  obj.tmpN;
										tempValC =  obj.tmpC;
									}else if(searchItem=="P"){
										tempValN =  obj.phyN;
										tempValC =  obj.phyC;
									}else if(searchItem=="D"){
										tempValN =  obj.dowN;
										tempValC =  obj.dowC;
									}else if(searchItem=="E"){
										tempValN =  obj.conN;
										tempValC =  obj.conC;
									}else if(searchItem=="C"){
										tempValN =  obj.tofN;
										tempValC =  obj.tofC;
									}
									if (tempValN != "" || tempValC != "") {
										
										if (obj.longitude != undefined	&& obj.latitude != undefined){
											
											var preBerm=0;
											
											if(b_tot>0){
												for(var j=0; j < b_tot; j++){
													var b_obj = result['bermDataList'][j];
													
													if(preBerm < Number(tempValN) && Number(tempValN) <= b_obj.berm){
														img = "circle"+b_obj.bermGubun;
													}
													preBerm = b_obj.berm.replace(/\s/g,'');
													
												}
												if(img != ""){
													$kecoMap.model.addMarkerTm(5, obj.longitude, obj.latitude, obj, '', img);
												}
											}
										}
									}
									//지도표시 End
									
									//데이터 Start
									if(searchItem=="T"){
										obj.turN = (obj.turN != null && obj.turN != '') ? obj.turN : '-';
										obj.turC = (obj.turC != null && obj.turC != '') ? obj.turC : '-';
										
										item += '<td style="text-align:center; cursor:pointer;" onclick="$kecoMap.model.moveCenterTm(\''+obj.longitude+'\',\''+obj.latitude+'\');">' + obj.turN + '</td>';
										item += '<td style="text-align:center; cursor:pointer;" onclick="$kecoMap.model.moveCenterTm(\''+obj.longitude+'\',\''+obj.latitude+'\');">' + obj.turC + '</td>';
									}else if(searchItem=="W"){
										obj.tmpN = (obj.tmpN != null && obj.tmpN != '') ? obj.tmpN : '-';
										obj.tmpC = (obj.tmpC != null && obj.tmpC != '') ? obj.tmpC : '-';
										
										item += '<td style="text-align:center; cursor:pointer;" onclick="$kecoMap.model.moveCenterTm(\''+obj.longitude+'\',\''+obj.latitude+'\');">' + obj.tmpN + '</td>';
										item += '<td style="text-align:center; cursor:pointer;" onclick="$kecoMap.model.moveCenterTm(\''+obj.longitude+'\',\''+obj.latitude+'\');">' + obj.tmpC + '</td>';
									}else if(searchItem=="P"){
										obj.phyN = (obj.phyN != null && obj.phyN != '') ? obj.phyN : '-';
										obj.phyC = (obj.phyC != null && obj.phyC != '') ? obj.phyC : '-';
										
										item += '<td style="text-align:center; cursor:pointer;" onclick="$kecoMap.model.moveCenterTm(\''+obj.longitude+'\',\''+obj.latitude+'\');">' + obj.phyN + '</td>';
										item += '<td style="text-align:center; cursor:pointer;" onclick="$kecoMap.model.moveCenterTm(\''+obj.longitude+'\',\''+obj.latitude+'\');">' + obj.phyC + '</td>';
									}else if(searchItem=="D"){
										obj.dowN = (obj.dowN != null && obj.dowN != '') ? obj.dowN : '-';
										obj.dowC = (obj.dowC != null && obj.dowC != '') ? obj.dowC : '-';
										
										item += '<td style="text-align:center; cursor:pointer;" onclick="$kecoMap.model.moveCenterTm(\''+obj.longitude+'\',\''+obj.latitude+'\');">' + obj.dowN + '</td>';
										item += '<td style="text-align:center; cursor:pointer;" onclick="$kecoMap.model.moveCenterTm(\''+obj.longitude+'\',\''+obj.latitude+'\');">' + obj.dowC + '</td>';
									}else if(searchItem=="E"){
										obj.conN = (obj.conN != null && obj.conN != '') ? obj.conN : '-';
										obj.conC = (obj.conC != null && obj.conC != '') ? obj.conC : '-';
										
										item += '<td style="text-align:center; cursor:pointer;" onclick="$kecoMap.model.moveCenterTm(\''+obj.longitude+'\',\''+obj.latitude+'\');">' + obj.conN + '</td>';
										item += '<td style="text-align:center; cursor:pointer;" onclick="$kecoMap.model.moveCenterTm(\''+obj.longitude+'\',\''+obj.latitude+'\');">' + obj.conC + '</td>';
									}else if(searchItem=="C"){
										obj.tofN = (obj.tofN != null && obj.tofN != '') ? obj.tofN : '-';
										obj.tofC = (obj.tofC != null && obj.tofC != '') ? obj.tofC : '-';
										
										item += '<td style="text-align:center; cursor:pointer;" onclick="$kecoMap.model.moveCenterTm(\''+obj.longitude+'\',\''+obj.latitude+'\');">' + obj.tofN + '</td>';
										item += '<td style="text-align:center; cursor:pointer;" onclick="$kecoMap.model.moveCenterTm(\''+obj.longitude+'\',\''+obj.latitude+'\');">' + obj.tofC + '</td>';
									}
									//데이터 End
								}

								item += "</tr>";
								
								//연계항목설정이 있을 경우 데이터 조회
								var s_obj = result['bermSettingList'][0];
								
								if(result['bermSettingList'].length>0){
									if(s_obj.itemR=='Y'){
										item += "<tr>";
										
										item += "<td style='text-align:center;'>강우</th>";
		
										for ( var i = 0; i < tot; i++) {
											var obj = result['detailViewList'][i];
											obj.rainFall = (obj.rainFall != null && obj.rainFall != '') ? obj.rainFall : '-';
											item += '<td  style="text-align:center;">' + obj.rainFall + '</td>';
											item += '<td  style="text-align:center;">' + obj.rainFall + '</td>';
											
										}
		
										item += "</tr>";
									}
									
									if(s_obj.itemH=='Y'){
										item += "<tr>";
										
										item += "<td style='text-align:center;'>습도</th>";
		
										for ( var i = 0; i < tot; i++) {
											var obj = result['detailViewList'][i];
											obj.humidity = (obj.humidity != null && obj.humidity != '') ? obj.humidity : '-';
											item += '<td  style="text-align:center;">' + obj.humidity + '</td>';
											item += '<td  style="text-align:center;">' + obj.humidity + '</td>';
											
										}
		
										item += "</tr>";
									}
									
									if(s_obj.itemT=='Y'){
										item += "<tr>";
										
										item += "<td style='text-align:center;'>온도</th>";
		
										for ( var i = 0; i < tot; i++) {
											var obj = result['detailViewList'][i];
											obj.temp = (obj.temp != null && obj.temp != '') ? obj.temp : '-';
											item += '<td style="text-align:center;">' + obj.temp + '</td>';
											item += '<td style="text-align:center;">' + obj.temp + '</td>';
											
										}
		
										item += "</tr>";
									}
									
									if(s_obj.itemWs=='Y'){
										item += "<tr>";
										
										item += "<td style='text-align:center;'>풍속</th>";
		
										for ( var i = 0; i < tot; i++) {
											var obj = result['detailViewList'][i];
											obj.windSpeed = (obj.windSpeed != null && obj.windSpeed != '') ? obj.windSpeed : '-';
											
											item += '<td style="text-align:center;">' + obj.windSpeed + '</td>';
											item += '<td style="text-align:center;">' + obj.windSpeed + '</td>';
											
										}
		
										item += "</tr>";
									}
									
									if(s_obj.itemWd=='Y'){
										item += "<tr>";
										
										item += "<td style='text-align:center;'>풍향</th>";
		
										for ( var i = 0; i < tot; i++) {
											var obj = result['detailViewList'][i];
											obj.windDir = (obj.windDir != null && obj.windDir != '') ? obj.windDir : '-';
											
											item += '<td style="text-align:center;">' + obj.windDir + '</td>';
											item += '<td style="text-align:center;">' + obj.windDir + '</td>';
											
										}
		
										item += "</tr>";
									}
								
								}
								
								$("#dataList").append(item);
								$("#dataList tr:odd").attr("class", "even");
							}
							
							closeLoading();
							result = '';
						},

					});
		}
	}
	
	function fnSearchDataDis(val){
		if(val=='U'){
			$('#dataDiv').show();
		}else{
			$('#dataDiv').hide();
		}
			
	}
	
	function excelDown() {
		document.frm.action = "<c:url value='/stats/thematicMapExcel.do'/>";
		document.frm.submit();
	}
	
	//]]>
</script>
</head>

<body>
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
						<form name="frm" action="" method="post">
						<div class="mapBxTm" style=height:600px;>
							<div id="map" class="claro" style="width:100%; height:100%; border:1px solid #000; position:relative;">
<!-- 								<div id="tool" style="right:1px; top:10px; position:absolute; width:100px; height:24px; z-index:10;"> -->
<!-- 									<div class="tool_bu1"><a href="javascript:$kecoMap.model.generalMap();" onMouseOut="$kecoMap.controller.MM_swapImgRestore('Image1','/gis/images/tool_1_off.gif')" onMouseOver="$kecoMap.controller.MM_swapImage('Image1','/gis/images/tool_1_over1.gif',1)" ><img idx="0" src="/gis/images/tool_1_over1.gif" id="Image1" width="42" height="24" border="0"></a></div> -->
<!-- 									<div class="tool_bu1"><a href="javascript:$kecoMap.model.flightMap();" onMouseOut="$kecoMap.controller.MM_swapImgRestore('Image2','/gis/images/tool_2_off.gif')" onMouseOver="$kecoMap.controller.MM_swapImage('Image2','/gis/images/tool_2_over1.gif',1)" ><img idx="1" src="/gis/images/tool_2_off.gif" id="Image2" width="42" height="24" border="0"></a></div> -->
<!-- 								</div> -->
								<div id="search_result" style="margin-left: -220px;">
									<div id="resultToggle">
										<img src="/images/renewal2/toggle_bin.png" alt="닫기" />
									</div>
									<div id="resultBtAreaTm">
										<span style="vertical-align: left; padding-left: 5px;">
											<b>
											<span style="display: inline-block; vertical-align: top; padding-left: 10px; background: url('/images/renewal2/point_01.png') no-repeat left center; font-weight: bold; margin-right: 5px;">[기상특보]</span>
											</b>
											<span id="weather_warn" style="cursor: pointer" onclick="weatherWarnPopup()"></span>
										 </span> 
										 <span style="margin-left: 360px;"> 
											 <input type="button" id="graphDnBtn" value="그래프" class="bt_graph" style="padding-right: 5px;" /> 
											 <input type="button" id="excelDnBtn" value="엑셀" class="bt_xls" onclick="javascript:excelDown();"/>
										</span>
									</div>
									<div id="result">
										<div id="resultDiv" style="overflow-x: scroll; overflow-y: hidden; width: 703px; height: 205px;">
											<table id="dataTable">
												<tbody id="dataList">
													<tr>
														<td style="height: 28px; text-align: center; border-bottom: 1px solid #333333; border-top: 1px solid #333333; border-left: 1px solid #ffffff; border-right: 1px solid #ffffff;">조회																결과가 없습니다.</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
								</div>
								<!--좌측 검색패널 Start-->
								<div id="leftSearchBx2">
									<div id="leftSearch">
										<div class="list-wrap2">
											<div id="siteCase" class="tabCase">
												<div id="search">
													<div id="search_terms">
														<ul>
															<li>
																<span class="point">수계</span> 
																<select name="searchSugye" id="searchSugye" style="width: 110px">
																	<option value="R01" <c:if test="${searchVO.searchSugye == 'R01'}">selected</c:if>>한강</option>
																	<option value="R02" <c:if test="${searchVO.searchSugye == 'R02'}">selected</c:if>>낙동강</option>
																	<option value="R03" <c:if test="${searchVO.searchSugye == 'R03'}">selected</c:if>>금강</option>
																	<option value="R04" <c:if test="${searchVO.searchSugye == 'R04'}">selected</c:if>>영산강</option>
																</select>
															</li>
															<li>
																<span class="point">시스템</span> 
																<select name="searchSystem" id="searchSystem" style="width: 110px" onchange="javascript:fnSearchDataDis(this.value);">
																	<option value="U" <c:if test="${searchVO.searchSystem == 'U'}">selected</c:if>>IP-USN</option>
																	<!-- 																<option value="A">국가수질자동측정망</option> -->
																	<!-- 																<option value="W">수질TMS</option> -->
																</select>
															</li>
															<li>
																<span class="point">항목</span> 
																<select name="searchItem" id="searchItem" style="width: 110px" onchange="javascript:dataLoad_bermSettingInfo();">
																		<option value="T" <c:if test="${searchVO.searchItem == 'T'}">selected</c:if>>탁도</option>
																		<option value="W" <c:if test="${searchVO.searchItem == 'W'}">selected</c:if>>수온</option>
																		<option value="P" <c:if test="${searchVO.searchItem == 'P'}">selected</c:if>>ph</option>
																		<option value="D" <c:if test="${searchVO.searchItem == 'D'}">selected</c:if>>DO</option>
																		<option value="E" <c:if test="${searchVO.searchItem == 'E'}">selected</c:if>>EC</option>
																		<option value="C" <c:if test="${searchVO.searchItem == 'C'}">selected</c:if>>Chl-a</option>
																</select>
															</li>
															<li>
																<span class="point">날짜</span> 
																<input type="text" id="searchDays" name="searchDays" size="13" value="<c:out value="${searchVO.searchDays}" />" alt="날짜" />
															</li>
															<li>
																<span class="point">시간</span> 
																<select name="searchTime" id="searchTime" style="width: 50px">
																	<c:forEach var="item" varStatus="i" begin="0" end="24" step="1">
																	<c:if test="${item < 10}"><c:set var="temp" value="0${item}" /></c:if>
																	<c:if test="${item >= 10}"><c:set var="temp" value="${item}" /></c:if>
																    <option value="${temp}" <c:if test="${temp == searchVO.searchTime}">selected="selected"</c:if>>
																    <c:out value="${temp}" />
																    </option>
																    </c:forEach>
																</select>
															</li>
															<li>
																<span class="point">비교년도</span> 
																<%
																	Calendar now = Calendar.getInstance();
																
																	String year = String.valueOf(now.get(Calendar.YEAR));
																	
																	int eYear = Integer.parseInt(year);
																	
																	int sYear = eYear-6;
																%>
																<select name="searchCompareYear" id="searchCompareYear" style="width: 110px">
																	<c:forEach var="item" varStatus="i" begin="<%=sYear%>" end="<%=eYear%>" step="1">
																	<option value="${item}" <c:if test="${item == searchVO.searchCompareYear}">selected="selected"</c:if>><c:out value="${item}" /></option>
																    </c:forEach>
																</select>
															</li>
															<li id="dataDiv">
																<span class="point">데이터</span> 
																<select name="searchData" id="searchData" style="width: 110px">
																	<option value="B" <c:if test="${searchVO.searchData == 'B'}">selected</c:if>>확정전</option>
																	<option value="A" <c:if test="${searchVO.searchData == 'A'}">selected</c:if>>확정후</option>
																</select>
															</li>
														</ul>
														<div style="text-aling: right; padding-top: 10px;">
															<input type="button" id="tmSearBtn" name="tmSearBtn" value="조회" class="btn btn_search" onclick="javascript:reloadData();" style="float: right;" />
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
								<!--좌측 검색패널 End-->
								<!--우측 범례패널 Start-->
								<div id="menuAuth1">
									<div id="bermTm" style="background-color: #ffffff">
										<div id="bermList"> 										
										</div>
										<ul>
											<li>
												<span onclick="javascript:fnBermSet();" style="cursor: pointer;">
													<img src="/images/renewal/top_info_icon_2.gif" alt="범례설정" />범례설정
												</span>
											</li>
										</ul>
									</div>
								</div>
								<!--우측 범례패널 End-->
							</div>
							</form>
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
		
		<!-- 범례 등록 수정 레이어 -->
		<div id="layerBermModify" class="divPopup2">
			<div id="xbox">
				<img src="/images/renewal/layerLogo.png" alt="한국환경공단" /> 
				<input type="button" id="btnBranModXbox" name="btnBranModXbox" value="X" class="btn btn_white" style="width: 18px" onclick="javascript:layerPopClose('layerBermModify');" alt="닫기" />
			</div>
			<form id="bermForm" name="bermForm" action="/stats/saveBermSettingInfo.do" method="post">
				<input type="hidden" name="berm1" id="berm1"> 
				<input type="hidden" name="berm2" id="berm2"> 
				<input type="hidden" name="berm3" id="berm3"> 
				<input type="hidden" name="berm4" id="berm4"> 
				<input type="hidden" name="berm5" id="berm5">
				<input type="hidden" name="berm6" id="berm6"> 
				<input type="hidden" name="itemR" id="itemR"> 
				<input type="hidden" name="itemH" id="itemH"> 
				<input type="hidden" name="itemT" id="itemT"> 
				<input type="hidden" name="itemWs" id="itemWs"> 
				<input type="hidden" name="itemWd" id="itemWd"> 
				<div>
					<span style="padding-left: 12px; background: url('/images/renewal2/point_04.png') no-repeat no-repeat left center;">항목</span>
					<select name="item" id="item" style="width: 130px" onchange="javascript:getBermSettingInfoChange(this.value);">
						<option value="T">탁도</option>
						<option value="W">수온</option>
						<option value="P">ph</option>
						<option value="D">DO</option>
						<option value="E">EC</option>
						<option value="C">Chl-a</option>
					</select>
					<div class="divisionBx2">
						<div class="div2_50">
							<div class="table_wrapper">
								<span>[범례설정]</span>
								<table id="tab_1_1" summary="범례설정">
									<caption>범례설정</caption>
									<colgroup>
										<col width="30" />
										<col width="40" />
										<col />
									</colgroup>
									<tbody>
										<tr>
											<td style="text-align: center;">
												<input type="checkbox" id="checkBerm6" name="checkBerm6" />
											</td>
											<td style="text-align: center;">
												<img src="/gis/images/circle6.png" alt="60" />
											</td>
											<td><input type="text" name="berm6Set" id="berm6Set" /></td>
										</tr>
										<tr>
											<td style="text-align: center;">
												<input type="checkbox" id="checkBerm5" name="checkBerm5" />
											</td>
											<td style="text-align: center;">
												<img src="/gis/images/circle5.png" alt="50" />
											</td>
											<td><input type="text" name="berm5Set" id="berm5Set" /></td>
										</tr>
										<tr>
											<td style="text-align: center;">
												<input type="checkbox" id="checkBerm4" name="checkBerm4" />
											</td>
											<td style="text-align: center;">
												<img src="/gis/images/circle4.png" alt="40" />
											</td>
											<td><input type="text" name="berm4Set" id="berm4Set" /></td>
										</tr>
										<tr>
											<td style="text-align: center;">
												<input type="checkbox" id="checkBerm3" name="checkBerm3" />
											</td>
											<td style="text-align: center;">
												<img src="/gis/images/circle3.png" alt="30" />
											</td>
											<td><input type="text" name="berm3Set" id="berm3Set" /></td>
										</tr>
										<tr>
											<td style="text-align: center;">
												<input type="checkbox" id="checkBerm2" name="checkBerm2" />
											</td>
											<td style="text-align: center;">
												<img src="/gis/images/circle2.png" alt="20" />
											</td>
											<td><input type="text" name="berm2Set" id="berm2Set" /></td>
										</tr>
										<tr>
											<td style="text-align: center;">
												<input type="checkbox" id="checkBerm1" name="checkBerm1" />
											</td>
											<td style="text-align: center;">
												<img src="/gis/images/circle1.png" alt="10" />
											</td>
											<td><input type="text" name="berm1Set" id="berm1Set" /></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="div2_50 last">
							<div class="table_wrapper">
								<span>[항목연계설정]</span>
								<table id="tab_1_2" summary="항목연계설정">
									<caption>시스템정보</caption>
									<colgroup>
										<col width="120px"></col>
										<col></col>
									</colgroup>
									<tbody>
										<tr>
											<th>탁도</th>
										</tr>
										<tr>
											<td
												style="height: 103px; vertical-align: top; padding-top: 10px;">
												<input type="checkbox" id="checkItemR" name="checkItemR" style="margin-left: 5px; margin-right: 3px;" />강우
												<input type="checkbox" id="checkItemH" name="checkItemH" style="margin-left: 5px; margin-right: 3px;" />습도 
												<input type="checkbox" id="checkItemT" name="checkItemT" style="margin-left: 5px; margin-right: 3px;" />온도
												<input type="checkbox" id="checkItemWs" name="checkItemWs" style="margin-left: 5px; margin-right: 3px;" />풍속
												<input type="checkbox" id="checkItemWd" name="checkItemWd" style="margin-left: 5px; margin-right: 3px;" />풍향
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</form>
			<div id="btCarea">
				<input type="button" id="bermMod" name="bermMod" value="저장"	class="btn btn_search" onclick="javascript:saveBermInfo();" style="float: right;" />
			</div>
		</div>
		<!-- 범례 등록 수정 레이어 -->
	</div>
	
	
	<script language="javascript">
	function menuAuth(auth){
		var iauthC ="";
		var iauthU ="";
		var iauthD ="";
		if(auth == "C"){
			iauthC ="Y";
		}
		if(auth == "U"){
			iauthU ="Y";
		}
		if(auth == "D"){
			iauthD ="Y";
		}
		var menuAuth = ""	;
		$.ajax({	
			type:"post",
			url: "<c:url value='/admin/member/getUserAuthorCnt.do'/>",
			dataType:"json",
			async: false,
			data:{
				userId:$("#userId").val(),
				menuId:$("#naviMenuNo").val(),
				authC:iauthC,
				authU:iauthU,
				authD:iauthD
			},
			success : function(result){
				var tot = 0;
				 tot = result['getUserMenuAuthorCount'];
				 menuAuth = tot;
			}
		});
		return menuAuth;
	}
	if("1" == menuAuth("U")){
		$("#menuAuth1").show();
	}else{
		$("#menuAuth1").hide();
	}
	
</script>

</body>
</html>