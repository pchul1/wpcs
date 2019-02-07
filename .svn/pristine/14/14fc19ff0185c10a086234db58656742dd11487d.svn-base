<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : riverMainPrintView.jsp
	 * Description : 4대강주요수계일지(인쇄) 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2014.10.10	kyr			최초생성
	 * 
	 * author kyr
	 * since 2014.10.10
	 * 
	 * Copyright (C) 2010 by k All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>4대강주요수계일지</title>
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
		<span style="text-align:center;font-size: 20px;"><u><b><h1>'4대강 주요수계' 상시감시 결과 일일보고</h1></b></u></span>
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
			</div>
			<br />
			<div style="padding-bottom:10px;padding-top:10px;">
		    <span style="float:left;padding-left:10px;"><b>2. 상시감시 주요결과(방제센터 및 지역본부 방제팀 세부내용)</b></span>
		    </div>
		    <div  style="padding-left:10px;padding-top:10px;">
			<table  class="dataTable5">
				<colgroup>
					<col width="80px" />
					<col width="120px" />
					<col width="110px" />
					<col />
					<col width="120px" />
				</colgroup>
				<tr>
					<th>구분</th>
					<th>감시구간</th>
					<th>감시시간(횟수)</th>
					<th>현장 확인결과 및 조치사항</th>
					<th>특이사항</th>
				</tr>
				<tr>
					<td>수질오염<p>상황팀</p></td>
					<td>4대강 등 <p>주요하천 및 주변</p></td>
					<td>24시간</td>
					<td style="text-align:left;padding-left:10px;">
						<c:out value="${riverMainVO.situationteamContent1}"></c:out>
					</td>
					<td style="text-align:left;padding-left:10px;">
						<c:out value="${riverMainVO.situationteamContent2}"></c:out>
					</td>
				</tr>
				<tr>
					<td>수도권<p>동부</p></td>
					<td>한강<p>(북한강, 남한강)</p></td>
					<td>10:00~17:00<p>(일 1회)</p></td>
					<td style="text-align:left;padding-left:10px;">
						<c:out value="${riverMainVO.capitalAreaContent1}"></c:out>
					</td>
					<td style="text-align:left;padding-left:10px;">
						<c:out value="${riverMainVO.capitalAreaContent2}"></c:out>
					</td>
				</tr>
				<tr>
					<td rowspan="2">경북권</td>
					<td>낙동강(대구청)<p>구미, 상주, 예천</p></td>
					<td>09:30~16:20</td>
					<td style="text-align:left;padding-left:10px;">
						<c:out value="${riverMainVO.gyeongbuk1Content1}"></c:out>
					</td>
					<td style="text-align:left;padding-left:10px;">
						<c:out value="${riverMainVO.gyeongbuk1Content2}"></c:out>
					</td>
				</tr>
				<tr>
					<td>낙동강(낙동강청)<p>창녕, 함안</p></td>
					<td>13:20~18:15</td>
					<td style="text-align:left;padding-left:10px;">
						<c:out value="${riverMainVO.gyeongbuk2Content1}"></c:out>
					</td>
					<td style="text-align:left;padding-left:10px;">
						<c:out value="${riverMainVO.gyeongbuk2Content2}"></c:out>
					</td>
				</tr>
				<tr>
					<td>충청권</td>
					<td>금강<p>서천, 익산, 논산,</p><p>공주, 세종, 옥천</p></td>
					<td>10:00~17:00</td>
					<td style="text-align:left;padding-left:10px;">
						<c:out value="${riverMainVO.chungcheongContent1}"></c:out>
					</td>
					<td style="text-align:left;padding-left:10px;">
						<c:out value="${riverMainVO.chungcheongContent2}"></c:out>
					</td>
				</tr>
				<tr>
					<td>호남권</td>
					<td>영산강<p>극락교, 송촌보,</p><p>죽산보</p></td>
					<td>09:00~17:00<p>(일 1회)</p></td>
					<td style="text-align:left;padding-left:10px;">	
						<c:out value="${riverMainVO.honamContent1}"></c:out>
					</td>
					<td style="text-align:left;padding-left:10px;">
						<c:out value="${riverMainVO.honamContent2}"></c:out>
					</td>
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