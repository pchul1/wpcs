<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<%
	/**
	 * Class Name  : monitoringDetail.jsp
	 * Description : 조류모니터링 상세 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2014.10.13	kyr		최초 생성
	 * 
	 * author kyr
	 * since 2014.10.13
	 * 
	 * Copyright (C) 2014 by kyr All right reserved.
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
<script type="text/javascript" src="<c:url value='/js/dailywork.js'/>"></script>
<script type="text/javascript">
//<![CDATA[
	function fnList(){
		var menuGubun = $('#menuGubun').val();
		
		if(menuGubun=='app'){
			document.registform.action = "<c:url value='/dailywork/receiveApprovalList.do'/>";
		}else{
			document.registform.action = "<c:url value='/dailywork/dailyWorkList.do?gubun=M'/>";			
		}
		document.registform.submit();
	}
	
	function fnDelete(){
		if(confirm("삭제 하시겠습니까?")){
			document.registform.action = "<c:url value='/dailywork/dailyWorkInfoDelete.do?gubun=M'/>";
			document.registform.submit();
		}
	}
	
	function fnModify(modifyGubun){
		if(confirm("수정 하시겠습니까?")){
			$('#modifyGubun').val(modifyGubun);	
			document.registform.action = "<c:url value='/dailywork/monitoringModify.do'/>";
			document.registform.submit();
		}
	}
	
	function fnPrint(printGubun) {
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 700;
		var winWidth = 800;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-40;
		var height = winHeight-40;
		
		var param = "dailyWorkId=${dailyWorkVO.dailyWorkId}&printGubun="+printGubun;
	
		window.open("<c:url value='/dailywork/dailyWorkPrintView_popup.do'/>?"+encodeURI(param),
		'dailyWorkPrintView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	function fnApp(appGubun){
		var dailyWorkId = $('#dailyWorkId').val();
		var workDay = $('#workDay').val();
		var seq = $('#approvalSeq').val();
		var msg = "";
		
		if(appGubun=='return'){
			msg = "반려"; 
		}else{
			msg = "결재"; 
		}
		if(confirm(msg+" 하시겠습니까?")){
			$('#checkDailyWorkId').val(dailyWorkId+";"+seq+";"+workDay);
			$('#appGubun').val(appGubun);
			
			if(appGubun=='return'){
				document.registform.action = "<c:url value='/dailywork/approvalReturnProc.do'/>"; 
			}else{
				document.registform.action = "<c:url value='/dailywork/approvalProc.do'/>"; 
			}
			document.registform.submit();
		}
	}
	
	function fnSave(){
		if(confirm("결재상신하시겠습니까?")){
			document.registform.action = "<c:url value='/dailywork/insertDailyWorkApproval.do?gubun=M'/>";
			document.registform.submit();
		}
	}
	
	function fnHisList(){
		layerPopCloseAll();
		
		var dailyWorkId = $('#dailyWorkId').val();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/dailywork/getDailyWorkHisInfoList.do'/>",
			data:{dailyWorkId:dailyWorkId
				},
			dataType:"json",
			success:function(result){
				var tot = result['hisInfoList'].length;
				var item = "";
				if(tot>0){
					for(var i=0; i< tot; i++){
						var obj = result['hisInfoList'][i];
						
						item += "<tr>"
							+"<td style='text-align:center;width:120px;'>"+obj.regName+"</td>"
							+"<td style='text-align:center;width:150px;'>"+obj.regDate+"</td>"
							+"</tr>";
					}
					$("#hisInfo").html(item);
				}else{
					$("#hisInfo").html("<tr><td  colspan='2' style='text-align:center;width:150px;'>수정이력이 없습니다.</td></tr>");
				}
			},
	        error:function(result){
					$("#hisInfo").html("<tr><td colspan='2' style='text-align:center'>서버접속 실패</td></tr>");
		        }
		});
		
		layerPopOpen('layerDailyWorkHis');
	}
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("layerDailyWorkHis");
	}
//]]>
</script>
</head>

<body>
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div id="layerFullBgDiv"></div>
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
					<div >
						<span style="text-align:center;"><u><b><h1>조류(Chl-a) 모니터링 일지</h1></b></u></span>
					</div>
					<div style="float:right; ">
						<table style="width:430px;">
							<!-- 
							<colgroup>
							<col width="30px" />
							<col width="120px" />
							<col width="120px" />
							</colgroup>
							<tr>
								<th rowspan="3"  style="height:120px;">결<br/><br/>재</th>
								<td style="height:20px;"><b><c:out value="${approvalList[0].approvalName}"></c:out></b></td>
								<td><b><c:out value="${approvalList[1].approvalName}"></c:out></b></td>
							</tr>
							<tr>
								<td style="height:80px;">
								<c:if test="${not empty approvalList[0].signature_file}">
									<c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
										<c:param name="atchFileId" value="${approvalList[0].signature_file}" />
									</c:import>
								</c:if>
								</td>
								<td>
								<c:if test="${not empty approvalList[1].signature_file}">
									<c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
										<c:param name="atchFileId" value="${approvalList[1].signature_file}" />
									</c:import>
								</c:if>
								</td>
							</tr>
							<tr>
								<td style="height:20px;"><c:out value="${approvalList[0].approvalDate}"></c:out></td>
								<td><c:out value="${approvalList[1].approvalDate}"></c:out></td>
							</tr>
							 -->
							 <colgroup>
							<col width="30px" />
							<col width="120px" />
							<col width="30px" />
							<col width="120px" />
							<col width="120px" />
							</colgroup>
							<tr>
								<th rowspan="3"  style="height:120px;">기<br/>안<br/>자</th>
								<td style="height:20px;"><b><c:out value="${approvalList[0].approvalName}"></c:out></b></td>
								<th rowspan="3"  style="height:120px;">결<br/><br/>재</th>
								<td style="height:20px;"><b><c:out value="${approvalList[1].approvalName}"></c:out></b></td>
								<td><b><c:out value="${approvalList[2].approvalName}"></c:out></b></td>
							</tr>
							<tr>
								<td style="height:80px;">
								<c:if test="${not empty approvalList[0].signature_file}">
									<c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
										<c:param name="atchFileId" value="${approvalList[0].signature_file}" />
									</c:import>
								</c:if>
								</td>
								<td style="height:80px;">
								<c:if test="${not empty approvalList[1].signature_file}">
									<c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
										<c:param name="atchFileId" value="${approvalList[1].signature_file}" />
									</c:import>
								</c:if>
								</td>
								<td>
								<c:if test="${not empty approvalList[2].signature_file}">
									<c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
										<c:param name="atchFileId" value="${approvalList[2].signature_file}" />
									</c:import>
								</c:if>
								</td>
							</tr>
							<tr>
								<td style="height:20px;"><c:out value="${dailyWorkVO.regDate}"></c:out></td>
								<td><c:out value="${approvalList[0].approvalDate}"></c:out></td>
								<td><c:out value="${approvalList[1].approvalDate}"></c:out></td>
							</tr>
						</table>
					</div>	
					<!--tab Contnet Start-->
					<div class="tab_container2">
						<div class="table_wrapper">
							<form name="registform" method="post" onsubmit="return false;">
								<input type="hidden" id="mId" name="mId" value="<c:out value="${monitoringVO.mId}"/>"/>
								<input type="hidden" id="dailyWorkId" name="dailyWorkId" value="<c:out value="${dailyWorkVO.dailyWorkId}"/>"/>
								<input type="hidden" id="menuGubun" name="menuGubun" value="<c:out value="${menuGubun}"/>"/>
								<input type="hidden" id="checkDailyWorkId" name="checkDailyWorkId" />
								<input type="hidden" id="workDay" name="workDay"  value="<c:out value="${dailyWorkVO.workDay}"/>"/> 
								<input type="hidden" id="approvalSeq" name="approvalSeq"  value="<c:out value="${seq}"/>"/>
								<input type="hidden" id="appGubun" name="appGubun"/>
								
								<span style="float:left"><b>1. 일자</b> : <c:out value="${dailyWorkVO.workDay}"></c:out></span>
								<span style="padding-left:30px;float:left"><b>날씨</b> : <c:out value="${monitoringVO.weather}"></c:out></span>
								<br />
								<div style="text-align:left;">
									<span><b></b></span> 
								</div>
								<br />
								<div style="text-align:left;">
									<span><b>2. 수질예측정보</b></span> 
								</div>
								<div>
									<table>
										<colgroup>
											<col width="4%" />
											<col width="8%" />
											<col width="11%" />
											<col width="11%" />
											<col width="11%" />
											<col width="11%" />
											<col width="11%" />
											<col width="11%" />
											<col width="11%" />
										</colgroup>
										<tr>
											<th colspan="2" rowspan="2">구분</th>
											<th colspan="3">한강</th>
											<th colspan="3">금강</th>
											<th colspan="2">영산강</th>
										</tr>
										<tr>
											<th>강천</th>
											<th>여주</th>
											<th>이포</th>
											<th>세종</th>
											<th>공주</th>
											<th>백제</th>
											<th>승촌</th>
											<th>죽산</th>
										</tr>
										<tr>
											<td rowspan="4">예 <p>·</p><p>경</p><p>보</p></td>
											<td>일자</td>
											<td>
												<c:out value="${forecastSList[0].forecastDay}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[1].forecastDay}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[2].forecastDay}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[3].forecastDay}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[4].forecastDay}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[5].forecastDay}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[6].forecastDay}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[7].forecastDay}"></c:out>
											</td>
										</tr>
										<tr>
											<td>현황</td>
											<td>
												<c:out value="${forecastSList[0].forecastStatus}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[1].forecastStatus}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[2].forecastStatus}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[3].forecastStatus}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[4].forecastStatus}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[5].forecastStatus}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[6].forecastStatus}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[7].forecastStatus}"></c:out>
											</td>
										</tr>
										<tr>
											<td>농도</td>
											<td>
												<c:out value="${forecastSList[0].forecastCon}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[1].forecastCon}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[2].forecastCon}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[3].forecastCon}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[4].forecastCon}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[5].forecastCon}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[6].forecastCon}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[7].forecastCon}"></c:out>
											</td>
										</tr>
										<tr>
											<td>남조류</td>
											<td>
												<c:out value="${forecastSList[0].forecastTidal}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[1].forecastTidal}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[2].forecastTidal}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[3].forecastTidal}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[4].forecastTidal}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[5].forecastTidal}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[6].forecastTidal}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[7].forecastTidal}"></c:out>
											</td>
										</tr>
										<tr>
											<td colspan="2">자동</td>
											<td>
												<c:out value="${forecastSList[0].forecastAuto}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[1].forecastAuto}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[2].forecastAuto}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[3].forecastAuto}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[4].forecastAuto}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[5].forecastAuto}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[6].forecastAuto}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[7].forecastAuto}"></c:out>
											</td>
										</tr>
										<tr>
											<th colspan="2" rowspan="2">구분</th>
											<th colspan="8">낙동강</th>
										</tr>
										<tr>
											<th>상주</th>
											<th>낙단</th>
											<th>구미</th>
											<th>칠곡</th>
											<th>강정·고령</th>
											<th>달성</th>
											<th>합청·창녕</th>
											<th>창녕·함안</th>
										</tr>
										<tr>
											<td rowspan="4">예<p>·</p><p>경</p><p>보</p></td>
											<td>일자</td>
											<td>
												<c:out value="${forecastSList[8].forecastDay}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[9].forecastDay}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[10].forecastDay}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[11].forecastDay}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[12].forecastDay}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[13].forecastDay}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[14].forecastDay}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[15].forecastDay}"></c:out>
											</td>
										</tr>
										<tr>
											<td>현황</td>
											<td>
												<c:out value="${forecastSList[8].forecastStatus}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[9].forecastStatus}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[10].forecastStatus}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[11].forecastStatus}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[12].forecastStatus}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[13].forecastStatus}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[14].forecastStatus}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[15].forecastStatus}"></c:out>
											</td>
										</tr>
										<tr>
											<td>농도</td>
											<td>
												<c:out value="${forecastSList[8].forecastCon}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[9].forecastCon}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[10].forecastCon}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[11].forecastCon}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[12].forecastCon}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[13].forecastCon}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[14].forecastCon}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[15].forecastCon}"></c:out>
											</td>
										</tr>
										<tr>
											<td>남조류</td>
											<td>
												<c:out value="${forecastSList[8].forecastTidal}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[9].forecastTidal}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[10].forecastTidal}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[11].forecastTidal}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[12].forecastTidal}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[13].forecastTidal}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[14].forecastTidal}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[15].forecastTidal}"></c:out>
											</td>
										</tr>
										<tr>
											<td colspan="2">자동</td>
											<td>
												<c:out value="${forecastSList[8].forecastAuto}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[9].forecastAuto}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[10].forecastAuto}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[11].forecastAuto}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[12].forecastAuto}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[13].forecastAuto}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[14].forecastAuto}"></c:out>
											</td>
											<td>
												<c:out value="${forecastSList[15].forecastAuto}"></c:out>
											</td>
										</tr>
									</table>
									<div style="text-align:left;">
									<p><span>* 예·경보 : 국립환경과학원 수질통합관리센터 발표자료(관심, 주의, 경계, 심각으로 구분), 단위:chl-a(㎎/㎥)</span></p>
									<span>* 자동자료는 국가수질자동측정망에서 생산한 시간 평균자료(16시) 적용</span>
									</div>
								</div>
								<br />
								<div style="text-align:left;">
									<span><b>3. 조류제거(순찰)지원 등 현황</b></span> 
								</div>
								<div>
									<table>
										<colgroup>
										<col width="100px" />
										<col />
										</colgroup>
										<tr>
											<td colspan="2" style="text-align:left;padding-left:10px;">
												${fn:replace(monitoringVO.supportStatus,newLineChar,'<br/>')}
											</td>
										</tr>
										<tr class="borderNone">
											<th><label for="">파일</label></th>
											<td colspan="8" style="text-align:left;">
												<c:if test="${not empty monitoringVO.atchFileId}">
													<c:import url="/cmmn/selectFileInfs.do" charEncoding="utf-8">
														<c:param name="param_atchFileId" value="${monitoringVO.atchFileId}" />
													</c:import>
												</c:if>
											</td>
										</tr>
									</table>
								</div>
								<br />
								<div style="text-align:left;">
									<span><b>4. 강우현황</b></span> 
								</div>
								<div>
									<table>
										<colgroup>
											<col width="16%" />
											<col width="12%" />
											<col width="12%" />
											<col width="12%" />
											<col width="12%" />
											<col width="12%" />
											<col width="12%" />
											<col width="12%" />
										</colgroup>
										<tr>
											<th rowspan="2">구분</th>
											<th colspan="2">한강</th>
											<th colspan="3">금강</th>
											<th colspan="2">영산강</th>
										</tr>
										<tr>
											<th>여주</th>
											<th>충주</th>
											<th>부여</th>
											<th>공주</th>
											<th>연기</th>
											<th>나주</th>
											<th>광주</th>
										</tr>
										<tr>
											<td>강수량(mm)</td>
											<td><c:out value="${rainFallList[0].rainFall}"></c:out></td>
											<td><c:out value="${rainFallList[1].rainFall}"></c:out></td>
											<td><c:out value="${rainFallList[2].rainFall}"></c:out></td>
											<td><c:out value="${rainFallList[3].rainFall}"></c:out></td>
											<td><c:out value="${rainFallList[4].rainFall}"></c:out></td>
											<td><c:out value="${rainFallList[5].rainFall}"></c:out></td>
											<td><c:out value="${rainFallList[6].rainFall}"></c:out></td>
										</tr>
									</table>
									<br />
									<table>
										<colgroup>
											<col width="16%" />
											<col width="12%" />
											<col width="12%" />
											<col width="12%" />
											<col width="12%" />
											<col width="12%" />
											<col width="12%" />
											<col width="12%" />
										</colgroup>
										<tr>
											<th rowspan="2">구분</th>
											<th colspan="7">낙동강</th>
										</tr>
										<tr>
											<th>부산</th>
											<th>창녕</th>
											<th>합천</th>
											<th>대구</th>
											<th>구미</th>
											<th>안동</th>
											<th>-</th>
										</tr>
										<tr>
											<td>강수량(mm)</td>
											<td><c:out value="${rainFallList[7].rainFall}"></c:out></td>
											<td><c:out value="${rainFallList[8].rainFall}"></c:out></td>
											<td><c:out value="${rainFallList[9].rainFall}"></c:out></td>
											<td><c:out value="${rainFallList[10].rainFall}"></c:out></td>
											<td><c:out value="${rainFallList[11].rainFall}"></c:out></td>
											<td><c:out value="${rainFallList[12].rainFall}"></c:out></td>
											<td>-</td>
										</tr>
									</table>
								</div>
								<br />
								<div>
									<table>
										<colgroup>
											<col width="16%" />
											<col />
										</colgroup>
										<c:forEach var="result" items="${approvalList}" varStatus="status">
							    			<c:if test="${result.approvalComment != null}">
												<tr>
													<th><c:out value="${result.approvalName}"></c:out> 의견</th>
													<td style="text-align:left;padding-left:10px;">
														${fn:replace(result.approvalComment,newLineChar,'<br/>')}
													</td>
												</tr>
											</c:if>
										</c:forEach>
										<c:if test="${menuGubun == 'app'}">
											<c:if test="${appCheck=='Y'}">
											<tr>
												<th>의견</th>
												<td><textarea name="approvalComment" id="approvalComment" rows="2" style="width:98%;"></textarea></td>
											</tr>	
											</c:if>
										</c:if>
									</table>
								</div>
							</form>
							<div style="padding-top:10px;">
								<c:if test="${dailyWorkVO.state == 'F'}">
								<input type="button" id="btnApp" value="인쇄" class="btn btn_basic" style="float:right" alt="인쇄" onclick="javascript:fnPrint('M');"/>
								</c:if>
								<c:if test="${menuGubun == 'dailyWork'}">
									<c:if test="${dailyWorkVO.state == 'S' or dailyWorkVO.state == 'R'}">
										<input type="button" id="btnPrint" value="삭제" class="btn btn_basic" style="float:right" alt="삭제" onclick="javascript:fnDelete();"/>
										<input type="button" id="btnMod" value="수정" class="btn btn_basic" style="float:right" alt="수정" onclick="javascript:fnModify('m');"/>
										<input type="button" id="btnApp" value="결재상신" class="btn btn_basic" style="float:right" alt="결재상신" onclick="javascript:fnSave('app');"/>
									</c:if>
									<input type="button" id="btnList" value="수정이력" class="btn btn_basic" style="float:right" alt="수정이력" onclick="javascript:fnHisList();"/>
									<input type="button" id="btnList" value="목록" class="btn btn_basic" style="float:right" alt="목록" onclick="javascript:fnList();"/>
								</c:if>
								<c:if test="${menuGubun == 'app'}">
									<c:if test="${appCheck=='Y'}">
									<input type="button" id="btnReturn" value="반려" class="btn btn_basic" style="float:right" alt="반려" onclick="javascript:fnApp('return');"/>
									<input type="button" id="btnApp" value="결재" class="btn btn_basic" style="float:right" alt="결재" onclick="javascript:fnApp('app');"/>
									<input type="button" id="btnMod" value="수정" class="btn btn_basic" style="float:right" alt="수정" onclick="javascript:fnModify('a');"/>
									</c:if>
							    	<input type="button" id="btnList" value="목록" class="btn btn_basic" style="float:right" alt="목록" onclick="javascript:fnList();"/>
								</c:if>
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
	<div id="layerDailyWorkHis" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnBranRegXbox" name="btnBranRegXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerDailyWorkHis');" alt="닫기"/>
		</div>
		<table summary="수정이력정보">
			<caption>수정이력정보</caption>
			<colgroup>
				<col width="120px" />
				<col width="150px" />
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th>수정자</th>
					<th>수정일</th>
				</tr>
				<tbody id="hisInfo"></tbody>
			</tbody>
		</table>
	</div>
</body>
</html>