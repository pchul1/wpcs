<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
	
					<!--sub title Start-->
					<c:if test="${ not empty naviMenuList}">
						<div id="subTitArea">
							<c:forEach var="result" items="${naviMenuList}" varStatus="status">
								<c:if test="${result.menuNo == naviclickMenu}">
									${result.menuName}
									<input type="hidden" id="naviMenuNo" value="${result.menuNo}" />
									<span><img src="/images/renewal/icon_h.gif" alt="HOME"/>&gt;${result.relatesavepath}</span>
								</c:if>
							</c:forEach>
						</div>
						<!--sub title End-->
						
						<c:if test="${param.isPopup!='Y'}">
						<!--tab menu Start-->
							<ul class="tabs_top">
								<c:forEach var="result" items="${naviMenuList}" varStatus="status">
									<c:choose>
										<c:when test="${result.menuNo == naviclickMenu}">
											<c:set var="on" value="on"/>
										</c:when>
										<c:otherwise>
											<c:set var="on" value=""/>
										</c:otherwise>
									</c:choose>
									<c:if test="${!status.first}">
										<li class="li_space"></li>
									</c:if>
									<li class="${on}" onClick="javascript:goMenu('${empty result.url ? '#': result.url}','${result.menuNo}')">
										<a href="#" onClick="javascript:goMenu('${empty result.url ? '#': result.url}','${result.menuNo}')">${result.menuName}</a>
									</li>
									<c:if test="${!status.last}">
										<li class="li_space"></li>
									</c:if>
								</c:forEach>
							</ul>
						</c:if>
						<!--tab menu End-->
					</c:if>