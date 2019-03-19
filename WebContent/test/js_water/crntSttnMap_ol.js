var _CrntSttnMap_ol = function () {
	var preZoomLevel = 0;
	
	var lyr;
	
	var cityFeature;
	var cityDstrcFeature;
	
	var itemValue = 'PHY';
	
	//NORMAL, A1, A2, A3, A4, M, PHY, V2, V3, V4, V5, V6
	var init = function(){
		setEvent();

		$.when(_MapService.getWfs(':CITY_POINT','*'),
				_MapService.getWfs(':CITY_DSTRC_POINT','*'),
				getData('/psupport/jsps/getCityData.jsp'),
				getData('/psupport/jsps/getCityDstrcData.jsp')).then(function(feature1, feature2, data1, data2) {
					cityFeature = setFeatures(feature1[0].features, JSON.parse(data1[0]));
					cityDstrcFeature = setFeatures(feature2[0].features, JSON.parse(data2[0]));
					writeLayer();
				});
	};
	
	var setFeatures = function(f, d){
		var fArr = [];
		
		for(var i = 0; i < f.length; i++){
			var feature = new ol.Feature();
			for(var j = 0; j < d.length; j++){
				if(f[i].properties.ADM_CD == d[j].CODE){
					feature.setGeometry(new ol.geom.Point(f[i].geometry.coordinates));
					feature.setProperties(d[j]);
				}
			}
			fArr.push(feature);
		}
		
		return fArr;
	};
	
	var setEvent = function(){
		_MapEventBus.on(_MapEvents.map_moveend, function(){
			var getZoom = _CoreMap.getMap().getView().getZoom();
			if(preZoomLevel != getZoom){
				preZoomLevel = getZoom;
				
				writeLayer();
			}
		});
	};
	
	var writeLayer = function(){
		
		if(lyr){
			_MapEventBus.trigger(_MapEvents.map_removeLayer, lyr);
			lyr = null;
		}
		
		lyr = new ol.layer.Vector({
	        source: new ol.source.Vector({
				features: _CoreMap.getMap().getView().getZoom() > 9 ? cityDstrcFeature : cityFeature
			}),
			style:styleFunction,
			opacity: 0.9
		});
		
		_MapEventBus.trigger(_MapEvents.map_addLayer,lyr);
	};
	
	var styleFunction = function(f, r){
		var p = f.getProperties();
		
		return [new ol.style.Style({
			image : new ol.style.Circle({
				radius : 37.5,
				fill : new ol.style.Fill({
					//color : '#ED5610', // red
					color : '#42B9F4' // blue
				}),
				stroke : new ol.style.Stroke({
					color : '#ACADA8',
					width : 3
				})
			}),
			text:new ol.style.Text({
						textAlign : 'center',
						textBaseline : 'top',
						font : 'bold 13.3333px Arial',
						text : p.CTY_NM ? p.CTY_NM : p.DO_NM,
						fill : new ol.style.Fill({
							color : '#000000'
						}),
						offsetX : 0,
						offsetY : -16,
						placement : 'point',
						maxAngle : undefined,
						exceedLength : undefined,
						rotation : 0.0
			})
		}),new ol.style.Style({
			text: new ol.style.Text({
				text: p[itemValue] ? p[itemValue] : ' ',
				textAlign : 'center',
				textBaseline : 'top',
				font : 'bold 13.3333px Arial',
				fill : new ol.style.Fill({
					color : '#000000'
				}),
				offsetX : 0,
				offsetY : 3,
				placement : 'point',
				maxAngle : undefined,
				exceedLength : undefined,
				rotation : 0.0
			})
		})];
	};
	
	var getData = function(url){
		return $.ajax({
			url:url,
            type: 'GET',
            contentType: 'application/json'
		});
	};
	
	return {
		init: function () {
			init();
		},
		selectButton:function(val){
			itemValue = val;
			writeLayer();
		}
	};
}();
