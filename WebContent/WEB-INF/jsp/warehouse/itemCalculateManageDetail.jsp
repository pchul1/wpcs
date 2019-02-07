<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

<%
	/**
	 * Class Name : itemCalculateManageDetail.jsp
	 * Description :방제물품 입출내역 상세 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2012.11.07	윤일권			최초 생성
	 * 2013.10.20	lkh			리뉴얼
	 * 
	 * author 윤일권
	 * since 2012.11.07
	 * 
	 * Copyright (C) 2012by 윤일권  All right reserved.
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
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
%>

<script type="text/javascript">
//<!--
	function init(){
		var startDate = '<%=startDate%>';
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
		
		$("#startDate").datepicker({
			buttonText: '조회일자'
		});
		
		$("#endDate").datepicker({
			buttonText: '조회일자'
		});
		
		var today = new Date();
		today = today.getFullYear()+"/"+ addzero(today.getMonth()+1) + "/" + addzero(today.getDate());
		
		//var yday = new Date(Date.parse(today) - 1 * 1000 * 60 * 60 * 24);
		//yday = yday.getFullYear()+ addzero(yday.getMonth()+1) + addzero(yday.getDate());
		
		function addzero(n) {
			 return n < 10 ? "0" + n : n + "";
		}
		
		//날짜 초기값 Setting
		if(startDate == 'null'){
			$("#startDate").val(today);
		}
		if(endDate == 'null'){
			$("#endDate").val(today);
		}
	}
	
	//페이징 처리 함수
	function linkPage(pageNo){
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/warehouse/itemCalculateManageDetail.do'/>";
		document.listForm.submit();
	}
	
	//조회 처리
	function fnSearch(){
		document.listForm.pageIndex.value = 1;
		document.listForm.submit();
	}
	
	//목록
	function fnGoListPage(){
		location.href = "<c:url value='/warehouse/itemConditionManageList.do'/>";
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
				checkNum = "true";
			}else{
				returnValue = "false";
				checkNum = "false";
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
	
	$(function () {
		reloadData();
	});
	
	function reloadData(pageNo){
		showLoading();
		
		var itemCode = $('#itemCode').val();
		var itemCodeNum = $('#itemCodeNum').val();
		var searchWhName = $('#searchWhName').val();
		var searchCondition = $('#searchCondition').val();
		var startDate = $('#startDate').val();
		var endDate = $('#endDate').val();
		
		if (pageNo == null) pageNo = 1;
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/getItemCalculateManageDetail.do'/>",
			data: { itemCode:itemCode,
					itemCodeNum:itemCodeNum,
					searchWhName:searchWhName,
					searchCondition:searchCondition,
					startDate:startDate,
					endDate:endDate,
					pageIndex:pageNo
				},
			dataType:"json",
			success : function(result){
				var tot = result['resultList'].length;
				var pageInfo = result['paginationInfo'];
				
				if( tot <= 0 ){
					$('#dataList').html("<tr><td colspan='6'>조회 결과가 없습니다.</td></tr>");
				}else{
					var item="";
					for(var i=0; i < tot; i++){
						
						var obj = result['resultList'][i];
						
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
						
	                   	item += "<tr>"			                   	 
								+"<td><span>"+obj.no+"</span></td>"
		                 		+"<td>"+obj.itemName+"</td>"
		                 		+"<td>"+obj.whName+"</td>"
		                 		+"<td>"+obj.condition+"</td>"
		                 		+"<td>"+obj.itemCnt+"</td>"
		                 		+"<td>"+obj.conditionDate+"</td>"
	                 		 	+"</tr>";
	
	              		$("#dataList").html(item);
	              		$("#dataList tr:odd").attr("class","even");
					}
				}
				
				$("#p_total_cnt").html("총 " + result['totCnt'] + "건");
				
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
				$('#dataList').html("<tr><td colspan='6'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></tr>");
				
				closeLoading();
			}
		});
	}
	
	// 페이지 번호 클릭
	function linkPage(pageNo){
		reloadData(pageNo);
	}
//-->
</script>
</head>

<body onload="init();">
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
						
						<form id="hiddenForm" action="" method="get">
							<input type="hidden" id=strSearchType name="strSearchType" value="item"/>
						</form>
						
						<form name="listForm" method="post">
							<input type="hidden" id="itemCode" name="itemCode" value="${searchVO.itemCode}"/>
							<input type="hidden" id="itemCodeNum" name="itemCodeNum" value="${searchVO.itemCodeNum}"/>
							<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex}"/>
							
							<div class="searchBox">
								<ul>
									<li>
										<span class="fieldName">창고명</span>
										<input type="text" id="searchWhName" name="searchWhName" value="${searchVO.searchWhName}" style="ime-mode:active; width: 150px;"/>
									</li>
									<li>
										<span class="fieldName">입출고 구분</span>
										<select id="searchCondition" name="searchCondition">
											<option value="">전체</option>
											<option value="I" <c:if test="${searchVO.searchCondition eq 'I'}">selected="selected"</c:if>>입고</option>
											<option value="O" <c:if test="${searchVO.searchCondition eq 'O'}">selected="selected"</c:if>>출고</option>
										</select>
									</li>
									<li>
										<span class="fieldName">기간</span>
										<input type="text" value="${searchVO.startDate}" id="startDate" name="startDate" size="13" onchange="commonWork()" alt="조회시작일"/>
										<span>~</span>
										<input type="text" value="${searchVO.endDate}" id="endDate" name="endDate" size="13" onchange="commonWork()" alt="조회종료일"/>
									</li>
									<li class="last">
										<input type="button" id="btnSearch" name="btnSearch" value="조회" class="btn btn_search" onclick="javascript:fnSearch();" alt="조회"/>
									</li>
								</ul>
							</div>
						</form>
							
						<div id="btArea">
							<input type="button" id="btnList" name="btnList" value="목록" class="btn btn_basic" onclick="javascript:fnGoListPage();" alt="목록"/>
						</div>
						
						<div class="table_wrapper" style="margin-top:30px">
							<div  style="overflow-x: hidden; overflow-y: scroll; width: 100%; height: 497px;">
									<table>
										<colgroup>
											<col width="60" />
											<col width="150" />
											<col />
											<col width="120" />
											<col width="120" />
											<col width="150" />
										</colgroup>
										<tr>
											<th scope="col">NO</th>
											<th scope="col">물품</th>
											<th scope="col">창고명</th>
											<th scope="col">입/출고</th>
											<th scope="col">개수</th>
											<th scope="col">날짜</th>
										</tr>
										<tbody  id="dataList">
										<tr>
											<td colspan="6">조회 결과가 없습니다.</td>
										</tr>
										</tbody>
									</table>
								</div>
						</div>
						
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