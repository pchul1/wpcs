<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	//System.out.println("Left >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
%>
	<div id="snbArea">
<%-- 		<img src="<c:url value='${upperMenuVO.relateImagePath}snb_${upperMenuVO.relateImageName}.gif'/>" alt="${upperMenuVO.menuName}"/> --%>
		<img src="<c:url value='/images/renewal2/snb_${upperMenuVO.relateImageName}.png'/>" alt="${upperMenuVO.menuName}"/>

		<dl id="nav">
			<c:if test="${ not empty leftMenuList}">
				<c:forEach var="result" items="${leftMenuList}" varStatus="status">
					<c:choose>
						<c:when test="${result.selected == 'true'}">
							<c:set var="selected" value="selected"/>
							<c:set var="display" value=""/>
						</c:when>
						<c:otherwise>
							<c:set var="selected" value=""/>
							<c:set var="display" value="hidden"/>
						</c:otherwise>
					</c:choose>
					<dt class="${selected}">
						<!-- 2014-10-22 mypark 방제지원 메뉴얼인 경우 메뉴얼 다운로드 가능하게 수정 -->
						<c:if test="${result.menuNo == '22000'}">
							<a href="#" onClick="javascript:goMenu('${empty result.url ? '#': result.url}','${result.menuNo}')">${result.menuName}</a>
						</c:if>
						<c:if test="${result.menuNo != '22000'}">${result.menuName}</c:if>
					</dt>
					<dd class="${display}">
						<ul>
							<c:forEach var="result2" items="${result.subMenuList}" varStatus="status2">
								<c:choose>
									<c:when test="${result2.menuNo == clickMenu}">
										<c:set var="texton" value="texton"/>
									</c:when>
									<c:otherwise>
										<c:set var="texton" value=""/>
									</c:otherwise>
								</c:choose>
							<li class="${texton}">
								<a href="#" onClick="javascript:goMenu('${empty result2.url ? '#': result2.url}','${empty result2.subMenuNo ? result2.menuNo: result2.subMenuNo}')">${result2.menuName}</a>
							</li>
							</c:forEach>
						</ul>
					</dd>
				</c:forEach>
			</c:if>
		</dl>
		
		<img src="<c:url value='/images/renewal2/snb_bottom.png'/>" alt="바닥 이미지"/>
			
	</div>