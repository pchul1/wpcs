var $main;

$(function() {
	
	var page = {
		"dom" : $(this)
	};
	
	var TAG = page.id;
	
	var EVENT_TEMP = {
			title:"${wpkind}",
			content: "<ul>"
						+ "<li> ● 사고유형 : ${wpkind} </li>"
						+ "<li> ● 신고일자 : ${reportdate}</li>"
						+ "<li> ● 접수일자 : ${receivedate}</li>"
						+ "<li> ● 수계 : ${river_name} </li>"
						+ "<li> ● 주소 : ${address} ${addrdet}</li>"
						+ "<li> ● 처리상태 : ${supportkind}</li></ul>"
					};
	
	var AUTO_TEMP = {
			title:"${FACTNAME}"+"("+"${BRANCH_NAME}"+")",
			content: "<ul>"
						+ "<li> ● 수신시간 : ${STRDATE} ${STRTIME} </li>"
						+ "<li> ● 수계 : ${RIVER_NAME} </li>"
						+ "<li> ● PH : ${PHY} </li>"
						+ "<li> ● DO : ${DOW} (mS/cm)</li>"
						+ "<li> ● EC : ${CON} (mS/cm)</li>"
						+ "<li> ● 탁도 : ${TUR} (NTU)</li>"
						+ "<li> ● 수온 : ${TMP} (℃)</li></ul>"
					};
	
	var AUTO_TEMP_ALERT = {
			title:"${FACTNAME}"+"("+"${BRANCH_NAME}"+")",
			content: "<ul>"
						+ "<li> ● 수신시간 : ${STRDATE} ${STRTIME} </li>"
						+ "<li> ● 수계 : ${RIVER_NAME} </li>"
						+ "<li> ● PH : ${PHY} </li>"
						+ "<li> ● DO : ${DOW} (mS/cm)</li>"
						+ "<li> ● EC : ${CON} (mS/cm)</li>"
						+ "<li> ● 탁도 : ${TUR} (NTU)</li>"
						+ "<li> ● 수온 : ${TMP} (℃)</li></ul>"
						+ "<li><font color=\"#ff0000\"> ● 이상메세지 : ${ALERT_MSG}</font></li></ul>"
					};
	
	var NULL_TEMP = {
			title:"${FACI_NM}",
			content: "<ul>"+
						"<li> 정보가 없습니다. </li></ul>"
					};
	
	// MVC 설정 시작
	// ////////////////////////////
	
	// TODO MVC::model 관련 코드 작성
	page.model = ( function() {
		// ////////////////////////////
		// private variables
		// ////////////////////////////
		// Model 초기화
		
		var pub = {};
		
		// 사고목록
		pub.accidentData = [];
		
		pub.tmsListData = [];	
		
		// 평시 자동측정망 
		pub.autoData = [];
		// 평시 IPUSN
		pub.ipusnData = [];
		// 평시 TMS
		pub.tmsData = [];
		
		// 이상데이터 자동측정망
		pub.alertData = [];
		
		// 자동측정소 리스트
		pub.autoList = [];
		
		// IP USN 리스트
		pub.usnList = [];
		
		// TMS 리스트
		pub.tmsList = [];
		
		// 창고 재고 리스트
		pub.whList = [];
		
		// 10분에 한번씩 폴링하여 최신 데이터로 갱신한다.
		pub.intervalEvent = function()
		{
			// 지도위에 올려진 아이콘들을 삭제 한다.
			//$kecoMap.model.markerClear();
			
			this.accidentData = [];
			
			this.tmsListData = [];
			
			// 평시 자동측정망 
			this.autoData = [];
			// 평시 IPUSN
			this.ipusnData = [];
			// 평시 TMS
			this.tmsData = [];
			
			// 이상데이터 자동측정망
			this.alertData = [];
			// 창고 재고 조회
			this.whList = [];
			// 창고재고 조회
			$main.model.getWh();
			// 사고발생 정보 조회
			$main.model.getAccident();
			$main.model.getTmsList();
			page.model.getAutoTmsList();
			// 평시 조회
			$main.model.getAllserene('U'); // IP-USN
			$main.model.getAllserene('A'); // 자동측정망
			$main.model.getAllserene('W'); // TMS
			// 이상상태 조회
			$main.model.getMeasureQueryData();
			$main.model.getUSNQueryData();
			$main.model.getTmsQueryData();
		};
		
		pub.getAccident = function()
		{
			$main.model.accidentData = [];
			page.model.accidentDataView.setItems([]);
			
			
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
						$("#slickNullSearch2").hide();
					else
						$("#slickNullSearch2").show();
					
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
						
						$main.model.accidentData.push(obj);
						
						/*if(obj.longitude != undefined && obj.latitude != undefined)
							$kecoMap.model.addMarker(type, obj.longitude, obj.latitude, obj);*/
					}
					page.model.accidentDataView.beginUpdate();
					page.model.accidentDataView.setItems( $main.model.accidentData, 'no');
					page.model.accidentDataView.endUpdate();
					
					$main.model.accident = $main.model.accidentData[0];
					
					
				}
			});
		};
		
		pub.getTmsList = function(wtype)
		{
			$main.model.tmsListData = [];
			page.model.tmsDataView.setItems([]);
			
			
			var url = '';
			if(wtype == undefined)
			{
				url = '/psupport/jsps/getTMSXML1.jsp';
			}
			else if (wtype == "1")
			{
				url = '/psupport/jsps/getTMSXML1.jsp';
			}
			else if (wtype == "2")
			{
				url = '/psupport/jsps/getTMSXML2.jsp';
			}
			else if (wtype == "3")
			{
				url = '/psupport/jsps/getTMSXML3.jsp';
			}
			else if (wtype == "4")
			{
				url = '/psupport/jsps/getTMSXML4.jsp';
			}
			else if (wtype == "5")
			{
				url = '/psupport/jsps/getTMSXMLM.jsp';
			}
			
			var type
			
			$.ajax({
				url: url,
				dataType: 'text',
				success: function(data) {
					data = JSON.parse(data);
					/*data = xml2json.parser(data);*/
					/*var datas = undefined;
					
					if(data.tmsList == undefined)
						data.accidents = {};
						
					if(data.accidents.accident == undefined)
						datas = [];
					else if(data.accidents.accident.length > 1)
						datas = data.accidents.accident;
					else
					{
						datas = [];
						datas.push(data.accidents.accident);
					}*/
					
					if(data.length > 0)
						$("#slickNullSearch3").hide();
					else
						$("#slickNullSearch3").show();
					
					for ( var i = 0; i < data.length; i++) {
						var obj = data[i];
						
//						if(obj.wpsstep == 'END')	//1년 데이터는 무조거 나오게 함
//							continue;
						
						obj.no = i + 1;
						
						if(obj.VALUE == 'M')
						{
							obj.VALUE = '미수신';
						}
						else if (obj.VALUE == '1')
						{
							obj.VALUE = '정상';
						}
						else if (obj.VALUE == '2')
						{
							obj.VALUE = '초과';
						}
						else if (obj.VALUE == '3')
						{
							obj.VALUE = '주의';
						}
						else if (obj.VALUE == '4')
						{
							obj.VALUE = '경보';
						}
						else
						{
							obj.VALUE = '점검중';
						}
						
						/*
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
						
						obj.datatype = 'AC';*/
						
						$main.model.tmsListData.push(obj);
						
						/*if(obj.longitude != undefined && obj.latitude != undefined)
							$kecoMap.model.addMarker(type, obj.longitude, obj.latitude, obj);*/
					}
					page.model.tmsDataView.beginUpdate();
					page.model.tmsDataView.setItems( $main.model.tmsListData, 'no');
					page.model.tmsDataView.endUpdate();
					
					$main.model.wtms = $main.model.tmsListData[0];
					
					
				}
			});
		};
		
		pub.getAutoTmsList = function(wtype)
		{
			$main.model.autoData = [];
			page.model.resultDataView.setItems([]);
			
			
			var url = '';
			if(wtype == undefined)
			{
				url = '/psupport/jsps/getAutoXML.jsp?sys=A';
			}
			else if (wtype == "1")
			{
				url = '/psupport/jsps/getTMSXML1.jsp';
			}
			else if (wtype == "2")
			{
				url = '/psupport/jsps/getTMSXML2.jsp';
			}
			else if (wtype == "3")
			{
				url = '/psupport/jsps/getTMSXML3.jsp';
			}
			else if (wtype == "4")
			{
				url = '/psupport/jsps/getTMSXML4.jsp';
			}
			else
			{
				url = '/psupport/jsps/getTMSXMLM.jsp';
			}
			
			var type
			
			$.ajax({
				url: url,
				dataType: 'text',
				success: function(data) {
					data = JSON.parse(data);
					
					if(data.length > 0)
						$("#slickNullSearch").hide();
					else
						$("#slickNullSearch").show();
					
					
					for ( var i = 0; i < data.length; i++) {
						var obj = data[i];
						
//						if(obj.wpsstep == 'END')	//1년 데이터는 무조거 나오게 함
//							continue;
						
						obj.no = i + 1;
						
						
						$main.model.autoData.push(obj);
						
						/*if(obj.longitude != undefined && obj.latitude != undefined)
							$kecoMap.model.addMarker(type, obj.longitude, obj.latitude, obj);*/
					}
					page.model.resultDataView.beginUpdate();
					page.model.resultDataView.setItems( $main.model.autoData, 'no');
					page.model.resultDataView.endUpdate();
					
					//$main.model.wtms = $main.model.autoData[0];
					
					
				}
			});
		};
		
		pub.getWh = function()
		{
			$.ajax({
				url:'/psupport/jsps/getWH.jsp',
				dataType:"text",
				success:function(result){
					var data = JSON.parse(result);
					for ( var i = 0; i < data.length; i++)
					{
						var stock = data[i]; 
						var wh = $main.model.getWhData(stock.WH_CODE)
						if(wh != undefined)
							wh.msgs.push(stock.MSG);
						else
						{
							wh = {}
							wh.WH_CODE = stock.WH_CODE;
							wh.msgs = [];
							wh.msgs.push(stock.MSG);
							$main.model.whList.push(wh);
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
		pub.getAlert = function()
		{
			$.ajax({
				url:'/psupport/jsps/getAlertXML.jsp',
				dataType:"text",
				success:function(result){
//					console.log("getAlertXML result : ",result)
					var data = JSON.parse(result);
					$main.model.alertData = data;
					$main.model.getWriteAlert(data);
					
					//$kecoMap.model.initFeatureLayer($main.model.alertData);
				},
				error:function(result){
				}
			});
		};
		pub.getAlertData = function(factcode, branchno)
		{
			for ( var i = 0; i < $main.model.alertData.length; i++) 
			{
				if( $main.model.alertData[i].FACT_CODE == factcode &&
					$main.model.alertData[i].BRANCH_NO == branchno )
				{
					return $main.model.alertData[i];
				}
			}
		};
		pub.getAllserene = function(sys)
		{
			if(sys != 'W')
			{
				$.ajax({
					url:'/psupport/jsps/getAutoXML.jsp?sys='+sys,
					dataType:"text",
					success:function(result){
						var data = JSON.parse(result);
//						console.log("data 결과",data);
						if(sys == 'U')
							$main.model.ipusnData = data;
						else
						{
							$main.model.autoData = data;
							$main.model.getAutoData("A");
						}
					},
					error:function(result){
						var data = JSON.parse(result);
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
						$main.model.tmsData = data;
					},
					error:function(result){
						var data = JSON.parse(result);
					}
				});
			}
		};
		
		pub.getCheckData = function(type, factcode, branchno)
		{
			var data = undefined;
			
			if(type == 'U')
				data = $main.model.ipusnData;
			else if(type == 'A')
				data = $main.model.autoData;
			else
				data = $main.model.tmsData;
			
			for ( var i = 0; i < data.length; i++) 
			{
				var obj = data[i];
				
				if(obj.FACT_CODE == factcode && obj.BRANCH_NO == branchno)
				{
					if(obj.ALAM != undefined && obj.ALAM.length > 0)
					{
						var alams = obj.ALAM.split(',');
						obj.ALAM = '';
						
						for ( var j = 0; j < alams.length; j++) 
						{
							obj.ALAM = obj.ALAM+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+alams[j] +'<br>';
						}
					}
					
					return obj;
				}
			}
			return undefined;
		};
		
		/*pub.getAccident = function()
		{
			var today = new Date();
			
			var yday = today.getFullYear()-1 + addzero(today.getMonth()+1) + addzero(today.getDate());
			var today = today.getFullYear()+ addzero(today.getMonth()+1) +addzero(today.getDate());
				
			if(user_riverid != undefined && user_riverid != 'null')
				url = '/psupport/jsps/getAccidentXML.jsp?searchRiverDiv='+user_riverid+'&searchWpKind=all&searchSupportKind=all&startDate='+yday+'&endDate='+today; 
			else 
				url = '/psupport/jsps/getAccidentXML.jsp?searchRiverDiv=all&searchWpKind=all&searchSupportKind=all&startDate='+yday+'&endDate='+today;
			
			var type
			$.ajax({
				url: url,
					dataType: 'text',
				success: function(data) {
					data = xml2json.parser(data);
					
					$main.model.accidentData = [];
					
					for ( var i = 0; i < data.accidents.accident.length; i++) 
					{
						if(data.accidents.accident[i].wpsstep != 'END' )
						{
							var obj = data.accidents.accident[i];
							
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
							
							$main.model.accidentData.push(obj);
							
							if(obj.longitude != undefined && obj.latitude != undefined)
								$kecoMap.model.addMarker(type, obj.longitude, obj.latitude, obj);
						}
					}
				}
			});
		};*/
		
		pub.resultGrid = undefined;
		pub.resultDataView = undefined;
		
		pub.accidentGrid = undefined;
		pub.accidentDataView = undefined;
		
		pub.tmsGrid = undefined;
		pub.tmsDataView = undefined;
		
		pub.reloadData = function(){
			showLoading();
			page.model.resultDataView.setItems([]);
		
			
			var sys = page.view.system.val();
			var sugye = page.view.sugye.val();
			var gongku = page.view.factCode.val();
			
			var d = new Date();
			var today = leadingZeros(d.getFullYear(), 4)+leadingZeros(d.getMonth() + 1, 2)+leadingZeros(d.getDate(), 2);
			var ftime = leadingZeros(d.getHours() - 1, 2) + '00';
			var ttime = leadingZeros(d.getHours(), 2) + '59';
			
			if(sys == 'U' || sys == 'A')
			{
				var chukjeongso = 'all';
				var frDate = today;
				var toDate = today;
				var frTime = ftime;
				var toTime = ttime;
				var valid = 'all';
				var minor = 'all';
				var orderType1 = 'desc';
				var rType = 'all';
				var pageNo = 1;
				var branchNo  = page.view.branch_no.val();
				
				if(sys == 'U')
				{
					chukjeongso = page.view.branch_no.val();
				}
				
				$.ajax({
					
					type:"post",
					url:'/waterpolmnt/waterinfo/getDetailViewRIVER.do',
					data:{sugye:sugye, 
							gongku:gongku,
							chukjeongso:chukjeongso,
							frDate:frDate,
							mainPageUnit:100000,
							toDate:toDate,
							frTime:frTime,
							toTime:toTime,
							branchNo:branchNo,
							sys:sys,
							valid:valid,
							minor:minor,
							pageIndex:pageNo,
							dataType:rType,
							orderType1:orderType1,
							item:'all'
						},
					dataType:"json",
					async:true,
					success:function(result){
						
						if(result.detailViewList.length > 0)
							$("#slickNullSearch").hide();
						else {
							$("#slickNullSearch").text("조회 결과가 없습니다.")
							$("#slickNullSearch").show();
						}
						
						for ( var i = 0; i < result.detailViewList.length; i++) 
							result.detailViewList[i].no = i+1;
						
						page.model.resultDataView.beginUpdate();
						page.model.resultDataView.setItems(result.detailViewList, 'no');
						page.model.resultDataView.endUpdate();
						
						closeLoading();
						result = '';
					},
					
				});
			}
			else
			{
				var branchNo = 'all';
				var frDate = today;
				var toDate = today;
				
				var item1=item2=item3=item4=item5=item6=item7="x";
				
				item1 = "PHY";
				item2 = "BOD";
				item3 = "COD";
				item4 = "SUS";
				item5 = "TON";
				item6 = "TOP";
				item7 = "FLW";
				
				pageNo = 1;
				var rType = $("#dataType").val();
				
				$.ajax({
					type:'post',
					url:'/waterpolmnt/waterinfo/getDetailViewDISCHARGE.do',
					data:{sugye:sugye, 
							gongku:gongku,
							chukjeongso:branchNo,
							frDate:frDate,
							toDate:toDate,
							frTime:ftime,
							toTime:ttime,
							//sys:sys,
							item01:item1,
							item02:item2,
							item03:item3,
							item04:item4,
							item05:item5,
							item06:item6,
							item07:item7,
							pageIndex:pageNo,
							dataType:'2'},
					dataType:"json",
					async:true,
					success:function(result){
						if(result.detailViewList.length > 0)
							$("#slickNullSearch").hide();
						else {
							$("#slickNullSearch").text("조회 결과가 없습니다.")
							$("#slickNullSearch").show();
						}
						
						for ( var i = 0; i < result.detailViewList.length; i++) 
							result.detailViewList[i].no = i+1;
						
						page.model.resultDataView.beginUpdate();
						page.model.resultDataView.setItems(result.detailViewList, 'no');
						page.model.resultDataView.endUpdate();
						closeLoading();
						result = '';
					},
					
				});
			}
			
			if(btToggle_flag)
				$('#resultToggle').trigger('click');
		};
		
		
		pub.reloadDataForFact = function(factCode, rvCd, bNo){
			showLoading();
			page.model.resultDataView.setItems([]);
		
			
			var sys = page.view.system.val();
			var sugye = 'all'; //page.view.sugye.val();
			if(rvCd !=null){
				sugye = rvCd;
			}
			var gongku = factCode; //''; //page.view.factCode.val();
			
			var d = new Date();
			var today = leadingZeros(d.getFullYear(), 4)+leadingZeros(d.getMonth() + 1, 2)+leadingZeros(d.getDate(), 2);
			var ftime = leadingZeros(d.getHours() - 1, 2) + '00';
			var ttime = leadingZeros(d.getHours(), 2) + '59';
			
			if(sys == 'U' || sys == 'A')
			{
				var chukjeongso = 'all';
				var frDate = today;
				var toDate = today;
				var frTime = ftime;
				var toTime = ttime;
				var valid = 'all';
				var minor = 'all';
				var orderType1 = 'desc';
				var rType = 'all';
				var pageNo = 1;
				var branchNo  = 'all'; //page.view.branch_no.val();
				if(bNo != null){
					branchNo  = bNo; //page.view.branch_no.val();
				}
				$.ajax({
					
					type:"post",
					url:'/waterpolmnt/waterinfo/getDetailViewRIVER.do',
					data:{sugye:sugye, 
							gongku:gongku,
							chukjeongso:chukjeongso,
							frDate:frDate,
							mainPageUnit:100000,
							toDate:toDate,
							frTime:frTime,
							toTime:toTime,
							branchNo:branchNo,
							sys:sys,
							valid:valid,
							minor:minor,
							pageIndex:pageNo,
							dataType:rType,
							orderType1:orderType1,
							item:'all'
						},
					dataType:"json",
					async:true,
					success:function(result){
						
						if(result.detailViewList.length > 0)
							$("#slickNullSearch").hide();
						else {
							$("#slickNullSearch").text("조회 결과가 없습니다.")
							$("#slickNullSearch").show();
						}
						
						for ( var i = 0; i < result.detailViewList.length; i++) 
							result.detailViewList[i].no = i+1;
						
						page.model.resultDataView.beginUpdate();
						page.model.resultDataView.setItems(result.detailViewList, 'no');
						page.model.resultDataView.endUpdate();
						
						closeLoading();
						result = '';
					},
					
				});
			}
			else
			{
				var branchNo = 'all';
				var frDate = today;
				var toDate = today;
				
				var item1=item2=item3=item4=item5=item6=item7="x";
				
				item1 = "PHY";
				item2 = "BOD";
				item3 = "COD";
				item4 = "SUS";
				item5 = "TON";
				item6 = "TOP";
				item7 = "FLW";
				
				pageNo = 1;
				var rType = $("#dataType").val();
				
				$.ajax({
					type:'post',
					url:'/waterpolmnt/waterinfo/getDetailViewDISCHARGE.do',
					data:{sugye:sugye, 
							gongku:gongku,
							chukjeongso:branchNo,
							frDate:frDate,
							toDate:toDate,
							frTime:ftime,
							toTime:ttime,
							//sys:sys,
							item01:item1,
							item02:item2,
							item03:item3,
							item04:item4,
							item05:item5,
							item06:item6,
							item07:item7,
							pageIndex:pageNo,
							dataType:'2'},
					dataType:"json",
					async:true,
					success:function(result){
						if(result.detailViewList.length > 0)
							$("#slickNullSearch").hide();
						else {
							$("#slickNullSearch").text("조회 결과가 없습니다.")
							$("#slickNullSearch").show();
						}
						
						for ( var i = 0; i < result.detailViewList.length; i++) 
							result.detailViewList[i].no = i+1;
						
						page.model.resultDataView.beginUpdate();
						page.model.resultDataView.setItems(result.detailViewList, 'no');
						page.model.resultDataView.endUpdate();
						closeLoading();
						result = '';
					},
					
				});
			}
			
			if(btToggle_flag)
				$('#resultToggle').trigger('click');
		};
		
		pub.writeResultGrid = function(data)
		{
			
		};
		
		// 유형 검색
		pub.searchCategory = function()
		{
			showLoading();
			
			var excess = page.view.excessChk.attr('checked');
			if(excess != undefined)
				excess = true;
			
			var sugye		= page.view.sugyeThemeSel.val();
			var themeItem	= page.view.themeItemSel.val();
			
			$kecoMap.model.searchTheme(sugye, themeItem, this.searchThemeCallBack);
		};
		
		pub.themeList = [];
		
		pub.searchThemeCallBack = function(result)
		{
			var html = '';
			
			if(result == undefined || result.features.length < 0)
			{
				html = '<ul><li class="tit">검색결과가 없습니다.</li></ul>';
			}
			else
			{
				$main.model.themeList = result.features;
				
				var ilabel =parseInt($main.view.themeItemSel.val());
				
				$('#'+ilabel).attr('checked', 'true');
				$kecoMap.model.updateLayerVisibility();
				
				if(ilabel < 29)
					ilabel = '시설명';
				else if(ilabel > 28 && ilabel < 32 )
					ilabel = '단지명';
				else if(ilabel == 32 )
					ilabel = '매립장명';
				else if(ilabel == 34)
					ilabel = '취수장명';
				else if(ilabel == 35)
					ilabel = '정수장명';
				
				for ( var i = 0; i < result.features.length; i++)
				{
					var obj = result.features[i].attributes;
					html = html +'<ul onclick="$main.model.showThemeBuffer(\''+i+'\')">';
					html = html +'<li class="tit">'+obj[ilabel]+'</li>';
					html = html +'<li >'+obj['주소']+'</li>';
					html = html +'</ul>';
				}
			}	edddxdd
			
			$main.view.resultCount.html('총 '+result.features.length+'건');
			$main.view.resultBx.html(html);
			closeLoading();
		};
		// 테마로 이동
		pub.showThemeBuffer = function(idx)
		{
			var obj = this.themeList[idx];
			var distances = page.view.rangeSel.val();
			$kecoMap.model.showThemeBuffer(obj.geometry , distances);
		};
		// 사고 지점 조회
//		pub.getAccident = function()
//		{
//			$.ajax({
//				url: '/psupport/jsps/getAccidentXML.jsp',
//				dataType: 'text',
//				success: function(data) {
//					
//					data = xml2json.parser(data);
//					
//					for ( var i = 0; i < data.accidents.accident.length; i++) {
//						data.accidents.accident[i].no = i;
//					}
//					console.log(data);
//					
//					page.view.accidentDataView.beginUpdate();
//					page.view.accidentDataView.setItems(data.accidents.accident, 'no');
//					page.view.accidentDataView.endUpdate();
//					page.view.accidentDataView.refresh();
//					
//				}
//			});
//		};
		pub.getTotalMnt = function(){
			
			$.ajax({
				url:'/waterpollution/getAlertCnt2.do',
				dataType:"text",
				success:function(result){
					var result = JSON.parse(result.toUpperCase());
					result = result.WATERPOLLUTIONSEARCHVOLIST;
//					console.log('[알림 카운트]', result);
					
					for(var i=0; i < result.length; i++){
						
						var obj = result[i];
						obj.river_div = 'All';
						if(page.model['totalMnt'+obj.river_div] == undefined)
							page.model['totalMnt'+obj.river_div] = {};
						
						if(obj.SYS_KIND == "U") {
							page.model['totalMnt'+obj.river_div].u = obj;
							page.model['totalMnt'+obj.river_div].u.total = obj.CNT1;
						} else if(obj.SYS_KIND == "T") {
							page.model['totalMnt'+obj.river_div].t = obj;
							page.model['totalMnt'+obj.river_div].t.total = obj.CNT1;
						} else if(obj.SYS_KIND == "A") {
							page.model['totalMnt'+obj.river_div].a = obj;
							page.model['totalMnt'+obj.river_div].a.total = obj.CNT1
						}
					}
					page.model.writeTotalMnt('All');
					
				},
				error:function(error){
//					console.log('[경보현황 서버에러]', error)
//					var today = new Date();
//
//					var item = "<strong>[ 서버 접속 실패 : " + today.getFullYear() + "-" + today.getMonth() + "-" + 
//									today.getDate() + " " + today.getHours() + ":" + today.getMinutes() + " ]</strong>";
//					$("#currDate").html(item);
				}
			});
		};
		
		pub.getWaterPollutionStatus = function(){
			
			var searchDate = $("#wateryear").val() + $("#watermonth").val() + $("#waterday").val();
			
			$.ajax({
				url:'/waterpollution/getWaterPollutionStatus.do?startDate=' + searchDate,
				dataType:"text",
				success:function(result){
					var startDate = $("#wateryear").val() + $("#watermonth").val() + $("#waterday").val();
					var result = JSON.parse(result.toUpperCase());
					result = result.WATERPOLLUTIONVOLIST[0];
					var end = Number(result.END_N) + Number(result.END_Y);
					var html = "■ 신고 : <a href='#' onclick=\"goMenu('/waterpollution/waterPollutionList.do?startDate="+startDate+"&endDate="+startDate+"','32120');return false;\">" + result.STA + "</a>";
					html = html +" ■ 접수 : <a href='#' onclick=\"goMenu('/waterpollution/waterPollutionList.do?startDate="+startDate+"&endDate="+startDate+"','32120');return false;\">" + result.RCV + "</a>";
					html = html +" ■ 수습중 : <a href='#' onclick=\"goMenu('/waterpollution/waterPollutionList.do?startDate="+result.STARTDATE+"&endDate="+startDate+"','32120');return false;\">" + result.ING + "</a>";
					html = html +" ■ 조치완료 : <a href='#' onclick=\"goMenu('/waterpollution/waterPollutionList.do?startDate="+startDate+"&endDate="+startDate+"','32120');return false;\">" + String(end) + "</a>";
					$("#waterContent").html(html);
				},
				error:function(error){
				}
			});
			
			$.ajax({
				url:'/waterpollution/getWaterPollutionStatusList.do?startDate=' + searchDate,
				dataType:"text",
				success:function(result){
					var startDate = $("#wateryear").val() + $("#watermonth").val() + $("#waterday").val();
					var result = JSON.parse(result.toUpperCase());
					result = result.WATERPOLLUTIONVOLIST;
					
					var html = ""; 
					var obj;
					if(result != undefined){
						for(var i=0; i<result.length;i++){
							obj = result[i];
							html += "<tr>";
							switch(obj.RIVERDIV){
								case "R01" : html += "<td align='center'>한강</td>"; break;
								case "R02": html += "<td align='center'>낙동강</td>"; break;
								case "R03": html += "<td align='center'>금강</td>"; break;
								case "R04": html += "<td align='center'>영산강</td>"; break;
								default : html += "<td align='center'>계</td>"; break;
							}
							html = html +"<td align='center'><a href='#' onclick=\"goMenu('/waterpollution/waterPollutionList.do?startDate="+startDate+"&endDate="+startDate+"' ,'32120');return false;\">" + obj.STA + "</a></td>";
							html = html +"<td align='center'><a href='#' onclick=\"goMenu('/waterpollution/waterPollutionList.do?startDate="+startDate+"&endDate="+startDate+"' ,'32120');return false;\">" + obj.RCV + "</a></td>";
							html = html +"<td align='center'><a href='#' onclick=\"goMenu('/waterpollution/waterPollutionList.do?startDate="+obj.STARTDATE+"&endDate="+startDate+"' ,'32120');return false;\">" + obj.ING + "</a></td>";
							html = html + "<td align='center'><a href='#' onclick=\"goMenu('/waterpollution/waterPollutionList.do?startDate="+obj.STARTDATE+"&endDate="+startDate+"' ,'32120');return false;\">" + obj.END_N + "</a></td>";
							html = html +"<td align='center'><a href='#' onclick=\"goMenu('/waterpollution/waterPollutionList.do?startDate="+obj.STARTDATE+"&endDate="+startDate+"' ,'32120');return false;\">" + obj.END_Y + "</a></td>";
							html = html +"</tr>"
						}
					}
					$("#waterlistContent").html(html);
				},
				error:function(error){
				}
			});
		};
		
		pub.getWaterPollutionStatusdisplay = function(){
			var status = $("#waterListTable").css("display");
			if(status == "block"){
				$("#waterListTable").css("display","none");
				$("#waterListButton").html("펼쳐보기 ▼");
			}else{
				$("#waterListTable").css("display","block");
				$("#waterListButton").html("접기 ▲");
			}
		}
		
		pub.getAlertListStatusdisplay = function(){
			var status = $("#alertListTable").css("display");
			if(status == "block"){
				$("#alertListTable").css("display","none");				
			}else{
				$("#alertListTable").css("display","block");				
			}
		}
		
//		
//		// 4대강 경보발령 현황조회
//		pub.totalMntR01 = undefined;
//		pub.totalMntR02 = undefined;
//		pub.totalMntR03 = undefined;
//		pub.totalMntR04 = undefined;
//		
//		pub.getTotalMnt = function(){
//
//			$.ajax({
//				type:"post",
//				url:'/waterpolmnt/situationctl/getTotalMntMainTopTS.do',
//				dataType:"json",
//				success:function(result){
//					var tot	 = result['totalData'].length;
//					
//					for(var i=0; i < tot; i++){
//						
//						var obj = result['totalData'][i];
//						if(page.model['totalMnt'+obj.river_div] == undefined)
//							page.model['totalMnt'+obj.river_div] = {};
//						if(obj.sys_kind == "U") {
//							page.model['totalMnt'+obj.river_div].u = obj;
//							page.model['totalMnt'+obj.river_div].u.total = parseInt(obj.normal)+parseInt(obj.interest)+parseInt(obj.caution)+parseInt(obj.alert)+parseInt(obj.over)+parseInt(obj.norecv);
//						} else if(obj.sys_kind == "T") {
//							page.model['totalMnt'+obj.river_div].t = obj;
//							page.model['totalMnt'+obj.river_div].t.total = parseInt(obj.normal)+parseInt(obj.alert)+parseInt(obj.norecv);
//						} else if(obj.sys_kind == "A") {
//							page.model['totalMnt'+obj.river_div].a = obj;
//							page.model['totalMnt'+obj.river_div].a.total = parseInt(obj.normal)+parseInt(obj.interest)+parseInt(obj.caution)+parseInt(obj.alert)+parseInt(obj.over)+parseInt(obj.norecv);
//						}
//					}
//					page.model.writeTotalMnt('All');
//					
//				},
//				error:function(error){
//					console.log('[경호현황 서버에러]', error)
////					var today = new Date();
////
////					var item = "<strong>[ 서버 접속 실패 : " + today.getFullYear() + "-" + today.getMonth() + "-" + 
////									today.getDate() + " " + today.getHours() + ":" + today.getMinutes() + " ]</strong>";
////					$("#currDate").html(item);
//				 }
//			});
//
//			
//		};
//		
//		// 4대강 경보현황 세팅
		pub.writeTotalMnt = function(rflag)
		{
//			if(rflag == 'All')
//			{
//				this['totalMntAll'] = {
//										u:{total:0,normal:0,interest:0,caution:0,alert:0,over:0,norecv:0},
//										a:{total:0,normal:0,interest:0,caution:0,alert:0,over:0,norecv:0}
//									};
//				
//				for(var i=1; i<5; i++)
//				{
//					var ffix = 'u'; 
//					
//					for(var j=0; j<2; j++)
//					{
//						if(j == 1)
//							ffix = 'a';
//							
//						this['totalMntAll'][ffix].total	+= parseInt( this['totalMntR0'+i][ffix].total);
//						this['totalMntAll'][ffix].normal	+= parseInt( this['totalMntR0'+i][ffix].normal);
//						this['totalMntAll'][ffix].interest	+= parseInt( this['totalMntR0'+i][ffix].interest);
//						this['totalMntAll'][ffix].caution	+= parseInt( this['totalMntR0'+i][ffix].caution);
//						this['totalMntAll'][ffix].alert	+= parseInt( this['totalMntR0'+i][ffix].alert);
//						this['totalMntAll'][ffix].over		+= parseInt( this['totalMntR0'+i][ffix].over);
//						this['totalMntAll'][ffix].norecv	+= parseInt( this['totalMntR0'+i][ffix].norecv);
//					}
//				}
//			}
			var ffix = 'u'; 
			
			for(var i=0; i<2; i++)
			{
				if(i == 1)
					ffix = 'a';
				page.view['total'+ffix].text(this['totalMnt'+rflag][ffix].CNT1);
				page.view['normal'+ffix].text(this['totalMnt'+rflag][ffix].CNT2);
				page.view['interest'+ffix].text(this['totalMnt'+rflag][ffix].A1);
				page.view['caution'+ffix].text(this['totalMnt'+rflag][ffix].A2);
				//alert(this['totalMnt'+rflag][ffix].CNT4 + "/" + this['totalMnt'+rflag][ffix].CNT5 + "/" + this['totalMnt'+rflag][ffix].CNT6)
				if(i == 1) {
					page.view['alert'+ffix].text(this['totalMnt'+rflag][ffix].A3);
					page.view['over'+ffix].text(this['totalMnt'+rflag][ffix].A4);
					page.view['check'+ffix].text(this['totalMnt'+rflag][ffix].CNT4);
					page.view['test'+ffix].text(this['totalMnt'+rflag][ffix].CNT5);
					page.view['stop'+ffix].text(this['totalMnt'+rflag][ffix].CNT6);
				} else {
					page.view['alert'+ffix].text('-');
					page.view['over'+ffix].text('-');
				}
				
				page.view['norecv'+ffix].text(this['totalMnt'+rflag][ffix].M);
			}
			
			ffix = 't';
			test1 = this['totalMnt'+rflag][ffix].A1;
			test2 = this['totalMnt'+rflag][ffix].A2;
			test3 = this['totalMnt'+rflag][ffix].A3;
			test4 = this['totalMnt'+rflag][ffix].A4;
				
			page.view['total'+ffix].text(this['totalMnt'+rflag][ffix].CNT1);
			page.view['normal'+ffix].text(this['totalMnt'+rflag][ffix].CNT2);
			page.view['interest'+ffix].text(this['totalMnt'+rflag][ffix].A1);
			page.view['caution'+ffix].text(this['totalMnt'+rflag][ffix].A2);
			page.view['alert'+ffix].text(this['totalMnt'+rflag][ffix].A3);
			page.view['over'+ffix].text(this['totalMnt'+rflag][ffix].A4);
			page.view['norecv'+ffix].text(this['totalMnt'+rflag][ffix].M);
			page.view['cnt'+ffix].html("수질TMS<br/>(" +this['totalMnt'+rflag][ffix].CNT3 + " 개소)");
			
			
		};
		
		// 경보 현황 조회
		pub.getWriteAlert = function(data)
		{
			var html = '';
			var html2 = '';
			for ( var i = 0; i < data.length; i++) 
			{
				var obj = data[i];
				if(obj.ALERT_LEVEL == '1')
					obj.LEVEL_TEXT = '관심';
				else if(obj.ALERT_LEVEL == '2')
					obj.LEVEL_TEXT = '주의';
				else if(obj.ALERT_LEVEL == '3')
					obj.LEVEL_TEXT = '경계';
				else if(obj.ALERT_LEVEL == '4')
					obj.LEVEL_TEXT = '심각';
				else if(obj.ALERT_LEVEL == 'M')
					obj.LEVEL_TEXT = '미수신';
				else if(obj.ALERT_LEVEL == 'C')
					obj.LEVEL_TEXT = '점검중';
				else if(obj.ALERT_LEVEL == 'L')
					obj.LEVEL_TEXT = '위치이탈';
				
				if(obj.SYS_KIND == 'A')
					obj.SYS_KIND_TEXT = '국가수질자동측정망';
				else if(obj.SYS_KIND == 'U')
					obj.SYS_KIND_TEXT = '이동형측정기기';
				
//				var fact = $main.model.getCheckData('A', obj.FACT_CODE, obj.BRANCH_NO);
				
//				if(fact != undefined)
//				{
//				obj.RIVER_NAME = fact.RIVER_NAME;
//				obj.FACT_NAME = fact.FACTNAME;
//				}
				html += '<li style="cursor:pointer;">'
						+ '<span class="txtinfo">경보현황 -> 측정장비 : '+obj.SYS_KIND_TEXT+' </span>'
						+ '<span class="txtinfo">수신시간 : '+obj.ALERT_TIME+' </span>'
						+ '<span class="txtinfo">단계 : '+obj.LEVEL_TEXT+' </span>'
						+ '<span class="txtinfo">수계 : '+obj.RIVER_NAME+' </span>'
						+ '<span class="txtinfo">측정소 : '+obj.FACT_NAME+' </span>'
						+ '<span class="txtinfo">경보내용 : '+obj.ALERT_MSG+' </span>'
						+ '</li> ';
				
				html2 += '<tr>'
				+ '<td scope="col" align = "center">'+obj.SYS_KIND_TEXT+'</th>'
				+ '<td scope="col" >'+obj.ALERT_TIME+'</td>'
				+ '<td scope="col" align = "center">'+obj.LEVEL_TEXT+'</td>'
				+ '<td scope="col" align = "center">'+obj.RIVER_NAME+'</td>'
				+ '<td scope="col" align = "center">'+obj.FACT_NAME+'</td>'
				+ '<td scope="col" align = "center"> - </td>'
				+ '<td scope="col" align = "center"> - </td>'
				+ '<td scope="col" >'+obj.ALERT_MSG+'</td>'
				+'</tr>'			
			}
			
			$main.view.alertInfo.html(html);
			$main.view.alertInfoList.html(html2);
		};
		
		pub.setResultGridInit = function(sys)
		{
			$('#resultDiv').html();
			
				this.resultDataView = new Slick.Data.DataView();
				
				var columns = [
								{ id: "no", name: "NO", field: "no", width: 45, sortable: true },
								{ id: "river_name", name: "수계", field: "RIVER_NAME", width: 60, sortable: true },
								{ id: "factname", name: "측정소", field: "FACTNAME", width: 100, sortable: true },								
								{ id: "strtime", name: "수집시간", field: "STRTIME", width: 100, sortable: true },
								{ id: "tur", name: "탁도(측정값)", field: "TUR", width: 100, sortable: true },
								{ id: "turl", name: "탁도(기준치)", field: "TURL", width: 100, sortable: true },
								{ id: "phy", name: "pH(측정값)", field: "PHY", width: 100, sortable: true },								
								{ id: "phyl", name: "pH(기준치)", field: "PHYL", width: 100, sortable: true },
								{ id: "dow", name: "DO(측정값)", field: "DOW", width: 100, sortable: true },								
								{ id: "dowl", name: "DO(기준치)", field: "DOWL", width: 100, sortable: true },
								{ id: "con", name: "EC(측정값)", field: "CON", width: 100, sortable: true },								
								{ id: "conl", name: "EC(기준치)", field: "CONL", width: 100, sortable: true },
								{ id: "tmp", name: "수온", field: "TMP", width: 100, sortable: true },
								{ id: "alarm", name: "메시지", field: "ALARM", width: 100, sortable: true }
							];
				var options = {
						enableColumnReorder: false,
						multiColumnSort: false,
						enableCellNavigation: true
				};
				
				this.resultGrid = new Slick.Grid("#resultDiv", this.resultDataView, columns, options);
				
			
			
			this.resultGrid.setSelectionModel(new Slick.RowSelectionModel());
			
			this.resultGrid.onSelectedRowsChanged.subscribe(function() { 
				page.model.resultGrid.resetActiveCell();
				var obj = page.model.resultGrid.getDataItem(page.model.resultGrid.getSelectedRows())
				
//				console.log('[ 선택]', obj);
				obj.FACT_CODE = obj.factcode;
				obj.BRANCH_NO = obj.branchno;
				
				var data = {};
				
				if(obj.sys_kind == 'A')
				{
					data = $main.model.getAutoData(obj);
				}
				else if(obj.sys_kind == 'U')
				{
					data = $main.model.getUSNData(obj);
				}
				else if(obj.sys_kind == 'W')
				{
					data = $main.model.getTmsData(obj);
				}
				
//				console.log('[선택 데이터]', data);
				
			/*	$kecoMap.view.map.setLevel(6);
				$kecoMap.model.moveCenter(data.geometry.x, data.geometry.y);*/
				
			});
			
			this.resultDataView.onRowCountChanged.subscribe(function (e, args) {
				page.model.resultGrid.updateRowCount();
				page.model.resultGrid.render();
			});
			
			this.resultDataView.onRowsChanged.subscribe(function (e, args) {
				page.model.resultGrid.invalidateRows(args.rows);
				page.model.resultGrid.render();
			});
			
			function comparer(a,b) {
				var x = a[sortcol], y = b[sortcol];
				
//				if(sortcol == 'rcv_date' || sortcol == 'fact_name' || sortcol == 'no')
					return (x == y ? 0 : (x > y ? 1 : -1));
//				else
//				{
//					x = parseFloat(x);
//					y = parseFloat(y);
//					if(isNaN(x) && isNaN(y))
//						return 0;
//					else if(isNaN(x))
//						return -1;
//					else if(isNaN(y))
//						return 1;
//						
//					return (x == y ? 0 : (x > y ? 1 : -1));
//				}
			}
			
			var sortcol = "";
			var sortdir = 1;
			
			this.resultGrid.onSort.subscribe(function(e, args) {
				
				sortdir = args.sortAsc ? 1 : -1;
				sortcol = args.sortCol.field;
				
				page.model.resultDataView.sort(comparer, args.sortAsc);
			});
		};
		
		pub.initAccidentGrid = function()
		{
			$('#accident_tab').html();
			
			this.accidentDataView = new Slick.Data.DataView();
			
			
			var columns = [
							{ id: "no", name: "NO", field: "no", width: 45, sortable: true, cssClass: "slick-pointer" },
							{ id: "receivedate", name: "접수일자", field: "receivedate", width: 100, sortable: true, cssClass: "slick-pointer" },
							{ id: "river_div", name: "수계", field: "river_name", width: 100, sortable: true, cssClass: "slick-pointer" },
							{ id: "wpkind", name: "사고유형", field: "wpkind", width: 90, sortable: true, cssClass: "slick-pointer" },
							{ id: "wpcontent", name: "사고내용", field: "wpcontent", width: 90, cssClass: "slick-pointer text-align-left" },
							{ id: "wpsstep", name: "방제현황", field: "wpsstep", width: 90, sortable: true, cssClass: "slick-pointer" },
							{ id: "supportkind", name: "지원", field: "supportkind", width: 100, sortable: true, cssClass: "slick-pointer" }
						];
			
			var options = {
					enableColumnReorder: false,
					enableCellNavigation: true,
					multiColumnSort: false
			};
			
			this.accidentGrid = new Slick.Grid("#accident_tab", this.accidentDataView, columns, options);
			
			
			this.accidentGrid.setSelectionModel(new Slick.RowSelectionModel());
			
			
			this.accidentGrid.onSelectedRowsChanged.subscribe(function() { 
				page.model.accidentGrid.resetActiveCell();
				var obj = page.model.accidentGrid.getDataItem(page.model.accidentGrid.getSelectedRows())
				page.model.accident = obj;
				
				page.model.GetFcode();
			});
			
			this.accidentDataView.onRowCountChanged.subscribe(function (e, args) {
				page.model.accidentGrid.updateRowCount();
				page.model.accidentGrid.render();
			});
			
			this.accidentDataView.onRowsChanged.subscribe(function (e, args) {
				page.model.accidentGrid.invalidateRows(args.rows);
				page.model.accidentGrid.render();
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
				
				console.log("page.view.accidentDataView : ",page.model.accidentDataView);
				page.model.accidentDataView.sort(comparer, args.sortAsc);
			});
			
			
		};
		
		pub.initTmsGrid = function()
		{
			$('#tms_tab').html();
			
			this.tmsDataView = new Slick.Data.DataView();
			
			
			var columns = [
							{ id: "no", name: "NO", field: "no", width: 45, sortable: true, cssClass: "slick-pointer" },
							{ id: "FACTNAME", name: "측정소", field: "FACTNAME", width: 100, sortable: true, cssClass: "slick-pointer" },
							{ id: "BRANCH_NO", name: "방류구", field: "BRANCH_NO", width: 50, sortable: true, cssClass: "slick-pointer" },
							{ id: "VALUE", name: "상태", field: "VALUE", width: 100, sortable: true, cssClass: "slick-pointer" }
							
						];
			
			var options = {
					enableColumnReorder: false,
					enableCellNavigation: true,
					multiColumnSort: false
			};
			
			this.tmsGrid = new Slick.Grid("#tms_tab", this.tmsDataView, columns, options);
			
			
			this.tmsGrid.setSelectionModel(new Slick.RowSelectionModel());
			
			
			this.tmsGrid.onSelectedRowsChanged.subscribe(function() { 
				page.model.tmsGrid.resetActiveCell();
				var obj = page.model.tmsGrid.getDataItem(page.model.tmsGrid.getSelectedRows())
				page.model.wtms = obj;
				
				page.model.GetFcode();
			});
			
			this.tmsDataView.onRowCountChanged.subscribe(function (e, args) {
				page.model.tmsGrid.updateRowCount();
				page.model.tmsGrid.render();
			});
			
			this.tmsDataView.onRowsChanged.subscribe(function (e, args) {
				page.model.tmsGrid.invalidateRows(args.rows);
				page.model.tmsGrid.render();
			});
			
			
			
			function comparer(a,b) {
				var x = a[sortcol], y = b[sortcol];
					return (x == y ? 0 : (x > y ? 1 : -1));
			}
			
			var sortcol = "";
			var sortdir = 1;
			
			this.tmsGrid.onSort.subscribe(function(e, args) {
				sortdir = args.sortAsc ? 1 : -1;
				sortcol = args.sortCol.field;
				
				console.log("page.view.tmsDataView : ",page.model.tmsDataView);
				page.model.tmsDataView.sort(comparer, args.sortAsc);
			});
			
			
		};
		
		pub.getMeasureQueryData = function()
		{
			var q = new esri.tasks.Query();
			q.returnGeometry = true;
			q.outFields = ["*"];
			if(user_riverid != undefined && user_riverid != 'null') {
				q.where = "OBJECTID < 10000 AND RV_CD = '"+user_riverid+"'";
				q.orderByFields = ["RV_CD"];
			}
			else {
				q.where = "OBJECTID < 10000";
				q.orderByFields = ["RV_CD"];
			}
			
			this.queryTask = new esri.tasks.QueryTask($define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/FeatureServer/1');
			
			this.queryTask.execute(q, function(result){
				$main.model.autoList = result.features;
			});
		};
		
		pub.getUSNQueryData = function()
		{
			var q = new esri.tasks.Query();
			q.returnGeometry = true;
			q.outFields = ["*"];
			if(user_riverid != undefined && user_riverid != 'null') {
				q.where = "OBJECTID < 10000 AND RV_CD = '"+user_riverid+"'";
				q.orderByFields = ["RV_CD"];
			}
			else {
				q.where = "OBJECTID < 10000";
				q.orderByFields = ["RV_CD"];
			}
			this.queryTask = new esri.tasks.QueryTask($define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/FeatureServer/2');
			this.queryTask.execute(q, function(result){
				$main.model.usnList = result.features;
			});
		};
		
		pub.getTmsQueryData = function()
		{
			var q = new esri.tasks.Query();
			q.returnGeometry = true;
			q.outFields = ["*"];
			if(user_riverid != undefined && user_riverid != 'null') {
			q.where = "OBJECTID < 10000 AND RV_CD = '"+user_riverid+"'";
			q.orderByFields = ["RV_CD"];
		}
		else {
			q.where = "OBJECTID < 10000";
			q.orderByFields = ["RV_CD"];
		}
			this.queryTask = new esri.tasks.QueryTask($define.ARC_SERVER_URL+'/rest/services/WPCS_EDIT/FeatureServer/4');
			this.queryTask.execute(q, function(result){
				$main.model.tmsList = result.features;
			});
		};
		
		pub.getAutoData = function(obj)
		{
			if(obj == undefined)
				return;
			
			for ( var i = 0; i < $main.model.autoList.length; i++) {
				var adata = $main.model.autoList[i].attributes;
				
				if(adata.FACT_CODE == obj.FACT_CODE && adata.BRANCH_NO == obj.BRANCH_NO)
					return $main.model.autoList[i];
			}
		};
		
		pub.getUSNData = function(obj)
		{
			if(obj == undefined)
				return;
			
			for ( var i = 0; i < $main.model.usnList.length; i++) {
				var adata = $main.model.usnList[i].attributes;
//				console.log("adata 체크 : ",adata);
				if(adata.FACT_CODE == obj.FACT_CODE && adata.BRANCH_NO == obj.BRANCH_NO)
					return $main.model.usnList[i];
			}
		};
		
		pub.getTmsData = function(obj)
		{
			if(obj == undefined)
				return;
			
			for ( var i = 0; i < $main.model.tmsList.length; i++) {
				var adata = $main.model.tmsList[i].attributes;
				
				if(adata.FACT_CODE == obj.FACT_CODE && adata.BRANCH_NO == obj.BRANCH_NO)
					return $main.model.tmsList[i];
			}
		};
		
		pub.timer = null;
		
		pub.roopType = 5; // 1, 2, 3 = 평시, 4 = 이상, 5 = 사고발생
		
		pub.cuIndex = -1;
		
		pub.cuidxArr = [];
		
		pub.isPlay = false;
		
		pub.play = function()
		{
			if(this.isPlay)
				return;
			
			if($main.model.roopType != 5 || $main.model.roopType != 4)
			{
				if($main.view.roopSysKindSel.val() == "null"){
					alert("측정소의 국각수질자동측정망이나  수질측정소_IPUSN이 선택 되어야 합니다.");
					return;
				}
			}
			
			if($main.model.roopType == 4)
			{
				if(!$('#ipLd').attr('checked') && !$('#autoLd').attr('checked')){
					alert("측정소의 국각수질자동측정망이나 수질측정소_IPUSN이 선택 되어야 합니다.");
					return;
				}
			}
			
			this.roopMonitor();
			this.timer = setInterval(this.roopMonitor, 5000);
			
			this.isPlay = true;
		};
		pub.stop = function()
		{
			this.isPlay = false;
			clearInterval(this.timer);
			$kecoMap.view.map.infoWindow.hide();
		};
		pub.next = function()
		{
			this.stop();
			this.roopMonitor();
		};
		pub.prevCnt = 2;
		
		pub.prev = function()
		{
			this.cuIndex = this.cuidxArr[this.cuidxArr.length-this.prevCnt]-1;
			if(this.cuIndex < 0)
				this.cuIndex = 0;
			
			this.prevCnt++;
			
			this.stop();
			this.roopMonitor(true);
		};
		pub.refresh = function()
		{
			this.stop();
			
			this.intervalEvent();
		};
		pub.roopMonitor = function(prevFlag)
		{
//			console.log("prevFlag : ", prevFlag);
			$kecoMap.view.map.infoWindow.hide();

			var return_flag = false;
			
			if($main.model.roopType == 5)
			{
				if($main.model.cuIndex+1 >= $main.model.accidentData.length) $main.model.cuIndex = -1;
				
				for ( var i = $main.model.cuIndex+1; i < $main.model.accidentData.length; i++) 
				{
					var wm = esri.geometry.geographicToWebMercator(new esri.geometry.Point($main.model.accidentData[i].longitude , $main.model.accidentData[i].latitude));
					
					$kecoMap.view.map.centerAt(wm);
					
					$main.model.cuIndex = i;
					
					setTimeout(function(){
						var point = new esri.geometry.ScreenPoint($kecoMap.view.map.width/2, $kecoMap.view.map.height/2);
						var graphic = new esri.Graphic(undefined, undefined);
						graphic.setAttributes($main.model.accidentData[i]);
						
						graphic.setInfoTemplate(new esri.InfoTemplate(EVENT_TEMP));
						
						$kecoMap.view.map.infoWindow.setContent(graphic.getContent());
						$kecoMap.view.map.infoWindow.setTitle(graphic.getTitle());
						$kecoMap.view.map.infoWindow.resize(250,200);
						$kecoMap.view.map.infoWindow.show(point,$kecoMap.view.map.getInfoWindowAnchor(point));
						
					}, 1000);
					
					if(!prevFlag)
					{
						if($main.model.cuidxArr[$main.model.cuidxArr.length-1] != $main.model.cuIndex)
							$main.model.cuidxArr.push(i);
					}
					return;
				}
			}
			else if($main.model.roopType == 4)
			{
				if($main.model.cuIndex+1 >= $main.model.alertData.length)
					$main.model.cuIndex = -1;
				
				for ( var i = $main.model.cuIndex+1; i < $main.model.alertData.length; i++) 
				{
					var alertData = $main.model.alertData[i];
					var adata = undefined;

					return_flag = $kecoMap.model.LayerAuthIn(alertData.FACT_CODE,alertData.BRANCH_NO,alertData.SYS_KIND);

					if(return_flag){ 
						if(!$('#autoLd').attr('checked')){
							if(alertData.SYS_KIND == 'A' ){
								$main.model.cuIndex = i;
								continue;
							}
						}
						
						if(!$('#ipLd').attr('checked')){
							if(alertData.SYS_KIND == 'U' ){
								$main.model.cuIndex = i;
								continue;
							}
						}
						
						if(alertData.SYS_KIND == 'A' )
							adata = $main.model.getAutoData(alertData);
						else if(alertData.SYS_KIND == 'T')
							adata = $main.model.getTmsData(alertData);
						else if(alertData.SYS_KIND == 'U')
							adata = $main.model.getUSNQueryData(alertData);
						
						var aChkData = $main.model.getCheckData(alertData.SYS_KIND, alertData.FACT_CODE, alertData.BRANCH_NO);
	//					console.log("adata======  : ", adata);
	//					var wm = esri.geometry.geographicToWebMercator(new esri.geometry.Point(adata.Y , adata.X));
						
						if(aChkData != undefined){
							if(aChkData.LONGITUDE != undefined){
								var wm = esri.geometry.geographicToWebMercator(new esri.geometry.Point(aChkData.LONGITUDE , aChkData.LATITUDE) );
							}
						}
						
						$kecoMap.view.map.centerAt(wm);
						
						$main.model.cuIndex = i;
						
						setTimeout(function(){
							var point = new esri.geometry.ScreenPoint($kecoMap.view.map.width/2, $kecoMap.view.map.height/2);
							var graphic = new esri.Graphic(undefined, undefined);
							
							if(aChkData != undefined)
							{
								aChkData.ALERT_MSG = alertData.ALERT_MSG;
								graphic.setAttributes(aChkData);
	//							graphic.setAttributes(alertData);
								graphic.setInfoTemplate(new esri.InfoTemplate(AUTO_TEMP_ALERT));
								$kecoMap.view.map.infoWindow.resize(250,230);
								$kecoMap.view.map.infoWindow.setContent(graphic.getContent());
								$kecoMap.view.map.infoWindow.setTitle(graphic.getTitle());
								
								$kecoMap.view.map.infoWindow.show(point,$kecoMap.view.map.getInfoWindowAnchor(point));
							}
							
	//						adata에 값이 없어서 스크립트 에러가 발생  
							
	//						else
	//						{
	//							adata.attributes.ALERT_MSG = alertData.ALERT_MSG;
	//							
	//							adata.attributes.FACTNAME = adata.attributes.FACI_NM ;
	//							
	//							graphic.setAttributes(adata.attributes);
	//							graphic.setInfoTemplate(new esri.InfoTemplate(AUTO_TEMP_ALERT));
	//							$kecoMap.view.map.infoWindow.resize(250,230);
	//						}
							
						}, 1000);
						
						if(!prevFlag)
						{
							if($main.model.cuidxArr[$main.model.cuidxArr.length-1] != $main.model.cuIndex)
								$main.model.cuidxArr.push(i);
						}
						return;
					}
				}
			}
			else
			{
				
				if($main.view.roopSysKindSel.val() == "A"){
					
					if($main.model.cuIndex+1 >= $main.model.autoList.length)
						$main.model.cuIndex = -1;
					
					for ( var i = $main.model.cuIndex+1; i < $main.model.autoData.length; i++) 
					{
						var sereneData = $main.model.autoData[i];
						var adata = undefined;
						adata = $main.model.getAutoData(sereneData);

						return_flag = $kecoMap.model.LayerAuthIn(sereneData.FACT_CODE, sereneData.BRANCH_NO,sereneData.SYS_KIND);
						if(return_flag){ 
							
							var aChkData = $main.model.getCheckData(sereneData.SYS_KIND, sereneData.FACT_CODE, sereneData.BRANCH_NO);
	
							if(aChkData != undefined){
								if(aChkData.LONGITUDE != undefined){
									var wm = esri.geometry.geographicToWebMercator(new esri.geometry.Point(aChkData.LONGITUDE , aChkData.LATITUDE) );
								}
							}
							
							$kecoMap.view.map.centerAt(wm);
							
							$main.model.cuIndex = i;
							
							setTimeout(function(){
								var point = new esri.geometry.ScreenPoint($kecoMap.view.map.width/2, $kecoMap.view.map.height/2);
								var graphic = new esri.Graphic(undefined, undefined);
								graphic.setAttributes(aChkData);
								
								if(aChkData != undefined)
								{
									graphic.setInfoTemplate(new esri.InfoTemplate(AUTO_TEMP));
									$kecoMap.view.map.infoWindow.resize(250,210);
									$kecoMap.view.map.infoWindow.setContent(graphic.getContent());
									$kecoMap.view.map.infoWindow.setTitle(graphic.getTitle());
									
									$kecoMap.view.map.infoWindow.show(point,$kecoMap.view.map.getInfoWindowAnchor(point));
								}
	//							else
	//							{
	//								graphic.setAttributes(adata);
	//								graphic.setInfoTemplate(new esri.InfoTemplate(NULL_TEMP));
	//								$kecoMap.view.map.infoWindow.resize(250,100);
	//							}
								
							}, 1000);
							
							if(!prevFlag)
							{
								if($main.model.cuidxArr[$main.model.cuidxArr.length-1] != $main.model.cuIndex)
									$main.model.cuidxArr.push(i);
							}
							return;
						}
					}
				}
				else if($main.view.roopSysKindSel.val() == "U"){
					
					if($main.model.cuIndex+1 >= $main.model.usnList.length)
						$main.model.cuIndex = -1;
					for ( var i = $main.model.cuIndex+1; i < $main.model.ipusnData.length; i++) 
					{
						var sereneData = $main.model.ipusnData[i];
						var adata = undefined;
						adata = $main.model.getUSNData(sereneData);
						
						return_flag = $kecoMap.model.LayerAuthIn(sereneData.FACT_CODE, sereneData.BRANCH_NO,sereneData.SYS_KIND);
						if(return_flag){
							var aChkData = $main.model.getCheckData(sereneData.SYS_KIND, sereneData.FACT_CODE, sereneData.BRANCH_NO);
							
							if(aChkData != undefined){
								if(aChkData.LONGITUDE != undefined){
									var wm = esri.geometry.geographicToWebMercator(new esri.geometry.Point(aChkData.LONGITUDE , aChkData.LATITUDE) );
								}
							}
							
							$kecoMap.view.map.centerAt(wm);
							
							$main.model.cuIndex = i;
							
							setTimeout(function(){
								var point = new esri.geometry.ScreenPoint($kecoMap.view.map.width/2, $kecoMap.view.map.height/2);
								var graphic = new esri.Graphic(undefined, undefined);
								graphic.setAttributes(aChkData);
								
								if(aChkData != undefined)
								{
									graphic.setInfoTemplate(new esri.InfoTemplate(AUTO_TEMP));
									$kecoMap.view.map.infoWindow.resize(250,210);
									$kecoMap.view.map.infoWindow.setContent(graphic.getContent());
									$kecoMap.view.map.infoWindow.setTitle(graphic.getTitle());
									
									$kecoMap.view.map.infoWindow.show(point,$kecoMap.view.map.getInfoWindowAnchor(point));
								}
	//							else
	//							{
	//								graphic.setAttributes(adata);
	//								graphic.setInfoTemplate(new esri.InfoTemplate(NULL_TEMP));
	//								$kecoMap.view.map.infoWindow.resize(250,100);
	//							}
								
							}, 1000);
							
							if(!prevFlag)
							{
								if($main.model.cuidxArr[$main.model.cuidxArr.length-1] != $main.model.cuIndex)
									$main.model.cuidxArr.push(i);
							}
							return;
						}
					}
				}
				else {
					
					if($main.model.cuIndex+1 >= $main.model.autoData.length + $main.model.ipusnData.length)
						$main.model.cuIndex = -1;
					
					if($main.model.cuIndex+1 >= $main.model.autoData.length){
//						console.log("평시 usn");
						for ( var i = $main.model.cuIndex+1-$main.model.autoData.length; i < $main.model.autoData.length + $main.model.ipusnData.length; i++)
						{
							var sereneData = $main.model.ipusnData[i];
							var adata = undefined;
							
							adata = $main.model.getUSNData(sereneData);

							return_flag = $kecoMap.model.LayerAuthIn(sereneData.FACT_CODE, sereneData.BRANCH_NO,sereneData.SYS_KIND);
							if(return_flag){
								var aChkData = $main.model.getCheckData(sereneData.SYS_KIND, sereneData.FACT_CODE, sereneData.BRANCH_NO);
								var wm = esri.geometry.geographicToWebMercator(new esri.geometry.Point(adata.geometry.x , adata.geometry.y) );
								
								$kecoMap.view.map.centerAt(wm);
								
								$main.model.cuIndex = $main.model.autoData.length + i;
								
								setTimeout(function(){
									var point = new esri.geometry.ScreenPoint($kecoMap.view.map.width/2, $kecoMap.view.map.height/2);
									var graphic = new esri.Graphic(undefined, undefined);
									graphic.setAttributes(aChkData);
									
									if(aChkData != undefined)
									{
										graphic.setInfoTemplate(new esri.InfoTemplate(AUTO_TEMP));
										$kecoMap.view.map.infoWindow.resize(250,210);
										$kecoMap.view.map.infoWindow.setContent(graphic.getContent());
										$kecoMap.view.map.infoWindow.setTitle(graphic.getTitle());
										
										$kecoMap.view.map.infoWindow.show(point,$kecoMap.view.map.getInfoWindowAnchor(point));
									}
	//								else
	//								{
	//									graphic.setAttributes(adata);
	//									graphic.setInfoTemplate(new esri.InfoTemplate(NULL_TEMP));
	//									$kecoMap.view.map.infoWindow.resize(250,100);
	//								}
									
								}, 1000);
								
								if(!prevFlag)
								{
									if($main.model.cuidxArr[$main.model.cuidxArr.length-1] != $main.model.cuIndex)
										$main.model.cuidxArr.push($main.model.autoList.length + i);
								}
								return;
							}
						}
					}
					else {
//						console.log("평시 수질자동");
						for ( var i = $main.model.cuIndex+1; i < $main.model.autoData.length; i++) 
						{
							var sereneData = $main.model.autoData[i];
							var adata = undefined;
		//					var ageo = undefined;
							
		//					if(sereneData.SYS_KIND == 'A' ) {
								adata = $main.model.getAutoData(sereneData);
		//						ageo = adata.geometry;
		//					}
		//					else
		//						adata = $main.model.getUSNData(sereneData);

							return_flag = $kecoMap.model.LayerAuthIn(sereneData.FACT_CODE, sereneData.BRANCH_NO,sereneData.SYS_KIND);
							if(return_flag){
								var aChkData = $main.model.getCheckData(sereneData.SYS_KIND, sereneData.FACT_CODE, sereneData.BRANCH_NO);
	//							console.log("adata.geometry.x : ",adata.geometry.x);
	//							console.log("adata.geometry.y : ",adata.geometry.y);
								
								if(adata.geometry != null){
									var wm = esri.geometry.geographicToWebMercator(new esri.geometry.Point(adata.geometry.x , adata.geometry.y) );
									
									$kecoMap.view.map.centerAt(wm);
									$main.model.cuIndex = i;
									
									setTimeout(function(){
										var point = new esri.geometry.ScreenPoint($kecoMap.view.map.width/2, $kecoMap.view.map.height/2);
										var graphic = new esri.Graphic(undefined, undefined);
										graphic.setAttributes(aChkData);
										
										if(aChkData != undefined)
										{
											graphic.setInfoTemplate(new esri.InfoTemplate(AUTO_TEMP));
											$kecoMap.view.map.infoWindow.resize(250,210);
											$kecoMap.view.map.infoWindow.setContent(graphic.getContent());
											$kecoMap.view.map.infoWindow.setTitle(graphic.getTitle());
											
											$kecoMap.view.map.infoWindow.show(point,$kecoMap.view.map.getInfoWindowAnchor(point));
										}
										else
										{
											graphic.setAttributes(adata);
											graphic.setInfoTemplate(new esri.InfoTemplate(NULL_TEMP));
											$kecoMap.view.map.infoWindow.resize(250,100);
										}
										
									}, 1000);
									
									if(!prevFlag)
									{
										if($main.model.cuidxArr[$main.model.cuidxArr.length-1] != $main.model.cuIndex)
											$main.model.cuidxArr.push(i);
									}
									return;
								}
							}
						}
					}
				}
			}
			
//			$main.model.eventTest();
			
			/*
			if($main.model.features == null)
				return;
			
			var infoTemplate = new esri.InfoTemplate(TEMPLATJSON);

			$kecoMap.view.map.infoWindow.hide();
			
			for ( var i = $main.model.cuIndex+1; i < $main.model.features.length; i++) 
			{
				$main.model.features[i].setInfoTemplate(infoTemplate);
				
				if($main.model.roopType > 3)
				{
					if($main.model.roopType == $main.model.features[i].attributes.value)
					{
						var wm = esri.geometry.geographicToWebMercator($main.model.features[i].geometry);
						$kecoMap.view.map.centerAt(wm);
						
						$main.model.cuIndex = i;
						
						setTimeout(function(){
							var point = new esri.geometry.ScreenPoint($kecoMap.view.map.width/2, $kecoMap.view.map.height/2);
							$kecoMap.view.map.infoWindow.setContent($main.model.features[i].getContent());
							var title = $main.model.features[i].getTitle();
							$kecoMap.view.map.infoWindow.setTitle(title);
							$kecoMap.view.map.infoWindow.show(point,$kecoMap.view.map.getInfoWindowAnchor(point));
							
						}, 1000);
						
						if(!prevFlag)
						{
							if($main.model.cuidxArr[$main.model.cuidxArr.length-1] != $main.model.cuIndex)
								$main.model.cuidxArr.push(i);
						}
						return;
					}
					continue;
				}
				else
				{
					var wm = esri.geometry.geographicToWebMercator($main.model.features[i].geometry);
					$kecoMap.view.map.centerAt(wm);
					
					$main.model.cuIndex = i;
					
					setTimeout(function(){
						var point = new esri.geometry.ScreenPoint($kecoMap.view.map.width/2, $kecoMap.view.map.height/2);
						$kecoMap.view.map.infoWindow.setContent($main.model.features[i].getContent());
						var title = $main.model.features[i].getTitle();
						$kecoMap.view.map.infoWindow.setTitle(title);
						$kecoMap.view.map.infoWindow.show(point,$kecoMap.view.map.getInfoWindowAnchor(point));
						
					}, 1000);
					
					if(!prevFlag)
					{
						if($main.model.cuidxArr[$main.model.cuidxArr.length-1] != $main.model.cuIndex)
							$main.model.cuidxArr.push(i);
					}
					return;
				}
			}
			*/
			$main.model.cuIndex = -1;
			$main.model.cuidxArr = [];
			$main.model.prevCnt = 2;
		}
		
		pub.excelDown = function () {
			var sys = page.view.system.val();
			var sugye = page.view.sugye.val();
			var gongku = page.view.factCode.val();
			
			var d = new Date();
			var today = leadingZeros(d.getFullYear(), 4)+leadingZeros(d.getMonth() + 1, 2)+leadingZeros(d.getDate(), 2);
			var frTime = leadingZeros(d.getHours() - 1, 2) + '00';
			var toTime = leadingZeros(d.getHours(), 2) + '59';
			
			if(sys == 'A' || sys == 'U')
			{
				var chukjeongso = 'all';
				var toDate = today;
				var frDate = today;
				var valid = 'all';
				var minor = "all";
				var rType = '2';
				
				var param = "sugye=" + sugye + "&gongku=" + gongku + "&chukjeongso=" + chukjeongso +
					"&frDate=" + frDate + "&toDate=" + toDate + "&frTime=" + frTime + "&toTime=" + toTime + 
					"&sys=" + sys + 
					"&minor=" + minor +
					"&valid=" + valid +
					"&dataType=" + rType;
					
				location.href='/waterpolmnt/waterinfo/getExcelDetalViewRIVER.do?'+param;
			}
			else 
			{
				var bangryu = 'all';
				var frDate = today;
				var toDate = today;
				var item1=item2=item3=item4=item5=item6=item7="x";
				
				item1 = "PHY";
				item2 = "BOD";
				item3 = "COD";
				item4 = "SUS";
				item5 = "TON";
				item6 = "TOP";
				item7 = "FLW";
				
				var rType = '2';
				
				var param = "sugye=" + sugye + "&gongku=" + gongku + "&bangryu=" + bangryu +
					"&frDate=" + frDate + "&toDate=" + toDate + "&frTime=" + frTime + "&toTime=" + toTime + 
					"&item01=" + item1 + "&item02=" + item2 + "&item03=" + item3 + "&item04=" + item4 + "&item05=" + item5 +
					"&item06=" + item6 + "&item07=" + item7 +
					"&dataType=" + rType;
				
				location.href='/waterpolmnt/waterinfo/getExcelDetalViewDISCHARGE.do?'+param;
			}
			
		}
		
		pub.roopMonitorPlay = function () {
			if($main.model.accidentData.length > 0) {
				page.view.radiobutton3.attr('checked',true);
				if(page.model.roopType != 5)
				{
					page.model.cuIndex = -1;
					page.model.cuidxArr = [];
					page.model.prevCnt = 2;
				}
				$main.model.roopType = 5; // 1, 2, 3 = 평시, 4 = 이상, 5 = 사고발생
			} else if ($main.model.alertData.length > 0) {
				page.view.radiobutton2.attr('checked',true);
				if(page.model.roopType != 4)
				{
					page.model.cuIndex = -1;
					page.model.cuidxArr = [];
					page.model.prevCnt = 2;
				}
				$main.model.roopType = 4; // 1, 2, 3 = 평시, 4 = 이상, 5 = 사고발생
			} else{
				$main.model.roopType = 3; // 1, 2, 3 = 평시, 4 = 이상, 5 = 사고발생
				page.view.radiobutton1.attr('checked',true);
			}
//			this.roopMonitor();
			//$main.model.play();
		}
		
		pub.init = function() {
			this.setResultGridInit('A');
			this.initAccidentGrid();
			this.initTmsGrid();
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
		
		pub.accidentGrid	= undefined;
		pub.accidentDataView = undefined;
		
		pub.tmsGrid	= undefined;
		pub.tmsDataView = undefined;
		
		pub.totalu			= $('#totalu', page.dom);
		pub.normalu			= $('#normalu', page.dom);
		pub.interestu		= $('#interestu', page.dom);
		pub.cautionu		= $('#cautionu', page.dom);
		pub.alertu			= $('#alertu', page.dom);
		pub.overu			= $('#overu', page.dom);
		pub.norecvu			= $('#norecvu', page.dom);
		
		pub.totala			= $('#totala', page.dom);
		pub.normala			= $('#normala', page.dom);
		pub.interesta		= $('#interesta', page.dom);
		pub.cautiona		= $('#cautiona', page.dom);
		pub.alerta			= $('#alerta', page.dom);
		pub.overa			= $('#overa', page.dom);
		pub.norecva			= $('#norecva', page.dom);
		pub.checka			= $('#checka', page.dom);
		pub.testa			= $('#testa', page.dom);
		pub.stopa			= $('#stopa', page.dom);
		
		pub.totalt			= $('#totalt', page.dom);
		pub.normalt			= $('#normalt', page.dom);
		pub.interestt		= $('#interestt', page.dom);
		pub.cautiont		= $('#cautiont', page.dom);
		pub.alertt			= $('#alertt', page.dom);
		pub.overt			= $('#overt', page.dom);
		pub.norecvt			= $('#norecvt', page.dom);
		pub.cntt			= $('#cntt', page.dom); 
		
		pub.alertInfo		= $('#rolling', page.dom);
		
		pub.alertInfoList	= $('#alertlistContent', page.dom);
		
		pub.system			= $('#system', page.dom);
		pub.sugye			= $('#sugye', page.dom);
		pub.factCode		= $('#factCode', page.dom);
		pub.branch_no		= $('#branch_no', page.dom);
		
		pub.radiobutton1	= $("#radiobutton1", page.dom);
		pub.radiobutton2	= $("#radiobutton2", page.dom);
		pub.radiobutton3	= $("#radiobutton3", page.dom);
		
		pub.radiobutton4	= $("#radiobutton4", page.dom);
		pub.radiobutton5	= $("#radiobutton5", page.dom);
		pub.radiobutton6	= $("#radiobutton6", page.dom);
		
			
		pub.excelDnBtn		= $('#excelDnBtn', page.dom);
		
		pub.sugyeThemeSel	= $('#sugyeThemeSel', page.dom);
		pub.themeSel		= $('#themeSel', page.dom);
		pub.themeItemSel	= $('#themeItemSel', page.dom);
		
		pub.searBtn			= $('#searBtn', page.dom);
		pub.excessChk		= $('#excessChk', page.dom);
		pub.resultBx		= $('#resultBx', page.dom);
		pub.resultCount		= $('#resultCount', page.dom);
		pub.rangeSel		= $('#rangeSel', page.dom);
		
		pub.roopSysKindSel	= $('#roopSysKindSel', page.dom);
		
		/*pub.initAccidentGrid = function()
		{
			this.accidentDataView = new Slick.Data.DataView();
			
			var columns = [
							{ id: "start_date", name: "Date", field: "start_date", width: 100 },
							{ id: "addr", name: "사고위치", field: "addr", width: 100 },
							{ id: "type", name: "사고유형", field: "type", width: 90 },
							{ id: "status", name: "방제현황", field: "status", width: 90 },
							{ id: "acct_act_content", name: "사고내용", field: "acct_act_content", width: 100 }
						];
			var options = {
					enableColumnReorder: false,
					enableCellNavigation: true,
					multiColumnSort: false
			};
			
			this.accidentGrid = new Slick.Grid("#accident_tab", this.accidentDataView, columns, options);
			
			this.accidentGrid.setSelectionModel(new Slick.RowSelectionModel());
			
			this.accidentGrid.onSelectedRowsChanged.subscribe(function() { 
				page.model.accidentGrid.resetActiveCell();
				var obj = page.model.accidentGrid.getDataItem(page.view.accidentGrid.getSelectedRows());
//				console.log('[선택]', obj);
//				factClick(undefined,obj.fact_code);
			});
			
			// wire up model events to drive the grid
			this.accidentDataView.onRowCountChanged.subscribe(function (e, args) {
				page.model.accidentGrid.updateRowCount();
				page.model.accidentGrid.render();
			});
			
			this.accidentDataView.onRowsChanged.subscribe(function (e, args) {
				page.model.accidentGrid.invalidateRows(args.rows);
				page.model.accidentGrid.render();
			});
		};*/
		
		// View 초기화
		pub.init = function() {
			
//			this.initAccidentGrid();
			
			var html = '<option value="R01">한강</option>';
			html += '<option value="R02">낙동강</option>';
			html += '<option value="R03">금강</option>';
			html += '<option value="R04">영산강</option>';
			
			page.view.sugyeThemeSel.html(html);
		};
		
		pub.sugyeChange = function(){
			var system = page.view.system.val();
			page.model.setResultGridInit(system);
			
			$("#slickNullSearch").text("측정소를 조회하세요.")
			$("#slickNullSearch").show();
			
			if(system != null){
				$.getJSON('/waterpolmnt/waterinfo/getSugyeList.do', {system:system} , function (data, status){
					if(status == 'success'){
						var html = "";
						for(var i=0 ; i<data.List.length; i++)
						{
							html += '<option value="'+data.List[i].VALUE+'">'+data.List[i].CAPTION+'</option>'
						}
						page.view.sugye.html(html);
						pub.factCodeChange();
					} else { 
						alert("공구 목록 가져오기 실패");
						return;
					}
				});
			}
		};
		
		pub.factCodeChange = function(){
			var system = page.view.system.val();
			if(system == 'all')
				return;
			
			if(system == 'U'){
				$("#noipusnselect").css("display","none");
				$("#ipusnselect").css("display","");
			}
			else{
				$("#noipusnselect").css("display","");
				$("#ipusnselect").css("display","none");
			}
			
			if( page.view.sugye.val() == 'all'){// || sys_kind == 'all' ){
				page.view.factCode.attr("disabled", true);
				$("#factCode>option:first").attr("selected", "true");
				
			}else
			{
				page.view.factCode.attr("disabled", false);
				
				if(system == 'A' || system == 'U')
				{
					page.view.factCode.attr("disabled", false);
					$.getJSON('/waterpolmnt/waterinfo/getGongkuList.do',
						{sugye:page.view.sugye.val(), system:system},
						function (data, status){
							if(status == 'success'){
								var html = '<option value="all">전체</option>'
								
								for(var i=0 ; i<data.gongku.length; i++)
								{
									if(system == 'U')
									{
										html = html +'<option value="'+data.gongku[i].BRANCH_NO+'">'+data.gongku[i].CAPTION+'</option>'
									}else{
										html = html +'<option value="'+data.gongku[i].VALUE+'">'+data.gongku[i].CAPTION+'</option>'
									}
								}
								if(system == 'U')
								{
									page.view.factCode.html('<option value="'+ data.gongku[i-1].VALUE +'">' + data.gongku[i-1].CAPTION + '</option>');
									page.view.branch_no.html(html);
								}else{
									page.view.factCode.html(html);
								}
							} else { 
								alert("공구 목록 가져오기 실패");
								return;
							}
					});
				}
				else
				{
					$.getJSON('/waterpolmnt/waterinfo/getTMSList.do',
						{sugye:page.view.sugye.val()}, 
						function (data, status){
							if(status == 'success')
							{
								var html = '<option value="all">전체</option>'
								
								for(var i=0 ; i<data.tms.length; i++)
								{
									html = html +'<option value="'+data.tms[i].VALUE+'">'+data.tms[i].CAPTION+'</option>'
								}
								page.view.factCode.html(html);
							} 
							else 
							{ 
								alert("공구 목록 가져오기 실패");
								return;
							}
					});
				}
				
				$("#factCode>option:first").attr("selected", "true");
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
			
			$.getJSON('/waterpolmnt/waterinfo/getSystemList.do', null , function (data, status){
				if(status == 'success'){
					var html = "";
					for(var i=0 ; i<data.List.length; i++)
					{
						html += '<option value="'+data.List[i].VALUE+'">'+data.List[i].CAPTION+'</option>'
					}
					page.view.system.html(html);
					page.view.sugyeChange();
				} else { 
					alert("공구 목록 가져오기 실패");
					return;
				}
			});
			
			page.view.system.on('change', function(){
				page.view.sugyeChange();
			});
			
			page.view.sugye.on('change', function(){
				page.view.factCodeChange();
			});
			page.model.getAccident();
			page.model.getTmsList();
			page.model.getAutoTmsList();
			
			page.view.radiobutton1.on('click', function(evt){
				if(page.model.roopType != 1)
				{
					page.model.cuIndex = -1;
					page.model.cuidxArr = [];
					page.model.prevCnt = 2;
				}
				page.model.roopType = 1; // 1, 2, 3 = 평시, 4 = 이상, 5 = 사고발생
			});
			page.view.radiobutton2.on('click', function(evt){
				if(page.model.roopType != 4)
				{
					page.model.cuIndex = -1;
					page.model.cuidxArr = [];
					page.model.prevCnt = 2;
				}
				page.model.roopType = 4; // 1, 2, 3 = 평시, 4 = 이상, 5 = 사고발생
			});
			page.view.radiobutton3.on('click', function(evt){
				if(page.model.roopType != 5)
				{
					page.model.cuIndex = -1;
					page.model.cuidxArr = [];
					page.model.prevCnt = 2;
				}
				page.model.roopType = 5; // 1, 2, 3 = 평시, 4 = 이상, 5 = 사고발생
			});
			
			page.view.radiobutton4.on('click', function(evt){
				if(page.model.roopType != 1)
				{
					page.model.cuIndex = -1;
					page.model.cuidxArr = [];
					page.model.prevCnt = 2;
				}
				page.model.roopType = 1; // 1, 2, 3 = 평시, 4 = 이상, 5 = 사고발생
			});
			page.view.radiobutton5.on('click', function(evt){
				if(page.model.roopType != 4)
				{
					page.model.cuIndex = -1;
					page.model.cuidxArr = [];
					page.model.prevCnt = 2;
				}
				page.model.roopType = 4; // 1, 2, 3 = 평시, 4 = 이상, 5 = 사고발생
			});
			page.view.radiobutton6.on('click', function(evt){
				if(page.model.roopType != 5)
				{
					page.model.cuIndex = -1;
					page.model.cuidxArr = [];
					page.model.prevCnt = 2;
				}
				page.model.roopType = 5; // 1, 2, 3 = 평시, 4 = 이상, 5 = 사고발생
			});
			page.view.excelDnBtn.on('click', function(evt){
				page.model.excelDown();
			});
			page.view.themeSel.on('change', function(evt){
				var theme = page.view.themeSel.val();
				var html = '';
				
				if(theme == '1')
				{
					html =  '<option value="20">농공단지폐수종말처리시설</option>'+
							'<option value="21">기타공동처리시설</option>'+
							'<option value="22">분뇨처리시설</option>'+
							'<option value="23">산업폐수종말처리시설</option>'+
							'<option value="24">매립장침출수처리시설</option>'+
							'<option value="25">축산폐수공공처리시설</option>'+
							'<option value="26">마을하수도</option>'+
							'<option value="27">하수종말처리시설</option>';
				}
				else if(theme == '2')
				{
					html =  '<option value="29">국가산업단지</option>'+
							'<option value="30">일반산업단지</option>'+
							'<option value="31">농공단지</option>'+
							'<option value="32">매립장</option>';
				}
				else
				{
					html =  '<option value="34">취수장</option>'+
							'<option value="35">정수장</option>';
				}
				page.view.themeItemSel.html(html);
			});
			page.view.searBtn.on('click', function(evt){
				page.model.searchCategory();
			});
			//page.model.getAllserene("A");
			//page.model.getAutoData("A");
//			page.model.getDetailRiverAlert();
			page.model.getTotalMnt();
			page.model.getWaterPollutionStatus();
			
			page.view.system.trigger('change');
			/*
			setTimeout(function(){
				page.model.roopMonitorPlay();
			}, 3000);
			*/
		};
		return pub;
	}());
	
	$main = page;
	
	page.controller.init();
	
});

function showLoading()
{
	$("#loadingDiv").dialog({
		modal:true,
		open:function() 
		{
			$("#loadingDiv").css("visibility","visible");
			$(this).parents(".ui-dialog:first").find(".ui-dialog-titlebar-close").hide();
			$(this).parents(".ui-dialog:first").find(".ui-dialog-titlebar").hide();
			$(this).parents(".ui-dialog:first").find(".ui-dialog-resizing").hide();
			$(this).parents(".ui-dialog:first").find(".ui-dialog-buttonpane").hide();
			$(this).parents(".ui-dialog:first").find(".ui-dialog-dragging").hide();
			$(this).parents(".ui-dialog:first").css("width", "85px");
			$(this).parents(".ui-dialog:first").css("height", "75px");
			$(this).parents(".ui-dialog:first").css("overflow", "hidden");
			$("#loadingDiv").css("float", "left");
		},
		width:120,
		height:120,
		showCaption:false,
		resizable:false
	});
	
	$("#loadingDiv").dialog("open");
}

function closeLoading()
{
	$("#loadingDiv").dialog("close");
}