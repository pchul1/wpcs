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
	
	var setSymbolColor = function(f, r){
		var circle;
		var symbolLegendObj = {
				'NORMAL':{color:'#0FED64',flag:'basic'},
				'A1':{color:'#7CAAF4',flag:'basic'},
				'A2':{color:'#EDE91C',flag:'basic'},
				'A3':{color:'#ED5610',flag:'basic'},
				'A4':{color:'#ED2009',flag:'basic'},
				'M':{color:'#6B6362',flag:'basic'},
				'PHY':{flag:'item',standValue:0.0,color:function(v){
					var color = '#7B7B7B';
					var val = parseFloat(v);
					if(0 <= val && val <= 5.9){
						color = '#ED5610';
					}else if(6 <= val && val <= 9.5){
						color = '#42B9F4';
					}else if(9.6 <= val && val <= 9999.0){
						color = '#ED5610';
					}
					return color;
				}},
				'V2':{flag:'item',standValue:10.0,color:setLegendColor},
				'V3':{flag:'item',standValue:50.0,color:setLegendColor},
				'V4':{flag:'item',standValue:40.0,color:setLegendColor},
				'V5':{flag:'item',standValue:30.0,color:setLegendColor},
				'V6':{flag:'item',standValue:4.0,color:setLegendColor},
		};
		
		if(symbolLegendObj[itemValue].flag == 'item'){
			circle = new ol.style.Circle({
				radius : 37.5,
				fill : new ol.style.Fill({
					color : symbolLegendObj[itemValue].color(f.getProperties()[itemValue],symbolLegendObj[itemValue].standValue)
				}),
				stroke : new ol.style.Stroke({
					color : '#ACADA8',
					width : 3
				})
			});
		}else{
			circle = new ol.style.Circle({
				radius : 37.5,
				fill : new ol.style.Fill({
					color : symbolLegendObj[itemValue].color
				})
			});
		}
		
		return circle;
	};
	
	var setLegendColor = function(v, standValue){
		var value = parseFloat(v);
		var color = '#7B7B7B';
		if(0 <= value && value <= standValue){
			color = '#42B9F4';
		}else if((standValue+0.1) <= value && value <= 9999.0){
			color = '#ED5610';
		}
		return color;
	};
	
	var styleFunction = function(f, r){
		var p = f.getProperties();
		
		var image = setSymbolColor(f, r);
		
		return [new ol.style.Style({
			image : image,
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
