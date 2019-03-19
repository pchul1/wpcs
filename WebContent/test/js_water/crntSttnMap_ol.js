var _CrntSttnMap_ol = function () {
	var preZoomLevel = 0;
	
	var lyr;
	
	var cityFeature;
	var cityDstrcFeature;
	
	//V_FACT_LOC_INFO_2D
	var init = function(){
		setEvent();

		$.when(_MapService.getWfs(':CITY_POINT','*'),
				_MapService.getWfs(':CITY_DSTRC_POINT','*')).then(function(feature1, feature2) {
					cityFeature = setFeatures(feature1[0].features);
					cityDstrcFeature = setFeatures(feature2[0].features);
					writeLayer('TEST_ITEM');
				});
	};
	
	var setFeatures = function(f){
		var fArr = [];
		for(var i = 0; i < f.length; i++){
			var feature = new ol.Feature();
			feature.setGeometry(new ol.geom.Point(f[i].geometry.coordinates));
			feature.setProperties(f[i].properties);
			fArr.push(feature);
		}
		return fArr;
	};
	
	var setEvent = function(){
		_MapEventBus.on(_MapEvents.map_moveend, function(){
			var getZoom = _CoreMap.getMap().getView().getZoom();
			if(preZoomLevel != getZoom){
				preZoomLevel = getZoom;
				
				writeLayer('TEST_ITEM');
			}
		});
	};
	
	var writeLayer = function(item){
		
		if(lyr){
			_MapEventBus.trigger(_MapEvents.map_removeLayer, lyr);
		}
		
		lyr = new ol.layer.Vector({
	        source: new ol.source.Vector({
				features: _CoreMap.getMap().getView().getZoom() > 9 ? cityDstrcFeature : cityFeature
			}),
			style:circleStyleFunction,
			opacity: 0.9
		});
		
		_MapEventBus.trigger(_MapEvents.map_addLayer,lyr);
	};
	
	var circleStyleFunction = function(feature, resolution){
		var style = new ol.style.Style({
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
						font : 'bold 13px Arial',
						text : '서울',
						fill : new ol.style.Fill({
							color : '#ffffff'
						}),
						offsetX : 0,
						offsetY : -5,
						placement : 'point',
						maxAngle : undefined,
						exceedLength : undefined,
						rotation : 0.0
			})
		})
		feature.setStyle(style);
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
		selectButton:function(flag){
			writeLayer(flag);
		}
	};
}();
