<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

<script>
function fn_popup(url){
	var retVal;
	var openParam = "width=650,height=550,resizable=yes,scrollbars=yes";
	retVal = window.open(url,"bbsListPopup", openParam);
}
</script>

<c:choose>
	<c:when test="${view == 'index'}">
		<c:choose>
			<c:when test="${brdMstrVO.bbsAttrbCode == 'BBSA02'}">
				<!-- 갤러리 -->
				<c:if test="${boardVO.bbsId == 'BBSMSTR_000000000020'}">
					<c:set var="clickMenu" value="1640"/>
					<c:set var="no" value="6"/>
				</c:if>
				<c:if test="${boardVO.bbsId == 'BBSMSTR_000000000040'}">
					<c:set var="clickMenu" value="1620"/>
					<c:set var="no" value="5"/>
				</c:if>
				
				<ul>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<li>
						<a href="<c:url value='/bbs/selectBoardList.do'/>?bbsId=${boardVO.bbsId}&galleryNttId=${result.nttId}&clickMenu=${clickMenu}&view=pub&menu=4&no=${no}">
							<c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
								<c:param name="atchFileId" value="${result.atchFileId}" />
								<c:param name="thumbnailFlag" value="Y"/>
							</c:import>
						</a>
					</li>
				</c:forEach>
				</ul>
			</c:when>
			<c:otherwise>
				<!-- 일반 게시판 -->
				<c:if test="${boardVO.bbsId == 'BBSMSTR_000000000030'}">
					<c:set var="no" value="1"/>
				</c:if>
				<c:if test="${boardVO.bbsId == 'BBSMSTR_000000000050'}">
					<c:set var="no" value="3"/>
				</c:if>
				
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<c:if test="${status.count eq 1}">
					<div style="clear: both;padding: 0 8px 8px;">
					</c:if>
					<c:if test="${status.count ne 1}">
					<div style="clear: both;padding: 8px;">
					</c:if>
						<div style="float:left;width:390px;">
							&middot; &nbsp; <a href="<c:url value='/bbs/selectBoardArticle.do'/>?bbsId=${boardVO.bbsId}&nttId=${result.nttId}&view=pub&menu=4&no=${no}">
							<c:if test="${fn:length(result.nttSj) <= 50}">
								<c:out value="${result.nttSj}" />
							</c:if>
							<c:if test="${fn:length(result.nttSj) > 50}">
								<c:out value="${fn:substring(result.nttSj,0,50)}" />..
							</c:if>
							</a>
						</div>
						<div style="float:left;width:150px;text-align:center;">
							<a href="<c:url value='/bbs/selectBoardArticle.do'/>?bbsId=${boardVO.bbsId}&nttId=${result.nttId}&view=pub&menu=4&no=${no}"><c:out value="${result.frstRegisterNm}" /></a>
						</div>
						<div style="float:left;width:140px;text-align: right;">
							<a href="<c:url value='/bbs/selectBoardArticle.do'/>?bbsId=${boardVO.bbsId}&nttId=${result.nttId}&view=pub&menu=4&no=${no}"><span class="num"><c:out value="${result.frstRegisterPnttm}" /></span></a>
						</div>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</c:when>
	
	<c:otherwise>
		<c:choose>
			<c:when test="${brdMstrVO.bbsAttrbCode == 'BBSA02'}">
				<!-- 갤러리 -->
				<c:if test="${boardVO.bbsId == 'BBSMSTR_000000000020'}">
					<c:set var="clickMenu" value="1640"/>
				</c:if>
				<c:if test="${boardVO.bbsId == 'BBSMSTR_000000000040'}">
					<c:set var="clickMenu" value="1620"/>
				</c:if>
				
				<h2><c:out value="${brdMstrVO.bbsNm}"/></h2>
				<ul>
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<li>
							<a href="<c:url value='/bbs/selectBoardList.do'/>?bbsId=${boardVO.bbsId}&galleryNttId=${result.nttId}&clickMenu=${clickMenu}">
								<c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
									<c:param name="atchFileId" value="${result.atchFileId}" />
									<c:param name="thumbnailFlag" value="Y"/>
								</c:import>
							</a>
						</li>
<%-- 						<li><a href="#"><img src="<c:url value='/images/common/@temp_img.gif'/>" alt="" /></a></li> --%>
					</c:forEach>
				</ul>
				<p class="btn">
					<a href="<c:url value='/bbs/selectBoardList.do'/>?bbsId=${boardVO.bbsId}&clickMenu=${clickMenu}">
						<img src="<c:url value='/images/common/btn_more.gif'/>" alt="more" />
					</a>
				</p>
			</c:when>
			<c:otherwise>
				<!-- 일반 게시판 -->
				<h2><c:out value="${brdMstrVO.bbsNm}"/></h2>
				<ul>
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<li>
							<a href="#" onclick="fn_popup('<c:url value='/bbs/selectBoardArticle.do'/>?bbsId=${boardVO.bbsId}&nttId=${result.nttId}&viewFlag=popup');">
								[<c:out value="${result.frstRegisterPnttm}" />]<c:out value="${result.nttSj}" />
							</a> 
						</li>
					</c:forEach>
				</ul>
				<p class="btn">
					<a href="#" onclick="fn_popup('<c:url value='/bbs/selectBoardList.do'/>?bbsId=${boardVO.bbsId}&viewFlag=popup');">
						<img src="<c:url value='/images/common/btn_more.gif'/>" alt="more" />
					</a>
				</p>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>