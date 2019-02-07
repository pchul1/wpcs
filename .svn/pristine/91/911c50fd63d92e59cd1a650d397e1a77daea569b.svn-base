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
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
	<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
	
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
	<script type="text/javascript">

	// 검색 시작일
	var search_date_start = "${airMntDataVO.search_date_start}";
	// 검색 종료일
	var search_date_end = "${airMntDataVO.search_date_end}";
	
	$(function () {	

		// 창고목록을 가져온다.
		getWareHouseList();

		// 물품코드를 가져온다.
		getItemCodeList();
		
		$.datepicker.setDefaults({
		    monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
		    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		    showMonthAfterYear:true,
		    dateFormat: 'yymmdd',
		    showOn: 'both',
		    buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
		    buttonImageOnly: true
		});

		$("#search_date_start").datepicker({
		    buttonText: '시작일'
		    
		});
		$("#search_date_end").datepicker({
		    buttonText: '종료일'
		});

		var today = new Date(); 
		var yday = new Date(Date.parse(today) - 1 * 1000 * 60 * 60 * 24);

		yday = yday.getFullYear()+ addzero(yday.getMonth()+1) + addzero(yday.getDate());
		today = today.getFullYear()+ addzero(today.getMonth()+1) + addzero(today.getDate());

		function addzero(n) {
			 return n < 10 ? "0" + n : n + "";
		}

		// 선택되어져 있게...
		//$("#sugye > option[value="+sugye+"]").attr("selected", "true");
		
		if(search_date_start != null && search_date_start != "")
			$("#search_date_start").val(search_date_start);
		else
			$("#search_date_start").val(yday);

		if(search_date_end != null && search_date_end != "")
			$("#search_date_end").val(search_date_end);
		else
			$("#search_date_end").val(today);

		dataLoad();
		$("#dataList tr:odd").attr("class","add");
	});

	// 창고목록을 가져온다.
	function getWareHouseList()
	{
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/selectWareHouseList.do'/>",
			data: "",	
			dataType:"json",
			beforeSend : function(){
				$('#wareHouse').attr("disabled", true);	
				},				
			success : function(result){
				//var tot = result['list'].length;

				var dropDownSet = $('#wareHouse');
				dropDownSet.loadSelectWareHouse(result.list, '전체', 'whCode', 'whName');
				$('#wareHouse').attr("disabled", false);
			}
		});
	}

	// 물품코드를 가져온다.
	function getItemCodeList()
	{
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/selectWareHouseItemCodeList.do'/>",
			data: "",	
			dataType:"json",
			beforeSend : function(){
				$('#itemCode').attr("disabled", true);	
				},				
			success : function(result){
				var dropDownSet = $('#itemCode');
				dropDownSet.loadSelectWareHouse(result.list, '전체', 'itemCode', 'itemName');
				$('#itemCode').attr("disabled", false);
			}
		});	
	}
	
	// 데이터 목록 불러오기
	function dataLoad(pageNo)
	{
		if (pageNo == null) pageNo = 1;
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/itemReleDataList.do'/>",
			data: {whCode:$('#wareHouse').val(),
					itemCode:$('#itemCode').val(),
					startDate:$('#search_date_start').val(),
					endDate:$('#search_date_end').val(),
					pageIndex:pageNo
				},	
			dataType:"json",
			beforeSend : function(){
				$("#dataList").html("");
				$("#dataList").html("<tr><td colspan='7'>데이터를 불러오는 중 입니다...</td></tr>");	
				},				
			success : function(result){

				var tot = result['list'].length;

				if( tot <= 0 ){
	            	$("#dataList").html("<tr><td colspan='7'>조회 결과 없음 (조회 기간등 검색 조건을 확인해주세요.)</td></tr>");
	            }else{
	            	$("#dataList").html("");
	                for(var i=0; i < tot; i++){
	                    var obj = result['list'][i];
						var item;
						
	                   	item = "<tr style='cursor:hand'>" 
								+"<td class='num'><span>"+obj.num+"</span></td>"
		                 		+"<td>"+obj.whName+"</td>"
		                 		+"<td>"+obj.itemName+"</td>"
		                 		+"<td>"+obj.itemStan+"</td>"
		                 		+"<td>"+obj.itemUnit+"</td>"
		                 		+"<td>"+obj.amt+"</td>"
		                 		+"<td>"+obj.itemDate+"</td>"
	                 		 	+"</tr>";

	              		$("#dataList").append(item);

	              		$("#dataList tr:odd").attr("class","add");
	                }
	            }

	            // 페이징 정보
	            var pageStr = makePaginationInfo(result['paginationInfo']);
	            $("#pagination").empty();
	            $("#pagination").append(pageStr);

	         	// 총건수 표시
	            $("#totcnt").empty();
				$("#totcnt").append("[총 "+result['paginationInfo'].totalRecordCount+"건]");	            	
			}
		});
	}

	// 페이지 번호 클릭	
	function linkPage(pageNo){
		dataLoad(pageNo);				    
	} 
	</script>
</head>
<body>
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
			<div class="content_wrap page_waterinfo">
				<div class="inner_airmnt">
					<div class="search_all_wrap">
						<form:form commandName="airMntDataVO" name="listFrm"  id="listFrm" method="post" cssClass="formBox">		
							<input type="hidden" name="pageIndex" id="pageIndex" value="${airMntDataVO.pageIndex}"/>	
							<input type="hidden" name="sugye" id="river_div"/>
							<div class="btnInBox">
								<dl>
									<dt><img src="<c:url value='/images/content/tit_search_land.gif'/>" alt="창고구분" /></dt>
									<dd>
										<select class="fixWidth12" id="wareHouse">
										</select>
									</dd>
									<dt><img src="<c:url value='/images/content/tit_search_land.gif'/>" alt="물품구분" /></dt>
									<dd>
										<select class="fixWidth15" id="itemCode">
										</select>
									</dd>
									<dt><img src="<c:url value='/images/content/tit_search_date.gif'/>" alt="조회기간" /></dt>
									<dd class="time">
										<input type="text" class="inputText" id="search_date_start" name="search_date_start" readonly="readonly"/>
										<span>~</span>
										<input type="text" class="inputText" id="search_date_end" name="search_date_end" readonly="readonly"/>
									</dd>
								</dl>
								<p class="btn_search"><a href="javascript:dataLoad()"><img src="<c:url value='/images/common/btn_search.gif'/>" alt="조회" /></a></p>
							</div>
						</form:form>
					</div>
					<div class="data_wrap pad_t">
						<div class="overBox">
							<div align="right" id="totcnt">&nbsp;</div>
							<table class="dataTable">
								<colgroup>
									<col width="38px"/>
									<col width="140px" />
									<col width="200px" />
									<col width="100px" />
									<col width="100px" />
									<col />
									<col width="130px"/>
								</colgroup>
								<thead>
									<tr>
										<th scope="col">NO</th>
										<th scope="col">창고명</th>
										<th scope="col">물품명</th>
										<th scope="col">규격</th>
										<th scope="col">단위</th>
										<th scope="col">출고수량</th>
										<th scope="col">출고일자</th>
									</tr>
								</thead>
								<tbody  id="dataList">&nbsp;</tbody>
							</table>
						</div>
					</div>
					<ul class="paginate" id="pagination">
				        
					</ul>
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
