<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : list.jsp
	 * Description : 사고지점정보 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2013.10.20	lkh			리뉴얼
	 * 
	 * author khany
	 * since 2013.10.20
	 * 
	 * Copyright (C) 2013 by lkh All right reserved.
	 */
%>
<%
String sURL = "/psupport/TMS_POP.jsp?menuID="+(String)request.getSession().getAttribute("clickMenu");
String menuID = (String)request.getSession().getAttribute("clickMenu");
// menuID = (String)request.getAttribute("menuID");
//$('#mapFrame').attr('src', '/psupport/TMS_Manage.html?menuID=${menuID} }'))
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />

<link rel="stylesheet" type="text/css" href="<c:url value='/gis/css/gis_style.css'/>"/>
<link rel="stylesheet" href="http://js.arcgis.com/3.8/js/dojo/dijit/themes/claro/claro.css">
<link rel="stylesheet" href="http://js.arcgis.com/3.8/js/esri/css/esri.css">
<script type="text/javascript" src="/gis/gis/jsapi_vsdoc10_v36.js"></script>

<script src="http://js.arcgis.com/3.8/"></script>

<script src="/gis/js/xml2json.js"></script>
<script src="/gis/js/common.js"></script>
<script src="/gis/js/kecoMap.js"></script>
<script src="/gis/js/list.js"></script>

<script type="text/javascript">
	var MENU_ID = request.getParameter('menuID');
	
// 	function ps_accident_popup(){
// 		var sw=screen.width;
// 		var sh=screen.height;
// 		var winHeight = 890;
// 		var winWidth = 1260;
// 		var winLeftPost = (sw - winWidth) / 2;
// 		var winTopPost = 0;
// 		var width = winWidth-20;
// 		var height = winHeight-20;
		
// 		window.open("/psupport/TMS_POP.jsp?menuID=5110", 
// 				'psView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
// 	}
	
// 	function ps_ipusn_popup(){
// 		var sw=screen.width;
// 		var sh=screen.height;
// 		var winHeight = 890;
// 		var winWidth = 1260;
// 		var winLeftPost = (sw - winWidth) / 2;
// 		var winTopPost = 0;
// 		var width = winWidth-20;
// 		var height = winHeight-20;
		
// 		window.open("/psupport/TMS_POP.jsp?menuID=5120", 
// 				'psView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
// 	}
	
// 	function ps_sphone_popup(){
// 		var sw=screen.width;
// 		var sh=screen.height;
// 		var winHeight = 890;
// 		var winWidth = 1260;
// 		var winLeftPost = (sw - winWidth) / 2;
// 		var winTopPost = 0;
// 		var width = winWidth-20;
// 		var height = winHeight-20;
		
// 		window.open("/psupport/TMS_POP.jsp?menuID=5130", 
// 				'psView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
// 	}
	
	function popupOpen(){
		window.open("/psupport/TMS_POP.jsp?riverid="+user_riverid, 
				'psView','width='+window.screen.width+',height='+window.screen.height+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left=0,top=0');
	}
	
	$(window).load(function(){
		popupOpen();
	});
</script>
</head>

<body>
	<div id="wrap">
		<!-- Head Start-->
		<div id="header">
			<c:import url="/common/menu/header.do" />
		</div>
		<!-- Head End-->
		
		<!-- Body Start-->
		<div id="container">
			<div id="content_wrapper">
				
				<!--left menu Start-->
				<c:import url="/common/menu/left.do" />
				<!--left menu End-->
				
				<!-- Content Start-->
				<div id="content">
					
					<!-- navi, tab menu Start-->
					<c:import url="/common/menu/navi.do" />
					<!-- navi, tab menu End-->
					
					<!--tab Contnet Start-->
					<div class="tab_container">
						<div class="mapBx" style=height:600px;>
							<div id="map" class="claro" style="width:100%; height:100%; border:1px solid #000; position:relative;">
								<div id="tool" style="right:1px; top:10px; position:absolute; width:100px; height:24px; z-index:10;">
									<div class="tool_bu1"><a href="javascript:$kecoMap.model.generalMap();" onMouseOut="$kecoMap.controller.MM_swapImgRestore('Image1','/gis/images/tool_1_off.gif')" onMouseOver="$kecoMap.controller.MM_swapImage('Image1','/gis/images/tool_1_over1.gif',1)" ><img idx="0" src="/gis/images/tool_1_over1.gif" id="Image1" width="42" height="24" border="0"></a></div>
									<div class="tool_bu1"><a href="javascript:$kecoMap.model.flightMap();" onMouseOut="$kecoMap.controller.MM_swapImgRestore('Image2','/gis/images/tool_2_off.gif')" onMouseOver="$kecoMap.controller.MM_swapImage('Image2','/gis/images/tool_2_over1.gif',1)" ><img idx="1" src="/gis/images/tool_2_off.gif" id="Image2" width="42" height="24" border="0"></a></div>
<!-- 									<div class="tool_bu2"><a href="javascript:showLayerDiv();" onmouseout="$kecoMap.controller.MM_swapImgRestore('Image3','/gis/images/btn_smapLegend_off.png')" onMouseOver="$kecoMap.controller.MM_swapImage('Image3','/gis/images/btn_smapLegend_over.png',1)" ><img idx="3" src="/gis/images/btn_smapLegend_off.png" id="Image3" border="0" /></a></div> -->
<!-- 									<input type="button" name="" value="기초시설물" class="smapLegend" onclick="javascript:showLayerDiv()"/> -->
<!-- 									<div class="tool_bu1"><a href="javascript:showLayerDiv()" onMouseOut="$kecoMap.controller.MM_swapImgRestore('Image2','/gis/images/tool_2_off.gif')" onMouseOver="$kecoMap.controller.MM_swapImage('Image2','/gis/images/tool_2_over1.gif',1)" ><img idx="1" src="/gis/images/tool_2_off.gif" id="Image2" width="42" height="24" border="0"></a></div> -->
								</div>
							</div>
						</div>
					</div>
					<!--tab Contnet End-->
				</div>
				<!-- Content End-->
			</div>
		</div>
		<!-- Body End-->
		
		<!-- Footer Start-->
		<div id="footer">
			<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
		<!-- Footer End-->
	</div>
</body>
</html>