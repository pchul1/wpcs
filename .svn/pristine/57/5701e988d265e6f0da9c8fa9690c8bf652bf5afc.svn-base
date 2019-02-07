var $control;

$(function() {
	
	var page = {
		"dom" : $(this)
	};

	var TAG = page.id;

	var FLUX_DATA = [{label:"화천~춘천", distance:33.02, flux:1000, time:"2:00"},
					{label:"화천~춘천", distance:33.02, flux:2000, time:"1:40"},
					{label:"화천~춘천", distance:33.02, flux:3000, time:"1:25"},
					{label:"화천~춘천", distance:33.02, flux:5000, time:"1:15"},
					{label:"화천~춘천", distance:33.02, flux:7000, time:"1:15"},
					{label:"화천~춘천", distance:33.02, flux:10000, time:"1:10"},
					{label:"화천~춘천", distance:33.02, flux:15000, time:"1:10"},
					{label:"춘천~의암", distance:19.4, flux:1000, time:"2:00"},
					{label:"춘천~의암", distance:19.4, flux:2000, time:"1:40"},
					{label:"춘천~의암", distance:19.4, flux:3000, time:"1:25"},
					{label:"춘천~의암", distance:19.4, flux:5000, time:"1:15"},
					{label:"춘천~의암", distance:19.4, flux:7000, time:"1:15"},
					{label:"춘천~의암", distance:19.4, flux:10000, time:"1:10"},
					{label:"춘천~의암", distance:19.4, flux:15000, time:"1:10"},
					{label:"의암~청평", distance:43.08, flux:1000, time:"2:00"},
					{label:"의암~청평", distance:43.08, flux:2000, time:"1:40"},
					{label:"의암~청평", distance:43.08, flux:3000, time:"1:25"},
					{label:"의암~청평", distance:43.08, flux:5000, time:"1:15"},
					{label:"의암~청평", distance:43.08, flux:7000, time:"1:15"},
					{label:"의암~청평", distance:43.08, flux:10000, time:"1:10"},
					{label:"의암~청평", distance:43.08, flux:15000, time:"1:10"},
					{label:"청평~팔당", distance:33.02, flux:1000, time:"2:00"},
					{label:"청평~팔당", distance:33.02, flux:2000, time:"1:40"},
					{label:"청평~팔당", distance:33.02, flux:3000, time:"1:25"},
					{label:"청평~팔당", distance:33.02, flux:5000, time:"1:15"},
					{label:"청평~팔당", distance:33.02, flux:7000, time:"1:15"},
					{label:"청평~팔당", distance:33.02, flux:10000, time:"1:10"},
					{label:"청평~팔당", distance:33.02, flux:15000, time:"1:10"},
					{label:"충주~여주", distance:53.05, flux:1000, time:"2:00"},
					{label:"충주~여주", distance:53.05, flux:2000, time:"1:40"},
					{label:"충주~여주", distance:53.05, flux:3000, time:"1:25"},
					{label:"충주~여주", distance:53.05, flux:5000, time:"1:15"},
					{label:"충주~여주", distance:53.05, flux:7000, time:"1:15"},
					{label:"충주~여주", distance:53.05, flux:10000, time:"1:10"},
					{label:"충주~여주", distance:53.05, flux:15000, time:"1:10"},
					{label:"여주~팔당", distance:54, flux:1000, time:"2:00"},
					{label:"여주~팔당", distance:54, flux:2000, time:"1:40"},
					{label:"여주~팔당", distance:54, flux:3000, time:"1:25"},
					{label:"여주~팔당", distance:54, flux:5000, time:"1:15"},
					{label:"여주~팔당", distance:54, flux:7000, time:"1:15"},
					{label:"여주~팔당", distance:54, flux:10000, time:"1:10"},
					{label:"여주~팔당", distance:54, flux:15000, time:"1:10"}];
	var FLUX_R02 = [{label:"안동교~왜관수위", distance:146.7, h_time:"21:00~24:00", p_time:"60:00"},
					{label:"왜관수위~고령수위", distance:114.1, h_time:"7:00~9:00", p_time:"33:36"},
					{label:"고령수위~적포교수위", distance:41.5, h_time:"6:00~7:00", p_time:"33:36"},
					{label:"적포교수위~칠서취수장", distance:27.8, h_time:"4:00", p_time:"19:12"},
					{label:"칠서취수장~삼랑진수위", distance:37, h_time:"9:00~10:00", p_time:"31:12"},
					{label:"삼랑진수위~하구언", distance:44.8, h_time:"7:00~10:00", p_time:"14:24"}];
	var FLUX_R03 = [{label:"발원지~대청댐", distance:370.7, h_time:"", p_time:"", j_time:""},
					{label:"대청댐~금남교", distance:28.5, h_time:"5:30~6:24", p_time:"9:30~14:00", j_time:"15:00~20:00"},
					{label:"금남교~공주취수장", distance:15.3, h_time:"2:36~3:00", p_time:"3:36~5:54", j_time:"4:00~8:00"},
					{label:"공주취수장~부여취수장", distance:32, h_time:"7:30~8:36", p_time:"15:00~21:00", j_time:"19:00~24:00"},
					{label:"부여취수장~황산대교", distance:17, h_time:"3:36~5:00", p_time:"11:00~11:24", j_time:"23:00~42:00"},
					{label:"부여취수장~금강하구언", distance:37.3, h_time:"5:00~6:00", p_time:"8:00~10:00", j_time:"12:00~13:00"}];
	var FLUX_R04 = [{label:"담양댐~광주", distance:33, time:"96:00"},
					{label:"광주~나주교", distance:17.5, time:"7:12"},
					{label:"나주교~고막원", distance:22, time:"4:48"},
					{label:"고막원~동강교", distance:6.5, time:"19:12"},
					{label:"동강교~몽탄취수장", distance:12.5, time:"40:48"},
					{label:"몽탄취수장~목포", distance:25, time:"72:00"}];
	
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
			
			if(window.location.href.indexOf('WPL_POP') > -1)
			{
				// 사고발생 정보 조회
				$control.model.getAccident();
				
				// 평시 조회
				$control.model.getAllserene('U');
				$control.model.getAllserene('A');
				$control.model.getAllserene('W');
			}
			
			else
			{
				// 평시 조회
				$control.model.getAllserene('U');
				$control.model.getAllserene('A');
				$control.model.getAllserene('W');
				
				// 이상상태 조회
			}
			
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
//					$control.model.getWriteAlert(data);
					
					$kecoMap.model.initFeatureLayer($control.model.alertData);
				},
				error:function(result){
				}
			});
		};
		pub.getAlertData = function(factcode, branchno)
		{
			for ( var i = 0; i < $control.model.alertData.length; i++) 
			{
				if( $control.model.alertData[i].FACT_CODE == factcode &&
					$control.model.alertData[i].BRANCH_NO == branchno )
				{
					return $control.model.alertData[i];
				}
			}
		};
		pub.getAllserene = function(sys) {
			if(sys != 'W')
			{
				$.ajax({
					url:'/psupport/jsps/getAutoXML.jsp?sys='+sys,
					dataType:"json",
					success:function(result){
						
						//var data = JSON.parse(result);
						var data = result;
						
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
		// 경보 현황 조회
		pub.getWriteAlert = function(data)
		{
		};
		
		// 사고 지점 조회
		pub.getAccident = function()
		{
			$control.model.accidentData = [];
			page.view.accidentDataView.setItems([]);
			
			var today = new Date();
			
			var yestday = today.getFullYear()-1 + addzero(today.getMonth()+1) + addzero(today.getDate());
			var today = today.getFullYear()+ addzero(today.getMonth()+1) +addzero(today.getDate());
			
//			yestday = "20140606";
//			today = "20140607";
			
			var url = '';
			
			if(user_riverid != undefined && user_riverid != 'null')
				url = '/psupport/jsps/getAccidentWPLXML.jsp?wpCode='+wpCode; 
			else 
				url = '/psupport/jsps/getAccidentWPLXML.jsp?wpCode='+wpCode; 
			
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
					
					if(datas.length > 0)
						$("#slickNullSearch").hide();
					else
						$("#slickNullSearch").show();
					
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
					page.view.accidentDataView.beginUpdate();
					page.view.accidentDataView.setItems( $control.model.accidentData, 'no');
					page.view.accidentDataView.endUpdate();
					
					$control.model.accident = $control.model.accidentData[0];
					
					$control.model.GetFcode();
				}
			});
		};
		
		pub.searchAccident = function() {
			if(btToggleFlag)
				$('#btToggle').trigger('click');
			
			$control.model.accidentSearData = [];
			page.view.accidentSearDataView.setItems([]);
			
			var type;
			var fday			= page.view.startDate.val().replace(/[/]/g,'');
			var tday			= page.view.endDate.val().replace(/[/]/g,'');
			var selEventType	= page.view.selEventType.val();
			var selRDiv			= page.view.selRDiv.val();
			var selStep			= page.view.selStep.val();
			var url = '/psupport/jsps/getAccidentXML.jsp?searchRiverDiv='+selRDiv+'&searchWpKind='+selEventType+'&searchstep='+selStep+'&startDate='+fday+'&endDate='+tday;
			$.ajax({
				url: url,
				dataType: 'text',
				success: function(data) {
					data = xml2json.parser(data);
//					$kecoMap.model.markerClear();	//1년간 사고내역 검색시 재 검색이 없으므로...
					
					var datas = undefined;
					
					if(data.accidents== undefined)
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
					
					if(datas.length > 0)
						$("#slickNullSearch1").hide();
					else
						$("#slickNullSearch1").show();
					
					for ( var i = 0; i < datas.length; i++) {
						var obj = datas[i];
						
						obj.sear = i + 's';
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
						
						$control.model.accidentSearData.push(obj);
						
						if(obj.longitude != undefined && obj.latitude != undefined)
							$kecoMap.model.addMarker(type, obj.longitude, obj.latitude, obj);
					}
					page.view.accidentSearDataView.beginUpdate();
					page.view.accidentSearDataView.setItems( $control.model.accidentSearData, 'no');
					page.view.accidentSearDataView.endUpdate();
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
		
		pub.accidentSearGrid = undefined;
		pub.accidentSearDataView = undefined;
		
		
				
		pub.initAccidentGrid = function()
		{
			if(window.location.href.indexOf('WPL_POP') <= -1)
				return;
			
			this.accidentDataView = new Slick.Data.DataView();
			this.accidentSearDataView = new Slick.Data.DataView();
			
			var columns = [
							{ id: "no", name: "NO", field: "no", width: 45, sortable: true, cssClass: "slick-pointer" },
							{ id: "receivedate", name: "접수일자", field: "receivedate", width: 100, sortable: true, cssClass: "slick-pointer" },
							{ id: "river_div", name: "수계", field: "river_name", width: 100, sortable: true, cssClass: "slick-pointer" },
							{ id: "wpkind", name: "사고유형", field: "wpkind", width: 90, sortable: true, cssClass: "slick-pointer" },
							{ id: "wpcontent", name: "사고내용", field: "wpcontent", width: 90, cssClass: "slick-pointer text-align-left" },
							{ id: "wpsstep", name: "방제현황", field: "wpsstep", width: 90, sortable: true, cssClass: "slick-pointer" },
							{ id: "supportkind", name: "지원", field: "supportkind", width: 100, sortable: true, cssClass: "slick-pointer" }
						];
			var columns1 = [
							{ id: "no", name: "NO", field: "no", width: 45, sortable: true, cssClass: "slick-pointer" },
							{ id: "receivedate", name: "접수일자", field: "receivedate", width: 100, sortable: true, cssClass: "slick-pointer" },
							{ id: "river_div", name: "수계", field: "river_name", width: 100, sortable: true, cssClass: "slick-pointer" },
							{ id: "wpkind", name: "사고유형", field: "wpkind", width: 115, sortable: true, cssClass: "slick-pointer" },
							{ id: "wpcontent", name: "사고내용", field: "wpcontent", width: 200, cssClass: "slick-pointer text-align-left" },
							{ id: "wpsstep", name: "방제현황", field: "wpsstep", width: 80, sortable: true, cssClass: "slick-pointer" },
							{ id: "supportkind", name: "지원", field: "supportkind", width: 78, sortable: true, cssClass: "slick-pointer" }
						];
			var options = {
					enableColumnReorder: false,
					enableCellNavigation: true,
					multiColumnSort: false
			};
			
			this.accidentGrid = new Slick.Grid("#accident_tab", this.accidentDataView, columns, options);
			this.accidentSearGrid = new Slick.Grid("#accidentSear_tab", this.accidentSearDataView, columns1, options);
			
			this.accidentGrid.setSelectionModel(new Slick.RowSelectionModel());
			this.accidentSearGrid.setSelectionModel(new Slick.RowSelectionModel());
			
			this.accidentGrid.onSelectedRowsChanged.subscribe(function() { 
				page.view.accidentGrid.resetActiveCell();
				var obj = page.view.accidentGrid.getDataItem(page.view.accidentGrid.getSelectedRows())
				page.model.accident = obj;
				
				page.model.GetFcode();
			});
			
			this.accidentDataView.onRowCountChanged.subscribe(function (e, args) {
				page.view.accidentGrid.updateRowCount();
				page.view.accidentGrid.render();
			});
			
			this.accidentDataView.onRowsChanged.subscribe(function (e, args) {
				page.view.accidentGrid.invalidateRows(args.rows);
				page.view.accidentGrid.render();
			});
			
			this.accidentSearGrid.onSelectedRowsChanged.subscribe(function() { 
				page.view.accidentSearGrid.resetActiveCell();
				var obj = page.view.accidentSearGrid.getDataItem(page.view.accidentSearGrid.getSelectedRows())
				page.model.accident = obj;
				
				page.model.GetFcode();
			});
			
			this.accidentSearDataView.onRowCountChanged.subscribe(function (e, args) {
				page.view.accidentSearGrid.updateRowCount();
				page.view.accidentSearGrid.render();
			});
			
			this.accidentSearDataView.onRowsChanged.subscribe(function (e, args) {
				page.view.accidentSearGrid.invalidateRows(args.rows);
				page.view.accidentSearGrid.render();
			});
			
			function comparer(a,b) {
				var x = a[sortcol], y = b[sortcol];
					return (x == y ? 0 : (x > y ? 1 : -1));
			}
			
			var sortcol = "";
			var sortdir = 1;
			
			this.accidentGrid.onSort.subscribe(function(e, args) {
				sortdir = args.sortAsc ? 1 : -1;
				sortcol = args.sortCol.field;
				
				console.log("page.view.accidentDataView : ",page.view.accidentDataView);
				page.view.accidentDataView.sort(comparer, args.sortAsc);
			});
			
			this.accidentSearGrid.onSort.subscribe(function(e, args) {
				sortdir = args.sortAsc ? 1 : -1;
				sortcol = args.sortCol.field;
				
				page.view.accidentSearDataView.sort(comparer, args.sortAsc);
			});
		};
		
		// View 초기화
		pub.init = function() {
			
			this.initAccidentGrid();
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
			
			// ///////////////////
			// 이벤트 핸들러 등록
			// ///////////////////
		};
		return pub;
	}());
	
	$control = page;
	
	page.controller.init();

});