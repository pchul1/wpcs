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
	<jsp:param value="수질현황조회" name="title"/>
</jsp:include>
</head>
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0">
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/water/watersearch.do" name="link"/>
		<jsp:param value="수질현황조회" name="title"/>
	</jsp:include>
		<div id="riverdetail"> 
        	 
			<p class="txt"><c:out value="${condition}" escapeXml="false"/></p>
			<table width="100%">
				<c:if test="${param_s.sys eq 'T'}">
					<tr> 
						<th>측정시간</th>
						<th>탁도</th>
						<th>수온</th>
						<th>pH</th>
						<th>Do</th>
						<th>Ec</th>
					</tr> 	
				</c:if>
				<c:if test="${param_s.sys eq 'U'}">
					<tr> 
						<th>측정시간</th>
						<th>탁도</th>
						<th>수온</th>
						<th>pH</th>
						<th>Do</th>
						<th>Ec</th>
						<th>Chl-a</th>
					</tr> 
				</c:if>
				<!-- 자동측정망 : 일반항목(내부) -->			
				<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'COM1'}">
					<tr> 
						<th>측정시간</th>
						<th>pH</th>
						<th>Do</th>
						<th>Ec</th>
						<th>수온</th>
					</tr> 
				</c:if>			
				<!-- 자동측정망 : 생물독성(물고기) -->			
				<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'BIO1'}">
					<tr> 
						<th>측정시간</th>
						<th>임펄스</th>
					</tr> 
				</c:if>			
				<!-- 자동측정망 : 생물독성(물벼룩1) -->			
				<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'BIO2'}">
					<tr> 
						<th>측정시간</th>
						<th>임펄스(좌)</th>
						<th>임펄스(우)</th>
					</tr> 
				</c:if>			
				<!-- 자동측정망 : 생물독성(물벼룩2) -->			
				<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'BIO3'}">	
					<tr> 
						<th>측정시간</th>
						<th>독성지수(좌)</th>
						<th>독성지수(우)</th>
					</tr> 
				</c:if>			
				<!-- 자동측정망 : 생물독성(미생물) -->		
				<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'BIO4'}">
					<tr> 
						<th>측정시간</th>
						<th>미생물독성지수</th>
					</tr> 
				</c:if>			
				<!-- 자동측정망 : 생물독성(조류) -->
				<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'BIO5'}">
					<tr> 
						<th>측정시간</th>
						<th>조류독성지수</th>
					</tr> 
				</c:if>			
				<!-- 자동측정망 : 클로로필-a -->		
				<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'CHLA'}">		
					<tr> 
						<th>측정시간</th>
						<th>클로로필-a</th>
					</tr> 
				</c:if>			
				<!-- 자동측정망 : 휘발성 유기화합물 -->		
				<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'VOCS'}">
					<tr> 
						<th>측정시간</th>
						<th>염화메틸렌</th>
						<th>1.1.1-트리클로로에테인</th>
						<th>사염화탄소</th>
						<th>벤젠</th>
						<th>트리클로로에틸렌</th>
						<th>톨루엔</th>
						<th>테트라클로로에티렌</th>
						<th>에틸벤젠</th>
						<th>m,p-자일렌</th>
						<th>o-자일렌</th>
						<th>[ECD]염화메틸렌</th>
						<th>[ECD]1.1.1-트리클로로에테인</th>
						<th>[ECD]사염화탄소</th>
						<th>[ECD]트리클로로에틸렌</th>
						<th>[ECD]테트라클로로에티렌</th>
					</tr> 
				</c:if>			
				<!-- 자동측정망 : 중금속 -->		
				<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'METL'}">		
					<tr> 
						<th>측정시간</th>
						<th>카드뮴</th>
						<th>납</th>
						<th>구리</th>
						<th>아연</th>
					</tr> 
				</c:if>			
				<!-- 자동측정망 : 페놀 -->		
				<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'PHEN'}">		
					<tr>
						<th>측정시간</th>
						<th>페놀1</th>
						<th>페놀2</th>
					</tr> 
				</c:if>			
				<!-- 자동측정망 : 페놀 -->			
				<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'ORGA'}">	
					<tr>
						<th>측정시간</th>
						<th>총유기탄소</th>
					</tr> 
				</c:if>			
				<!-- 자동측정망 : 영양염류 -->		
				<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'NUTR'}">	
					<tr>
						<th>측정시간</th>
						<th>총질소</th>
						<th>총인</th>
						<th>암모니아성질소</th>
						<th>질산성질소</th>
						<th>인산염인</th>
					</tr> 
				</c:if>
				<!-- /자동측정망 : 강수량계 -->
				<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'RAIN'}">	
					<tr>
						<th>측정시간</th>
						<th>강수량</th>
					</tr> 
				</c:if>			
				<c:forEach items="${List}" var="item">
				<tr>
					<td><nobr><c:out value="${item.min_time}"/></nobr></td>
					<c:if test="${param_s.sys eq 'T'}">
						<td><c:out value="${pj:SelectWaterListColor(item.tur,item.tur_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.tmp,item.tmp_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.phy,item.phy_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.dow,item.dow_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.con,item.con_or)}" escapeXml="false"/></td>
					</c:if>
					<c:if test="${param_s.sys eq 'U'}">
						<td><c:out value="${pj:SelectWaterListColor(item.tur,item.tur_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.tmp,item.tmp_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.phy,item.phy_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.dow,item.dow_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.con,item.con_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.tof,item.tof_or)}" escapeXml="false"/></td>
					</c:if>
					<!-- 자동측정망 : 일반항목(내부) -->			
					<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'COM1'}">
						<td>
							<c:set var="set_number"  value="2"/>
							<c:choose>
								<c:when test="${!empty item.phy}"><c:set var="set_number"  value="1"/></c:when>
								<c:when test="${empty item.phy && empty item.phy2}"><c:set var="set_number"  value="3"/></c:when>
							</c:choose>
							<c:if test="${set_number eq '1'}"><c:out value="${pj:SelectWaterListColor(item.phy,item.phy_or)}" escapeXml="false"/></c:if>
							<c:if test="${set_number eq '2'}"><c:out value="${pj:SelectWaterListColor(item.phy2,item.phy2_or)}" escapeXml="false"/></c:if>
							<c:if test="${set_number eq '3'}"><c:out value="${pj:SelectWaterListColor(item.phy3,item.phy3_or)}" escapeXml="false"/></c:if>
						</td>
						
						<td>
							<c:set var="set_number"  value="2"/>
							<c:choose>
								<c:when test="${!empty item.dow}"><c:set var="set_number"  value="1"/></c:when>
								<c:when test="${empty item.dow && empty item.dow2}"><c:set var="set_number"  value="3"/></c:when>
							</c:choose>
							<c:if test="${set_number eq '1'}"><c:out value="${pj:SelectWaterListColor(item.dow,item.dow_or)}" escapeXml="false"/></c:if>
							<c:if test="${set_number eq '2'}"><c:out value="${pj:SelectWaterListColor(item.dow2,item.dow2_or)}" escapeXml="false"/></c:if>
							<c:if test="${set_number eq '3'}"><c:out value="${pj:SelectWaterListColor(item.dow3,item.dow3_or)}" escapeXml="false"/></c:if>
						</td>
						
						<td>
							<c:set var="set_number"  value="2"/>
							<c:choose>
								<c:when test="${!empty item.con}"><c:set var="set_number"  value="1"/></c:when>
								<c:when test="${empty item.con && empty item.con2}"><c:set var="set_number"  value="3"/></c:when>
							</c:choose>
							<c:if test="${set_number eq '1'}"><c:out value="${pj:SelectWaterListColor(item.con,item.con_or)}" escapeXml="false"/></c:if>
							<c:if test="${set_number eq '2'}"><c:out value="${pj:SelectWaterListColor(item.con2,item.con2_or)}" escapeXml="false"/></c:if>
							<c:if test="${set_number eq '3'}"><c:out value="${pj:SelectWaterListColor(item.con3,item.con3_or)}" escapeXml="false"/></c:if>
						</td>
						
						<td>
							<c:set var="set_number"  value="2"/>
							<c:choose>
								<c:when test="${!empty item.tmp}"><c:set var="set_number"  value="1"/></c:when>
								<c:when test="${empty item.tmp && empty item.tmp2}"><c:set var="set_number"  value="3"/></c:when>
							</c:choose>
							<c:if test="${set_number eq '1'}"><c:out value="${pj:SelectWaterListColor(item.tmp,item.tmp_or)}" escapeXml="false"/></c:if>
							<c:if test="${set_number eq '2'}"><c:out value="${pj:SelectWaterListColor(item.tmp2,item.tmp2_or)}" escapeXml="false"/></c:if>
							<c:if test="${set_number eq '3'}"><c:out value="${pj:SelectWaterListColor(item.tmp3,item.tmp3_or)}" escapeXml="false"/></c:if>
						</td>
					</c:if>			
					<!-- 자동측정망 : 생물독성(물고기) -->			
					<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'BIO1'}">
						<td><c:out value="${pj:SelectWaterListColor(item.imp,item.imp_or)}" escapeXml="false"/></td>
					</c:if>			
					<!-- 자동측정망 : 생물독성(물벼룩1) -->			
					<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'BIO2'}">
						<td><c:out value="${pj:SelectWaterListColor(item.lim,item.lim_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.rim,item.rim_or)}" escapeXml="false"/></td>
					</c:if>			
					<!-- 자동측정망 : 생물독성(물벼룩2) -->			
					<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'BIO3'}">
						<td><c:out value="${pj:SelectWaterListColor(item.ltx,item.ltx_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.rtx,item.rtx_or)}" escapeXml="false"/></td>
					</c:if>			
					<!-- 자동측정망 : 생물독성(미생물) -->		
					<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'BIO4'}">
						<td><c:out value="${pj:SelectWaterListColor(item.tox,item.tox_or)}" escapeXml="false"/></td>
					</c:if>			
					<!-- 자동측정망 : 생물독성(조류) -->
					<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'BIO5'}">
						<td><c:out value="${pj:SelectWaterListColor(item.evn,item.evn_or)}" escapeXml="false"/></td>
					</c:if>			
					<!-- 자동측정망 : 클로로필-a -->		
					<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'CHLA'}">
						<td><c:out value="${pj:SelectWaterListColor(item.tof,item.tof_or)}" escapeXml="false"/></td>
					</c:if>			
					<!-- 자동측정망 : 휘발성 유기화합물 -->		
					<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'VOCS'}">
						<td><c:out value="${pj:SelectWaterListColor(item.voc1,item.voc1_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.voc2,item.voc2_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.voc3,item.voc3_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.voc4,item.voc4_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.voc5,item.voc5_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.voc6,item.voc6_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.voc7,item.voc7_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.voc8,item.voc8_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.voc9,item.voc9_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.voc10,item.voc10_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.voc11,item.voc11_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.voc12,item.voc12_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.voc13,item.voc13_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.voc14,item.voc14_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.voc15,item.voc15_or)}" escapeXml="false"/></td>
					</c:if>			
					<!-- 자동측정망 : 중금속 -->		
					<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'METL'}">
						<td><c:out value="${pj:SelectWaterListColor(item.cad,item.cad_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.plu,item.plu_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.cop,item.cop_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.zin,item.zin_or)}" escapeXml="false"/></td>
					</c:if>			
					<!-- 자동측정망 : 페놀 -->		
					<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'PHEN'}">
						<td><c:out value="${pj:SelectWaterListColor(item.phe,item.phe_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.phl,item.phl_or)}" escapeXml="false"/></td>
					</c:if>			
					<!-- 자동측정망 : 페놀 -->			
					<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'ORGA'}">
						<td><c:out value="${pj:SelectWaterListColor(item.toc,item.toc_or)}" escapeXml="false"/></td>
					</c:if>			
					<!-- 자동측정망 : 영양염류 -->		
					<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'NUTR'}">
						<td><c:out value="${pj:SelectWaterListColor(item.ton,item.ton_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.top,item.top_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.nh4,item.nh4_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.no3,item.no3_or)}" escapeXml="false"/></td>
						<td><c:out value="${pj:SelectWaterListColor(item.po4,item.po4_or)}" escapeXml="false"/></td>
					</c:if>			
					<!-- /자동측정망 : 강수량계 -->
					<c:if test="${param_s.sys eq 'A' && param_s.auto eq 'RAIN'}">
						<td><c:out value="${pj:SelectWaterListColor(item.rin,item.rin_or)}" escapeXml="false"/></td>
					</c:if>
				</tr>
				</c:forEach>
			</table> 
        </div>         
</body>
</html>