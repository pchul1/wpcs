<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
 /** 
  * @Class Name : EgovFileNmSearch.jsp
  * @Description : 프로그램파일명 검색 화면 (팝업)
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.03.10    이용          최초 생성
  *
  *  @author 공통서비스 개발팀 이용
  *  @since 2009.03.10
  *  @version 1.0
  *  @see
  *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<link href="<c:url value='/css/com.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/content.css' />" rel="stylesheet" type="text/css" />
<link href="<c:url value='/css/popup.css' />" rel="stylesheet" type="text/css" />
<title>프로그램파일명 검색</title>
<script> 
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.progrmManageForm.pageIndex.value = pageNo;
	document.progrmManageForm.action = "<c:url value='/admin/menu/EgovProgramListSearch.do'/>";
   	document.progrmManageForm.submit();
}

/* ********************************************************
 * 조회 처리 함수
 ******************************************************** */ 
function selectProgramListSearch() { 
	document.progrmManageForm.pageIndex.value = 1;
	document.progrmManageForm.action = "<c:url value='/admin/menu/EgovProgramListSearch.do'/>";
	document.progrmManageForm.submit();
}

/* ********************************************************
 * 프로그램목록 선택 처리 함수
 ******************************************************** */ 
function choisProgramListSearch(vFileNm) { 
	eval("opener.document.all."+opener.document.all.tmp_SearchElementName.value).value = vFileNm;
    window.close();
}
-->
</script>
</head>
<body class="subPop"><!-- 추가 및 수정 --> 
<div class="headerWrap"> 
	<div class="headerBg_r"> 
		<div class="header">
			<h1>프로그램 파일명 검색</h1>
		</div> 
	</div> 
</div> 
<div class="contentWrap"> 
	<div class="contentBg_r"> 
		<div class="contentBox"> 
			<div class="contentPad">
				<!-- 내용 --> 
				<div id="managePage">
					<form name="progrmManageForm" action ="javascript:selectProgramListSearch()" method="post">
						<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
				
						<ul class="menuList menuSpacing highIndex">
							<li class="spacing">
								<span class="inputTit">프로그램파일명 :</span> <input name="searchKeyword" type="text" size="30" value=""  maxlength="60" title="검색">
							</li>
							<li>
								<a href="javascript:selectProgramListSearch()" class="btn_mng"><span><em>조회</em></span></a>
							</li>
						</ul>
						<table class="dataTable">
							<colgroup>
								<col width="50%">
								<col>
							</colgroup>
							<thead> 
								<tr>
									<th>프로그램파일명</th> 
									<th>프로그램명</th> 
								</tr> 
							</thead> 
							<tbody>
								<c:forEach var="result" items="${list_progrmmanage}" varStatus="status">
								<tr> 
									<td><a href="javascript:choisProgramListSearch('<c:out value="${result.progrmFileNm}"/>')"><c:out value="${result.progrmFileNm}"/></a></td> 
									<td><c:out value="${result.progrmKoreanNm}"/></td>
								</tr> 
								</c:forEach>
							</tbody>
						</table>
						<ul class="paginate">
							<ui:pagination paginationInfo = "${paginationInfo}"	type="default" jsFunction="linkPage"/>
							<!-- 
							<li><a href="#">이전..</a></li>
							<li><em>1</em></li>
							<li><a href="#" onclick="linkPage(2); return false;">2</a></li>
							<li><a href="#" onclick="linkPage(3); return false;">3</a></li>
							<li><a href="#" onclick="linkPage(4); return false;">4</a></li>
							<li><a href="#" onclick="linkPage(5); return false;">5</a></li>
							<li><a href="#" onclick="linkPage(6); return false;">6</a></li>
							<li><a href="#" onclick="linkPage(7); return false;">7</a></li>
							<li><a href="#">..이후</a></li>
							-->
						</ul>
					</form>
				</div><!-- //managePage -->
			</div>
		</div> 
	</div> 
</div> 
<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div><!-- //추가 및 수정 --> 
</body> 
</html>