dojo.require("esri.map");
dojo.require("esri.layers.WebTiledLayer");
dojo.require("esri.layers.FeatureLayer");
dojo.require("esri.InfoTemplate");
dojo.require("esri.geometry.Point");

dojo.require("dojo.domReady!");

var $waterMap = function () {
	// private functions & variables
	var ARC_SERVER_URL = "http://10.101.164.236:6080/arcgis"
	var WKT = 3857;
	var MAP_SPATIALREFERENCE = null; // 4326;

	var ORIGIN = {
		"x": 13462700,
		"y": 5322463
	};
	var TILEINFO = null;
	var spatialReference = null;

	var map;
	var vworldLayer;
	var vworldHybridLayer;
	var vworldSatelliteLayer;

	var rdngFeatureLayer;

	var rdngTextGraphicsLayer;

	var rdngTitleGraphicsLayer;

	var featureDatas = {};

	var currentDepth = 'd1';
	var currentFieldName = 'PHY';

	var refreshTimer;

	var symbolColors = {};


	var init = function () {
		symbolColors['NORMAL'] = [15, 237, 100, 0.9];
		symbolColors['A1'] = [124, 170, 244, 0.9];
		symbolColors['A2'] = [237, 233, 28, 0.9];
		symbolColors['A3'] = [237, 86, 16, 0.9];
		symbolColors['A4'] = [237, 32, 9, 0.9];
		symbolColors['M'] = [107, 99, 98, 0.9];
		symbolColors['PHY'] = [30, 7, 239, 0.9];

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
		initVWorldBaseLayer();
		initVWorldSatelliteLayer();
		initVWorldHybridLayer();

		spatialReference = new esri.SpatialReference(WKT);

		var initialExtent = new esri.geometry.Extent({
			xmax: 14381785.062839303,
			xmin: 14290060.628897216,
			ymax: 4322831.032734754,
			ymin: 4261681.410106694,
			spatialReference: spatialReference
		});

		map = new esri.Map("map", {
			sliderPosition: 'top-right',
			slider: false,
			logo: false,
			sliderStyle: "large",
			Extent: initialExtent,
			center: new esri.geometry.Point(14194854.735083774, 4382780.991764621, spatialReference),
			zoom: 0
		});

		vworldLayer = new VworldTiledMapServiceLayer();
		map.addLayer(vworldLayer);

		vworldSatelliteLayer = new VworldTiledSatelliteMapServiceLayer();
		map.addLayer(vworldSatelliteLayer);
		vworldSatelliteLayer.hide();

		vworldHybridLayer = new VworldTiledHybridMapServiceLayer();
		map.addLayer(vworldHybridLayer);
		vworldHybridLayer.hide();

		map.on('zoom-end', function(event){
			var depth = '';
			if(event.level < 3){
				depth = 'd1';
			}else if(event.level < 5){
				depth = 'd2';
			}else{
				depth = 'd3';
			}
			
			if(currentDepth != depth){
				var fieldName;

				if(currentDepth == 'd3'){
					fieldName = $('.active').attr('value');
				}

				currentDepth = depth;
				
				if(depth == 'd3'){
					fieldName = 'MIN_OR';
					$('#playBtnDiv').hide();
				}else{
					$('#playBtnDiv').show();
				}
				
				refreshFeatureLayers(fieldName);
			}
		})

		getFeatures();

		refreshTimer = window.setInterval(getFeatures, 1000* 60* 10);
	}

	var getFeatures = function () {

		var query2 = new esri.tasks.Query();
		query2.outFields = ['GIS_SD_PT.OBJECTID', 'WPCS.V_FACT_LOC_INFO_1D.DO_NM','WPCS.V_FACT_LOC_INFO_1D.TOTAL','WPCS.V_FACT_LOC_INFO_1D.NORMAL','WPCS.V_FACT_LOC_INFO_1D.A1','WPCS.V_FACT_LOC_INFO_1D.A2','WPCS.V_FACT_LOC_INFO_1D.A3','WPCS.V_FACT_LOC_INFO_1D.A4','WPCS.V_FACT_LOC_INFO_1D.M','WPCS.V_FACT_LOC_INFO_1D.PHY'];
		query2.returnGeometry = true;
		query2.outSpatialReference = spatialReference;
		query2.where = '1=1';

		var query3 = new esri.tasks.Query();
		query3.outFields = ['GIS_SGG_PT.OBJECTID', 'GIS_SGG_PT.DO_NM', 'GIS_SGG_PT.CTY_NM','WPCS.V_FACT_LOC_INFO_2D.TOTAL','WPCS.V_FACT_LOC_INFO_2D.NORMAL','WPCS.V_FACT_LOC_INFO_2D.A1','WPCS.V_FACT_LOC_INFO_2D.A2','WPCS.V_FACT_LOC_INFO_2D.A3','WPCS.V_FACT_LOC_INFO_2D.A4','WPCS.V_FACT_LOC_INFO_2D.M','WPCS.V_FACT_LOC_INFO_2D.PHY'];
		query3.returnGeometry = true;
		query3.outSpatialReference = spatialReference;
		query3.where = '1=1';

		var query4 = new esri.tasks.Query();
		query4.outFields = ['FACT_CODE', 'FACT_NAME', 'BRANCH_NO','MIN_TIME','MIN_OR','RIVER_DIV','SYS_KIND','ADM_CD','PHY'];
		query4.returnGeometry = false;
		query4.where = '1=1';

		var query5 = new esri.tasks.Query();
		query5.outFields = ['OBJECTID', 'FACT_CODE', 'BRANCH_NO'];
		query5.returnGeometry = true;
		query5.outSpatialReference = spatialReference;
		query5.where = "USE_FLAG='Y'";

		var query6 = new esri.tasks.Query();
		query6.outFields = ['OBJECTID', 'FACT_CODE', 'BRANCH_NO'];
		query6.returnGeometry = true;
		query6.outSpatialReference = spatialReference;
		query6.where = "1=1";


		var queryTask2 = new esri.tasks.QueryTask(ARC_SERVER_URL + '/rest/services/WPCS_V_FACT/MapServer/0');
		var queryTask3 = new esri.tasks.QueryTask(ARC_SERVER_URL + '/rest/services/WPCS_V_FACT/MapServer/1');
		var queryTask4 = new esri.tasks.QueryTask(ARC_SERVER_URL + '/rest/services/WPCS_V_FACT/MapServer/2');

		var queryTask5 = new esri.tasks.QueryTask(ARC_SERVER_URL + '/rest/services/WPCS_EDIT/FeatureServer/1');
		var queryTask6 = new esri.tasks.QueryTask(ARC_SERVER_URL + '/rest/services/WPCS_EDIT/FeatureServer/2');
		var queryTask7 = new esri.tasks.QueryTask(ARC_SERVER_URL + '/rest/services/WPCS_EDIT/FeatureServer/4');

		var queryTask2Def = queryTask2.execute(query2);
		var queryTask3Def = queryTask3.execute(query3);
		var queryTask4Def = queryTask4.execute(query4);

		var queryTask5Def = queryTask5.execute(query6);
		var queryTask6Def = queryTask6.execute(query5);
		var queryTask7Def = queryTask7.execute(query6);


		var deferredlist = new dojo.DeferredList([queryTask2Def, queryTask3Def,  queryTask5Def, queryTask6Def, queryTask7Def, queryTask4Def]);

		deferredlist.then(function (result) {
			
			featureDatas['d1'] = [];
			featureDatas['d2'] = [];
			featureDatas['d3'] = [];

			tempd3 = [];

			for(var z=0; z<result.length; z++){

				if(result[z][0]){
					var featureData = result[z][1].features;

					for(var i=0; i<featureData.length; i++){
						var feature = featureData[i];
						
						for(var key in feature.attributes){
							var len = key.split('.');
							feature.attributes[len[len.length-1]] = feature.attributes[key];
							if(len.length > 1){
								delete feature.attributes[key];
							}
						}
						var dIndex = (z+1);
						if(dIndex > 2){
							dIndex = 3;
						}
						if(z != 5){
							featureDatas['d'+dIndex].push(feature);
						} else{
							var d2Data =  featureDatas['d3'];

							for(var j=0; j<d2Data.length; j++){

								var d2Feature = d2Data[j];
								if(d2Feature.geometry == null){
									continue;
								}
								if(String(feature.attributes.FACT_CODE) == String(d2Feature.attributes.FACT_CODE)  
									&& String(feature.attributes.BRANCH_NO) == String(d2Feature.attributes.BRANCH_NO)){
									var tempFeature = {};
									tempFeature.attributes = dojo.extend(feature.attributes, {});
									tempFeature.geometry = dojo.extend(d2Feature.geometry, {});
									tempFeature.attributes.OBJECTID = j;
									tempd3.push(tempFeature);
								}
							}
						}
					}
				}
			}
			
			featureDatas['d3'] = tempd3;
			refreshFeatureLayers();
		});
	}
	var getRenderer = function (features) {
		if(currentDepth == 'd3'){

			var h = 41;
			var w = 26;
			var y = 0;

			var symbols = {};			

			symbols['W0'] = new esri.symbol.PictureMarkerSymbol({"url":"./images/t_1.png","height":h,"width":w,"type":"esriPMS"});
			symbols['W1'] = new esri.symbol.PictureMarkerSymbol({"url":"./images/t_3.png","height":h,"width":w,"type":"esriPMS"});
			symbols['W2'] = new esri.symbol.PictureMarkerSymbol({"url":"./images/t_4.png","height":h,"width":w,"type":"esriPMS"});
			symbols['W3'] = new esri.symbol.PictureMarkerSymbol({"url":"./images/t_5.png","height":h,"width":w,"type":"esriPMS"});
			symbols['W9'] = new esri.symbol.PictureMarkerSymbol({"url":"./images/t_6.png","height":h,"width":w,"type":"esriPMS"});


			symbols['A0'] = new esri.symbol.PictureMarkerSymbol({"url":"./images/a_1.png","height":h,"width":w,"type":"esriPMS"});
			symbols['A1'] = new esri.symbol.PictureMarkerSymbol({"url":"./images/a_2.png","height":h,"width":w,"type":"esriPMS"});
			symbols['A2'] = new esri.symbol.PictureMarkerSymbol({"url":"./images/a_3.png","height":h,"width":w,"type":"esriPMS"});
			symbols['A3'] = new esri.symbol.PictureMarkerSymbol({"url":"./images/a_4.png","height":h,"width":w,"type":"esriPMS"});
			symbols['A4'] = new esri.symbol.PictureMarkerSymbol({"url":"./images/a_5.png","height":h,"width":w,"type":"esriPMS"});
			symbols['A9'] = new esri.symbol.PictureMarkerSymbol({"url":"./images/a_6.png","height":h,"width":w,"type":"esriPMS"});

			symbols['U0'] = new esri.symbol.PictureMarkerSymbol({"url":"./images/u_1.png","height":h,"width":w,"type":"esriPMS"});
			symbols['U1'] = new esri.symbol.PictureMarkerSymbol({"url":"./images/u_2.png","height":h,"width":w,"type":"esriPMS"});
			symbols['U2'] = new esri.symbol.PictureMarkerSymbol({"url":"./images/u_3.png","height":h,"width":w,"type":"esriPMS"});
			symbols['U3'] = new esri.symbol.PictureMarkerSymbol({"url":"./images/u_4.png","height":h,"width":w,"type":"esriPMS"});
			symbols['U4'] = new esri.symbol.PictureMarkerSymbol({"url":"./images/u_5.png","height":h,"width":w,"type":"esriPMS"});
			symbols['U9'] = new esri.symbol.PictureMarkerSymbol({"url":"./images/u_6.png","height":h,"width":w,"type":"esriPMS"});

			var symbol = new esri.symbol.PictureMarkerSymbol({"url":"./images/c10.png","height":16,"width":16,"type":"esriPMS"});

			var renderer = new esri.renderer.UniqueValueRenderer(symbol, 'OBJECTID');

			for(var i=0; i<features.length; i++){
				var feature = features[i].attributes;
				renderer.addValue(feature.OBJECTID, symbols[feature.SYS_KIND+feature.MIN_OR]);
			}

			return renderer;
		}
		
		var outlineSymbol = new esri.symbol.SimpleLineSymbol().setWidth(0);
		var symbolSize = 75;
		var symbol = new esri.symbol.SimpleMarkerSymbol(esri.symbol.SimpleMarkerSymbol.STYLE_CIRCLE, symbolSize, outlineSymbol, new esri.Color(symbolColors[currentFieldName]));
		var d1Renderer = new esri.renderer.ClassBreaksRenderer(symbol, currentFieldName);
			
		if(currentFieldName == 'PHY'){
			
		}
		
		return d1Renderer;
	}

	var getInfoTemplate = function () {
		if (currentDepth == 'd3') {
			return new esri.InfoTemplate("${FACT_CODE}", "측정소명 :   ${FACT_NAME}");
		}else{
			return null;
			
		}
		//  else if(currentDepth == 'd2'){
		// 	return new esri.InfoTemplate("${CTY_NM}", "VAL :   ${"+currentFieldName+"}");
		// }else {
		// 	return new esri.InfoTemplate("${DO_NM}", "VAL :   ${"+currentFieldName+"}");
		// }
	}

	var refreshFeatureLayers = function (fieldName) {
		if(fieldName){
			currentFieldName = fieldName;
		}

		if (rdngFeatureLayer != null) {
			map.removeLayer(rdngFeatureLayer);
		}
		if (rdngTextGraphicsLayer != null) {
			map.removeLayer(rdngTextGraphicsLayer);
		}
		if (rdngTitleGraphicsLayer != null) {
			map.removeLayer(rdngTitleGraphicsLayer);
		}

		var fields = [];
		fields.push({ "name": "OBJECTID", "type": "esriFieldTypeOID", "alias": "OBJECTID" });
		fields.push({ "name": currentFieldName, "type": "esriFieldTypeString", "alias": currentFieldName });

		var features = [];
		for(var i=0; i<featureDatas[currentDepth].length; i++){
			var feature = featureDatas[currentDepth][i];
			
			var featureExtend = {};
			featureExtend.attributes = dojo.extend(feature.attributes, {});
			featureExtend.geometry = dojo.extend(feature.geometry, {});

			features.push(featureExtend)
		}
		var featureCollection = {
			featureSet: { "geometryType": "esriGeometryPoint", "features": features},
			layerDefinition: { "geometryType": "esriGeometryPoint", "fields": fields }
		};

		rdngFeatureLayer = new esri.layers.FeatureLayer(featureCollection, {
			id: 'rdngFeatureLayer',
			infoTemplate: getInfoTemplate(),
			spatialReference: new esri.SpatialReference(WKT)

		});
		rdngFeatureLayer.setRenderer(getRenderer(features));
		
		map.addLayer(rdngFeatureLayer);
		
		rdngFeatureLayer.on('click', function (event){
			if($waterMap.featureClicked){
				if(typeof($waterMap.featureClicked) == 'function'){
					$waterMap.featureClicked.apply(this, [currentDepth, event.graphic.attributes]);
				}
			}
		});
		if(currentDepth != 'd3'){
			rdngTextGraphicsLayer = new esri.layers.GraphicsLayer({ id: 'rdngTextGraphicsLayer' });

			for (var i = 0; i < featureDatas[currentDepth].length; i++) {
				var feature = featureDatas[currentDepth][i];
				var symbol = new esri.symbol.TextSymbol({
						text: feature.attributes[currentFieldName],
						yoffset: -7,
						font: {
							size: 10,
							family: "arial",
							weight: esri.symbol.Font.WEIGHT_BOLD
						},
						color: new esri.Color('#fff'),
						verticalAlignment: "middle"
					});	
				var targetGeo = esri.geometry.webMercatorToGeographic(feature.geometry);
				var textGraphic = new esri.Graphic(new esri.geometry.Point(targetGeo.x, targetGeo.y), symbol);
				rdngTextGraphicsLayer.add(textGraphic);
			}

			map.addLayer(rdngTextGraphicsLayer);

			rdngTitleGraphicsLayer = new esri.layers.GraphicsLayer({ id: 'rdngTitleGraphicsLayer' });

			var titleFieldNm = 'DO_NM';
			if(currentDepth == 'd2'){
				titleFieldNm = 'CTY_NM';
			}
			for (var i = 0; i < featureDatas[currentDepth].length; i++) {
				var feature = featureDatas[currentDepth][i];
				var symbol = new esri.symbol.TextSymbol({
						text: feature.attributes[titleFieldNm],
						yoffset: 7,
						font: {
							size: 10,
							family: "arial",
							weight: esri.symbol.Font.WEIGHT_BOLD
						},
						color: new esri.Color('#fff'),
						verticalAlignment: "middle"
					});	
				var targetGeo = esri.geometry.webMercatorToGeographic(feature.geometry);
				var textGraphic = new esri.Graphic(new esri.geometry.Point(targetGeo.x, targetGeo.y), symbol);
				rdngTitleGraphicsLayer.add(textGraphic);
			}

			map.addLayer(rdngTitleGraphicsLayer);
		}
	}

	var initVWorldBaseLayer = function () {
		dojo.declare("VworldTiledMapServiceLayer", esri.layers.TiledMapServiceLayer, {
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
				var returnUrl = "http://xdworld.vworld.kr:8080/2d/Base/201802/" + (level + 7) + "/" + newcol + "/" + newrow + ".png";
				return returnUrl;
			}
		});
	};

	// 브이월드 위성맵 세팅
	var initVWorldSatelliteLayer = function () {
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
	var initVWorldHybridLayer = function () {
		dojo.declare("VworldTiledHybridMapServiceLayer", esri.layers.TiledMapServiceLayer, {
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

	// public functions
	return {

		init: function () {
			var me = this;

			init();

			return me;
		},
		getMap: function () {
			return map;
		},
		changeRdngFeatureLayer: function(fieldName){
			refreshFeatureLayers(fieldName);
		}
	};
}();
