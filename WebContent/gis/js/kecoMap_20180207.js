dojo.require("esri.map");
dojo.require("dijit.layout.BorderContainer");
dojo.require("dijit.layout.ContentPane");
dojo.require("esri.virtualearth.VETiledLayer");
dojo.require("dijit.TitlePane");
dojo.require("esri.dijit.BasemapGallery");
dojo.require("esri.arcgis.utils");
dojo.require("esri.tasks.query");
dojo.require("esri.tasks.geometry");
dojo.require("esri.layers.WebTiledLayer");
dojo.require("esri.dijit.Measurement");
dojo.require("esri.renderers.SimpleRenderer");
dojo.require("esri.symbols.SimpleFillSymbol");
dojo.require("esri.map");
dojo.require("esri.dijit.Scalebar");
dojo.require("dojo.parser");
dojo.require("esri.dijit.Legend");
dojo.require("dojo._base.array");
dojo.require("esri.layers.LayerInfo");
dojo.require("esri.layers.ImageParameters");
dojo.require("dijit.layout.BorderContainer");
dojo.require("dijit.layout.ContentPane");
dojo.require("dojo.domReady!");
dojo.require("esri.geometry.Point");
dojo.require("esri.tasks.PrintTemplate");
dojo.require("esri.dijit.Print");
dojo.require("esri.tasks.PrintTask");
dojo.require("esri.dijit.OverviewMap");
dojo.require("esri.toolbars.edit");
dojo.require("esri.symbols.SimpleFillSymbol");
dojo.require("esri.renderers.UniqueValueRenderer");
dojo.require("esri.dijit.InfoWindow");
dojo.require("esri.tasks.IdentifyTask");
dojo.require("esri.tasks.IdentifyParameters");


var daum = {
		apikey: "4bc63e3a941c98f7bb179dff6c5437e796dae6fe",
		addr2coord : function(addr , callBack) 
		{
			var obj = document.createElement('script');
			obj.type ='text/javascript';
			obj.charset ='utf-8';
			obj.src = 'http://apis.daum.net/local/geo/addr2coord?apikey=' + this.apikey + 
			'&output=json&callback='+callBack+'&q=' + encodeURI(addr);
			document.getElementsByTagName('head')[0].appendChild(obj);
		},
		coord2addr : function(longitude, latitude , callBack) 
		{
			var obj = document.createElement('script');
			obj.type ='text/javascript';
			obj.charset ='utf-8';
			obj.src = 'http://apis.daum.net/local/geo/coord2addr?apikey=' + this.apikey + '&output=json&callback='+callBack+'&longitude='+longitude+'&latitude='+latitude+'&inputCoordSystem=WGS84';
			document.getElementsByTagName('head')[0].appendChild(obj);
		}
	};

var $kecoMap;

$(function() {
	
	var page = {
		"dom" : $(this)
	};
	
	var TAG = page.id;
//	var WKT = "PROJCS[\"Google_Maps_Global_Mercator\",GEOGCS[\"GCS_WGS_1984\",DATUM[\"D_WGS_1984\",SPHEROID[\"WGS_1984\",6378137.0,298.257223563]],PRIMEM[\"Greenwich\",0.0],UNIT[\"Degree\",0.0174532925199433]],PROJECTION[\"Mercator_2SP\"],PARAMETER[\"false_easting\",0.0],PARAMETER[\"false_northing\",0.0],PARAMETER[\"central_meridian\",0.0],PARAMETER[\"standard_parallel_1\",0.0],PARAMETER[\"latitude_of_origin\",0.0],UNIT[\"Meter\",1.0]]";
	var WKT = 3857;
	var MAP_SPATIALREFERENCE = null; //4326;
	
	var ORIGIN = {
					"x": 13462700,
					"y": 5322463
				};
	var TILEINFO = null; 
	
	var TEMPLATJSON  = {
			title:"${OBJECTID}",
			content: "${*}"};
		
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
	var TEMPLATJSON  = {
			title:"${사업장명칭}",
			content: "<ul>"
						+ "<li> ● 수신시간 : ${date} ${time} </li>"
						+ "<li> ● PH : ${ph}</li>"
						+ "<li> ● DO : ${DO1} (ms/L)</li>"
						+ "<li> ● EC : ${EC1} (mS/w)</li>"
						+ "<li> ● 탁도 : ${NTU}</li>"
						+ "<li> ● 온도 : ${heat}</li></ul>"
					};
	var TMS_TEMP  = {
			title:"${FACTNAME}",
			content: "<ul>"
						+ "<li> ● 수신시간 : ${STRDATE} ${STRTIME} </li>"
						+ "<li> ● 권역 : ${RIVER_NAME} </li>"
						+ "<li> ● PH : ${PHY}</li>"
						+ "<li> ● BOD : ${BOD} (ppm)</li>"
						+ "<li> ● COD : ${COD} (ppm)</li>"
						+ "<li> ● SS : ${SUS} (mg/L)</li>"
						+ "<li> ● T-N : ${TON} (mg/L)</li>"
						+ "<li> ● T-P : ${TOP} (mg/L)</li>"
						+ "<li> ● 유량 : ${FLW} (㎥/hr)</li></ul>"
					};
	var IPUSN_TEMP = {
			title:"${FACTNAME}"+"("+"${BRANCH_NAME}"+")",
			content: "<ul>"
						+ "<li> ● 수신시간 : ${STRDATE} ${STRTIME} </li>"
						+ "<li> ● 수계 : ${RIVER_NAME} </li>"
						+ "<li> ● PH : ${PHY}</li>"
						+ "<li> ● DO : ${DOW} (mS/cm)</li>"
						+ "<li> ● EC : ${CON} (mS/cm)</li>"
						+ "<li> ● 탁도 : ${TUR} (NTU)</li>"
						+ "<li> ● 수온 : ${TMP} (℃)</li></ul>"
					};
	var IPUSN_TEMP_ALERT = {
			title:"${BRANCH_NAME}",
			content: "<ul>"
						+ "<li> ● 수신시간 : ${STRDATE} ${STRTIME} </li>"
						+ "<li> ● 수계 : ${RIVER_NAME} </li>"
						+ "<li> ● PH : ${PHY} </li>"
						+ "<li> ● DO : ${DOW} (mS/cm)</li>"
						+ "<li> ● EC : ${CON} (mS/cm)</li>"
						+ "<li> ● 탁도 : ${TUR} (NTU)</li>"
						+ "<li> ● 수온 : ${TMP} (℃)</li></ul>"
						+ "<li><font color=\"#ff0000\"> ● 이상메세지 : ${ALERT_MSG}</font></li></ul>"
					};
	var IPUSN_TEMP_THEME = {
			title:"${FACTNAME}",
			content: "<ul>"
						+ "<li> ● 수신시간 : ${STRDATE} ${STRTIME} </li>"
						+ "<li> ● 수계 : ${RIVER_NAME} </li>"
						+ "<li> ● PH : ${PHY} </li>"
						+ "<li> ● DO : ${DOW} (mS/cm)</li>"
						+ "<li> ● EC : ${CON} (mS/cm)</li>"
						+ "<li> ● 탁도 : ${TUR} (NTU)</li>"
						+ "<li> ● 수온 : ${TMP} (℃)</li>"
						+ "<li> ● 기준치 알람 : ${ALAM}</li></ul>"
					};
	var AUTO_TEMP = {
			title:"${FACTNAME}",
			content: "<ul>"
						+ "<li> ● 수신시간 : ${STRDATE} ${STRTIME} </li>"
						+ "<li> ● 수계 : ${RIVER_NAME} </li>"
						+ "<li> ● PH : ${PHY} </li>"
						+ "<li> ● DO : ${DOW} (mS/cm)</li>"
//						+ "<li> ● EC : ${CON} (mS/cm)</li>"
						+ "<li> ● EC : ${CON} (μS/cm)</li>"
						+ "<li> ● 탁도 : ${TUR} (NTU)</li>"
						+ "<li> ● 수온 : ${TMP} (℃)</li></ul>"
						};
	var AUTO_TEMP_ALERT = {
			title:"${FACTNAME}",
			content: "<ul>"
						+ "<li> ● 수신시간 : ${STRDATE} ${STRTIME} </li>"
						+ "<li> ● 수계 : ${RIVER_NAME} </li>"
						+ "<li> ● PH : ${PHY} </li>"
						+ "<li> ● DO : ${DOW} (mS/cm)</li>"
						+ "<li> ● EC : ${CON} (μS/cm)</li>"
//						+ "<li> ● EC : ${CON} (mS/cm)</li>"
						+ "<li> ● 탁도 : ${TUR} (NTU)</li>"
						+ "<li> ● 수온 : ${TMP} (℃)</li></ul>"
						+ "<li><font color=\"#ff0000\"> ● 이상메세지 : ${ALERT_MSG}</font></li></ul>"
					};
	var AUTO_TEMP_THEME = {
			title:"${FACTNAME}",
			content: "<ul>"
						+ "<li> ● 수신시간 : ${STRDATE} ${STRTIME} </li>"
						+ "<li> ● 수계 : ${RIVER_NAME} </li>"
						+ "<li> ● PH : ${PHY} </li>"
						+ "<li> ● DO : ${DOW} (mS/cm)</li>"
//						+ "<li> ● EC : ${CON} (mS/cm)</li>"
						+ "<li> ● EC : ${CON} (μS/cm)</li>"
						+ "<li> ● 탁도 : ${TUR} (NTU)</li>"
						+ "<li> ● 수온 : ${TMP} (℃)</li>"
						+ "<li> ● 기준치 알람 : ${ALAM}</li></ul>"
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
		
		pub.getThemeIpusnData = function(factcode , branchno)
		{
			for ( var i = 0; i < this.themeIpusnList.length; i++) 
			{
				var obj = this.themeIpusnList[i].attributes;
				if(obj.FACT_CODE == factcode && obj.BRANCH_NO == branchno)
					return obj;
			}
			return;
		};
		
		pub.getThemeAutoData = function(factcode , branchno)
		{
			for ( var i = 0; i < this.themeAutoList.length; i++) 
			{
				var obj = this.themeAutoList[i].attributes;
				if(obj.FACT_CODE == factcode && obj.BRANCH_NO == branchno)
					return obj;
			}
			return;
		};
		
		pub.daumCallBack = function(result)
		{
		};
		
		pub.eventTest = function()
		{
			var distances = $( "#slider" ).slider('value');
			this.eventCall([{
				x:127.31820260609659,
				y: 37.422599704042085
			}, {
				x: 127.07719003285469,
				y: 37.57839777594502
			}], distances);
		};
		
		pub.eventCall = function(coord, distances)
		{
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
				if($('#autoLd').attr('checked'))
					$kecoMap.view.autoLayer.show();
				else
					$kecoMap.view.autoLayer.hide();
				
				
//				$kecoMap.model.baseObj.model.stop();
				
				var isOption = "";
				
				if($('#autoLd').attr('checked')){
					if($('#ipLd').attr('checked'))
						isOption = "<option value='all'>전&nbsp;&nbsp;체</option><option value='A'>자동측정망(A)</option><option value='U'>IP-USN(U)</option>";
					else
						isOption = "<option value='A'>자동측정망(A)";
				}else{
					if($('#ipLd').attr('checked'))
						isOption = "<option value='U'>IP-USN(U)</option>";
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
						isOption = "<option value='all'>전&nbsp;&nbsp;체</option><option value='A'>자동측정망(A)</option><option value='U'>IP-USN(U)</option>";
					else
						isOption = "<option value='A'>자동측정망(A)";
				}else{
					if($('#ipLd').attr('checked'))
						isOption = "<option value='U'>IP-USN(U)</option>";
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
		
		pub.generalMap = function()
		{
			$('#Image9').attr('class','off');
			$('#Image10').attr('class','off');
			$('#Image11').attr('class','off');
			$('#Image12').attr('class','off');
			$("#tool_buffer").hide();
			page.view.vworldLayer.show();
			page.view.vworldSatelliteLayer.hide();
			page.view.vworldHybridLayer.hide(); 
			this.mapidx = 0;
			//page.controller.setButtonImg('Image2','/gis/images/tool_2_off.gif');
			page.controller.setButtonImg('Image2','/gis/images/new_tool_2_off.gif');
		};
		
		pub.flightMap = function()
		{
			$('#Image9').attr('class','off');
			$('#Image10').attr('class','off');
			$('#Image11').attr('class','off');
			$('#Image12').attr('class','off');
			$("#tool_buffer").hide();
			page.view.vworldLayer.hide();
			page.view.vworldSatelliteLayer.show(); 
			page.view.vworldHybridLayer.show(); 
			this.mapidx = 1;
//			page.controller.setButtonImg('Image1','/gis/images/tool_1_off.gif');
			page.controller.setButtonImg('Image1','/gis/images/new_tool_1_off.gif');
		};
		
		pub.sear = function()
		{
			page.view.tb.activate(esri.toolbars.Draw.POLYGON);
			page.view.map.graphics.clear();
			page.view.dtype = 0;
		};
		
		pub.distances = function()
		{
			$('#Image9').attr('class','off');
			$('#Image10').attr('class','off');
			$('#Image11').attr('class','off');
			$('#Image12').attr('class','off');
			$("#tool_buffer").hide();
			page.view.tb.activate(esri.toolbars.Draw.POLYLINE);
			//page.view.map.graphics.clear();
			page.view.dtype = 2;
			this.toolbaridx = 2;
//			page.controller.setButtonImg('Image4','/gis/images/tool_4_off.gif');
			page.controller.setButtonImg('Image4','/gis/images/new_tool_4_off.gif');
			
		};
		
		pub.area = function()
		{
			$('#Image9').attr('class','off');
			$('#Image10').attr('class','off');
			$('#Image11').attr('class','off');
			$('#Image12').attr('class','off');
			$("#tool_buffer").hide();
			page.view.tb.activate(esri.toolbars.Draw.POLYGON);
			//page.view.map.graphics.clear();
			page.view.dtype = 3;
			this.toolbaridx = 3;
//			page.controller.setButtonImg('Image3','/gis/images/tool_3_off.gif');
			page.controller.setButtonImg('Image3','/gis/images/new_tool_3_off.gif');
		};
		
		pub.coordMood = function(callBack)
		{
			if(callBack == undefined)
				return;
			
			page.view.dtype = 4;
			this.coordCallback = callBack;
		};
		
		pub.clear = function()
		{
			$('#Image9').attr('class','off');
			$('#Image10').attr('class','off');
			$('#Image11').attr('class','off');
			$('#Image12').attr('class','off');
			$("#tool_buffer").hide();
			page.view.tb.deactivate();
			page.view.map.graphics.clear();
			page.view.dtype = -1;
			this.toolbaridx = -1;
			if($kecoMap.view.map.getLayer("buffer_graphicsLayer_au")!=undefined){
				$kecoMap.view.map.removeLayer($kecoMap.view.map.getLayer("buffer_graphicsLayer_au"));
			}
			
//			page.controller.setButtonImg('Image3','/gis/images/tool_3_off.gif');
//			page.controller.setButtonImg('Image4','/gis/images/tool_4_off.gif');
			page.controller.setButtonImg('Image3','/gis/images/new_tool_3_off.gif');
			page.controller.setButtonImg('Image4','/gis/images/new_tool_4_off.gif');
			
			
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
		pub.move_key = function()
		{
			GL_MOVE('36','1012110');
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
		pub.print = function()
		{
			page.view.tb.activate(esri.toolbars.Draw.POLYGON);
			page.view.map.graphics.clear();
			page.view.dtype = -1;
		};
		
		pub.drawSymbol = function(mevt)
		{
			page.view.map.infoWindow.hide();
			
//			console.log("mevt : ",mevt);
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
			            	
			            	//alert(layer_Info);
		            	} 
	            	}
	            });
			}else if(page.view.dtype == 10){
				var lonlat = esri.geometry.xyToLngLat(mevt.mapPoint.x, mevt.mapPoint.y);
				window.open("/tempBRegPop.jsp?regId="+$('#userId').val()+"&type=0&X="+lonlat[0]+"&Y="+lonlat[1],'tempBRegPop','width=550,height=430,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,left=100,top=50');
				page.view.dtype = -1;
			}
		};
		
		
		pub.searchTheme = function(sugye, themeItem, searchThemeCallBack)
		{
			var q = new esri.tasks.Query();
			q.returnGeometry = true;
			q.outFields = ["*"];
			q.where = "WS_CD = '"+sugye+"'";
			
			var qt = new esri.tasks.QueryTask($define.ARC_SERVER_URL+"/rest/services/WPCS/MapServer/43");
			
			qt.execute(q, function(result){
				if(result.features.length == 1)
				{
					var q = new esri.tasks.Query();
					q.geometry = result.features[0].geometry;
					q.returnGeometry = true;
					q.outFields = ["*"];
					
					var qt = new esri.tasks.QueryTask($define.ARC_SERVER_URL+"/rest/services/WPCS/MapServer/"+themeItem);
					qt.execute(q, searchThemeCallBack);
				}
				else
					searchThemeCallBack(undefined);
			}, function(error){
				
				alert('서버에 에러가 발생했습니다.\n'+error.message);
				closeLoading();
			});
		};
		
		pub.showThemeBuffer = function(geometries, distances)
		{
			var tl = 4;
			if(distances > 20)
				tl = 4;
			else if( distances > 10)
				tl = 5;
			else 
				tl = 6;
			
			if(page.view.map.getLevel() < tl)
				page.view.map.setLevel(tl);
		
			page.view.map.centerAt(geometries);
			
			var wm = esri.geometry.geographicToWebMercator(new esri.geometry.Point(geometries.x,geometries.y));
		
			var params = new esri.tasks.BufferParameters();
			params.geometries  = [wm];
			params.distances = [distances];
			params.unit = esri.tasks.GeometryService.UNIT_KILOMETER;
			
			$kecoMap.view.gsvc.buffer(params, function(result){
				
//				$kecoMap.view.map.graphics.clear();
				$kecoMap.view.bufferLayer.clear();
				
				
				var symbol = new esri.symbol.SimpleFillSymbol(
					esri.symbol.SimpleFillSymbol.STYLE_SOLID,
					new esri.symbol.SimpleLineSymbol(
						esri.symbol.SimpleLineSymbol.STYLE_SHORTDASHDOTDOT,
							new dojo.Color([105,105,105]), 
							2
					),new dojo.Color([255,0,0,0.25])
				);
				
					$kecoMap.view.bufferLayer.add(new esri.Graphic(result[0], symbol))

//					$kecoMap.view.map.graphics.add(new esri.Graphic(result[0], symbol));
//					$kecoMap.model.removeAllLayer();
//					setTimeout(function(){$kecoMap.model.addAllLayer($kecoMap.view.map.getLevel());
//					}, '1000');
				
				var query = new esri.tasks.Query();
				query.geometry = result[0];
				
				$kecoMap.view.autoLayer.selectFeatures(query, esri.layers.FeatureLayer.SELECTION_NEW, function(results){
					console.log('[autoLayer result]',results);
					
					$kecoMap.model.themeAutoList = results;
				});
				$kecoMap.view.ipusnLayer.selectFeatures(query, esri.layers.FeatureLayer.SELECTION_NEW, function(results){
				console.log('[ipusnLayer result]',results);
//					$kecoMap.model.themeAutoList = results;
				});
			});
		};
		
		pub.writeBuffer = function(type, obj, distances, callback)
		{
			if(type == '1')
			{
				if(!$('#38').attr('checked'))
				{
					$('#38').attr('checked', 'true');
					$kecoMap.model.updateLayerVisibility();
				}
				if($kecoMap.view.fLayer != undefined)
				{
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
//					$kecoMap.view.map.graphics.add(new esri.Graphic(result[0], symbol));
				
					var query = new esri.tasks.Query();
					query.geometry = result[0];
					
					$kecoMap.view.fLayer = new esri.layers.FeatureLayer($define.ARC_SERVER_URL+"/rest/services/WPCS/MapServer/38",{
						mode: esri.layers.FeatureLayer.MODE_ONDEMAND,
//						infoTemplate: new esri.InfoTemplate(TEMPLATJSON),
						outFields: ["*"],
						id: "flayerLayer"
					});
					
					$kecoMap.view.fLayer.selectFeatures(query, esri.layers.FeatureLayer.SELECTION_NEW, function(results){
						if(callback != undefined)
							callback(results);
						
//							$kecoMap.view.map.removeLayer($kecoMap.view.fLayer);
					});
				});
			}
			else
			{
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
					
//					$kecoMap.view.map.graphics.add(new esri.Graphic(result[0], symbol));
					
					var query = new esri.tasks.Query();
					query.geometry = result[0];
					
					$kecoMap.view.whLayer.selectFeatures(query, esri.layers.FeatureLayer.SELECTION_NEW, function(results){
						if(callback != undefined)
							callback(results);
						
//						$kecoMap.view.map.removeLayer($kecoMap.view.whLayer);
					});
				});
			}
		};
		pub.drawEnded = function(geometry)
		{
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
						
						//$kecoMap.view.tb.deactivate();
						//this.toolbaridx = -1;
						//page.controller.setButtonImg('Image4','/gis/images/tool_4_off.gif');
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
						/* if((response.features.length-1) > i){
							 layer_Info += info + ".";
						 }
						 else{
							 layer_Info += info;
						 }*/
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
						 /*if((response.features.length-1) > i){
							 layer_Info += info + ".";
						 }
						 else{
							 layer_Info += info;
						 }*/
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
						 /*if((response.features.length-1) > i){
							 layer_Info += info + ".";
						 }
						 else{
							 layer_Info += info;
						 }*/
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
						 /*if((response.features.length-1) > i){
							 layer_Info += info + ".";
						 }
						 else{
							 layer_Info += info;
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
						 info ="댐,"+response.features[i].attributes.ID+".";
						 
						 layer_Info += info;
						 /*if((response.features.length-1) > i){
							 layer_Info += info + ".";
						 }
						 else{
							 layer_Info += info;
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
						 info ="보,"+response.features[i].attributes.BOOBSCD+".";
						 
						 layer_Info += info;
						 /*if((response.features.length-1) > i){
							 layer_Info += info + ".";
						 }
						 else{
							 layer_Info += info;
						 }*/
		        	 }
		        	 count++;
		        	 get_buffer_key(count,layer_Info);
		        });
		        //$kecoMap.view.tb.deactivate();
				this.toolbaridx = -1;
			}
		};
		
		// 브이 월드 맵 세팅
		pub.initVWorldBaseLayer = function () {
			dojo.declare("VworldTiledMapServiceLayer", esri.layers.TiledMapServiceLayer, 
			{
				constructor: function () {
					this.id = "BaseMap";
					this.spatialReference = new esri.SpatialReference(WKT);
					this.initialExtent = (this.fullExtent = new esri.geometry.Extent(13417793.028, 3777430.348, 15084515.335, 4772379.684, this.spatialReference));
					var lod = [];
					
					this.tileInfo = TILEINFO;
					
					this.loaded = true;
					this.onLoad(this);
				},
				
				getTileUrl: function (level, row, col) {
					
					var newrow = row + (Math.pow(2, level) * 47);
					var newcol = col + (Math.pow(2, level) * 107);
					var returnUrl = "http://xdworld.vworld.kr:8080/2d/Base/201512/" + (level + 7) + "/" + newcol + "/" + newrow + ".png";
					return returnUrl;
				}
			});
		};
		
		// 브이월드 위성맵 세팅
		pub.initVWorldSatelliteLayer = function () {
			dojo.declare("VworldTiledSatelliteMapServiceLayer", esri.layers.TiledMapServiceLayer, 
			{
				constructor: function () {
					this.id = "SatelliteMap";
					this.spatialReference = new esri.SpatialReference(WKT);
					this.initialExtent = (this.fullExtent = new esri.geometry.Extent(13417793.028, 3777430.348, 15084515.335, 4772379.684, this.spatialReference));
					var lod = [];

					this.tileInfo = TILEINFO;

					this.loaded = true;
					this.onLoad(this);
				},
				
				getTileUrl: function (level, row, col) {
					
					var newrow = row + (Math.pow(2, level) * 47);
					var newcol = col + (Math.pow(2, level) * 107);
					var returnUrl = "http://xdworld.vworld.kr:8080/2d/Satellite/201301/" + (level + 7) + "/" + newcol + "/" + newrow + ".jpeg";
					return returnUrl;
				}
			});
		};
		
		// 브이 월드 중첩맵 세팅
		pub.initVWorldHybridLayer = function () {
			dojo.declare("VworldTiledHybridMapServiceLayer", esri.layers.TiledMapServiceLayer, 
			{
				constructor: function () {
					this.id = "HybridMap";
					this.spatialReference = new esri.SpatialReference(WKT);
					this.initialExtent = (this.fullExtent = new esri.geometry.Extent(13417793.028, 3777430.348, 15084515.335, 4772379.684, this.spatialReference));
					var lod = [];

					this.tileInfo = TILEINFO;

					this.loaded = true;
					this.onLoad(this);
				},
				
				getTileUrl: function (level, row, col) {
					
					var newrow = row + (Math.pow(2, level) * 47);
					var newcol = col + (Math.pow(2, level) * 107);
					var returnUrl = "http://xdworld.vworld.kr:8080/2d/Hybrid/201512/" + (level + 7) + "/" + newcol + "/" + newrow + ".png";
					return returnUrl;
				}
			});
		};
		
		// print: setting
		pub.setPrint = function() {
			var $btn = $("#printBtn");
			
			if($btn == undefined)
				return;
			
			$btn.on("click", function() {
				page.view.customPrintTask.print();
				
//				alert('개발중입니다.');
				return;
				showLoading();
				esri.config.defaults.io.proxyUrl = "/proxy.jsp";
					
				var template = new esri.tasks.PrintTemplate();
				template.exportOptions = {
					width: page.view.map.width,
					height: page.view.map.height,
					dpi: 96
				};
				template.format = "PNG32";
				template.layout = "MAP_ONLY";
				template.preserveScale = false;
				
				var params = new esri.tasks.PrintParameters();
				params.map = page.view.map;
				params.template = template;
				
				var task = new esri.tasks.PrintTask($define.ARC_SERVER_URL+"/rest/services/Utilities/PrintingTools/GPServer/Export%20Web%20Map%20Task");
				task.execute(params, $kecoMap.model.printResult, $kecoMap.model.printError);
			});
		};
		pub.printError = function(error)
		{
			alert('저장중 에러가 발생하였습니다.');
			closeLoading();
		};
		// print: remove print evt, box
		pub.printResult = function(result) {
			
			var msg = "인쇄를 실패하였습니다.<br>다시 시도하여 주시기 바랍니다.";
			if(result == null) {
				alert(msg);
				return;
			}
			
			if (result.url == null || result.url == "") {
				alert(msg);
				return;
			}
			
			closeLoading();
			var printdoc = window.open("","오염","toolbar=no,location=no,directories=no,menubar=no,scrollbars=no,left=0, top=0");
			
			printdoc.document.write('<html>');
			printdoc.document.write('<head>');
			printdoc.document.write('<title>오염 - 인쇄</title>');
			printdoc.document.write('<body style="margin: 0; padding: 0;">');
			printdoc.document.write("<img src='" + result.url + "'>");
			printdoc.document.write('</body>');
			printdoc.document.write('</html>');
			
			printdoc.document.close();
			printdoc.focus();  
			printdoc.window.print();
		};
		
		// save: setting
		pub.setSave = function() {
			var $btn = $("#saveBtn");
			if($btn == undefined)
				return;
			
			$btn.on("click", function() {
				page.view.customPrintTask.capture();
				return;
				
//				map.setMapCursor("url(/ce/resources/cur/pan.cur), auto");
				
				var formatID = "mapSave_format";
				var layoutID = "mapSave_layout";
				var btnID = "mapSave_btn_save";
				
				var html = "<div class='content'><div>"
							+ "	<label for='" + formatID + "'>파일유형</label>"
							+ "	<select id='" + formatID + "'>"
							+ "		<option value='none'>파일유형 선택</option>"
							+ "		<option value='PDF'>PDF</option>"
							+ "		<option value='PNG32'>PNG</option>"
							+ "		<option value='JPG'>JPG</option>"
							+ "	</select>"
							+ "</div>"
							+ "<div>"
							+ "	<label for='" + layoutID + "'>문서크기</label>"
							+ "	<select id='" + layoutID + "'>"
							+ "		<option value='none'>문서크기 선택</option>"
							+ "		<option value='MAP_ONLY'>현재화면</option>"
							+ "		<option value='A3 Landscape'>A3 가로형</option>"
							+ "		<option value='A3 Portrait'>A3 세로형</option>"
							+ "		<option value='A4 Landscape'>A4 가로형</option>"
							+ "		<option value='A4 Portrait'>A4 세로형</option>"
							+ "	</select>"
							+ "</div>"
							+ "<div class='btn'>"
							+ "	<ul>"
							+ "		<input id='" + btnID + "' type='button' value='저장하기'/>"
							+ "	</ul>"
							+ "</div></div>";
				
				$("#saveBox").empty();
				$("#saveBox").append(html);
				
				var saveBox = dialogCustom({
					id: "saveBox",
					width: 300,
					height: 300,
					title: '<img src="/ce/resources/images/common/popup_title_mapsave.png" />',
					close: true,
					position: [340, 110],
					autoOpen: true,
					resizable: false,
					display: false
				});
				
				$("#" + btnID).bind("click", function () {
					var formatValue = $("#" + formatID + " option:selected").val();
					var layoutValue = $("#" + layoutID + " option:selected").val();
					
					$kecoMap.model.saveEvt(formatValue, layoutValue);
				});
			});
		};
		
		pub.saveEvt = function(format, layout) {
			if (format == 'none') {
				alert("파일유형을 선택해주시기 바랍니다");
				return;
			}
			
			if (layout == 'none') {
				alert("문서크기를 선택해주시기 바랍니다");
				return;
			}
			
			showLoading();
			
			esri.config.defaults.io.proxyUrl = "/proxy.jsp";
				
			var template = new esri.tasks.PrintTemplate();
			template.exportOptions = {
				width: page.view.map.width,
				height: page.view.map.height,
				dpi: 96
			};
			
			template.layoutOptions = {
				titleText: '토양지하수정보시스템 GIS',
				authorText: '토양지하수과',
				copyrightText: '환경부 국립환경과학원',
				scalebarUnit: 'Kilometers',
				legendLayers: [],
				customTextElements: ''
			};
			template.label = '';
			template.format = format;
			template.layout = layout;
			template.preserveScale = false;
			template.showAttribution = false;
			
			var params = new esri.tasks.PrintParameters();
			params.map = page.view.map;
			params.template = template;
			
			var task = new esri.tasks.PrintTask($define.ARC_SERVER_URL+"/rest/services/Utilities/PrintingTools/GPServer/Export%20Web%20Map%20Task");
			task.execute(params, $kecoMap.model.saveResult , $kecoMap.model.saveError);
		};
		
		pub.saveError = function(error)
		{
			alert('저장중 에러가 발생하였습니다.');
			closeLoading();
		};
		pub.saveResult = function(result) {
			var msg = "저장을 실패하였습니다.<br>다시 시도하여 주시기 바랍니다.";
			
			if(result == null) {
				alert(msg);
				return;
			}
			
			if (result.url == null || result.url == "") {
				alert(msg);
				return;
			}
			
			closeLoading();
			
			window.location.href = '/download.jsp?filename=' + result.url;
		};
		
		pub.setVworldSearch = function() {
			var $btn = $("#vworldBtn");
			if($btn == undefined)
				return;
			
			$btn.on("click", function() {
				window.open("/vworldSearchPop.jsp",'vworldSearchPop','width=750,height=410,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,left=100,top=50');
				
			});
		};
		
		pub.setTempBAdd = function() {
			var $btn = $("#tempBBtn");
			if($btn == undefined)
				return;
			
			$btn.on("click", function() {
				alert('임시지점으로 등록할 곳을 지도에서 클릭하세요.');
				page.view.dtype = 10;
			});
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
//					console.log("window.location.href : ", window.location.href);
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
//						$('#40').attr('checked', true);
//						$('#41').attr('checked', true);
						
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
			
			for(var i =0; i<myAuthorSessionFactCode.length;i++)
			{
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
		
		pub.getMargerSymbolTm = function(bermImg)
		{
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
		
		pub.initFeatureLayer = function(alertData)
		{
			$kecoMap.model.alertData = alertData;
			
			this.addAllLayer(1);
			
		};
		pub.addTMSLayer = function(level)
		{
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
			
//			//테스트 용
//			h = 37;
//			w = 23;
//			y = 13;
			
			// selection symbol used to draw the selected census block points within the buffer polygon
			var symbol = new esri.symbol.PictureMarkerSymbol({
				"url":"gis/images/auticon/t_1.png",//$define.ARC_SERVER_URL+"/rest/services/WPCS_EDIT/MapServer/4/images/"+$define.ARC_SERVER_IMG_TMS,
				"height":h,
				"width":w,
				"type":"esriPMS"
			});
			var symbol1 = new esri.symbol.PictureMarkerSymbol({ "url":"gis/images/auticon/t_1.png", "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var symbol2 = new esri.symbol.PictureMarkerSymbol({ "url":"gis/images/auticon/t_2.png", "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var symbol3 = new esri.symbol.PictureMarkerSymbol({ "url":"gis/images/auticon/t_3.png", "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var symbol4 = new esri.symbol.PictureMarkerSymbol({ "url":"gis/images/auticon/t_4.png", "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var symbol5 = new esri.symbol.PictureMarkerSymbol({ "url":"gis/images/auticon/t_5.png", "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var symbol6 = new esri.symbol.PictureMarkerSymbol({ "url":"gis/images/auticon/t_6.png", "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			var symbol7 = new esri.symbol.PictureMarkerSymbol({ "url":"gis/images/auticon/t_7.png", "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			
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
									page.view.map.infoWindow.resize(250, 250);
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
//			//테스트 용
//			h = 41;
//			w = 26;
//			y = 13;
			
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
										page.view.map.infoWindow.resize(250, 250);
									} else if( alertData != undefined) {
										obj.ALERT_MSG = alertData.ALERT_MSG;
										graphic.setInfoTemplate(new esri.InfoTemplate(IPUSN_TEMP_ALERT));
										page.view.map.infoWindow.resize(250, 250);
									} else {
										graphic.setInfoTemplate(new esri.InfoTemplate(IPUSN_TEMP));
										page.view.map.infoWindow.resize(250, 190);
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
			
//			//테스트 용
//			h = 41;
//			w = 26;
//			y = 13;
			
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
										page.view.map.infoWindow.resize(250, 250);
									} else if( alertData != undefined) {
										obj.ALERT_MSG = alertData.ALERT_MSG;
										graphic.setInfoTemplate(new esri.InfoTemplate(AUTO_TEMP_ALERT));
										
										page.view.map.infoWindow.resize(250, 250);
									} else {
										graphic.setInfoTemplate(new esri.InfoTemplate(AUTO_TEMP));
										page.view.map.infoWindow.resize(250, 190);
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
		
		pub.addTempBLayer = function(level)
		{
			//MODE_SNAPSHOT MODE_ONDEMAND
			var firstFlag = false;
			if($kecoMap.view.tempBLayer == null){
				var firstFlag = true;
				$kecoMap.view.tempBLayer = new esri.layers.FeatureLayer($define.ARC_SERVER_URL+"/rest/services/WPCS_EDIT/FeatureServer/6",{
					mode: esri.layers.FeatureLayer.MODE_ONDEMAND,
	//				infoTemplate: new esri.InfoTemplate(TEMPLATJSON),
					outFields: ["*"],
					id: "tempBLayer"
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
			
			var symbol = new esri.symbol.PictureMarkerSymbol({ "url":$define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/MapServer/6/images/'+$define.ARC_SERVER_IMG_TMPB, "height":h, "width":w, "type":"esriPMS", "yoffset":y });
			
			var rend = new esri.renderer.SimpleRenderer(symbol);
			
//			$kecoMap.view.autoLayer.setSelectionSymbol(selectionSymbol);
			$kecoMap.view.tempBLayer.setRenderer(rend);
			// 수계별로 보여줌
//			if(user_riverid != undefined &&  user_riverid != 'null'){
				$kecoMap.view.tempBLayer.setDefinitionExpression("USE_YN = '1' AND (ALL_YN = '1' OR (REG_ID = '"+$('#userId').val()+"'))");
//			}
			
			if(firstFlag){
				$kecoMap.view.map.addLayer($kecoMap.view.tempBLayer, 5);
				
				dojo.connect($kecoMap.view.tempBLayer, "onMouseOver", function(evt) {
					var graphic = new esri.Graphic(undefined, undefined);
					
					var return_flag = false;
					try{
						var paramData = $.extend({}, {}, evt.graphic.attributes);
						paramData.REG_DATE = formatYMDHM(paramData.REG_DATE);
						
						paramData.CONTENT = '<br>'+paramData.CONTENT.replace(/\n/g,'<br>');
						
						graphic.setAttributes(paramData);
						graphic.setInfoTemplate(new esri.InfoTemplate(TEMP_B_TEMP));
						page.view.map.infoWindow.resize(250, 300);
						
						page.model.showInfoWindow(graphic, evt);
						
					}catch(e)
					{}
				});
				
				//listen for when map.graphics onMouseOut event is fired and then clear the highlight graphic
				//and hide the info window
				dojo.connect($kecoMap.view.tempBLayer, "onMouseOut", function(evt) {
//					page.view.map.graphics.clear();
					page.view.map.infoWindow.hide();
				});
				dojo.connect($kecoMap.view.tempBLayer, "onClick", function(evt) {
					$kecoMap.view.tempBData = evt.graphic.attributes;
					window.open("/tempBRegPop.jsp?regId="+$('#userId').val()+"&type=1",'tempBRegPop','width=550,height=430,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,left=100,top=50');
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
			
//			//테스트 용
//			h = 41;
//			w = 26;
//			y = 13;
			
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
		
		
		pub.removeAllLayer = function()
		{
			page.view.map.removeLayer(page.view.tmsLayer);
			page.view.map.removeLayer(page.view.autoLayer);
			page.view.map.removeLayer(page.view.ipusnLayer);
			page.view.map.removeLayer(page.view.whLayer);
			page.view.map.removeLayer(page.view.tempBLayer);
		};
		
		pub.addAllLayer = function(level)
		{
			this.addAutoLayer(level);
			this.addipusnLayer(level);
			this.addTMSLayer(level);
			this.addWhLayer(level);
			this.addTempBLayer(level);
		};
//클릭해서 포인트 이동
//		pub.upGeometry = undefined;
//		
//		pub.initAutoLayerEdit = function()
//		{
//			var editToolbar = new esri.toolbars.Edit($kecoMap.view.map);
//			
//			dojo.connect(editToolbar, "onDeactivate", function(tool,graphic) {
////				var params = new esri.tasks.ProjectParameters();
////				params.geometries = [graphic.geometry];
////				params.outSR = MAP_SPATIALREFERENCE;
////				
////				 $kecoMap.view.gsvc.project(params, function(projectedPoints) {
////						var pt = projectedPoints[0];
////						
////						console.log(projectedPoints);
////						
////						$kecoMap.view.autoLayer.attr('x',graphic.geometry.x);
////						$kecoMap.view.autoLayer.attr('y',graphic.geometry.y);
////				});
//				
//				if($kecoMap.model.upGeometry == undefined)
//					return;
//				graphic.geometry = $kecoMap.model.upGeometry;
//				
////				$kecoMap.model.writeJSON(graphic);
//				$kecoMap.view.autoLayer.applyEdits(null, [graphic], null, function(result){
////					console.log('[applyEdits]' , result);
//					
////					$kecoMap.view.gsvc.project(params, function(projectedPoints) {
////						var pt = projectedPoints[0];
////						console.log(projectedPoints);
////						$kecoMap.view.autoLayer.attr('x',graphic.geometry.x);
////						$kecoMap.view.autoLayer.attr('y',graphic.geometry.y);
////					});
//				});
//			});
//		
//			dojo.connect($kecoMap.view.autoLayer, "onMouseUp", function(evt) {
//				if (editingEnabled) {
//					$kecoMap.model.upGeometry = evt.mapPoint;
//					editToolbar.deactivate();
//					editingEnabled = false;
//					} 
//			});
//			
//			var editingEnabled = false;
//			
//			dojo.connect($kecoMap.view.autoLayer, "onClick", function(evt) {
//				dojo.stopEvent(evt);
//				
//				if (editingEnabled === false) {
//					editingEnabled = true;
//					editToolbar.activate(esri.toolbars.Edit.MOVE , evt.graphic);
//				} else {
//					editToolbar.deactivate();
//					editingEnabled = false;
//				}
//			});
//		};
//		
//		pub.upUSNGeometry = undefined;
//		
//		pub.initUSNLayerEdit = function()
//		{
//			var editToolbar = new esri.toolbars.Edit($kecoMap.view.map);
//			
//			dojo.connect(editToolbar, "onDeactivate", function(tool,graphic) {
//				
//				if($kecoMap.model.upUSNGeometry == undefined)
//					return;
//				graphic.geometry = $kecoMap.model.upUSNGeometry;
//				
////				$kecoMap.model.writeJSON(graphic);
//				$kecoMap.view.ipusnLayer.applyEdits(null, [graphic], null, function(result){
//					console.log('[applyEdits]' , result);
//					
////					$kecoMap.view.gsvc.project(params, function(projectedPoints) {
////						var pt = projectedPoints[0];
////						console.log(projectedPoints);
////						$kecoMap.view.autoLayer.attr('x',graphic.geometry.x);
////						$kecoMap.view.autoLayer.attr('y',graphic.geometry.y);
////					});
//				});
//			});
//		
//			dojo.connect($kecoMap.view.ipusnLayer, "onMouseUp", function(evt) {
//				if (editingEnabled) {
//					$kecoMap.model.upUSNGeometry = evt.mapPoint;
//					editToolbar.deactivate();
//					editingEnabled = false;
//					} 
//			});
//			
//			var editingEnabled = false;
//			
//			dojo.connect($kecoMap.view.ipusnLayer, "onClick", function(evt) {
//				dojo.stopEvent(evt);
//				
//				if (editingEnabled === false) {
//					editingEnabled = true;
//					editToolbar.activate(esri.toolbars.Edit.MOVE , evt.graphic);
//				} else {
//					editToolbar.deactivate();
//					editingEnabled = false;
//				}
//			});
//		};
//		
//		pub.upWhGeometry = undefined;
//		
//		pub.initWhLayerEdit = function()
//		{
//			var editToolbar = new esri.toolbars.Edit($kecoMap.view.map);
//			
//			dojo.connect(editToolbar, "onDeactivate", function(tool,graphic) {
//				
//				if($kecoMap.model.upWhGeometry == undefined)
//					return;
//				graphic.geometry = $kecoMap.model.upWhGeometry;
//				
////				$kecoMap.model.writeJSON(graphic);
//				$kecoMap.view.whLayer.applyEdits(null, [graphic], null, function(result){
//					console.log('[applyEdits]' , result);
//					
////					$kecoMap.view.gsvc.project(params, function(projectedPoints) {
////						var pt = projectedPoints[0];
////						console.log(projectedPoints);
////						$kecoMap.view.autoLayer.attr('x',graphic.geometry.x);
////						$kecoMap.view.autoLayer.attr('y',graphic.geometry.y);
////					});
//				});
//			});
//		
//			dojo.connect($kecoMap.view.whLayer, "onMouseUp", function(evt) {
//				if (editingEnabled) {
//					$kecoMap.model.upWhGeometry = evt.mapPoint;
//					editToolbar.deactivate();
//					editingEnabled = false;
//					} 
//			});
//			
//			var editingEnabled = false;
//			
//			dojo.connect($kecoMap.view.whLayer, "onClick", function(evt) {
//				dojo.stopEvent(evt);
//				
//				if (editingEnabled === false) {
//					editingEnabled = true;
//					editToolbar.activate(esri.toolbars.Edit.MOVE , evt.graphic);
//				} else {
//					editToolbar.deactivate();
//					editingEnabled = false;
//				}
//			});
//		};
//클릭해서 포이트 이동 끝
		
		pub.writeJSON = function(data)
		{
			for ( var obj in data) 
			{
				if(typeof(data[obj]) == 'function')
					continue;
				
//				console.log(obj, data[obj]);
			}
		};
		
		
		pub.init = function() {
			TILEINFO = new esri.layers.TileInfo({
				"rows": 256,
				"cols": 256,
				"origin": ORIGIN,
				"spatialReference": {
					"wkt": WKT
				},
				"lods": [
							{ "level": 0, "resolution": 1222.99245256249, "scale": 4622324.434309 },
							{ "level": 1, "resolution": 611.49622628138, "scale": 2311162.217155 },
							{ "level": 2, "resolution": 305.748113140558, "scale": 1155581.108577 },
							{ "level": 3, "resolution": 152.874056570411, "scale": 577790.554289 },
							{ "level": 4, "resolution": 76.4370282850732, "scale": 288895.277144 },
							{ "level": 5, "resolution": 38.2185141425366, "scale": 144447.638572 },
							{ "level": 6, "resolution": 19.1092570712683, "scale": 72223.819286 },
							{ "level": 7, "resolution": 9.55462853563415, "scale": 36111.909643 },
							{ "level": 8, "resolution": 4.77731426794937, "scale": 18055.954822 },
							{ "level": 9, "resolution": 2.38865713397468, "scale": 9027.977411 },
							{ "level": 10, "resolution": 1.19432856685505, "scale": 4513.988705 },
							{ "level": 11, "resolution": 0.597164283559817, "scale": 2256.994353 }
							]
			});
			
			this.initVWorldBaseLayer();
			this.initVWorldSatelliteLayer();
			this.initVWorldHybridLayer();
			
			var spatialReference = new esri.SpatialReference(WKT);
				
			var initialExtent = new esri.geometry.Extent({ "xmin": 13517793.028, "ymin": 3877430.348, "xmax": 15084515.335, "ymax": 4672379.684, "spatialReference": spatialReference });
			
			var initCenter = esri.geometry.geographicToWebMercator(new esri.geometry.Point('127.81560','36.813077'));
			
			var infoWindow = new esri.dijit.InfoWindow({}, dojo.create("div"));
			infoWindow.startup();
			
			page.view.map = new esri.Map("map",
					{
					sliderPosition:'top-right',
					slider: false,
					logo: false,
					sliderStyle: "large",
					Extent:initialExtent,
					center : initCenter,
					infoWindow: infoWindow,
					zoom: 1});
			
			if(window.location.href.indexOf('main') > -1 || window.location.href.indexOf('init') > -1 ) {
				page.view.customPrintTask = new Sgis.map.task.CustomPrintTask(page.view.map, "map","psupport/jsps/CustomPrintTask.jsp", esriConfig.defaults.io.proxyUrl);
			}
			 
			dojo.connect(page.view.map, "onZoomEnd" , $kecoMap.controller.zoomEnd);
			
			dojo.connect(page.view.map, "onLoad" , $kecoMap.controller.initDraw);
			dojo.connect(page.view.map, "onClick" , $kecoMap.model.drawSymbol);
			
			page.view.vworldLayer = new VworldTiledMapServiceLayer();
			page.view.map.addLayer(page.view.vworldLayer);
			
			page.view.vworldSatelliteLayer = new VworldTiledSatelliteMapServiceLayer();
			page.view.map.addLayer(page.view.vworldSatelliteLayer);
			
			page.view.vworldSatelliteLayer.hide();
			
			page.view.vworldHybridLayer = new VworldTiledHybridMapServiceLayer();
			page.view.map.addLayer(page.view.vworldHybridLayer);
			
			page.view.vworldHybridLayer.hide();
			
			var imageParametersndk1 = new esri.layers.ImageParameters();
//			imageParametersndk1.layerIds = [0,8,12,14,23,32,40,43,47];
			imageParametersndk1.layerIds = [40];
			imageParametersndk1.layerOption = esri.layers.ImageParameters.LAYER_OPTION_SHOW;
//			http://118.37.180.151:5006/rest/services/map_weis_new_ver1_1/MapServer
			page.view.mainLayer = new esri.layers.ArcGISDynamicMapServiceLayer($define.ARC_SERVER_URL+'/rest/services/WPCS/MapServer/', {
				"imageParameters":imageParametersndk1
			});
				
			page.view.map.addLayer(page.view.mainLayer);
			
			MAP_SPATIALREFERENCE = page.view.mainLayer.spatialReference;
			
			esriConfig.defaults.io.proxyUrl = "/proxy.jsp";
			esriConfig.defaults.io.alwaysUseProxy = false;
			
			page.view.gsvc = new esri.tasks.GeometryService($define.ARC_SERVER_URL+"/rest/services/Utilities/Geometry/GeometryServer");
			
			this.setPrint();
			this.setSave();
			this.setVworldSearch();
			this.setTempBAdd();
			
//			this.getMeasureQueryData();
			this.writeLayerLegend($define.ARC_SERVER_URL+'/rest/services/WPCS/MapServer/');//1/images/104f45cc8fd8beba7fadc0fd8d151741
			page.view.bufferLayer = new esri.layers.GraphicsLayer();
			page.view.map.addLayer(page.view.bufferLayer);
			page.view.bufferLayer.show();
			
			page.view.markerLayer = new esri.layers.GraphicsLayer();
			page.view.map.addLayer(page.view.markerLayer);
			page.view.markerLayer.show();
			
			dojo.connect(page.view.markerLayer, "onMouseOver", function(evt) {
				
				var content = evt.graphic.getContent();
				
				if(content == undefined)
					return;
				
//				page.view.map.infoWindow.setContent(content);
//				var title = evt.graphic.getTitle();
//				page.view.map.infoWindow.setTitle(title);
				page.view.map.infoWindow.resize(250, 180);
//				page.view.map.infoWindow.show(evt.screenPoint, page.view.map.getInfoWindowAnchor(evt.screenPoint));
				page.model.showInfoWindow(evt.graphic, evt);
			});
			
			dojo.connect(page.view.markerLayer, "onMouseOut", function(evt) {
				page.view.map.infoWindow.hide();
			});
			
			dojo.connect(page.view.markerLayer, "onClick", function(evt) {

				if(evt.graphic.attributes.datatype == 'AC')
				{
					window.open("/waterpollution/waterPollutionDetail.do?clickMenu=32120&wpCode="+evt.graphic.attributes.wpcode, 
					'wpView','width='+window.screen.width+',height='+window.screen.height+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left=0,top=0');
				}
			});
			
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
		
			
		pub.setButtonImg = function(img , src)
		{
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
		
		pub.showLoading = function()
		{
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
		
		pub.closeLoading = function()
		{
			if($("#loadingDiv") != undefined)
				$("#loadingDiv").dialog("close");
		};
		
		pub.initDraw = function(){
//			console.log('[initDraw ]');
			page.view.tb = new esri.toolbars.Draw(page.view.map);
			dojo.connect(page.view.tb, "onDrawEnd", page.model.drawEnded);
		};
		
		pub.mainLayerLoaded = function(layer)
		{
			console.log('[loaded ] = ', layer);
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
			//console.log('[KEPCO MAP INIT]');
			page.model.init();
			
			try
			{
				$kecoMap.model.baseObj = $main;
				$kecoMap.model.baseObj.model.intervalEvent();
				setInterval($kecoMap.model.baseObj.model.intervalEvent, 600000);
			}catch(e)
			{
				try
				{
					$kecoMap.model.baseObj = $control;
					
					$kecoMap.model.baseObj.model.intervalEvent();
					setInterval($kecoMap.model.baseObj.model.intervalEvent, 600000);
				}
				catch(e)
				{
//					$kecoMap.model.initFeatureLayer(undefined);
				}
			}
			
			if(window.location.href.indexOf('addrMap') > -1)
				$kecoMap.model.addAllLayer(1);
			
		};

		return pub;
	}());
	dojo.ready(page.controller.init);
	
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
		//alert(layer_Info);
		selectAllWaterPop(layer_Info);
	}
}

//특정 개체 위치로 확대 이동
function GL_MOVE(layer_Id,key){
	//36 -> layerId 값으로 layer_Id 파라미터를 넘김..임시적으로 36 넣어놓음(WPCS 서비스 댐 레이어)
	
	var findTask,findParams;
	
	findTask = new esri.tasks.FindTask($define.ARC_SERVER_URL+"/rest/services/WPCS/MapServer");
	
	findParams = new esri.tasks.FindParameters();
	findParams.returnGeometry = true;
	findParams.layerIds = [layer_Id];
	
	findParams.searchFields = ["ID"];
	findParams.searchText = key;
	
	findTask.execute(findParams,function(results){
		dojo.forEach(results, function(result) {
			
		});
		var wm = esri.geometry.geographicToWebMercator(new esri.geometry.Point(results[0].feature.geometry.x,results[0].feature.geometry.y));
		$kecoMap.view.map.centerAndZoom(wm,10);
	});
}

//XY 좌표로 확대이동
function GL_MOVE_XY(x,y){
	var point = new esri.geometry.Point(x,y);
	var wm = esri.geometry.geographicToWebMercator(new esri.geometry.Point(x,y));
	$kecoMap.view.map.centerAndZoom(point,10);
	
	//yoffset을 주기 위해 변경
	var symbol = new esri.symbol.PictureMarkerSymbol({ "url":window.location.origin+"/gis/images/apoint.png", "height":"31", "width":"17", "type":"esriPMS", "yoffset":"14" });
	var graphic = new esri.Graphic(wm, symbol);
	
	$kecoMap.view.map.graphics.add(graphic);
}

//선택지점 레이어명과 KEYV값 리턴(dobuffer와 동일 - dojo.connect onclick 이벤트가 일어난 후 타는 함수)
function GL_GET_KEYV(layer,evt){
	var layer_Info = "";
	var params = new esri.tasks.BufferParameters();
	var p_distance = $('#tool_buffer_txt').val();
	params.geometries = [ evt.graphic.geometry ];
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
		        var graphic = new esri.Graphic(geometry,symbol);
		        $kecoMap.view.map.graphics.add(graphic);
			 var query = new esri.tasks.Query();
			 
			 query.geometry = geometry;
			 query.outFields = ["*"];
			 
			 if(layer == 'a'){
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
						 }		*/				
					 }
					 //alert(layer_Info);
				 });
			 }else if(layer == 'u'){
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
					 //alert(layer_Info);
				 });
			 }
		     
		 });
		$kecoMap.view.map.setExtent(results[0].getExtent().expand(2));
	});

}

//반경내 모든 레이어명 및 KEYV값 리턴(dobuffer_all과 동일 - dojo.connect onclick 이벤트가 일어난후 타는 함수)
function GL_GET_ALLKEYV(evt){
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
		      var layer = new esri.layers.GraphicLayer();
		      layer.add(graphic);
		      $kecoMap.view.map.addLayer(layer);
		      //$kecoMap.view.map.reorderLayer(layer,0);
			 //$kecoMap.view.map.graphics.add(graphic);
		      alert($kecoMap.view.map);
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
						/* if((response.features.length-1) > i){
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
						/* if((response.features.length-1) > i){
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
						 /*if((response.features.length-1) > i){
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
						/* if((response.features.length-1) > i){
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
						 /*if((response.features.length-1) > i){
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
						/* if((response.features.length-1) > i){
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
