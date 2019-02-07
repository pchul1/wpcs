<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="pj" uri="ProjectJstlUtil"%>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="이동형측정기기 위치" name="title"/>
</jsp:include>

<script>
function goModify() {
	var f = document.forms['form1'];
	if(confirm("저장하시겠습니까?")) f.submit();
	return;
}
</script>
</head>
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0">
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/ipusn/ipusn/ipusnlist.do" name="link"/>
		<jsp:param value="이동형측정기기 위치" name="title"/>
	</jsp:include>
<form name="form1" method="post" action="/mobile/sub/ipusn/ipusn/UpdateIpUsnDeviceStatus.do">
<input type="hidden" name="fact_code" id="fact_code" value="<c:out value="${param_s.fact_code}"/>"/>
<input type="hidden" name="branch_no" id="branch_no" value="<c:out value="${param_s.branch_no}"/>"/>
<div>
	
	<div class="manageview"> 
		<table width="100%"> 
		<colgroup> 
			<col width="30%" /> 
			<col width="65%" /> 
		</colgroup> 
		<tr> 
			<th>측정소명</th> 
			<td><c:out value="${View.branch_name}"/></td>
		</tr> 
		<tr> 
			<th>측정소총명</th>
			<td><c:out value="${View.branch_fname}"/></td>
		</tr> 
		<tr> 
			<th>지점코드</th>
			<td><c:out value="${View.fact_code}"/></td>
		</tr> 
		<tr> 
			<th>측정소번호</th>
			<td><c:out value="${View.branch_no}"/></td>
		</tr> 
		<tr> 
			<th>담당자전화번호</th>
			<td><a href='<c:url value="tel:${View.branch_mgr_tel_no}"/>'><c:out value="${View.branch_mgr_tel_no}"/></a></td> 
		</tr> 
		<tr> 
			<th>측정소 IP</th>
			<td><c:out value="${View.branch_ip}"/></td>
		</tr> 
		<tr> 
			<th>측정소 PORT</th>
			<td><c:out value="${View.branch_port}"/></td>
		</tr> 
		<tr> 
			<th>위도</th>
			<td><c:out value="${View.latitude}"/></td>
		</tr> 
		<tr> 
			<th>경도</th>
			<td><c:out value="${View.longitude}"/></td>
		</tr> 
		<tr> 
			<th>IPUSN_CDMA</th>
			<td><c:out value="${View.cdma_group}"/></td>
		</tr> 
		<tr> 
			<th>IPUSN_CDMA_TEL</th>
			<td><c:out value="${View.cdma_tel_no}"/></td>
		</tr> 
		<tr> 
			<th>GPS오차허용범위</th>
			<td><c:out value="${View.gps_dist}"/></td>
		</tr> 
		<tr>
			<th>상태</th>
			<td>
				<select name="device_st">
					<option value="OK" ${(View.device_st eq "OK") ? "selected" : ""}>정상</option>
					<option value="A0" ${(View.device_st eq "A0") ? "selected" : ""}>전원이상 - 메인전원</option>
					<option value="B0" ${(View.device_st eq "B0") ? "selected" : ""}>점검/보수중 - 측정기기 보수</option>
					<option value="B1" ${(View.device_st eq "B1") ? "selected" : ""}>점검/보수중 - 측정기기 부품 교환(센서, 기타)</option>
					<option value="B2" ${(View.device_st eq "B2") ? "selected" : ""}>점검/보수중 - 측정기기 부품 교환</option>
					<option value="B3" ${(View.device_st eq "B3") ? "selected" : ""}>점검/보수중 - 측정기기 Overhaul cleaning</option>
					<option value="B4" ${(View.device_st eq "B4") ? "selected" : ""}>점검/보수중 - 측정기기 점검(정기, 수시)</option>
					<option value="B5" ${(View.device_st eq "B5") ? "selected" : ""}>점검/보수중 - 전송장비 점검/보수</option>
					<option value="C0" ${(View.device_st eq "C0") ? "selected" : ""}>장비이상 - 측정기기 이상</option>
					<option value="E1" ${(View.device_st eq "E1") ? "selected" : ""}>교정중 - 수동 교정</option>
					<option value="E2" ${(View.device_st eq "E2") ? "selected" : ""}>교정중 - 정도 관리</option>
					<option value="F0" ${(View.device_st eq "F0") ? "selected" : ""}>시운전 - 시운전</option>
					<option value="G0" ${(View.device_st eq "G0") ? "selected" : ""}>가동중지 - 가동중지(측정기)</option>
					<option value="Z9" ${(View.device_st eq "Z9") ? "selected" : ""}>영구중단</option>
				</select>
			</td>
		</tr>
		</table> 
	</div> 

	<table width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td style="width:33%">
			<ul class="sbtn" style="width:100%;">
				<li style="width:90%;"><a href="ipusnlist.do">목록</a></li> 
			</ul>
		</td>
		<td style="width:33%">
			<ul class="sbtn" style="width:100%;">
				<li style="width:90%;"><a href='<c:url value="ipusnmap.do?fact_code=${param_s.fact_code}&branch_no=${param_s.branch_no}"/>'>지도보기</a></li> 
			</ul>
		</td>
		<td style="width:33%">
			<ul class="sbtn" style="width:100%;">
				<li style="width:90%;"><a href="#" onclick="goModify(); return false;">저장</a></li> 
			</ul>
		</td>
	</tr>
	</table>
	
</div> 
</form>

</body>
</html>