<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : rdView.jsp
	 * Description : 상황발생이력 리포트 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2010.05.20	k			최초 생성
	 * 2015.05.27	lkh			리뉴얼
	 * 
	 * author k
	 * since 2010.05.20
	 * 
	 * Copyright (C) 2010 by k All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
</head>
<body leftmargin="0" topmargin="0" _onLoad="javascript:rdOpen()" padding="0">
<script src="<c:url value='/js/rdviewer.js'/>"></script>
<script>
	function rdOpen(){
		// 리얼용 연동되면 쓰삼
		//var rdServerUrl = "http://www.watertms.or.kr/RDServer/rdagent.jsp"; 
		var rdServerUrl = "http://www.watertms.or.kr/twtms/RDServer/rdagent.jsp"; //서버 아이피
		//rdviewer.FileOpen ("C:/workspaces/wpcs/src/main/webapp/rdf/viewer.rdf", "");
		var param = '${paramData}';
	//	alert("param : "+param);
		
		var mrdUrl = "<%=request.getRequestURL().toString().replaceAll(request.getRequestURI(), "")%><c:url value='/rdf/${mrdpath}.mrd'/>";
// 		var mrdUrl = "/rdf/completeRpt.mrq";
		
		param = param + " /rcontype [RDAGENT] /rf ["+rdServerUrl+"] /rsn [wpcs_taksu]";
		
		Rdviewer.SetBackgroundColor(255,255,255);
		Rdviewer.SetPageLineColor(255,255,255);
		Rdviewer.SetPageColor(255,255,255);
		
		Rdviewer.AutoAdjust=0;
		Rdviewer.ApplyLicense(rdServerUrl);
		Rdviewer.FileOpen(mrdUrl,param);
		
	}
	
	$(function() {
		rdOpen();
	});
</script>
</body>
</html>