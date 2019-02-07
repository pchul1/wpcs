<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : alertMngList.jsp
	 * Description : 상황발생이력 화면->상황(자동)관리
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2010.05.20	k			최초생성
	 * 2013.10.20	lkh			리뉴얼
	 * 2014.10.27  mypark		페이징 처리
	 * 
	 * author k
	 * since 2013.10.31
	 * 
	 * Copyright (C) 2010 by k  All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />

<script type="text/javascript">
	$(function () {
		var page = "${param.pageIndex}";
		
		$('#search').click(function () {
			//search_data();
		});
		
		//============================= 달 력  Start ======================================
		var system = "${param.system}";
		var startDate = "${param.startDate}";
		var endDate = "${param.endDate}";
		var minOr = "${param.minOr}";
		
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
		
		var startDay = new Date(); 
		startDay = startDay.getFullYear()+"/"+ addzero(startDay.getMonth()+1) + "/" + "01";
		
		//var yday = new Date(Date.parse(today) - 1 * 1000 * 60 * 60 * 24);
		//yday = yday.getFullYear()+ addzero(yday.getMonth()+1) + addzero(yday.getDate());
		
		function addzero(n) {
			return n < 10 ? "0" + n : n + "";
		}
		
		//날짜 초기값 Setting
		if(startDate == 'null' || startDate == ''){
			$("#startDate").val(startDay);
		}else{
			var startTemp = startDate.substr(0,4) + '/' + startDate.substr(4,2) + '/' + startDate.substr(6,2);
			$("#startDate").val(startTemp);
		}
		
		if(endDate == 'null' || endDate == ''){
			$("#endDate").val(today);
		}else{
			var endTemp = endDate.substr(0,4) + '/' + endDate.substr(4,2) + '/' + endDate.substr(6,2);
			$("#endDate").val(endTemp);
		}
		//============================= 달 력  End ======================================
		
		if(system != 'null' && system != ''){
			$("#system").val(system);
		}
		
		search_data(page, minOr);
	});
	
	function view(asId, page, step, itemType){
		var system = $("#system").val();
		var startDate = $('#startDate').val();
		var endDate = $('#endDate').val();
		
		startDate = startDate.split('/').join('');
		endDate = endDate.split('/').join('');
		
		var minOr =  $('#minOr').val();
		
		document.location.href = "<c:url value='/alert/alertMngView.do'/>?asId="+asId
								+"&step=" + step
								+"&pageIndex=" + page
								+"&itemType=" + itemType
								+"&system=" + system
								+"&startDate=" + startDate
								+"&endDate=" + endDate
								+"&minOr=" + minOr
								;
	}
	
	function reloadData(pageNo, minOr){
		showLoading();
		
		if(pageNo == null)
			pageNo = 1;
		
		var system = $("#system").val();
		var startDate = $('#startDate').val();
		var endDate = $('#endDate').val();
		
		//페이징처리 위해서, 히든값을 셋팅해준다. 여기서 셋팅하고, 페이지클릭 할때 히든값을 가지고 간다.
		$('#minOr').val(minOr);
		
		startDate = startDate.split('/').join('');
		endDate = endDate.split('/').join('');
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/alert/getAlertMngList.do'/>",
			dataType:"json",
			data:{
				pageIndex:pageNo,
				system:system,
				startDate:startDate,
				endDate:endDate,
				minOr:minOr
			},
			success : function(result){
// 				console.log("결과 값 확인 : ",result);
				
				var html = "";
				var tot = result['alertStepList'].length;
				var pageInfo = result['paginationInfo'];
				
				if( tot <= 0 ){
					html += "<tr><td colspan='8'>조회 결과가 없습니다.</td></tr>";
				} else {
					
					for(var i=0; i < tot; i++){
						var obj = result['alertStepList'][i];
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						
						if(obj.factCode == '50A0001')
						{
							obj.system = "-";
							obj.factName = "임의지점";
							obj.branchNo = "";
							obj.minVl = "-";
						}
						else
						{
							obj.branchNo = "-" + obj.branchNo;
						}
						
						switch(obj.alertStep){
						case "1":	//정상
							obj.alertStepName = '경보발생';
							break;
						case "2":	//정상
							obj.alertStepName = '현장확인';
							break;
						case "3":	//정상
							obj.alertStepName = '시료분석';
							break;
						case "4":	//정상
							obj.alertStepName = '경보발령';
							break;
						case "5":	//정상
							obj.alertStepName = '상황조치';
							break;
						case "6":	//상황종료 - 측정기이상
							obj.alertStepName = '상황종료-측정기이상';
							break;
						case "7":	//상황종료 - 이상데이터
							obj.alertStepName = '상황종료-이상데이터';
							break;
						case "8":	//상황종료
							obj.alertStepName = '상황종료';
							break;
						case "9":	// 1과 9가 같나???
							obj.alertStepName = '경보등록';
							break;
						case "10":	//상황종료 - 시료분석
							obj.alertStepName = '상황종료-시료분석';
							break;
						}
						if(obj.currentPageNo == undefined) obj.currentPageNo = 1;
						if("1" == menuAuth("U")){
							link = "view('" + obj.asId + "', '" + obj.currentPageNo + "', '" + obj.alertStep + "', '" + obj.itemTypeCode + "')";
						}else{
							link = "";
						}	

						obj.factName = obj.branchName + obj.branchNo;
						obj.endTime = (obj.step6 != '' ? obj.step6 : (obj.step7 != '' ? obj.step7 : (obj.step8 != '' ? obj.step8 : obj.step10)));
						obj.currentPageNo = pageInfo.currentPageNo;
						obj.no = no;
						trclass = "";
						if(i % 2 == 1) trclass = "class=\"even\"";
						
						html +="<tr "+trclass+">";
						html += "<td><a onclick=\""+link+"; return false;\" href=\"#\">"+ obj.no +"</a></td>";
						html += "<td><a onclick=\""+link+"; return false;\" href=\"#\">"+ obj.itemType +"</a></td>";
						html += "<td><a onclick=\""+link+"; return false;\" href=\"#\">"+ obj.system +"</a></td>";
						html += "<td><a onclick=\""+link+"; return false;\" href=\"#\">"+ obj.alertStepName +"</a></td>";
						html += "<td><a onclick=\""+link+"; return false;\" href=\"#\">"+ obj.riverId +"</a></td>";
						html += "<td><a onclick=\""+link+"; return false;\" href=\"#\">"+ obj.factName +"</a></td>";
						html += "<td><a onclick=\""+link+"; return false;\" href=\"#\">"+ obj.minTime +"</a></td>";
						html += "<td><a onclick=\""+link+"; return false;\" href=\"#\">"+ obj.minTime +"</a></td>";
						html +="</tr>";
					}
				}
				// 페이징 정보
				var pageStr = makePaginationInfo(result['paginationInfo']);
				$("#pagination").empty();
				$("#pagination").append(pageStr);
				$("#dataList").html(html);
				
				closeLoading();
			},
			error:function(result){
				var html = "";
				html += "<tr><td colspan='8'>서버 접속에 실패하였습니다.</td></tr>";
				$("#dataList").html(html);
				closeLoading();
			}
		});
	}
	
	//페이지 번호 클릭
	function linkPage(pageNo){
		var minOr = $('#minOr').val();
		reloadData(pageNo, minOr);
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
				checkNum	= "true";
			}else{
				returnValue = "false";
				checkNum	= "false";
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
	
	function search_data(page, minOr){
		var system = $("#system").val();
		var startDate = $('#startDate').val();
		var endDate = $('#endDate').val();
		
		if(minOr == null)
			minOr = '';
		
		startDate = startDate.split('/').join('');
		endDate	= endDate.split('/').join('');
		
		showLoading();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/stats/getPreventStatsList.do'/>",
			data:{
				system:system,
				startDate:startDate,
				endDate:endDate},
			dataType:"json",
			success:function(result){
				var tot = result['preventStatsList'].length;
				
				var item;
				var sysKind;
				var total;
				var val1;
				var val2;
				var val3;
				var val4;
				
				item = "";
				
				$("#statsBody").html("");
				
				if( tot <= "0" ){
					$("#statsBody").html("<tr><td colspan='10'>조회 결과가 없습니다</td></td>");
					closeLoading();
				} else {
					for(var j=0; j < tot; j++){
						var obj = result['preventStatsList'][j];
						
						sysKind = obj.sysKind;
						total = obj.total;
						val1 = obj.val1;
						val2 = obj.val2;
						val3 = obj.val3;
						val4 = obj.val4;
						
						if(sysKind == "ALL")
							sysKind = "총계";
						else if(sysKind == "U")
							sysKind = "이동형측정기기";
						else if(sysKind == "A")
							sysKind = "국가수질자동측정망";
							
						var pageNo = 1;
						
						item = "<tr>"
							+ "<td>"+sysKind+"</td>"
							+ "<td style='cursor:pointer' onclick='reloadData(1,0)'>"+total+"</td>"
							+ "<td style='cursor:pointer' onclick='reloadData(1,1)'>"+val1+"</td>"
							+ "<td style='cursor:pointer' onclick='reloadData(1,2)'>"+val2+"</td>"
							+ "<td style='cursor:pointer' onclick='reloadData(1,3)'>"+val3+"</td>"
							+ "<td style='cursor:pointer' onclick='reloadData(1,4)'>"+val4+"</td>"
							+ "</tr>"; 
							
						$("#statsBody").append(item);
						item = "";
					}
					$('#statsBody tr:odd').addClass('add');
				}
				closeLoading();
				
				if(minOr != 'null' && minOr != ''){
					reloadData(page, minOr);
				}else{
					reloadData(1, 0);
				}
			},
			error:function(result){}
		});
	}
	
	function menuAuth(auth){
		var iauthC ="";
		var iauthU ="";
		var iauthD ="";
		if(auth == "C"){
			iauthC ="Y";
		}
		if(auth == "U"){
			iauthU ="Y";
		}
		if(auth == "D"){
			iauthD ="Y";
		}
		var menuAuth = ""	;
		$.ajax({	
			type:"post",
			url: "<c:url value='/admin/member/getUserAuthorCnt.do'/>",
			dataType:"json",
			async: false,
			data:{
				userId:$("#userId").val(),
				menuId:$("#naviMenuNo").val(),
				authC:iauthC,
				authU:iauthU,
				authD:iauthD
			},
			success : function(result){
				var tot = 0;
				 tot = result['getUserMenuAuthorCount'];
				 menuAuth = tot;
			}
		});
		return menuAuth;
	}
</script>
</head>

<body>
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
						
						<!-- 상황발생이력 검색 조건 -->
						<form action="" onsubmit="return false">
						
							<div class="searchBox dataSearch">
								<ul>
									<li>
										<span class="fieldName">시스템</span>
										<select class="fixWidth13" id="system" name="system">
												<option value="U" selected="selected">이동형측정기기</option>
												<!-- <option value="T">탁수모니터링</option> -->
												<option value="A">국가수질자동측정망</option>
										</select>
									</li>
									<li>
										<span class="fieldName">조회기간</span>												
										<input type="text" value="${searchVO.startDate}" id="startDate" name="startDate" size="13" onchange="commonWork()" alt="조회시작일"/>
										<span>~</span>
										<input type="text"value="${searchVO.endDate}" id="endDate" name="endDate" size="13" onchange="commonWork()" alt="조회종료일"/>
									</li>
								</ul>
							</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:search_data();" alt="조회하기" style="float:right;"/>
						</div>
						</form>
						<!-- //방제조치 통계 검색 -->
							
						<!-- 방제조치 통계 현황 -->
						<div class="table_wrapper">
							
							<div id="overBox" class="overBox">
								<table id="dataTable" summary="유역별통계정보">
									<colgroup>
										<col />
										<col width="80px" />
										<col width="80px" />
										<col width="80px" />
										<col width="80px" />
										<col width="80px" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col" rowspan="2">시스템</th>
											<th scope="col" colspan="5">경보</th>	
										</tr>
										<tr>
											<th scope="col">계</th>
											<th scope="col">관심</th>
											<th scope="col">주의</th>
											<th scope="col">경계</th>
											<th scope="col">심각</th>
										</tr>
									</thead>
									<tbody id="statsBody"></tbody>
								</table>
							</div>
							<!-- //방제조치 통계 현황 -->
							<br />
							<form:form commandName="alertMngVO" name="listFrm" method="post">
								<input type="hidden" name="pageIndex" value="${alertMngVO.pageIndex}"/>
							</form:form>
							
							<input type="hidden" id="minOr" />
							
							<table>
								<col width='45 ' />
								<col width='110' />
								<col width='110' />
								<col width='150' />
								<col width='110' />
								<col width='130' />
								<col width='180' />
								<col width='155' />
								<thead>
									<tr>
										<th scope='col'>No</th>
										<th scope='col'>구분</th>
										<th scope='col'>시스템</th>
										<th scope='col'>조치단계</th>
										<th scope='col'>수계</th>
										<th scope='col'>측정소</th>
										<th scope='col'>경보발생시간</th>
										<th scope='col'>상황종료시간</th>
									</tr>
								</thead>
								<tbody id="dataList">
								</tbody>
							</table>

							
							<div class="paging">
								<div id="page_number">
									<ul class="paginate" id="pagination"></ul>
								</div>
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