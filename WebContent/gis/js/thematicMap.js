var $control;

$(function() {
	
	var page = {
		"dom" : $(this)
	};
	
	var TAG = page.id;
	
	// MVC 설정 시작
	// ////////////////////////////
	
	// TODO MVC::model 관련 코드 작성
	page.model = ( function() {
		// ////////////////////////////
		// private variables
		// ////////////////////////////
		// Model 초기화
		
		var pub = {};
		
		pub.intervalEvent = function()
		{
			$kecoMap.model.markerClear();
			
			// 평시 조회
			$control.model.getAllserene('U');
			$control.model.getAllserene('A');
			$control.model.getAllserene('W');
			
		};
		
		pub.getAlert = function() {
			$.ajax({
				url:'/psupport/jsps/getAlertXML.jsp',
				dataType:"text",
				success:function(result){
					var data = JSON.parse(result);
					
					$control.model.alertData = data;
					
					$kecoMap.model.initFeatureLayer($control.model.alertData);
				},
				error:function(result){
				}
			});
		};
		
		pub.getAllserene = function(sys) {
			if(sys != 'W')
			{
				$.ajax({
					url:'/psupport/jsps/getAutoXML.jsp?sys='+sys,
					dataType:"text",
					success:function(result){
						var data = JSON.parse(result);
						
						if(sys == 'U')
							$control.model.ipusnData = data;
						else
						{
							$control.model.autoData = data;
							$control.model.getAlert();
						}
					},
					error:function(result){
					}
				});
			}
			else
			{
				$.ajax({
					url:'/psupport/jsps/getTMSXML.jsp',
					dataType:"text",
					success:function(result){
						var data = JSON.parse(result);
						$control.model.tmsData = data;
					},
					error:function(result){
					}
				});
			}
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
			page.model.init();
			
		};
		return pub;
	}());
	
	$control = page;
	
	page.controller.init();

});