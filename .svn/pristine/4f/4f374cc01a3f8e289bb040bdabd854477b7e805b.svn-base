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
		
		pub.accident = undefined;
		
		// 사고목록
		pub.accidentData = [];
		
		// 사고조회 목록
		pub.accidentSearData = [];
		
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
			
			if(window.location.href.indexOf('TMS_POP') > -1)
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
				url = '/psupport/jsps/getAccidentXML.jsp?searchRiverDiv='+user_riverid+'&searchWpKind=all&searchSupportKind=all&startDate='+yestday+'&endDate='+today; 
			else 
				url = '/psupport/jsps/getAccidentXML.jsp?searchRiverDiv=all&searchWpKind=all&searchSupportKind=all&startDate='+yestday+'&endDate='+today;
			
			var type
			
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
			
			var fday			= page.view.startDate.val().replace(/[/]/g,'');
			var tday			= page.view.endDate.val().replace(/[/]/g,'');
			var selEventType	= page.view.selEventType.val();
			var selRDiv			= page.view.selRDiv.val();
			var selStep			= page.view.selStep.val();
			var url = '/psupport/jsps/getAccidentXML.jsp?searchRiverDiv='+selRDiv+'&searchWpKind='+selEventType+'&searchstep='+selStep+'&startDate='+fday+'&endDate='+tday;
			var type;
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
			
			
			var html = '';
			
			if($control.model.accident.river_div == "R01")
			{
				page.view.r01SelDiv.show();
				page.view.unitLabel.html('단위 [유량 - 톤/일],[거리 - km],[도달시간 - 시:분]');
				html ='<tr><th scope="col">구간</th><th scope="col">유량</th><th scope="col">거리</th><th scope="col" class="last">시간</th></tr>';
				page.view.arrivalHd.html(html);
			}
			else if($control.model.accident.river_div == "R02")
			{
				page.view.r01SelDiv.hide();
				page.view.unitLabel.html('단위[거리 - Km],[도달시간 - 시:분]');
				html ='<tr><th scope="col">구간</th><th scope="col">거리</th><th scope="col">홍수기</th><th scope="col" class="last">평수기</th></tr>';
				page.view.arrivalHd.html(html);
			}
			else if($control.model.accident.river_div == "R03")
			{
				page.view.r01SelDiv.hide();
				page.view.unitLabel.html('단위[거리 - Km],[도달시간 - 시:분]');
				html ='<tr><th scope="col">구간</th><th scope="col">거리</th><th scope="col">홍수기</th><th scope="col">평수기</th><th scope="col" class="last">절수기</th></tr>';
				page.view.arrivalHd.html(html);
			}
			else if($control.model.accident.river_div == "R04")
			{
				page.view.r01SelDiv.hide();
				page.view.unitLabel.html('단위[거리 : Km],[도달시간 : 시/분]');
				html ='<tr><th scope="col">구간</th><th scope="col">거리</th><th scope="col" class="last">시간</th></tr>';
				page.view.arrivalHd.html(html);
			}
			
			this.writeArrivalData($control.model.accident.river_div);
			
			// 자동 측정망 상류 0 , 1 하류 
			
			this.getSeqAutoXML(0);
			this.getSeqAutoXML(1);
//			this.getSeqTaksuXML(0);
//			this.getSeqTaksuXML(1);
			
			// IP-USN  상류 0 , 하류 1
			this.getSeqIPusnXML(0);
			this.getSeqIPusnXML(1);
//			
			this.getSeqDamXML();
			this.getSeqWaterCenterXML();
			
			this.show_enterway();
//			C_radius.dataProvider = A_radius;
		};
		
		// 구간 넣기
		pub.writeArrivalData = function(rdiv)
		{
			var html = '';
			if(rdiv == 'R02')
			{
				for ( var i = 0; i < FLUX_R02.length; i++) 
				{
					html += '<tr><td>'+FLUX_R02[i].label+'</td>'+
							'<td>'+FLUX_R02[i].distance+'</td>'+
							'<td>'+FLUX_R02[i].h_time+'</td>'+
							'<td class="last">'+FLUX_R02[i].p_time+'</td></tr>';
				}
			}
			else if(rdiv == 'R03')
			{
				for ( var i = 0; i < FLUX_R03.length; i++) 
				{
					html += '<tr><td>'+FLUX_R03[i].label+'</td>'+
							'<td>'+FLUX_R03[i].distance+'</td>'+
							'<td>'+FLUX_R03[i].h_time+'</td>'+
							'<td>'+FLUX_R03[i].p_time+'</td>'+
							'<td class="last">'+FLUX_R03[i].j_time+'</td></tr>';
				}
			}
			else if(rdiv == 'R04')
			{
				for ( var i = 0; i < FLUX_R04.length; i++) 
				{
					html += '<tr><td>'+FLUX_R04[i].label+'</td>'+
							'<td>'+FLUX_R04[i].distance+'</td>'+
							'<td class="last">'+FLUX_R04[i].time+'</td></tr>';
				}
			}
			if(rdiv == 'R01')
				this.getSection();
			else
				page.view.arrival_tab.html(html);
			
		};
		// 댐정보
		pub.getSeqDamXML = function()
		{
			$.ajax({
				url: '/psupport/jsps/getDamBySeq.jsp?ID=' + $control.model.accident.fact_code + '&BRANCH_NO=' + $control.model.accident.branch_no,
				dataType: 'text',
				success: function(data) {
					
					data = xml2json.parser(data);
					
					var html = '';
					var dams = undefined;
					
					if(data.dams.dam == undefined)
						dams = [];
					else if( data.dams.dam.length > 1)
					{
						dams = data.dams.dam;
					}
					else
					{
						dams = [];
						dams.push(data.dams.dam);
					}
					for ( var i = 0; i < dams.length; i++) 
					{
						html += '<tr onclick="$kecoMap.model.moveCenter(\''+dams[i].longitude+'\',\''+dams[i].latitude+'\');">'+
							'<td>'+dams[i].name+'</td>'+
							'<td>'+dams[i].ngi_phone+'</td>'+
							'<td>'+dams[i].swl+'</td>'+
							'<td>'+dams[i].inf+'</td>'+
							'<td>'+dams[i].otf+'</td>'+
							'<td class="last">'+dams[i].ecpc+'</td></tr>';
					}
					page.view.dam_tab.html(html);
				}
			});	
			
		
		}// end function
		
		// 취정수장
		pub.getSeqWaterCenterXML = function() 
		{
			$.ajax({
				url: '/psupport/jsps/getWaterCenterBySeq.jsp?ID=' + $control.model.accident.fact_code + '&BRANCH_NO=' + $control.model.accident.branch_no, 
				dataType: 'text',
				success: function(data) {
					
					data = xml2json.parser(data);
					
					var html = '';
					var wcs = undefined;
					
					if(data.wcs.wc == undefined)
						wcs = [];
					else if( data.wcs.wc.length > 1)
					{
						wcs = data.wcs.wc;
					}
					else
					{
						wcs = [];
						wcs.push(data.wcs.wc);
					}
					for ( var i = 0; i < wcs.length; i++) 
					{
						html += '<tr onclick="$kecoMap.model.moveCenter(\''+wcs[i].longitude+'\',\''+wcs[i].latitude+'\');">'+
							'<td>'+wcs[i].name+'</td>'+
							'<td>'+wcs[i].manager+'</td>'+
							'<td>'+wcs[i].proc_qty+'</td>'+
							'<td class="last">'+wcs[i].phone+'</td></tr>';
					}
					page.view.wc_tab.html(html);
				}
			});
		}// end function
		
		pub.getSeqAutoXML = function(seq) //seq == 0 상류, 1 = 하류
		{
			var url = '/psupport/jsps/getSeqXML.jsp?ID=' + $control.model.accident.fact_code + '&SEQ='+seq+'&SYS_KIND=A&BRANCH_NO=' + $control.model.accident.branch_no;
			
			$.ajax({
				url : url,
				dataType: 'text',
				success: function(data) {
					
					data = xml2json.parser(data);
//					console.log('['+seq+']', data);
					
					var outHtml = '';
					var inHtml = '';
					var sqcs = undefined;
					
					if(data.sqcs.sqc == undefined)
						sqcs = [];
					else if( data.sqcs.sqc.length > 1)
					{
						sqcs = data.sqcs.sqc;
					}
					else
					{
						sqcs = [];
						sqcs.push(data.sqcs.sqc);
					}
					
					for ( var i = 0; i < sqcs.length; i++) 
					{
						inHtml += '<tr onclick="$kecoMap.model.moveCenter(\''+sqcs[i].longitude+'\',\''+sqcs[i].latitude+'\');">'+
							'<td>'+sqcs[i].branch_name+'</td>'+
							'<td>'+sqcs[i].phy00_vl+'</td>'+
							'<td>'+sqcs[i].dow00_vl+'</td>'+
							'<td>'+sqcs[i].con00_vl+'</td>'+
							'<td class="last">'+sqcs[i].toc00_vl+'</td></tr>';
						
						outHtml += '<tr onclick="$kecoMap.model.moveCenter(\''+sqcs[i].longitude+'\',\''+sqcs[i].latitude+'\');">'+
							'<td>'+sqcs[i].branch_name+'</td>'+
							'<td>'+sqcs[i].phy01_vl+'</td>'+
							'<td>'+sqcs[i].dow01_vl+'</td>'+
							'<td>'+sqcs[i].con01_vl+'</td>'+
							'<td class="last">'+sqcs[i].toc00_vl+'</td></tr>';
					}
					if(seq == 0)
					{
						$control.view.DG_A_out.html(outHtml);
						$control.view.DG_A_in.html(inHtml);
					}
					else
					{
						$control.view.DG_Adn_out.html(outHtml);
						$control.view.DG_Adn_in.html(inHtml);
					}
				}
			});
		};
		// 하류
	
		pub.getSeqTaksuXML = function(seq)
		{
			$.ajax({
				url: '/psupport/jsps/getSeqXML.jsp?ID=' + $control.model.accident.fact_code + '&SEQ='+seq+'&SYS_KIND=T&BRANCH_NO=' + $control.model.accident.branch_no,
				dataType: 'text',
				success: function(data) {
					
					data = xml2json.parser(data);
					console.log('[탁수]', data);
					var html = '';
					var sqcs = undefined;
					
					if(data.sqcs.sqc == undefined)
						sqcs = [];
					else if( data.sqcs.sqc.length > 1)
					{
						sqcs = data.sqcs.sqc;
					}
					else
					{
						sqcs = [];
						sqcs.push(data.sqcs.sqc);
					}
					
					for ( var i = 0; i < sqcs.length; i++) 
					{
						html += '<tr onclick="$kecoMap.model.moveCenter(\''+sqcs[i].longitude+'\',\''+sqcs[i].latitude+'\');">'+
						'<td>'+sqcs[i].branch_name+'</td>'+
						'<td>'+sqcs[i].phy00_vl+'</td>'+
						'<td>'+sqcs[i].dow00_vl+'</td>'+
						'<td>'+sqcs[i].con00_vl+'</td>'+
						'<td>'+sqcs[i].tmp00_vl+'</td>'+
						'<td class="last">'+sqcs[i].tur00_vl+'</td>'+
						'</tr>';
					}
					if(seq == 0)
						$control.view.DG_T.html(html);
					else
						$control.view.DG_Tdn.html(html);
				}
			});
		}// end function
		
		pub.getSeqIPusnXML = function(seq) //seq == 0 상류, 1 = 하류
		{
			$.ajax({
				url: '/psupport/jsps/getSeqXML.jsp?ID=' + $control.model.accident.fact_code + '&SEQ='+seq+'&SYS_KIND=U&BRANCH_NO=' + $control.model.accident.branch_no,
				dataType: 'text',
				success: function(data) {
					
					data = xml2json.parser(data);
					var html = '';
					var sqcs = undefined;
					
					if(data.sqcs.sqc == undefined)
						sqcs = [];
					else if( data.sqcs.sqc.length > 1)
					{
						sqcs = data.sqcs.sqc;
					}
					else
					{
						sqcs = [];
						sqcs.push(data.sqcs.sqc);
					}
					
					for ( var i = 0; i < sqcs.length; i++) 
					{
						html += '<tr onclick="$kecoMap.model.moveCenter(\''+sqcs[i].longitude+'\',\''+sqcs[i].latitude+'\');">'+
						'<td>'+sqcs[i].fact_full_name+'</td>'+
						'<td>'+sqcs[i].phy00_vl+'</td>'+
						'<td>'+sqcs[i].dow00_vl+'</td>'+
						'<td>'+sqcs[i].con00_vl+'</td>'+
						'<td>'+sqcs[i].tmp00_vl+'</td>'+
						'<td class="last">'+sqcs[i].tur00_vl+'</td>'+
						'</tr>';
					}
					
					if(seq == 0)
						$control.view.DG_U.html(html);
					else
						$control.view.DG_Udn.html(html);
				}
			});	
			
		};
	
		// 방제창고조회
	//		pub.getWareHouseXML = function()
	//		{
	//			if($control.model.accident == undefined)
	//				return;
	//			
	//			console.log('[getWareHouseXML]', $control.model.accident);
	//			
	//			$.ajax({
	//				url: '/psupport/jsps/getWareHouseXML.jsp?RIVER_DIV=' + $control.model.accident.river_div,
	//				dataType: 'text',
	//				success: function(data) {
	//						
	//					data = xml2json.parser(data);
	//					
	//					var html = '';
	//					var warehouses = undefined;
	//					
	//					if(data.warehouses.warehouse == undefined)
	//						warehouses = [];
	//					else if( data.warehouses.warehouse.length > 1)
	//					{
	//						warehouses = data.warehouses.warehouse;
	//					}
	//					else
	//					{
	//						warehouses = [];
	//						warehouses.push(data.warehouses.warehouse);
	//					}
	//					
	//					for ( var i = 0; i < warehouses.length; i++) 
	//					{
	//						html += '<tr onclick="$kecoMap.model.moveCenter(\''+warehouses[i].longitude+'\',\''+warehouses[i].latitude+'\');">'+
	//						'<td>'+warehouses[i].wh_name+'</td>'+
	//						'<td >'+warehouses[i].item_name+'</td>'+
	//						'<td >'+warehouses[i].stor_amt+'</td>'+
	//						'<td class="last">'+warehouses[i].item_unit+'</td>'+
	//						'</tr>';
	//					}
	//					$control.view.wh_tab.html(html);
	//				}
	//			});
	//		};
	
		// 오염원 조회
		pub.getFactoryByAccidentXML = function()
		{
			if($control.model.accident == undefined)
				return;
			
			$.ajax({
				url: '/psupport/jsps/getFactoryByAccidentXML.jsp?FACT_CODE=' + $control.model.accident.fact_code,
				dataType: 'text',
				success: function(data) {
					
					data = xml2json.parser(data);
					
					var html = '';
					var factorys = undefined;
					
					if(data.factorys.factory == undefined)
						factorys = [];
					else if( data.factorys.factory.length > 1)
					{
						factorys = data.factorys.factory;
					}
					else
					{
						factorys = [];
						factorys.push(data.factorys.factory);
					}
					
					for ( var i = 0; i < factorys.length; i++) 
					{
						html += '<tr onclick="$kecoMap.model.moveCenter(\''+factorys[i].longitude+'\',\''+factorys[i].latitude+'\');">'+
						'<td>'+factorys[i].nm+'</td>'+
						'<td >'+factorys[i].river_id+'</td>'+
						'<td class="last">'+factorys[i].address+'</td>'+
						'</tr>';
					}
					$control.view.fac_tab.html(html);
				}
			});
			
		};
		
		pub.getSection = function()
		{
			
			var secData = this.getFluxData(page.view.r01Sel_sec.val() , page.view.r01Sel_flux.val());
			
			var html = '';
			
			for ( var i = 0; i < secData.length; i++) 
			{
				html += '<tr><td>'+secData[i].label+'</td>' +
						'<td>'+secData[i].distance+'</td>' +
						'<td>'+secData[i].flux+'</td>' +
						'<td>'+secData[i].time+'</td></tr>';
			}
			page.view.arrival_tab.html(html);
		};
		
		pub.getFluxData = function(sec, flux)
		{
			if(sec == '전체' && flux == '전체')
				return FLUX_DATA;
			
			var seclabll = sec;
			var fluxlabel = flux;
			
			var reData = [];
			for ( var i = 0; i < FLUX_DATA.length; i++) 
			{
				if(sec == '전체')
					seclabll = FLUX_DATA[i].label;
				if(flux == '전체')
					fluxlabel = FLUX_DATA[i].flux;
				if(seclabll == FLUX_DATA[i].label  && fluxlabel == FLUX_DATA[i].flux)
					reData.push(FLUX_DATA[i]);
			}
			return reData;
		};
		
		pub.refreshIpusn = function(outFlag)
		{
			var url = '/psupport/jsps/getAccidentIPUSN.jsp';
			
			if(outFlag == 4)
				url = '/psupport/jsps/getIPUSNXML.jsp';
			
			$.ajax({
				url: url,
				dataType: 'text',
				success: function(data) {
					data = xml2json.parser(data);
					
					var html = '';
					var ipusns = undefined;
					
					if(data.ipusns.ipusn == undefined)
						ipusns = [];
					else if( data.ipusns.ipusn.length > 1)
					{
						ipusns = data.ipusns.ipusn;
					}
					else
					{
						ipusns = [];
						ipusns.push(data.ipusns.ipusn);
					}
					
					for ( var i = 0; i < ipusns.length; i++) 
					{
						html += '<tr onclick="$kecoMap.model.moveCenter(\''+ipusns[i].longitude+'\',\''+ipusns[i].latitude+'\');">'+
							'<td>'+ipusns[i].branch_name+'</td>'+
							'<td >'+ipusns[i].battery+'</td>'+
							'<td class="last">'+ipusns[i].update_time+'</td>'+
							'</tr>';
						$kecoMap.model.addMarker(outFlag, ipusns[i].longitude, ipusns[i].latitude, ipusns[i]);
					}
					
					if(outFlag == 4)
						$control.view.ipusn_tab.html(html);
					
					else
						$control.view.outIpusn_tab.html(html);
				}
			});
		};
		pub.freshSmart = function()
		{
			$.ajax({
				url: '/psupport/jsps/getEcompanyGpsXML.jsp',
				dataType: 'text',
				success: function(data) {
					
					data = xml2json.parser(data);
					
					var html = '';
					var ecomgpss = undefined;
					
					if(data.ecomgpss.ecomgps == undefined)
						ecomgpss = [];
					else if( data.ecomgpss.ecomgps.length > 1)
					{
						ecomgpss = data.ecomgpss.ecomgps;
					}
					else
					{
						ecomgpss = [];
						ecomgpss.push(data.ecomgpss.ecomgps);
					}

					for ( var i = 0; i < ecomgpss.length; i++) 
					{
						html += '<tr onclick="$kecoMap.model.moveCenter(\''+ecomgpss[i].longitude+'\',\''+ecomgpss[i].latitude+'\');">'+
							'<td>'+ecomgpss[i].member_name+'</td>'+
							'<td >'+ecomgpss[i].mobile_no+'</td>'+
							'<td class="last">'+ecomgpss[i].update_time+'</td>'+
							'</tr>';
						
						$kecoMap.model.addMarker(4, ecomgpss[i].longitude, ecomgpss[i].latitude, ecomgpss[i]);
					}
					
					$control.view.smart_tab.html(html);
				}
			});	
			
		};
		
		// 전출입 
		
		pub.show_enterway = function() 
		{
			$.ajax({
				url: '/psupport/jsps/getAccessPointXML.jsp?FACT_CODE=' + $control.model.accident.fact_code + '&BRANCH_NO=' + $control.model.accident.branch_no,
				dataType: 'text',
				success: function(data) {
					
					data = xml2json.parser(data);
					
					var html = '';
					var aplists = undefined;
					
					if(data.aplists.aplist == undefined)
						aplists = [];
					else if( data.aplists.aplist.length > 1)
					{
						aplists = data.aplists.aplist;
					}
					else
					{
						aplists = [];
						aplists.push(data.aplists.aplist);
					}
					
					for ( var i = 0; i < aplists.length; i++) 
					{
						$kecoMap.model.addMarker(2, aplists[i].longitude, aplists[i].latitude, aplists[i]);
					}
				}
			});
		}
		
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
		
		
		pub.DG_A_out	= $('#DG_A_out', page.dom);
		pub.DG_A_in		= $('#DG_A_in', page.dom);
		pub.DG_Adn_out	= $('#DG_Adn_out', page.dom);
		pub.DG_Adn_in	= $('#DG_Adn_in', page.dom);
		pub.DG_U		= $('#DG_U', page.dom);
		pub.DG_Udn		= $('#DG_Udn', page.dom);
		
		pub.DG_T		= $('#DG_T', page.dom);
		pub.DG_Tdn		= $('#DG_Tdn', page.dom);
		
		pub.dam_tab		= $('#dam_tab', page.dom);
		pub.wc_tab		= $('#wc_tab', page.dom);
		
//		pub.C_radius	= $('#C_radius', page.dom);
		pub.searchEcomBtn = $('#searchEcomBtn', page.dom);
		pub.do_tab		= $('#do_tab', page.dom);
		
		pub.searchWhBtn = $('#searchWhBtn', page.dom);
		pub.wh_tab	  = $('#wh_tab', page.dom);
		
		pub.searchFacBtn = $('#searchFacBtn', page.dom);
		pub.fac_tab	  = $('#fac_tab', page.dom);
		
		pub.unitLabel	= $('#unitLabel', page.dom);
		pub.r01SelDiv	= $('#r01SelDiv', page.dom);
		
		pub.arrivalHd	= $('#arrivalHd', page.dom);
		pub.arrival_tab		= $('#arrival_tab', page.dom);
		
		pub.r01Sel_flux		= $('#r01Sel_flux', page.dom);
		pub.r01Sel_sec		= $('#r01Sel_sec', page.dom);
		
		pub.refreshIpusnBtn	= $('#refreshIpusnBtn', page.dom);
		pub.ipusn_tab		= $('#ipusn_tab', page.dom);
		
		pub.refreshOutIpusnBtn	= $('#refreshOutIpusnBtn', page.dom);
		pub.outIpusn_tab		= $('#outIpusn_tab', page.dom);
		
		pub.refreshSmartBtn	= $('#refreshSmartBtn', page.dom);
		pub.smart_tab		= $('#smart_tab', page.dom);
		
		pub.startDate		= $('#startDate', page.dom);
		pub.endDate			= $('#endDate', page.dom);
		pub.selEventType	= $('#selEventType', page.dom);
		pub.selRDiv			= $('#selRDiv', page.dom);
		pub.selStep			= $('#selStep', page.dom);
		
		pub.acSearBtn		= $('#acSearBtn', page.dom);
		
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yy/mm/dd',
			showOn: 'both',
			buttonImage: '/images/common/ico_calendar.gif',
			buttonImageOnly: true
		});
		
		pub.startDate.datepicker({
			buttonText: '시작일'
			
		});
		pub.endDate.datepicker({
			buttonText: '종료일'
		});
		
		var today = new Date(); 
		
		var yeday = today.getFullYear()+ "/" + addzero(today.getMonth()+1) + "/" + addzero(today.getDate());
		var today = today.getFullYear()+ "/" + addzero(today.getMonth()+1) + "/" +addzero(today.getDate());
		
		pub.startDate.val(yeday);
		pub.endDate.val(today);
		
		
//			pub.dam_nm	= $('#dam_nm', page.dom);
//			pub.dam_tel	= $('#dam_tel', page.dom);
//			
//			pub.SWL		= $('#SWL', page.dom);
//			pub.INF		= $('#INF', page.dom);
//			pub.OTF		= $('#OTF', page.dom);
//			pub.ECPC	= $('#ECPC', page.dom);
		
		pub.initAccidentGrid = function()
		{
			if(window.location.href.indexOf('TMS_POP') <= -1)
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
			
			var html = '<option value="all">전체</option>';
			html += '<option value="R01">한강</option>';
			html += '<option value="R02">낙동강</option>';
			html += '<option value="R03">금강</option>';
			html += '<option value="R04">영산강</option>';
			
			page.view.selRDiv.html(html);
			
			if(user_riverid != undefined && user_riverid != 'null')
			{
				$("#selRDiv option[value="+user_riverid+"]").attr("selected",true);
				page.view.selRDiv.attr('disabled', true);
			}
			else
			{
				page.view.selRDiv.attr('disabled', false);
			}
			
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
			
			if(window.location.href.indexOf('TMS_POP') <= -1)
				return;
			
			page.view.searchEcomBtn.on('click', function(){
				var de = $('#slider3').slider('value');
				de = parseInt(de) * 10;
				
				if($control.model.accident != undefined)
					$kecoMap.model.writeBuffer('1', $control.model.accident, de, function(result){
						var html = '';
						
						if(result != undefined)
						{
							for ( var i = 0; i < result.length; i++) 
							{
								var obj = result[i].attributes;
								
								html += '<tr onclick="$kecoMap.model.moveCenter(\''+obj.LONGITUDE+'\',\''+obj.LATITUDE+'\');"><td>'+obj.RIVER_NM+'</td>'+
								'<td>'+obj.NM+'</td>'+
								'<td class="last">'+obj.D_PHONE+'</td></tr>';
							}
						}
						$control.view.do_tab.html(html);
					});
			})
			
			page.view.searchWhBtn.on('click', function(){
				var de = $('#slider3').slider('value');
				de = parseInt(de) * 10;
				
				if($control.model.accident != undefined)
					$kecoMap.model.writeBuffer('2', $control.model.accident, de, function(result){
						var html = '';
						
						if(result != undefined)
						{
							for ( var i = 0; i < result.length; i++) 
							{
								var obj = result[i].attributes;
	//								var wh  = $control.model.getWhData(obj.WH_CODE);
								
								html += '<tr onclick="$kecoMap.model.moveCenter(\''+obj.LON+'\',\''+obj.LAT+'\', \'w\', \''+obj.WH_CODE+'\', \''+obj.WH_NAME+'\');">'+
									'<td>'+obj.WH_NAME+'</td>'+
									'<td>'+obj.ADMIN_MGR+'</td>'+
									'<td class="last">'+obj.ADMIN_TELN+'</td>'+
									'</tr>';
							}
						}
						$control.view.wh_tab.html(html);
					});
			});
			
	//			page.view.searchWhBtn.on('click', function(){
	//				page.model.getWareHouseXML();
	//			});
			
			page.view.searchFacBtn.on('click', function(){
				page.model.getFactoryByAccidentXML();
			});
			page.view.r01Sel_flux.on('change', function(){
				page.model.getSection();
			});
			page.view.r01Sel_sec.on('change', function(){
				page.model.getSection();
			});
			
			page.view.refreshIpusnBtn.on('click', function(){
				page.model.refreshIpusn(4);
			});
			page.view.refreshOutIpusnBtn.on('click', function(){
				page.model.refreshIpusn(3);
			});
			page.view.refreshSmartBtn.on('click', function(){
				page.model.freshSmart();
			});
			
			page.view.acSearBtn.on('click', function(){
				page.model.searchAccident();
			});
			
			setTimeout(function(){
				page.model.refreshIpusn(3);
				page.model.refreshIpusn(4);
			}, 1000);
		};
		return pub;
	}());
	
	$control = page;
	
	page.controller.init();

});