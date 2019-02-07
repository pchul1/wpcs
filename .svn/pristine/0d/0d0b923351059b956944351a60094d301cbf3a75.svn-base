<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : itemHoldConditionList.jsp
	 * Description : 방제물품 보유현황 화면
	 * 
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />
<%
	String endDate = request.getParameter("endDate");
%>
<script type="text/javascript">
//<![CDATA[
  var wareHouseLen;
  
	function init(){
		getUpperDeptCode();
	
		var endDate = '<%=endDate%>';
		
		/*shows the loading div every time we have an Ajax call*/  
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yy/mm/dd',
			showOn: 'both',
			buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly: true
		});

		$("#endDate").datepicker({
			buttonText: '조회일자'
		});
		
		var today = new Date();
		today = today.getFullYear()+"/"+ addzero(today.getMonth()+1) + "/" + addzero(today.getDate());
	
		function addzero(n) {
			 return n < 10 ? "0" + n : n + "";
		}
		
		//날짜 초기값 Setting
		if(endDate == 'null'){
			$("#endDate").val(today);
		}
		
		<sec:authorize  ifAnyGranted="ROLE_WAREHOUSE">
			//$('#btnItemStor').show();
		</sec:authorize>
		
		setHeader('');
		
	}
	
	//담당 부서
	function getDeptCode(){
		
		$.ajax({
			type : "POST",
			url : "<c:url value='/warehouse/getDeptCode.do'/>",
			data : {
				
				upperDeptCode:''
			},
			dataType : "json",
			beforeSend : function() {},
			success : function(result) {
				
				var dropDownSet = $('#selectDept');
				dropDownSet.loadSelectWareHouse(result.codes, '담당부서', "DEPTCODE",'DEPTNAME');
			}
		});
	}
	//소속 창고 조회
	function getWareHouse(){
		var adminDept = $('#selectDeptMgr option:selected').val();
		//alert(adminDept);
		$("#p_total_cnt").html("[총 0건]");
		if(adminDept != ''){
			$.ajax({
				type:"POST",
				url:"<c:url value='/warehouse/getWareHouseNames.do'/>",
				data:{
						adminDept : adminDept
					 },
				dataType:"json",
				success:function(result){
					setHeader(result['codes']);
				}
			});
		}
	}
	
	//페이징 처리 함수
	function linkPage(pageNo){
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/warehouse/itemConditionManageList.do'/>";
		document.listForm.submit();
	}
	
	//운영기관,관리 주체 
	function getUpperDeptCode(){
		
		$.ajax({
			type : "POST",
			url : "<c:url value='/warehouse/getUpperDeptCode.do'/>",
			data : {},
			dataType : "json",
			beforeSend : function() {},
			success : function(result) {
				
				var dropDownSet = $('#selectUpperDeptMgr');
				
				dropDownSet.loadSelectWareHouse  (result.codes, '선택', "UPPERDEPTCODE",'UPPERDEPTNAME');
			
			}
		});
	}
	//운영부서/관리부서 
	function getDeptCode(type){
		
		var upperDeptCode = $("#selectUpperDeptMgr option:selected").val();
		
		$.ajax({
			type : "POST",
			url : "<c:url value='/warehouse/getDeptCode.do'/>",
			data : {
				upperDeptCode:upperDeptCode
			},
			dataType : "json",
			beforeSend : function() {
			
			},
			success : function(result) {
				
				var list = new Array();
				if(result["codes"].length > 0)
					list = result["codes"];
				else
					list.push({"DEPTCODE":'', 'DEPTNAME':''});
				
				var dropDownSet = $('#selectDeptMgr');
				
				dropDownSet.loadSelectWareHouse(list, '선택', "DEPTCODE",'DEPTNAME');
				
			}
		});
	}
	
	function setHeader(whNames){

		if(whNames == ''){
			wareHouseLen  = 0;
			
		}else{
			wareHouseLen = whNames.length;	
		}
		var colWidthHtml = "";
		
		var colHtml = "";
		
		colWidthHtml += "<col width='30' />";

		colWidthHtml += "<col width='150' />";
		
		colWidthHtml += "<col width='40' />";

		colWidthHtml += "<col width='40' />";
		/* 
		colWidthHtml += "<col width='100' />";

		colWidthHtml += "<col width='120' />";

		colWidthHtml += "<col width='120' />";

		colWidthHtml += "<col width='120' />";
  		*/
		colHtml += "<tr>";
		
		colHtml += "<th scope='col' rowspan='3'>순서</th>";
		
		colHtml += "<th scope='col' rowspan='3'>물품명</th>";
		
		colHtml += "<th scope='col' rowspan='3'>단위</th>";
		
		colHtml += "<th scope='col' rowspan='3'>합계</th>";
		
		if(wareHouseLen > 0){
			colHtml += "<th scope='col' colspan='"+(wareHouseLen+1)+"'>"+$('#selectDeptMgr option:selected').text()+"</th>";
		}else{
			colHtml += "<th scope='col' colspan='4'>지역본부</th>";			
		} 
		colHtml += "</tr>";
		
		colHtml += "<tr>";
		
		colHtml += "<th scope='col' rowspan='2'>소계</th>";
		
		if(wareHouseLen > 0){
			for(var i = 0 ; i < wareHouseLen ; i++){
				colHtml += "<th scope='col' >"+whNames[i].CAPTION+"</th>";
			}
		}else{
			colHtml += "<th scope='col' >창고</th>";
			colHtml += "<th scope='col' >창고</th>";
			colHtml += "<th scope='col' >창고</th>";
		}
		colHtml += "</tr>";
		colHtml += "<tr>";
		if(wareHouseLen > 0){
			for(var i = 0 ; i < wareHouseLen ; i++){
				colHtml += "<th scope='col' >"+whNames[i].CTY_NAME+"</th>";
			}
		}else{
			colHtml += "<th scope='col' >지역명</th>";
			colHtml += "<th scope='col' >지역명</th>";
			colHtml += "<th scope='col' >지역명</th>";
		}
		colHtml += "</tr>";
		
		$("#colWidth").html("");
		$("#colWidth").append(colWidthHtml);
		$("#headerList").html("");
		$("#headerList").append(colHtml);
		$("#dataList").html("");
		/* 
		if(whNames == ''){
			$('#dataList').html("<tr><td colspan='9'>관리부서를 선택하세요.</td></tr>");
		}else{
			$('#dataList').html("<tr><td colspan='"+(wareHouseLen+5)+"'></td></tr>");
		}
		 */
		//excelDown();
	}
	function excelDown(){
		var pageNo = null;

		var deptNo = $('#selectDeptMgr option:selected').val();
		var deptName = $('#selectDeptMgr option:selected').text();
		var endDate = $('#endDate').val();
		
		if($('#selectUpperDeptMgr option:selected').val() == '' || $('#selectDeptMgr option:selected').val() == ''){
			alert('관리부서를 선택하세요.');
			closeLoading();
			return;
		}
		if(wareHouseLen == 0){
			alert('보유창고가 존재하지 않습니다.');
			closeLoading();
			return;
		}
		if (pageNo == null) pageNo = 1;
		var param = "deptNo="+deptNo+"&deptName="+encodeURIComponent(deptName)+"&endDate="+endDate+"&pageIndex="+pageNo;
		
		location.href="<c:url value='/warehouse/getExcelViewWareHouseItem.do'/>?"+param;
	}
	$(function () {
		//reloadData();
	});
	
	function reloadData(pageNo){
		showLoading();
		
		var deptNo = $('#selectDeptMgr').val();
		
		var endDate = $('#endDate').val();
		
		if($('#selectUpperDeptMgr option:selected').val() == '' || $('#selectDeptMgr option:selected').val() == ''){
			alert('관리부서를 선택하세요.');
			closeLoading();
			return;
		}
		if(wareHouseLen == 0){
			alert('보유창고가 존재하지 않습니다.');
			closeLoading();
			return;
		}
		
		if (pageNo == null) pageNo = 1;
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/getItemHoldConditionList.do'/>",
			data: { 
					deptNo:deptNo,
					endDate:endDate,
					pageIndex:pageNo
					
				},
			dataType:"json",
			success : function(result){
				var tot = result['resultList'].length;
				var pageInfo = result['paginationInfo'];
				
				if( tot <= 0 ){
					$('#dataList').html("<tr><td colspan='9'>조회 결과가 없습니다.</td></tr>");
				}else{
					
					var item = "";
				
					for(var i=0; i < tot; i++){
						
						var obj = result['resultList'][i];
						
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						
						obj.no = no;
					
	 					item += "<tr>"
	 					      +   "<td><span>"+obj.no+"</span></td>"
	 					      +   "<td>"+obj.itemName+"</td>"
	 					      +   "<td>"+obj.itemStan+"</td>"
	 					      +   "<td>"+obj.totalCnt+"</td>"
	 					      +   "<td>"+obj.cnt+"</td>"
	 					      if(obj.wh1 != '' )  item +=   "<td>"+obj.wh1+"</td>";
	 					      if(obj.wh2 != '' )  item +=   "<td>"+obj.wh2+"</td>";
	 					      if(obj.wh3 != '' )  item +=   "<td>"+obj.wh3+"</td>";
	 					      if(obj.wh4 != '' )  item +=   "<td>"+obj.wh4+"</td>";
	 					      if(obj.wh5 != '' )  item +=   "<td>"+obj.wh5+"</td>";
	 					      if(obj.wh6 != '' )  item +=   "<td>"+obj.wh6+"</td>";
	 					      if(obj.wh7 != '' )  item +=   "<td>"+obj.wh7+"</td>";
	 					      if(obj.wh8 != '' )  item +=   "<td>"+obj.wh8+"</td>";
	 					      if(obj.wh9 != '' )  item +=   "<td>"+obj.wh9+"</td>";
	 					      if(obj.wh10 != '' ) item +=   "<td>"+obj.wh10+"</td>";
	 					      if(obj.wh11 != '' ) item +=   "<td>"+obj.wh11+"</td>";
	 					      if(obj.wh12 != '' ) item +=   "<td>"+obj.wh12+"</td>";
	 					      if(obj.wh13 != '' ) item +=   "<td>"+obj.wh13+"</td>";
	 					      if(obj.wh14 != '' ) item +=   "<td>"+obj.wh14+"</td>";
	 					      if(obj.wh15 != '' ) item +=   "<td>"+obj.wh15+"</td>";
	 					      if(obj.wh16 != '' ) item +=   "<td>"+obj.wh16+"</td>";
	 					      if(obj.wh17 != '' ) item +=   "<td>"+obj.wh17+"</td>";
	 					      if(obj.wh18 != '' ) item +=   "<td>"+obj.wh18+"</td>";
	 					      if(obj.wh19 != '' ) item +=   "<td>"+obj.wh19+"</td>";
	 					      if(obj.wh20 != '' ) item +=   "<td>"+obj.wh20+"</td>";
	 					 	  +  "</tr>";	
	 					 
					}
					
              		$("#dataList").html(item);
              		$("#dataList tr:odd").attr("class","even");
					
				}
				
				$("#p_total_cnt").html("[총 " + tot + "건]");
				
				closeLoading();
			},
			error:function(result){
				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
				var oraErrorCode = "";
				if (result.responseText != null ) {
					var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				$('#dataList').html("<tr><td colspan='9'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></tr>");
				
				closeLoading();
			}
		});
	}
//]]>
</script>
</head>

<body onload="init();" link="blue" vlink="red" alink="darkgreen">
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div id="wrap">
		
		<!-- Head Start-->
		<div id="header">
			<c:import url="/common/menu/header.do" />
		</div>
		<!-- Head End-->
		
		<!-- Body Start-->
		<div id="container">
			<div id="content_wrapper">
				
				<!--left menu Start-->
				<c:import url="/common/menu/left.do" />
				<!--left menu End-->
				
				<!-- Content Start-->
				<div id="content">
					
					<!-- navi, tab menu Start-->
					<c:import url="/common/menu/navi.do" />
					<!-- navi, tab menu End-->
						
					<!--tab Contnet Start-->
					<div class="tab_container">
						<form name="listForm" method="post">
							<div class="searchBox dataSearch">
								<ul>
									<li>
										<span class="fieldName">관리부서</span>
										<select id="selectUpperDeptMgr" style="width:188px" onchange="javascript:getDeptCode();">
											<option value="">선택</option>
										</select>&nbsp;
										<select id="selectDeptMgr" style="width:188px" onchange="javascript:getWareHouse();">
											<option value="">선택</option>
										</select>
									</li>
									<li>
										<span class="fieldName">일자</span>
										<input type="text" value="${searchVO.endDate}" id="endDate" name="endDate" size="13" alt="조회일자"/>
									</li>
								</ul>
							</div>
							
							<div class="btnSearchDiv">
								<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData();" alt="조회하기" style="float:right;"/>
							</div>
							<div id="btArea">
								<span id="p_total_cnt">[총 0건]</span>
								<input type="button" id="excel" name="excel" class="btn btn_excel" onclick="javascript:excelDown();" alt="엑셀"/>
							</div>
							<div class="table_wrapper">
								<input id="pageIndex" name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
								<div  style="overflow-x: hidden; overflow-y: hidden; width: 100%; height: 100%;">
									<table>
										<colgroup id="colWidth">

										</colgroup>

										<thead id="headerList">

										</thead>

										<tbody id="dataList">

										</tbody>
									</table>
								</div>
							</div>
						</form>
					</div>
					<!--tab Contnet End-->
				</div>
				<!-- Content End-->
			</div>
		</div>
		<!-- Body End-->
		<!-- Footer Start-->
		<div id="footer">
			<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
		<!-- Footer End-->
	</div>
</body>
</html>