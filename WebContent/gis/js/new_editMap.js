
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
			if(type == undefined)
				return;
			if(obj == undefined)
				return;
			
			$.ajax({
				url:'/psupport/jsps/getAutoIpusnInfo.jsp?type='+type+'&factCode='+obj.FACT_CODE+'&branchNo='+obj.BRANCH_NO,
				dataType:"text",
				success:function(result){
					var data = JSON.parse(result);
					
					if(data == null || data.length == 0){
						obj.type = type;
						obj.flag = 'I';
						
						$.ajax({
							url:'/psupport/jsps/editAutoIpusn.jsp',
							type :'POST',
							data: obj,
							success:function(result){
								if(parseInt(result)> 0){
									if(callBack != undefined) {
										result = {};
										result.callbacktype = 'S';
										callBack(result);
									}
								}
							}, 
							error:function(error){  
								if(callBack != undefined) {
									error.callbacktype = 'E';
									callBack(error);
								}
							}
						});
					}else{
						if(callBack != undefined) {
							var reObj = {};
							reObj.callbacktype = 'R';
							reObj.msg = '이미 등록된 측정소입니다.';
							callBack(reObj);
						}
					}
				},
				error:function(error){  
					if(callBack != undefined) {
						error.callbacktype = 'E';
						callBack(error);
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
			if(type == undefined)
				return;
			if(obj == undefined)
				return;
			
			$.ajax({
				url:'/psupport/jsps/getAutoIpusnInfo.jsp?flag='+type+'&factCode='+obj.FACT_CODE+'&branchNo='+obj.BRANCH_NO,
				dataType:"text",
				success:function(result){
					var data = JSON.parse(result);
					
					if(data != null && data.length > 0){
						obj.OBJECTID = data[0].OBJECTID;
						obj.type = type;
						obj.flag = 'U';
						
						$.ajax({
							url:'/psupport/jsps/editAutoIpusn.jsp',
							type :'POST',
							data: obj,
							success:function(result){
								if(parseInt(result)> 0){
									if(callBack != undefined) {
										result = {};
										result.callbacktype = 'S';
										callBack(result);
									}
								}
							}, 
							error:function(error){  
								if(callBack != undefined) {
									error.callbacktype = 'E';
									callBack(error);
								}
							}
						});
					}
				}, 
				error:function(error){  
					if(callBack != undefined) {
						error.callbacktype = 'E';
						callBack(error);
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
			
			$.ajax({
				url:'/psupport/jsps/getAutoIpusnInfo.jsp?flag='+type+'&factCode='+obj.FACT_CODE+'&branchNo='+obj.BRANCH_NO,
				dataType:"text",
				success:function(result){
					var data = JSON.parse(result);
					
					if(data != null && data.length > 0){
						obj.OBJECTID = data[0].OBJECTID;
						obj.type = type;
						obj.flag = 'D';
						
						$.ajax({
							url:'/psupport/jsps/editAutoIpusn.jsp',
							type :'POST',
							data: obj,
							success:function(result){
								if(parseInt(result)> 0){
									if(callBack != undefined) {
										result = {};
										result.callbacktype = 'S';
										callBack(result);
									}
								}
							}, 
							error:function(error){  
								if(callBack != undefined) {
									error.callbacktype = 'E';
									callBack(error);
								}
							}
						});
					}
				}, 
				error:function(error){  
					if(callBack != undefined) {
						error.callbacktype = 'E';
						callBack(error);
					}
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
			
			obj.flag = 'I';
			
			$.ajax({
				url:'/psupport/jsps/editWHGeo.jsp',
				type :'POST',
				data: obj,
				success:function(result){
					if(parseInt(result)> 0){
						if(callBack != undefined) {
							result = {};
							result.callbacktype = 'S';
							callBack(result);
						}
					}
				}, 
				error:function(error){  
					if(callBack != undefined) {
						error.callbacktype = 'E';
						callBack(error);
					}
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
			
			obj.flag = 'U';
			
			$.ajax({
				url:'/psupport/jsps/editWHGeo.jsp',
				type :'POST',
				data: obj,
				success:function(result){
					if(parseInt(result)> 0){
						if(callBack != undefined) {
							result = {};
							result.callbacktype = 'S';
							callBack(result);
						}
					}
				}, 
				error:function(error){  
					if(callBack != undefined) {
						error.callbacktype = 'E';
						callBack(error);
					}
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
			if(obj == undefined)
				return;
			
			obj.flag = 'D';
			
			$.ajax({
				url:'/psupport/jsps/editWHGeo.jsp',
				type :'POST',
				data: obj,
				success:function(result){
					if(parseInt(result)> 0){
						if(callBack != undefined) {
							result = {};
							result.callbacktype = 'S';
							callBack(result);
						}
					}
				}, 
				error:function(error){  
					if(callBack != undefined) {
						error.callbacktype = 'E';
						callBack(error);
					}
				}
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