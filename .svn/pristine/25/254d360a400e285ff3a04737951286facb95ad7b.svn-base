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
<script type="text/javascript">
	function goIpn(fact_code,branch_no){
		document.go_ipn.fact_code.value=fact_code;
		document.go_ipn.branch_no.value=branch_no;
		document.go_ipn.submit();
	}

	function goWater(river_div, sys, branch, time_term, item_code){
		document.go_water.sugye.value=river_div;
		document.go_water.sys.value=sys;
		document.go_water.branch.value=branch;
		document.go_water.time_term.value=time_term;
		document.go_water.item_code.value=item_code;
		document.go_water.submit();
	}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/ipusn/ipusn/ipusnlist.do" name="link"/>
		<jsp:param value="이동형측정기기 위치" name="title"/>
	</jsp:include>
<form name="go_ipn" method="post" action="ipusnmap.do">
	<input type="hidden" name="fact_code"/>
	<input type="hidden" name="branch_no"/>
</form>
<form name="go_water" method="post" action="/mobile/sub/water/waterview.do">
	<input type="hidden" name="sugye"/>
	<input type="hidden" name="sys"/>
	<input type="hidden" name="branch"/>
	<input type="hidden" name="time_term"/>
	<input type="hidden" name="item_code"/>
	<input type="hidden" name="time_type" value="1"/>
</form>
        <div id="ipusn"> 
        	
			<ul class="clearfix kindriver"> 
				<li style='padding:0'><a href="ipusnlist.do"><span class="<c:choose><c:when test='${empty param_s.sugye}'>select_sugye</c:when><c:otherwise>nonselect_sugye</c:otherwise></c:choose>">전체</span></a></li>
				<li style='padding:0'><a href='ipusnlist.do?sugye=R01'><span class='<c:choose><c:when test='${"R01" eq param_s.sugye}'>select_sugye</c:when><c:otherwise>nonselect_sugye</c:otherwise></c:choose>'>한강</a></li> 
				<li style='padding:0'><a href='ipusnlist.do?sugye=R02'><span class='<c:choose><c:when test='${"R02" eq  param_s.sugye}'>select_sugye</c:when><c:otherwise>nonselect_sugye</c:otherwise></c:choose>'>낙동강</a></li>
				<li style='padding:0'><a href='ipusnlist.do?sugye=R03'><span class='<c:choose><c:when test='${"R03" eq  param_s.sugye}'>select_sugye</c:when><c:otherwise>nonselect_sugye</c:otherwise></c:choose>'>금강</a></li>
				<li style='padding:0'><a href='ipusnlist.do?sugye=R04'><span class='<c:choose><c:when test='${"R04" eq  param_s.sugye}'>select_sugye</c:when><c:otherwise>nonselect_sugye</c:otherwise></c:choose>'>영산강</a></li>  
			</ul> 
            <ul class="searchresult">
				<c:forEach var="item" items="${List}">
                <li class="arrow"> 
					<table class="notable" width="100%">
					<tr>
					<td>
						<div class="numb"><a href="<c:url value="ipusnview.do?fact_code=${item.fact_code}&branch_no=${item.branch_no}"/>"><c:out value="${item.branch_name}"/></a><span style="font-size:12px; font-weight:bold; color:#ffffff;">&nbsp;(<c:out value="${pj:SelectIpUsnstr(item.device_st)}"/>)</span></div>
						<div class=""><span class="chim"><c:out value="${item.input_time}"/></span></div>
					</td>
					<td width="125">
						<span class="bbn clearfix">
							<a href="#" onclick="goIpn('<c:out value="${item.fact_code}"/>','<c:out value="${item.branch_no}"/>'); return false;"><span class="aaa"><span>
							</span>
							<c:out value='${pj:SelectIpUsnDistance(item.latitude1, item.longitude1, item.latitude2, item.longitude2, "M", item.gps_dist,"Y")}' escapeXml="false"/>
							</span>
							</a>
							<a href="#" onclick="goWater('<c:out value="${item.river_div}"/>', 'U', '<c:out value="${item.fact_code}"/>:<c:out value="${item.branch_no}"/>', '', ''); return false;"><img src="/images/mobile/view_water_qual.png" alt="" border="0" /></a>
						</span> 
					</td>
					</tr>
					</table>
				</li>  
				</c:forEach>
            </ul> 
        </div> 

</body>
</html>