<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
  /**
  * @Class Name : alertList.jsp
  * @Description : Alert List 화면
  * @Modification Information
  * 
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  *  2010.05.17             최초 생성
  *
  * author khany
  * since 2010.05.17
  *  
  * Copyright (C) 2010 by khany  All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">


<sec:authorize ifAnyGranted="ROLE_USER">
	<script  type='text/javascript'>
		var user_dept_no = '<sec:authentication property="principal.userVO.deptNo"/>';
	</script> 
</sec:authorize>

<%-- <sec:authorize ifNotGranted="ROLE_USER"> --%>
<!-- 	<script  type='text/javascript'> -->
<!-- 		alert('로그인이 필요한 페이지 입니다'); -->
<%-- 		window.location = "<c:url value='/'/>";  --%>
<!-- 	</script>  -->
<%-- </sec:authorize> --%>


<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content2.css'/>" />
<script src="<c:url value='/js/JQuery/jquery-1.3.2.min.js" type="text/javascript'/>"></script>
<script src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js" type="text/javascript'/>"></script>
<script src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js" type="text/javascript'/>"></script>
<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>

<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.datepicker.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/JQuery/jquery.form.js'/>"></script>
 

<script type='text/javascript'>
//<![CDATA[

           function save()
           {
        	   showLoading();
            	document.upload.action = '/waterpolmnt/waterinfo/uploadExcelData.do';
            	document.upload.submit();
           }


           var isSuccess = "${result}";
           var errorMsg = "${errorMsg}";

           $(function(){

        	   if(isSuccess != null && isSuccess != "")
        	   {
            	   if(isSuccess == 'true')
            	   {
                	   alert("업로드 성공");
            	   }  
            	   else if(isSuccess == 'false')
            	   {
                	   alert("업로드 실패! [" + errorMsg + "]");  
            	   }	   
        	   }
               
           });


           function showLoading()
           {
           	$("#loadingDiv").dialog({
           		modal:true,
           		open:function() 
           		{
           			$("#loadingDiv").css("visibility","visible");
           			$(this).parents(".ui-dialog:first").find(".ui-dialog-titlebar-close").hide();
           			$(this).parents(".ui-dialog:first").find(".ui-dialog-titlebar").hide();
           			$(this).parents(".ui-dialog:first").find(".ui-dialog-resizing").hide();
           			$(this).parents(".ui-dialog:first").find(".ui-dialog-buttonpane").hide();
           			$(this).parents(".ui-dialog:first").find(".ui-dialog-dragging").hide();
           			$(this).parents(".ui-dialog:first").css("width", "120px");
           			$(this).parents(".ui-dialog:first").css("height", "40px");
           			$(this).parents(".ui-dialog:first").css("overflow", "hidden");
           			$("#loadingDiv").css("float", "left");
           		},
           		width:0,
           		height:0,
           	    showCaption:false,
           	    resizable:false
           	});
           	
           	$("#loadingDiv").dialog("open");
           }

           function closeLoading()
           {
           	$("#loadingDiv").dialog("close");
           }
           
//]]>
</script>

</head>
<body class="padding-left:0px;margin-left:0px">
<div id='loadingDiv' style="visibility:hidden;position:absolute;font-size:9pt">
	업로드 중입니다...
</div>
<div id="container" style="padding-left:0px;margin-left:0px">
	<!-- content -->
	<div id="content" class="sub_waterpolmnt" style="margin-left:0px;padding-top:15px;">
		<div class="content_wrap page_waterinfo" style="margin-left:0px;padding-left:0px">
			<div class="inner_riverwater">
				<!-- 하천 수질 조회 -->
				<div class="search_all_wrap" style="width:420px">
					<form:form commandName="excelUpload" name="upload"  id="upload" method="post" enctype="multipart/form-data">		
					<dl>
						<dt><img src="<c:url value='/images/content/tit_search_river.gif'/>" alt="수계" /></dt>
						<dd>
							<select class="fixWidth7"  id="river_div">
								   <option value="R01">한강</option>
								   <option value="R03">금강</option>
								   <option value="R02">낙동강</option>
								   <option value="R04">영산강</option>
							</select>
						</dd>
					</dl>
					<div class="btnInBox">
						<dl>
							<dt></dt>
							<dd>
								<input type="file" size="45" id="excelFile" name="excelFile"/>
							</dd>
						</dl>					
						<p class="btn_search"><a href="javascript:save()"><img src="<c:url value='/images/common/btn_confirm.gif'/>" alt="엑셀저장" /></a></p>
					</div>
						<!-- //수질 조회 현황 -->
			   	 	</form:form>
			    </div>
			</div>
		</div>
	</div><!-- //content -->
</div><!-- //container -->
</body>
</html>