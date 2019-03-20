<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/** 
	 * Class Name : addrMap.jsp
	 * Description : 좌표를 찾는 지도(도로명주소 포함)
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2014.03.20	choi		최초 생성
	 * 
	 * author choi
	 * since 2014.03.20
	 *
	 * Copyright (C) 2014 by choi  All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no" />

<link type="text/css" rel="stylesheet" href="<c:url value='/css/content.css' />" />
<link type="text/css" rel="stylesheet" href="<c:url value='/css/com.css' />" />
<link type="text/css" rel="stylesheet" href="<c:url value='/css/popup.css' />" />

<link type="text/css" rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<link type="text/css" rel="stylesheet" href="/gis/css/common.css" />
<link type="text/css" rel="stylesheet" href="/gis/css/gis_bj.css" />
<link type="text/css" rel="stylesheet" href="http://js.arcgis.com/3.8/js/dojo/dijit/themes/claro/claro.css" />
<link type="text/css" rel="stylesheet" href="http://js.arcgis.com/3.8/js/esri/css/esri.css" />

<title>좌표지정</title>
<script type='text/javascript'>
	var user_riverid = 'null';
	
</script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="/js/JQuery/css/ui.all.css" />
<script type="text/javascript" src="/js/mobile/jquery-ui-1.9.1.min.js"></script>

<script type="text/javascript" src="/gis/js/organictabs.jquery.js"></script>
<script type="text/javascript" src="/gis/js/acco.js"></script>
<!-- <script type="text/javascript" src="/gis/js/UI.js"></script> -->

<script type="text/javascript" src="/js/JQuery/ui/ui.datepicker.js"></script>

<script type="text/javascript" src="/gis/gis/jsapi_vsdoc10_v36.js"></script>
<script type="text/javascript" src="/gis/js/jquery.dialog.custom.js"></script>
<!-- <script type="text/javascript" src="http://js.arcgis.com/3.8/"></script> -->

<script type="text/javascript" src="/gis/js/xml2json.js"></script>
<script type="text/javascript" src="/gis/js/define.js"></script>
<script type="text/javascript" src="/gis/js/common.js"></script>
<!-- <script type="text/javascript" src="/gis/js/kecoMap.js"></script> -->
<script type="text/javascript" src="/gis/js/control.js"></script>


<script type="text/javascript" src="/gis/new_js/lib/proj4.js" ></script>
<script type="text/javascript" src="/gis/new_js/lib/mapEventBus.js" ></script>
<script type="text/javascript" src="http://tsauerwein.github.io/ol3/mapbox-gl-js/build/ol.js"></script>
<script type="text/javascript" src="/gis/new_js/mapService.js"></script>
<script type="text/javascript" src="/gis/new_js/lib/vworldLayer.js"></script>
<script type="text/javascript" src="/gis/new_js/lib/coreMap.js"></script>

<!-- 실서버-->
<!-- <SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=3728760A-A99F-39F6-96C8-74746BA4A738"></SCRIPT>	 -->
<!--  ????  -->
<!-- <SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=C4246B58-A669-3643-A7FD-F545A61ECE20"></SCRIPT>    -->
<!-- 210.99.81.159:9090-->
<!-- <SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=4EA77A23-29BC-37C9-A4EE-D3BCABCD9846"></SCRIPT> -->
<script language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=C4246B58-A669-3643-A7FD-F545A61ECE20"></script>
<script language="javascript" type="text/javascript" src="/js/mobile/Vworld.js"></script>
</head>
<body class="subPop"><!-- 추가 및 수정 -->
	<div class="headerWrap">
		<div class="headerBg_r">
			<div class="header">
				<h1>주소 또는 좌표를 입력해주세요</h1>
			</div>
		</div>
	</div>
	<div class="contentWrap">
		<div class="contentBg_r">
			<div class="contentBox">
				<div class="contentPad">
					<!-- 내용 -->
					<div id="managePage">
						<ul class="menuSpacing highIndex">
							<li class="spacing">
								<select id="type" name="type" >
									<option value="3" >좌표 -> 지번</option>
									<option value="4" >좌표 -> 도로명</option>
									<option value="1" >지번 -> 좌표</option>
									<option value="2" >도로명 -> 좌표</option>
								</select>
								위도(Y) : <input id="y" type="text" value="" style="width:140px; padding:2px 0 3px 5px;" />
								경도(X) : <input id="x" type="text" style="width:140px; padding:2px 0 3px 5px;" value="" />
								주소 : <input id="q" type="text" value="" style="width:260px; padding:2px 0 3px 5px;"/>
								<input type="button" style="width:40px;height:21px;background:url('/images/renewal/bt_search.gif') no-repeat;text;color:#fff;" value="변환" onclick="go_url();">&nbsp;
								<input type="button" style="width:40px;height:21px;background:url('/images/renewal/bt_search.gif') no-repeat;text;color:#fff;" value="반영" onclick="applyLonLat();">
								<br/>
								서울시청 [ X - 126.978224556483 Y - 37.5665711703918 ]<br/>
								지번주소 : 태평로1가 31 *행정동 + 지번까지 입력 / 도로명주소 : 세종대로 110 *도로명 + 건물번호 입력<br/>
							</li>
						</ul>
						<div id="mapBoxBj" style="height:640px;">
							<div id="map" class="claro"></div>
							<!--우측 상단 버튼 Start-->
<!-- 							<div id="tool" style="width:100px;"> -->
<!-- 								<div class="tool_bu1 toolBtn" type="0"><a href="javascript:void(0);"><img idx="0" src="/gis/images/tool_1_over1.gif" id="Image1" border="0"/></a></div> -->
<!-- 								<div class="tool_bu1 toolBtn" type="1"><a href="javascript:void(0);"><img idx="1" src="/gis/images/tool_2_off.gif" id="Image2" border="0"/></a></div> -->
<!-- 							</div> -->
							<!--우측 상단 버튼 End-->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div><!-- //추가 및 수정 -->
	
	<script type="text/javascript">
		var pointLayer;
		
		function addMarker(coord){
			if(pointLayer){
				_MapEventBus.trigger(_MapEvents.map_removeLayer, pointLayer);
			}
			
			var geometry = new ol.geom.Point(coord);
			
			pointLayer = new ol.layer.Vector({
				source : new ol.source.Vector({
					features : [new ol.Feature({geometry:geometry})]
				}),
				style : new ol.style.Style({
		    		geometry: geometry,
	    			image: new ol.style.Icon(({
	    				src: '/gis/images/apoint.png'
	        		}))
				}),
				visible: true,
				id:'clickPoint'
			});
			
			_MapEventBus.trigger(_MapEvents.map_addLayer, pointLayer);
		}
		$(function() {
			_CoreMap.init('map',{
				satellite: true
			});
			
			_MapEventBus.on(_MapEvents.map_singleclick, function(event, data){
				
				addMarker(data.result.coordinate);
				var tempCoord = ol.proj.transform(data.result.coordinate, 'EPSG:3857', 'EPSG:4326');
				
				$('#x').val(tempCoord[0]);
				$('#y').val(tempCoord[1]);
			});
		});
		
		function go_url(){
			var t = $("#type").val();
			var q = document.getElementById("q").value;
// 			var apiKey = '292052CF-BCA3-3C66-86A2-567EF19C8EEA'; /* 로컬 개발용  */
// 			var apiKey = '3728760A-A99F-39F6-96C8-74746BA4A738'; /* 210.99.81.159 */
// 			var apiKey = 'C4246B58-A669-3643-A7FD-F545A61ECE20'; /* ???? */
// 			var apiKey = '4EA77A23-29BC-37C9-A4EE-D3BCABCD9846'; /* 210.99.81.159:9090 */
			var apiKey= "C4246B58-A669-3643-A7FD-F545A61ECE20";  //waterkorea
// 			var domain = 'http://map.vworld.kr';
			var domain = 'http://210.99.81.159';
			var output = 'json';
			var epsg = 'EPSG:4326';
			var x = document.getElementById("x").value;
			var y = document.getElementById("y").value;
			var go_url="";
			var base_url="";
			if(t < 3 &&(q == null || q=="")){
				alert("주소를 입력하여 주십시오");
				document.getElementById("q").focus();
				return;
			}else if(t >2 && (x == null || x=="") ){
				alert("경도를 입력하여 주십시오");
				document.getElementById("x").focus();
				return;
			}else if(t >2 && (y == null || y=="") ){
				alert("위도를 입력하여 주십시오");
				document.getElementById("y").focus();
				return;
			}

			PointToAddr(y,x,q,t);
// 			$.ajax({
// 				type: 'POST',
// 				url: url,
// 				dataType: "json",
// 				contentType: "application/json; charset=utf-8",
// 				crossDomain: true,
// 				cache:false,
// 				success: function(data) {
// // 					console.log("v월드에서 가져온 값 : ", data);
// 					if(t==1 || t==2){
// 						document.getElementById("q").value = data.JUSO;
// 						document.getElementById("x").value = data.EPSG_4326_X;
// 						document.getElementById("y").value = data.EPSG_4326_Y;
// 					}else if (t==3){
// 						document.getElementById("q").value = data.ADDR;
// 					}else if (t==4){
// 						document.getElementById("q").value = data.NEW_JUSO;
// 					}
					
// // 					console.log(data);
// 				},
// 				error:function(jqXHR, textStatus, errorThrown){
// 					// alert("변환시 오류가 발생했거나 해당 결과가 없습니다.\n+ERROR Message:"+errorThrown);
// 					alert("변환시 오류가 발생했거나 해당 결과가 없습니다.\n\n[참조] 지번 또는 도로명이 존재하지  않을 시 해당 지점의 주소가 변환되지 않습니다. (산,하천,바다,도로 등)");
// 				}
// 			});

		};
		

		function Pointmessage(addr,X,Y){
			$("#q").val(addr);
			if(X != undefined)	{ $("#x").val(X); }
			if(Y != undefined)	{ $("#y").val(Y); }
		}
		
		
		function getXy(evt){
			var lonlat = esri.geometry.xyToLngLat(evt.mapPoint.x, evt.mapPoint.y);
			
			document.getElementById("x").value =lonlat[0];
			document.getElementById("y").value =lonlat[1];
			document.getElementById("q").value = "";
			
			var point = new esri.geometry.Point(lonlat[0], lonlat[1]);
			point = esri.geometry.geographicToWebMercator(point);
			
// 			var symbol = new esri.symbol.PictureMarkerSymbol("/gis/images/apoint.png", 22, 40);
			//yoffset을 주기 위해 변경
			var symbol = new esri.symbol.PictureMarkerSymbol({ "url":"/gis/images/apoint.png", "height":"31", "width":"17", "type":"esriPMS", "yoffset":"14" });
			var graphic = new esri.Graphic(point, symbol);
			
			$kecoMap.view.map.graphics.clear();
			
			$kecoMap.view.map.graphics.add(graphic);
		}
		
		function applyLonLat() {
			opener.applyLonLat($("#x").val(), $("#y").val(), $("#q").val());
			self.close();
		}
		
		$(function(){
			<%
				String X = request.getParameter("X");
				String Y = request.getParameter("Y");
				
			%>
			
			X = '<%=X%>';
			Y = '<%=Y%>';
			
			if(('' != X && 'null' != X) || ('' != Y && 'null' != Y)) {
				setTimeout(function(){
					
					if(isNaN(X) || isNaN(Y)){
						return;
					}
					var x = parseFloat(X);
					var y = parseFloat(Y);
					if(y > 38.097604 || y < 34.45364624){
						return;
					}
					if(x > 129.8856936 || x < 124.5631067){
						return;
					}
					var lonlat = [];
	
					lonlat[0] = x;
					lonlat[1] = y;
					document.getElementById("x").value =lonlat[0];
					document.getElementById("y").value =lonlat[1];
					document.getElementById("q").value = "";
					
					var tempCoord = ol.proj.transform([lonlat[0], lonlat[1]], 'EPSG:4326', 'EPSG:3857');
					
					addMarker(tempCoord);
					
					_MapEventBus.trigger(_MapEvents.map_move, {x:tempCoord[0], y:tempCoord[1], zoom:10});
					
				}, 2000)
			}
		})
	</script>
</body>
</html>