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
		
		pub.accident = undefined;
		
		// 사고목록
		pub.accidentData = [];
		
		// 평시 자동측정망 
		pub.autoData = [];
		// 평시 IPUSN
		pub.ipusnData = [];
		// 평시 TMS
		pub.tmsData = [];
		
		// 이상데이터 자동측정망
		pub.alertData = [];
		
		// 창고 재고
		pub.whList = [];
		
		pub.intervalEvent = function()
		{
			$kecoMap.model.markerClear();
			
			this.accidentData = new Array();
			
			this.accident = undefined;
			
			// 평시 자동측정망 
			this.autoData = new Array();
			// 평시 IPUSN
			this.ipusnData = new Array();
			// 평시 TMS
			this.tmsData = new Array();
			
			// 이상데이터 자동측정망
			this.alertData = new Array();
			
			// 창고 재고 조회
			this.whList = new Array();
			
			
			$control.model.getWh();
			
			// 사고발생 정보 조회
			$control.model.getAccident();
			
			// 평시 조회
			$control.model.getAllserene('U');
			$control.model.getAllserene('A');
			$control.model.getAllserene('W');
			
		};
		
		pub.getWh = function() {
			$.ajax({
				url:'/psupport/jsps/getWH.jsp',
				dataType:"text",
				success:function(result){
					var data = JSON.parse(result);
					for ( var i = 0; i < data.length; i++) 
					{
						var stock = data[i]; 
						var wh = $control.model.getWhData(stock.WH_CODE)
						if(wh != undefined)
							wh.msgs.push(stock.MSG);
						else
						{
							wh = {}
							wh.WH_CODE = stock.WH_CODE;
							wh.msgs = [];
							wh.msgs.push(stock.MSG);
							$control.model.whList.push(wh);
						}
					}
				},
				error:function(result){
				}
			});
		};
		pub.getWhData = function(whcode)
		{
			if(whcode == undefined)
				return;
			
			for ( var i = 0; i < this.whList.length; i++) {
				if(this.whList[i].WH_CODE == whcode)
					return this.whList[i];
			}
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
		
		pub.getCheckData = function(type, factcode, branchno)
		{
			var data = undefined;
			
			if(type == 'U')
				data = $control.model.ipusnData;
			else if(type == 'A')
				data = $control.model.autoData;
			else
				data = $control.model.tmsData;
			
			for ( var i = 0; i < data.length; i++) 
			{
				if(data[i].FACT_CODE == factcode && data[i].BRANCH_NO == branchno)
					return data[i];
			}
			
			return undefined;
		}
		
		// 사고 지점 조회
		pub.getAccident = function()
		{
			var today = new Date();
			
			var yestday = today.getFullYear()-1 + addzero(today.getMonth()+1) + addzero(today.getDate());
			var today = today.getFullYear()+ addzero(today.getMonth()+1) +addzero(today.getDate());
			
//			yestday = "20140610";
//			today = "20140611";
			var url = '';
			
			if(user_riverid != undefined && user_riverid != 'null')
				url = '/psupport/jsps/getAccidentXML.jsp?searchRiverDiv='+user_riverid+'&searchWpKind=all&searchSupportKind=all&startDate='+yestday+'&endDate='+today; 
			else 
				url = '/psupport/jsps/getAccidentXML.jsp?searchRiverDiv=all&searchWpKind=all&searchSupportKind=all&startDate='+yestday+'&endDate='+today;
			
			var type;
			$.ajax({
				url: url,
				dataType: 'text',
				success: function(data) {
					
					data = xml2json.parser(data);
					
					var datas = undefined;
					
					if(data.accidents == undefined)
						data.accidents = {};
						
					if(data.accidents.accident == undefined)
						datas = [];
					else if(data.accidents.accident.length > 1)
						datas = data.accidents.accident;
					else
					{
						datas = [];
						datas.push(data.accidents.accident);
					}
					
					for ( var i = 0; i < datas.length; i++) {
						var obj = datas[i];
						
//						if(obj.wpsstep == 'END')	//1년 데이터는 무조거 나오게 함
//							continue;
						
						obj.no = i + 1;
						
						if(obj.river_div == 'R01'){
							obj.river_name = '한강';
						}else if(obj.river_div == 'R02'){
							obj.river_name = '낙동강';
						}else if(obj.river_div == 'R03'){
							obj.river_name = '금강';
						}else if(obj.river_div == 'R04'){
							obj.river_name = '영산강';
						}
						
						if(obj.wpkind == 'PA'){
							obj.wpkind = '유류유출';
							type = 11;
						}else if(obj.wpkind == 'PB'){
							obj.wpkind = '물고기폐사';
							type = 12;
						}else if(obj.wpkind == 'PC'){
							obj.wpkind = '화학물질';
							type = 13;
						}else if(obj.wpkind == 'PD'){
							obj.wpkind = '기타';
							type = 14;
						}else if(obj.wpkind == 'PT'){
							obj.wpkind = '테스트';
						}
						
						if(obj.wpsstep == 'RCV'){
							obj.wpsstep = '접수';
						}else if(obj.wpsstep == 'ING'){
							obj.wpsstep = '수습중';
						}else if(obj.wpsstep == 'END'){
							obj.wpsstep = '조치완료';
						}else if(obj.wpsstep == 'STA'){
							obj.wpsstep = '신고';
							type = 10;
						}
						
						if(obj.supportkind == 'Y'){
							obj.supportkind = '지원';
						}else if(obj.supportkind == 'N'){
							obj.supportkind = '접수';
						}else{
							obj.supportkind = '미정';
						}
						
						if(obj.addrdet == 'null')
							obj.addrdet = '';
						
						obj.datatype = 'AC';
						
						$control.model.accidentData.push(obj);
						
						if(obj.longitude != undefined && obj.latitude != undefined)
							$kecoMap.model.addMarker(type, obj.longitude, obj.latitude, obj);
					}
					//최근 사고지점으로 가기
//					$control.model.accident = $control.model.accidentData[0];
//					
//					$control.model.GetFcode();
				}
			});
		};
		
		// 측정소 정보 조회
		pub.GetFcode = function()
		{
			if($control.model.accident == undefined)
				return;
			if($control.model.accident.fact_code == undefined && $control.model.accident.branch_no == undefined )
			{
				$.ajax({
					url: '/psupport/jsps/getFACTXML.jsp?lon='+page.model.accident.longitude+'&lan='+page.model.accident.latitude,
					dataType: 'text',
					success: function(data) {
						
						data = xml2json.parser(data);
						console.log('[ 사고 지점]', data);
						var d = data.items.split('_');
						
						if(d.length == 2)
						{
							$control.model.accident.fact_code = d[0];
							$control.model.accident.branch_no = d[1];
							$control.model.GetFcode();
						}
					}
				});
				return;
			}
			
			setTimeout(function(){
				$kecoMap.model.moveCenter($control.model.accident.longitude, $control.model.accident.latitude);	
			}, 1000)
			
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
		
		pub.accidentGrid = undefined;
		pub.accidentDataView = undefined;
		
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