dojo.require("dijit.layout.BorderContainer");
dojo.require("dijit.layout.ContentPane");
dojo.require("esri.map");
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

var $arcGIS;

$(function() {
	
	var page = {
		"dom" : $(this)
	};
	
	var TAG = page.id;
//	var WKT = "PROJCS[\"Google_Maps_Global_Mercator\",GEOGCS[\"GCS_WGS_1984\",DATUM[\"D_WGS_1984\",SPHEROID[\"WGS_1984\",6378137.0,298.257223563]],PRIMEM[\"Greenwich\",0.0],UNIT[\"Degree\",0.0174532925199433]],PROJECTION[\"Mercator_2SP\"],PARAMETER[\"false_easting\",0.0],PARAMETER[\"false_northing\",0.0],PARAMETER[\"central_meridian\",0.0],PARAMETER[\"standard_parallel_1\",0.0],PARAMETER[\"latitude_of_origin\",0.0],UNIT[\"Meter\",1.0]]";
	var WKT = 3857;
	var MAP_SPATIALREFERENCE = null; //4326;
	var ARC_SERVER_URL = 'http://10.101.214.91:6080/rest/services/WPCS/MapServer/';
	
	var ORIGIN  =  {
						"x": 13462700,
						"y": 5322463
				};
	var TILEINFO = null; 
	
	var evtClick = null;
	var evtDoubleClick = null;
	var evtIdentify = null;
	
	// ////////////////////////////
	// MVC 설정 시작
	// ////////////////////////////

	// TODO MVC::model 관련 코드 작성
	page.model = ( function() {
		// ////////////////////////////
		// private variables
		// ////////////////////////////
		// Model 초기화
		
		var pub = {};

		pub.moveCenter = function()
		{
			var wm = esri.geometry.geographicToWebMercator(new esri.geometry.Point(127.402,36.34));
			
			
//			page.view.map.centerAndZoom(wm, 0.5);
			page.view.map.centerAt(wm);
		};
		pub.moveTarget = function(latitude,longitude)
		{
			var wm = esri.geometry.geographicToWebMercator(new esri.geometry.Point(latitude,longitude));
			
			
//			page.view.map.centerAndZoom(wm, 0.5);
			page.view.map.centerAt(wm);
		};
		pub.generalMap = function()
		{
//			page.view.mainLayer.show(); 
			page.view.vworldLayer.show();
			page.view.vworldSatelliteLayer.hide(); 
			page.view.vworldHybridLayer.hide(); 
			mapidx = 0;
			setButtonImg('Image2','/gis//images/tool_2_off.gif');
		};
		
		pub.flightMap = function()
		{
//			page.view.vworldLayer.show(); 
//			page.view.mainLayer.hide();
			page.view.vworldLayer.hide();
			page.view.vworldSatelliteLayer.show(); 
			page.view.vworldHybridLayer.show(); 
			mapidx = 1;
			setButtonImg('Image1','/gis/images/tool_1_off.gif');
		};
		
		pub.drawSymbol = function(mevt)
		{
			console.log('[DRAW SYMBOL]', mevt);
			
			if (page.view.dtype == 2)
			{
				var pictureMarkerSymbol = new esri.symbol.PictureMarkerSymbol('http://blogfiles.naver.net/20130218_2/comesummer_1361193282117Viont_PNG/p11.png', 15, 15);
				pictureMarkerSymbol.setOffset(5,5);
				page.view.map.graphics.add(new esri.Graphic(mevt.mapPoint, pictureMarkerSymbol));
			}
			else if(page.view.dtype == 3)
			{
				
				var pictureMarkerSymbol = new esri.symbol.PictureMarkerSymbol('http://blogfiles.naver.net/20120812_282/comesummer_1344757559719iYe2Y_PNG/38.png', 15, 15);
				pictureMarkerSymbol.setOffset(0,0);
					
				page.view.map.graphics.add(new esri.Graphic(mevt.mapPoint, pictureMarkerSymbol));
			}
		};
		pub.addGraphic = function(geometry)
		{
			console.log('[GEOMETRY] ',geometry);
			if(page.view.dtype == 0)
			{
				var symbol = page.view.tb.fillSymbol;
				page.view.map.graphics.add(new esri.Graphic(geometry, symbol));
				page.view.tb.deactivate();
				
				var q = new esri.tasks.Query();
				q.geometry = geometry;
				q.returnGeometry = true;
				q.outFields = ["*"];
				
//				var qt = new esri.tasks.QueryTask("http://118.37.180.151:5006/rest/services/map_weis_new_ver1_1/MapServer/4");
				var qt = new esri.tasks.QueryTask(ARC_SERVER_URL+"13");
				
				qt.execute(q, $arcGIS.controller.handleCounties2);
			}
			else if (page.view.dtype == 2)
			{
//				page.view.map.graphics.clear();
				page.view.gsvc.project([geometry],MAP_SPATIALREFERENCE , function(graphics){
					console.log('[onProjectComplete]', graphics);
					if(page.view.dtype == 2)
					{
						page.view.map.graphics.add(new esri.Graphic(geometry, page.view.tb.lineSymbol));
						
						var lengthParams = new esri.tasks.LengthsParameters();
						lengthParams.polylines = graphics;
						lengthParams.geodesic = true;
						lengthParams.lengthUnit = esri.tasks.GeometryService.UNIT_METER;
						
						$arcGIS.view.gsvc.lengths(lengthParams, function(result){
							console.log('[onLengthsComplete]', result);
							console.log('[geometry]', geometry);
							var point = geometry.paths[0][geometry.paths[0].length-1];
							var textSymbol = new esri.symbol.TextSymbol(dojo.number.format(result.lengths[0] / 1000) + " Km");
							textSymbol.setOffset(35,-10);
							$arcGIS.view.map.graphics.add(new esri.Graphic(new esri.geometry.Point(point[0],point[1],$arcGIS.view.map.spatialReference), textSymbol));
							
							$arcGIS.view.tb.deactivate();
							toolbaridx = -1;
							setButtonImg('Image3','/gis/images/tool_3_off.gif');
						});
					}
				});
			}
			else if(page.view.dtype == 3)
			{
				var areasAndLengthParams = new esri.tasks.AreasAndLengthsParameters();
				areasAndLengthParams.lengthUnit = esri.tasks.GeometryService.UNIT_KILOMETER;
				areasAndLengthParams.areaUnit = esri.tasks.GeometryService.UNIT_SQUARE_KILOMETERS;
				
				page.view.map.graphics.add(new esri.Graphic(geometry, page.view.tb.fillSymbol));
				
				$arcGIS.view.gsvc.simplify([geometry], function(simplifiedGeometries) 
				{
					areasAndLengthParams.polygons = simplifiedGeometries;
					$arcGIS.view.gsvc.areasAndLengths(areasAndLengthParams, function(result) {
						console.log('[onAreasEndLengthsComplete]', result);
						console.log('[geometry]', geometry);
						
						var point = geometry.rings[0][geometry.rings[0].length-3];
						var textSymbol = new esri.symbol.TextSymbol(dojo.number.format(result.areas[0])+" K㎢");
						textSymbol.setOffset(35,-10);
						$arcGIS.view.map.graphics.add(new esri.Graphic(new esri.geometry.Point(point[0],point[1],$arcGIS.view.map.spatialReference), textSymbol));
						
						$arcGIS.view.tb.deactivate();
						toolbaridx = -1;
						setButtonImg('Image4','/gis/images/tool_4_off.gif');
					});
				});
			}
			else
			{
				switch (geometry.type) {
					case "point":
						var symbol = new esri.symbol.SimpleMarkerSymbol(esri.symbol.SimpleMarkerSymbol.STYLE_SQUARE, 10, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([255,0,0]), 1), new dojo.Color([0,255,0,0.25]));
						break;
					case "polyline":
						var symbol = new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_DASH, new dojo.Color([255,0,0]), 1);
						break;
					case "polygon":
						var symbol = new esri.symbol.SimpleFillSymbol(esri.symbol.SimpleFillSymbol.STYLE_NONE, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_DASHDOT, new dojo.Color([255,0,0]), 2), new dojo.Color([255,255,0,0.25]));
						break;
				}

				var graphic = new esri.Graphic(geometry, symbol);
				page.view.map.graphics.add(graphic);

				var params = new esri.tasks.BufferParameters();

				params.distances = [ 1 ];
				params.bufferSpatialReference = MAP_SPATIALREFERENCE;
				params.outSpatialReference = $arcGIS.view.map.spatialReference;
				params.unit = esri.tasks.BufferParameters.UNIT_KILOMETER;
			  
				if (geometry.type === "polygon") {
					//if geometry is a polygon then simplify polygon.  This will make the user drawn polygon topologically correct.
					page.view.gsvc.simplify([geometry], function(graphics) {
						params.features = graphics;
						page.view.gsvc.buffer(params, function(features) {
							this.showBuffer(features);
						});
					});
				} 
				else 
				{
					params.features = [geometry];
					page.view.gsvc.buffer(params, function(features) {
						this.showBuffer(features);
					});
				}
			}
		};
		
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
					var returnUrl = "http://xdworld.vworld.kr:8080/2d/Base/201301/" + (level + 7) + "/" + newcol + "/" + newrow + ".png";
//					var returnUrl = "http://xdworld.vworld.kr:8080/2d/Hybrid/201301/" + (level + 7) + "/" + newcol + "/" + newrow + ".png";
					
//					http://xdworld.vworld.kr:8080/2d/Hybrid/201301/7/110/48.png
						

					return returnUrl;
				}
			});
		};
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
//					
//					http://xdworld.vworld.kr:8080/2d/Satellite
						
//					var returnUrl = "http://xdworld.vworld.kr:8080/2d/Hybrid/201301/" + (level + 7) + "/" + newcol + "/" + newrow + ".png";
					
//					http://xdworld.vworld.kr:8080/2d/Hybrid/201301/7/110/48.png
						

					return returnUrl;
				}
			});
		};
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
					var returnUrl = "http://xdworld.vworld.kr:8080/2d/Hybrid/201301/" + (level + 7) + "/" + newcol + "/" + newrow + ".png";
//					var returnUrl = "http://xdworld.vworld.kr:8080/2d/Hybrid/201301/" + (level + 7) + "/" + newcol + "/" + newrow + ".png";
					

					return returnUrl;
				}
			});
		};
		
		pub.queryTask = null;
		
		pub.features = null;
		pub.meGraphicsLayer = null;
		
		pub.getMeasureQueryData = function()
		{
			var q = new esri.tasks.Query();
			q.returnGeometry = true;
			q.outFields = ["*"];
			q.where = "OBJECTID < 72";
				
			this.queryTask	= new esri.tasks.QueryTask(ARC_SERVER_URL+"9");
			
			this.queryTask.execute(q, function(result){
				console.log('[RESULT]', result);
				
				$arcGIS.model.features = result.features;
				
				if(result.features == undefined || result.features.length == 0 )
					return;
				
				var infoTemplate = new esri.InfoTemplate("${사업장명칭}","${*}");

//				var symbol = new esri.symbol.SimpleMarkerSymbol();
//				symbol.style = esri.symbol.SimpleMarkerSymbol.STYLE_X;
//				symbol.setSize(10);
//				symbol.setColor(new dojo.Color([255,255,0,0.5]));
				  
				var symbol = new esri.symbol.PictureMarkerSymbol('/gis/images/al.png', 15, 15);
//				symbol.setOffset(5,5);
				
				
				$arcGIS.view.map.graphics.clear();
//				var highlightSymbol = new esri.symbol.SimpleFillSymbol(esri.symbol.SimpleFillSymbol.STYLE_SOLID, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([255,0,0]), 3), new dojo.Color([125,125,125,0.35]));

				meGraphicsLayer = new esri.layers.GraphicsLayer();
				
				for (var i=0, il=result.features.length; i<il; i++) {
					var graphic = result.features[i];
					graphic.setSymbol(symbol);
					graphic.setInfoTemplate(infoTemplate);
					meGraphicsLayer.add(graphic);
				}
				$arcGIS.view.map.addLayer(meGraphicsLayer);
				$arcGIS.view.map.graphics.enableMouseEvents();
				
				dojo.connect(meGraphicsLayer, "onMouseOver", function(evt) {
					page.view.map.graphics.clear();  //use the maps graphics layer as the highlight layer
					var content = evt.graphic.getContent();
					$arcGIS.view.map.infoWindow.setContent(content);
					var title = evt.graphic.getTitle();
					$arcGIS.view.map.infoWindow.setTitle(title);
					
//					var highlightGraphic = new esri.Graphic(evt.graphic.geometry,highlightSymbol);
//					
//					$arcGIS.view.map.graphics.add(highlightGraphic);
					$arcGIS.view.map.infoWindow.show(evt.screenPoint,page.view.map.getInfoWindowAnchor(evt.screenPoint));
				});

				//listen for when map.graphics onMouseOut event is fired and then clear the highlight graphic
				//and hide the info window
				dojo.connect(page.view.map.graphics, "onMouseOut", function(evt) {
//					$arcGIS.view.map.infoWindow.hide();
				});
			});
		};
		
		pub.init = function() {
			console.log('[MODEL INIT]');
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
			page.view.map = new esri.Map("mapDiv", {sliderPosition:'top-left', autoResize:true, slider: true, logo: false, sliderStyle: "small", Extent:initialExtent });
			//sliderPosition:'top-left',
			dojo.connect(page.view.map, "onLoad" , $arcGIS.controller.initDraw);
			dojo.connect(page.view.map, "onClick" , $arcGIS.model.drawSymbol);
			
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
			imageParametersndk1.layerIds = [9];
			imageParametersndk1.layerOption = esri.layers.ImageParameters.LAYER_OPTION_SHOW;
//			http://118.37.180.151:5006/rest/services/map_weis_new_ver1_1/MapServer
			page.view.ndk1 = new esri.layers.ArcGISDynamicMapServiceLayer(ARC_SERVER_URL, {
			  "imageParameters":imageParametersndk1
			});
				
//			page.view.map.addLayer(page.view.mainLayer);
			page.view.map.addLayer(page.view.ndk1);
			
			MAP_SPATIALREFERENCE = page.view.ndk1.spatialReference;
			
			
			dojo.connect(page.view.mainLayer, "onLoad" , $arcGIS.controller.loaded);
			dojo.connect(page.view.ndk1, "onLoad" , $arcGIS.controller.loaded);
				
//			var scalebar = new esri.dijit.Scalebar({
//				map: page.view.map,
//				attachTo: "bottom-left",
//				scalebarUnit:"metric"
//			});
				
//			page.view.queryTask = new esri.tasks.QueryTask("http://118.37.180.151:5006/rest/services/map_weis_new_ver1_1/MapServer/4");
			
			esriConfig.defaults.io.proxyUrl = "/proxy.jsp";
			esriConfig.defaults.io.alwaysUseProxy = false;

			page.view.gsvc = new esri.tasks.GeometryService("http://localhost:6080/rest/services/Utilities/Geometry/GeometryServer");
			
			page.controller.setEvent();
			
			this.getMeasureQueryData();
			
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
		// View 초기화
		var pub = {};
		pub.map = null;
		pub.ndk1 = null;  
		pub.visible = [];
		pub.mainLayer = null;
		pub.arrayUtils = null; 
		pub.lcnt=0;
		pub.queryTask = null;
		pub.query = null;
		pub.gsvc = null;
		pub.tb = null;
		pub.vworldLayer = null;
		pub.vworldSatelliteLayer = null;
		pub.vworldHybridLayer = null;
		
		pub.map_weis_new_ver1_1 = null;
		pub.map_weis_new_ver1_0 = null;
		
		pub.dtype = 0;
		
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

		// Controller 초기화
		pub.init = function() {
			// Model 과 View 초기화
			page.view.init();
			
			// ///////////////////
			// 이벤트 핸들러 등록
			// ///////////////////
			
			pub.initDraw = function(){
				console.log('[INIT TOOLBAR]');
				page.view.tb = new esri.toolbars.Draw(page.view.map);
				dojo.connect(page.view.tb, "onDrawEnd", page.model.addGraphic);
//				dojo.connect(page.view.tb, "onDrawComplete", page.model.drawSymbol);
				
			};
			
			pub.loaded = function(layer)
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
					page.view.map.infoWindow.show(evt.screenPoint,page.view.map.getInfoWindowAnchor(evt.screenPoint));
				});

				//listen for when map.graphics onMouseOut event is fired and then clear the highlight graphic
				//and hide the info window
				dojo.connect(page.view.map.graphics, "onMouseOut", function(evt) {
					page.view.map.graphics.clear();
					page.view.map.infoWindow.hide();
				});
			};
			
			pub.setEvent = function()
			{
//				dojo.connect(page.view.gsvc, "onLengthsComplete", function (result) {
//					
//						
//				});
//				dojo.connect(page.view.gsvc, "onProjectComplete", function(graphics) {
//				  //call GeometryService.lengths() with projected geometry
//					
//				});
				
			};
			
			page.model.init();
			
		};
		return pub;
	}());

	dojo.ready(page.controller.init);
	
	$arcGIS = page;
});


var toolbaridx = -1;
var mapidx = 0;

function setButtonImg(img , src)
{
	$('#'+img).attr('src', src);
}

function MM_swapImgRestore(img, src) { //v3.0
	
	if($('#'+img).attr('idx') == toolbaridx  || $('#'+img).attr('idx') == mapidx)
		return;
	
	$('#'+img).attr('src', src);
}
function MM_preloadImages() { //v3.0
	var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
	var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
	if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
	var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
		d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
	if(!(x=d[n])&&d.all) x=d.all[n]; 
	for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
	for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
	if(!x && d.getElementById) x=d.getElementById(n); return x;
}
function MM_swapImage(img, src) { //v3.0
	$('#'+img).attr('src', src);
}

