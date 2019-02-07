<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<c:choose>
	<c:when test="${no == 1}">
		<c:set var="className" value="noticeBoard"/>
		<c:set var="altName" value="공지사항"/>
	</c:when>
	<c:when test="${no == 3}">
		<c:set var="className" value="faqBoard"/>
		<c:set var="altName" value="FAQ"/>
	</c:when>
	<c:when test="${no == 4}">
		<c:set var="className" value="dataBoard"/>
		<c:set var="altName" value="자료실"/>
	</c:when>
	<c:when test="${no == 5}">
		<c:set var="className" value="waterGallery"/>
		<c:set var="altName" value="수질오염사례 갤러리"/>
	</c:when>
	<c:when test="${no == 6}">
		<c:set var="className" value="preventGallery"/>
		<c:set var="altName" value="방제지원사례 갤러리"/>
	</c:when>
		<c:when test="${no == 7}">
		<c:set var="className" value="videoGallery"/>
		<c:set var="altName" value="동영상 갤러리"/>
	</c:when>
	<c:otherwise>
		<c:set var="className" value="noticeBoard"/>
		<c:set var="altName" value="공지사항"/>
	</c:otherwise>
</c:choose>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=edge"> 
<title>한국환경공단 수질오염 방제정보 시스템</title>
<link rel="stylesheet" type="text/css" href="/css/newFrontCommon.css"/>
<link rel="stylesheet" href="/assets/css/main.css" />
<script type="text/javascript" src="<c:url value='/js/JQuery/jquery-1.3.2.min.js'/>"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript" src="/js/tab.js"></script>
<script type="text/javascript" src="<c:url value='/js/bbs/EgovBBSMng.js' />" ></script>
<script src="/assets/js/jquery.min.js"></script>
<script src="/assets/js/jquery.poptrox.min.js"></script>
<script src="/assets/js/skel.min.js"></script>
<script src="/assets/js/util.js"></script>
<!--[if lte IE 8]><script src="/assets/js/ie/respond.min.js"></script><![endif]-->
<script src="/assets/js/main.js"></script>
<script type="text/javascript">
//<![CDATA[
           
    var currPage = "${paginationInfo.currentPageNo}";
	$(function(){
		$(window).scroll(function() {
		    if ($(window).scrollTop() == $(document).height() - $(window).height()) {
		    	//alert("${paginationInfo.currentPageNo}");
		    	currPage++;
		    	lastPostFunc();
		    }
		});
	});       
           
	function press(event) {
		if (event.keyCode==13) {
			fn_egov_select_noticeList('1');
		}
	}
	
	function fn_egov_select_noticeList(pageNo, galleryNttId) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/bbs/selectBoardList.do'/>";
		document.frm.galleryNttId.value = galleryNttId;
		document.frm.submit();
	}
	
	function fn_egov_inqire_notice(nttId, bbsId) {
		document.frm.nttId.value = nttId;
		document.frm.bbsId.value = bbsId;
		document.frm.action = "<c:url value='/bbs/selectBoardArticle.do'/>";
		document.frm.submit();
	}
	
	// 페이지 번호 클릭
	function linkPage(pageNo){
		reloadData(pageNo);
	}
	
	function lastPostFunc(){ 
		document.frm.pageIndex.value = currPage;
		//document.frm.galleryNttId.value = galleryNttId;
		
		$.ajax({
			type:"post",
			url:"<c:url value='/bbs/selectBoardListAjax.do'/>", 
			cache:false,
			data:$("#frm").serialize(),
			dataType:"json",
			success:function(data) { 
				if (data != "") {  
					var tot = data['resultList'].length;
					var html = "";
					for(var i=0; i < tot; i++){
						var obj = data['resultList'][i];
						
						html+="<article class=\"thumb\">";
						html+="<a style=\"cursor:pointer;background-image:url('/cmmn/getImage.do?atchFileId="+obj.atchFileId+"&fileSn=0&thumbnailFlag=');\" class=\"image\"><img style=\"display:none\" alt=\"수질 오염 방제 갤러리 썸네일 이미지\" src=\"/cmmn/getImage.do?atchFileId="+obj.atchFileId+"&fileSn=0&thumbnailFlag=\"/></a>";
						//html+="<a href=\"/cmmn/getImage.do?atchFileId="+obj.atchFileId+"&fileSn=0&thumbnailFlag=\" class=\"image\"><img alt=\"수질 오염 방제 갤러리 썸네일 이미지\" src=\"/cmmn/getImage.do?atchFileId="+obj.atchFileId+"&fileSn=0&thumbnailFlag=\"/></a>";
						html+="<h2>"+obj.nttSj+"</h2>";
						html+="<p>"+obj.nttCn+"</p>";
						html+="</article>";
					}
			        $("#main").append(html);
		        } 
			},
			error:function() {
				alert("error");
			}
		});     
	};  
//]]>
</script>
</head>
<body>
<!-- wrap -->

<div id="wrap"> 
  
	<!--header -->
	<div class="header_wrap">
		<c:import url="/WEB-INF/jsp/pub/include/client_header.jsp"/>
	</div>
	<!--header --> 
  
	<!--container -->
	<div class="container_wrap">
		<div id="container"> 
		    
			<!--content wrap -->
			<div class="content_wrap">
				<div id="snb">
					<c:import url="/WEB-INF/jsp/pub/include/leftMenu4.jsp"/>
				</div>
				<div class="content">
					<!-- Navi -->
					<p class="spot">홈 &gt; 정보마당 &gt; <span class="point">${altName}</span></p>
					<h3>${altName}</h3>
					<!-- Navi -->
					<div class="section_table02">
						<form name="frm" id="frm" action ="" method="post">
							<input type="hidden" name="bbsId" value="<c:out value='${boardVO.bbsId}'/>" />
							<input type="hidden" name="nttId"  value="0" />
							<input type="hidden" name="bbsTyCode" value="<c:out value='${brdMstrVO.bbsTyCode}'/>" />
							<input type="hidden" name="bbsAttrbCode" value="<c:out value='${brdMstrVO.bbsAttrbCode}'/>" />
							<input type="hidden" name="authFlag" value="<c:out value='${brdMstrVO.authFlag}'/>" />
							<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
							<input type="hidden" name="galleryNttId" value=""/>
							<input type="hidden" name="view" value="pub"/>
							<input type="hidden" name="menu" value="${menu}"/>
							<input type="hidden" name="no" value="${no}"/>
							
							<c:choose>
								<c:when test="${brdMstrVO.bbsAttrbCode == 'BBSA02'}">
									<!-- 갤러리 게시판 -->
									<%-- <div class="content_wrap page_protecttechinfo">
										<div class="inner_techgallery">
											<!-- //현 페이지 경로 -->
											<div class="sec_gallery">
												<div class="photo_list">
													<div class="list">
														<p class="btn_prev">
														
														<c:if test="${searchVO.pageIndex > 1}">
															<a href="#" onclick="javascript:fn_egov_select_noticeList('${searchVO.pageIndex-1}','');return false;">
																<img src="<c:url value='/images/waterpolmnt/btn_prev.gif'/>" title="이전" alt="이전" />
															</a>
														</c:if>
														<c:if test="${searchVO.pageIndex <= 1}">
															<a href="#">
																<img src="<c:url value='/images/waterpolmnt/btn_prev.gif'/>" title="이전" alt="이전" />
															</a>
														</c:if>
														</p>
														<ul>
															<c:forEach var="result" items="${resultList}" varStatus="status">
																
																<c:choose>
																	<c:when test="${result.nttId == galleryBoardVO.nttId}">
																		<c:set var="on" value="on"/>
																	</c:when>
																	<c:otherwise>
																		<c:set var="on" value=""/>
																	</c:otherwise>
																</c:choose>
																
																<li>
																	<a href="#" class="${on}" onclick="javascript:fn_egov_select_noticeList('${searchVO.pageIndex}', '${result.nttId}');return false;">
																		<c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
																			<c:param name="atchFileId" value="${result.atchFileId}" />
																			<c:param name="thumbnailFlag" value="Y" />
																		</c:import>
																	</a>
																</li>
															</c:forEach>
														</ul>
														<p class="btn_next">
														
														<c:if test="${paginationInfo.currentPageNo*paginationInfo.recordCountPerPage < paginationInfo.totalRecordCount}">
															<a href="#" onclick="javascript:fn_egov_select_noticeList('${searchVO.pageIndex+1}','');return false;">
																<img src="<c:url value='/images/waterpolmnt/btn_next.gif'/>" title="다음" alt="다음" />
															</a>
														</c:if>
														<c:if test="${paginationInfo.currentPageNo*paginationInfo.recordCountPerPage >= paginationInfo.totalRecordCount}">
														<a href="#">
															<img src="<c:url value='/images/waterpolmnt/btn_next.gif'/>" title="다음" alt="다음" />
														</a>
														</c:if>
														</p>
													</div>
												</div>
												<div class="header">
													<h7 class="photo_tit"><c:out value="${galleryBoardVO.nttSj}" /></h7>
													<p class="photo_time">[<c:out value="${galleryBoardVO.frstRegisterPnttm}" />] <c:out value="${galleryBoardVO.frstRegisterNm}" /></p>
												</div>
												<div class="photo_img">
													<p class="img">
														<c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
															<c:param name="atchFileId" value="${galleryBoardVO.atchFileId}" />
														</c:import>
													</p>
												</div>
												<p class="photo_con"><c:out value="${galleryBoardVO.nttCn}" escapeXml="false" /></p>
											</div>
										</div>
									</div> --%>
									
									<div id="main">
										<c:forEach var="result" items="${resultList}" varStatus="status">
										<article class="thumb">
											<a href="/cmmn/getImage.do?atchFileId=${result.atchFileId}&fileSn=0" class="image"><c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
															<c:param name="atchFileId" value="${result.atchFileId}" />
														</c:import></a>
											<h2><c:out value="${result.nttSj}" /></h2>
											<p><c:out value="${result.nttCn}" escapeXml="false" /></p>
											<!-- <a href="/images/fulls/01.jpg" class="image"><img src="/images/thumbs/01.jpg" alt="" /></a>
							<h2>Magna feugiat lorem</h2>
							<p>Nunc blandit nisi ligula magna sodales lectus elementum non. Integer id venenatis velit.</p> -->
										</article>
										</c:forEach>
									</div>
								</c:when>

								<c:otherwise>
									<!-- 일반 게시판 -->
										<div class="table_right">
											<p>
											<select name="searchCnd" class="select_box01" title="선택">
												<option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >제목</option>
												<option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >내용</option>
												<option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if> >게시자</option>
											</select>
											<input type="text" name="searchWrd" id="" value='<c:out value="${searchVO.searchWrd}"/>' onkeypress="press(event);" class="search_box01" title="제목"/> 
											<input type="image" src="<c:url value='/images/new/btn_search01.gif'/>" alt ="검색" onclick="javascript:fn_egov_select_noticeList('1');return false;"/>
											</p>
										</div>
										<!-- 글목록 내용 -->
										<table summary="게시판 리스트. 번호, 제목, 게시자, 날짜, 조회, 파일이 담김">
											<caption>${altName }</caption>
											<colgroup>
												<col width="45" />
												<col />
												<col width="100" />
												<col width="100" />
												<col width="45" />
												<col width="45" />
											</colgroup>
											<thead>
												<tr>
													<th class="first" scope="col">번호</th>
													<th scope="col">제목</th>
													<th scope="col">게시자</th>
													<th scope="col">날짜</th>
													<th scope="col">조회</th>
													<th scope="col">파일</th>
												</tr>
											</thead>
											<tbody>
												
											<c:forEach var="result" items="${resultList}" varStatus="status">
											<tr>
												<td>
													<c:out value="${status.count + ((paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage)}"/>
												</td>
												<td class="text_l">
													<c:if test="${result.replyLc!=0}">
														<c:forEach begin="0" end="${result.replyLc}" step="1">
															&nbsp;
														</c:forEach>
														<img src="<c:url value='/images/board/bu_reply.gif'/>" alt="reply arrow" />
													</c:if>
													<c:choose>
														<c:when test="${result.isExpired=='Y' || result.useAt == 'N'}">
															<c:out value="${result.nttSj}" />
														</c:when>
														<c:otherwise>
															<a href="javascript:fn_egov_inqire_notice('<c:out value="${result.nttId}"/>','<c:out value="${result.bbsId}"/>')">
															<c:out value="${result.nttSj}"/></a>
														</c:otherwise>
													</c:choose>
												</td>
												<td><c:out value="${result.frstRegisterNm}"/></td>
												<td><c:out value="${result.frstRegisterPnttm}"/></td>
												<td><c:out value="${result.inqireCo}"/></td>
												<c:if test="${not empty result.atchFileId}">
													<td class="file"><img src="<c:url value='/images/new/ico_file.png'/>" alt="파일" /></td>
												</c:if>
												<c:if test="${empty result.atchFileId}">
													<td class="file">&nbsp;</td>
												</c:if>
											</tr>
											</c:forEach>
											
											<c:if test="${fn:length(resultList) == 0}">
												<tr>
													<td class="listCenter" colspan="6" ><spring:message code="common.nodata.msg" /></td>
												</tr>
											</c:if>
											</tbody>
										</table>
										<!-- 페이징 -->
										<ul class="table_number">
											<li>
											<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_noticeList" />
											</li>
										</ul>
										<!-- //페이징 -->
									<!-- //글목록 내용 -->
								</c:otherwise>
							</c:choose>
						</form>
					</div>
				</div>
			</div>
			<!--content wrap --> 
		    
		</div>
	</div>
	<!--container --> 
  
	<!--footer -->
	<div class="footer_wrap">
		<div id="footer">
			<c:import url="/WEB-INF/jsp/pub/include/client_footer.jsp" />
		</div>
	</div>
	<!--footer --> 
  
</div>
<!-- wrap -->

</body>
</html>