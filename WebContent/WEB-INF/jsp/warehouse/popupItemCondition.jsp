<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

<title>한국환경공단 수질오염 방제정보 시스템 &gt; 방제장비물품현황 </title>
<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />
</head>
<body>
<h3>[주요 방제장비 및 물품 현황]</h3>
<br/>
<div style="text-align:right">기준일 : ${stdDate }</div>
<br/>
<div style="width:100%">
  <table style="width:40%;float: left">
    <colgroup>
    	<col width="18%">
    	<col width="25%">
    	<col>
    	<col width="18%">
    </colgroup>
    <thead>
    <tr>
      <th rowspan="2" colspan="3" height="63">구 분</th>
      <th rowspan="2">단위</th>
    </tr>
    </thead>
    <tr>
      <td colspan="3">선 박</td>
      <td align="center">대</td>
    </tr>
    <tr>
      <td></td>
      <td colspan="2">수질감시선</td>
      <td align="center">대</td>
    </tr>
    <tr>
      <td></td>
      <td colspan="2">기동방제선</td>
      <td align="center">대</td>
    </tr>
    <tr>
      <td></td>
      <td colspan="2">방제바지선</td>
      <td align="center">대</td>
    </tr>
    <tr>
      <td></td>
      <td colspan="2">보조방제선</td>
      <td align="center">대</td>
    </tr>
    <tr>
      <td></td>
      <td></td>
      <td>FRP선</td>
      <td align="center">대</td>
    </tr>
    <tr>
      <td></td>
      <td></td>
      <td>고무보트(6인)</td>
      <td align="center">대</td>
    </tr>
    <tr>
      <td></td>
      <td></td>
      <td>고무보트(2인)</td>
      <td align="center">대</td>
    </tr>
    <tr>
      <td></td>
      <td></td>
      <td>RIB 보트</td>
      <td align="center">대</td>
    </tr>
    <tr>
      <td></td>
      <td></td>
      <td>알루미늄보트</td>
      <td align="center">대</td>
    </tr>
    <tr>
      <td colspan="3">차 량</td>
      <td align="center">대</td>
    </tr>
    <tr>
      <td></td>
      <td colspan="2">기동방제차량(3.5t)</td>
      <td align="center">대</td>
    </tr>
    <tr>
      <td></td>
      <td colspan="2">방제지원트럭(1t)</td>
      <td align="center">대</td>
    </tr>
    <tr>
      <td></td>
      <td colspan="2">방제장비견인차량</td>
      <td align="center">대</td>
    </tr>
    <tr>
      <td></td>
      <td colspan="2">방제물품트레일러</td>
      <td align="center">대</td>
    </tr>
    <tr>
      <td></td>
      <td colspan="2">전동지게차(2t)</td>
      <td align="center">대</td>
    </tr>
    <tr>
      <td colspan="3">유회수기</td>
      <td align="center">개</td>
    </tr>
    <tr>
      <td></td>
      <td colspan="2">대 형</td>
      <td align="center">개</td>
    </tr>
    <tr>
      <td></td>
      <td colspan="2">소 형</td>
      <td align="center">개</td>
    </tr>
    <tr>
      <td></td>
      <td colspan="2">진공흡입기</td>
      <td align="center">개</td>
    </tr>
    <tr>
      <td colspan="3">드론(멀티콥터)</td>
      <td align="center">대</td>
    </tr>
    <tr>
      <td colspan="3">에어텐트</td>
      <td align="center">개</td>
    </tr>
    <tr>
      <td colspan="3">동력분무기</td>
      <td align="center">개</td>
    </tr>
    <tr>
      <td colspan="3">발전기</td>
      <td align="center">개</td>
    </tr>
    <tr>
      <td colspan="3">오일펜스</td>
      <td align="center">m</td>
    </tr>
    <tr>
      <td colspan="3">일회용작업복</td>
      <td align="center">ea</td>
    </tr>
    <tr>
      <td colspan="3">유처리제</td>
      <td align="center">캔</td>
    </tr>
    <tr>
      <td colspan="3">매트형유흡착재</td>
      <td align="center">Box</td>
    </tr>
    <tr>
      <td colspan="3">롤형유흡착재</td>
      <td align="center">Box</td>
    </tr>
    <tr>
      <td colspan="3">붐형유흡착재</td>
      <td align="center">Box</td>
    </tr>
  </table>
  <table style="width:60%;float: left">
    <colgroup>
    	<col>
    	<col width="16%">
    	<col width="18%">
    	<col width="16%">
    	<col width="16%">
    	<col width="16%">
    </colgroup>
    <thead>
    	<th rowspan="2">합 계</th>
    	<th>총 괄</th>
    	<th>한 강</th>
    	<th>낙동강</th>
    	<th>금 감</th>
    	<th>영산강</th>
    </tr>
    <tr>
    	<th>본 사</th>
    	<th>수도권동부</th>
    	<th>대구경북</th>
    	<th>충청권</th>
    	<th>호남권</th>
    </tr>
    </thead>
    <c:forEach items="${resultList }" var="result">
    <tr align="center">
    	<td><c:if test="${result.total eq '-' }">${result.total }</c:if><c:if test="${result.total ne '-' }"><fmt:formatNumber value="${result.total }" pattern="#,###" /></c:if></td>
    	<td><c:if test="${result.dept1001Cnt eq '-' }">${result.dept1001Cnt }</c:if><c:if test="${result.dept1001Cnt ne '-' }"><fmt:formatNumber value="${result.dept1001Cnt }" pattern="#,###" /></c:if></td>
    	<td><c:if test="${result.dept1002Cnt eq '-' }">${result.dept1002Cnt }</c:if><c:if test="${result.dept1002Cnt ne '-' }"><fmt:formatNumber value="${result.dept1002Cnt }" pattern="#,###" /></c:if></td>
    	<td><c:if test="${result.dept1004Cnt eq '-' }">${result.dept1004Cnt }</c:if><c:if test="${result.dept1004Cnt ne '-' }"><fmt:formatNumber value="${result.dept1004Cnt }" pattern="#,###" /></c:if></td>
    	<td><c:if test="${result.dept1003Cnt eq '-' }">${result.dept1003Cnt }</c:if><c:if test="${result.dept1003Cnt ne '-' }"><fmt:formatNumber value="${result.dept1003Cnt }" pattern="#,###" /></c:if></td>
    	<td><c:if test="${result.dept1005Cnt eq '-' }">${result.dept1005Cnt }</c:if><c:if test="${result.dept1005Cnt ne '-' }"><fmt:formatNumber value="${result.dept1005Cnt }" pattern="#,###" /></c:if></td>
    </tr>
    </c:forEach>
  </table>
</div>
</body>
</html>