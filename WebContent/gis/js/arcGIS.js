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
dojo.require("esri.toolbars.edit");
dojo.require("esri.symbols.SimpleFillSymbol");
dojo.require("esri.renderers.UniqueValueRenderer");
dojo.require("dgrid.OnDemandGrid");
dojo.require("dojo.store.Memory");
dojo.require("esri.tasks.ProjectParameters");


//dojo.require("esri.geometry.webMercatorUtils");

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

var $arcGIS;

$(function() {
	
    var page = {
        "dom" : $(this)
    };
    
    var TAG = page.id;
//    var WKT = "PROJCS[\"Google_Maps_Global_Mercator\",GEOGCS[\"GCS_WGS_1984\",DATUM[\"D_WGS_1984\",SPHEROID[\"WGS_1984\",6378137.0,298.257223563]],PRIMEM[\"Greenwich\",0.0],UNIT[\"Degree\",0.0174532925199433]],PROJECTION[\"Mercator_2SP\"],PARAMETER[\"false_easting\",0.0],PARAMETER[\"false_northing\",0.0],PARAMETER[\"central_meridian\",0.0],PARAMETER[\"standard_parallel_1\",0.0],PARAMETER[\"latitude_of_origin\",0.0],UNIT[\"Meter\",1.0]]";
    var WKT = 3857;
    var MAP_SPATIALREFERENCE = null; //4326;
    
    var ORIGIN  =  {
			    		"x": 13462700,
			    		"y": 5322463
		    	   };
    var TILEINFO = null; 
    
    var TEMPLATJSON  = {
			 title:"${사업장명칭}",
			 content: "<ul>"+
			 		  "<li> ● 수신시간  : ${date} ${time} </li>" +
			 		  "<li> ● PH : ${ph}</li>" +
			 		  "<li> ● DO : ${DO1} (ms/L)</li>" +
			 		  "<li> ● EC : ${EC1} (mS/w)</li>" +
			 		  "<li> ● 탁도 : ${NTU}</li>" +
			 		  "<li> ● 온도 : ${heat}</li></ul>"};
    var EVENT_TEMPLATJSON  = {
			 title:"${acct_act_content}",
			 content: "<ul>"+
			 		  "<li> ● 주소  : ${addr} </li>" +
			 		  "<li> ● 수계  : ${river_div} </li>" +
			 		  "<li> ● 지점 : ${branch_name}</li>" +
			 		  "<li> ● 측정소 : ${fact_name}</li>" +
			 		  "<li> ● 날짜 : ${start_date}</li>" +
			 		  "<li> ● 상태 : ${status}</li></ul>"};
	
    
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
    	pub.eventLayer = undefined;
    	pub.accidentData = [];
    	
    	pub.intervalEvent = function()
    	{
    		// 사고발생 정보 조회
    		this.getAccident();
    		
    		// 평시 조회
    		
    		// 이상상태 조회
    	};
    	pub.daum = function()
    	{
    		daum.addr2coord('호매실동 965', '$arcGIS.model.daumCallBack');
    	};
    	
    	pub.daumCallBack = function(result)
    	{
    		console.log(result);
    		if(result.channel.item.lengdbl-clickth > 0)
    			this.moveCenter(result.channel.item[0].point_x, result.channel.item[0].point_y);
    	};
    	
    	pub.getAccident = function()
    	{
    		var today = new Date();
    		
    		var yday = today.getFullYear()-1 + addzero(today.getMonth()+1) + addzero(today.getDate());
    	    var today = today.getFullYear()+ addzero(today.getMonth()+1) +addzero(today.getDate());
    	    	
    		$.ajax({
				url: '/psupport/jsps/getAccidentXML.jsp?searchRiverDiv=all&searchWpKind=all&searchSupportKind=all&startDate='+yday+'&endDate='+today,
					dataType: 'text',
				success: function(data) {
					
					data = xml2json.parser(data);
					
					console.log(data.accidents.accident);
					
					$arcGIS.model.accidentData = [];
					
					for ( var i = 0; i < data.accidents.accident.length; i++) 
					{
						data.accidents.accident[i].x = data.accidents.accident[i].longitude;
						data.accidents.accident[i].y = data.accidents.accident[i].latitude;
						
						if(data.accidents.accident[i].wpsstep != 'END' )
							$arcGIS.model.accidentData.push(data.accidents.accident[i]);
					}
					
					$arcGIS.model.eventCall($arcGIS.model.accidentData);
				}
			});	
    	};
    	pub.eventCall = function(coord, distances)
    	{
    		if(this.eventLayer == undefined) 
    			this.eventLayer = new esri.layers.GraphicsLayer();
    		else
    			this.eventLayer.clear();
    		
    		if(coord == undefined || coord.length < 0)
    			return;
    		
    		if(distances == undefined)
    			distances = 10;
    		
    		var geometries = [];
    		for ( var i = 0; i < coord.length; i++) {
    			var geo = esri.geometry.geographicToWebMercator(new esri.geometry.Point(coord[i].x,coord[i].y));
    			geometries.push(geo);
			}
    		
    		for ( var i = 0; i < geometries.length; i++) {
  		  		var pictureMarkerSymbol = new esri.symbol.PictureMarkerSymbol('/gis/images/event.gif', 50, 50);
	  			pictureMarkerSymbol.setOffset(10,10);
	  			var graphic = new esri.Graphic(geometries[i], pictureMarkerSymbol);
	  			graphic.setAttributes(coord[i]);
	  			graphic.setInfoTemplate(new esri.InfoTemplate(EVENT_TEMPLATJSON));
	  			this.eventLayer.add(graphic);
    		}
    		$arcGIS.view.map.addLayer(this.eventLayer);
    		
    		dojo.connect(this.eventLayer, "onMouseOver", function(evt) {
            	var content = evt.graphic.getContent();
            	$arcGIS.view.map.infoWindow.setContent(content);
            	var title = evt.graphic.getTitle();
            	$arcGIS.view.map.infoWindow.setTitle(title);
            	$arcGIS.view.map.infoWindow.show(evt.screenPoint,page.view.map.getInfoWindowAnchor(evt.screenPoint));
            });

	            //listen for when map.graphics onMouseOut event is fired and then clear the highlight graphic
	            //and hide the info window
    		dojo.connect(this.eventLayer, "onMouseOut", function(evt) {
    			$arcGIS.view.map.infoWindow.hide();
    		});
	            
//    		var params = new esri.tasks.BufferParameters();
//  		    params.geometries  = geometries;
//  		    params.distances = [ distances];
//  		    params.unit = esri.tasks.GeometryService.UNIT_KILOMETER;
////  		    
//  		    console.log(params);
  		    
//  		  	$arcGIS.view.gsvc.buffer(params, function(result){
//  		  		console.log('[RESULT]', result);
//  		  		
//  		  		var symbol = new esri.symbol.SimpleFillSymbol(
//  		  			esri.symbol.SimpleFillSymbol.STYLE_SOLID,
//  					  new esri.symbol.SimpleLineSymbol(
//  							esri.symbol.SimpleLineSymbol.STYLE_SHORTDASHDOTDOT,
//  							  new dojo.Color([255,0,0]), 
//  							  2
//  					  ),new dojo.Color([255,0,0,0.01]));
//  		  	
//  		  		for ( var i = 0; i < result.length; i++) {
//	  		  		var bufferGeometry = result[i];
//	  		  		var graphic = new esri.Graphic(bufferGeometry, symbol);
//	  		  		$arcGIS.model.eventLayer.add(graphic);
//	  		  		
////		  		  	var query = new esri.tasks.Query();
////	  		  		query.geometry = bufferGeometry;
////	  		  		$arcGIS.view.featureLayer.selectFeatures(query, esri.layers.FeatureLayer.SELECTION_NEW, function(results){
////	  		  			console.log('[FEATURE LAYER RESULT]', results);
////	  		  		});
//				}
  		  		
//  		  	});
    	};
  	   	pub.updateLayerVisibility = function() {
  	   		var inputs = dojo.query(".list_item");
          //in this application layer 2 is always on.
  	   		page.view.visible = [];
  	   		
  	   		for (var i=0, il=inputs.length; i<il; i++) {
  	   			if (inputs[i].checked) {
  	   				page.view.visible.push(inputs[i].id);
  	   			}
  	   		}
           //if there aren't any layers visible set the array value to = -1
  	   		if(page.view.visible.length === 0){
  	   			page.view.visible.push(-1);
  	   		}
  		
  	   		page.view.ndk1.setVisibleLayers(page.view.visible);
  	   	};
  	  
	    pub.moveCenter = function(x,y)
		{
	    	var wm = esri.geometry.geographicToWebMercator(new esri.geometry.Point(x,y));
			
	    	
//	    	page.view.map.centerAndZoom(wm, 0.5);
	    	page.view.map.centerAt(wm);
		};
	    
	    pub.generalMap = function()
	    {
//	    	page.view.mainLayer.show(); 
	    	page.view.vworldLayer.show();
	    	page.view.vworldSatelliteLayer.hide(); 
	    	page.view.vworldHybridLayer.hide(); 
	    	mapidx = 0;
	    	setButtonImg('Image2','/gis/images/tool_2_off.gif');
	    };
	    
	    pub.flightMap = function()
	    {
//	    	page.view.vworldLayer.show(); 
//	    	page.view.mainLayer.hide();
	    	page.view.vworldLayer.hide();
	    	page.view.vworldSatelliteLayer.show(); 
	    	page.view.vworldHybridLayer.show(); 
	    	mapidx = 1;
	    	setButtonImg('Image1','/gis/images/tool_1_off.gif');
	    };
	    
        pub.sear = function()
      	{
        	page.view.tb.activate(esri.toolbars.Draw.POLYGON);
        	page.view.map.graphics.clear();
        	page.view.dtype = 0;
      	};
      	
        pub.searBu = function()
      	{
        	page.view.tb.activate(esri.toolbars.Draw.POLYGON);
        	page.view.map.graphics.clear();
        	page.view.dtype = 1;
      	};
      	
      	pub.distances = function()
      	{
        	page.view.tb.activate(esri.toolbars.Draw.POLYLINE);
        	page.view.map.graphics.clear();
        	page.view.dtype = 2;
        	toolbaridx = 2;
        	setButtonImg('Image4','/gis/images/tool_4_off.gif');
        	
      	};
      	
      	pub.area = function()
      	{
        	page.view.tb.activate(esri.toolbars.Draw.POLYGON);
        	page.view.map.graphics.clear();
        	page.view.dtype = 3;
        	toolbaridx = 3;
        	setButtonImg('Image3','/gis/images/tool_3_off.gif');
      	};
      	
      	pub.clear = function()
      	{
//        	page.view.tb.activate(esri.toolbars.Draw.POLYGON);
        	page.view.map.graphics.clear();
        	page.view.dtype = 0;
        	toolbaridx = -1;
      	};
      	
      	
      	pub.print = function()
      	{
        	page.view.tb.activate(esri.toolbars.Draw.POLYGON);
        	page.view.map.graphics.clear();
        	page.view.dtype = 3;
      	};
      	
      	pub.drawSymbol = function(mevt)
      	{
      		console.log('[DRAW SYMBOL]', mevt);
      		var lonlat = esri.geometry.xyToLngLat(mevt.mapPoint.x, mevt.mapPoint.y);
      		console.log('[lonlat]', lonlat);
      		daum.coord2addr(lonlat[0], lonlat[1] , '$arcGIS.model.daumCallBack'); 
      		
      		if(page.view.dtype == 0)
      		{
      			 //define input buffer parameters
      		    var params = new esri.tasks.BufferParameters();
      		    params.geometries  = [ mevt.mapPoint ];
      		    params.distances = [ 10 ];
      		    params.unit = esri.tasks.GeometryService.UNIT_KILOMETER;
      		    console.log('[BUFFER]', params);
      		    
      		  	$arcGIS.view.gsvc.buffer(params, function(result){
      		  		console.log('[RESULT]', result);
      		  		
      		  		$arcGIS.view.map.graphics.clear();
      			  
      		  		var symbol = new esri.symbol.SimpleFillSymbol(
      		  			esri.symbol.SimpleFillSymbol.STYLE_NULL,
      					  new esri.symbol.SimpleLineSymbol(
      							esri.symbol.SimpleLineSymbol.STYLE_SHORTDASHDOTDOT,
      							  new dojo.Color([105,105,105]), 
      							  2
      					  ),new dojo.Color([255,255,0,0.25]));
      		  	console.log('[symbol]', symbol);
  		  		
      		  	
      		  		var bufferGeometry = result[0];
      		  	console.log('[bufferGeometry]', bufferGeometry);
  		  		
      		  		
      		  		var graphic = new esri.Graphic(bufferGeometry, symbol);
      		  		$arcGIS.view.map.graphics.add(graphic);

      		  	console.log('[$arcGIS.view.map.graphics.add(graphic)]');
  		  		
      		  		var query = new esri.tasks.Query();
      		  		query.geometry = bufferGeometry;
      		  		
      		  	console.log('[query]', query);
  		  		
      		  		$arcGIS.view.featureLayer.selectFeatures(query, esri.layers.FeatureLayer.SELECTION_NEW, function(results){
      		  			console.log('[FEATURE LAYER RESULT]', results);
      		  		});
      		  	});
      		}
      		if (page.view.dtype == 2)
      		{
      			var pictureMarkerSymbol = new esri.symbol.PictureMarkerSymbol('/gis/images/p11.png', 15, 15);
      			pictureMarkerSymbol.setOffset(5,5);
      			page.view.map.graphics.add(new esri.Graphic(mevt.mapPoint, pictureMarkerSymbol));
      		}
      		else if(page.view.dtype == 3)
      		{
      			
      			var pictureMarkerSymbol = new esri.symbol.PictureMarkerSymbol('/gis/images/38.png', 15, 15);
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
	        	
//	        	var qt = new esri.tasks.QueryTask("http://118.37.180.151:5006/rest/services/map_weis_new_ver1_1/MapServer/4");
	        	var qt = new esri.tasks.QueryTask(ARC_SERVER_IP+':'+ARC_SERVER_PORT+"/rest/services/WPCS/MapServer/13");
	        	
	        	qt.execute(q, $arcGIS.controller.handleCounties2);
        	}
        	else if (page.view.dtype == 2)
        	{
//        		page.view.map.graphics.clear();
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

	    pub.showBuffer = function(features) {
	    	
	      var symbol = new esri.symbol.SimpleFillSymbol(
	        esri.symbol.SimpleFillSymbol.STYLE_SOLID,
	        new esri.symbol.SimpleLineSymbol(
	          esri.symbol.SimpleLineSymbol.STYLE_SOLID,
	          new dojo.Color([255,0,0,0.65]), 2
	        ),
	        new dojo.Color([255,0,0,0.35])
	      );

	      for (var j=0, jl=features.length; j<jl; j++) {
	        features[j].setSymbol(symbol);
	        map.graphics.add(features[j]);
	      }
	      tb.deactivate();
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
//          			var returnUrl = "http://xdworld.vworld.kr:8080/2d/Hybrid/201301/" + (level + 7) + "/" + newcol + "/" + newrow + ".png";
          			
//          			http://xdworld.vworld.kr:8080/2d/Hybrid/201301/7/110/48.png
          				

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
//          			http://xdworld.vworld.kr:8080/2d/Satellite
          				
//          			var returnUrl = "http://xdworld.vworld.kr:8080/2d/Hybrid/201301/" + (level + 7) + "/" + newcol + "/" + newrow + ".png";
          			
//          			http://xdworld.vworld.kr:8080/2d/Hybrid/201301/7/110/48.png
          				

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
//          			var returnUrl = "http://xdworld.vworld.kr:8080/2d/Hybrid/201301/" + (level + 7) + "/" + newcol + "/" + newrow + ".png";
          			

          			return returnUrl;
          		}
			});
		};
		
		pub.topSliderInit = function() {
			var id = "ar_out_search";
			var $btn = $("#" + id);
			var $top = $("#search_result");
			
			$btn.on("click", function() {
				console.log("[CLICK ]");
				
				
				var status = $(this).attr("status");
				
				if(status == "show") {
					$(this).attr("status", "hide");
					$common.slide('search_result', 'left', '-350px');
//						$(this).css("background-image", img.replace("hide", "show"));
					$("#ar_out_img").attr("src","/gis/images/arrow_in.png");
					
				} else {
					$(this).attr("status", "show");
					$common.slide('search_result', 'left', '10px');
//						$(this).css("background-image", img.replace("show", "hide"));
					$("#ar_out_img").attr("src","/gis/images/arrow_out.png");
					
				}
			});
		};
		
		// print: setting
		pub.setPrint = function() {
			
			var $btn = $("#printBtn");
			
			console.log('[setPrin]')
			$btn.on("click", function() {
				alert('개발중입니다.');
				return;
				
				$arcGIS.model.removeEvt('print');
//				page.view.map.setMapCursor("url(/ce/resources/cur/pan.cur), auto");
			
//				var $loading = $("#printLoading");
//				$loading.css("display", "block");
				
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
				task.execute(params, $arcGIS.model.printResult, $arcGIS.model.printError);
			});
		};
		pub.printError = function(error)
		{
			alert('저장중 에러가 발생하였습니다.');
			closeLoading();
		};
		// print: remove print evt, box
		pub.printResult = function(result) {
			console.log('[printResult]', result);
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
			
			console.log(printdoc);
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
			var $btn = $("#save");
			
			$btn.on("click", function() {
				alert('개발중입니다.');
				return;
				
				$arcGIS.model.removeEvt('save');
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
				
				var saveBox = 	dialogCustom({
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
					
					$arcGIS.model.saveEvt(formatValue, layoutValue);
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
			task.execute(params, $arcGIS.model.saveResult , $arcGIS.model.saveError);
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
		
		// remove map click event
		pub.removeEvt = function(type) {
			
			if(evtClick != null) {
				dojo.disconnect(evtClick);
			}
			
			if(evtDoubleClick != null) {
				dojo.disconnect(evtDoubleClick);
			}
			
			if(evtIdentify != null) {
				dojo.disconnect(evtIdentify);
			}
			
			if(type != 'measurement') {
				dojo.disconnect(page.view.measurementObj);
				
				if($(page.view.measurementBox).hasClass('ui-dialog-content')) 
					$(page.view.measurementBox).dialog("destroy");
			}
			
			if (type != 'measurement' && type != 'fullExtent' && type != 'move') {
				if (page.view.map.graphics.graphics.length != 0) {
					page.view.map.graphics.clear();
				}
			}
		};
		
		pub.writeLayerLegend = function (url) {
			$.ajax({
				url: url + "/legend?f=pjson" ,
				dataType: 'text',
				success: function(data) {
					data = JSON.parse(data);
//					ARC_SERVER_URL/1/images/104f45cc8fd8beba7fadc0fd8d151741
					
					var html = '<ul>';
					html += '<li class="tit">수질측정지점</li>';
											
					for ( var i = 0; i < data.layers.length; i++) 
					{
						var l = data.layers[i];
						
						html += 	'<li>'+
										'<label><input type="checkbox" class="list_item" id="'+l.layerId+'" onclick="$arcGIS.model.updateLayerVisibility();"/><img src="'+url+l.layerId+'/images/'+l.legend[0].url+'" alt=""/> '+l.layerName+'</label>'+
									'</li>';
						if(l.layerId == '7')
						{
							html += '</ul>';
							html += '<ul><li class="tit">수질자동측정지점</li>';
						}
						else if(l.layerId == '11')
						{
							html += '</ul>';
							html += '<ul><li class="tit">퇴적물조사지점</li>';
						}
						else if(l.layerId == '22')
						{
							html += '</ul>';
							html += '<ul><li class="tit">환경기초시설</li>';
						}
						else if(l.layerId == '31')
						{
							html += '</ul>';
							html += '<ul><li class="tit">시설물</li>';
						}
						else if(l.layerId == '39')
						{
							html += '</ul>';
							html += '<ul><li class="tit">하천</li>';
						}
						else if(l.layerId == '42')
						{
							html += '</ul>';
							html += '<ul><li class="tit">수질영향권역</li>';
						}
						else if(l.layerId == '46')
						{
							html += '</ul>';
							html += '<ul><li class="tit">행정구역</li>';
						}
					}		
					
					html += '</ul>';
					
					$('#chkInfoBx').html(html);
					
					setTimeout(function(){
						$('#9').attr('checked', true);
					}, 500);
					
				}
			});	
		};
		pub.drawOverview = function() {
	    	try {
	    		console.log('[OVERVIEW MAP]' , page.view.overviewDiv);
	    		
	    		// overview
	    		$("div[id*='esri_dijit_OverviewMap']").remove();
				
	    		var overview =  {
					id: "overview",
					attachTo: "bottom-right",
					width: 200,
					height: 200,
					baseLayer: 0,
					visible: true,
					expandFactor: 1,
					color: "#666666"
				};
	    		
				page.view.overviewDiv = new esri.dijit.OverviewMap({
					map: page.view.map,
					attachTo: overview.attachTo,
					width: overview.width,
					height: overview.height,
					visible: overview.visible,
					expandFactor: overview.expandFactor,
					color: overview.color
				});
				
				console.log('[OVERVIEW MAP]' , page.view.overviewDiv);
				
				page.view.overviewDiv.startup();
				
				// slide button
				var html = "<div id='overviewSlideBtn' alt='open'></div>";

	    		$("div[id='overviewSlideBtn']").remove();
				$(html).appendTo(".esriOverviewMap.ovwBR");
	    		
				$("#overviewSlideBtn").bind("click", function() {
					var attr = $(this).attr("alt");
									
					// open -> close
					if(attr == 'open') {
		    			$('.esriOverviewMap.ovwBR').animate({
		    				width: $(this).width(),
		    				height: $(this).height()
		    			}, 400, function() {});
		    			
						$(this).attr("alt", "close");
						$(this).css("background-image", "url(/ce/resourceses/images/lib/overview_up.png)");
					} 
					
					// close -> open
					else if(attr == 'close'){
						$(this).attr("alt", "open");
						$(this).css("background-image", "url(/ce/resources/images/lib/overview_down.png)");
						
		    			$('.esriOverviewMap.ovwBR').animate({
		    				width: overview.width,
		    				height: overview.height
		    			}, 400, function() {});
					}
				});
	    	} catch(e) {
	    	}
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
        		
        	this.queryTask 	= new esri.tasks.QueryTask($define.ARC_SERVER_URL+"/rest/services/WPCS/MapServer/9");
        	
        	this.queryTask.execute(q, function(result){
        		console.log('[RESULT]', result);
        		
        		$arcGIS.model.features = result.features;
        		
        		if(result.features == undefined || result.features.length == 0 )
	        		return;
	        	
	        	var infoTemplate = new esri.InfoTemplate(TEMPLATJSON);

//	        	var symbol = new esri.symbol.SimpleMarkerSymbol();
//	        	symbol.style = esri.symbol.SimpleMarkerSymbol.STYLE_X;
//	        	symbol.setSize(10);
//	        	symbol.setColor(new dojo.Color([255,255,0,0.5]));
		          
	        	var symbol = new esri.symbol.PictureMarkerSymbol('/gis/images/al.png', 15, 15);
//	        	symbol.setOffset(5,5);
      			
      			
	        	$arcGIS.view.map.graphics.clear();
//	        	var highlightSymbol = new esri.symbol.SimpleFillSymbol(esri.symbol.SimpleFillSymbol.STYLE_SOLID, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([255,0,0]), 3), new dojo.Color([125,125,125,0.35]));

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
	            	
//	            	var highlightGraphic = new esri.Graphic(evt.graphic.geometry,highlightSymbol);
//	            	
//	            	$arcGIS.view.map.graphics.add(highlightGraphic);
	            	$arcGIS.view.map.infoWindow.show(evt.screenPoint,page.view.map.getInfoWindowAnchor(evt.screenPoint));
	            });

	            //listen for when map.graphics onMouseOut event is fired and then clear the highlight graphic
	            //and hide the info window
	            dojo.connect(page.view.map.graphics, "onMouseOut", function(evt) {
//	            	$arcGIS.view.map.infoWindow.hide();
	            });
        	});
        	
//        	this.play();
        	
		};
		
		pub.timer =  null;
		
		pub.roopType = 5; // 1, 2, 3 = 평시, 4 = 이상, 5 = 사고발생
		
		pub.cuIndex = -1;
		
		pub.cuidxArr = [];
		
		pub.play = function()
		{
			console.log('[play]');
			timer = setInterval(this.roopMonitor, 5000);
		};
		pub.stop = function()
		{
			clearInterval(timer);
		};
		pub.next = function()
		{
			this.stop();
			this.roopMonitor();
		};
		pub.prevCnt = 2;
		
		pub.prev = function()
		{
			this.cuIndex = this.cuidxArr[this.cuidxArr.length-this.prevCnt]-1;
			this.prevCnt++;
			console.log(this.prevCnt);
			
			this.stop();
			this.roopMonitor(true);
		};
		pub.refresh = function()
		{
			this.stop();
			
			this.getMeasureQueryData();
		};
		pub.roopMonitor = function(prevFlag)
		{
			console.log('[roopMoniter]');
			
			if($arcGIS.model.roopType == 5)
			{
				for ( var i = $arcGIS.model.cuIndex+1; i < $arcGIS.model.accidentData.length; i++) 
				{
					var wm = esri.geometry.geographicToWebMercator(new esri.geometry.Point($arcGIS.model.accidentData[i].x , $arcGIS.model.accidentData[i].y));
					
					$arcGIS.view.map.centerAt(wm);
					
					$arcGIS.model.cuIndex = i;
					
					setTimeout(function(){
						var point = new esri.geometry.ScreenPoint($arcGIS.view.map.width/2, $arcGIS.view.map.height/2);
						var pictureMarkerSymbol = new esri.symbol.PictureMarkerSymbol('/gis/images/event.gif', 50, 50);
			  			pictureMarkerSymbol.setOffset(10,10);
			  			
			  			var graphic = new esri.Graphic(wm, pictureMarkerSymbol);
			  			graphic.setAttributes($arcGIS.model.accidentData[i]);
			  			graphic.setInfoTemplate(new esri.InfoTemplate(EVENT_TEMPLATJSON));
			  			
						$arcGIS.view.map.infoWindow.setContent(graphic.getContent());
		            	$arcGIS.view.map.infoWindow.setTitle($arcGIS.model.accidentData[i].acct_act_content);
						$arcGIS.view.map.infoWindow.show(point,$arcGIS.view.map.getInfoWindowAnchor(point));
						
					}, 1000);
					
					if(!prevFlag)
					{
						if($arcGIS.model.cuidxArr[$arcGIS.model.cuidxArr.length-1] != $arcGIS.model.cuIndex)
							$arcGIS.model.cuidxArr.push(i);
					}
			    	return;
				}
			}
			
//			$arcGIS.model.eventTest();
			
			/*
			if($arcGIS.model.features == null)
				return;
			
			var infoTemplate = new esri.InfoTemplate(TEMPLATJSON);

			$arcGIS.view.map.infoWindow.hide();
			
			for ( var i = $arcGIS.model.cuIndex+1; i < $arcGIS.model.features.length; i++) 
			{
				$arcGIS.model.features[i].setInfoTemplate(infoTemplate);
				
				if($arcGIS.model.roopType > 3)
				{
					if($arcGIS.model.roopType == $arcGIS.model.features[i].attributes.value)
					{
						var wm = esri.geometry.geographicToWebMercator($arcGIS.model.features[i].geometry);
						$arcGIS.view.map.centerAt(wm);
						
						$arcGIS.model.cuIndex = i;
						
						setTimeout(function(){
							var point = new esri.geometry.ScreenPoint($arcGIS.view.map.width/2, $arcGIS.view.map.height/2);
							$arcGIS.view.map.infoWindow.setContent($arcGIS.model.features[i].getContent());
			            	var title = $arcGIS.model.features[i].getTitle();
			            	$arcGIS.view.map.infoWindow.setTitle(title);
							$arcGIS.view.map.infoWindow.show(point,$arcGIS.view.map.getInfoWindowAnchor(point));
							
						}, 1000);
						
						if(!prevFlag)
						{
							if($arcGIS.model.cuidxArr[$arcGIS.model.cuidxArr.length-1] != $arcGIS.model.cuIndex)
								$arcGIS.model.cuidxArr.push(i);
						}
				    	return;
					}
					continue;
				}
				else
				{
					var wm = esri.geometry.geographicToWebMercator($arcGIS.model.features[i].geometry);
					$arcGIS.view.map.centerAt(wm);
					
					$arcGIS.model.cuIndex = i;
					
					setTimeout(function(){
						var point = new esri.geometry.ScreenPoint($arcGIS.view.map.width/2, $arcGIS.view.map.height/2);
						$arcGIS.view.map.infoWindow.setContent($arcGIS.model.features[i].getContent());
		            	var title = $arcGIS.model.features[i].getTitle();
		            	$arcGIS.view.map.infoWindow.setTitle(title);
						$arcGIS.view.map.infoWindow.show(point,$arcGIS.view.map.getInfoWindowAnchor(point));
						
					}, 1000);
					
					if(!prevFlag)
					{
						if($arcGIS.model.cuidxArr[$arcGIS.model.cuidxArr.length-1] != $arcGIS.model.cuIndex)
							$arcGIS.model.cuidxArr.push(i);
					}
			    	return;
				}
			}
			*/
			$arcGIS.model.cuIndex = -1;
			$arcGIS.model.cuidxArr = [];
			$arcGIS.model.prevCnt = 2;
		}
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
            page.view.map = new esri.Map("map", {sliderPosition:'top-right', slider: true, logo: false, sliderStyle: "large", Extent:initialExtent });
            
            dojo.connect(page.view.map, "onLoad" , $arcGIS.controller.initDraw);
            dojo.connect(page.view.map, "onClick" , $arcGIS.model.drawSymbol);
    		
     		page.view.vworldLayer = new VworldTiledMapServiceLayer();
     		page.view.map.addLayer(page.view.vworldLayer);
     		console.log('[addvworld]');
     		page.view.vworldSatelliteLayer = new VworldTiledSatelliteMapServiceLayer();
     		page.view.map.addLayer(page.view.vworldSatelliteLayer);
     		console.log('[addvworld2]');
     		page.view.vworldSatelliteLayer.hide();
     		
     		page.view.vworldHybridLayer = new VworldTiledHybridMapServiceLayer();
     		page.view.map.addLayer(page.view.vworldHybridLayer);
     		console.log('[addvworld3]');
     		page.view.vworldHybridLayer.hide();
     		

    		var imageParametersndk1 = new esri.layers.ImageParameters();
//    		imageParametersndk1.layerIds = [0,8,12,14,23,32,40,43,47];
    		imageParametersndk1.layerIds = [9];
            imageParametersndk1.layerOption = esri.layers.ImageParameters.LAYER_OPTION_SHOW;
//            http://118.37.180.151:5006/rest/services/map_weis_new_ver1_1/MapServer
    		page.view.ndk1 = new esri.layers.ArcGISDynamicMapServiceLayer($define.ARC_SERVER_URL+'/rest/services/WPCS/MapServer/', {
              "imageParameters":imageParametersndk1
            });
        		
//    		page.view.map.addLayer(page.view.mainLayer);
    		page.view.map.addLayer(page.view.ndk1);
    		console.log('[addvworld4]');
//    		page.view.map.addLayer(page.view.featureLayer);

    		MAP_SPATIALREFERENCE = page.view.ndk1.spatialReference;
    		$arcGIS.controller.initSymbol();
    		
//    		dojo.connect(page.view.mainLayer, "onLoad" , $arcGIS.controller.loaded);
//    		dojo.connect(page.view.ndk1, "onLoad" , $arcGIS.controller.loaded);
    		
//    		dojo.connect(page.view.featureLayer, "onLoad" , $arcGIS.controller.initSymbol);
    		
//    		var scalebar = new esri.dijit.Scalebar({
//    			map: page.view.map,
//        		attachTo: "bottom-left",
//        		scalebarUnit:"metric"
//        	});
        		
//    		page.view.queryTask = new esri.tasks.QueryTask("http://118.37.180.151:5006/rest/services/map_weis_new_ver1_1/MapServer/4");
        	
            esriConfig.defaults.io.proxyUrl = "/proxy.jsp";
            esriConfig.defaults.io.alwaysUseProxy = false;

            page.view.gsvc = new esri.tasks.GeometryService($define.ARC_SERVER_URL+"/rest/services/Utilities/Geometry/GeometryServer");

    		this.topSliderInit();
    		var measurement =  {
    			divID: 'mapControl9',
    			boxID: 'measurementDiv'
    		};
//    		this.setMeasurement(measurement);
    		
    		this.setPrint();
        	this.setSave();
        	
        	this.drawOverview();
        	page.controller.setEvent();
        	
//        	this.getMeasureQueryData();
        	this.writeLayerLegend($define.ARC_SERVER_URL+'/rest/services/WPCS/MapServer/');//1/images/104f45cc8fd8beba7fadc0fd8d151741
        	
        	this.intervalEvent();
        	setInterval(this.intervalEvent, 600000);
        	
//        	page.controller.initEdit();
        	
//        	grid = new dgrid.OnDemandGrid({
//                store: dojo.store.Memory({
//                  idProperty: "id"
//                }),
//                columns:{
//                		title: "title",
//                		cont: "cont",
//                		x: "x",
//                		y: "y",
//                		id: "id"
//                },
//              }, "result");
//        	
//        	var data = [];
        	
//          grid.store.setData(data);
//          grid.refresh();
              
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
        
        pub.featureLayer = null;
        
        pub.map_weis_new_ver1_1 = null;
        pub.map_weis_new_ver1_0 = null;
        
        pub.measurementObj = null;
        pub.measurementBox = null;
        pub.dtype = 0;
        pub.overviewDiv = null;
        
        pub.radiobutton1 = $("#radiobutton1", page.dom);
        pub.radiobutton2 = $("#radiobutton2", page.dom);
        pub.radiobutton3 = $("#radiobutton3", page.dom);
        
        pub.radiobutton4 = $("#radiobutton4", page.dom);
        pub.radiobutton5 = $("#radiobutton5", page.dom);
        pub.radiobutton6 = $("#radiobutton6", page.dom);
        
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
    		
            $("#btnExport").on('click', function(e) {
			    window.open('data:application/vnd.ms-excel,' + $('#result').html());
			    e.preventDefault();
			});
            
    		pub.initDraw = function(){
	        	console.log('[INIT TOOLBAR]');
	        	page.view.tb = new esri.toolbars.Draw(page.view.map);
	        	dojo.connect(page.view.tb, "onDrawEnd", page.model.addGraphic);
//	        	dojo.connect(page.view.tb, "onDrawComplete", page.model.drawSymbol);
	        };
    		
    		pub.loaded = function(layer)
    		{
    			console.log('[loaded ] = ', layer);
    		};
    		
    		pub.initEdit = function()
    		{
    			console.log('[initEdit]');
//    			var imageParametersndk1 = new esri.layers.ImageParameters();
//        		imageParametersndk1.layerIds = [1,2,3,4];
//                imageParametersndk1.layerOption = esri.layers.ImageParameters.LAYER_OPTION_SHOW;
//                
//    			$arcGIS.view.editFeatureLayer = new esri.layers.FeatureLayer($define.ARC_SERVER_URL+"/rest/services/WPCS_EDIT/FeatureServer",{
//         			mode: esri.layers.FeatureLayer.MODE_ONDEMAND,
//         			infoTemplate: new esri.InfoTemplate(TEMPLATJSON),
//         			outFields: ["*"],
//         			id: "editFeatureLayer",
//         			"imageParameters":imageParametersndk1
//         		  });
//    			$arcGIS.view.map.addLayers($arcGIS.view.editFeatureLayer);
//    			$arcGIS.view.editFeatureLayer.show();
    			
    			var editToolbar = new esri.toolbars.Edit(page.view.map);
    			
    			dojo.connect(editToolbar, "onDeactivate", function(tool,graphic) {
    				console.log('[onDeactivate-tool]',tool);
    				console.log('[onDeactivate-graphic]',graphic);
    				
    				var params = new esri.tasks.ProjectParameters();
    				params.geometries = [graphic.geometry];
    				params.outSR = MAP_SPATIALREFERENCE;
			          
    				 $arcGIS.view.gsvc.project(params, function(projectedPoints) {
 			            var pt = projectedPoints[0];
 			            console.log(projectedPoints);
 			            $arcGIS.view.featureLayer.attr('x',graphic.geometry.x);
     					$arcGIS.view.featureLayer.attr('y',graphic.geometry.y);
 			          });
    				console.log('[applyEdits]', graphic);
    				
    				$arcGIS.view.featureLayer.applyEdits(null, [graphic], null, function(result){
    			          
    			         $arcGIS.view.gsvc.project(params, function(projectedPoints) {
    			            var pt = projectedPoints[0];
    			            console.log(projectedPoints);
    			            $arcGIS.view.featureLayer.attr('x',graphic.geometry.x);
        					$arcGIS.view.featureLayer.attr('y',graphic.geometry.y);
    			          });
    					
    				});
    				
    				
				});
    		
    			dojo.connect($arcGIS.view.featureLayer, "onMouseUp", function(evt) {
    				console.log('[onMouseUp]');
    				if (editingEnabled) {
    					console.log('[deactivate]');
    	        		editToolbar.deactivate();
    	        		editingEnabled = false;
   	        	   } 
				});
    			
 	            var editingEnabled = false;
 	            
 	           dojo.connect($arcGIS.view.featureLayer, "onClick", function(evt) {
 	        	   console.log('[onDblClick]');
 	        	  
 	        	   dojo.stopEvent(evt);
 	        	   
 	        	   if (editingEnabled === false) {
 	        		  console.log('[activate]');
 	        		   editingEnabled = true;
 	        		   editToolbar.activate(esri.toolbars.Edit.MOVE , evt.graphic);
 	        	   } else {
 	        		  console.log('[deactivate]');
 	        		   editToolbar.deactivate();
 	        		   editingEnabled = false;
 	        	   }
 	        	});
    		};
    		pub.initSymbol = function()
    		{
    			console.log('[initSymbol]');
//    			http://10.101.214.91:6080/rest/services/WPCS_EDIT/FeatureServer/1
    			
    			$arcGIS.view.featureLayer = new esri.layers.FeatureLayer($define.ARC_SERVER_URL+"/rest/services/WPCS_EDIT/FeatureServer/1",{
         			mode: esri.layers.FeatureLayer.MODE_ONDEMAND,
         			infoTemplate: new esri.InfoTemplate(TEMPLATJSON),
         			outFields: ["*"],
         			id: "featureLayer"
         		  });
    			
    			 // selection symbol used to draw the selected census block points within the buffer polygon
         		var symbol = new esri.symbol.SimpleMarkerSymbol(
         				esri.symbol.SimpleMarkerSymbol.STYLE_CIRCLE, 
         				12, new esri.symbol.SimpleLineSymbol(
         						esri.symbol.SimpleLineSymbol.STYLE_NULL, 
         						new dojo.Color([247, 34, 101, 0.9]), 
         				1
         				),
         				new dojo.Color([207, 34, 171, 0.5]));
         		
         		var defaultSymbol = new esri.symbol.SimpleFillSymbol().setStyle(esri.symbol.SimpleFillSymbol.STYLE_NULL);
                defaultSymbol.outline.setStyle(esri.symbol.SimpleLineSymbol.STYLE_NULL);
                
         		var renderer = new esri.renderer.UniqueValueRenderer(defaultSymbol, "value");
                //add symbol for each possible value
         			
     			var symbol1 = 	new esri.symbol.SimpleMarkerSymbol(esri.symbol.SimpleMarkerSymbol.STYLE_CIRCLE, 12,
     				    new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID,
     				    new dojo.Color([225, 225, 225, 255]), 2),
     				    new dojo.Color([0, 169, 230, 255]));
     			var symbol2 = 	new esri.symbol.SimpleMarkerSymbol(esri.symbol.SimpleMarkerSymbol.STYLE_CIRCLE, 12,
     				    new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID,
     				    new dojo.Color([225, 225, 225, 255]), 2),
     				    new dojo.Color([76, 230, 0, 255]));
     			var symbol3 = 	new esri.symbol.SimpleMarkerSymbol(esri.symbol.SimpleMarkerSymbol.STYLE_CIRCLE, 12,
     				    new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID,
     				    new dojo.Color([225, 225, 225, 255]), 2),
     				    new dojo.Color([255, 255, 0, 255]));
     			var symbol4 = 	new esri.symbol.SimpleMarkerSymbol(esri.symbol.SimpleMarkerSymbol.STYLE_CIRCLE, 12,
     				    new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID,
     				    new dojo.Color([225, 225, 225, 255]), 2),
     				    new dojo.Color([255, 170, 0, 255]));
     			var symbol5 = 	new esri.symbol.SimpleMarkerSymbol(esri.symbol.SimpleMarkerSymbol.STYLE_CIRCLE, 12,
     				    new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID,
     				    new dojo.Color([225, 225, 225, 255]), 2),
     				    new dojo.Color([255, 0, 0, 255]));
     		
     			renderer.addValue("1", symbol1);
     			renderer.addValue("2", symbol2);
     			renderer.addValue("3", symbol3);
     			renderer.addValue("4", symbol4);
     			renderer.addValue("5", symbol5);
                
         		$arcGIS.view.featureLayer.setSelectionSymbol(symbol); 
         		$arcGIS.view.featureLayer.setRenderer(renderer);
         		console.log('[addFeature]');
         		
         		$arcGIS.view.map.addLayer($arcGIS.view.featureLayer);
         		dojo.connect($arcGIS.view.featureLayer, "onLoad" , $arcGIS.controller.initEdit);
         		
         		$arcGIS.view.featureLayer.show();
         		
         		dojo.connect($arcGIS.view.featureLayer, "onClick", function(evt) {
//	            	page.view.map.graphics.clear();  //use the maps graphics layer as the highlight layer
	            	var content = evt.graphic.getContent();
	            	page.view.map.infoWindow.setContent(content);
	            	var title = evt.graphic.getTitle();
	            	page.view.map.infoWindow.setTitle(title);
	            	
	            	var highlightSymbol = new esri.symbol.SimpleFillSymbol(esri.symbol.SimpleFillSymbol.STYLE_SOLID, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([255,0,0]), 3), new dojo.Color([125,125,125,0.35]));

	            	
	            	var highlightGraphic = new esri.Graphic(evt.graphic.geometry,highlightSymbol);
	            	page.view.map.graphics.add(highlightGraphic);
	            	page.view.map.infoWindow.show(evt.screenPoint,page.view.map.getInfoWindowAnchor(evt.screenPoint));
	            });

	            //listen for when map.graphics onMouseOut event is fired and then clear the highlight graphic
	            //and hide the info window
	            dojo.connect($arcGIS.view.featureLayer, "onMouseOut", function(evt) {
//	            	page.view.map.graphics.clear();
	            	page.view.map.infoWindow.hide();
	            });
	            
         		
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
//	        	dojo.connect(page.view.gsvc, "onLengthsComplete", function (result) {
//                	
//                		
//                });
//                dojo.connect(page.view.gsvc, "onProjectComplete", function(graphics) {
//                  //call GeometryService.lengths() with projected geometry
//                	
//                });
                
	        };
	        page.view.radiobutton1.on('click', function(evt){
	        	page.model.roopType = 1; // 1, 2, 3 = 평시, 4 = 이상, 5 = 사고발생
	    		page.model.cuIndex = -1;
	        });
	        page.view.radiobutton2.on('click', function(evt){
	        	page.model.roopType = 4; // 1, 2, 3 = 평시, 4 = 이상, 5 = 사고발생
	    		page.model.cuIndex = -1;
	        });
	        page.view.radiobutton3.on('click', function(evt){
	        	page.model.roopType = 5; // 1, 2, 3 = 평시, 4 = 이상, 5 = 사고발생
	    		page.model.cuIndex = -1;
			});
	        
	        page.view.radiobutton4.on('click', function(evt){
	        	page.model.roopType = 1; // 1, 2, 3 = 평시, 4 = 이상, 5 = 사고발생
	    		page.model.cuIndex = -1;
	        });
	        page.view.radiobutton5.on('click', function(evt){
	        	page.model.roopType = 4; // 1, 2, 3 = 평시, 4 = 이상, 5 = 사고발생
	    		page.model.cuIndex = -1;
	        });
	        page.view.radiobutton6.on('click', function(evt){
	        	page.model.roopType = 5; // 1, 2, 3 = 평시, 4 = 이상, 5 = 사고발생
	    		page.model.cuIndex = -1;
			});
	        
	        page.model.init();
	        
		};
		return pub;
    }());

    dojo.ready(page.controller.init);
    
    $arcGIS = page;
    
    $( "#slider" ).slider({
        range: "min",
        value: 5,
        min: 5,
        max: 50,
        step:5
      });
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
function MM_swapImage(img, src) { //v3.0
	$('#'+img).attr('src', src);
}
  
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
}

function closeLoading()
{
	$("#loadingDiv").dialog("close");
}

