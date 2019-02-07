<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

	
<%-- 	<sec:authorize ifNotGranted="ROLE_USER"> --%>
<!-- 		<script  type='text/javascript'> -->
<!-- 			alert('로그인이 필요한 페이지 입니다'); -->
<%-- 			window.location = "<c:url value='/'/>";  --%>
<!-- 		</script>  -->
<%-- 	</sec:authorize> --%>
	
	
	<sec:authorize ifAnyGranted="ROLE_USER">
		<script  type='text/javascript'>
			var user_dept_no = '<sec:authentication property="principal.userVO.deptNo"/>';
		</script> 
	</sec:authorize>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
	<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />	
	<script src="<c:url value='/js/JQuery/jquery-1.3.2.min.js'/>" type="text/javascript"></script>
	<script src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js'/>" type="text/javascript"></script>
	<script src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js'/>" type="text/javascript"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>	
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.datepicker.js'/>"></script>
	
<script type='text/javascript'>
//<![CDATA[
           
  	var frDate = "${searchTaksuVO.frDate}";
	var toDate = "${searchTaksuVO.toDate}";
	var frTime = "${searchTaksuVO.frTime}";
	var toTime = "${searchTaksuVO.toTime}";

	var fact = "${searchTaksuVO.gongku}";
	var sugye = "${searchTaksuVO.sugye}";

	var item_1 = "${searchTaksuVO.item01}";
	var item_2 = "${searchTaksuVO.item02}";
	var item_3 = "${searchTaksuVO.item03}";
	var item_4 = "${searchTaksuVO.item04}";
	
$(function () {
	
	$("#sugye>option[value='"+sugye+"']").attr("selected", "selected");
	
	set_User_deptNo(user_dept_no, "sugye");

	$.datepicker.setDefaults({
	    monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
	    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	    showMonthAfterYear:true,
	    dateFormat: 'yy/mm/dd',
	    showOn: 'both',
	    buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
	    buttonImageOnly: true
	});
	$("#startDate").datepicker({
	    buttonText: '시작일'
	    
	});
	$("#endDate").datepicker({
	    buttonText: '종료일'
	});
			
	var today = new Date(); 
	var yday = new Date(Date.parse(today) - 1 * 1000 * 60 * 60 * 12);

	yday = yday.getFullYear()+ "/" + addzero(yday.getMonth()+1) +"/" + addzero(yday.getDate());
	today = today.getFullYear()+ "/" + addzero(today.getMonth()+1) + "/" + addzero(today.getDate());

	function addzero(n) {
		 return n < 10 ? "0" + n : n + "";
	}

	if(frDate != "" && frTime != "")
	{
		$("#startDate").val(frDate);
		$("#frTime>option[value='"+frTime+"']").attr("selected", "selected");
	}
	else
	{
		$("#startDate").val(yday);
	}

	if(toDate != "" && toTime != "")
	{
		$("#endDate").val(toDate);
		$("#toTime>option[value='"+toTime+"']").attr("selected", "selected");
	}
	else
	{
		$("#endDate").val(today);
	}

	adjustGongku();

  	$('#sugye')
  	.change(function(){
  		adjustGongku();
  	});

  	$('#factCode')
  	.change(function(){
  		setGraphBtn();
  	});
  	
	$("#dataList tr:odd").attr("class","add");

	reloadData();

	$("#legend").hide();
	$("#legendDetail").hide();

	//맵 처음 로드시 zoom
	firstZoom = 11;
});
	
	//측정소가 전체가 아닐때만 그래프 버튼이 표시됩니다.
	function setGraphBtn()
	{ 
		 if($('#factCode').val() == "all")
	        {
		        $('#a_chartPopup').attr("href", "#");
		        $('#img_chartPopup').hide();
	        }
	        else
	        {
	        	$('#a_chartPopup').attr("href","javascript:chartPopup()");
	        	$('#img_chartPopup').fadeIn('fast');
	        }
	}
	
	function adjustGongku()
	{
		var sugyeCd = '';//$('#sugye').val();
		
		var dropDownSet = $('#factCode');

		if( sugyeCd == 'all' ){
			dropDownSet.attr("disabled", true);
			$("#factCode>option:first").attr("selected", "true");
		}else{
			dropDownSet.attr("disabled", false);
			$.getJSON("<c:url value='/waterpolmnt/waterinfo/getWLFact.do'/>", 
					{sugye:'all'}, function (data, status){
			     if(status == 'success'){     
			        //locId 객체에 SELECT 옵션내용 추가.
			        dropDownSet.loadSelect_all(data.gongku);
										
					$("#factCode>option[value='"+fact+"']").attr("selected", "selected");	
					setGraphBtn();
					//adjustBranch();

			     } else { 
			    	 alert("공구 목록 가져오기 실패");
			        return;
			     }
			});
		}		
	}

	function excelDown() {

		if( validation() == false ) return;

		var sugye = $("#sugye").val();
		var gongku = $("#factCode").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
	    var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();

		var rType = $("#dataType").val();
		
        var param = "sugye=" + sugye + "&gongku=" + gongku +
         "&frDate=" + frDate + "&toDate=" + toDate + "&frTime=" + frTime + "&toTime=" + toTime + 
		 "&dataType=" + rType
            
		location.href="<c:url value='/waterpolmnt/waterinfo/getWLExcel.do'/>?"+param;
	}

	function chartPopup() {
		if( validation() == false ) return;

		var sugye = $("#sugye").val();
		var gongku = $("#factCode").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
	    var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();

		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 500;
		var winWidth = 680;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-20;
		var height = winHeight-20;
		

		var rType = $("#dataType").val();
		
        var param = "sugye=" + sugye + "&gongku=" + gongku + 
         "&frDate=" + frDate + "&toDate=" + toDate + "&frTime=" + frTime + "&toTime=" + toTime + 
		 "&dataType=" + rType + "&width=" + (winWidth-20) + "&height=" + (winHeight-40);

		 //stats/getAccidentStatsChart.do
		window.open("<c:url value='/waterpolmnt/waterinfo/getWLChart_popup.do'/>?"+encodeURI(param), 
				'chartDetailViewRIVER','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}

	
	function reloadData(pageNo){

		showLoading(); 

		if( validation() == false ) return;

		var sugye = $("#sugye").val();
		var gongku = $("#factCode").val();
		var sys = $("#sys").val();

		if(gongku == null || gongku == "unknowned")
			gongku = "all";
		if(sugye == null || sugye == "unknowned")
			sugye = "all";
		
		//$("#dataList").html("<tr><td colspan='7'>데이터를 불러오는 중 입니다...</td></td>");
		
		var rType = $("#dataType").val();

		if (pageNo == null) pageNo = 1;

		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/waterpolmnt/waterinfo/getWLData.do'/>",
			data: {gongku:gongku,
					  sugye:sugye,
					  frTime:frTime,
					  toTime:toTime,
					  frDate:frDate,
					  toDate:toDate,
					  pageIndex:pageNo
				},	
			dataType:"json",
			beforeSend : function(){
				//$("#dataList").html("");
				//$("#dataList").html("<tr><td colspan='7'>데이터를 불러오는 중 입니다...</td></tr>");	
				},				
			success : function(result){

				var tot = result['detailViewList'].length;
				var pageInfo = result['paginationInfo'];
				
				if( tot <= 0 ){
	            	$("#dataList").html("<tr><td colspan='4'>조회 결과 없음</td></tr>");
	            	 closeLoading();
	            }else{
	            	$("#dataList").html("");
	                for(var i=0; i < tot; i++){
	                    var obj = result['detailViewList'][i];
						var item;

						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;

	                   	item = "<tr style='cursor:hand' onclick='factClick("+i+", \""+obj.fact_code+"\")'>" 
								+"<td class='num'><span>"+no+"</span></td>"
		                 		+"<td>"+obj.fact_name+"</td>"
		                 		+"<td>"+obj.rcv_date+"</td>"
		                 		+"<td class='num'><span>" + ((obj.value != null && obj.value != '') ? obj.value : '-') + "</span></td>"
	                 		 	+"</tr>";

	              		$("#dataList").append(item);

	              		if(i == 0)
	              		{
		              		factClick(0, obj.fact_code);
	              		}
	              		//$("#dataList tr:odd").attr("class","add");
	                }
	            }

	            // 페이징 정보
	            var pageStr = makePaginationInfo(result['paginationInfo']);
	            $("#pagination").empty();
	            $("#pagination").append(pageStr);	       

	            $("#p_total_cnt").html("총 " + result['totCnt'] + "건");     	
	
	            closeLoading();
			}
		});

		//document.listFrm.action = "<c:url value='/waterpolmnt/waterinfo/getWLData.do'/>";

		 //document.listFrm.submit();
	}    

	function validation(){
		if( $('#startDate').val() == "" ){ alert("조회 시작일자를 선택하세요"); return false; }
		if( $('#endDate').val() == "" ){ alert("조회 종료일자를 선택하세요"); return false; }
	}

	function commonWork() {
		var stdt = document.getElementById("startDate");
		var endt = document.getElementById("endDate");

		if(endt.value != '' && stdt.value > endt.value) {
			alert("종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			stdt.value = "";
			endt.value = "";
			stdt.focus();
		}
	} 

	// 페이지 번호 클릭	
	function linkPage(pageNo){
		reloadData(pageNo);				    
	} 


	//측정소 클릭시
	function factClick(idx, factCode)
	{
		$("#dataList tr").attr("class", "");
		$("#dataList tr:nth(" + idx + ")").attr("class","add");

		chart(factCode);
		mapMove(factCode);
	}

	var lastLatitude = 0;
	var lastLongitude = 0;
	function mapMove(factCode)
	{
		$.getJSON("<c:url value='/waterpolmnt/waterinfo/getWLFactLocation.do'/>", {fact_code:factCode}, function (data, status){
		     if(status == 'success'){     

		    	 if(data['location'] == null)
		    	 {
		    		 $("#lblLocation").text("측정소 위치 (위치정보를 가져올 수 없습니다) ");
		    		 return;
		    	 }
		    	 
		    	 lastLatitude = data['location'].latitude;
		    	 lastLongitude = data['location'].longitude;
			     
		    	 mov3(data['location'].latitude, data['location'].longitude);
		     } else { 
			     alert('위치정보를 가져올 수 없습니다.');
		        return;
		     }
		});
	}
	
	function chart_load()
	{
		$("#span_loading").css("display", "none");
	}

	
	function chart(factCode){

		$("#span_loading").show();
		
		var width = "480";
		var height = "230";

		document.listFrm.target = "chart";

		document.listFrm.gongku.value = factCode;
		document.listFrm.width.value = width;
		document.listFrm.height.value = height;
			
		document.listFrm.action = "<c:url value='/waterpolmnt/waterinfo/getWLChart.do'/>";
		
		document.listFrm.submit();
	}

	var slideFlag = false;
	function slide()
	{
		if(!slideFlag)
		{
			$("#data_graph").css("height", "0px");
			$("#data_map").css("height", "501px");
			$("#pendingBtn").attr("src","<c:url value='/images/popup/btn_arrow_up.gif'/>");
			slideFlag = true;	

			var zm = gmap.getZoom();
			if(lastLatitude != 0)
				initialize2(zm);

			//mov2level(lastLatitude + "," +  lastLongitude + ", " + "12");
		}
		else
		{
			$("#data_graph").css("height", "230px");
			$("#data_map").css("height", "271px");
			$("#pendingBtn").attr("src","<c:url value='/images/popup/btn_arrow_down.gif'/>");
			slideFlag = false;

			var zm = gmap.getZoom();
			if(lastLatitude != 0)
				initialize2(zm);

			//mov2level(lastLatitude + "," +  lastLongitude + ", " + "12");
		}
	}

	function initialize2(zm) {
		//Load Google Maps
	      gmap = new GMap2(document.getElementById("gmap"));
		  gmap.setMapType(G_HYBRID_MAP);//G_NORMAL_MAP, G_SATELLITE_MAP, G_HYBRID_MAP, G_PHYSICAL_MAP
		  gmap.addMapType(G_PHYSICAL_MAP);
		  //gmap.addControl(new GLargeMapControl());
	      var topRight = new GControlPosition(G_ANCHOR_TOP_RIGHT, new GSize(5,5));
	      gmap.addControl(new GMenuMapTypeControl(),topRight);
	      //gmap.addControl(new GOverviewMapControl());
	      gmap.setCenter(new GLatLng(lastLatitude,lastLongitude),zm);
	      gmap.enableScrollWheelZoom();

	      //create custom dynamic layer
	      //esri.arcgis.gmaps.DynamicMapServiceLayer(url,esri.arcgis.gmaps.ImageParameters?,opacity?,callback?);
	      dynamicMap = new esri.arcgis.gmaps.DynamicMapServiceLayer("http://"+hostIP+"/rest/services/test1/MapServer", null, 0.75, dynmapcallback);
	      geocoder = new GClientGeocoder();
	      
	      
	      layers=dynamicMap.getVisibleLayers() ;
		  
		  mapExtension = new esri.arcgis.gmaps.MapExtension(gmap);
		  identifyTask = new esri.arcgis.gmaps.IdentifyTask("http://"+hostIP+"/rest/services/test1/MapServer");
		  GEvent.addListener(gmap, "click", identify);

		  getAreaMoveDisable(34.07086232376631,125.70556640625,38.58252615935333,129.55078125);
		  getAreaLevelDisable(7,15);

	      
	      executeQueryinit();

	    }
//]]>
</script>
</head>
<body>
<div id='loadingDiv' style="visibility:hidden;position:absolute;">
	<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="" />
</div>
<div id="wrap">
	<div id="header">
		<c:import url="/common/menu/header.do" />
	</div><!-- //header -->
	<div id="container">
		<!-- 사이드 리스트 -->
		<div id="snb" class="snb">
			<c:import url="/common/menu/left.do" />
		</div>
		<!-- //사이드 리스트 -->
		<!-- navi 리스트 -->
		<div>
			<c:import url="/common/menu/navi.do" />
		</div>
		<!-- //navi 리스트 -->
	
	<!-- 그래프 데이터 전달용 Form -->			
		<!-- content -->
		<div id="content" class="sub_waterpolmnt">
			<div class="content_wrap page_waterinfo">
				<div class="inner_waterlvlflux">
					<!-- 수위,유량 조회 -->
					<div class="search_all_wrap">
						<form:form commandName="searchTaksuVO" name="listFrm"  id="listFrm" method="post">		
							<input type="hidden" name="pageIndex" id="pageIndex" value="${searchTaksuVO.pageIndex}"/>	
							<input type="hidden" name="chukjeongso" id="chukjeongso"/>
							<input type="hidden" name="width"/>
							<input type="hidden" name="height"/>
							<input type="hidden" name="gongku" id="gongku"/>
							<input type="hidden" name="sugye" id="river_div"/>
							<input type="hidden" id="sugye" value="all"/>
							<div class="btnInBox">
									<dl>
								<!-- 
								<dt><img src="../../../images/content/tit_search_branch.gif" alt="측정소" /></dt>
								<dd>
									<select class="fixWidth7" id="sugye">
										<option value="R01">한강</option>
										<option value="R02">낙동강</option>
										<option value="R03">금강</option>
										<option value="R04">영산강</option>
									</select>
									<span>&gt;</span>
									<select class="fixWidth11" id="factCode">
										<option value="all">전체</option>
									</select>
								</dd>
								 -->
								<dt><img src="<c:url value='/images/content/tit_search_branch.gif'/>" alt="측정소" /></dt>
								<dd>
									<select class="fixWidth10" id="factCode">
										<option value="all">전체</option>
									</select>
								</dd>
								<dt><img src="<c:url value='/images/content/tit_search_date.gif'/>" alt="조회기간" /></dt>
									<dd class="time">
										<input type="text" class="inputText"  id="startDate" name="frDate" onchange="commonWork()" size="15" readonly="readonly"/>
										<select id="frTime" name="frTime" style="width:50px">
												<option value="00">00</option>
												<option value="01">01</option>
												<option value="02">02</option>
												<option value="03">03</option>
												<option value="04">04</option>
												<option value="05">05</option>
												<option value="06">06</option>
												<option value="07">07</option>
												<option value="08">08</option>
												<option value="09">09</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
												<option value="13">13</option>
												<option value="14">14</option>
												<option value="15">15</option>
												<option value="16">16</option>
												<option value="17">17</option>
												<option value="18">18</option>
												<option value="19">19</option>
												<option value="20">20</option>
												<option value="21">21</option>
												<option value="22">22</option>
												<option value="23">23</option>
											</select><span>시</span>
										<span>~</span>
										<input type="text" class="inputText" id="endDate" name="toDate" onchange="commonWork()" size="15" readonly="readonly"/>
											<select id="toTime" name="toTime" style="width:50px">
												<option value="00">00</option>
												<option value="01">01</option>
												<option value="02">02</option>
												<option value="03">03</option>
												<option value="04">04</option>
												<option value="05">05</option>
												<option value="06">06</option>
												<option value="07">07</option>
												<option value="08">08</option>
												<option value="09">09</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
												<option value="13">13</option>
												<option value="14">14</option>
												<option value="15">15</option>
												<option value="16">16</option>
												<option value="17">17</option>
												<option value="18">18</option>
												<option value="19">19</option>
												<option value="20">20</option>
												<option value="21">21</option>
												<option value="22">22</option>
												<option value="23" selected="selected">23</option>
											</select><span>시</span>
									</dd>
								</dl>
								<dl style="display:none">
									<dt>소항목</dt>
									<dd>
										<ul class="checkList">
											<li id="sys0"><input type="checkbox" class="inputCheck" id="i1" checked="checked" /><label for="">유량</label></li>
											<li id="sys1"><input type="checkbox" class="inputCheck" id="i2" checked="checked"/><label for="">시우량</label></li>
											<li id="sys2"><input type="checkbox" class="inputCheck" id="i3" checked="checked"/><label for="">우량</label></li>
											<li id="sys3"><input type="checkbox" class="inputCheck" id="i4" checked="checked"/><label for="">수위</label></li>
										</ul>
									</dd>
								</dl>
								<p class="btn_search"><a href="javascript:reloadData()"><img src="<c:url value='/images/common/btn_search.gif'/>" alt="조회" /></a></p>
							</div>
						</form:form>
					</div>
					<!-- //수위,유량 조회 -->
					<ul class="dataBtn">
						<li><a id="a_chartPopup"><img style='display:none' id="img_chartPopup" src="<c:url value='/images/common/btn_graph.gif'/>" alt="그래프" /></a></li>
						<li><a href="javascript:excelDown()"><img src="<c:url value='/images/common/btn_excel.gif'/>" alt="엑셀" /></a></li>
						<!-- <li><a href="#"><img src="<c:url value='/images/common/btn_map.gif'/>" alt="지도" /></a></li> -->
					</ul>
					<p class="p_total_cnt" id="p_total_cnt">총 ${totCnt}건</p>
					<div class="data_wrap" style="width:520px;float:left;clear:left">
						<div class="overBox">
							<a name="data"></a>
							<table class="dataTable"  oncontextmenu="return false" ondragstart="return false" onselectstart="return false"><!-- 컬럼 개수가 늘어날수록 width값도 증가해야합니다. -->
								<colgroup>
									<col width="38px" />
									<col width="" />
									<col width="" />
									<col width="" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">NO</th>
										<th scope="col">측정소</th>
										<th scope="col">일자</th>
										<th scope="col">수위(cm)</th>
									</tr>
								</thead>
								<tbody id="dataList">
								</tbody>
							</table>
						</div>
					</div>
					<div style="width:480px;float:right;clear:right">
						<h2><span id="lblLocation">측정소 위치</span> <img id="pendingBtn" style='cursor:pointer' align="bottom" onclick='slide()' src="<c:url value='/images/popup/btn_arrow_down.gif'/>" alt="pending" /></h2>
						<div id="data_map" class="data_map" style="width:480px;height:271px;border:solid 2px #CCC;">
								<c:import url="/WEB-INF/jsp/common/mapview_totalmnt.jsp" />
						</div>
						<br/>
						<h2> 변화추이 그래프</h2>
						<div id="data_graph" class="data_graph" style="width:480px;height:230px;border:solid 2px #CCC;overflow:hidden">
							<span id="span_loading" style="position:absolute">그래프를 불러오는 중 입니다...</span>
							<iframe id="chart"  name="chart" onload="chart_load()" src="" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" width="100%" height="230px"></iframe>
						</div>
					</div>
					<ul class="paginate" id="pagination" style="clear:both">
					</ul>
					<!-- //수질 조회 현황 -->
				</div>
			</div>
		</div><!-- //content -->

	</div><!-- //container -->
	<div id="footer">
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div><!-- //footer -->
</div>
</body>
</html>
