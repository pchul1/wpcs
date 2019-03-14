
var $editMap;

$(function() {
	
	var page = {
		"dom" : $(this)
	};
	
	var TAG = page.id;
 
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
		
		pub.addMemtPoint = function(type, obj, callBack) {
			var graphic;
			if(type == undefined)
				return;
			if(obj == undefined)
				return;
			
			graphic = new esri.Graphic(new esri.geometry.Point(obj.X,obj.Y));
			
			graphic.attributes = obj;
			var qTask = undefined;
			
			if( type == 'A')
				qTask = new esri.tasks.QueryTask($define.ARC_SERVER_URL+"/rest/services/WPCS_EDIT/FeatureServer/1");
			else if( type == 'U')
				qTask = new esri.tasks.QueryTask($define.ARC_SERVER_URL+"/rest/services/WPCS_EDIT/FeatureServer/2");
				
			
			var q = new esri.tasks.Query();  
			q.outFields = ["*"];
			q.where = "FACT_CODE = '"+obj.FACT_CODE+"' AND BRANCH_NO = '"+obj.BRANCH_NO+"'";
			
			qTask.execute(q, function(result){
				if(result.features.length == 0) {
					if( type == 'A') {
						$editMap.view.autoLayer.applyEdits([graphic], null, null, function(result){
							if(callBack != undefined) {
								result.callbacktype = 'S';
								callBack(result);
							}
						} , function(error){
							if(callBack != undefined) {
								error.callbacktype = 'E';
								callBack(error);
							}
						});
					} else if( type == 'U') {
						$editMap.view.ipusnLayer.applyEdits([graphic], null, null, function(result){
								if(callBack != undefined) {
									result.callbacktype = 'S';
									callBack(result);
								}
								
							} , function(error){
								if(callBack != undefined) {
									error.callbacktype = 'E';
									callBack(error);
								}
							});
					}
				} else {
					if(callBack != undefined) {
						var reObj = {};
						reObj.callbacktype = 'R';
						reObj.msg = '이미 등록된 측정소입니다.';
						callBack(reObj);
					}
				}
			});
		};
		// type = A 자동 측정망 , U IP-USN
		// obj = Object
		// obj.X = x 좌표
		// obj.Y = y 좌표
		// obj.RV_CD = 수계코드
		// obj.FACT_CODE = 측정소코드
		// obj.BRANCH_NO = 지점 코드
		pub.updateMemtPoint = function(type, obj, callBack) {
			var graphic;
			if(type == undefined)
				return;
			if(obj == undefined)
				return;
			
			//var graphic = new esri.Graphic(esri.geometry.geographicToWebMercator(new esri.geometry.Point(obj.Y,obj.X)));
			if(type == 'U'){
				graphic = new esri.Graphic(new esri.geometry.Point(obj.Y,obj.X));
			}else{
				graphic = new esri.Graphic(new esri.geometry.Point(obj.X,obj.Y));
			}
			graphic.attributes = obj;
			
			var qTask = undefined;
			
			if( type == 'A')
				qTask = new esri.tasks.QueryTask($define.ARC_SERVER_URL+"/rest/services/WPCS_EDIT/FeatureServer/1");
			else if( type == 'U')
				qTask = new esri.tasks.QueryTask($define.ARC_SERVER_URL+"/rest/services/WPCS_EDIT/FeatureServer/2");
			
			var q = new esri.tasks.Query();
			q.outFields = ["*"];
			q.where = "FACT_CODE = '"+obj.FACT_CODE+"' AND BRANCH_NO = '"+obj.BRANCH_NO+"'";
			
			qTask.execute(q, function(result){
				if(result.features.length > 0) {
					graphic.attributes.OBJECTID = result.features[0].attributes.OBJECTID;
					if( type == 'A') {
						$editMap.view.autoLayer.applyEdits(null, [graphic], null, function(result){
							if(callBack != undefined) {
								result.callbacktype = 'S';
								callBack(result);
							}
						} , function(error){
							if(callBack != undefined) {
								error.callbacktype = 'E';
								callBack(error);
							}
						});
					} else if(type == 'U') {
						$editMap.view.ipusnLayer.applyEdits(null, [graphic], null, function(result){
							if(callBack != undefined) {
								result.callbacktype = 'S';
								callBack(result);
							}
						} , function(error){
							if(callBack != undefined) {
								error.callbacktype = 'E';
								callBack(error);
							}
						});
					}
				}
			});
		};
		// type = A 자동 측정망 , U IP-USN
		// obj = Object
		// obj.FACT_CODE = 측정소코드
		// obj.BRANCH_NO = 지점 코드
		pub.removeMemtPoint = function(type, obj, callBack) {
			if(type == undefined)
				return;
			if(obj == undefined)
				return;
			
			var qTask = undefined;
			
			if( type == 'A')
				qTask = new esri.tasks.QueryTask($define.ARC_SERVER_URL+"/rest/services/WPCS_EDIT/FeatureServer/1");
			else if( type == 'U')
				qTask = new esri.tasks.QueryTask($define.ARC_SERVER_URL+"/rest/services/WPCS_EDIT/FeatureServer/2");
			
			var q = new esri.tasks.Query();
			q.outFields = ["*"];
			q.where = "FACT_CODE = '"+obj.FACT_CODE+"' AND BRANCH_NO = '"+obj.BRANCH_NO+"'";
			qTask.execute(q, function(result){
				if( type == 'A') {
					$editMap.view.autoLayer.applyEdits(null, null, result.features, function(result){
					if(callBack != undefined)
					{
						result.callbacktype = 'S';
						callBack(result);
					}
					} , function(error){
						if(callBack != undefined) {
							error.callbacktype = 'E';
							callBack(error);
						}
					});
				} else if(type == 'U') {
					$editMap.view.ipusnLayer.applyEdits(null, null, result.features, function(result){
					if(callBack != undefined) {
						result.callbacktype = 'S';
						callBack(result);
					}
					} , function(error){
						if(callBack != undefined)
						{
							error.callbacktype = 'E';
							callBack(error);
						}
					});
				}
			});
		};
		
		// obj = Object
		// obj.WH_CODE = 창고코드
		// obj.WH_NAME = 창고명
		// obj.ADMIN_MGR = 관리자명
		// obj.ADMIN_TELN = 관리자 전화번호
		// obj.LON = 좌표
		// obj.LAT = 좌표
		// obj.USE_FLAG = Y : default
		// obj.HOUSE_TYPE = W : default
		
		pub.addWHPoint = function( obj, callBack) {
			if(obj == undefined)
				return;
			
			//var graphic = new esri.Graphic(esri.geometry.geographicToWebMercator(new esri.geometry.Point(obj.LAT,obj.LON)));
			var graphic = new esri.Graphic(new esri.geometry.Point(obj.LON,obj.LAT));
			graphic.attributes = obj;
			
			$editMap.view.whLayer.applyEdits([graphic], null, null, function(result){
//				console.log('whLayerapply : ' , result);
				if(callBack != undefined) {
					result.callbacktype = 'S';
						callBack(result);
				}
				} , function(error){
						if(callBack != undefined) {
							error.callbacktype = 'E';
							callBack(error);
						}
				});
		};
		// obj = Object
		// obj.WH_CODE = 창고코드
		// obj.WH_NAME = 창고명
		// obj.ADMIN_MGR = 관리자명
		// obj.ADMIN_TELN = 관리자 전화번호
		// obj.LON = 좌표
		// obj.LAT = 좌표
		// obj.USE_FLAG = Y : default
		// obj.HOUSE_TYPE = W : default
		pub.updateWHPoint = function( obj, callBack) {
//			if(type == undefined)
//				return;
			if(obj == undefined)
				return;
			
			//var graphic = new esri.Graphic(esri.geometry.geographicToWebMercator(new esri.geometry.Point(obj.Y,obj.X)));
			var graphic = new esri.Graphic(new esri.geometry.Point(obj.LON,obj.LAT));
			graphic.attributes = obj;
			
			var qTask = new esri.tasks.QueryTask($define.ARC_SERVER_URL+"/rest/services/WPCS_EDIT/FeatureServer/5");
			
			var q = new esri.tasks.Query();
			q.outFields = ["*"];
			q.where = "WH_CODE = '"+obj.WH_CODE+"'";
			
			qTask.execute(q, function(result){
				if(result.features.length > 0) {
					graphic.attributes.OBJECTID = result.features[0].attributes.OBJECTID;
					
					$editMap.view.whLayer.applyEdits(null, [graphic], null, function(result){
					if(callBack != undefined) 	{
						result.callbacktype = 'S';
						callBack(result);
					}
					} , function(error){
							if(callBack != undefined)
							{
								error.callbacktype = 'E';
								callBack(error);
							}
					});
				}
			});
		};
		// obj = Object
		// obj.WH_CODE = 창고코드
		// obj.WH_NAME = 창고명
		// obj.ADMIN_MGR = 관리자명
		// obj.ADMIN_TELN = 관리자 전화번호
		// obj.LON = 좌표
		// obj.LAT = 좌표
		// obj.USE_FLAG = Y : default
		// obj.HOUSE_TYPE = W : default
		pub.removeWHPoint = function( obj, callBack) {
//			if(type == undefined)
//				return;
			if(obj == undefined)
				return;
			
			var qTask = new esri.tasks.QueryTask($define.ARC_SERVER_URL+"/rest/services/WPCS_EDIT/FeatureServer/5");
			
			var q = new esri.tasks.Query();
			q.outFields = ["*"];
			q.where = "WH_CODE = '"+obj.WH_CODE+"'";
			
			qTask.execute(q, function(result){
				$editMap.view.whLayer.applyEdits(null, null, result.features, function(result){
					if(callBack != undefined) {
						result.callbacktype = 'S';
						callBack(result);
					}
					} , function(error){
							if(callBack != undefined) {
								error.callbacktype = 'E';
								callBack(error);
							}
					});
			});
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
			
			console.log('[EDIT MAP INIT]');
			page.model.init();
		};
		return pub;
	}());

	$(function(){
		page.controller.init();
	});
	
	$editMap = page;
});