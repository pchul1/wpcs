<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html> <head> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<title>VWORLD DEMO SAMPLE</title> 
<!-- 실서버-->
<!-- <SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=3728760A-A99F-39F6-96C8-74746BA4A738"></SCRIPT>	 -->
<!--  ????  -->
<!-- <SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=C4246B58-A669-3643-A7FD-F545A61ECE20"></SCRIPT>    -->
<!-- 210.99.81.159:9090-->
<!-- <SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=4EA77A23-29BC-37C9-A4EE-D3BCABCD9846"></SCRIPT> -->
<SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=C4246B58-A669-3643-A7FD-F545A61ECE20"></SCRIPT>	
</head> <body >

<script type="text/javascript">     
		var map = null;  
		vworld.showMode = false; 
		
		vworld.init("cont1", "map-first", 
				function() {         
					map = this.vmap; 
					//기본맵 설정  
					map.setBaseLayer(map.vworldBaseMap); 
					map.setControlsType({"simpleMap":true});	//간단한 화면	 
					
					//기능버튼 추가
					map.addVWORLDControl("zoomBar");
					map.addVWORLDControl("indexMap");
					map.addVWORLDControl("layerSwitch");					
					map.setIndexMapPosition("right-bottom");				
					map.addMapToolButton("init");		//초기화       
					map.addMapToolButton("zoomin"); 	//확대     
					map.addMapToolButton("zoomout"); 	//축소     
					map.addMapToolButton("zoominbox"); 	//영역확대     
					map.addMapToolButton("zoomoutbox"); //영역축소     
					map.addMapToolButton("pan");   		//이동      
					map.addMapToolButton("prev");     	//이전화면    
					map.addMapToolButton("next");   	//다음화면
					map.addMapToolButton("info");   	//정보조회      
					map.addMapToolButton("fullext");	//전체보기
					map.addMapToolButton("caldist");	//거리측정
					map.addMapToolButton("calarea");	//면적측정
					
					//화면중심점과 레벨로 이동
					map.setCenterAndZoom(14137792.751626197, 4092051.278263237, 8);  	
					
					//화면이동시 좌표표출 이벤트 등록
					map.events.register('moveend', this, moveend);
				}
				,function (obj){SOPPlugin = obj; }//initCallback
				,function (msg){alert('oh my god');}//failCallback
			);
	
	function printSave(){
		map.getPrintMap();
	}
	function printPreview(){
		map.getPreviewMap();
	}
	//주제도 레이어 추가하기(보기)
	function addThemeLayer(title, layer){
		map.showThemeLayer(title, {layers:layer});			
	}
	//주제도 레이어 감추기(끄기)
	function hideThemeLayer(title){
		map.hideThemeLayer(title);			
	}
	
	function addTileCache(){
		map.showTileCacheLayer('국토환경성평가지도', 'ECVAM',{min:9,max:12});	
		//map.showTileCacheLayer('산사태위험지도', 'SANSATAI',{min:9,max:15});						
	}
	//마우스 이동완료시
	function moveend(e){
		var point = map.getTransformXY(map.getCenter().lon,map.getCenter().lat,"EPSG:900913","EPSG:4326");
		var query = "lon=" + point.x + "&lat=" + point.y;
		if (point== null) return;
		document.getElementById('centerx').value = point.x;
		document.getElementById('centery').value = point.y;		
		document.getElementById('centergx').value = map.getCenter().lon;
		document.getElementById('centergy').value = map.getCenter().lat;
		document.getElementById('level').value = map.getZoom();	
		document.getElementById('scale').value = map.getScale();
	}
	//좌표변환 
	function trans(){
		var point = map.getTransformXY(document.getElementById('centerx').value,
										document.getElementById('centery').value,
										"EPSG:4326","EPSG:900913");
		document.getElementById('centergx').value = point.x;
		document.getElementById('centergy').value = point.y;		
	}
	
	//화면클릭 이벤트 등록 및 마커찍기
	var markerControl;
	function addMarkingEvent(){	
		var pointOptions = {persist:true}
		if (markerControl == null) {
			markerControl = new OpenLayers.Control.Measure(OpenLayers.Handler.Point,{handlerOptions:pointOptions});
        	markerControl.events.on({"measure": mapclick});
        	map.addControl(markerControl);
		}        
		map.init();
        markerControl.activate();
	}
	//화면클릭 이벤트 해제
	function removeMarkingEvent(){
		map.events.unregister('click', this, mapclick);
	}
	//클릭이벤트 받아 마커찍기 호출
	function mapclick(event){
		map.init();	
		var temp = event.geometry;	
		var pos = new OpenLayers.LonLat(temp.x, temp.y);
		
		document.getElementById('mousex').value = pos.lon;
		document.getElementById('mousey').value = pos.lat;
		
		addMarker(pos.lon, pos.lat,"오류신고지역입니다.", null);			
	}	
	//좌표받아 마커찍기
	function addMarker(lon, lat, message, imgurl){
		var marker = new vworld.Marker(lon, lat,message,"");    
		if (typeof imgurl == 'string') {marker.setIconImage(imgurl);}   			        
		map.addMarker(marker); 
	}
	//레이어 리스트 얻기
	function layerListShow(){
		var cat = vworldCategory.theme;
		for (var i=0, len=map.layers.length; i<len; i++) {
            var layer = map.layers[i];
            alert(layer.name + ":" + layer.isBaseLayer);
            /*if (layer.name.indexOf(cat) > -1) {
            	layer.setVisibility(false);
				layer.redraw();
            }*/
        }
	}

	//외부 WMS 레이어 추가
	function importWMS(){
		map.ImportWMSLayer('개발제한구역',
			{
			url:'http://210.99.81.159:8090/gis/rest/services/WPCS/MapServer',
			layers:'40', // 사용할 레이어
			version: '1.3.0', // WMS 버전
			crs:'EPSG:900913', // CRS 좌표계
			srs:'EPSG:900913', // SRS 좌표계
			format:'image/png' // 리턴 타입
			});
							
	}
	//레이어 삭제하기
	function removeLayer(layername){
		/*
        // map.getLayerByName으로 레이어를 얻어와서 레이어 삭제        
        var layer = map.getLayerByName('wms_theme_' + layername); // wms 테마 레이어의 경우  wms_theme_ 접두사를 붙인다. 
        if(layer != null)
			map.removeLayer(layer);
		*/
		// map.getThemeLayerByName으로 레이어를 얻어와서 레이어 삭제
        var layer = map.getThemeLayerByName(layername);
        if(layer != null)
			map.removeLayer(layer);
	}
	
	// 전체 객체 삭제
	function clearAll(){
		map.clear();
	}
	
	// 모든 마커 삭제
	function clearMarkers(){
		map.clearMarkers();
	}
	
	// 중심좌표 반환
	function getCenterXY(){
		alert(map.getCenterXY().cx + ", "+ map.getCenterXY().cy);
	}
	
	//네비게이션(PanZoomBar) 위치 설정. 'left', 'right' 만 입력 가능합니다.
	function movePanZoomBar(){
		alert('move left');
		map.setZoomBarPosition('left');
		alert('move right');
		map.setZoomBarPosition('right');
	}
	// 맵툴바 위치 설정. right-top, right-bottom, left-top, left-bottom 만 입력 가능합니다. 
	function moveMapToolBar(){
		alert('move right-top');
		map.setMapToolPosition('right-top');
		alert('move right-bottom');
		map.setMapToolPosition('right-bottom');
		alert('move left-top');
		map.setMapToolPosition('left-top');
		alert('move left-bottom');
		map.setMapToolPosition('left-bottom');		
	}
	
	// 맵툴바 전개방향 설정
	function setMapToolDirection(direction){
		map.setMapToolDirection(direction);
		map.addMapToolButton('zoominbox');
		var x = map.mapToolbar.controls.length;
		map.removePanelButton(map.mapToolbar.controls[x-1]);
	}
	
	// 마커 관련 함수 테스트
	function markerFunction(){
		// 마커 개수 반환
		alert("현재까지 만들어진 마커의 개수는 " + map.getMarkerCount() + "개 입니다.");
		
		if(map.getMarkerCount() > 0){
			var firstMarker = map.getMarker(0); // index번째 마커 반환
			alert("첫번째 마커의 사이즈는 (" +  map.getMarkerSize(0).w + ", " + map.getMarkerSize(0).h + ") 입니다."); // index번째 마커 크기 반환
		}
	}
	
	// 중심좌표 설정
	function setCenterXY(){
		alert("화면 중심점 필드(경위도)에  입력한 좌표로 중심점을 이동합니다.");
		//화면중심점과 레벨로 이동
		trans(); // 경위도 좌표계를 구글좌표계로 변환
		//예제  126.82067872144127, 37.56577114128836
		map.setCenterXY(document.getElementById('centergx').value, document.getElementById('centergy').value);	
	}
	
	// 좌표이동
	function moveMap(){
		alert('이동합니다.');
		map.panXy(100, 100);

		alert('이전위치로 이동합니다.');
		map.prevMap();
		
		alert('다음위치로 이동합니다.');
		map.nextMap();
	} 
	
	// 인덱스맵 위치 설정
	function moveIndexMap(){
		alert('move right-top');
		map.setIndexMapPosition('right-top');
		alert('move right-bottom');
		map.setIndexMapPosition('right-bottom');
		alert('move left-top');
		map.setIndexMapPosition('left-top');
		alert('move left-bottom');
		map.setIndexMapPosition('left-bottom');
	}
	
	function zoomTest(){
		/*
		줌관련 테스트 모음. 다양한 예제에 대한 모음이 있으므로 주석처리하였습니다. 
		
		// 줌인
		alert("zoom in");
		map.zoomIn();
		
		//줌아웃
		alert("zoom out");
		map.zoomOut();
		
		// 줌 정보 
		alert("줌 레벨 반환 : " + map.getZoomLevel()
			+ "\n줌인 비율 반환 : " + map.getZoominRatio()  
			+ "\n최대 줌레벨 반환 : " + map.getMaxLevel()
			+ "\n최소 줌레벨 반환 : " + map.getMinLevel() 
			+ "\n경계(boundary) 정보를 반환 : " + map.getBounds()
		);
		
		map.zoomIn();
		map.zoomIn();
		map.zoomIn();
		alert("최대 영역 줌");
		map.fullExtent();
		
		// 줌 레벨 설정
		alert("줌 레벨 설정");
		map.setZoomLevel(10);
		
		// 줌인 비율 설정
		map.setZoominRatio(2);
		map.setZoomoutRatio(3);
		alert("줌인 비율 설정 후");
		map.zoomIn();
		map.zoomOut();
		
		*/
		
		// 자동줌 . 특정영역을 파라미터로 주었을 때 
		// 해당영역이 화면 안에 있다면 화면의 중심점과 영역의 중심점을 맞추고
		// 해당영역이 화면 안에 없다면 
		// 현재 줌 레벨이 영역에 해당하는 자동줌레벨보다 크면 줌레벨을 자동줌레벨에 맞추고 화면의 중심점과 영역의 중심점을 맞춘다.
		// 현재 줌 레벨이 영역에 해당하는 자동줌레벨보다 작으면 화면의 중심점과 영역의 중심점을 맞춘다. 	 	
		alert("자동줌 ");
		var bounds = new OpenLayers.Bounds(14107217.939517, 4210681.5469405, 14150634.171576, 4166042.32243);
		map.zoomToAuto(bounds, 15);
	}
	
	// 컨트롤 관련 함수 테스트
	function controlTest1(){
		map.zoomBoxIn();
		map.zoomBoxOut();
		map.calcArea();
		map.calcDistance();
		map.infoOn();
		map.initAll();
		map.initMeasurement();
	}	
	
	function testAlert(){
		alert('moveend!!')
	}
	
	// 이벤트 추가 테스트
	function addEvent(){		
		map.addEvent("moveend", testAlert);
	}
	// 이벤트 제거 테스트
	function removeEvent(){		
		map.removeEvent("moveend", testAlert); // 추가했던 함수를 정확하게 지정해야 한다.
	}
	// 이벤트 존재 확인 테스트
	function existEvent(){		
		if(map.isEventExist("moveend", testAlert)){ // 추가했던 함수를 정확하게 지정해야 한다.
			alert( "해당 함수가 존재합니다."); 
		}
		else{
			alert( "해당 함수가 존재하지 않습니다."); 
		}
		
	} 	 	 	 	
	
	// 경계값 관련 함수 테스트
	function testBounds(){
		var bounds = new OpenLayers.Bounds(14107217.939517, 4210681.5469405, 14150634.171576, 4166042.32243);
		map.setBounds(bounds); // 지도 바운더리(경계값}) 변경
		
		// 경위도 바운더리를 구글좌표계 바운더리로 변환한다.
		var newBounds = new OpenLayers.Bounds(126.92230225659186, 35.17994512161053, 127.42904663414752, 34.87969789741494);
		var mapBounds = map.getTransformBounds(newBounds);
		alert("mapBounds  : " + mapBounds );	
	}
	
	// 레이어 테스트
	function layerTest(){
		addThemeLayer('도시지역','LT_C_UQ111');
		map.hideAllThemeLayer(); // 모든 WMS 레이어 숨기기. 지도목록보기로 확인하면 레이어는 존재하는걸 알 수 있습니다.
		map.mapRefresh();	// 레이어 새로고침
	} 
	
	// 그래픽 함수 테스트
	function graphicTest(){
		var size = new OpenLayers.Size(21,25);
 		var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
		var icon = new OpenLayers.Icon('http://www.openlayers.org/dev/img/marker.png', size, offset);
		var graphicVar = new OpenLayers.Feature.Vector(
                        new OpenLayers.Geometry.Point(14105383.450839, 3950184.1545913), null, null
                    );
		map.addGraphic(graphicVar);// 그래픽 객체 추가
	}
</script> 
	<div>			
		현재레벨:
		<input type="text" name='q' id='level' value="0" maxlength="20" style="ime-mode:active;width:50px;"/>
		축척:
		<input type="text" name='q' id='scale' value="0" maxlength="20" style="ime-mode:active;width:50px;"/>
		화면중심점(경위도4326):
		<input type="text" name='q' id='centerx' value="0" maxlength="20" style="ime-mode:active;width:100px;"/>
		<input type="text" name='q' id='centery' value="0" maxlength="20" style="ime-mode:active;width:100px;"/>
		<button type="button" onclick="javascript:trans();" >변환>></button>		
		화면중심점(구글좌표):
		<input type="text" name='q' id='centergx' value="0" maxlength="20" style="ime-mode:active;width:100px;"/>
		<input type="text" name='q' id='centergy' value="0" maxlength="20" style="ime-mode:active;width:100px;"/>
	</div>
	<div>
		<button type="button" onclick="javascript:layerListShow();" name="list2d" >지도목록보기</button>
		<button type="button" onclick="javascript:addThemeLayer('도시지역','LT_C_UQ111');" name="addcache" >도시지역도 보기(추가)</button>
		<button type="button" onclick="javascript:hideThemeLayer('도시지역');" name="addcache" >도시지역도 감추기</button>
		<button type="button" onclick="javascript:addTileCache();" name="addcache" >TileCache 추가(2DCache/tile)</button>
		<button type="button" onclick="javascript:importWMS();" name="importwms" >개발제한구역(외부WMS)추가</button>
		<button type="button" onclick="javascript:removeLayer('개발제한구역');" name="importwms" >개발제한구역 삭제</button>
	</div>
	<div>
		<button type="button" onclick="javascript:addMarkingEvent();" name="addpin" >마커찍기</button>
		마우스클릭(구글좌표):
		<input type="text" name='q' id='mousex' value="0" maxlength="20" style="ime-mode:active"/>
		<input type="text" name='q' id='mousey' value="0" maxlength="20" style="ime-mode:active"/>	
		&nbsp;&nbsp;&nbsp;<button type="button" onclick="javascript:map.addMapToolButton('zoominbox');" name="mode0" >영역확대버튼추가</button>
		<button type="button" onclick="javascript:printSave();" name="printsave" >화면저장</button>
		<button type="button" onclick="javascript:printPreview();" name="preview" >인쇄미리보기</button>
		
	</div>	
	<div>
		<button type="button" onclick="javascript:vworld.setMode(0);" name="mode0" >2D전환</button>
		<button type="button" onclick="javascript:vworld.setMode(2);" name="mode2" >3D전환</button>
		<button type="button" onclick="moveMap()" >좌표이동</button>
		<button type="button" onclick="layerTest()" >레이어 테스트</button>
		<button type="button" onclick="graphicTest()" >graphic 테스트</button>		
	</div>
	<div>
		<button type="button" onclick="clearAll()" >전체 객체 삭제</button>
		<button type="button" onclick="clearMarkers()" >전체 마커 삭제</button>
		<button type="button" onclick="zoomTest()" >줌 관련 함수 테스트</button>
		<button type="button" onclick="controlTest1()" >컨트롤 관련 함수 테스트1</button>
		<button type="button" onclick="addEvent()" >이벤트 추가</button>
		<button type="button" onclick="removeEvent()" >이벤트 제거</button>
		<button type="button" onclick="existEvent()" >이벤트 존재 확인</button>
		<button type="button" onclick="testBounds()" >바운더리 테스트</button>
	</div>
	<div>
		<button type="button" onclick="getCenterXY()" >중심좌표 반환</button>
		<button type="button" onclick="setCenterXY()" >중심좌표 설정</button>
		<button type="button" onclick="movePanZoomBar()" >네비게이션(PanZoomBar) 위치 설정</button>
		<button type="button" onclick="moveMapToolBar()" >맵툴바 위치 설정</button>
		<button type="button" onclick="moveIndexMap()" >인덱스맵 위치 설정</button>
		<button type="button" onclick="setMapToolDirection('vertical')" >맵툴바 전개방향 수직설정</button>
		<button type="button" onclick="setMapToolDirection('horizontal')" >맵툴바 전개방향 수평설정</button>
		<button type="button" onclick="markerFunction()" >마커 관련 함수 테스트</button>
	</div>
	
	<div style="display:inline;float:left;width:100%;height:500px;left:0px;top:0px">
	<div id="cont1" style="width:100%;height:500px;left:0px;top:0px"></div>	
	</div>
	
</body> 
</html>