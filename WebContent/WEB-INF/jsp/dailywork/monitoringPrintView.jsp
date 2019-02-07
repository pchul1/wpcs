<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<%
	/**
	 * Class Name : monitoringPrintView.jsp
	 * Description : 주요모니터링(인쇄) 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2014.10.13	kyr			최초생성
	 * 
	 * author kyr
	 * since 2014.10.13
	 * 
	 * Copyright (C) 2010 by k All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>주요모니터링</title>
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />
	<script src="<c:url value='/js/JQuery/jquery-1.3.2.min.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js" type="text/javascript'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>
	<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/jquery.form.js'/>"></script>
	<script type="text/javascript">
		function fnPrint(){
			$('#btnPrint').hide();
			window.print();
			window.close();
		}
	</script>
</head>

<body class="pop_basic" style="overflow-X:hidden">
	<div style="margin-top:20px; margin-bottom:20px;">
		<span style="text-align:center;font-size: 20px;"><u><b><h1>조류(Chl-a) 모니터링 일지</h1></b></u></span>
		<div style="float:right;padding-left:500px;padding-right:16px; padding-top:20px;">
			<table class="dataTable4">
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
					<td style="height:80px;"></td>
					<td></td>
				</tr>
				<tr>
					<td style="height:20px;"><c:out value="${approvalList[0].approvalDate}"></c:out></td>
					<td><c:out value="${approvalList[1].approvalDate}"></c:out></td>
				</tr>
			</table>
		</div>
		<div style="margin-top:160px;">
			<div style="padding-bottom:10px;"> 
				<span style="float:left;padding-left:10px;"><b>1. 일자</b> : <c:out value="${dailyWorkVO.workDay}"></c:out></span>
				<span style="padding-left:30px;float:left"><b>날씨</b> : <c:out value="${monitoringVO.weather}"></c:out></span>
			</div>
			<br />
			<div style="padding-bottom:10px;padding-top:10px;">
		    <span style="float:left;padding-left:10px;"><b>2. 수질예측정보</b></span>
		    </div>
		    <div  style="padding-left:10px;padding-top:10px;">
			<table  class="dataTable5">
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
			<div style="text-align:left;padding-top:5px;">
				<p><span>* 예·경보 : 국립환경과학원 수질통합관리센터 발표자료(관심, 주의, 경계, 심각으로 구분), 단위:chl-a(㎎/㎥)</span></p>
				<span>* 자동자료는 국가수질자동측정망에서 생산한 시간 평균자료(16시) 적용</span>
			</div>
		</div>
		
		<div style="padding-bottom:10px;padding-top:10px;">
		    <span style="float:left;padding-left:10px;"><b>3. 조류제거(순찰)지원 등 현황</b></span>
		</div>
		<div  style="padding-left:10px;padding-top:10px;">
			<table  class="dataTable5">
				<colgroup>
					<col width="100px" />
					<col />
				</colgroup>
				<tr>
					<td colspan="2" style="text-align:left;padding-left:10px;">
						${fn:replace(monitoringVO.supportStatus,newLineChar,'<br/>')}
					</td>
				</tr>
				<c:if test="${not empty monitoringVO.atchFileId}">
				<tr>
					<th><label for="">파일</label></th>
					<td style="text-align:left;">
						<c:import url="/cmmn/selectFileInfs.do" charEncoding="utf-8">
							<c:param name="param_atchFileId" value="${monitoringVO.atchFileId}" />
						</c:import>
					</td>
				</tr>
				</c:if>
			</table>
		</div>
		<div style="padding-bottom:10px;padding-top:10px;">
		    <span style="float:left;padding-left:10px;"><b>4. 강우현황</b></span>
		    </div>
		    <div  style="padding-left:10px;padding-top:10px;">
			<table  class="dataTable5">
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
			<table  class="dataTable5">
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
		</div>
		<div style="float:right;padding-right:15px;padding-top:10px;">
		<p>
			<input type="button" id="btnPrint" value="인쇄" class="btn btn_basic" style="float:right" alt="인쇄" onclick="javascript:fnPrint();"/>
		</p>
		</div>
		<br />
	</div>
</body>
</html>