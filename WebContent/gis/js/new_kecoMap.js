
var daum = {
		apikey: "4bc63e3a941c98f7bb179dff6c5437e796dae6fe",
		addr2coord : function(addr , callBack) {
			var obj = document.createElement('script');
			obj.type ='text/javascript';
			obj.charset ='utf-8';
			obj.src = 'http://apis.daum.net/local/geo/addr2coord?apikey=' + this.apikey + 
			'&output=json&callback='+callBack+'&q=' + encodeURI(addr);
			document.getElementsByTagName('head')[0].appendChild(obj);
		},
		coord2addr : function(longitude, latitude , callBack) {
			var obj = document.createElement('script');
			obj.type ='text/javascript';
			obj.charset ='utf-8';
			obj.src = 'http://apis.daum.net/local/geo/coord2addr?apikey=' + this.apikey + '&output=json&callback='+callBack+'&longitude='+longitude+'&latitude='+latitude+'&inputCoordSystem=WGS84';
			document.getElementsByTagName('head')[0].appendChild(obj);
		}
	};
if (!window.location.origin) { // Some browsers (mainly IE) does not have this property, so we need to build it manually...
	window.location.origin = window.location.protocol + '//' + window.location.hostname + (window.location.port ? (':' + window.location.port) : '');
}

function formatYMDHM(src){
	if(src == null && src.length != 12){
		return src;
	}
	var des = '';
	des += src.substring(0,4)+'-';
	des += src.substring(4,6)+'-';
	des += src.substring(6,8)+' ';
	des += src.substring(8,10)+':';
	des += src.substring(10,12);
	return des;
	
}

var $kecoMap;

$(function() {
	
	var page = {
		"dom" : $(this)
	};
	
	var TAG = page.id;
	var WKT = 3857;
	var MAP_SPATIALREFERENCE = null; //4326;
	
	var ORIGIN = {
					"x": 13462700,
					"y": 5322463
				};
	var TILEINFO = null; 
	
	var EVENT_TEMP  = {
			title:"${wpkind}",
			content: "<ul>"
						+ "<li> ● 사고유형 : ${wpkind} </li>"
						+ "<li> ● 신고일자 : ${reportdate}</li>"
						+ "<li> ● 접수일자 : ${receivedate}</li>"
						+ "<li> ● 수계 : ${river_name} </li>"
						+ "<li> ● 주소 : ${address} ${addrdet}</li>"
						+ "<li> ● 처리상태 : ${supportkind}</li></ul>"
					};
	var TMS_TEMP  = {
			title:"${FACTNAME}",
			content: "<ul>"
						+ "<li> ● 수신시간 : ${STRDATE} ${STRTIME}</li>"
						+ "<c:if test=\"${RIVER_NAME == ''}\"> " + "<li> ● 권역 : ${RIVER_NAME} </li>" + "</c:if>"					
						+ "<table>"
						+ "<thead>"
						+ "<tr>"
						+ "<th>항목</th>"
						+ "<th>측정값</th>"
						+ "<th>단위</th>"
						+ "<th>기준</th>"
						+ "</tr>"
						+ "</thead>"
						+ "<tbody>"
						+ "<tr>"
						+ "<td align='center'>PH</td>"
						+ "<td align='center'>${PHY}</td>"
						+ "<td align='center'></td>"
						+ "<td align='center'>${PHYLAW}</td>"
						+ "</tr>"
						+ "<tr>"
						+ "<td align='center'>BOD</td>"
						+ "<td align='center'>${BOD}</td>"
						+ "<td align='center'>(ppm)</td>"
						+ "<td align='center'>${BODLAW}</td>"
						+ "</tr>"
						+ "<tr>"
						+ "<td align='center'>COD</td>"
						+ "<td align='center'>${COD}</td>"
						+ "<td align='center'>(ppm)</td>"
						+ "<td align='center'>${CODLAW}</td>"
						+ "</tr>"
						+ "<tr>"
						+ "<td align='center'>SS</td>"
						+ "<td align='center'>${SUS}</td>"
						+ "<td align='center'>(mg/L)</td>"
						+ "<td align='center'>${SUSLAW}</td>"
						+ "</tr>"
						+ "<tr>"						
						+ "<td align='center'>T-N</td>"
						+ "<td align='center'>${TON}</td>"
						+ "<td align='center'>(mg/L)</td>"
						+ "<td align='center'>${TONLAW}</td>"
						+ "</tr>"
						+ "<tr>"
						+ "<td align='center'>T-P</td>"
						+ "<td align='center'>${TOP}</td>"
						+ "<td align='center'>(mg/L)</td>"
						+ "<td align='center'>${TOPLAW}</td>"
						+ "</tr>"
						+ "</tbody>"
						+ "<table>"
					};
	
	var IPUSN_TEMP = {
			title:"${FACTNAME}"+"("+"${BRANCH_NAME}"+")",
			content: "<ul>"
				+ "<li> ● 수신시간 : ${STRDATE} ${STRTIME}</li>"
				+ "<li> ● 수계 : ${RIVER_NAME} </li>"					
				+ "<table>"
				+ "<thead>"
				+ "<tr>"
				+ "<th>항목</th>"
				+ "<th>측정값</th>"
				+ "<th>단위</th>"
				+ "<th>기준</th>"
				+ "</tr>"
				+ "</thead>"
				+ "<tbody>"
				+ "<tr>"
				+ "<td align='center'>PH</td>"
				+ "<td align='center'>${PHY}</td>"
				+ "<td align='center'></td>"
				+ "<td align='center'>${PHYL}</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td align='center'>DO</td>"
				+ "<td align='center'>${DOW}</td>"
				+ "<td align='center'>(mS/cm)</td>"
				+ "<td align='center'>${DOWL}</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td align='center'>EC</td>"
				+ "<td align='center'>${CON}</td>"
				+ "<td align='center'>(μS/cm)</td>"
				+ "<td align='center'>${CONL}</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td align='center'>탁도</td>"
				+ "<td align='center'>${TUR}</td>"
				+ "<td align='center'>(NTU)</td>"
				+ "<td align='center'>${TURL}</td>"
				+ "</tr>"
				+ "<tr>"						
				+ "<td align='center'>수온</td>"
				+ "<td align='center'>${TMP}</td>"
				+ "<td align='center'>(℃)</td>"
				+ "<td align='center'>${TMPL}</td>"
				+ "</tr>"				
				+ "</tbody>"
				+ "<table>"
					};
	var IPUSN_TEMP_ALERT = {
			title:"${BRANCH_NAME}",
			content: "<ul>"
				+ "<li> ● 수신시간 : ${STRDATE} ${STRTIME}</li>"
				+ "<li> ● 수계 : ${RIVER_NAME} </li>"					
				+ "<table>"
				+ "<thead>"
				+ "<tr>"
				+ "<th>항목</th>"
				+ "<th>측정값</th>"
				+ "<th>단위</th>"
				+ "<th>기준</th>"
				+ "</tr>"
				+ "</thead>"
				+ "<tbody>"
				+ "<tr>"
				+ "<td align='center'>PH</td>"
				+ "<td align='center'>${PHY}</td>"
				+ "<td align='center'></td>"
				+ "<td align='center'>${PHYL}</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td align='center'>DO</td>"
				+ "<td align='center'>${DOW}</td>"
				+ "<td align='center'>(mS/cm)</td>"
				+ "<td align='center'>${DOWL}</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td align='center'>EC</td>"
				+ "<td align='center'>${CON}</td>"
				+ "<td align='center'>(μS/cm)</td>"
				+ "<td align='center'>${CONL}</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td align='center'>탁도</td>"
				+ "<td align='center'>${TUR}</td>"
				+ "<td align='center'>(NTU)</td>"
				+ "<td align='center'>${TURL}</td>"
				+ "</tr>"
				+ "<tr>"						
				+ "<td align='center'>수온</td>"
				+ "<td align='center'>${TMP}</td>"
				+ "<td align='center'>(℃)</td>"
				+ "<td align='center'>${TMPL}</td>"
				+ "</tr>"				
				+ "<tr>"						
				+ "<td colspan = 4><font color=\"#ff0000\"> ● 이상메세지 : ${ALERT_MSG}</font></td>"				
				+ "</tr>"
				+ "</tbody>"
				+ "<table>"
					};
	var IPUSN_TEMP_THEME = {
			title:"${FACTNAME}",
			content: "<ul>"
				+ "<li> ● 수신시간 : ${STRDATE} ${STRTIME}</li>"
				+ "<li> ● 수계 : ${RIVER_NAME} </li>"					
				+ "<table>"
				+ "<thead>"
				+ "<tr>"
				+ "<th>항목</th>"
				+ "<th>측정값</th>"
				+ "<th>단위</th>"
				+ "<th>기준</th>"
				+ "</tr>"
				+ "</thead>"
				+ "<tbody>"
				+ "<tr>"
				+ "<td align='center'>PH</td>"
				+ "<td align='center'>${PHY}</td>"
				+ "<td align='center'></td>"
				+ "<td align='center'>${PHYL}</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td align='center'>DO</td>"
				+ "<td align='center'>${DOW}</td>"
				+ "<td align='center'>(mS/cm)</td>"
				+ "<td align='center'>${DOWL}</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td align='center'>EC</td>"
				+ "<td align='center'>${CON}</td>"
				+ "<td align='center'>(μS/cm)</td>"
				+ "<td align='center'>${CONL}</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td align='center'>탁도</td>"
				+ "<td align='center'>${TUR}</td>"
				+ "<td align='center'>(NTU)</td>"
				+ "<td align='center'>${TURL}</td>"
				+ "</tr>"
				+ "<tr>"						
				+ "<td align='center'>수온</td>"
				+ "<td align='center'>${TMP}</td>"
				+ "<td align='center'>(℃)</td>"
				+ "<td align='center'>${TMPL}</td>"
				+ "</tr>"				
				+ "<tr>"						
				+ "<td colspan = 4>● 기준치 알람 : ${ALAM}</td>"				
				+ "</tr>"
				+ "</tbody>"
				+ "<table>"
					};
	var AUTO_TEMP = {
			title:"${FACTNAME}",
			content: "<ul>"
				+ "<li> ● 수신시간 : ${STRDATE} ${STRTIME}</li>"
				+ "<li> ● 수계 : ${RIVER_NAME} </li>"					
				+ "<table>"
				+ "<thead>"
				+ "<tr>"
				+ "<th>항목</th>"
				+ "<th>측정값</th>"
				+ "<th>단위</th>"
				+ "<th>기준</th>"
				+ "</tr>"
				+ "</thead>"
				+ "<tbody>"
				+ "<tr>"
				+ "<td align='center'>PH</td>"
				+ "<td align='center'>${PHY}</td>"
				+ "<td align='center'></td>"
				+ "<td align='center'>${PHYL}</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td align='center'>DO</td>"
				+ "<td align='center'>${DOW}</td>"
				+ "<td align='center'>(mS/cm)</td>"
				+ "<td align='center'>${DOWL}</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td align='center'>EC</td>"
				+ "<td align='center'>${CON}</td>"
				+ "<td align='center'>(μS/cm)</td>"
				+ "<td align='center'>${CONL}</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td align='center'>탁도</td>"
				+ "<td align='center'>${TUR}</td>"
				+ "<td align='center'>(NTU)</td>"
				+ "<td align='center'>${TURL}</td>"
				+ "</tr>"
				+ "<tr>"						
				+ "<td align='center'>수온</td>"
				+ "<td align='center'>${TMP}</td>"
				+ "<td align='center'>(℃)</td>"
				+ "<td align='center'>${TMPL}</td>"
				+ "</tr>"				
				+ "</tbody>"
				+ "<table>"
			};
	
	var AUTO_TEMP_ALERT = {
			title:"${FACTNAME}",
			content: "<ul>"
				+ "<li> ● 수신시간 : ${STRDATE} ${STRTIME}</li>"
				+ "<li> ● 수계 : ${RIVER_NAME} </li>"					
				+ "<table>"
				+ "<thead>"
				+ "<tr>"
				+ "<th>항목</th>"
				+ "<th>측정값</th>"
				+ "<th>단위</th>"
				+ "<th>기준</th>"
				+ "</tr>"
				+ "</thead>"
				+ "<tbody>"
				+ "<tr>"
				+ "<td align='center'>PH</td>"
				+ "<td align='center'>${PHY}</td>"
				+ "<td align='center'></td>"
				+ "<td align='center'>${PHYL}</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td align='center'>DO</td>"
				+ "<td align='center'>${DOW}</td>"
				+ "<td align='center'>(mS/cm)</td>"
				+ "<td align='center'>${DOWL}</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td align='center'>EC</td>"
				+ "<td align='center'>${CON}</td>"
				+ "<td align='center'>(μS/cm)</td>"
				+ "<td align='center'>${CONL}</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td align='center'>탁도</td>"
				+ "<td align='center'>${TUR}</td>"
				+ "<td align='center'>(NTU)</td>"
				+ "<td align='center'>${TURL}</td>"
				+ "</tr>"
				+ "<tr>"						
				+ "<td align='center'>수온</td>"
				+ "<td align='center'>${TMP}</td>"
				+ "<td align='center'>(℃)</td>"
				+ "<td align='center'>${TMPL}</td>"
				+ "</tr>"				
				+ "<tr>"						
				+ "<td colspan = 4><font color=\"#ff0000\"> ● 이상메세지 : ${ALERT_MSG}</font></td>"				
				+ "</tr>"
				+ "</tbody>"
				+ "<table>"
			};
	
	var AUTO_TEMP_THEME = {
			title:"${FACTNAME}",
			content: "<ul>"
				+ "<li> ● 수신시간 : ${STRDATE} ${STRTIME}</li>"
				+ "<li> ● 수계 : ${RIVER_NAME} </li>"					
				+ "<table>"
				+ "<thead>"
				+ "<tr>"
				+ "<th>항목</th>"
				+ "<th>측정값</th>"
				+ "<th>단위</th>"
				+ "<th>기준</th>"
				+ "</tr>"
				+ "</thead>"
				+ "<tbody>"
				+ "<tr>"
				+ "<td align='center'>PH</td>"
				+ "<td align='center'>${PHY}</td>"
				+ "<td align='center'></td>"
				+ "<td align='center'>${PHYL}</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td align='center'>DO</td>"
				+ "<td align='center'>${DOW}</td>"
				+ "<td align='center'>(mS/cm)</td>"
				+ "<td align='center'>${DOWL}</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td align='center'>EC</td>"
				+ "<td align='center'>${CON}</td>"
				+ "<td align='center'>(μS/cm)</td>"
				+ "<td align='center'>${CONL}</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td align='center'>탁도</td>"
				+ "<td align='center'>${TUR}</td>"
				+ "<td align='center'>(NTU)</td>"
				+ "<td align='center'>${TURL}</td>"
				+ "</tr>"
				+ "<tr>"						
				+ "<td align='center'>수온</td>"
				+ "<td align='center'>${TMP}</td>"
				+ "<td align='center'>(℃)</td>"
				+ "<td align='center'>${TMPL}</td>"
				+ "</tr>"				
				+ "<tr>"						
				+ "<td colspan = 4>● 기준치 알람 : ${ALAM}</td>"				
				+ "</tr>"
				+ "</tbody>"
				+ "<table>"
			};
	var NULL_TEMP = {
			title:"${FACI_NM}",
			content: "<ul>"
						+ "<li> 정보가 없습니다. </li></ul>"
					};
	var OUT_TEMP = {
			title:"${branch_name}",
			content: "<ul>"
						+ "<li> ● 수신시간 : ${update_time} </li>"
						+ "<li> ● 코드 : ${fact_code} </li>"
						+ "<li> ● 배터리 : ${battery} </li>"
						+ "<li> ● 위도 : ${latitude} </li>"
						+ "<li> ● 경도 : ${longitude} </li></ul>"
					};
	var TEMP_B_TEMP = {
			title:"${TITLE}",
			content: "<ul>"
						+ "<li> ● 등록자 : ${REG_ID} </li>"
						+ "<li> ● 등록일자 : ${REG_DATE} </li>"
						+ "<li> ● 상세정보 : ${CONTENT} </li>"
					};
	var CR_TEMP  = {
			title:"${branch_name}",
			content: "<ul>"
						+ "<li> ● 수신시간 : ${update_time} </li>"
						+ "<li> ● 코드 : ${fact_code} </li>"
						+ "<li> ● 배터리 : ${battery} </li>"
						+ "<li> ● 위도 : ${latitude} </li>"
						+ "<li> ● 경도 : ${longitude} </li></ul>"
					};
	var TEMP_DE = {};
	TEMP_DE['de4'] = {
			title:"${보명}",
			content: "<ul>"
						+ "<li> ● 관측소명 : ${보명} </li>"
						+ "<li> ● 수계 : ${수계} </li></ul>"
					};
	TEMP_DE['de5'] = {
			title:"${관측소명}",
			content: "<ul>"
						+ "<li> ● 관측소명 : ${관측소명} </li>"
						+ "<li> ● 관측소코드 : ${관측소코드} </li>"
						+ "<li> ● 댐종류 : ${댐종류} </li>"
						+ "<li> ● 법정동코드 : ${법정동코드} </li>"
						+ "<li> ● 관할기관 : ${관할기관} </li>"
						+ "<li> ● 주소 : ${주소} </li></ul>"
					};
	TEMP_DE['de6'] = {
			title:"${취수장명}",
			content: "<ul>"
						+ "<li> ● 취수장명 : ${취수장명} </li>"
						+ "<li> ● 주소 : ${주소} </li>"
						+ "<li> ● 대책수계 : ${대책수계} </li>"
						+ "<li> ● 대책권역 : ${대책권역} </li>"
						+ "<li> ● 대책유역 : ${대책유역} </li>"
						+ "<li> ● 시설용량 : ${시설용량} </li>"
						+ "<li> ● 수원_표류 : ${수원_표류} </li>"
						+ "<li> ● 수원_복류 : ${수원_복류} </li>"
						+ "<li> ● 수원_댐 : ${수원_댐} </li>"
						+ "<li> ● 수원_기타 : ${수원_기타} </li>"
						+ "<li> ● 수원_지하 : ${수원_지하} </li>"
						+ "<li> ● 일평균취수 : ${일평균취수} </li>"
						+ "<li> ● 공급량 : ${공급량} </li>"
						+ "<li> ● 수원_복류 : ${수원_복류} </li>"
						+ "<li> ● 정수장 : ${정수장} </li>"
						+ "<li> ● 비고 : ${비고} </li>"
						+ "<li> ● 조인여부 : ${조인여부} </li></ul>"
					};
	TEMP_DE['de7'] = {
			title:"${정수장명}",
			content: "<ul>"
						+ "<li> ● 정수장명 : ${정수장명} </li>"
						+ "<li> ● 배수코드 : ${배수코드} </li>"
						+ "<li> ● 배수구역 : ${배수구역} </li>"
						+ "<li> ● 대책수계 : ${대책수계} </li>"
						+ "<li> ● 대책권역 : ${대책권역} </li>"
						+ "<li> ● 대책유역 : ${대책유역} </li>"
						+ "<li> ● 시설용량 : ${시설용량} </li>"
						+ "<li> ● 간이처리 : ${간이처리} </li>"
						+ "<li> ● 완속여과 : ${완속여과} </li>"
						+ "<li> ● 급속여과 : ${급속여과} </li>"
						+ "<li> ● 고도처리 : ${고도처리} </li>"
						+ "<li> ● 일최대급수 : ${일최대급수} </li>"
						+ "<li> ● 일평균급수 : ${일평균급수} </li>"
						+ "<li> ● 급수구역 : ${급수구역} </li>"
						+ "<li> ● 급수인구 : ${급수인구} </li>"
						+ "<li> ● 정수장 : ${정수장} </li>"
						+ "<li> ● 비고 : ${비고} </li>"
						+ "<li> ● 주소 : ${주소} </li></ul>"
					};
	TEMP_DE['de8'] = {
			title:"${NAME}",
			content: "<ul>"
						+ "<li> ● 댐명 : ${NAME} </li>"
						+ "<li> ● 주소 : ${ADDRESS} </li>"
						+ "<li> ● 수계 : ${RIVER_NM} </li>"
						+ "<li> ● 관리과 : ${NGI_MANAGE} </li>"
						+ "<li> ● 대책권역 : ${NGI_MANAGE} </li></ul>"
					};
	// //////////////////
	TEMP_DE['de9'] = {
			title:"${OBSNM}",
			content: "<ul>"
						+ "<li> ● 보명 : ${OBSNM} </li></ul>"
					};
	
	layerInfoDiv = null;
	layerInfoOverlay = null;
	
	currentFeature = null;
	
	//////////
	// MVC 설정 시작
	// ////////////////////////////
	
	// TODO MVC::model 관련 코드 작성
	page.model = ( function() {
		// ////////////////////////////
		// private variables
		// ////////////////////////////
		// Model 초기화
		
		var pub = {};
		
		pub.themeIpusnList = [];
		
		pub.themeAutoList = [];
		
		pub.baseObj = undefined;
		
		pub.alertData = [];
		
		pub.toolbaridx = -1;
		pub.mapidx = 0;
		
		pub.visibleLayers = [];
		
		pub.wmsLayers = {};
		
		pub.coordCallback = '$kecoMap.model.daumCallBack';
		
		pub.getThemeIpusnData = function(factcode , branchno) {
			for ( var i = 0; i < this.themeIpusnList.length; i++) {
				var obj = this.themeIpusnList[i].attributes;
				if(obj.FACT_CODE == factcode && obj.BRANCH_NO == branchno){
					return obj;
				}
			}
			return;
		};
		
		pub.getThemeAutoData = function(factcode , branchno) {
			for ( var i = 0; i < this.themeAutoList.length; i++)  {
				var obj = this.themeAutoList[i].attributes;
				if(obj.FACT_CODE == factcode && obj.BRANCH_NO == branchno){
					return obj;
				}
			}
			return;
		};
		
		pub.daumCallBack = function(result) {
		};
		
		pub.eventCall = function(coord, distances)  {
			if(coord == undefined || coord.length < 0)
				return;
			if(distances == undefined)
				distances = 10;
			
			var geometries = [];
			for ( var i = 0; i < coord.length; i++) {
				var geo = esri.geometry.geographicToWebMercator(new esri.geometry.Point(coord[i].x,coord[i].y));
				geometries.push(geo);
			}
			var params = new esri.tasks.BufferParameters();
			params.geometries = geometries;
			params.distances = [ distances ,distances+2];
			params.unit = esri.tasks.GeometryService.UNIT_KILOMETER;
			
			$kecoMap.view.gsvc.buffer(params, function(result){
				$kecoMap.view.map.graphics.clear();
			
				var symbol = new esri.symbol.SimpleFillSymbol(
					esri.symbol.SimpleFillSymbol.STYLE_SOLID,
						new esri.symbol.SimpleLineSymbol(
							esri.symbol.SimpleLineSymbol.STYLE_SHORTDASHDOTDOT,
							new dojo.Color([255,0,0]), 
							2
						),new dojo.Color([255,0,0,0.25]));
			
				for ( var i = 0; i < result.length; i++) {
					var bufferGeometry = result[i];
					var graphic = new esri.Graphic(bufferGeometry, symbol);
					$kecoMap.view.map.graphics.add(graphic);
					
					var query = new esri.tasks.Query();
					query.geometry = bufferGeometry;
					$kecoMap.view.featureLayer.selectFeatures(query, esri.layers.FeatureLayer.SELECTION_NEW, function(results){
						console.log('[FEATURE LAYER RESULT]', results);
					});
				}
				
				for ( var i = 0; i < geometries.length; i++) {
					var pictureMarkerSymbol = new esri.symbol.PictureMarkerSymbol('/gis/images/event.gif', 50, 50);
					pictureMarkerSymbol.setOfflt(10,10);
					$kecoMap.view.map.graphics.add(new esri.Graphic(geometries[i], pictureMarkerSymbol));
				}
				
			});
		};
		
		pub.updateLayerVisibility = function(idx) {
			if(idx == undefined) {
				var inputs = $(".list_item");
				
				var visibleLayers = [];
				
				for (var i=0, il=inputs.length; i<il; i++) {
					if (inputs[i].checked) {
						visibleLayers.push(inputs[i].id);
					}
				}
				
				pub.visibleLayers = visibleLayers;
				 
				for(var key in $kecoMap.model.wmsLayers){
					$kecoMap.model.wmsLayers[key].setVisible(false);
				}
				
				for(var i=0; i<visibleLayers.length; i++){
					if($kecoMap.model.wmsLayers[visibleLayers[i]]){
						$kecoMap.model.wmsLayers[visibleLayers[i]].setVisible(true);	
					}else{
						var layerInfo = [{layerNm:'wpcs:'+visibleLayers[i],isVisible:true,isTiled:true,cql:null,opacity:1}];
						$kecoMap.model.wmsLayers[visibleLayers[i]] = _CoreMap.createTileLayer(layerInfo)[0];
						
						_MapEventBus.trigger(_MapEvents.map_addLayer, $kecoMap.model.wmsLayers[visibleLayers[i]]);
					}
				} 
				
			} else if(idx == 0) {
				if($('#autoLd').attr('checked')){
					$kecoMap.view.autoLayer.setVisible(true);
				} else {
					$kecoMap.view.autoLayer.setVisible(false);
				}
				
				var isOption = "";
				
				if($('#autoLd').attr('checked')){
					if($('#ipLd').attr('checked'))
						isOption = "<option value='all'>전&nbsp;&nbsp;체</option><option value='A'>자동측정망(A)</option><option value='U'>이동형측정기기(U)</option>";
					else
						isOption = "<option value='A'>자동측정망(A)";
				}else{
					if($('#ipLd').attr('checked'))
						isOption = "<option value='U'>이동형측정기기(U)</option>";
					else
						isOption = "<option value='null'>지점선택필요</option>";
				}
				
				$kecoMap.model.baseObj.view.roopSysKindSel.html(isOption);
			} else if( idx == 1) {
				if($('#tmsLd').attr('checked'))
					$kecoMap.view.tmsLayer.setVisible(true);
				else
					$kecoMap.view.tmsLayer.setVisible(false);
			} else if( idx == 2) {
				if($('#ipLd').attr('checked'))
					$kecoMap.view.ipusnLayer.setVisible(true);
				else
					$kecoMap.view.ipusnLayer.setVisible(false);
				
//				$kecoMap.model.baseObj.model.stop();
				
				var isOption = "";
				
				if($('#autoLd').attr('checked')){
					if($('#ipLd').attr('checked'))
						isOption = "<option value='all'>전&nbsp;&nbsp;체</option><option value='A'>자동측정망(A)</option><option value='U'>이동형측정기기(U)</option>";
					else
						isOption = "<option value='A'>자동측정망(A)";
				}else{
					if($('#ipLd').attr('checked'))
						isOption = "<option value='U'>이동형측정기기(U)</option>";
					else
						isOption = "<option value='null'>지점선택필요</option>";
				}
				
				$kecoMap.model.baseObj.view.roopSysKindSel.html(isOption);
			} else if( idx == 3) {
				if($('#whLd').attr('checked'))
						$kecoMap.view.whLayer.setVisible(true);
					else
						$kecoMap.view.whLayer.setVisible(false);
			}else{
				if($('#de'+idx).attr('checked')){
					$kecoMap.view.orderLayers['de'+idx].setVisible(true);
				}else{
					$kecoMap.view.orderLayers['de'+idx].setVisible(false);
				}
			}
			
			//범례 선택의 경우 무조건 이동 멈춤
//			$kecoMap.model.baseObj.model.isPlay = false;
//			clearInterval($kecoMap.model.baseObj.model.timer);
		};
			
		pub.moveCenter = function(x,y, whflag,wh_code, whnm ) {
			
			var zoom = _CoreMap.getZoom();
			
			zoom = zoom-7;
			
			if(zoom < 10){
				_MapEventBus.trigger(_MapEvents.setZoom , 10);
			}
		
			if(x == null || y == null || x == "" || y == ""){
				return;
			}
			
			_MapEventBus.trigger(_MapEvents.map_move , {x:x, y:y});
			
			if(whflag != undefined && whflag == 'w') {
				setTimeout(function(){
					var obj = $kecoMap.model.baseObj.model.getWhData(wh_code);
					
//					if(obj != undefined) {
//						graphic.setAttributes(obj);
//						
//						obj.WH_NAME = whnm;
//						var contentHTML = '<ul>';
//						var hsize = 0;
//						for ( var i = 0; i < obj.msgs.length; i++)  {
//							contentHTML += '<li>'+obj.msgs[i]+'</li>'
//							hsize += 25;
//						}
//						var temp  = {
//							title:obj.WH_NAME,
//							content: contentHTML};
//						
//						graphic.setAttributes(obj);
//						graphic.setInfoTemplate(new esri.InfoTemplate(temp)); 
//						$kecoMap.view.map.infoWindow.resize(250, hsize+50);
//					} else {
//						graphic.setAttributes({});
//						graphic.attributes.FACI_NM = whnm
//						
//						graphic.setAttributes(graphic.attributes);
//						graphic.setInfoTemplate(new esri.InfoTemplate(NULL_TEMP)); 
//						$kecoMap.view.map.infoWindow.resize(250, 100);
//					}
					
				}, 1000);
			}
		};
		
		pub.moveCenterTm = function(x,y) {
			if(x=='' || y==''){
				return;
			}else{
				if(page.view.map.getLevel() < 6)
					page.view.map.setLevel(6);
			
				var wm = esri.geometry.geographicToWebMercator(new esri.geometry.Point(x,y));
				page.view.map.centerAt(wm);
			}
		};
		
		
		
		pub.sear = function() {
			page.view.tb.activate(esri.toolbars.Draw.POLYGON);
			page.view.map.graphics.clear();
			page.view.dtype = 0;
		};
		
		pub.coordMood = function(callBack) {
			if(callBack == undefined)
				return;
			
			page.view.dtype = 4;
			this.coordCallback = callBack;
		};
		
		pub.info = function() {
			$('#Image9').attr('class','on');
			$('#Image10').attr('class','off');
			$('#Image11').attr('class','off');
			$('#Image12').attr('class','off');
			$("#tool_buffer").hide();
			page.view.dtype = 7;
		}
		
		// 경보지점 
		pub.buffer = function() {
			$('#Image9').attr('class','off');
			$('#Image10').attr('class','on');
			$('#Image11').attr('class','off');
			$('#Image12').attr('class','off');
			$("#tool_buffer").show();
			
		}
		// 사고지점 
		pub.buffer_all = function() {
			$('#Image9').attr('class','off');
			$('#Image10').attr('class','off');
			$('#Image11').attr('class','on');
			$('#Image12').attr('class','off');
			$("#tool_buffer").show();
			page.view.dtype = 5;
		}
		
		//다중선택
		pub.buffer_drag = function() {
			$('#Image9').attr('class','off');
			$('#Image10').attr('class','off');
			$('#Image11').attr('class','off');
			$('#Image12').attr('class','on');
			$("#tool_buffer").hide();
			page.view.tb.activate(esri.toolbars.Draw.CIRCLE);
			page.view.map.graphics.clear();
			page.view.dtype = 6;
			this.toolbaridx = 6;
		}
		
		pub.drawSymbol = function(mevt) {
			page.view.map.infoWindow.hide();
			
			if(page.view.dtype == 0) {
				var params = new esri.tasks.BufferParameters();
				params.geometries  = [ mevt.mapPoint ];
				params.distances = [ 10 ];
				params.unit = esri.tasks.GeometryService.UNIT_KILOMETER;
				
				$kecoMap.view.gsvc.buffer(params, function(result){
					
					$kecoMap.view.map.graphics.clear();
				
					var symbol = new esri.symbol.SimpleFillSymbol(
						esri.symbol.SimpleFillSymbol.STYLE_NULL,
							new esri.symbol.SimpleLineSymbol(
								esri.symbol.SimpleLineSymbol.STYLE_SHORTDASHDOTDOT,
									new dojo.Color([105,105,105]), 
									2
							),new dojo.Color([255,255,0,0.25]));
				
				
					var bufferGeometry = result[0];
				
					
					var graphic = new esri.Graphic(bufferGeometry, symbol);
					$kecoMap.view.map.graphics.add(graphic);
				
					var query = new esri.tasks.Query();
					query.geometry = bufferGeometry;
					
					$kecoMap.view.featureLayer.selectFeatures(query, esri.layers.FeatureLayer.SELECTION_NEW, function(results){
						console.log('[FEATURE LAYER RESULT]', results);
					});
				});
			} else if (page.view.dtype == 2) {
				var pictureMarkerSymbol = new esri.symbol.PictureMarkerSymbol(window.location.origin+'/gis/images/p11.png', 15, 15);
				pictureMarkerSymbol.setOffset(5,5);
				page.view.map.graphics.add(new esri.Graphic(mevt.mapPoint, pictureMarkerSymbol));
			} else if(page.view.dtype == 3) {
				
				var pictureMarkerSymbol = new esri.symbol.PictureMarkerSymbol(window.location.origin+'/gis/images/38.png', 15, 15);
				pictureMarkerSymbol.setOffset(0,0);
					
				page.view.map.graphics.add(new esri.Graphic(mevt.mapPoint, pictureMarkerSymbol));
			} else if(page.view.dtype == 4) {
				var lonlat = esri.geometry.xyToLngLat(mevt.mapPoint.x, mevt.mapPoint.y);
				daum.coord2addr(lonlat[0], lonlat[1] , page.model.coordCallback); 
				page.view.dtype = -1;
			}else if(page.view.dtype == 5){
				if($('#Image11').attr('class') == 'on'){
					dobuffer_all(mevt);
				}
			}else if(page.view.dtype == 6){
				var identifyTask, identifyParams;
				var layer_Info;
				identifyTask = new esri.tasks.IdentifyTask($define.ARC_SERVER_URL+"/rest/services/WPCS/MapServer");
				
				identifyParams = new esri.tasks.IdentifyParameters();
			  	identifyParams.tolerance = 3;
	            identifyParams.returnGeometry = true;
	            identifyParams.layerIds = [36,37];
	            identifyParams.width = page.view.map.width;
	            identifyParams.height = page.view.map.height;
	            identifyParams.geometry = mevt.mapPoint;
	            identifyParams.mapExtent = page.view.map.extent;
	            identifyTask.execute(identifyParams, function (idResults) {
	            	if($('#Image9').attr('class') == 'on'){
		            	if(idResults != ''){
			            	if(idResults[0].layerId == '36'){
			            		layer_Info = '댐,'+idResults[0].feature.attributes.ID;
			            	}else if(idResults[0].layerId == '37'){
			            		layer_Info = '보,' +idResults[0].feature.attributes.BOOBSCD;
			            	}
		            	} 
	            	}
	            });
			}
		};
		
		pub.writeBuffer = function(type, obj, distances, callback) {
			if(type == '1') {
				
				/*if(!$('#38').attr('checked')) {
					$('#38').attr('checked', 'true');
					$kecoMap.model.updateLayerVisibility();
				}*/
				
				if(_CoreMap.getMap().getLayerForName('fLayer') != undefined) {
					_CoreMap.getMap().getLayerForName('fLayer').getSource().clear();
				}
				
				//버퍼 레이어가 존재하면 지우기
				if(_CoreMap.getMap().getLayerForName('bufferLayer') != undefined){
					_CoreMap.getMap().getLayerForName('bufferLayer').getSource().clear();	
				}
				
				//센터 이동
				$kecoMap.model.moveCenter(obj.longitude,obj.latitude);
				
				//좌표 변환하여 버러 레이어 생성
				var parser = new jsts.io.OL3Parser();
				var tempCoord = ol.proj.transform([obj.longitude,obj.latitude], 'EPSG:4326', 'EPSG:3857');				
				var feature = new ol.Feature({geometry:new ol.geom.Point(tempCoord)});
				// convert the OpenLayers geometry to a JSTS geometry
				var jstsGeom = parser.read(feature.getGeometry());
				// create a buffer of 40 meters around each line
				var buffered = jstsGeom.buffer(distances*1000); // 미터단위 10km 10*1000
				// convert back from JSTS and replace the geometry on the feature
				feature.setGeometry(parser.write(buffered));
				
				//버퍼 레이어 그리기
				page.view.bufferLayer.getSource().addFeature(feature);
				
				// EQUALS, DISJOINT, INTERSECTS, TOUCHES, CROSSES,  WITHIN, CONTAINS, OVERLAPS, RELATE, DWITHIN, BEYOND.
				var cqlFilter = "WITHIN(the_geom, POLYGON((";
				for(var a = 0 ; a < feature.getGeometry().getCoordinates()[0].length ; a++){
					if(a == feature.getGeometry().getCoordinates()[0].length-1 ){
						cqlFilter += feature.getGeometry().getCoordinates()[0][a][0] +' '+feature.getGeometry().getCoordinates()[0][a][1] + ')))';
					}else{
						cqlFilter += feature.getGeometry().getCoordinates()[0][a][0] +' '+feature.getGeometry().getCoordinates()[0][a][1] + ',';	
					}
				}
				
				// 방제업체 extent로 공간검색
				_MapService.getWfs(":PST_CMPNY" , "*" , cqlFilter).then(function(response) {
					
					//그리드에 넣을 데이터
					var results = [];
					if(response.features.length > 0 ){
						for(var i = 0 ; i < response.features.length; i++){
							//방제시설 featureLayer 그리기
							/*var fFeature = new ol.Feature({geometry:new ol.geom.Point(response.features[i].geometry.coordinates)});
							page.view.fLayer.getSource().addFeature(fFeature);*/
							results.push(response.features[i]);
						}
						
						if(callback != undefined){
							callback(results);
						}
					}
					
				})
				
				//return;
				//var wm = esri.geometry.geographicToWebMercator(new esri.geometry.Point(obj.longitude,obj.latitude));
				
				//page.view.map.centerAt(wm);
				
				/*var params = new esri.tasks.BufferParameters();
				params.geometries = [wm];
				params.distances = [distances];
				params.unit = esri.tasks.GeometryService.UNIT_KILOMETER;
				
				$kecoMap.view.gsvc.buffer(params, function(result){
//					$kecoMap.view.map.graphics.clear();
					$kecoMap.view.bufferLayer.clear();
					
					var symbol = new esri.symbol.SimpleFillSymbol(
						esri.symbol.SimpleFillSymbol.STYLE_SOLID,
						new esri.symbol.SimpleLineSymbol(
							esri.symbol.SimpleLineSymbol.STYLE_SHORTDASHDOTDOT,
								new dojo.Color([105,105,105]), 
								2
						),new dojo.Color([255,0,0,0.25])
					);
					
					
					$kecoMap.view.bufferLayer.add(new esri.Graphic(result[0], symbol));
				
					var query = new esri.tasks.Query();
					query.geometry = result[0];
					
					$kecoMap.view.fLayer = new esri.layers.FeatureLayer($define.ARC_SERVER_URL+"/rest/services/WPCS/MapServer/38",{
						mode: esri.layers.FeatureLayer.MODE_ONDEMAND,
//						infoTemplate: new esri.InfoTemplate(TEMPLATJSON),
						outFields: ["*"],
						id: "flayerLayer"
					});
					
					$kecoMap.view.fLayer.selectFeatures(query, esri.layers.FeatureLayer.SELECTION_NEW, function(results){
						if(callback != undefined){
							callback(results);
						}
					});
				});*/
				
			} else {
				
				//버퍼 레이어가 존재하면 지우기
				if(_CoreMap.getMap().getLayerForName('bufferLayer') != undefined){
					_CoreMap.getMap().getLayerForName('bufferLayer').getSource().clear();	
				}
				//_CoreMap.getMap().getLayerForName('whLayer').getSource().clear()
				
				
				//page.view.bufferLayer.getSource().addFeature(feature);
				$kecoMap.model.moveCenter(obj.longitude,obj.latitude);
				
				//좌표 변환하여 버러 레이어 생성
				var parser = new jsts.io.OL3Parser();
				var tempCoord = ol.proj.transform([obj.longitude,obj.latitude], 'EPSG:4326', 'EPSG:3857');				
				var feature = new ol.Feature({geometry:new ol.geom.Point(tempCoord)});
				// convert the OpenLayers geometry to a JSTS geometry
				var jstsGeom = parser.read(feature.getGeometry());
				// create a buffer of 40 meters around each line
				var buffered = jstsGeom.buffer(distances*1000); // 미터단위  10km 10*1000
				// convert back from JSTS and replace the geometry on the feature
				feature.setGeometry(parser.write(buffered));
				
				//버퍼 레이어 그리기
				page.view.bufferLayer.getSource().addFeature(feature);
				
				var whLayer = _CoreMap.getMap().getLayerForName('whLayer').getSource().getFeatures();
				//whLayer에 있는지 없는지 확인
				var results = [];
				for(var i = 0 ; i < whLayer.length; i ++){
					var whFeature = whLayer[i];
					var target = parser.read(whFeature.getGeometry());
					var interFeature = buffered.intersection(target);
					
					// 반경안에 feature 확인
					if(interFeature.getCoordinate()){
						//properties
						results.push(whFeature.getProperties());	
					}
				}	
				//그리드로 callback
				if(callback != undefined){
					callback(results);
				}
				
				// EQUALS, DISJOINT, INTERSECTS, TOUCHES, CROSSES,  WITHIN, CONTAINS, OVERLAPS, RELATE, DWITHIN, BEYOND.
				/*var cqlFilter = "WITHIN(the_geom, POLYGON((";
				for(var a = 0 ; a < feature.getGeometry().getCoordinates()[0].length ; a++){console.info(a)
					if(a == feature.getGeometry().getCoordinates()[0].length-1 ){
						cqlFilter += feature.getGeometry().getCoordinates()[0][a][0] +' '+feature.getGeometry().getCoordinates()[0][a][1] + ')))';
					}else{
						cqlFilter += feature.getGeometry().getCoordinates()[0][a][0] +' '+feature.getGeometry().getCoordinates()[0][a][1] + ',';	
					}
				}
				
				// 방제업체 extent로 공간검색
				_MapService.getWfs(":PST_CMPNY" , "*" , cqlFilter).then(function(response) {
					
					if(response.features.length > 0 ){
						for(var i = 0 ; i < response.features.length; i++){
							//방제시설 featureLayer 그리기
							var fFeature = new ol.Feature({geometry:new ol.geom.Point(response.features[i].geometry.coordinates)});
							page.view.fLayer.getSource().addFeature(fFeature);
							
						}
					}
					
				}*/
				
				
				/*
				$('#whLd').attr('checked', 'true');
				$kecoMap.view.whLayer.show();
				
				var wm = esri.geometry.geographicToWebMercator(new esri.geometry.Point(obj.longitude,obj.latitude));
				
				page.view.map.centerAt(wm);
				
				var params = new esri.tasks.BufferParameters();
				params.geometries  = [wm];
				params.distances = [distances];
				params.unit = esri.tasks.GeometryService.UNIT_KILOMETER;
				
				$kecoMap.view.gsvc.buffer(params, function(result){
//					$kecoMap.view.map.graphics.clear();
					$kecoMap.view.bufferLayer.clear();
					var symbol = new esri.symbol.SimpleFillSymbol(
							esri.symbol.SimpleFillSymbol.STYLE_SOLID,
						new esri.symbol.SimpleLineSymbol(
							esri.symbol.SimpleLineSymbol.STYLE_SHORTDASHDOTDOT,
								new dojo.Color([105,105,105]), 
								2
						),new dojo.Color([255,0,0,0.25])
					);
					
					$kecoMap.view.bufferLayer.add(new esri.Graphic(result[0], symbol));
					
					var query = new esri.tasks.Query();
					query.geometry = result[0];
					
					$kecoMap.view.whLayer.selectFeatures(query, esri.layers.FeatureLayer.SELECTION_NEW, function(results){
						if(callback != undefined){
							callback(results);
						}
					});
				});*/
			}
		};
		pub.drawEnded = function(geometry) {
			if(page.view.dtype == 0) {
				var symbol = page.view.tb.fillSymbol;
				page.view.map.graphics.add(new esri.Graphic(geometry, symbol));
				page.view.tb.deactivate();
				
				var q = new esri.tasks.Query();
				q.geometry = geometry;
				q.returnGeometry = true;
				q.outFields = ["*"];
				
//				var qt = new esri.tasks.QueryTask("http://118.37.180.151:5006/rest/services/map_weis_new_ver1_1/MapServer/4");
				var qt = new esri.tasks.QueryTask(ARC_SERVER_IP+':'+ARC_SERVER_PORT+"/rest/services/WPCS/MapServer/13");
				
				qt.execute(q, $kecoMap.controller.handleCounties2);
			} else if (page.view.dtype == 2) {
//				page.view.map.graphics.clear();
				page.view.gsvc.project([geometry],MAP_SPATIALREFERENCE , function(graphics){
					page.view.map.graphics.add(new esri.Graphic(geometry, page.view.tb.lineSymbol));
					
					var lengthParams = new esri.tasks.LengthsParameters();
					lengthParams.polylines = graphics;
					lengthParams.geodesic = true;
					lengthParams.lengthUnit = esri.tasks.GeometryService.UNIT_METER;
					
					$kecoMap.view.gsvc.lengths(lengthParams, function(result){
						var point = geometry.paths[0][geometry.paths[0].length-1];
						var textSymbol = new esri.symbol.TextSymbol(dojo.number.format(result.lengths[0] / 1000) + " Km");
						textSymbol.setOffset(35,-10);
						$kecoMap.view.map.graphics.add(new esri.Graphic(new esri.geometry.Point(point[0],point[1],$kecoMap.view.map.spatialReference), textSymbol));
						
						//$kecoMap.view.tb.deactivate();
						//this.toolbaridx = 2;
						//page.controller.setButtonImg('Image3','/gis/images/tool_3_off.gif');
					});
				});
			} else if(page.view.dtype == 3) {
				var areasAndLengthParams = new esri.tasks.AreasAndLengthsParameters();
				areasAndLengthParams.lengthUnit = esri.tasks.GeometryService.UNIT_KILOMETER;
				areasAndLengthParams.areaUnit = esri.tasks.GeometryService.UNIT_SQUARE_KILOMETERS;
				
				page.view.map.graphics.add(new esri.Graphic(geometry, page.view.tb.fillSymbol));
				
				$kecoMap.view.gsvc.simplify([geometry], function(simplifiedGeometries) 
				{
					areasAndLengthParams.polygons = simplifiedGeometries;
					$kecoMap.view.gsvc.areasAndLengths(areasAndLengthParams, function(result) {
						
						var point = geometry.rings[0][geometry.rings[0].length-3];
						var textSymbol = new esri.symbol.TextSymbol(dojo.number.format(result.areas[0])+" K㎢");
						textSymbol.setOffset(35,-10);
						$kecoMap.view.map.graphics.add(new esri.Graphic(new esri.geometry.Point(point[0],point[1],$kecoMap.view.map.spatialReference), textSymbol));
						
					});
				});
			} else if(page.view.dtype == 4) {
				page.view.tb.deactivate();
			}else if(page.view.dtype == 6){
				var layer_Info = "";
				var count=0;
				page.view.map.graphics.add(new esri.Graphic(geometry, page.view.tb.fillSymbol));
				page.view.tb.deactivate();
				var query = new esri.tasks.Query();
				 
				 query.geometry = geometry;
				 query.outFields = ["*"];
		        
		        //국가수질자동측정망
		        $kecoMap.view.autoLayer.queryFeatures(query,function(response){
		        	 for(var i=0; i<response.features.length;i++){
		        		 var info;
						 info ="국가수질자동측정망,"+response.features[i].attributes.FACT_CODE+","+ response.features[i].attributes.BRANCH_NO+".";
						 
						 layer_Info += info;
		        	 }
		        	 count++;
		        	 get_buffer_key(count,layer_Info);
		        });
		        
		        //IPUSN
		        $kecoMap.view.ipusnLayer.queryFeatures(query,function(response){
		        	 for(var i=0; i<response.features.length;i++){
		        		 var info;
						 info ="IPUSN,"+response.features[i].attributes.FACT_CODE+","+ response.features[i].attributes.BRANCH_NO+".";
						 
						 layer_Info += info;
		        	 }
		        	 count++;
		        	 get_buffer_key(count,layer_Info);
		        });
		        
		        //수질TMS
		        $kecoMap.view.tmsLayer.queryFeatures(query,function(response){
		        	 for(var i=0; i<response.features.length;i++){
		        		 var info;
						 info ="수질TMS,"+response.features[i].attributes.FACT_CODE+","+ response.features[i].attributes.BRANCH_NO+".";
						 
						 layer_Info += info;
		        	 }
		        	 count++;
		        	 get_buffer_key(count,layer_Info);
		        });
		        
		        //방제창고
		        $kecoMap.view.whLayer.queryFeatures(query,function(response){
		        	 for(var i=0; i<response.features.length;i++){
		        		 var info;
						 info ="방제창고,"+response.features[i].attributes.WH_CODE+".";
						 
						 layer_Info += info;
		        	 }
		        	 count++;
		        	 get_buffer_key(count,layer_Info);
		        });
		        //댐
		        if($kecoMap.view.damlayer == undefined){
			        $kecoMap.view.damlayer = new esri.layers.FeatureLayer($define.ARC_SERVER_URL+"/rest/services/WPCS/MapServer/36",{
						mode: esri.layers.FeatureLayer.MODE_ONDEMAND,
	//					infoTemplate: new esri.InfoTemplate(TEMPLATJSON),
						outFields: ["*"],
						id: "damlayer"
					});
		        }
		        $kecoMap.view.damlayer.queryFeatures(query,function(response){
		        	 for(var i=0; i<response.features.length;i++){
		        		 var info;
						 info ="댐,"+response.features[i].attributes.ID+".";
						 
						 layer_Info += info;
		        	 }
		        	 count++;
		        	 get_buffer_key(count,layer_Info);
		        });
		        //보
		        if($kecoMap.view.bolayer == undefined){
			        $kecoMap.view.bolayer = new esri.layers.FeatureLayer($define.ARC_SERVER_URL+"/rest/services/WPCS/MapServer/37",{
						mode: esri.layers.FeatureLayer.MODE_ONDEMAND,
	//					infoTemplate: new esri.InfoTemplate(TEMPLATJSON),
						outFields: ["*"],
						id: "bolayer"
					});
		        }
		        $kecoMap.view.bolayer.queryFeatures(query,function(response){
		        	 for(var i=0; i<response.features.length;i++){
		        		 var info;
						 info ="보,"+response.features[i].attributes.BOOBSCD+".";
						 
						 layer_Info += info;
		        	 }
		        	 count++;
		        	 get_buffer_key(count,layer_Info);
		        });
				this.toolbaridx = -1;
			}
		};
		
		pub.setOrderLayers = function(layers, url){
			if($kecoMap.view.orderLayers == null){
				$kecoMap.view.orderLayers = {};
			}
			
			_MapService.getWfs(':NTN_RVR','*').then(function(result){
				
				
				if(result == null || result.features.length <= 0){
					return;
				}
				
				var features = [];
				
				for(var i=0; i<result.features.length; i++){
					
					var featureProperties = result.features[i].properties;
					var featureCoordinate = result.features[i].geometry.coordinates;
					
					featureProperties.featureType = 'NTN_RVR';
					
					var feature = new ol.Feature({geometry:new ol.geom.Polygon(result.features[i].geometry.coordinates[0]), properties:featureProperties});
					features.push(feature);
				}
				
				$kecoMap.view.orderLayers['ntnRvr'] = new ol.layer.Vector({ 
						name : 'ntnRvrLayer',
						source : new ol.source.Vector({
							features : features
						}),
						visible: true
				}); 
				_MapEventBus.trigger(_MapEvents.map_addLayer, $kecoMap.view.orderLayers['ntnRvr']);
			});
			 
			_MapService.getWfs(':BO_OBS','*').then(function(result){
				
				if(result == null || result.features.length <= 0){
					return;
				}
				
				var features = [];
				
				for(var i=0; i<result.features.length; i++){
					
					var featureProperties = result.features[i].properties;
					var featureCoordinate = result.features[i].geometry.coordinates;
					
					featureProperties.featureType = 'BO_BOS';
					
					var feature = new ol.Feature({geometry:new ol.geom.Point(featureCoordinate), properties: featureProperties});
					features.push(feature);
				}
				
				$kecoMap.view.orderLayers['de4'] = new ol.layer.Vector({ 
						name : 'de4Layer',
						source : new ol.source.Vector({
							features : features
						}),
						visible: false,
						style : function(){
							return [new ol.style.Style({
								image: new ol.style.Icon({
									opacity: 1,
									src: url+layers[12].layerId+'/images/'+layers[12].url,
									crossOrigin: 'Anonymous'
								})
							})];
						}
				}); 
				_MapEventBus.trigger(_MapEvents.map_addLayer, $kecoMap.view.orderLayers['de4']);
			});
			
			_MapService.getWfs(':DAM_OBS','*').then(function(result){
				if(result == null || result.features.length <= 0){
					return;
				}
				
				var features = [];
				
				for(var i=0; i<result.features.length; i++){
					
					var featureProperties = result.features[i].properties;
					var featureCoordinate = result.features[i].geometry.coordinates;
					
					featureProperties.featureType = 'DAM_OBS';
					
					var feature = new ol.Feature({geometry:new ol.geom.Point(featureCoordinate), properties: featureProperties});
					features.push(feature);
				}
				
				$kecoMap.view.orderLayers['de5'] = new ol.layer.Vector({ 
						name : 'de5Layer',
						source : new ol.source.Vector({
							features : features
						}),
						visible: false,
						style : function(){
							return [new ol.style.Style({
								image: new ol.style.Icon({
									opacity: 1,
									src: url+layers[13].layerId+'/images/'+layers[13].url,
									crossOrigin: 'Anonymous'
								})
							})];
						}
				}); 
				_MapEventBus.trigger(_MapEvents.map_addLayer, $kecoMap.view.orderLayers['de5']);
			});
			
			_MapService.getWfs(':WTR_DEPOT','*').then(function(result){
				if(result == null || result.features.length <= 0){
					return;
				}
				
				var features = [];
				
				for(var i=0; i<result.features.length; i++){
					
					var featureProperties = result.features[i].properties;
					var featureCoordinate = result.features[i].geometry.coordinates;
					
					featureProperties.featureType = 'WTR_DEPOT';
					
					var feature = new ol.Feature({geometry:new ol.geom.Point(featureCoordinate), properties: featureProperties});
					features.push(feature);
				}
				
				$kecoMap.view.orderLayers['de6'] = new ol.layer.Vector({ 
						name : 'de6Layer',
						source : new ol.source.Vector({
							features : features
						}),
						visible: false,
						style : function(){
							return [new ol.style.Style({
								image: new ol.style.Icon({
									opacity: 1,
									src: url+layers[29].layerId+'/images/'+layers[29].url,
									crossOrigin: 'Anonymous'
								})
							})];
						}
				}); 
				_MapEventBus.trigger(_MapEvents.map_addLayer, $kecoMap.view.orderLayers['de6']);
			});
			
			_MapService.getWfs(':WTR_PRF','*').then(function(result){
				if(result == null || result.features.length <= 0){
					return;
				}
				var features = [];
				
				for(var i=0; i<result.features.length; i++){
					
					var featureProperties = result.features[i].properties;
					var featureCoordinate = result.features[i].geometry.coordinates;
					
					featureProperties.featureType = 'WTR_PRF';
					
					var feature = new ol.Feature({geometry:new ol.geom.Point(featureCoordinate), properties: featureProperties});
					features.push(feature);
				}
				$kecoMap.view.orderLayers['de7'] = new ol.layer.Vector({ 
						name : 'de7Layer',
						source : new ol.source.Vector({
							features : features
						}),
						visible: false,
						style : function(){
							return [new ol.style.Style({
								image: new ol.style.Icon({
									opacity: 1,
									src: url+layers[30].layerId+'/images/'+layers[30].url,
									crossOrigin: 'Anonymous'
								})
							})];
						}
				}); 
				_MapEventBus.trigger(_MapEvents.map_addLayer, $kecoMap.view.orderLayers['de7']);
			});
			
			_MapService.getWfs(':DAM','*').then(function(result){
				if(result == null || result.features.length <= 0){
					return;
				}
				var features = [];
				
				for(var i=0; i<result.features.length; i++){
					
					var featureProperties = result.features[i].properties;
					var featureCoordinate = result.features[i].geometry.coordinates;
					
					featureProperties.featureType = 'DAM';
					
					var feature = new ol.Feature({geometry:new ol.geom.Point(featureCoordinate), properties: featureProperties});
					features.push(feature);
				}
				$kecoMap.view.orderLayers['de8'] = new ol.layer.Vector({ 
						name : 'de8Layer',
						source : new ol.source.Vector({
							features : features
						}),
						visible: false,
						style : function(){
							return [new ol.style.Style({
								image: new ol.style.Icon({
									opacity: 1,
									src: url+layers[31].layerId+'/images/'+layers[31].url,
									crossOrigin: 'Anonymous'
								})
							})];
						}
				}); 
				_MapEventBus.trigger(_MapEvents.map_addLayer, $kecoMap.view.orderLayers['de8']);
			});
			
			_MapService.getWfs(':BO','*').then(function(result){
				if(result == null || result.features.length <= 0){
					return;
				}
				var features = [];
				
				for(var i=0; i<result.features.length; i++){
					
					var featureProperties = result.features[i].properties;
					var featureCoordinate = result.features[i].geometry.coordinates;
					
					featureProperties.featureType = 'BO';
					
					var feature = new ol.Feature({geometry:new ol.geom.Point(featureCoordinate), properties: featureProperties});
					features.push(feature);
				}
				$kecoMap.view.orderLayers['de9'] = new ol.layer.Vector({ 
						name : 'de9Layer',
						source : new ol.source.Vector({
							features : features
						}),
						visible: false, 
						style : function(){
							return [new ol.style.Style({
								image: new ol.style.Icon({
									opacity: 1,
									src: url+layers[32].layerId+'/images/'+layers[32].url,
									crossOrigin: 'Anonymous'
								})
							})];
						}
				}); 
				_MapEventBus.trigger(_MapEvents.map_addLayer, $kecoMap.view.orderLayers['de9']);
			});
		}
		
		pub.layerList ;
		// 레이어의 범례정보를 읽어와 레이어 on/off html 만듬
		pub.writeLayerLegend = function (url) {
			$.ajax({
				url: "/gis/js/layer.legend" ,
				dataType: 'text',
				success: function(data) {
					data = JSON.parse(data); 
					pub.layerList = data.layers;
					
					pub.setOrderLayers(data.layers, url);
					
					var html = '<ul><li class="tit">수질자동측정지점</li>';
					if(window.location.href.indexOf('goDetailFLUX') > -1 || window.location.href.indexOf('goDetailDam') > -1 || window.location.href.indexOf('psupport/list') > -1){
						html +='<li><label><input id="autoLd" type="checkbox" class="" onclick="$kecoMap.model.updateLayerVisibility(0);"/><img src="/gis/new_images/regular/auto_1.png" alt=""/> 국가수질자동측정망 </label></li>';
						html +='<li><label><input id="tmsLd" type="checkbox" class="" onclick="$kecoMap.model.updateLayerVisibility(1);"/><img src="/gis/new_images/regular/tms_1.png" alt=""/> 수질TMS </label></li>';
						html +='<li><label><input id="ipLd" type="checkbox" class="" onclick="$kecoMap.model.updateLayerVisibility(2);"/><img src="/gis/new_images/regular/usn_1.png" alt=""/> 이동형측정기기 </label></li>';
					}else{
						html +='<li><label><input id="autoLd" type="checkbox" checked class="" onclick="$kecoMap.model.updateLayerVisibility(0);"/><img src="/gis/new_images/regular/auto_1.png" alt=""/> 국가수질자동측정망 </label></li>';
						html +='<li><label><input id="tmsLd" type="checkbox" checked class="" onclick="$kecoMap.model.updateLayerVisibility(1);"/><img src="/gis/new_images/regular/tms_1.png" alt=""/> 수질TMS </label></li>';
						html +='<li><label><input id="ipLd" type="checkbox" checked class="" onclick="$kecoMap.model.updateLayerVisibility(2);"/><img src="/gis/new_images/regular/usn_1.png" alt=""/> 이동형측정기기 </label></li>';
					}
					
					html += '<ul><li class="tit">중요 시설물</li>';
					html +='<li><label><input id="de4" type="checkbox" class="" onclick="$kecoMap.model.updateLayerVisibility(4);"/><img src="'+url+data.layers[12].layerId+'/images/'+data.layers[12].url+'" alt=""/> '+data.layers[12].layerName+' </label></li>';
					html +='<li><label><input id="de5" type="checkbox" class="" onclick="$kecoMap.model.updateLayerVisibility(5);"/><img src="'+url+data.layers[13].layerId+'/images/'+data.layers[13].url+'" alt=""/> '+data.layers[13].layerName+' </label></li>';
					html +='<li><label><input id="de6" type="checkbox" class="" onclick="$kecoMap.model.updateLayerVisibility(6);"/><img src="'+url+data.layers[29].layerId+'/images/'+data.layers[29].url+'" alt=""/> '+data.layers[29].layerName+' </label></li>';
					html +='<li><label><input id="de7" type="checkbox" class="" onclick="$kecoMap.model.updateLayerVisibility(7);"/><img src="'+url+data.layers[30].layerId+'/images/'+data.layers[30].url+'" alt=""/> '+data.layers[30].layerName+' </label></li>';
					html +='<li><label><input id="de8" type="checkbox" class="" onclick="$kecoMap.model.updateLayerVisibility(8);"/><img src="'+url+data.layers[31].layerId+'/images/'+data.layers[31].url+'" alt=""/> '+data.layers[31].layerName+' </label></li>';
					html +='<li><label><input id="de9" type="checkbox" class="" onclick="$kecoMap.model.updateLayerVisibility(9);"/><img src="'+url+data.layers[32].layerId+'/images/'+data.layers[32].url+'" alt=""/> '+data.layers[32].layerName+' </label></li>';
					
					html += '</ul><ul><li class="tit">수질측정지점</li>';
					
					for ( var i = 0; i < data.layers.length; i++) {
						var l = data.layers[i];
						
						if((i > 11 && i < 14) || (i > 28 && i < 33)){
							continue;
						}
						
						html += '<li>'+
									'<label><input type="checkbox" class="list_item '+l.layerId+'" id="'+l.geoLayerId+'" onclick="$kecoMap.model.updateLayerVisibility();"/><img src="'+url+l.layerId+'/images/'+l.url+'" alt=""/> '+l.layerName+'</label>'+
								'</li>';
						
						if(l.layerId == '7') {
							html += '</ul>';
							html += '<ul><li class="tit">퇴적물조사지점</li>';
						} else if(l.layerId == '9') {
							html += '</ul>';
							html += '<ul><li class="tit">기타측정지점</li>';
						} else if(l.layerId == '18') {
							html += '</ul>';
							html += '<ul><li class="tit">환경기초시설</li>';
						} else if(l.layerId == '27') {
							html += '</ul>';
							html += '<ul><li class="tit">시설물</li>';
						} else if(l.layerId == '38') {
							html +='<li><label><input id="whLd" type="checkbox" class=""  onclick="$kecoMap.model.updateLayerVisibility(3);"/><img src="'+$define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/5/images/'+$define.ARC_SERVER_IMG_WH+'" alt=""/> 방제창고 </label></li>';
							html += '</ul>';
							html += '<ul><li class="tit">하천</li>';
						} else if(l.layerId == '41') {
							html += '</ul>';
							html += '<ul><li class="tit">수질영향권역</li>';
						} else if(l.layerId == '45') {
							html += '</ul>';
							html += '<ul><li class="tit">행정구역</li>';
						}
					}
					
					html += '</ul>';
					
					$('#chkInfoBx').html(html);
					
					setTimeout(function(){
						if(window.location.href.indexOf('goDetailFLUX') > -1){
							$('#11').attr('checked', true);
							$('#12').attr('checked', true);
						}
						
						if(window.location.href.indexOf('goDetailDam') > -1){
							$('#16').attr('checked', true);
						}
						
						$kecoMap.model.updateLayerVisibility();
						
						_MapEventBus.trigger(_MapEvents.layerLoaded, {});
						
					}, 500);
				}
			});
		};
		
		pub.markerData = [];
		
		// 지도위에 표출
		// type = 0 사고지점 , 1 = 방제창고, 2 = 진입지점 , 3 = 이탈 USN, 4 = 실시간, 5 = 주제도 
		pub.addMarker = function(type, x, y, obj, flag) {
			if(page.view.markerLayer == undefined)
				return;
			
			if(x == undefined || y == undefined)
				return;
			
			var nobj = {};
			nobj.type = type;
			obj.markerType = 'map';
			obj.iconType = type;
			
			nobj.x = x;
			nobj.y = y;
			nobj.obj = obj;
			
			if(flag == undefined){
				this.markerData.push(nobj);
			}
				
			var tempCoord = ol.proj.transform([parseFloat(x), parseFloat(y)], 'EPSG:4326', 'EPSG:3857');
			nobj.obj.featureType = 'MARKER';
			nobj.obj.markerIndex = this.markerData.length;
			
			var feature = new ol.Feature({geometry:new ol.geom.Point(tempCoord), properties: nobj.obj});
			
			page.view.markerLayer.getSource().addFeature(feature);
			
		};
		
		// 주제도 지도위에 표출
		// type = 0 사고지점 , 1 = 방제창고, 2 = 진입지점 , 3 = 이탈 USN, 4 = 실시간, 5 = 주제도
		pub.addMarkerTm = function(type, x, y, obj, flag, bermImg) {
			if(page.view.markerLayer == undefined)
				return;
			
			if(x == undefined || y == undefined)
				return;
			
			var nobj = {};
			nobj.type = type;
			obj.markerType = 'theme';
			obj.iconType = type;
			obj.iconImg = bermImg;
			
			nobj.x = x;
			nobj.y = y;
			nobj.obj = obj;
			
			if(flag == undefined){
				this.markerData.push(nobj);
			}
			
			var tempCoord = ol.proj.transform([parseFloat(x), parseFloat(y)], 'EPSG:4326', 'EPSG:3857');
			nobj.obj.featureType = 'MARKER';
			var feature = new ol.Feature({geometry:new ol.geom.Point(tempCoord), properties: nobj.obj});
			
			page.view.markerLayer.getSource().addFeature(feature);
			
		};
		
		pub.markerClear = function() {
			if(page.view.markerLayer){
				page.view.markerLayer.getSource().clear();
			} 
			this.markerData = [];
		};
		
		

		pub.LayerAuthIn = function(FACT_CODE,BRANCH_NO,SYS) {
			
			if(user_roleCode == "ROLE_ADMIN") return true;
			
			return_value = false;
			
			for(var i =0; i<myAuthorSessionFactCode.length;i++) {
				switch(SYS){
				case  "W" :
					if(FACT_CODE == myAuthorSessionFactCode[i]) return true;
					break ;
				case "A" :
				case "U" :
					
					if(FACT_CODE + "-" + BRANCH_NO == myAuthorSessionAllFactCode[i]) return true;
					break;
				} 
			}
				
			return return_value;
		}
		
		pub.getMargerSymbolTm = function(bermImg) {
			var size = 30;
			
			var level = page.view.map.getLevel();
			if(level < 3)
				size = 30;
			else if( level < 8)
				size = 50;
			else
				size = 80;
			
			var img = '/gis/images/'+bermImg+'_'+size+'.png';
			
			var pictureMarkerSymbol = new esri.symbol.PictureMarkerSymbol(img, size, size);
			pictureMarkerSymbol.setOffset(parseInt(size/2),parseInt(size/2));
			return pictureMarkerSymbol;
		};
		
		pub.getInfoTemplate = function(type) {
			var infoTemplate = undefined;
			
			if(type == 0 || type >= 10 || type <= 14)
				infoTemplate = new esri.InfoTemplate(EVENT_TEMP);
			else if(type == 1)
				infoTemplate = new esri.InfoTemplate("${지점명}","${*}");
			else if(type == 2)
				infoTemplate = new esri.InfoTemplate("${branch_no}","${*}");
			else if(type == 3)
				infoTemplate = new esri.InfoTemplate(OUT_TEMP);
			else if(type == 4)
				infoTemplate = new esri.InfoTemplate(CR_TEMP);
//			else if(type == 5)
//				infoTemplate = new esri.InfoTemplate(TM_TEMP);
			
			return infoTemplate;
		};
		
		pub.initFeatureLayer = function(event, alertData) {
			
			if(alertData != null){
				if(Array.isArray(alertData)){
					$kecoMap.model.alertData = alertData;
				}else{
					$kecoMap.model.alertData = [alertData];
				}
			}
			
			$kecoMap.model.addAllLayer(1);
			
		};
		pub.mouseOverOnFeature = function(event, data){
			 var pixel = _CoreMap.getMap().getEventPixel(data.result.originalEvent);
			 
			 var feature = _CoreMap.getMap().forEachFeatureAtPixel(pixel, function(feature, layer) {
				 return feature;
			 });
			
			 if(currentFeature == feature){
				 return;
			 }
			 
			 currentFeature = feature;
			 
			 if(feature){
				 var featureInfo = feature.getProperties().properties;
				 
				 var tempTitle = '';
				 if(featureInfo){
					 if(featureInfo.featureType == 'AUTO'){
						 
						var return_flag = false;
						try{
							var obj = $kecoMap.model.baseObj.model.getCheckData('A', featureInfo.FACT_CODE, featureInfo.BRANCH_NO);
							if(obj != null){
								return_flag = $kecoMap.model.LayerAuthIn(obj.FACT_CODE,obj.BRANCH_NO,"U");
							}
							if(layerInfoDiv == null) {
								layerInfoDiv = document.createElement('div');	
							}
							
							if(return_flag){ 
								
								var themeObj = $kecoMap.model.getThemeAutoData(featureInfo.FACT_CODE, featureInfo.BRANCH_NO);
								
								if(obj != undefined) {
									var alertData = $kecoMap.model.baseObj.model.getAlertData(featureInfo.FACT_CODE, featureInfo.BRANCH_NO);
									
									if(themeObj != undefined && $main.view.excessChk.attr('checked')) {
										layerInfoDiv.innerHTML = AUTO_TEMP_THEME;
									} else if( alertData != undefined) {
										obj.ALERT_MSG = alertData.ALERT_MSG;
										layerInfoDiv.innerHTML = AUTO_TEMP_ALERT;
										
									} else {
										layerInfoDiv.innerHTML = AUTO_TEMP;
									}
								} else {
									layerInfoDiv.innerHTML = NULL_TEMP;
								}
							}
						}catch(e) {}

						if(return_flag){ 
							var html = '<dl class="info_box" style="">'+
			                '<dt>가평청평하수</dt>'+
			                '<dd>'+
			                    '<dl class="summary">'+ 
			                    	'<dt>수신시간</dt>'+
			                       ' <dd class="L0">2019/00/00 00:00</dd>'+
			                   ' </dl>'+
			                    '<dl class="summary">'+
			                    	'<dt>권역</dt>'+
			                        '<dd>수도권</dd>'+
			                    '</dl>'+
			                    '<table class="st02 MgT10" summary="측정소 항목별 측정값">'+
			                        '<caption></caption>'+
			                        '<colgroup>'+
			                        	'<col width="60" />'+
			                            '<col width="50" />'+
			                            '<col width="50" />'+
			                            '<col />'+
			                       ' </colgroup>'+
			                       ' <thead>'+
			                           ' <tr>'+
			                               ' <th>항목</th>'+
			                                '<th>측정값</th>'+
			                                '<th>단위</th>'+
			                                '<th>기준</th>'+
			                         '   </tr>'+
			                        '</thead>'+
			                        '<tbody>'+
			                            '<tr>'+
			                               ' <td>pH</td>'+
			                               ' <td>6.60</td>'+
			                               ' <td>-</td>'+
			                               ' <td>(5.80~8.60)</td>'+
			                           ' </tr>'+
			                           ' <tr>'+
			                                '<td>BOD</td>'+
			                               ' <td>-</td>'+
			                                '<td>ppm</td>'+
			                                '<td>-</td>'+
			                           ' </tr>'+
			                            '<tr>'+
			                                '<td>COD</td>'+
			                                '<td>2.80</td>'+
			                                '<td>ppm</td>'+
			                               ' <td>(0.00~20.00)</td>'+
			                          '  </tr>'+
			                           ' <tr>'+
			                                '<td>SS</td>'+
			                                '<td>0.86</td>'+
			                                '<td>mg/L</td>'+
			                                '<td>(0.00~10.00)</td>'+
			                           ' </tr>'+
			                           ' <tr>'+
			                               ' <td>T-N</td>'+
			                                '<td>4.38</td>'+
			                               ' <td>mg/L</td>'+
			                               ' <td>(0.00~20.00)</td>'+
			                           ' </tr>'+
			                           ' <tr>'+
			                                '<td>T-P</td>'+
			                                '<td>0.11</td>'+
			                                '<td>mg/L</td>'+
			                                '<td>(0.00~0.20)</td>'+
			                            '</tr>   '+                         
			                        '</tbody>'+
			                    '</table>'+
			                '</dd>'+
			          '  </dl>';
			            
							layerInfoDiv.innerHTML = html; 
							
							var zoom = _CoreMap.getZoom()-7;
							var offset = [-133 , -2];
							
							if(zoom < 2) {
								offset = [-137 , -2];
							}
							
							if(layerInfoOverlay){
								layerInfoOverlay.setPosition( feature.getGeometry().getCoordinates() );	
								layerInfoOverlay.setOffset(offset);
							}else{
								layerInfoOverlay = new ol.Overlay({
									element: layerInfoDiv,
									offset: offset,
									positioning: 'center-center'
								}); 
								 
								_MapEventBus.trigger(_MapEvents.map_addOverlay, layerInfoOverlay);
							}
						} 
						 console.log('auto on over');
					 } else if(featureInfo.featureType == 'TMS'){
						 console.log('tms on over');
					 } else if(featureInfo.featureType == 'IPUSN'){
						 console.log('ipusn on over');
					 } else if(featureInfo.featureType == 'BO'){
						 console.log('BO on over');
					 } else if(featureInfo.featureType == 'DAM'){
						 console.log('DAM on over');
					 } else if(featureInfo.featureType == 'WTR_PRF'){
						 console.log('WTR_PRF on over');
					 } else if(featureInfo.featureType == 'WTR_DEPOT'){
						 console.log('WTR_DEPOT on over');
					 } else if(featureInfo.featureType == 'DAM_OBS'){
						 console.log('DAM_OBS on over');
					 } else if(featureInfo.featureType == 'BO_OBS'){
						 console.log('BO_OBS on over');
					 } else if(featureInfo.featureType == 'MARKER'){
						 //pub.markerOverlay
						 if(featureInfo.iconType == 0 || featureInfo.iconType >= 10 || featureInfo.iconType <= 14){
							 //featureInfo.markerIndex
							 //infoTemplate = new esri.InfoTemplate(EVENT_TEMP);
							 html = EVENT_TEMP.content;
						 }else if(featureInfo.iconType == 1){
						 	 //infoTemplate = new esri.InfoTemplate("${지점명}","${*}");
							 html = "${지점명}","${*}";
						 }else if(featureInfo.iconType == 2){
						 	 //infoTemplate = new esri.InfoTemplate("${branch_no}","${*}");
							 html = "${branch_no}","${*}";
						 }else if(featureInfo.iconType == 3){
						 	 //infoTemplate = new esri.InfoTemplate(OUT_TEMP);
							 html = OUT_TEMP.content;
						 }else if(featureInfo.iconType == 4){
						 	 //infoTemplate = new esri.InfoTemplate(CR_TEMP);
							 html = CR_TEMP.content;
						 }
					 }
				 }
			 }else{
				 if(layerInfoOverlay){
					 layerInfoOverlay.setPosition(undefined);
				 }
			 }
		};
		
		
		pub.onClickOnFeature = function(event, data){
			 var pixel = _CoreMap.getMap().getEventPixel(data.result.originalEvent);
			 
			 var feature = _CoreMap.getMap().forEachFeatureAtPixel(pixel, function(feature, layer) {
				 return feature;
			 });
			 
			 if(feature){
				 var featureInfo = feature.getProperties().properties;
				 if(featureInfo){
					 if(featureInfo.featureType == 'AUTO'){
						 $('#system').val('A');
						 $('#system').trigger('change');
						 $kecoMap.model.baseObj.model.reloadDataForFact(featureInfo.FACT_CODE, featureInfo.RV_CD);
						
//							if($('#Image9').attr('class') == 'on'){
//							}else if($('#Image10').attr('class') == 'on'){
//								dobuffer("a",evt);
//							}
						
					 } else if(featureInfo.featureType == 'TMS'){
						 $('#system').val('W');
						 $('#system').trigger('change');
						 $kecoMap.model.baseObj.model.reloadDataForFact(featureInfo.FACT_CODE);
					 } else if(featureInfo.featureType == 'IPUSN'){
						 $('#system').val('U');
						 $('#system').trigger('change');
						 $kecoMap.model.baseObj.model.reloadDataForFact(featureInfo.FACT_CODE, featureInfo.RV_CD, featureInfo.BRANCH_NO);
						 
						 
//							 if($('#Image9').attr('class') == 'on'){
//							 }else if($('#Image10').attr('class') == 'on'){
//								 dobuffer("u",evt);
//							 }
					 }else if(featureInfo.featureType == 'BO'){
						 console.log('BO on click');
					 }else if(featureInfo.featureType == 'DAM'){
						 console.log('DAM on click');
					 }else if(featureInfo.featureType == 'WTR_PRF'){
						 console.log('WTR_PRF on click');
					 }else if(featureInfo.featureType == 'WTR_DEPOT'){
						 console.log('WTR_DEPOT on click');
					 }else if(featureInfo.featureType == 'DAM_OBS'){
						 console.log('DAM_OBS on click');
					 }else if(featureInfo.featureType == 'BO_OBS'){
						 console.log('BO_OBS on click');
					 }else if(featureInfo.featureType == 'MARKER'){
						 console.log('MARKER on click');
						 if(featureInfo.datatype == 'AC'){
							 window.open("/waterpollution/waterPollutionDetail.do?clickMenu=32120&wpCode="+featureInfo.wpcode, 
										'wpView','width='+window.screen.width+',height='+window.screen.height+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left=0,top=0');
						 }
					 } 
				 }
			 } 
		};
		
		pub.addTMSLayer = function(level) {
			var firstFlag = false;
			if($kecoMap.view.tmsLayer == null){
				var firstFlag = true;
				var rvCd = 'A';
				
				if(user_riverid != undefined &&  user_riverid != 'null'){
					rvCd = user_riverid;
				}
				
				$.ajax({
					url:'/psupport/jsps/getTMSGeo.jsp?rvCd='+rvCd,
					dataType:"text",
					success:function(result){
						var data = JSON.parse(result);
						var tmsFeatures = [];
						
						for(var i=0; i<data.length; i++){
							var tempCoord = ol.proj.transform([parseFloat(data[i].X), parseFloat(data[i].Y)], 'EPSG:4326', 'EPSG:3857');
							
							data[i].featureType = 'TMS';
							
							var feature = new ol.Feature({geometry:new ol.geom.Point(tempCoord), properties: data[i]});
							tmsFeatures.push(feature);
						}
						var isVisibled = false;
						
						if( $('#tmsLd').attr('checked')){
							isVisibled = true;
						}
						
						$kecoMap.view.tmsLayer = new ol.layer.Vector({ 
								name : 'tmsLayer',
								source : new ol.source.Vector({
									features : tmsFeatures
								}),
								visible: isVisibled,
								style : $kecoMap.model.tmsStyleFunction
						}); 
 
						_MapEventBus.trigger(_MapEvents.map_addLayer, $kecoMap.view.tmsLayer);
					}, 
					error:function(result){  
					}
				});
			}
		};
		
		pub.tmsStyleFunction = function(feature, resolution){
			
			var zoom = _CoreMap.getZoom()-7;
			var dirNm = 'regular';
			
			if(zoom < 2) {
				dirNm = 'small';
			}
			
			var symbol1 = '/gis/new_images/'+dirNm+'/tms_1.png';
			
//			var symbol1 = window.location.origin+'/gis/images/auticon/t_1.png';
			var symbol2 = window.location.origin+'/gis/images/auticon/t_2.png';
			var symbol3 = window.location.origin+'/gis/images/auticon/t_3.png';
			var symbol4 = window.location.origin+'/gis/images/auticon/t_4.png';
			var symbol5 = window.location.origin+'/gis/images/auticon/t_5.png';
			var symbol6 = window.location.origin+'/gis/images/auticon/t_6.png';
			var symbol7 = window.location.origin+'/gis/images/auticon/t_7.png';
			
			var tmsIconUrl = symbol1;
			
			var featureInfo = feature.getProperties().properties;
			
			for ( var i = 0; i < $kecoMap.model.baseObj.model.tmsData.length; i++)  {
				var a = $kecoMap.model.baseObj.model.tmsData[i];
				
				if(featureInfo.FACT_CODE == a.FACT_CODE && featureInfo.BRANCH_NO == a.BRANCH_NO){
					if(a.VALUE == "1"){
						tmsIconUrl =  symbol1;
					} else if(a.VALUE == "2"){
						tmsIconUrl =  symbol2;
					} else if(a.VALUE == "3"){
						tmsIconUrl =  symbol3;
					} else if(a.VALUE == "4"){
						tmsIconUrl =  symbol4;
					} else if(a.VALUE == "M"){
						tmsIconUrl =  symbol6;
					} else if(a.VALUE == "C"){
						tmsIconUrl =  symbol5;
					} else if(a.VALUE == "L"){
						tmsIconUrl =  symbol7;
					}
				}
			}
			
			return [new ol.style.Style({
						image: new ol.style.Icon({
							opacity: 1,
							src: tmsIconUrl,
							crossOrigin: 'Anonymous'
						})
					})];
		}

		pub.addipusnLayer = function(level) {
			var firstFlag = false;
			if($kecoMap.view.ipusnLayer == null){
				var firstFlag = true;
				var rvCd = 'A';
				
				if(user_riverid != undefined &&  user_riverid != 'null'){
					rvCd = user_riverid;
				}
				
				$.ajax({
					url:'/psupport/jsps/getIPUSNGeo.jsp?rvCd='+rvCd,
					dataType:"text",
					success:function(result){
						var data = JSON.parse(result);
						var ipusnFeatures = [];
						
						for(var i=0; i<data.length; i++){
							var tempCoord = ol.proj.transform([parseFloat(data[i].X), parseFloat(data[i].Y)], 'EPSG:4326', 'EPSG:3857');
							
							data[i].featureType = 'IPUSN';
							
							var feature = new ol.Feature({geometry:new ol.geom.Point(tempCoord), properties: data[i]});
							ipusnFeatures.push(feature);
						}
						var isVisibled = false;
						
						if( $('#ipLd').attr('checked')){
							isVisibled = true; 
						}
						
						$kecoMap.view.ipusnLayer = new ol.layer.Vector({ 
								name : 'ipusnLayer',
								source : new ol.source.Vector({
									features : ipusnFeatures
								}),
								visible: isVisibled,
								style : $kecoMap.model.ipusnStyleFunction
						}); 
 
						_MapEventBus.trigger(_MapEvents.map_addLayer, $kecoMap.view.ipusnLayer);
					}, 
					error:function(result){  
					}
				});
			}
		};
		pub.ipusnStyleFunction = function(feature, resolution){
			
			var zoom = _CoreMap.getZoom()-7;
			var dirNm = 'regular';
			
			if(zoom < 2) {
				dirNm = 'small';
			}
			
			var symbol = '/gis/new_images/'+dirNm+'/usn_1.png';
			
//			var symbol  = $define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/2/images/'+$define.ARC_SERVER_IMG_USN1;
			var symbol1 = $define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/2/images/'+$define.ARC_SERVER_IMG_USN2;
			var symbol2 = $define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/2/images/'+$define.ARC_SERVER_IMG_USN3;
			var symbol3 = $define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/2/images/'+$define.ARC_SERVER_IMG_USN4;
			var symbol4 = $define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/2/images/'+$define.ARC_SERVER_IMG_USN5;
			var symbol5 = $define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/2/images/'+$define.ARC_SERVER_IMG_USN6;
			var symbol6 = $define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/2/images/'+$define.ARC_SERVER_IMG_USN7;
			
			var ipusnIconUrl = symbol;
			
			var featureInfo = feature.getProperties().properties;
			
			for ( var i = 0; i < $kecoMap.model.baseObj.model.ipusnData.length; i++)  {
				var a = $kecoMap.model.baseObj.model.ipusnData[i];
				
				if(featureInfo.FACT_CODE == a.FACT_CODE && featureInfo.BRANCH_NO == a.BRANCH_NO){
					if(a.VALUE == "1"){
						ipusnIconUrl =  symbol1;
					} else if(a.VALUE == "2"){
						ipusnIconUrl =  symbol2;
					} else if(a.VALUE == "3"){
						ipusnIconUrl =  symbol3;
					} else if(a.VALUE == "4"){
						ipusnIconUrl =  symbol4;
					} else if(a.VALUE == "M"){
						ipusnIconUrl =  symbol5;
					} else if(a.VALUE == "C"){
						ipusnIconUrl =  symbol6;
					} else if(a.VALUE == "L"){
						ipusnIconUrl =  symbol6;
					}
				}
			}
			
			for ( var i = 0; i < $kecoMap.model.alertData.length; i++) {
				var a = $kecoMap.model.alertData[i];
				
				if(featureInfo.FACT_CODE == a.FACT_CODE && featureInfo.BRANCH_NO == a.BRANCH_NO){
					if(a.SYS_KIND == "U"){
						if(a.ALERT_LEVEL == 1){
							ipusnIconUrl =  symbol1;
						} else if(a.ALERT_LEVEL == 2){
							ipusnIconUrl =  symbol2;
						} else if(a.ALERT_LEVEL == 3){
							ipusnIconUrl =  symbol3;
						} else if(a.ALERT_LEVEL == 4){
							ipusnIconUrl =  symbol4;
						} else if(a.ALERT_LEVEL == "M"){
							ipusnIconUrl =  symbol5;
						} else if(a.ALERT_LEVEL == "C"){
							ipusnIconUrl =  symbol6;
						} else if(a.ALERT_LEVEL == "L"){
							ipusnIconUrl =  symbol6;
						}
					}
				}
			}
			
			return [new ol.style.Style({
						image: new ol.style.Icon({
							opacity: 1,
							src: ipusnIconUrl,
							crossOrigin: 'Anonymous'
						})
					})];
		}

		pub.addAutoLayer = function(level) {
			
			var firstFlag = false;
			if($kecoMap.view.autoLayer == null){
				var firstFlag = true;
				var rvCd = 'A';
				
				if(user_riverid != undefined &&  user_riverid != 'null'){
					rvCd = user_riverid;
				}
				
				$.ajax({
					url:'/psupport/jsps/getAutoGeo.jsp?rvCd='+rvCd,
					dataType:"text",
					success:function(result){
						var data = JSON.parse(result);
						var autoFeatures = [];
						
						for(var i=0; i<data.length; i++){
							var tempCoord = ol.proj.transform([parseFloat(data[i].X), parseFloat(data[i].Y)], 'EPSG:4326', 'EPSG:3857');
							
							data[i].featureType = 'AUTO';
							
							var feature = new ol.Feature({geometry:new ol.geom.Point(tempCoord), properties: data[i]});
							autoFeatures.push(feature);
						}
						var isVisibled = false;
						
						if( $('#autoLd').attr('checked')){
							isVisibled = true;
						}
						
						$kecoMap.view.autoLayer = new ol.layer.Vector({ 
								name : 'autoLayer',
								source : new ol.source.Vector({
									features : autoFeatures
								}),
								visible: isVisibled,
								style : $kecoMap.model.autoStyleFunction
						}); 
 
						_MapEventBus.trigger(_MapEvents.map_addLayer, $kecoMap.view.autoLayer);
					}, 
					error:function(result){  
					}
				});
			}
		};
		pub.autoStyleFunction = function(feature, resolution){
			
			var zoom = _CoreMap.getZoom()-7;
			
			var dirNm = 'regular';
			var offsetX = 13;
			var offsetY = 20;
			
			if(zoom < 2) {
				dirNm = 'small';
				offsetX = 9;
				offsetY = 15;
			}
			
			var symbol = '/gis/new_images/'+dirNm+'/auto_1.png';
			
			var symbol1 = $define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/1/images/'+$define.ARC_SERVER_IMG_AUTO2;
			var symbol2 = $define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/1/images/'+$define.ARC_SERVER_IMG_AUTO3;
			var symbol3 = $define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/1/images/'+$define.ARC_SERVER_IMG_AUTO4;
			var symbol4 = $define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/1/images/'+$define.ARC_SERVER_IMG_AUTO5;
			var symbol5 = $define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/1/images/'+$define.ARC_SERVER_IMG_AUTO6;
			var symbol6 = $define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/1/images/'+$define.ARC_SERVER_IMG_AUTO7;
			
			console.log(symbol);
			console.log(symbol1);
			console.log(symbol2);
			console.log(symbol3);
			console.log(symbol4);
			console.log(symbol5);
			console.log(symbol6);
			
			var autoIconUrl = symbol;
			
			var featureInfo = feature.getProperties().properties;
			
			for ( var i = 0; i < $kecoMap.model.baseObj.model.autoData.length; i++) {
				var a = $kecoMap.model.baseObj.model.autoData[i];
				
				if(featureInfo.FACT_CODE == a.FACT_CODE){
					if(a.VALUE == "1") {
						autoIconUrl =  symbol1;
						
					} else if(a.VALUE == "2"){
						autoIconUrl =  symbol2;
					} else if(a.VALUE == "3"){
						autoIconUrl =  symbol3;
					} else if(a.VALUE == "4"){
						autoIconUrl =  symbol4;
					} else if(a.VALUE == "M"){
						autoIconUrl =  symbol5;
					} else if(a.VALUE == "C"){
						autoIconUrl =  symbol6;
					} else if(a.VALUE == "L"){
						autoIconUrl =  symbol6;
					}
				}
			}
			
			for ( var i = 0; i < $kecoMap.model.alertData.length; i++) {
				var a = $kecoMap.model.alertData[i];
				
				if(a.SYS_KIND == "A"){
					if(featureInfo.FACT_CODE == a.FACT_CODE){
						if(a.ALERT_LEVEL == 1){
							autoIconUrl =  symbol1;
						} else if(a.ALERT_LEVEL == 2){
							autoIconUrl =  symbol2;
						} else if(a.ALERT_LEVEL == 3){
							autoIconUrl =  symbol3;
						} else if(a.ALERT_LEVEL == 4){
							autoIconUrl =  symbol4;
						} else if(a.ALERT_LEVEL == "M"){
							autoIconUrl =  symbol5;
						} else if(a.ALERT_LEVEL == "C"){
							autoIconUrl =  symbol6;
						} else if(a.ALERT_LEVEL == "L"){
							autoIconUrl =  symbol6;
						}
					}
				}
			}
			
			return [new ol.style.Style({
						image: new ol.style.Icon({
							opacity: 1,
							src: autoIconUrl,
							anchor: [0, 1],
							crossOrigin: 'Anonymous'
						}) 
					})];  
		}
		
		pub.addWhLayer = function(level) {
			var firstFlag = false;
			if($kecoMap.view.whLayer == null){
				var firstFlag = true;
				$.ajax({
					url:'/psupport/jsps/getWHGeo.jsp',
					dataType:"text",
					success:function(result){
						var data = JSON.parse(result);
						var whFeatures = [];
						
						for(var i=0; i<data.length; i++){
							var tempCoord = ol.proj.transform([parseFloat(data[i].X), parseFloat(data[i].Y)], 'EPSG:4326', 'EPSG:3857');
							
							data[i].featureType = 'WH';
							
							var feature = new ol.Feature({geometry:new ol.geom.Point(tempCoord), properties: data[i]});
							whFeatures.push(feature);
						}
						var isVisibled = false;
						
						if( $('#whLd').attr('checked')){
							isVisibled = true;
						}
						
						$kecoMap.view.whLayer = new ol.layer.Vector({ 
								name : 'whLayer',
								source : new ol.source.Vector({
									features : whFeatures
								}),
								visible: true,
								style : $kecoMap.model.whStyleFunction
						}); 
 
						_MapEventBus.trigger(_MapEvents.map_addLayer, $kecoMap.view.whLayer);
					}, 
					error:function(result){  
					}
				});
			}
		};
		
		pub.whStyleFunction = function(feature, resolution){
			
			var zoom = _CoreMap.getZoom()-7;
			
			var dirNm = 'regular';
			if(zoom < 2) {
				dirNm = 'small';
			}
			
			var whIconUrl = '/gis/new_images/'+dirNm+'/wh.png';
			
//			var whIconUrl = $define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/5/images/'+$define.ARC_SERVER_IMG_WH;
			
			return [new ol.style.Style({
						image: new ol.style.Icon({
							opacity: 1,
							src: whIconUrl,
							crossOrigin: 'Anonymous'
						})
					})];
		}
		
		pub.addAllLayer = function(level) {
			this.addAutoLayer(level);
			this.addipusnLayer(level);
			this.addTMSLayer(level);
			this.addWhLayer(level);
		};
		
		pub.init = function() {
			
		};
		return pub;
	}());

	// TODO MVC::view 관련 코드 작성
	page.view = ( function() {
		// ////////////////////////////
		// private variables
		// ////////////////////////////
		
		// ////////////////////////////
		// private functions
		// ////////////////////////////
		
		// ////////////////////////////
		// public functions
		// ////////////////////////////
		var pub = {};
		
		// View 초기화
		var pub = {};
		pub.map = null;
		
		pub.lcnt=0;
		
		pub.queryTask = null;
		pub.query = null;
		
		pub.gsvc = null;
		pub.tb = null;
		
		pub.vworldLayer = null;
		pub.vworldSatelliteLayer = null;
		pub.vworldHybridLayer = null;
		
		pub.mainLayer = null;
		
		pub.autoLayer = null;
		pub.ipusnLayer = null;
		pub.tmsLayer = null;
		pub.tempBLayer = null;
		
		pub.markerLayer = null;
		pub.markerSource = null;
		pub.bufferLayer = null;
		
		pub.markerOverlay = [];
		
		pub.fLayer = null;
		
		pub.dtype = -1; // 0 = 버퍼 , 2 = 길이 , 3 = 면적 , 4 = 좌표 얻기
		pub.overviewDiv = null;
		
		pub.markerStyleFunction = function(feature, resolution){
			
			var level = _CoreMap.getZoom() - 7;
		
			var featureInfo = feature.getProperties().properties;
			
			var size = 30;
			var img; 
			
			var hw = 30;
			
			if(featureInfo.markerType == 'map'){
				
				if(featureInfo.iconType == 0 || featureInfo.iconType == 3 || featureInfo.iconType == 5) {
					if(level < 3)
						size = 30;
					else if( level < 8)
						size = 50;
					else
						size = 80;
				} else if( featureInfo.iconType == 2 ) {
					if(level < 4)
						size = 16;
					else
						size = 32;
				} else if(featureInfo.iconType == 4) {
					if(level < 4)
						size = 16;
					else
						size = 24;
				}
				
				var img = '/gis/images/event'+size+'.gif';
				
				if(featureInfo.iconType == 1)
					img = '/gis/images/event'+size+'.gif';
				else if(featureInfo.iconType == 2)
					img = '/gis/images/flag'+size+'.gif';
				else if(featureInfo.iconType == 3)
					img = '/gis/images/rss_'+size+'.gif';
				else if(featureInfo.iconType == 4)
					img = '/gis/images/rss'+size+'.png';
				
				/**
				 * 2014.10.27 주제도 관련 추가
				 * kyr
				 */
				else if(featureInfo.iconType == 5)
					img = '/gis/images/circle6_'+size+'.png';
				
				/**
				 * 2014.10.27 주제도 관련 추가
				 * 사고현황 아이콘
				 */
				else if(featureInfo.iconType == 10){
					img = '/gis/images/watereventSTA.gif';
					size = 40;
				} else if(featureInfo.iconType == 11){
					img = '/gis/images/watereventPA.gif';
					size = 40;
				} else if(featureInfo.iconType == 12){
					img = '/gis/images/watereventPB.gif';
					size = 40;
				} else if(featureInfo.iconType == 13){
					img = '/gis/images/watereventPC.gif';
					size = 40;
				} else if(featureInfo.iconType == 14){
					img = '/gis/images/watereventPD.gif';
					size = 40;
				}
			}else{
				
				if(level < 3)
					size = 30;
				else if( level < 8)
					size = 50;
				else
					size = 80;
				
				img = '/gis/images/'+featureInfo.iconImg+'_'+size+'.png';
			}
			
			hw = size;
			
//			pictureMarkerSymbol.setOffset(parseInt(size/2),parseInt(size/2));
			 
			if($kecoMap.view.markerOverlay[featureInfo.markerIndex]){
				_MapEventBus.trigger(_MapEvents.map_removeOverlay, $kecoMap.view.markerOverlay[featureInfo.markerIndex]);
			}
			
			var img1 = document.createElement("IMG");
			img1.height = hw;
			img1.width = hw;
			img1.src = img;
			
			var marker = new ol.Overlay({
				  position: feature.getGeometry().getCoordinates(),
				  positioning: 'center-center',
				  element: img1, 
				  stopEvent: false
			});
			
			
			_MapEventBus.trigger(_MapEvents.map_addOverlay, marker);
			
			$kecoMap.view.markerOverlay[featureInfo.markerIndex] = marker;
			
 			return [new ol.style.Style({
				image: new ol.style.Icon({
					opacity: 1,
					src: img,
					crossOrigin: 'Anonymous'
				})
			})];
		}
		
		// View 초기화
		pub.init = function() {
			
			page.view.markerLayer = new ol.layer.Vector({ 
					name : 'markerLayer',
					source : new ol.source.Vector({ }),
					style : page.view.markerStyleFunction
			}); 
			 
			_MapEventBus.trigger(_MapEvents.map_addLayer, page.view.markerLayer);
			
			
			page.view.bufferLayer = new ol.layer.Vector({ 
					name : 'bufferLayer',
					source : new ol.source.Vector({ })
			}); 
			 
			_MapEventBus.trigger(_MapEvents.map_addLayer, page.view.bufferLayer);
			
			page.view.fLayer = new ol.layer.Vector({ 
					name : 'fLayer',
					source : new ol.source.Vector({ }),
					style : [new ol.style.Style({
						image: new ol.style.Icon({
							opacity: 1,
							src: '/gis/images/watereventSTA.gif', // test symbol
							crossOrigin: 'Anonymous'
						})
					})]
			}); 
			 
			_MapEventBus.trigger(_MapEvents.map_addLayer, page.view.fLayer);
			
			page.model.writeLayerLegend($define.ARC_SERVER_URL+'/rest/services/WPCS/MapServer/');
		};
		return pub; 
	}());
	
	// TODO MVC::controller 관련 코드 작성
	page.controller = ( function() {
		// ////////////////////////////
		// private variables
		// ////////////////////////////
		
		// ////////////////////////////
		// private functions
		// ////////////////////////////

		// ////////////////////////////
		// public functions
		// ////////////////////////////
		var pub = {};
		
			
		pub.setButtonImg = function(img , src) {
			$('#'+img).attr('src', src);
		};
		
		pub.MM_swapImgRestore = function(img, src) { //v3.0
			
			if($('#'+img).attr('idx') == $kecoMap.model.toolbaridx || $('#'+img).attr('idx') == $kecoMap.model.mapidx)
				return;
			
			$('#'+img).attr('src', src);
		};
		pub.MM_swapImage = function(img, src) { //v3.0
			$('#'+img).attr('src', src);
		};
		
		pub.showLoading = function() {
			if($("#loadingDiv") == undefined)
				return;
			
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
					$(this).parents(".ui-dialog:first").css("width", "85px");
					$(this).parents(".ui-dialog:first").css("height", "75px");
					$(this).parents(".ui-dialog:first").css("overflow", "hidden");
					$("#loadingDiv").css("float", "left");
				},
				width:0,
				height:0,
				showCaption:false,
				resizable:false
			});
			
			$("#loadingDiv").dialog("open");
		};
		
		pub.closeLoading = function() {
			if($("#loadingDiv") != undefined)
				$("#loadingDiv").dialog("close");
		};
		// Controller 초기화
		pub.init = function() {
			// Model 과 View 초기화
			page.view.init();
			
			// ///////////////////
			// 이벤트 핸들러 등록
			// ///////////////////
			page.model.init();
			
			try {
				$kecoMap.model.baseObj = $main;
				$kecoMap.model.baseObj.model.intervalEvent();
				setInterval($kecoMap.model.baseObj.model.intervalEvent, 600000);
			}catch(e){
				try {
					$kecoMap.model.baseObj = $control;
					
					$kecoMap.model.baseObj.model.intervalEvent();
					setInterval($kecoMap.model.baseObj.model.intervalEvent, 600000);
				} catch(e) {
				}
			}
			
			if(window.location.href.indexOf('addrMap') > -1){
				$kecoMap.model.addAllLayer(1);
			}
			
			_MapEventBus.on(_MapEvents.initFeatureLayer, page.model.initFeatureLayer);
			
			_MapEventBus.on(_MapEvents.map_mousemove, page.model.mouseOverOnFeature); 
			_MapEventBus.on(_MapEvents.map_mousemove, page.model.mouseOutOnFeature);
			
			_MapEventBus.on(_MapEvents.map_singleclick, page.model.onClickOnFeature);
		}; 

		return pub;
	}());
	
	$(document).ready(page.controller.init);
	
	$kecoMap = page;
});

//tool - 레이어 속성조회
function layer_onClick(LAYER_NM,FACT_CODE,BRANCH_NO){
	var layer_Info = LAYER_NM +","+FACT_CODE+","+BRANCH_NO;
	//alert(layer_Info);
}

//tool - 레이어 반경내 검색(국가수질, 수질 ipusn)
function dobuffer(layerName,evt){
	var layer_Info = "";
	var params = new esri.tasks.BufferParameters();
	var p_distance = $('#tool_buffer_txt').val();
	params.geometries = [ evt.graphic.geometry ];
	params.distances = [ p_distance ];
	params.unit = esri.tasks.GeometryService.UNIT_KILOMETER;
	params.outSpatialReference = map.spatialReference;
	$kecoMap.view.gsvc.buffer(params, function(results){
		$kecoMap.view.map.graphics.clear();
		
		if($kecoMap.view.map.getLayer("buffer_graphicsLayer_au")!=undefined){
			$kecoMap.view.map.removeLayer($kecoMap.view.map.getLayer("buffer_graphicsLayer_au"));
		}
		var symbol = new esri.symbol.SimpleFillSymbol(
		        esri.symbol.SimpleFillSymbol.STYLE_SOLID,
		        new esri.symbol.SimpleLineSymbol(
		          esri.symbol.SimpleLineSymbol.STYLE_SOLID,
		          new dojo.Color([0,0,255,0.65]), 2
		        ),
		        new dojo.Color([0,0,255,0.35])
		      );
		 dojo.forEach(results, function(geometry) {
		        var graphic = new esri.Graphic(geometry,symbol);
		        //$kecoMap.view.map.graphics.add(graphic);
		        var layer = new esri.layers.GraphicsLayer(
		        		{id:"buffer_graphicsLayer_au"}
		        		);
		        layer.add(graphic);
		        $kecoMap.view.map.addLayer(layer);
		        $kecoMap.view.map.reorderLayer(layer,1);
			 var query = new esri.tasks.Query();
			 
			 query.geometry = geometry;
			 query.outFields = ["*"];
		
			 if(layerName == 'a'){
				 $kecoMap.view.autoLayer.queryFeatures(query,function(response){
					 for(var i=0; i<response.features.length;i++){
						 var info;
						 if(response.features[i].geometry == evt.graphic.geometry){
							 info = "!국가수질자동측정망,"+response.features[i].attributes.FACT_CODE+","+ response.features[i].attributes.BRANCH_NO+".";
						 }else{
							 info = "국가수질자동측정망,"+response.features[i].attributes.FACT_CODE+","+ response.features[i].attributes.BRANCH_NO+".";
						 }
						 
						 layer_Info += info;
						 /*if((response.features.length-1) > i){
							 layer_Info += info + ".";
						 }
						 else{
							 layer_Info += info;
						 }*/
					 }
					 //alert(layer_Info);
					 selectWaterPop(layer_Info);
				 });
			 }else if(layerName == 'u'){
				
				 $kecoMap.view.ipusnLayer.queryFeatures(query,function(response){
					
					 for(var i=0; i<response.features.length;i++){
						 var info;
						 if(response.features[i].geometry == evt.graphic.geometry){
							 info = "!IPUSN,"+response.features[i].attributes.FACT_CODE+","+ response.features[i].attributes.BRANCH_NO+".";
						 }else{
							 info ="IPUSN,"+response.features[i].attributes.FACT_CODE+","+ response.features[i].attributes.BRANCH_NO+".";
						 }
						 
						 layer_Info += info;
						 /*if((response.features.length-1) > i){
							 layer_Info += info + ".";
						 }
						 else{
							 layer_Info += info;
						 }*/
					 }
					 selectWaterPop(layer_Info);
				 });
			 }
		     
		 });
		$kecoMap.view.map.setExtent(results[0].getExtent().expand(2));
	});
}

function dobuffer_all(evt){
	var layer_Info = "";
	var params = new esri.tasks.BufferParameters();
	var p_distance = $('#tool_buffer_txt').val();
	params.geometries = [ evt.mapPoint ];
	params.distances = [ p_distance ];
	params.unit = esri.tasks.GeometryService.UNIT_KILOMETER;
	params.outSpatialReference = map.spatialReference;

	$kecoMap.view.gsvc.buffer(params, function(results){
		$kecoMap.view.map.graphics.clear();
		
		var symbol = new esri.symbol.SimpleFillSymbol(
		        esri.symbol.SimpleFillSymbol.STYLE_SOLID,
		        new esri.symbol.SimpleLineSymbol(
		          esri.symbol.SimpleLineSymbol.STYLE_SOLID,
		          new dojo.Color([0,0,255,0.65]), 2
		        ),
		        new dojo.Color([0,0,255,0.35])
		      );
		 dojo.forEach(results, function(geometry) {
			 var count=0;
			 var graphic = new esri.Graphic(geometry,symbol);
		        $kecoMap.view.map.graphics.add(graphic);
		        
		        var query = new esri.tasks.Query();
				 
				 query.geometry = geometry;
				 query.outFields = ["*"];
		        
		        //국가수질자동측정망
		        $kecoMap.view.autoLayer.queryFeatures(query,function(response){
		        	 for(var i=0; i<response.features.length;i++){
		        		 var info;
						 if(response.features[i].geometry == evt.mapPoint){
							 info = "!국가수질자동측정망,"+response.features[i].attributes.FACT_CODE+","+ response.features[i].attributes.BRANCH_NO+".";
						 }else{
							 info ="국가수질자동측정망,"+response.features[i].attributes.FACT_CODE+","+ response.features[i].attributes.BRANCH_NO+".";
						 }
						 
						 layer_Info += info;
						/* if((response.features.length) > i){
							 layer_Info += info + ".";
						 }
						 else{
							 layer_Info += info + ".";
						 }*/
		        	 }
		        	 count++;
		        	 get_buffer_key(count,layer_Info);
		        });
		        
		        //IPUSN
		        $kecoMap.view.ipusnLayer.queryFeatures(query,function(response){
		        	 for(var i=0; i<response.features.length;i++){
		        		 var info;
						 if(response.features[i].geometry == evt.mapPoint){
							 info = "!IPUSN,"+response.features[i].attributes.FACT_CODE+","+ response.features[i].attributes.BRANCH_NO+".";
						 }else{
							 info ="IPUSN,"+response.features[i].attributes.FACT_CODE+","+ response.features[i].attributes.BRANCH_NO+".";
						 }
						 
						layer_Info += info;
						/* if((response.features.length) > i){
							 layer_Info += info + ".";
						 }
						 else{
							 layer_Info += info + ".";
						 }*/
		        	 }
		        	 count++;
		        	 get_buffer_key(count,layer_Info);
		        });
		        
		        //수질TMS
		        $kecoMap.view.tmsLayer.queryFeatures(query,function(response){
		        	 for(var i=0; i<response.features.length;i++){
		        		 var info;
		        		 
						 if(response.features[i].geometry == evt.mapPoint){
							 info = "!수질TMS,"+response.features[i].attributes.FACT_CODE+","+ response.features[i].attributes.BRANCH_NO+".";
						 }else{
							 info ="수질TMS,"+response.features[i].attributes.FACT_CODE+","+ response.features[i].attributes.BRANCH_NO+".";
						 }
						 
						 layer_Info += info;
						 /*if((response.features.length) > i){
							 layer_Info += info + ".";
						 }
						 else{
							 layer_Info += info + ".";
						 }*/
		        	 }
		        	 count++;
		        	 get_buffer_key(count,layer_Info);
		        });
		        
		        //방제창고
		        $kecoMap.view.whLayer.queryFeatures(query,function(response){
		        	 for(var i=0; i<response.features.length;i++){
		        		 var info;
						 if(response.features[i].geometry == evt.mapPoint){
							 info = "!방제창고,"+response.features[i].attributes.WH_CODE+".";
						 }else{
							 info ="방제창고,"+response.features[i].attributes.WH_CODE+".";
						 }
						 
						 layer_Info += info;
						 /*if((response.features.length) > i){
							 layer_Info += info + ".";
						 }
						 else{
							 layer_Info += info + ".";
						 }*/
		        	 }
		        	 count++;
		        	 get_buffer_key(count,layer_Info);
		        });
		        
		       
		        //댐
		        if($kecoMap.view.damlayer == undefined){
			        $kecoMap.view.damlayer = new esri.layers.FeatureLayer($define.ARC_SERVER_URL+"/rest/services/WPCS/MapServer/36",{
						mode: esri.layers.FeatureLayer.MODE_ONDEMAND,
	//					infoTemplate: new esri.InfoTemplate(TEMPLATJSON),
						outFields: ["*"],
						id: "damlayer"
					});
		        }
		        $kecoMap.view.damlayer.queryFeatures(query,function(response){
		        	 for(var i=0; i<response.features.length;i++){
		        		 var info;
						 if(response.features[i].geometry == evt.mapPoint){
							 info = "!댐,"+response.features[i].attributes.ID+".";
						 }else{
							 info ="댐,"+response.features[i].attributes.ID+".";
						 }
						 
						 layer_Info += info;
						 /*if((response.features.length) > i){
							 layer_Info += info + ".";
						 }
						 else{
							 layer_Info += info + ".";
						 }*/
		        	 }
		        	 count++;
		        	 get_buffer_key(count,layer_Info);
		        });
		        //보
		        if($kecoMap.view.bolayer == undefined){
			        $kecoMap.view.bolayer = new esri.layers.FeatureLayer($define.ARC_SERVER_URL+"/rest/services/WPCS/MapServer/37",{
						mode: esri.layers.FeatureLayer.MODE_ONDEMAND,
	//					infoTemplate: new esri.InfoTemplate(TEMPLATJSON),
						outFields: ["*"],
						id: "bolayer"
					});
		        }
		        $kecoMap.view.bolayer.queryFeatures(query,function(response){
		        	 for(var i=0; i<response.features.length;i++){
		        		 var info;
						 if(response.features[i].geometry == evt.mapPoint){
							 info = "!보,"+response.features[i].attributes.BOOBSCD+".";
						 }else{
							 info ="보,"+response.features[i].attributes.BOOBSCD+".";
						 }
						 
						 layer_Info += info;
						 /*if((response.features.length) > i){
							 layer_Info += info + ".";
						 }
						 else{
							 layer_Info += info + ".";
						 }*/
		        	 }
		        	 count++;
		        	 get_buffer_key(count,layer_Info);
		        });
		        
		 });
		$kecoMap.view.map.setExtent(results[0].getExtent().expand(2));
	});
}

function get_buffer_key(count,layer_Info){
	if(count == 6){
		selectAllWaterPop(layer_Info);
	}
}


