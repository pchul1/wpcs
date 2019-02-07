<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

	<sec:authorize ifAnyGranted="ROLE_USER">
		<script  type='text/javascript'>
			var user_dept_no = '<sec:authentication property="principal.userVO.deptNo"/>';
		</script> 
	</sec:authorize>
	
<%-- 	<sec:authorize ifNotGranted="ROLE_USER"> --%>
<!-- 		<script  type='text/javascript'> -->
<!-- 			alert('로그인이 필요한 페이지 입니다'); -->
<%-- 			window.location = "<c:url value='/'/>";  --%>
<!-- 		</script>  -->
<%-- 	</sec:authorize> --%>
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
	
	<script type="text/javascript">

	var search_date_start = "${param.searchStart}";
	var search_date_end = "${param.searchEnd}";
	var pageIdx = "${param.pageIndex}";
	
	$(function () {
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

		yday = yday.getFullYear()+ "/" + addzero(yday.getMonth()+1) + "/" + addzero(yday.getDate());
		today = today.getFullYear()+ "/" + addzero(today.getMonth()+1) + "/" + addzero(today.getDate());

		function addzero(n) {
			 return n < 10 ? "0" + n : n + "";
		}

		$("#startDate").val(yday);
		$("#endDate").val(today);


		
		if(search_date_start != null && search_date_start != "")
			$("#startDate").val(search_date_start);
		else
			$("#startDate").val(yday);

		if(search_date_end != null && search_date_end != "")
			$("#endDate").val(search_date_end);
		else
			$("#endDate").val(today);

		//firstDataLoad();
		$("#dataList tr:odd").attr("class","add");

		if(pageIdx != null && pageIdx != '')
			reloadData(pageIdx);
		else
			reloadData(1);
		
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
			width:0,
			height:0,
		    showCaption:false,
		    resizable:false
		});
		
		$("#loadingDiv").dialog("open");
	}

	function closeLoading()
	{
		$("#loadingDiv").dialog("close");
	}

	/*
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
	*/

	function reloadData(pageNo){

		showLoading(); 

		if (pageNo == null) pageNo = 1;

		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/mock/getDayLogList.do'/>",
			data: {
					  frTime:"00",
					  toTime:"23",
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

				var tot = result['dataList'].length;
				var pageInfo = result['paginationInfo'];
				
				if( tot <= 0 ){
	            	$("#dataList").html("<tr><td colspan='5'>조회 결과 없음</td></tr>");
	            	 closeLoading();
	            }else{
	            	$("#dataList").html("");
	                for(var i=0; i < tot; i++){
	                    var obj = result['dataList'][i];
						var item;

						//var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						
	                   	item = "<tr style='cursor:pointer' onclick='goView(\""+obj.daylogNo+"\", \"" + pageNo + "\")'>" 
								+"<td>"+obj.daylogNo+"</td>"
		                 		+"<td>"+obj.daylogMakeTime+"</td>"
		                 		+"<td>"+obj.regId+"</td>"
		                 		+"<td>"+ ((obj.isMod != "") ? "작성 후 수정됨" : "수정사항 없음") +"</td>"
		                 		+"<td>"+((obj.compFlag == 'Y') ? "완료" : "작성중") +"</td>"
	                 		 	+"</tr>";

	              		$("#dataList").append(item);
	              		$("#dataList tr:odd").attr("class","add"); 
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

		//document.listFrm.action = "<c:url value='/waterpolmnt/waterinfo/getFlowData.do'/>";

		 //document.listFrm.submit();
	}    


	function goView(daylogNo, page)
	{
		var searchStart = $("#startDate").val2();
		var searchEnd = $("#endDate").val2();
		
		var param = "pageIndex=" + page + "&daylogNo=" + daylogNo + "&searchStart=" + searchStart + "&searchEnd=" + searchEnd;

		window.location = "<c:url value='/mock/goDayLogDet.do'/>?" + param
	}	
	function commonWork() {
		var stdt = document.getElementById("startDate");
		var endt = document.getElementById("endDate");
		var dateCheck = /^(19[7-9][0-9]|20\d{2})\/(0[0-9]|1[0-2])\/(0[1-9]|[1-2][0-9]|3[0-1])$/;
		
		if(stdt.value !=''){
			if(dateCheck.test(stdt.value)!=true){
				
				var returnValue = commonWork2(stdt.value, "startDate");
				
				//숫자만 입력 체크를 통과못하면.
				if(returnValue != 'true'){
					alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
					stdt.value = "";
					stdt.focus;
					return false;
				}
			}
		}
		if(endt.value !=''){
			if(dateCheck.test(endt.value)!=true){
				
				var returnValue = commonWork2(endt.value, "endDate");
				
				//숫자만 입력 체크를 통과못하면.
				if(returnValue != 'true'){
					alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
					endt.value = "";
					endt.focus;
					return false;
				}				
			}
		}
		
		if(endt.value != '' && stdt.value > endt.value) {
			alert("조회 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			stdt.value = "";
			endt.value = "";
			stdt.focus();
		}
	}  
	
	//숫자만 입력했을때 자동완성을 위한 함수
	// 1. 8자리 체크
	// 2. 1000 년이후 체크
	// 3. 월 체크
	// 4. 일 체크
	function commonWork2(dateValue, inputId){
		var returnValue = "";
		var checkNum = "";
		
		for(var i=0 ; i<dateValue.length ; i++){
			var checkCode = dateValue.charCodeAt(i);
			
			//숫자로만 이루어져 있는지 여부 체크.
			if( checkCode >= 48 && checkCode <= 57 ){
				checkNum    = "true";
			}else{
				returnValue = "false";
				checkNum    = "false";
				break;
			}
		}
		
		//숫자로만 이루어져 있다면.
		if(checkNum == "true"){
			if( dateValue.length != 8){ //8자리가 아니면 false;
				returnValue = "false";
			}else{
				
				//년 비교
				if( !(1000 < Number(dateValue.substr(0,4)) && Number(dateValue.substr(0,4)) <= 9999 )){
					returnValue = "false";
				}else{
					var month = ["01","02","03","04","05","06","07","08","09","10","11","12"];
					var monthCheck = 'false';
					
					for(var j=0 ; j < month.length ; j++){
						if(Number(dateValue.substr(4,2)) == month[j]){
							monthCheck = 'true';
							break;
						}
					}
					
					//월 비교 통과했다면.
					if(monthCheck == 'true'){
						var day = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"];
						var dayCheck = 'false';
						
						for(var k=0 ; k < day.length ; k++){
							if(Number(dateValue.substr(6,2)) == day[k]){
								dayCheck = 'true';
								break;
							}
						}
						
						//일체크를 통과했다면.
						if(dayCheck == 'true'){
							var tempVar = dateValue.substr(0,4) + '/' + dateValue.substr(4,2) + '/' + dateValue.substr(6,2);
							document.getElementById(inputId).value = tempVar;
							returnValue = 'true';
						}else{
							returnValue = "false";
						}
						
					}else{
						returnValue = "false";
					}						
				}				
			}	
		}
		return returnValue;
	}
	</script>
	
</head>

<body> 
<div id='loadingDiv' style="visibility:hidden;position:absolute;">
	<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />	
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
		
		<!-- content -->
		<div id="content" class="sub_waterpolmnt">
			<div class="content_wrap page_alarmmng">
				<div class="inner_alarmhis">
					<!-- 조회 -->
					<div class="search_all_wrap">
						
						<div class="btnInBox">
							<dl>
								<dt><img src="<c:url value='/images/content/tit_search_date.gif'/>" alt="조회기간" /></dt>
								<dd class="time">
										<input type="text" class="inputText"  id="startDate" name="frDate" onchange="commonWork()" size="15"/>
										<span>~</span>
										<input type="text" class="inputText" id="endDate" name="toDate" onchange="commonWork()" size="15"/>
									</dd>
							</dl>
							<p class="btn_search2"><a href="javascript:reloadData(1)"><img src="<c:url value='/images/common/btn_search.gif'/>" alt="조회" /></a></p>
						</div>
				    </div>
					<!-- // 조회 -->
					<!--  현황 --> 
					
					<div class="data_wrap">
					    <br /> 
						<p class="p_total_cnt" id="p_total_cnt" style="padding-top:0px">총 0건</p>
						<div class="overBox">
							<table class="dataTable">
								<colgroup>
									<col width="45px" />
									<col width="150" />
									<col width="120" />
									<col />
									<col />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">NO</th>
										<th scope="col">작성일자</th>
										<th scope="col">작성자</th>
										<th scope="col">수정여부</th>
										<th scope="col">완료여부</th>
									</tr>
								</thead>
								<tbody id="dataList">
									<tr>
										<td colspan="5">데이터를 불러오는 중 입니다</td>
									</tr>
								</tbody>	
							</table>
						</div>
					</div>
					<ul class="paginate" id="pagination">
					</ul>
					<!-- // 현황 -->
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
