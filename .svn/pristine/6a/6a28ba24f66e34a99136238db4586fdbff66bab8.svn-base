<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />
	<script src="<c:url value='/js/JQuery/jquery-1.3.2.min.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js" type="text/javascript'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>
	
	<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.datepicker.js'/>"></script>

<c:set var="river_div" scope="request" value="${param.river_div}"/>
	<script type="text/javascript">
		var user_riverid = '<sec:authentication property="principal.userVO.riverId"/>';
	</script>

<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
	
<script type="text/javascript">
	$(function(){
		
		var sys = '${param.sys}';		
		if(sys == ""){
			if($("#dataU_factCode").val() != "" && typeof $("#dataU_factCode").val() !== "undefined"){
				sys = "U";
			}
			else if($("#dataA_factCode").val() != "" && typeof $("#dataA_factCode").val() !== "undefined"){
				sys = "A";
			}
			else if($("#dataW_factCode").val() != "" && typeof $("#dataW_factCode").val() !== "undefined"){
				sys = "W";
			}
			else if($("#dataD_factCode").val() != "" && typeof $("#dataD_factCode").val() !== "undefined"){
				sys = "D";
			}
			else if($("#dataI_factCode").val() != "" && typeof $("#dataI_factCode").val() !== "undefined"){
				sys = "I";
			}
			else if($("#dataP_factCode").val() != "" && typeof $("#dataP_factCode").val() !== "undefined"){
				sys = "P";
			}
		}
		showView(sys);
		
		$("#aEve").click(function(){
			var chkDis = $(this).attr("disabled");
			if(!chkDis){
				showView("A");
			}			
		});
		$("#uEve").click(function(){
			var chkDis = $(this).attr("disabled");
			if(!chkDis){
				showView("U");
			}
		});
		$("#wEve").click(function(){
			var chkDis = $(this).attr("disabled");
			if(!chkDis){
				showView("W");
			}
		});
		$("#pEve").click(function(){
			var chkDis = $(this).attr("disabled");
			if(!chkDis){
				showView("P");
			}
		});
		$("#dEve").click(function(){
			var chkDis = $(this).attr("disabled");
			if(!chkDis){
				showView("D");
			}
		});
		$("#iEve").click(function(){
			var chkDis = $(this).attr("disabled");
			if(!chkDis){
				showView("I");
			}
		});
	});
	
	function showView(sys){
		
		if(sys == 'A'){
			$("#newDataBoxA").show();
			$("#newDataBoxU").hide();
			$("#newDataBoxW").hide();
			$("#newDataBoxP").hide();
			$("#newDataBoxD").hide();
			$("#newDataBoxI").hide();
			//$("#allTitle").html("사고지점 : 국가수질자동측정망");			
			$(".menuBoxT td").each(function(){
				$(this).css("background", "");
			});			
			var style = $("#aEve").attr("style");
			$("#aEve").attr("style", style+"background: url('/images/renewal2/sub_sel_line.png') no-repeat;");
		}
		else if(sys == 'U'){
			$("#newDataBoxA").hide();
			$("#newDataBoxU").show();
			$("#newDataBoxW").hide();
			$("#newDataBoxP").hide();
			$("#newDataBoxD").hide();
			$("#newDataBoxI").hide();
			//$("#allTitle").html("사고지점 : 이동형측정기기");
			$(".menuBoxT td").each(function(){
				$(this).css("background", "");
			});
			var style = $("#uEve").attr("style");
			$("#uEve").attr("style", style+"background: url('/images/renewal2/sub_sel_line.png') no-repeat;");
		}
		else if(sys == 'W'){
			$("#newDataBoxA").hide();
			$("#newDataBoxU").hide();
			$("#newDataBoxW").show();
			$("#newDataBoxP").hide();
			$("#newDataBoxD").hide();
			$("#newDataBoxI").hide();
			//$("#allTitle").html("사고지점 : 수질TMS");
			$(".menuBoxT td").each(function(){
				$(this).css("background", "");
			});
			var style = $("#wEve").attr("style");
			$("#wEve").attr("style", style+"background: url('/images/renewal2/sub_sel_line.png') no-repeat;");
		}
		else if(sys == 'P'){
			$("#newDataBoxA").hide();
			$("#newDataBoxU").hide();
			$("#newDataBoxW").hide();
			$("#newDataBoxP").show();
			$("#newDataBoxD").hide();
			$("#newDataBoxI").hide();
			//$("#allTitle").html("사고지점 : 방제창고");
			$(".menuBoxT td").each(function(){
				$(this).css("background", "");
			});
			var style = $("#pEve").attr("style");
			$("#pEve").attr("style", style+"background: url('/images/renewal2/sub_sel_line.png') no-repeat;");
		}
		else if(sys == 'D'){
			$("#newDataBoxA").hide();
			$("#newDataBoxU").hide();
			$("#newDataBoxW").hide();
			$("#newDataBoxP").hide();
			$("#newDataBoxD").show();
			$("#newDataBoxI").hide();
			//$("#allTitle").html("사고지점 : 댐");
			$(".menuBoxT td").each(function(){
				$(this).css("background", "");
			});
			var style = $("#dEve").attr("style");
			$("#dEve").attr("style", style+"background: url('/images/renewal2/sub_sel_line.png') no-repeat;");
		}
		else if(sys == 'I'){
			$("#newDataBoxA").hide();
			$("#newDataBoxU").hide();
			$("#newDataBoxW").hide();
			$("#newDataBoxP").hide();
			$("#newDataBoxD").hide();
			$("#newDataBoxI").show();
			//$("#allTitle").html("사고지점 : 보");
			$(".menuBoxT td").each(function(){
				$(this).css("background", "");
			});
			var style = $("#iEve").attr("style");
			$("#iEve").attr("style", style+"background: url('/images/renewal2/sub_sel_line.png') no-repeat;");
		}
	}
	
	//추이 팝업
	function transitionPopup(sys, factCode, branchNo)
	{
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 800;
		var winWidth = 1000;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		
		var param = "factCode=" + factCode + "&branchNo=" +  branchNo + "&sys=" + sys;
		
		var src = "<c:url value='/waterpolmnt/situationctl/goWatersysMntTransition.do'/>?" + param;
		
		window.open(src,
				'watersysMntTransition','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	//지도 팝업
	function mapPopup(factCode, branchNo){		
		$.ajax({
			type: "POST",
			url: "<c:url value='/waterpolmnt/situationctl/sysMntMap.do'/>",
			data: {
					fact_code:factCode,
					branch_no:branchNo
				},
			dataType:"json",
			success : function(result){
				
					var longitude = result['resultList'].longitude;
					var latitude = result['resultList'].latitude;
					var sys = result['resultList'].sys_kind;
					
					window.open("/psupport/MNT_POP.html?riverid=" + user_riverid + "&menuid=mnt&longitude=" + longitude + "&latitude=" + latitude + "&sys=" + sys,
							'sysMntMap','width='+window.screen.width+',height='+window.screen.height+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left=0,top=0');
			},
			error:function(result){
				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
				var oraErrorCode = "";
				if (result.responseText != null ) {
					var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
			} 
		});
	}
</script>
</head>

<style type="text/css">
.menuBoxT td:hover{background: url('/images/renewal2/sub_sel_line.png') no-repeat;background-attachment: scroll; background-repeat: no-repeat;background-color: transparent;}
</style>

<body class="popup" id="mainBody">
<c:set var="selectVal1" value="${fn:split(sel, ',')[0] }"/>
<c:set var="selectVal2" value="${fn:split(sel, ',')[1] }"/>
<c:if test="${selectVal1 eq 'A' ||  selectVal1 eq 'U' || selectVal1 eq 'W'}">
<c:set var="selectVal3" value="${fn:split(sel, ',')[2] }"/>	
</c:if>

	<div id="wrap" class="mainPop" style="margin-left: 0px; width:1185px !important;">
		
		<div class="pop_container" style="height: 335px !important;">
			<div class="pop_container_r">
		<div id="container">
			<!-- content -->
			<div id="content" class="sub_waterpolmnt" style="width:1150px !important;">
				<div class="content_wrap page_situationctl">
					<div class="inner_watersysmnt">
						<div class="watersysmnt_wrap">
							<div class="pop_header" style="margin-left:0px ;width: 1150px !important;">
								<div class="bg_header_r">
									<div class="bg_header">
										<h1 id="allTitle" class="pop_tit">사고지점</h1>
									</div>
								</div>
							</div>
							<br/>
							<div class="data_graph" style="width:135px;">
								<div style="width: 135px; height: 220px; margin-bottom: 10px; padding-top: 10px; border-top-color: #ccc; border-right-color: #ccc; border-bottom-color: #ccc; border-left-color: #ccc; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: solid; border-right-style: solid; border-bottom-style: solid; border-left-style: solid;">
									<table class="menuBoxT">
										<tr style="">
											<td id="uEve" style="padding-left:25px; width: 150px; <c:if test="${!empty refreshDataU}">cursor: pointer</c:if>" <c:if test="${empty refreshDataU}">disabled="true"</c:if>>
												<span>이동형측정기기</span>
											</td>
										</tr>
										<tr>
											<td id="aEve" style="padding-left:25px; width: 150px; <c:if test="${!empty refreshDataA}">cursor: pointer</c:if>" <c:if test="${empty refreshDataA}">disabled="true"</c:if>>
												<span>국가수질</span>
											</td>
										</tr>
										<tr>
											<td id="wEve" style="padding-left:25px; width: 150px; <c:if test="${!empty refreshDataW}">cursor: pointer</c:if>" <c:if test="${empty refreshDataW}">disabled="true"</c:if>>
												<span>수질TMS</span>
											</td>
										</tr>
										<tr>
											<td id="dEve" style="padding-left:25px; width: 150px; <c:if test="${!empty refreshDataD}">cursor: pointer</c:if>" <c:if test="${empty refreshDataD}">disabled="true"</c:if>>
												<span>댐</span>
											</td>
										</tr>
										<tr>
											<td id="iEve" style="padding-left:25px; width: 150px; <c:if test="${!empty refreshDataI}">cursor: pointer</c:if>" <c:if test="${empty refreshDataI}">disabled="true"</c:if>>
												<span>보</span>
											</td>
										</tr>
										<tr>
											<td id="pEve" style="padding-left:25px; width: 150px; <c:if test="${!empty refreshDataP}">cursor: pointer</c:if>" <c:if test="${empty refreshDataP}">disabled="true"</c:if>>
												<span>방제창고</span>
											</td>
										</tr>
									</table>
								</div>							
							</div>
							
							<div><tr><td><input id="pointVal" style="display:none;"/></td></tr></div>
							
							<div class="watersysmnt_con" style="width: 1000px !important;">
								<c:if test="${!empty refreshDataA }">
								<div id="newDataBoxA" style="width: 1000px !important;">
									<input id="dataA_factCode" type="hidden" value="${refreshDataA[0].fact_code }"/>
									<div class="dataBox" style="height: 226px !important; border-width: 0px !important; width: 1000px !important;">
										<table oncontextmenu="return false" ondragstart="return false" onselectstart="return false" class="dataTable">
											<tbody>
												<tr>
													<th scope="col">수계</th>
													<th scope="col">측정소</th>
													<th scope="col">탁도(NTU)</th>
													<th scope="col">pH</th>
													<th scope="col">DO(mg/L)</th>
													<!-- <th scope="col">EC(mS/cm)</th> -->
													<th scope="col">EC(μS/cm)</th>
													<th scope="col">수온(℃)</th>
													<th scope="col">Chl-a</th>
													<th scope="col" style="width: 80px;">상태</th>
													<th scope="col">경보발령</th>
													<th scope="col">추이보기</th>
													<th scope="col">위치</th>
												</tr>
											</tbody>
											<tbody id="newDataListA">
													<c:forEach var="record" items="${refreshDataA}" varStatus="status">
													<c:choose>
														<c:when test="${status.count % 2 eq 0}">
															<tr style="background:#f2f2f2; <c:if test="${record.fact_code == selectVal2 && record.branch_no == selectVal3}"></c:if>" id="<c:out value='${status.index+1}' />" code="<c:out value='${record.fact_code }'/>"	branchno="<c:out value='${record.branch_no }'/>">
														</c:when>
														<c:otherwise>
															<tr <c:if test="${record.fact_code == selectVal2 && record.branch_no == selectVal3}"></c:if> id="<c:out value='${status.index+1}' />" code="<c:out value='${record.fact_code }'/>"	branchno="<c:out value='${record.branch_no }'/>">
														</c:otherwise>
													</c:choose>
															<td><c:out value='${record.river_name }'/></td>
															<td><c:out value='${record.branch_name }'/></td>
															<td class="num">
																<span style="font-weight: bold; color: green;" id="tur<c:out value='${status.index}' />">
																	<c:if test="${empty record.tur }">
																		-
																	</c:if>
																	<c:if test="${!empty record.tur }">
																		<c:out value="${record.tur }"/>
																	</c:if>
																</span>
															</td>
															<td class="num">
																<span style="font-weight: bold; color: green;" id="phy<c:out value='${status.index}' />">
																	<c:if test="${empty record.phy }">
																		-
																	</c:if>
																	<c:if test="${!empty record.phy }">
																		<c:out value="${record.phy }"/>
																	</c:if>
																</span>
															</td>
															<td class="num">
																<span style="font-weight: bold; color: green;" id="dow<c:out value='${status.index}' />">
																	<c:if test="${empty record.dow }">
																		-
																	</c:if>
																	<c:if test="${!empty record.dow }">
																		<c:out value="${record.dow }"/>
																	</c:if>
																</span>
															</td>
															<td class="num">
																<span style="font-weight: bold; color: green;" id="con<c:out value='${status.index}' />">
																	<c:if test="${empty record.con }">
																		-
																	</c:if>
																	<c:if test="${!empty record.con }">
																		<c:out value="${record.con }"/>
																	</c:if>
																</span>
															</td>
															<td class="num">
																<span style="font-weight: bold; color: green;" id="tmp<c:out value='${status.index}' />">
																	<c:if test="${empty record.tmp }">
																		-
																	</c:if>
																	<c:if test="${!empty record.tmp }">
																		<c:out value="${record.tmp }"/>
																	</c:if>
																</span>
															</td>
															<td class="num">
																<span style="font-weight: bold; color: green;" id="rin<c:out value='${status.index}' />">
																	<c:if test="${empty record.tof }">
																		-
																	</c:if>
																	<c:if test="${!empty record.tof }">
																		<c:out value="${record.tof }"/>
																	</c:if>
																</span>
															</td>
															<td><c:out value='${record.status_name }'/></td>
															
															<c:choose>
																<c:when test="${record.con_or eq '2' || record.dow_or eq '2'|| record.phy_or eq '2'}">
																	<td>주의</td>
																</c:when>
																<c:when test="${record.con_or eq '1' || record.dow_or eq '1'|| record.phy_or eq '1'}">
																	<td>관심</td>
																</c:when>
																<c:otherwise>
																	<td>정상</td>
																</c:otherwise>
															</c:choose>
															
															<td>
																<img src="<c:url value='/images/common/btn_progress.gif'/>" style="cursor: pointer" onclick="transitionPopup('A', '<c:out value="${record.fact_code }"/>', '<c:out value="${record.branch_no }"/>')" alt="추이" />
															</td>
															<td>
																<img src="<c:url value='/images/common/btn_map.gif'/>" style="cursor: pointer" onclick="mapPopup('<c:out value="${record.fact_code }"/>', '<c:out value="${record.branch_no }"/>')" alt="지도" />
															</td>
														</tr>
													</c:forEach>
											</tbody>
										</table>
									</div>
								</div>	
								</c:if>	
								<c:if test="${!empty refreshDataU }">	
								<div id="newDataBoxU" style="width: 1000px !important;">
									<input id="dataU_factCode" type="hidden" value="${refreshDataU[0].fact_code }"/>
									<div class="dataBox" style="height: 226px !important; border-width: 0px !important; width: 1000px !important;">
										<table oncontextmenu="return false" ondragstart="return false" onselectstart="return false" class="dataTable">
											<tbody>
												<tr>
													<th scope="col">수계</th>
													<th scope="col">측정소</th>
													<th scope="col">탁도(NTU)</th>
													<th scope="col">pH</th>
													<th scope="col">DO(mg/L)</th>
													<th scope="col">EC(mS/cm)</th>
													<th scope="col">수온(℃)</th>
													<th scope="col">Chl-a(μg/L)</th>
													<th scope="col" style="width: 80px;">상태</th>
													<th scope="col">경보발령</th>
													<th scope="col">추이보기</th>
													<th scope="col">지도보기</th>
												</tr>
											</tbody>
											<tbody id="newDataListU">
												<c:forEach var="record" items="${refreshDataU}" varStatus="status">
													<c:choose>
														<c:when test="${status.count % 2 eq 0}">
															<tr style="background:#f2f2f2; <c:if test="${record.fact_code == selectVal2 && record.branch_no == selectVal3}"></c:if>" id="<c:out value='${status.index+1}' />" code="<c:out value='${record.fact_code }'/>"	branchno="<c:out value='${record.branch_no }'/>">
														</c:when>
														<c:otherwise>
															<tr <c:if test="${record.fact_code == selectVal2 && record.branch_no == selectVal3}"></c:if> id="<c:out value='${status.index+1}' />" code="<c:out value='${record.fact_code }'/>"	branchno="<c:out value='${record.branch_no }'/>">
														</c:otherwise>
													</c:choose>
														<td><c:out value='${record.river_name }'/></td>
														<td><c:out value='${record.branch_name }'/></td>
														<td class="num">
															<span style="font-weight: bold; color: green;" id="tur<c:out value='${status.index}' />">
																<c:if test="${empty record.tur }">
																	-
																</c:if>
																<c:if test="${!empty record.tur }">
																	<c:out value="${record.tur }"/>
																</c:if>
															</span>
														</td>
														<td class="num">
															<span style="font-weight: bold; color: green;" id="phy<c:out value='${status.index}' />">
																<c:if test="${empty record.phy }">
																	-
																</c:if>
																<c:if test="${!empty record.phy }">
																	<c:out value="${record.phy }"/>
																</c:if>
															</span>
														</td>
														<td class="num">
															<span style="font-weight: bold; color: green;" id="dow<c:out value='${status.index}' />">
																<c:if test="${empty record.dow }">
																	-
																</c:if>
																<c:if test="${!empty record.dow }">
																	<c:out value="${record.dow }"/>
																</c:if>
															</span>
														</td>
														<td class="num">
															<span style="font-weight: bold; color: green;" id="con<c:out value='${status.index}' />">
																<c:if test="${empty record.con }">
																	-
																</c:if>
																<c:if test="${!empty record.con }">
																	<c:out value="${record.con }"/>
																</c:if>
															</span>
														</td>
														<td class="num">
															<span style="font-weight: bold; color: green;" id="tmp<c:out value='${status.index}' />">
																<c:if test="${empty record.tmp }">
																	-
																</c:if>
																<c:if test="${!empty record.tmp }">
																	<c:out value="${record.tmp }"/>
																</c:if>
															</span>
														</td>
														<td class="num">
															<span style="font-weight: bold; color: green;" id="rin<c:out value='${status.index}' />">
																<c:if test="${empty record.tof }">
																	-
																</c:if>
																<c:if test="${!empty record.tof }">
																	<c:out value="${record.tof }"/>
																</c:if>
															</span>
														</td>
														<td><c:out value='${record.status_name }'/></td>
														
														<c:choose>
															<c:when test="${record.con_or eq '2' || record.dow_or eq '2'|| record.phy_or eq '2'}">
																<td>주의</td>
															</c:when>
															<c:when test="${record.con_or eq '1' || record.dow_or eq '1'|| record.phy_or eq '1'}">
																<td>관심</td>
															</c:when>
															<c:otherwise>
																<td>정상</td>
															</c:otherwise>
														</c:choose>
														
														<td>
															<img src="<c:url value='/images/common/btn_progress.gif'/>" style="cursor: pointer" onclick="transitionPopup('U', '<c:out value="${record.fact_code }"/>', '<c:out value="${record.branch_no }"/>')" alt="추이" />
														</td>
														<td>
															<img src="<c:url value='/images/common/btn_map.gif'/>" style="cursor: pointer" onclick="mapPopup('<c:out value="${record.fact_code }"/>', '<c:out value="${record.branch_no }"/>')" alt="지도" />
														</td>
													</tr>
												</c:forEach>
												
											</tbody>
										</table>
									</div>
								</div>	
								</c:if>
								<c:if test="${!empty refreshDataW }">
								<div id="newDataBoxW" style="width: 1000px !important;">
									<input id="dataW_factCode" type="hidden" value="${refreshDataW[0].factcode }"/>
									<div class="dataBox" style="height: 226px !important; border-width: 0px !important; width: 1000px !important;">
										<table oncontextmenu="return false" ondragstart="return false" onselectstart="return false" class="dataTable">
											<colgroup>
												<col width="40">
												<col width="80">
												<col width="120">
												<col width="45">
												<col width="150">
												<col width="75">
												<col width="75">
												<col width="75">
												<col width="75">
												<col width="75">
												<col width="75">
											</colgroup>
											<thead>
												<tr>
													<th scope="col">No</th>
													<th scope="col">권역</th>
													<th scope="col">측정소</th>
													<th scope="col">방류구</th>
													<th scope="col">일자</th>
													<th scope="col">pH</th>
													<th scope="col">BOD(ppm)</th>
													<th scope="col">COD(ppm)</th>
													<th scope="col">SS(mg/L)</th>
													<th scope="col">T-N(mg/L)</th>
													<th scope="col">T-P(mg/L)</th>
													<th scope="col">유량(㎥/hr)</th>
												</tr>
											</thead>
											<tbody id="newDataListW">
												<c:forEach var="record" items="${refreshDataW}" varStatus="status">
													<c:choose>
														<c:when test="${status.count % 2 eq 0}">
															<tr style="background:#f2f2f2; <c:if test="${record.factcode == selectVal2 && record.branchno == selectVal3}"></c:if>"  >
														</c:when>
														<c:otherwise>
															<tr <c:if test="${record.factcode == selectVal2 && record.branchno == selectVal3}"></c:if> >
														</c:otherwise>
													</c:choose>
																<td><c:out value="${status.index+1 }" /></td>
																<td><c:out value="${record.river_name }" /></td>
																<td><c:out value="${record.factname }" /></td>
																<td><c:out value="${record.branch_name }" /></td>
																<td><c:out value="${record.strdate }" /></td>
																<td><c:out value="${record.phy }" /></td>
																<td><c:out value="${record.bod }" /></td>
																<td><c:out value="${record.cod }" /></td>
																<td><c:out value="${record.sus }" /></td>
																<td><c:out value="${record.ton }" /></td>
																<td><c:out value="${record.top }" /></td>
																<td><c:out value="${record.flw }" /></td>
															</tr>
												</c:forEach>
												
											</tbody>
										</table>
									</div>
								</div>	
								</c:if>
								<c:if test="${!empty refreshDataP }">
								<div id="newDataBoxP" style="width: 1000px !important;">
									<input id="dataP_factCode" type="hidden" value="${refreshDataP[0].whCode }"/>
									<div class="dataBox" style="height: 226px !important; border-width: 0px !important; width: 1000px !important;">
										<table oncontextmenu="return false" ondragstart="return false" onselectstart="return false" class="dataTable">
											<colgroup>
												<col width="60">
												<col width="180">
												<col>
												<col width="150">
												<col width="110">
												<col width="150">
												<col width="100">
												<col width="110">
											</colgroup>
											<thead>
												<tr>
													<th scope="col">NO</th>
													<th scope="col">창고명</th>
													<th scope="col">수계</th>
													<th scope="col">담당부서</th>
													<th scope="col">담당자</th>
													<th scope="col">연락처</th>
													<th scope="col">사용여부</th>
												</tr>
											</thead>
											<tbody id="newDataListP">
												
												<c:forEach var="record" items="${refreshDataP}" varStatus="status">
													<c:choose>
														<c:when test="${status.count % 2 eq 0}">
															<tr style="background:#f2f2f2; <c:if test="${record.whCode == selectVal2}"></c:if>" >
														</c:when>
														<c:otherwise>
															<tr <c:if test="${record.whCode == selectVal2}"></c:if>>
														</c:otherwise>
													</c:choose>
																<td><c:out value="${status.index+1}"/></td>
																<td><c:out value="${record.whName }"/></td>
																<td><c:out value="${record.riverName }"/></td>
																<td><c:out value="${record.adminDeptName }"/></td>
																<td><c:out value="${record.adminName }"/></td>
																<td><c:out value="${record.adminTelno }"/></td>
																<td><c:out value="${record.useFlag }"/></td>
															</tr>
												</c:forEach>
												
											</tbody>
										</table>
									</div>
								</div>
								</c:if>
								<c:if test="${!empty refreshDataD }">
								<div id="newDataBoxD" style="width: 1000px !important;">
									<input id="dataD_factCode" type="hidden" value="${refreshDataD[0].id }"/>
									<div class="dataBox" style="height: 226px !important; border-width: 0px !important; width: 1000px !important;">
										<table oncontextmenu="return false" ondragstart="return false" onselectstart="return false" class="dataTable">
											<colgroup>
												<col width="45">
												<col width="80">
												<col width="80">
												<col width="100">
												<col width="100">
												<col width="90">
												<col width="90">
												<col width="150">
											</colgroup>
											<thead>
												<tr>
													<th scope="col">수계</th>
													<th scope="col">하천명</th>
													<th scope="col">댐명</th>
													<th scope="col">관할기관</th>
													<th scope="col">연락처</th>
													<th scope="col">수위(M)</th>
													<th scope="col">유량(M3/HR)</th>
													<th scope="col">위치</th>
												</tr>
											</thead>
											<tbody id="newDataListD">
												
												<c:forEach var="record" items="${refreshDataD}" varStatus="status">
													<c:choose>
														<c:when test="${status.count % 2 eq 0}">
															<tr style="background:#f2f2f2; <c:if test="${record.id == selectVal2}"></c:if>" >
														</c:when>
														<c:otherwise>
															<tr <c:if test="${record.id == selectVal2}"></c:if>>
														</c:otherwise>
													</c:choose>
																<td><c:out value="${record.river_div }"/></td>
																<td><c:out value="${record.river_nm }"/></td>
																<td><c:out value="${record.name }"/></td>
																<td><c:out value="${record.manage }"/></td>
																<td><c:out value="${record.manage_phone }"/></td>
																<td><c:out value="${record.swl }"/></td>
																<td><c:out value="${record.sfw }"/></td>
																<td><c:out value="${record.address }"/></td>
															</tr>
												</c:forEach>
												
											</tbody>
										</table>
									</div>
								</div>	
								</c:if>
								<c:if test="${!empty refreshDataI }">	
								<div id="newDataBoxI" style="width: 1000px !important;">
									<input id="dataI_factCode" type="hidden" value="${refreshDataI[0].boObsCd }"/>
									<div class="dataBox" style="height: 226px !important; border-width: 0px !important; width: 1000px !important;">
										<table oncontextmenu="return false" ondragstart="return false" onselectstart="return false" class="dataTable">
											<colgroup>
												<col width="45">
												<col width="100">
												<col width="80">
												<col width="100">
												<col width="120">
												<col width="120">
												<col width="90">
												<col width="90">
												<col width="90">
												<col width="100">
											</colgroup>
											<thead>
												<tr>
													<th scope="col">No</th>
													<th scope="col">수신일</th>
													<th scope="col">수신시간</th>
													<th scope="col">보이름</th>
													<th scope="col">보상위수량(mm)</th>
													<th scope="col">보하위수량(mm)</th>
													<th scope="col">저수량(mm)</th>
													<th scope="col">공용량(mm)</th>
													<th scope="col">유입량(mm)</th>
													<th scope="col">방류량(mm)</th>
												</tr>
											</thead>
											<tbody id="newDataListI">
												
												<c:forEach var="record" items="${refreshDataI}" varStatus="status">
													<c:choose>
														<c:when test="${status.count % 2 eq 0}">
															<tr style="background:#f2f2f2; <c:if test="${record.boObsCd == selectVal2}"></c:if>" >
														</c:when>
														<c:otherwise>
															<tr <c:if test="${record.boObsCd == selectVal2}"></c:if>>
														</c:otherwise>
													</c:choose>
																<td><c:out value="${status.index+1 }"/></td>
																<td><c:out value="${record.recvDay }"/></td>
																<td><c:out value="${record.recvTime }"/></td>
																<td><c:out value="${record.obsNm }"/></td>
																<td><c:out value="${record.swl }"/></td>
																<td><c:out value="${record.owl }"/></td>
																<td><c:out value="${record.sfw }"/></td>
																<td><c:out value="${record.ecpc }"/></td>
																<td><c:out value="${record.inf }"/></td>
																<td><c:out value="${record.otf }"/></td>
															</tr>
												</c:forEach>
												
											</tbody>
										</table>
									</div>
								</div>	
								</c:if>
							</div>
							<!-- 우측 챠트 영역 엔드 -->
						</div>
					</div>
				</div>
			</div><!-- //content -->
		</div><!-- //container -->
			</div>
		</div>
		<div class="pop_footer">
			<div class="bg_footer_r">
				<div class="bg_footer">
				</div>
			</div>
		</div>	
	</div>
</body>
</html>