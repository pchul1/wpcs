var _CrntSttnMap_ol = function () {
	var preZoomLevel = 0;
	
	var init = function(){
		setEvent();
		_MapService.getWfs(':CITY','*').done(function(){
			debugger;
		});
	};
	
	var setEvent = function(){
		_MapEventBus.on(_MapEvents.map_moveend, function(){
			var getZoom = _CoreMap.getMap().getView().getZoom();
			if(preZoomLevel != getZoom){
				preZoomLevel = getZoom;
			}
		});
	};
	
	var writeLayer = function(){
		
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
		}
	};
}();
