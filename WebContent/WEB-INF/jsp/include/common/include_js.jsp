<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<c:url value='/slickgrid/css/slick.grid.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/slickgrid/css/slick-default-theme.css'/>"/>

<script type="text/javascript" src="<c:url value='/js/JQuery/jquery-1.3.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.datepicker.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/JQuery/plugin/jquery.treeview.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/JQuery/jquery.form.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/JQuery/plugin/jquery.validate.customizing.js'/>"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.8.3.js"></script>
<script type="text/javascript" src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<script type="text/javascript" src="<c:url value='/slickgrid/js/jquery.event.drag-2.2.js'/>"></script>
<script type="text/javascript" src="<c:url value='/slickgrid/js/slick.core.js'/>"></script>
<script type="text/javascript" src="<c:url value='/slickgrid/js/slick.grid_2.2.2.js'/>"></script>
<%-- <script type="text/javascript" src="<c:url value='/slickgrid/js/slick.grid.js'/>"></script> --%>
<script type="text/javascript" src="<c:url value='/slickgrid/js/slick.dataview.js'/>"></script>
<script type="text/javascript" src="<c:url value='/slickgrid/js/slick.rowselectionmodel.js'/>"></script>
<script type="text/javascript" src="<c:url value='/slickgrid/js/slick.checkboxselectcolumn.js'/>"></script>
<script type="text/javascript" src="<c:url value='/slickgrid/js/slick.editors.js'/>"></script>

<!-- <script type="text/javascript" src="http://js.arcgis.com/3.8/"></script> --><!-- 사용시 에러 남 -->
<%-- <script type="text/javascript" src="<c:url value='/gis/js/define.js'/>"></script> --%>
<%-- <script type="text/javascript" src="<c:url value='/gis/js/editMap.js'/>"></script> --%>


<!-- <script> --> 
<%-- // 	var ROOT_PATH = '<c:url value="/"/>'; --%>
<!-- </script> -->

<script type="text/javascript">
	$(document).ready(function(){
		//메시지처리
		<c:if test="${not empty message }">
			alert("${message}");
		</c:if>
	});
</script>

<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
