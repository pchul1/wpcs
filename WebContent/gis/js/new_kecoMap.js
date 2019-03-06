
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
					};//////////
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
				var inputs = dojo.query(".list_item");
			//in this application layer 2 is always on.
				this.visibleLayers = [];
				
				for (var i=0, il=inputs.length; i<il; i++) {
					if (inputs[i].checked) {
						this.visibleLayers.push(inputs[i].id);
					}
				}
			//if there aren't any layers visible set the array value to = -1
				if(this.visibleLayers.length === 0){
					this.visibleLayers.push(-1);
				}
				pub.visibleLayers = this.visibleLayers;
				page.view.mainLayer.setVisibleLayers(this.visibleLayers);
				
			} else if(idx == 0) {
				if($('#autoLd').attr('checked')){
					$kecoMap.view.autoLayer.show();
				} else {
					$kecoMap.view.autoLayer.hide();
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
			} else if( idx == 1)
			{
				if($('#tmsLd').attr('checked'))
					$kecoMap.view.tmsLayer.show();
				else
					$kecoMap.view.tmsLayer.hide();
			} else if( idx == 2) {
				if($('#ipLd').attr('checked'))
					$kecoMap.view.ipusnLayer.show();
				else
					$kecoMap.view.ipusnLayer.hide();
				
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
						$kecoMap.view.whLayer.show();
					else
						$kecoMap.view.whLayer.hide();
			}else{
				if($('#de'+idx).attr('checked')){
					$kecoMap.view.orderLayers['de'+idx].show();
				}else{
					$kecoMap.view.orderLayers['de'+idx].hide();
				}
			}
			
			//범례 선택의 경우 무조건 이동 멈춤
//			$kecoMap.model.baseObj.model.isPlay = false;
//			clearInterval($kecoMap.model.baseObj.model.timer);
		};
			
		pub.moveCenter = function(x,y, whflag,wh_code, whnm ) {
			if(page.view.map.getLevel() < 6)
				page.view.map.setLevel(6);
		
			var wm = esri.geometry.geographicToWebMercator(new esri.geometry.Point(x,y));
			page.view.map.centerAt(wm);
			
			if(whflag != undefined && whflag == 'w') {
				setTimeout(function(){
					var point = new esri.geometry.ScreenPoint($kecoMap.view.map.width/2, $kecoMap.view.map.height/2);
					var obj = $kecoMap.model.baseObj.model.getWhData(wh_code);
					
					var graphic = new esri.Graphic(undefined, undefined);
					
					if(obj != undefined)
					{
						graphic.setAttributes(obj);
						
						obj.WH_NAME = whnm;
						var contentHTML = '<ul>';
						var hsize = 0;
						for ( var i = 0; i < obj.msgs.length; i++) 
						{
							contentHTML += '<li>'+obj.msgs[i]+'</li>'
							hsize += 25;
						}
						var temp  = {
							title:obj.WH_NAME,
							content: contentHTML};
						
						graphic.setAttributes(obj);
						graphic.setInfoTemplate(new esri.InfoTemplate(temp)); 
						$kecoMap.view.map.infoWindow.resize(250, hsize+50);
					}
					else
					{
						graphic.setAttributes({});
						graphic.attributes.FACI_NM = whnm
						
						graphic.setAttributes(graphic.attributes);
						graphic.setInfoTemplate(new esri.InfoTemplate(NULL_TEMP)); 
						$kecoMap.view.map.infoWindow.resize(250, 100);
					}
					
					$kecoMap.view.map.infoWindow.setContent(graphic.getContent());
					$kecoMap.view.map.infoWindow.setTitle(graphic.getTitle());
					$kecoMap.view.map.infoWindow.show(point,$kecoMap.view.map.getInfoWindowAnchor(point));
					
				}, 1000);
			}
		};
		
		pub.moveCenterTm = function(x,y)
		{
			if(x=='' || y==''){
				return;
			}else{
				if(page.view.map.getLevel() < 6)
					page.view.map.setLevel(6);
			
				var wm = esri.geometry.geographicToWebMercator(new esri.geometry.Point(x,y));
				page.view.map.centerAt(wm);
			}
		};
		
		
		
		pub.sear = function()
		{
			page.view.tb.activate(esri.toolbars.Draw.POLYGON);
			page.view.map.graphics.clear();
			page.view.dtype = 0;
		};
		
		pub.coordMood = function(callBack)
		{
			if(callBack == undefined)
				return;
			
			page.view.dtype = 4;
			this.coordCallback = callBack;
		};
		
		pub.info = function()
		{
			$('#Image9').attr('class','on');
			$('#Image10').attr('class','off');
			$('#Image11').attr('class','off');
			$('#Image12').attr('class','off');
			$("#tool_buffer").hide();
			page.view.dtype = 7;
		}
		
		// 경보지점 
		pub.buffer = function()
		{
			$('#Image9').attr('class','off');
			$('#Image10').attr('class','on');
			$('#Image11').attr('class','off');
			$('#Image12').attr('class','off');
			$("#tool_buffer").show();
			
		}
		// 사고지점 
		pub.buffer_all = function()
		{
			$('#Image9').attr('class','off');
			$('#Image10').attr('class','off');
			$('#Image11').attr('class','on');
			$('#Image12').attr('class','off');
			$("#tool_buffer").show();
			page.view.dtype = 5;
		}
		
		//다중선택
		pub.buffer_drag = function()
		{
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
		pub.drawSymbol = function(mevt)
		{
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
				if(!$('#38').attr('checked')) {
					$('#38').attr('checked', 'true');
					$kecoMap.model.updateLayerVisibility();
				}
				if($kecoMap.view.fLayer != undefined) {
					page.view.map.removeLayer($kecoMap.view.fLayer);
					$kecoMap.view.fLayer = undefined;
				}
				
				var wm = esri.geometry.geographicToWebMercator(new esri.geometry.Point(obj.longitude,obj.latitude));
				
				page.view.map.centerAt(wm);
				
				var params = new esri.tasks.BufferParameters();
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
				});
			} else {
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
				});
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
			var h = 34;
			var w = 21;
			var y = 13;
			
			$kecoMap.view.orderLayers['de4'] = new esri.layers.FeatureLayer($define.ARC_SERVER_URL+"/rest/services/WPCS/MapServer/15",{
					mode: esri.layers.FeatureLayer.MODE_ONDEMAND,
					outFields: ["*"],
					id: "de4Layer"
			});
			$kecoMap.view.orderLayers['de4'].hide();
			var symbol = new esri.symbol.PictureMarkerSymbol({ "url":url+layers[12].layerId+'/images/'+layers[12].legend[0].url, "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var rend = new esri.renderer.SimpleRenderer(symbol);
			$kecoMap.view.orderLayers['de4'].setRenderer(rend);
			$kecoMap.view.map.addLayer($kecoMap.view.orderLayers['de4'], 5);
			
			dojo.connect($kecoMap.view.orderLayers['de4'], "onMouseOver", function(evt) {
				var graphic = new esri.Graphic(undefined, undefined);
				
				var return_flag = false;
				try{
					var paramData = $.extend({}, {}, evt.graphic.attributes);
					graphic.setAttributes(paramData);
					graphic.setInfoTemplate(new esri.InfoTemplate(TEMP_DE['de4']));
					page.view.map.infoWindow.resize(250, 100);
					page.model.showInfoWindow(graphic, evt);
				}catch(e) {}
			});
			dojo.connect($kecoMap.view.orderLayers['de4'], "onMouseOut", function(evt) {
				page.view.map.infoWindow.hide();
			});
			
			$kecoMap.view.orderLayers['de5'] = new esri.layers.FeatureLayer($define.ARC_SERVER_URL+"/rest/services/WPCS/MapServer/16",{
				mode: esri.layers.FeatureLayer.MODE_ONDEMAND,
				outFields: ["*"],
				id: "de5Layer"
			});
			$kecoMap.view.orderLayers['de5'].hide();
			var symbol = new esri.symbol.PictureMarkerSymbol({ "url":url+layers[13].layerId+'/images/'+layers[13].legend[0].url, "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var rend = new esri.renderer.SimpleRenderer(symbol);
			$kecoMap.view.orderLayers['de5'].setRenderer(rend);
			$kecoMap.view.map.addLayer($kecoMap.view.orderLayers['de5'], 5);
			
			dojo.connect($kecoMap.view.orderLayers['de5'], "onMouseOver", function(evt) {
				var graphic = new esri.Graphic(undefined, undefined);
				
				var return_flag = false;
				try{
					var paramData = $.extend({}, {}, evt.graphic.attributes);
					graphic.setAttributes(paramData);
					graphic.setInfoTemplate(new esri.InfoTemplate(TEMP_DE['de5']));
					page.view.map.infoWindow.resize(250, 170);
					page.model.showInfoWindow(graphic, evt);
				}catch(e) {}
			});
			dojo.connect($kecoMap.view.orderLayers['de5'], "onMouseOut", function(evt) {
				page.view.map.infoWindow.hide();
			});
			
			$kecoMap.view.orderLayers['de6'] = new esri.layers.FeatureLayer($define.ARC_SERVER_URL+"/rest/services/WPCS/MapServer/34",{
				mode: esri.layers.FeatureLayer.MODE_ONDEMAND,
				outFields: ["*"],
				id: "de6Layer"
			});
			$kecoMap.view.orderLayers['de6'].hide();
			var symbol = new esri.symbol.PictureMarkerSymbol({ "url":url+layers[29].layerId+'/images/'+layers[29].legend[0].url, "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var rend = new esri.renderer.SimpleRenderer(symbol);
			$kecoMap.view.orderLayers['de6'].setRenderer(rend);
			$kecoMap.view.map.addLayer($kecoMap.view.orderLayers['de6'], 5);
			
			dojo.connect($kecoMap.view.orderLayers['de6'], "onMouseOver", function(evt) {
				var graphic = new esri.Graphic(undefined, undefined);
				
				var return_flag = false;
				try{
					var paramData = $.extend({}, {}, evt.graphic.attributes);
					graphic.setAttributes(paramData);
					graphic.setInfoTemplate(new esri.InfoTemplate(TEMP_DE['de6']));
					page.view.map.infoWindow.resize(250, 390);
					page.model.showInfoWindow(graphic, evt);
				}catch(e) {}
			});
			dojo.connect($kecoMap.view.orderLayers['de6'], "onMouseOut", function(evt) {
				page.view.map.infoWindow.hide();
			});
			
			$kecoMap.view.orderLayers['de7'] = new esri.layers.FeatureLayer($define.ARC_SERVER_URL+"/rest/services/WPCS/MapServer/35",{
				mode: esri.layers.FeatureLayer.MODE_ONDEMAND,
				outFields: ["*"],
				id: "de7Layer"
			});
			$kecoMap.view.orderLayers['de7'].hide();
			var symbol = new esri.symbol.PictureMarkerSymbol({ "url":url+layers[30].layerId+'/images/'+layers[30].legend[0].url, "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var rend = new esri.renderer.SimpleRenderer(symbol);
			$kecoMap.view.orderLayers['de7'].setRenderer(rend);
			$kecoMap.view.map.addLayer($kecoMap.view.orderLayers['de7'], 5);
			
			dojo.connect($kecoMap.view.orderLayers['de7'], "onMouseOver", function(evt) {
				var graphic = new esri.Graphic(undefined, undefined);
				
				var return_flag = false;
				try{
					var paramData = $.extend({}, {}, evt.graphic.attributes);
					graphic.setAttributes(paramData);
					graphic.setInfoTemplate(new esri.InfoTemplate(TEMP_DE['de7']));
					page.view.map.infoWindow.resize(250, 390);
					page.model.showInfoWindow(graphic, evt);
				}catch(e) {}
			});
			dojo.connect($kecoMap.view.orderLayers['de7'], "onMouseOut", function(evt) {
				page.view.map.infoWindow.hide();
			});
			
			$kecoMap.view.orderLayers['de8'] = new esri.layers.FeatureLayer($define.ARC_SERVER_URL+"/rest/services/WPCS/MapServer/36",{
				mode: esri.layers.FeatureLayer.MODE_ONDEMAND,
				outFields: ["*"],
				id: "de8Layer"
			});
			$kecoMap.view.orderLayers['de8'].hide();
			var symbol = new esri.symbol.PictureMarkerSymbol({ "url":url+layers[31].layerId+'/images/'+layers[31].legend[0].url, "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var rend = new esri.renderer.SimpleRenderer(symbol);
			$kecoMap.view.orderLayers['de8'].setRenderer(rend);
			$kecoMap.view.map.addLayer($kecoMap.view.orderLayers['de8'], 5);
			
			dojo.connect($kecoMap.view.orderLayers['de8'], "onMouseOver", function(evt) {
				var graphic = new esri.Graphic(undefined, undefined);
				
				var return_flag = false;
				try{
					var paramData = $.extend({}, {}, evt.graphic.attributes);
					graphic.setAttributes(paramData);
					graphic.setInfoTemplate(new esri.InfoTemplate(TEMP_DE['de8']));
					page.view.map.infoWindow.resize(250, 150);
					page.model.showInfoWindow(graphic, evt);
				}catch(e) {}
			});
			dojo.connect($kecoMap.view.orderLayers['de8'], "onMouseOut", function(evt) {
				page.view.map.infoWindow.hide();
			});
			
			$kecoMap.view.orderLayers['de9'] = new esri.layers.FeatureLayer($define.ARC_SERVER_URL+"/rest/services/WPCS/MapServer/37",{
				mode: esri.layers.FeatureLayer.MODE_ONDEMAND,
				outFields: ["*"],
				id: "de9Layer"
			});
			$kecoMap.view.orderLayers['de9'].hide();
			var symbol = new esri.symbol.PictureMarkerSymbol({ "url":url+layers[32].layerId+'/images/'+layers[32].legend[0].url, "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var rend = new esri.renderer.SimpleRenderer(symbol);
			$kecoMap.view.orderLayers['de9'].setRenderer(rend);
			$kecoMap.view.map.addLayer($kecoMap.view.orderLayers['de9'], 5);
			
			dojo.connect($kecoMap.view.orderLayers['de9'], "onMouseOver", function(evt) {
				var graphic = new esri.Graphic(undefined, undefined);
				
				var return_flag = false;
				try{
					var paramData = $.extend({}, {}, evt.graphic.attributes);
					graphic.setAttributes(paramData);
					graphic.setInfoTemplate(new esri.InfoTemplate(TEMP_DE['de9']));
					page.view.map.infoWindow.resize(250, 100);
					page.model.showInfoWindow(graphic, evt);
				}catch(e) {}
			});
			dojo.connect($kecoMap.view.orderLayers['de9'], "onMouseOut", function(evt) {
				page.view.map.infoWindow.hide();
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
						html +='<li><label><input id="autoLd" type="checkbox" class="" onclick="$kecoMap.model.updateLayerVisibility(0);"/><img src="'+$define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/1/images/'+$define.ARC_SERVER_IMG_AUTO+'" alt=""/> 국가수질자동측정망 </label></li>';
						html +='<li><label><input id="tmsLd" type="checkbox" class="" onclick="$kecoMap.model.updateLayerVisibility(1);"/><img src="'+$define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/4/images/'+$define.ARC_SERVER_IMG_TMS+'" alt=""/> 수질TMS </label></li>';
						html +='<li><label><input id="ipLd" type="checkbox" class="" onclick="$kecoMap.model.updateLayerVisibility(2);"/><img src="'+$define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/2/images/'+$define.ARC_SERVER_IMG_USN+'" alt=""/> 이동형측정기기 </label></li>';
					}else{
						html +='<li><label><input id="autoLd" type="checkbox" checked class="" onclick="$kecoMap.model.updateLayerVisibility(0);"/><img src="'+$define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/1/images/'+$define.ARC_SERVER_IMG_AUTO+'" alt=""/> 국가수질자동측정망 </label></li>';
						html +='<li><label><input id="tmsLd" type="checkbox" checked class="" onclick="$kecoMap.model.updateLayerVisibility(1);"/><img src="'+$define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/4/images/'+$define.ARC_SERVER_IMG_TMS+'" alt=""/> 수질TMS </label></li>';
						html +='<li><label><input id="ipLd" type="checkbox" checked class="" onclick="$kecoMap.model.updateLayerVisibility(2);"/><img src="'+$define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/2/images/'+$define.ARC_SERVER_IMG_USN+'" alt=""/> 이동형측정기기 </label></li>';
					}
					
					html += '<ul><li class="tit">중요 시설물</li>';
					html +='<li><label><input id="de4" type="checkbox" class="" onclick="$kecoMap.model.updateLayerVisibility(4);"/><img src="'+url+data.layers[12].layerId+'/images/'+data.layers[12].legend[0].url+'" alt=""/> '+data.layers[12].layerName+' </label></li>';
					html +='<li><label><input id="de5" type="checkbox" class="" onclick="$kecoMap.model.updateLayerVisibility(5);"/><img src="'+url+data.layers[13].layerId+'/images/'+data.layers[13].legend[0].url+'" alt=""/> '+data.layers[13].layerName+' </label></li>';
					html +='<li><label><input id="de6" type="checkbox" class="" onclick="$kecoMap.model.updateLayerVisibility(6);"/><img src="'+url+data.layers[29].layerId+'/images/'+data.layers[29].legend[0].url+'" alt=""/> '+data.layers[29].layerName+' </label></li>';
					html +='<li><label><input id="de7" type="checkbox" class="" onclick="$kecoMap.model.updateLayerVisibility(7);"/><img src="'+url+data.layers[30].layerId+'/images/'+data.layers[30].legend[0].url+'" alt=""/> '+data.layers[30].layerName+' </label></li>';
					html +='<li><label><input id="de8" type="checkbox" class="" onclick="$kecoMap.model.updateLayerVisibility(8);"/><img src="'+url+data.layers[31].layerId+'/images/'+data.layers[31].legend[0].url+'" alt=""/> '+data.layers[31].layerName+' </label></li>';
					html +='<li><label><input id="de9" type="checkbox" class="" onclick="$kecoMap.model.updateLayerVisibility(9);"/><img src="'+url+data.layers[32].layerId+'/images/'+data.layers[32].legend[0].url+'" alt=""/> '+data.layers[32].layerName+' </label></li>';
					
					html += '</ul><ul><li class="tit">수질측정지점</li>';
					
					for ( var i = 0; i < data.layers.length; i++)
					{
						var l = data.layers[i];
						
						if(i != 13 || i != 14 || i != 33 || i != 34 || i != 35 || i != 36){
							html += '<li>'+
										'<label><input type="checkbox" class="list_item" id="'+l.layerId+'" onclick="$kecoMap.model.updateLayerVisibility();"/><img src="'+url+l.layerId+'/images/'+l.legend[0].url+'" alt=""/> '+l.layerName+'</label>'+
									'</li>';
						}
						if(l.layerId == '7')
						{
							html += '</ul>';
							html += '<ul><li class="tit">퇴적물조사지점</li>';
						}
						else if(l.layerId == '9')
						{
							html += '</ul>';
							html += '<ul><li class="tit">기타측정지점</li>';
						}
						else if(l.layerId == '18')
						{
							html += '</ul>';
							html += '<ul><li class="tit">환경기초시설</li>';
						}
						else if(l.layerId == '27')
						{
							html += '</ul>';
							html += '<ul><li class="tit">시설물</li>';
						}
						else if(l.layerId == '38')
						{
							html +='<li><label><input id="whLd" type="checkbox" class=""  onclick="$kecoMap.model.updateLayerVisibility(3);"/><img src="'+$define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/5/images/'+$define.ARC_SERVER_IMG_WH+'" alt=""/> 방제창고 </label></li>';
							html += '</ul>';
							html += '<ul><li class="tit">하천</li>';
						}
						else if(l.layerId == '41')
						{
							html += '</ul>';
							html += '<ul><li class="tit">수질영향권역</li>';
						}
						else if(l.layerId == '45')
						{
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
						
						if(window.location.href.indexOf('goDetailDam') > -1)
							$('#16').attr('checked', true);
						$kecoMap.model.updateLayerVisibility();
					}, 500);
				}
			});
		};
		
		pub.markerData = [];
		
		// 지도위에 표출
		pub.addMarker = function(type, x, y, obj, flag) // type = 0 사고지점 , 1 = 방제창고, 2 = 진입지점 , 3 = 이탈 USN, 4 = 실시간, 5 = 주제도 
		{
			if(page.view.markerLayer == undefined)
				return;
			
			if(x == undefined || y == undefined)
				return;
			var nobj = {};
			nobj.type = type;
			nobj.x = x;
			nobj.y = y;
			nobj.obj = obj;
			
			if(flag == undefined)
				this.markerData.push(nobj);
			
			var template = this.getInfoTemplate(type);
			var symbol = this.getMargerSymbol(type);
			var graphic = new esri.Graphic(esri.geometry.geographicToWebMercator(new esri.geometry.Point(x,y)), symbol);
			
			graphic.setAttributes(obj);
			graphic.setInfoTemplate(template);
			
			page.view.markerLayer.add(graphic);
			
		};
		
		// 주제도 지도위에 표출
		pub.addMarkerTm = function(type, x, y, obj, flag, bermImg) // type = 0 사고지점 , 1 = 방제창고, 2 = 진입지점 , 3 = 이탈 USN, 4 = 실시간, 5 = 주제도 
		{
			if(page.view.markerLayer == undefined)
				return;
			
			if(x == undefined || y == undefined)
				return;
			var nobj = {};
			nobj.type = type;
			nobj.x = x;
			nobj.y = y;
			nobj.obj = obj;
			
			if(flag == undefined)
				this.markerData.push(nobj);
			
			var template = this.getInfoTemplate(type);
			var symbol = this.getMargerSymbolTm(bermImg);
			var graphic = new esri.Graphic(esri.geometry.geographicToWebMercator(new esri.geometry.Point(x,y)), symbol);
			
			graphic.setAttributes(obj);
			graphic.setInfoTemplate(template);
			
			page.view.markerLayer.add(graphic);
			
		};
		
		pub.markerClear = function()
		{
			page.view.markerLayer.clear();
			this.markerData = [];
		};
		
		pub.getMargerSymbol = function(type)
		{
			var size = 30;
			if(type == 0 || type == 3 || type == 5)
			{
				var level = page.view.map.getLevel();
				if(level < 3)
					size = 30;
				else if( level < 8)
					size = 50;
				else
					size = 80;
			}	
			else if( type == 2 )
			{
				var level = page.view.map.getLevel();
				if(level < 4)
					size = 16;
				else
					size = 32;
			}
			else if(type == 4)
			{
				var level = page.view.map.getLevel();
				if(level < 4)
					size = 16;
				else
					size = 24;
			}
			var img = '/gis/images/event'+size+'.gif';
			
			if(type == 1)
				img = '/gis/images/event'+size+'.gif';
			else if(type == 2)
				img = '/gis/images/flag'+size+'.gif';
			else if(type == 3)
				img = '/gis/images/rss_'+size+'.gif';
			else if(type == 4)
				img = '/gis/images/rss'+size+'.png';
			
			/**
			 * 2014.10.27 주제도 관련 추가
			 * kyr
			 */
			else if(type == 5)
				img = '/gis/images/circle6_'+size+'.png';
			
			/**
			 * 2014.10.27 주제도 관련 추가
			 * 사고현황 아이콘
			 */
			else if(type == 10)
				img = '/gis/images/watereventSTA.gif';

			else if(type == 11)
				img = '/gis/images/watereventPA.gif';

			else if(type == 12)
				img = '/gis/images/watereventPB.gif';

			else if(type == 13)
				img = '/gis/images/watereventPC.gif';

			else if(type == 14)
				img = '/gis/images/watereventPD.gif';
			
			var pictureMarkerSymbol = new esri.symbol.PictureMarkerSymbol(img, size, size);
			pictureMarkerSymbol.setOffset(parseInt(size/2),parseInt(size/2));
			return pictureMarkerSymbol;
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
		
		pub.getInfoTemplate = function(type)
		{
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
		
		pub.initFeatureLayer = function(alertData) {
			$kecoMap.model.alertData = alertData;
			
			this.addAllLayer(1);
			
		};
		pub.addTMSLayer = function(level) {
			var firstFlag = false;
			if($kecoMap.view.tmsLayer == null){
				firstFlag = true;
				$kecoMap.view.tmsLayer = new esri.layers.FeatureLayer($define.ARC_SERVER_URL+"/rest/services/WPCS_EDIT/FeatureServer/4",{
					mode: esri.layers.FeatureLayer.MODE_SNAPSHOT,
//					infoTemplate: new esri.InfoTemplate(TEMPLATJSON),
					outFields: ["*"],
					id: "tmsLayer"
				});
			}
			
			
			var h = 41;
			var w = 26;
			var y = 13;
			
			if(level < 2) {
				h = 22;
				w = 13;
				y = 6;
			}else if( level < 6) {
				h = 36;
				w = 22;
				y = 11;
			}
			
			// selection symbol used to draw the selected census block points within the buffer polygon
			var symbol = new esri.symbol.PictureMarkerSymbol({
				"url":"gis/images/auticon/t_1.png",//$define.ARC_SERVER_URL+"/rest/services/WPCS_EDIT/MapServer/4/images/"+$define.ARC_SERVER_IMG_TMS,
				"height":h,
				"width":w,
				"type":"esriPMS"
			});
			var symbol1 = new esri.symbol.PictureMarkerSymbol({ "url":window.location.origin+"/gis/images/auticon/t_1.png", "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var symbol2 = new esri.symbol.PictureMarkerSymbol({ "url":window.location.origin+"/gis/images/auticon/t_2.png", "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var symbol3 = new esri.symbol.PictureMarkerSymbol({ "url":window.location.origin+"/gis/images/auticon/t_3.png", "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var symbol4 = new esri.symbol.PictureMarkerSymbol({ "url":window.location.origin+"/gis/images/auticon/t_4.png", "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var symbol5 = new esri.symbol.PictureMarkerSymbol({ "url":window.location.origin+"/gis/images/auticon/t_5.png", "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var symbol6 = new esri.symbol.PictureMarkerSymbol({ "url":window.location.origin+"/gis/images/auticon/t_6.png", "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var symbol7 = new esri.symbol.PictureMarkerSymbol({ "url":window.location.origin+"/gis/images/auticon/t_7.png", "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			
			var renderer = new esri.renderer.UniqueValueRenderer(symbol1, 'FACT_CODE','BRANCH_NO');
			//add symbol for each possible value
			
			for ( var i = 0; i < $kecoMap.model.baseObj.model.tmsData.length; i++)  {
				var a = $kecoMap.model.baseObj.model.tmsData[i];
				/*
				 * M = 미수집
				 * L = 점검중
				 * 
				 * 
				 */
				if(a.VALUE == "1")
					renderer.addValue(a.FACT_CODE+a.BRANCH_NO, symbol1);
				else if(a.VALUE == "2")
					renderer.addValue(a.FACT_CODE+a.BRANCH_NO, symbol2);
				else if(a.VALUE == "3")
					renderer.addValue(a.FACT_CODE+a.BRANCH_NO, symbol3);
				else if(a.VALUE == "4")
					renderer.addValue(a.FACT_CODE+a.BRANCH_NO, symbol4);
				else if(a.VALUE == "M")
					renderer.addValue(a.FACT_CODE+a.BRANCH_NO, symbol6);
				else if(a.VALUE == "C")
					renderer.addValue(a.FACT_CODE+a.BRANCH_NO, symbol5);
				else if(a.VALUE == "L")
					renderer.addValue(a.FACT_CODE+a.BRANCH_NO, symbol7);
			}
			
//			var rend = new esri.renderer.SimpleRenderer(symbol);
//			
//			var selectionSymbol = new esri.symbol.SimpleFillSymbol().setColor(new dojo.Color([255,255,0,0.5]));
			
//			$kecoMap.view.tmsLayer.setSelectionSymbol(selectionSymbol); 
			$kecoMap.view.tmsLayer.setRenderer(renderer);
			
			if(user_riverid != undefined && user_riverid != 'null')
				$kecoMap.view.tmsLayer.setDefinitionExpression("RV_CD = '"+user_riverid+"'");
			
			if(firstFlag){
				$kecoMap.view.map.addLayer($kecoMap.view.tmsLayer, 4);	
			}
			
			if( $('#tmsLd').attr('checked'))
				$kecoMap.view.tmsLayer.show();
			else
				$kecoMap.view.tmsLayer.hide();
			if(firstFlag){
				dojo.connect($kecoMap.view.tmsLayer, "onClick", function(evt) {
					console.log('[click]', evt.graphic.attributes);
					$('#system').val('W');
					$('#system').trigger('change');
					$kecoMap.model.baseObj.model.reloadDataForFact(evt.graphic.attributes.FACT_CODE);
				});
				
				dojo.connect($kecoMap.view.tmsLayer, "onMouseOver", function(evt) {
					// 2015-02-27
					// 환경부 사람이 아니면 튤팀 X
					// kys
//					if(user_dept_no == 2000 || user_dept_no.indexOf("10") == 0){
						var graphic = new esri.Graphic(undefined, undefined);
						
						var return_flag = false;
						try {
							var obj = $kecoMap.model.baseObj.model.getCheckData('W', evt.graphic.attributes.FACT_CODE, evt.graphic.attributes.BRANCH_NO);
							if(obj != null){
								return_flag = $kecoMap.model.LayerAuthIn(obj.FACT_CODE,obj.BRANCH_NO,"W") 
							}
							if(return_flag) {
								graphic.setAttributes(obj);
								if(obj != undefined) {
									graphic.setInfoTemplate(new esri.InfoTemplate(TMS_TEMP));
									page.view.map.infoWindow.resize(250, 280);
								} else {
									graphic.setAttributes(evt.graphic.attributes);
									graphic.setInfoTemplate(new esri.InfoTemplate(NULL_TEMP)); 
									page.view.map.infoWindow.resize(250, 100);
								}
							}
						}catch(e)
						{}
						
						if(return_flag) {
//							page.view.map.infoWindow.setContent(graphic.getContent());
//							page.view.map.infoWindow.setTitle(graphic.getTitle());
//							page.view.map.infoWindow.show(evt.screenPoint,page.view.map.getInfoWindowAnchor(evt.screenPoint));
							page.model.showInfoWindow(graphic, evt);
						}
//					}
				});
				
				//listen for when map.graphics onMouseOut event is fired and then clear the highlight graphic
				//and hide the info window
				dojo.connect($kecoMap.view.tmsLayer, "onMouseOut", function(evt) {
//					page.view.map.graphics.clear();
					page.view.map.infoWindow.hide();
				});
				dojo.connect($kecoMap.view.tmsLayer, "onClick", function(evt) { //1105추가
					if($('#Image9').attr('class') == 'on'){
						layer_onClick("수질tms",evt.graphic.attributes.FACT_CODE,evt.graphic.attributes.BRANCH_NO)
					}
				});
			}
		};
		
		pub.addipusnLayer = function(level)
		{
			var firstFlag = false;
			if($kecoMap.view.ipusnLayer == null){
				firstFlag = true;
				
				$kecoMap.view.ipusnLayer = new esri.layers.FeatureLayer($define.ARC_SERVER_URL+"/rest/services/WPCS_EDIT/FeatureServer/2",{
					mode: esri.layers.FeatureLayer.MODE_SNAPSHOT,
	//				infoTemplate: new esri.InfoTemplate(TEMPLATJSON),
					outFields: ["*"],
					id: "ipusnLayer"
				});
			}
			var h = 41;
			var w = 26;
			var y = 13;
			
			if(level < 2)
			{
				h = 22;
				w = 13;
				y = 6;
			}else if( level < 6)
			{
				h = 36;
				w = 22;
				y = 11;
			}
//			var symbol = new esri.symbol.PictureMarkerSymbol({ "url":"/gis/images/auticon/u_1.png", "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var symbol = new esri.symbol.PictureMarkerSymbol({ "url":$define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/2/images/'+$define.ARC_SERVER_IMG_USN1, "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var symbol1 = new esri.symbol.PictureMarkerSymbol({ "url":$define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/2/images/'+$define.ARC_SERVER_IMG_USN2, "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var symbol2 = new esri.symbol.PictureMarkerSymbol({ "url":$define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/2/images/'+$define.ARC_SERVER_IMG_USN3, "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var symbol3 = new esri.symbol.PictureMarkerSymbol({ "url":$define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/2/images/'+$define.ARC_SERVER_IMG_USN4, "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var symbol4 = new esri.symbol.PictureMarkerSymbol({ "url":$define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/2/images/'+$define.ARC_SERVER_IMG_USN5, "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var symbol5 = new esri.symbol.PictureMarkerSymbol({ "url":$define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/2/images/'+$define.ARC_SERVER_IMG_USN6, "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var symbol6 = new esri.symbol.PictureMarkerSymbol({ "url":$define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/2/images/'+$define.ARC_SERVER_IMG_USN7, "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			
			var renderer = new esri.renderer.UniqueValueRenderer(symbol, 'FACT_CODE','BRANCH_NO');
			//add symbol for each possible value
			
			for ( var i = 0; i < $kecoMap.model.baseObj.model.ipusnData.length; i++) 
			{
				var a = $kecoMap.model.baseObj.model.ipusnData[i];
				
				if(a.VALUE == "1")
					renderer.addValue(a.FACT_CODE+a.BRANCH_NO, symbol1);
				else if(a.VALUE == "2")
					renderer.addValue(a.FACT_CODE+a.BRANCH_NO, symbol2);
				else if(a.VALUE == "3")
					renderer.addValue(a.FACT_CODE+a.BRANCH_NO, symbol3);
				else if(a.VALUE == "4")
					renderer.addValue(a.FACT_CODE+a.BRANCH_NO, symbol4);
				else if(a.VALUE == "M")
					renderer.addValue(a.FACT_CODE+a.BRANCH_NO, symbol5);
				else if(a.VALUE == "C")
					renderer.addValue(a.FACT_CODE+a.BRANCH_NO, symbol6);
				else if(a.VALUE == "L")
					renderer.addValue(a.FACT_CODE+a.BRANCH_NO, symbol6);
			}
			
			for ( var i = 0; i < $kecoMap.model.alertData.length; i++)
			{
				var a = $kecoMap.model.alertData[i];
				
				if(a.SYS_KIND == "U"){
					if(a.ALERT_LEVEL == 1)
						renderer.addValue(a.FACT_CODE+a.BRANCH_NO, symbol1);
					else if(a.ALERT_LEVEL == 2)
						renderer.addValue(a.FACT_CODE+a.BRANCH_NO, symbol2);
					else if(a.ALERT_LEVEL == 3)
						renderer.addValue(a.FACT_CODE+a.BRANCH_NO, symbol3);
					else if(a.ALERT_LEVEL == 4)
						renderer.addValue(a.FACT_CODE+a.BRANCH_NO, symbol4);
					else if(a.ALERT_LEVEL == "M")
						renderer.addValue(a.FACT_CODE+a.BRANCH_NO, symbol5);
					else if(a.ALERT_LEVEL == "C")
						renderer.addValue(a.FACT_CODE+a.BRANCH_NO, symbol6);
					else if(a.ALERT_LEVEL == "L")
						renderer.addValue(a.FACT_CODE+a.BRANCH_NO, symbol6);
				}
			}
			
			$kecoMap.view.ipusnLayer.setRenderer(renderer);
			//레이어 그래픽 변경 끝 20130327 이경현 ===================================================================
			
			if(user_riverid != undefined &&  user_riverid != 'null')
				$kecoMap.view.ipusnLayer.setDefinitionExpression("RV_CD = '"+user_riverid+"' AND USE_FLAG = 'Y'");
			else
				$kecoMap.view.ipusnLayer.setDefinitionExpression("USE_FLAG = 'Y'");
			if(firstFlag){
				$kecoMap.view.map.addLayer($kecoMap.view.ipusnLayer, 4);
			}
//			dojo.connect($kecoMap.view.ipusnLayer, "onLoad" , $kecoMap.model.initUSNLayerEdit);
			
			if($('#ipLd').attr('checked'))
				$kecoMap.view.ipusnLayer.show();
			else
				$kecoMap.view.ipusnLayer.hide();
			if(firstFlag){
				dojo.connect($kecoMap.view.ipusnLayer, "onClick", function(evt) {
					console.log('[click]', evt.graphic.attributes);
					$('#system').val('U');
					$('#system').trigger('change');
					$kecoMap.model.baseObj.model.reloadDataForFact(evt.graphic.attributes.FACT_CODE, evt.graphic.attributes.RV_CD, evt.graphic.attributes.BRANCH_NO);
				});
				dojo.connect($kecoMap.view.ipusnLayer, "onMouseOver", function(evt) {
					// 2015-02-27
					// 환경부 사람이 아니면 튤팀 X
					// kys
//					if(user_dept_no == 2000 || user_dept_no.indexOf("10") == 0){
						var graphic = new esri.Graphic(undefined, undefined);
						
						var return_flag = false;
						try{
							var obj = $kecoMap.model.baseObj.model.getCheckData('U', evt.graphic.attributes.FACT_CODE, evt.graphic.attributes.BRANCH_NO);
							if(obj != null){
								return_flag = $kecoMap.model.LayerAuthIn(obj.FACT_CODE,obj.BRANCH_NO,"U");
							}
							if(return_flag){
								
								graphic.setAttributes(obj);
								
								if(obj != undefined) {
									graphic.setInfoTemplate(new esri.InfoTemplate(IPUSN_TEMP));
									page.view.map.infoWindow.resize(250, 250);
								}
								
								var themeObj = $kecoMap.model.getThemeIpusnData(evt.graphic.attributes.FACT_CODE, evt.graphic.attributes.BRANCH_NO);	//추가하려고 구상중
								
								if(obj != undefined) {
									var alertData = $kecoMap.model.baseObj.model.getAlertData(evt.graphic.attributes.FACT_CODE, evt.graphic.attributes.BRANCH_NO);
									
									if(themeObj != undefined && $main.view.excessChk.attr('checked')) {
										graphic.setInfoTemplate(new esri.InfoTemplate(IPUSN_TEMP_THEME));
										page.view.map.infoWindow.resize(250, 280);
									} else if( alertData != undefined) {
										obj.ALERT_MSG = alertData.ALERT_MSG;
										graphic.setInfoTemplate(new esri.InfoTemplate(IPUSN_TEMP_ALERT));
										page.view.map.infoWindow.resize(250, 280);
									} else {
										graphic.setInfoTemplate(new esri.InfoTemplate(IPUSN_TEMP));
										page.view.map.infoWindow.resize(250, 250);
									}
								} else {
									graphic.setAttributes(evt.graphic.attributes);
									graphic.setInfoTemplate(new esri.InfoTemplate(NULL_TEMP)); 
									page.view.map.infoWindow.resize(250, 100);
								}
							}
						}catch(e)
						{}

						if(return_flag){
//							page.view.map.infoWindow.setContent(graphic.getContent());
//							page.view.map.infoWindow.setTitle(graphic.getTitle());
//							page.view.map.infoWindow.show(evt.screenPoint,page.view.map.getInfoWindowAnchor(evt.screenPoint));
							page.model.showInfoWindow(graphic, evt);
						}
//					}
				});
				
				//listen for when map.graphics onMouseOut event is fired and then clear the highlight graphic
				//and hide the info window
				dojo.connect($kecoMap.view.ipusnLayer, "onMouseOut", function(evt) {
//					page.view.map.graphics.clear();
					page.view.map.infoWindow.hide();
				});
				dojo.connect($kecoMap.view.ipusnLayer, "onClick", function(evt) { //1105추가
					if($('#Image9').attr('class') == 'on'){
						layer_onClick("IPUSN",evt.graphic.attributes.FACT_CODE,evt.graphic.attributes.BRANCH_NO);
					}else if($('#Image10').attr('class') == 'on'){
						dobuffer("u",evt);
					}
				});
			}
				
			
		};
		
		pub.addAutoLayer = function(level)
		{
			//MODE_SNAPSHOT MODE_ONDEMAND
			var firstFlag = false;
			if($kecoMap.view.autoLayer == null){
				var firstFlag = true;
				$kecoMap.view.autoLayer = new esri.layers.FeatureLayer($define.ARC_SERVER_URL+"/rest/services/WPCS_EDIT/FeatureServer/1",{
					mode: esri.layers.FeatureLayer.MODE_ONDEMAND,
	//				infoTemplate: new esri.InfoTemplate(TEMPLATJSON),
					outFields: ["*"],
					id: "autoLayer"
				});
			}
			
			var h = 41;
			var w = 26;
			var y = 13;
			
			if(level < 2)
			{
				h = 22;
				w = 13;
				y = 6;
			}else if( level < 6)
			{
				h = 36;
				w = 22;
				y = 11;
			}
			
			var symbol = new esri.symbol.PictureMarkerSymbol({ "url":$define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/1/images/'+$define.ARC_SERVER_IMG_AUTO1, "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var symbol1 = new esri.symbol.PictureMarkerSymbol({ "url":$define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/1/images/'+$define.ARC_SERVER_IMG_AUTO2, "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var symbol2 = new esri.symbol.PictureMarkerSymbol({ "url":$define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/1/images/'+$define.ARC_SERVER_IMG_AUTO3, "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var symbol3 = new esri.symbol.PictureMarkerSymbol({ "url":$define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/1/images/'+$define.ARC_SERVER_IMG_AUTO4, "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var symbol4 = new esri.symbol.PictureMarkerSymbol({ "url":$define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/1/images/'+$define.ARC_SERVER_IMG_AUTO5, "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var symbol5 = new esri.symbol.PictureMarkerSymbol({ "url":$define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/1/images/'+$define.ARC_SERVER_IMG_AUTO6, "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var symbol6 = new esri.symbol.PictureMarkerSymbol({ "url":$define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/1/images/'+$define.ARC_SERVER_IMG_AUTO7, "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			
			
			var renderer = new esri.renderer.UniqueValueRenderer(symbol, 'FACT_CODE');
			for ( var i = 0; i < $kecoMap.model.baseObj.model.autoData.length; i++)
			{
				var a = $kecoMap.model.baseObj.model.autoData[i];
				
				if(a.VALUE == "1")
					renderer.addValue(a.FACT_CODE, symbol1);
				else if(a.VALUE == "2")
					renderer.addValue(a.FACT_CODE, symbol2);
				else if(a.VALUE == "3")
					renderer.addValue(a.FACT_CODE, symbol3);
				else if(a.VALUE == "4")
					renderer.addValue(a.FACT_CODE, symbol4);
				else if(a.VALUE == "M")
					renderer.addValue(a.FACT_CODE, symbol5);
				else if(a.VALUE == "C")
					renderer.addValue(a.FACT_CODE, symbol6);
				else if(a.VALUE == "L")
					renderer.addValue(a.FACT_CODE, symbol6);
			}
			
			for ( var i = 0; i < $kecoMap.model.alertData.length; i++)
			{
				var a = $kecoMap.model.alertData[i];
				
				if(a.SYS_KIND == "A"){
					if(a.ALERT_LEVEL == 1)
						renderer.addValue(a.FACT_CODE, symbol1);
					else if(a.ALERT_LEVEL == 2)
						renderer.addValue(a.FACT_CODE, symbol2);
					else if(a.ALERT_LEVEL == 3)
						renderer.addValue(a.FACT_CODE, symbol3);
					else if(a.ALERT_LEVEL == 4)
						renderer.addValue(a.FACT_CODE, symbol4);
					else if(a.ALERT_LEVEL == "M")
						renderer.addValue(a.FACT_CODE, symbol5);
					else if(a.ALERT_LEVEL == "C")
						renderer.addValue(a.FACT_CODE, symbol6);
					else if(a.ALERT_LEVEL == "L")
						renderer.addValue(a.FACT_CODE, symbol6);
				}
			}
			
//			$kecoMap.view.autoLayer.setSelectionSymbol(selectionSymbol);
			$kecoMap.view.autoLayer.setRenderer(renderer);
			// 수계별로 보여줌
			if(user_riverid != undefined &&  user_riverid != 'null'){
				$kecoMap.view.autoLayer.setDefinitionExpression("RV_CD = '"+user_riverid+"'");
			}
//			else{
//				$kecoMap.view.autoLayer.setDefinitionExpression("X != '0'");
//			}
			
			if(firstFlag){
				$kecoMap.view.map.addLayer($kecoMap.view.autoLayer, 5);
			}
//			dojo.connect($kecoMap.view.autoLayer, "onLoad" , $kecoMap.model.initAutoLayerEdit);
			
			if( $('#autoLd').attr('checked'))
				$kecoMap.view.autoLayer.show();
			else
				$kecoMap.view.autoLayer.hide();
			
			if(firstFlag){
				dojo.connect($kecoMap.view.autoLayer, "onClick", function(evt) {
					console.log('[click]', evt.graphic.attributes);
					$('#system').val('A');
					$('#system').trigger('change');
					$kecoMap.model.baseObj.model.reloadDataForFact(evt.graphic.attributes.FACT_CODE, evt.graphic.attributes.RV_CD);
				});
				dojo.connect($kecoMap.view.autoLayer, "onMouseOver", function(evt) {
//					page.view.map.graphics.clear();  
					//use the maps graphics layer as the highlight layer

					// 2015-02-27
					// 환경부 사람이 아니면 튤팀 X
					// kys
//					if(user_dept_no == 2000 || user_dept_no.indexOf("10") == 0){
					
					
						var graphic = new esri.Graphic(undefined, undefined);
						
						var return_flag = false;
						try{
							var obj = $kecoMap.model.baseObj.model.getCheckData('A', evt.graphic.attributes.FACT_CODE, evt.graphic.attributes.BRANCH_NO);
							if(obj != null){
								return_flag = $kecoMap.model.LayerAuthIn(obj.FACT_CODE,obj.BRANCH_NO,"U");
							}
							if(return_flag){ 
								graphic.setAttributes(obj);
								
								var themeObj = $kecoMap.model.getThemeAutoData(evt.graphic.attributes.FACT_CODE, evt.graphic.attributes.BRANCH_NO);
								
								if(obj != undefined) {
									var alertData = $kecoMap.model.baseObj.model.getAlertData(evt.graphic.attributes.FACT_CODE, evt.graphic.attributes.BRANCH_NO);
									
									if(themeObj != undefined && $main.view.excessChk.attr('checked')) {
										graphic.setInfoTemplate(new esri.InfoTemplate(AUTO_TEMP_THEME));
										page.view.map.infoWindow.resize(250, 280);
									} else if( alertData != undefined) {
										obj.ALERT_MSG = alertData.ALERT_MSG;
										graphic.setInfoTemplate(new esri.InfoTemplate(AUTO_TEMP_ALERT));
										
										page.view.map.infoWindow.resize(250, 280);
									} else {
										graphic.setInfoTemplate(new esri.InfoTemplate(AUTO_TEMP));
										page.view.map.infoWindow.resize(250, 250);
									}
								} else {
									graphic.setAttributes(evt.graphic.attributes);
									graphic.setInfoTemplate(new esri.InfoTemplate(NULL_TEMP));
									page.view.map.infoWindow.resize(250, 100);
								}
							}
						}catch(e)
						{}

						if(return_flag){ 
//							page.view.map.infoWindow.setContent(graphic.getContent());
//							page.view.map.infoWindow.setTitle(graphic.getTitle());
//							var sp = esri.geometry.toScreenPoint(page.view.map.extent, page.view.map.width, page.view.map.height, evt.graphic.geometry);
//							page.view.map.infoWindow.show(sp, page.view.map.getInfoWindowAnchor(sp));
							page.model.showInfoWindow(graphic, evt);
						}
//					}
				});
				
				//listen for when map.graphics onMouseOut event is fired and then clear the highlight graphic
				//and hide the info window
				dojo.connect($kecoMap.view.autoLayer, "onMouseOut", function(evt) {
//					page.view.map.graphics.clear();
					page.view.map.infoWindow.hide();
				});
				dojo.connect($kecoMap.view.autoLayer, "onClick", function(evt) { //1105추가
					if($('#Image9').attr('class') == 'on'){
						layer_onClick("국가수질자동측정망",evt.graphic.attributes.FACT_CODE,evt.graphic.attributes.BRANCH_NO);
					}else if($('#Image10').attr('class') == 'on'){
						dobuffer("a",evt);
					}
				});
			}
			
		};
		
		pub.showInfoWindow = function(graphic, evt){
			if(graphic != null){
				page.view.map.infoWindow.setContent(graphic.getContent());
				page.view.map.infoWindow.setTitle(graphic.getTitle());
			}
			var sp = esri.geometry.toScreenPoint(page.view.map.extent, page.view.map.width, page.view.map.height, evt.graphic.geometry);
			page.view.map.infoWindow.show(sp, page.view.map.getInfoWindowAnchor(sp));
		}
		
		pub.addWhLayer = function(level)
		{
			var firstFlag = false;
			if($kecoMap.view.whLayer == null){
				firstFlag = true;
				$kecoMap.view.whLayer = new esri.layers.FeatureLayer($define.ARC_SERVER_URL+"/rest/services/WPCS_EDIT/FeatureServer/5",{
					mode: esri.layers.FeatureLayer.MODE_SNAPSHOT,
//					infoTemplate: new esri.InfoTemplate(TEMPLATJSON),
					outFields: ["*"],
					id: "whLayer"
				});
			}
			
			
			var h = 41;
			var w = 26;
			var y = 13;
			
			if(level < 2)
			{
				h = 22;
				w = 13;
				y = 6;
			}else if( level < 6)
			{
				h = 36;
				w = 22;
				y = 11;
			}
			
			var symbol = new esri.symbol.PictureMarkerSymbol({
				"url":$define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/5/images/'+$define.ARC_SERVER_IMG_WH,
				"height":h,
				"width":w,
				"type":"esriPMS",
				"yoffset":y
			});
			
			var rend = new esri.renderer.SimpleRenderer(symbol);
			
			var symbolSel = new esri.symbol.PictureMarkerSymbol({
				"url":$define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/5/images/'+$define.ARC_SERVER_IMG_WH,
				"height":h+4,
				"width":w+4,
				"type":"esriPMS",
				"yoffset":y
			});
			
//			$kecoMap.view.whLayer.setSelectionSymbol(symbolSel);
			
			$kecoMap.view.whLayer.setRenderer(rend);
			$kecoMap.view.whLayer.setDefinitionExpression("USE_FLAG = 'Y'");
			if(firstFlag){
				$kecoMap.view.map.addLayer($kecoMap.view.whLayer, 4);
			}
//			dojo.connect($kecoMap.view.whLayer, "onLoad" , $kecoMap.model.initWhLayerEdit);
			
			if($('#whLd').attr('checked'))
				$kecoMap.view.whLayer.show();
			else
				$kecoMap.view.whLayer.hide();
			if(firstFlag){
				dojo.connect($kecoMap.view.whLayer, "onMouseOver", function(evt) {
//					page.view.map.graphics.clear();  //use the maps graphics layer as the highlight layer
					var graphic = new esri.Graphic(undefined, undefined);
					try{
						var obj = $kecoMap.model.baseObj.model.getWhData(evt.graphic.attributes.WH_CODE);
						
						graphic.setAttributes(obj);
						
						if(obj != undefined){
							obj.WH_NAME = evt.graphic.attributes.WH_NAME;
							var contentHTML = '<ul>';
							var hsize = 0;
							for ( var i = 0; i < obj.msgs.length; i++){
								contentHTML += '<li>'+obj.msgs[i]+'</li>'
								hsize += 25;
							}
							var temp = {
									title:obj.WH_NAME,
									content: contentHTML};
							
							graphic.setAttributes(obj);
							graphic.setInfoTemplate(new esri.InfoTemplate(temp)); 
							page.view.map.infoWindow.resize(250, hsize+50);
						}else{
							evt.graphic.attributes.FACI_NM = evt.graphic.attributes.WH_NAME;
							
							graphic.setAttributes(evt.graphic.attributes);
							graphic.setInfoTemplate(new esri.InfoTemplate(NULL_TEMP)); 
							page.view.map.infoWindow.resize(250, 100);
						}
					}catch(e)
					{}
					
//					page.view.map.infoWindow.setContent(graphic.getContent());
//					page.view.map.infoWindow.setTitle(graphic.getTitle());
//					page.view.map.infoWindow.show(evt.screenPoint,page.view.map.getInfoWindowAnchor(evt.screenPoint));
					page.model.showInfoWindow(graphic, evt);
				});
				
				dojo.connect($kecoMap.view.whLayer, "onMouseOut", function(evt) {
//					page.view.map.graphics.clear();
					page.view.map.infoWindow.hide();
				});
				dojo.connect($kecoMap.view.whLayer, "onClick", function(evt) { //1105추가
					if($('#Image9').attr('class','on')){
						layer_onClick("방제창고",evt.graphic.attributes.FACT_CODE,evt.graphic.attributes.BRANCH_NO);
					}
				});
			}
			
		};
		
		
		pub.removeAllLayer = function() {
			page.view.map.removeLayer(page.view.tmsLayer);
			page.view.map.removeLayer(page.view.autoLayer);
			page.view.map.removeLayer(page.view.ipusnLayer);
			page.view.map.removeLayer(page.view.whLayer);
			page.view.map.removeLayer(page.view.tempBLayer);
		};
		
		pub.addAllLayer = function(level) {
			this.addAutoLayer(level);
			this.addipusnLayer(level);
			this.addTMSLayer(level);
			this.addWhLayer(level);
			this.addTempBLayer(level);
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
		pub.bufferLayer = null;
		
		pub.fLayer = null;
		
		pub.dtype = -1; // 0 = 버퍼 , 2 = 길이 , 3 = 면적 , 4 = 좌표 얻기
		pub.overviewDiv = null;
		
		// View 초기화
		pub.init = function() {
			
			
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
		
		pub.initDraw = function(){
			page.view.tb = new esri.toolbars.Draw(page.view.map);
			dojo.connect(page.view.tb, "onDrawEnd", page.model.drawEnded);
		};
		
		pub.mainLayerLoaded = function(layer) {
		};
		
		pub.handleCounties2 = function(result) {
			if(result.features == undefined || result.features.length == 0 )
				return;
			
			console.log('[RESULT]', result);
			
			var infoTemplate = new esri.InfoTemplate("${지점명}","${*}");
			
			var symbol = new esri.symbol.SimpleMarkerSymbol();
			symbol.style = esri.symbol.SimpleMarkerSymbol.STYLE_SQUARE;
			symbol.setSize(10);
			symbol.setColor(new dojo.Color([255,255,0,0.5]));
			
			page.view.map.graphics.clear();
			var highlightSymbol = new esri.symbol.SimpleFillSymbol(esri.symbol.SimpleFillSymbol.STYLE_SOLID, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([255,0,0]), 3), new dojo.Color([125,125,125,0.35]));
			
			var countiesGraphicsLayer = new esri.layers.GraphicsLayer();
			//QueryTask returns a featureSet.  Loop through features in the featureSet and add them to the map.
			for (var i=0, il=result.features.length; i<il; i++) {
			//Get the current feature from the featureSet.
			//Feature is a graphic
				var graphic = result.features[i];
				graphic.setSymbol(symbol);
				graphic.setInfoTemplate(infoTemplate);
				
				//Add graphic to the counties graphics layer.
				countiesGraphicsLayer.add(graphic);
			}
			page.view.map.addLayer(countiesGraphicsLayer);
			page.view.map.graphics.enableMouseEvents();
			//listen for when the onMouseOver event fires on the countiesGraphicsLayer
			//when fired, create a new graphic with the geometry from the event.graphic and add it to the maps graphics layer
			dojo.connect(countiesGraphicsLayer, "onMouseOver", function(evt) {
				page.view.map.graphics.clear();  //use the maps graphics layer as the highlight layer
				var content = evt.graphic.getContent();
				page.view.map.infoWindow.setContent(content);
				var title = evt.graphic.getTitle();
				page.view.map.infoWindow.setTitle(title);
				var highlightGraphic = new esri.Graphic(evt.graphic.geometry,highlightSymbol);
				page.view.map.graphics.add(highlightGraphic);
				
				page.model.showInfoWindow(null, evt);
				
//				page.view.map.infoWindow.show(evt.screenPoint,page.view.map.getInfoWindowAnchor(evt.screenPoint));
			});
			
			//listen for when map.graphics onMouseOut event is fired and then clear the highlight graphic
			//and hide the info window
			dojo.connect(page.view.map.graphics, "onMouseOut", function(evt) {
				page.view.map.graphics.clear();
				page.view.map.infoWindow.hide();
			});
		};
		
		pub.zoomEnd = function(extent, zoomFactor, anchor ,level) {
			page.view.map.infoWindow.hide();
			
			if($kecoMap.model.markerData.length > 0) {
				$kecoMap.view.markerLayer.clear();
				
				for ( var i = 0; i < $kecoMap.model.markerData.length; i++) {
					$kecoMap.model.addMarker($kecoMap.model.markerData[i].type, $kecoMap.model.markerData[i].x,$kecoMap.model.markerData[i].y, $kecoMap.model.markerData[i].obj, 'zoom');
				}
			}
			
			if(window.location.href.indexOf('addrMap') <= -1) {
//				$kecoMap.model.removeAllLayer();
				$kecoMap.model.addAllLayer(level);
			}
			
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


