<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
 /**
  * Class Name : EgovFileList.jsp
  * Description : 파일 목록화면
  * Modification Information
  * 
  * 수정일     		 수정자           	 수정내용
  * -------     --------    ---------------------------
  * 2009.03.26	이삼섭			최초 생성
  *
  * author 공통서비스 개발팀 이삼섭
  * since 2009.03.26
  * version 1.0 
  * see
  *  
  */
%>
<script type="text/javascript">
	function fn_egov_downFile(atchFileId, fileSn){
		window.open("<c:url value='/cmmn/FileDown.do?atchFileId="+atchFileId+"&fileSn="+fileSn+"'/>");
	}	
</script>
      
<table>
	<c:forEach var="fileVO" items="${fileList}" varStatus="status">
		<tr>
			<td>
				<a href="javascript:fn_egov_downFile('<c:out value="${fileVO.atchFileId}"/>','<c:out value="${fileVO.fileSn}"/>')">사진다운로드</a>	       
		 	</td>
		</tr>  
	</c:forEach>
</table>
