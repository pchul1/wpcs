var _CrntSttnMap_ol = function () {
	var preZoomLevel = 0;
	
	var lyr;
	
	var cityFeature;
	var cityDstrcFeature;
	var factValueFeature;
	
	var itemValue = 'PHY';
	
	var tempBranchToolTip;
	var tempBranchTooltipElement;
	
	//NORMAL, A1, A2, A3, A4, M, PHY, V2, V3, V4, V5, V6
	var init = function(){
		setEvent();
		createTempBranchTooltip();
		
		$.when(_MapService.getWfs(':CITY_POINT','*'),
				_MapService.getWfs(':CITY_DSTRC_POINT','*'),
				getData('/psupport/jsps/getCityData.jsp'),
				getData('/psupport/jsps/getCityDstrcData.jsp'),
				getData('/psupport/jsps/getFactValueForItem.jsp')).then(function(feature1, feature2, data1, data2, factValue) {
					cityFeature = setFeatures(feature1[0].features, JSON.parse(data1[0]));
					cityDstrcFeature = setFeatures(feature2[0].features, JSON.parse(data2[0]));
					
					var fArr = [];
					var factValueResult = JSON.parse(factValue[0]);
					
					for(var i = 0; i < factValueResult.length; i++){
						var feature = new ol.Feature();
						var tempCoord = ol.proj.transform([parseFloat(factValueResult[i].X), parseFloat(factValueResult[i].Y)], 'EPSG:4326', 'EPSG:3857');
						feature.setGeometry(new ol.geom.Point(tempCoord));
						feature.setProperties(factValueResult[i]);
						fArr.push(feature);
					}
					
					factValueFeature = fArr;
					
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
				
				if(tempBranchTooltipElement.className.indexOf('hidden') == -1){
					tempBranchTooltipElement.className = 'tooltip hidden';
				}
			}
		});
		
		_MapEventBus.on(_MapEvents.map_mousemove, function(event, data){
			 var pixel = _CoreMap.getMap().getEventPixel(data.result.originalEvent);
			 
			 var feature = _CoreMap.getMap().forEachFeatureAtPixel(pixel, function(feature, layer) {
				 var p = feature.getProperties();
				 if(p.BRANCH_NO){
					 
					 var html = '';
					 html += '<div style="background: black; color: white; padding: 5px 5px; border-top-left-radius: 5px; border-top-right-radius: 5px;">' + p.FACT_CODE + '</div>';
					 html += '<div style="background: white; padding: 5px 5px; letter-spacing: -1px; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px">' + p.FACT_NAME + '</div>';
					 
					 $('.tooltip').html(html);
					 tempBranchToolTip.setPosition( feature.getGeometry().getCoordinates() );
					 tempBranchTooltipElement.classList.remove('hidden');
				 }
			 });
		}); 
	};
	
	var getRenderer = function (f, r) {
		var p = f.getProperties();
		
		var symbols = {};			
		
		symbols['W0'] = '/gis/new_images/regular/tms_1.png';
		symbols['W1'] = '/gis/new_images/regular/tms_3.png';
		symbols['W2'] = '/gis/new_images/regular/tms_4.png';
		symbols['W3'] = '/gis/new_images/regular/tms_5.png';
		symbols['W9'] = '/gis/new_images/regular/tms_6.png';
		
		symbols['A0'] = '/gis/new_images/regular/auto_1.png';
		symbols['A1'] = '/gis/new_images/regular/auto_2.png';
		symbols['A2'] = '/gis/new_images/regular/auto_3.png';
		symbols['A3'] = '/gis/new_images/regular/auto_4.png';
		symbols['A4'] = '/gis/new_images/regular/auto_5.png';
		symbols['A9'] = '/gis/new_images/regular/auto_6.png';
		
		symbols['U0'] = '/gis/new_images/regular/usn_1.png';
		symbols['U1'] = '/gis/new_images/regular/usn_2.png';
		symbols['U2'] = '/gis/new_images/regular/usn_3.png';
		symbols['U3'] = '/gis/new_images/regular/usn_4.png';
		symbols['U4'] = '/gis/new_images/regular/usn_5.png';
		symbols['U9'] = '/gis/new_images/regular/usn_6.png';
		
		return new ol.style.Icon({
			opacity: 1,
			src: symbols[p.SYS_KIND+p.MIN_OR],
			anchor: [0.5, 1.0],
		}); 
	};
	
	var writeLayer = function(){
		
		if(lyr){
			_MapEventBus.trigger(_MapEvents.map_removeLayer, lyr);
			lyr = null;
		}
		
		var isFactValue = _CoreMap.getMap().getView().getZoom() > 11 ? true : false;
		
		if(isFactValue){
			$('#playBtnDiv').hide();
			lyr = new ol.layer.Vector({
		        source: new ol.source.Vector({
					features: factValueFeature
				}),
				style:factValueStyleFunction,
				opacity: 1
			});
			
		}else{
			$('#playBtnDiv').show();
			lyr = new ol.layer.Vector({
		        source: new ol.source.Vector({
					features: _CoreMap.getMap().getView().getZoom() > 9 ? cityDstrcFeature : cityFeature
				}),
				style:styleFunction,
				opacity: 0.9
			});
		}
		
		_MapEventBus.trigger(_MapEvents.map_addLayer,lyr);
	};
	
	var factValueStyleFunction = function(f, r){
		return [new ol.style.Style({
			image : getRenderer(f)
		})];
	};
	
	var createTempBranchTooltip = function() {
		if (tempBranchTooltipElement) {
			tempBranchTooltipElement.parentNode.removeChild(tempBranchTooltipElement);
		}
		tempBranchTooltipElement = document.createElement('div');
		tempBranchTooltipElement.className = 'tooltip hidden';
		tempBranchToolTip = new ol.Overlay({
        	element: tempBranchTooltipElement,
        	offset: [20, 20],
        	positioning: 'center-left'
        });
        _CoreMap.getMap().addOverlay(tempBranchToolTip);
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
