<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : alertList.jsp
	 * Description : 전파이력조회 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2010.05.17	khany		최초 생성
	 * 2013.10.20	lkh			리뉴얼
	 * 2014.10.28  mypark 	검색 개선
	 * 
	 * author khany
	 * since 2010.05.17
	 * 
	 * Copyright (C) 2010 by khany All right reserved.
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
//<![CDATA[
	// 자동으로 조건(파라미터)을 입력하여 리스트를 조회하게 한다.
	var isAutoSetLoad = false;
	$(function () {
		/*shows the loading div every time we have an Ajax call*/
		selectedSugyeInMemberId(user_riverid , 'sugye');
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
		
		$("#startDate").val(today);
		$("#endDate").val(today);
		
		adjustGongku();
		
		$('#system').change(function(){
			adjustGongku();
		});
		
		$('#sugye').change(function(){
			adjustGongku();
		});
		
		$('#factCode').change(function(){
			adjustBranch();
		}); 
// 		set_User_deptNo();
		
		// 파라미터로 조건값이 넘어오면 해당 값을 조건으로 대입한다.
		var system = '${param.system}';
		var sugye = '${param.sugye}';
		var startDate = '${param.startDate}';
		var endDate = '${param.endDate}';
		var type = '${param.type}';
		//${param.factCode} 공구리스트 초기화 후 대입
		//${param.branchNo}
		
		if (system != null && system != '') {
			isAutoSetLoad = true;
			$('#system').val(system);
			$('#sugye').val(sugye);
			$('#startDate').val(startDate);
			$('#endDate').val(endDate);
			$('#type').val(type);
			
			adjustGongku();
		} else {
			loadAlertList();
		}
		
// 		set_User_deptNo(user_dept_no, "sugye");
		
		if (${param.isPopup=='Y'}) {
			$("#content_wrapper").attr("style","width:800px; height:830px");
			$("#wrap").attr("style","height:800px");
		}
		
	});
	
	var firstFlag = true;
	function init() {
		if(firstFlag) {
			loadAlertList();
			firstFlag = false;
		}
	}
	
	function loadAlertList(pageNo){

		showLoading();
		
		if (pageNo == null) pageNo = 1;

		var isPassive = "N";
		
		if($("#isPassive").is(":checked")){
			isPassive = "Y";
		}
		$.ajax({
			type:"post",
			url:"<c:url value='/alert/alertListView.do'/>",
			data:{
					factCode:$("#factCode").val(),
					branchNo:$("#branchNo").val(),
					startDate:$("#startDate").val2(),
					endDate:$("#endDate").val2(),
					isAuto:$("#isAuto").val(),
					type:$("#type").val(),
					pageIndex:pageNo,
					sugye:$("select[name=sugye]").val(),
					system:$("#system").val(),
					isPassive:isPassive},
			dataType:"json",
			success:function(result){
				var html = "";
				var tot = result['alertList'].length;
				var pageInfo = result['paginationInfo'];
				
				if( tot <= 0 ){
					html += "<tr><td colspan='8'>조회 결과가 없습니다.</td></tr>";
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['alertList'][i];
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						
						obj.no = no;

						trclass = "";
						if(i % 2 == 1) trclass = "class=\"even\"";
						
						html +="<tr "+trclass+">";
						html += "<td>"+ obj.no +"</td>";
						html += "<td>"+ obj.sendDate +"</td>";
						html += "<td>"+ obj.part +"</td>";
						html += "<td>"+ obj.name +"</td>";
						html += "<td>"+ obj.telNo +"</td>";
						html += "<td>"+ obj.gubun +"</td>";
						html += "<td>"+ obj.susin +"</td>";
						html += "<td>"+ obj.smsMsg +"</td>";
						html +="</tr>";

					}
				}
				// 페이징 정보
				var pageStr = makePaginationInfo(result['paginationInfo']);
				$("#pagination").empty();
				$("#pagination").append(pageStr);
				
				$("#p_total_cnt").html("[총 "+result['paginationInfo'].totalRecordCount+"건]");
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
	
	function fncSms() {
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 600;
		var winWidth = 900;
		var winLeftPost = (sw - winWidth) / 2;var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-40;
		var height = winHeight-40;
		
		window.open("<c:url value='/alert/alertSms.do'/>?", 
				'DetailView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	// 공구 목록 가져오기
	function adjustGongku()
	{
		var system = $('#system').val();
		var sugyeCd = $('#sugye').val();
		var dropDownSet = $('#factCode');
		var dropDownSetBranch = $('#branchNo');

		dropDownSet.attr("style", "background:#ffffff;");
		dropDownSetBranch.attr("style", "background:#ffffff;");
		$("#factCode>option:first").attr("selected", "true");
		$("#branchNo>option:first").attr("selected", "true");
		
		if( sugyeCd == 'all' ){
			dropDownSet.attr("disabled", true);
			dropDownSetBranch.attr("disabled", true);
			dropDownSetBranch.attr("style", "background:#e9e9e9;");
			dropDownSet.attr("disabled", true);
			dropDownSet.attr("style", "background:#e9e9e9;");
			if($('#system').val() == 'U') {
				$('#spanFact').show();
				$('#branchNo').show();
				$('#factCode').hide();
				$('#spanBranch').hide();
			} else {
				$('#spanFact').show();
				$('#factCode').show();
				$('#spanBranch').hide();
				$('#branchNo').hide();
			}
		}else{
			dropDownSet.attr("disabled", false);
			$.getJSON("<c:url value='/waterpolmnt/waterinfo/getGongkuList.do'/>", {system:system, sugye:sugyeCd}, function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
// 					console.log("data.gongku.length : ",data.gongku.length);
					if (data.gongku.length == 0) {
						dropDownSet.attr("disabled", true);
						dropDownSet.attr("style", "background:#e9e9e9;");
						
						dropDownSet.loadSelect_all(data.gongku);
						
					} else {
						if (data.gongku.length != 1) {
							dropDownSet.loadSelect_all(data.gongku);
						} else {
							dropDownSet.loadSelect(data.gongku);
							
							if (system == "U"){
								dropDownSet.attr("disabled", true);
								dropDownSet.attr("style", "background:#e9e9e9;");
							}
						}
					}
					
					if (isAutoSetLoad == true) {
						$('#factCode').val('${param.factCode}');
					}
					adjustBranch();
				} else { 
					alert("공구 목록 가져오기 실패");
					return;
				}
				
				//2014-10-28 검색 개선
				if($('#system').val() == 'U') {
					$('#spanFact').show();
					$('#branchNo').show();
					$('#factCode').hide();
					$('#spanBranch').hide();
				} else {
					$('#spanFact').show();
					$('#factCode').show();
					$('#spanBranch').hide();
					$('#branchNo').hide();
				}
			});
		}
	}
	
	//측정소 목록 가져오기
	function adjustBranch()
	{
		var factCode = $('#factCode').val();
		var dropDownSet = $('#branchNo');
		
		dropDownSet.attr("style", "background:#ffffff;");
		
		if( factCode == 'all' ){
			dropDownSet.attr("style", "background:#e9e9e9;");
			dropDownSet.attr("disabled", true);
			dropDownSet.emptySelect();
			$("#branchNo").append("<option value='all'>전체</option>");
		}else{
			dropDownSet.attr("disabled", false);
			$.getJSON("<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>", {factCode:factCode}, function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect_all(data.branch);
					
					if (isAutoSetLoad == true) {
						$('#branchNo').val('${param.branchNo}');
						loadAlertList();
						isAutoSetLoad == false;
					}
				} else {
					alert("공구 목록 가져오기 실패");
					return;
				}
				
				//2014-10-28 검색 개선
				if($('#system').val() == 'U') {
					$('#spanFact').show();
					$('#branchNo').show();
					$('#factCode').hide();
					$('#spanBranch').hide();
				} else {
					$('#spanFact').show();
					$('#factCode').show();
					$('#spanBranch').hide();
					$('#branchNo').hide();
				}
			});
		}
	}
	// 페이지 번호 클릭
	function linkPage(pageno){
		loadAlertList(pageno);
	}
	
	function validation(){
		if( $('#startDate').val() == "" ){ alert("조회 시작일자를 선택하세요"); return false; }
		if( $('#endDate').val() == "" ){ alert("조회 종료일자를 선택하세요"); return false; }
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
	
	function FnIsPassive(){
		//수동전파가 체크되면.
		if($("#isPassive").is(":checked")){
			$('#imgSystem').hide();
			$('#systemtitle').hide();
			$("#isAuto").val('manual');
		}else{
			$('#imgSystem').show();
			$('#systemtitle').show();
			$("#isAuto").val('all');
		}
	}
//]]>
</script>
</head>

<body>
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div id="wrap">
		
	<c:if test="${param.isPopup!='Y'}">
		<!-- Head Start-->
		<div id="header">
			<c:import url="/common/menu/header.do" />
		</div>
		<!-- Head End-->
	</c:if>
		
		<!-- Body Start-->
		<div id="container">
			<div id="content_wrapper">
			
			<c:if test="${param.isPopup!='Y'}">
				<!--left menu Start-->
				<c:import url="/common/menu/left.do" />
				<!--left menu End-->
			</c:if>
				<!-- Body Start-->
				<div id="content">
				
					<!-- navi, tab menu Start-->
					<c:import url="/common/menu/navi.do" />
					<!-- navi, tab menu End-->
					
					<!--tab Contnet Start-->
					<div class="tab_container">
					
						<!-- 경보 발령 이력 조회 -->
						<div class="searchBox dataSearch">
							<ul>
								<li  id="systemtitle" >
									<span class="fieldName">시스템</span>
									<select class="fixWidth13" id="system" name="system">
											<option value="U" selected="selected">이동형측정기기</option>
											<!-- <option value="T">탁수모니터링</option> -->
											<option value="A">국가수질자동측정망</option>
									</select>
								</li>
								<li>
									<span class="fieldName">측정소 위치</span>
									<select class="fixWidth7" id="sugye" name="sugye">
										<option value="all">전체</option>
										<option value="R01">한강</option>
										<option value="R02">낙동강</option>
										<option value="R03">금강</option>
										<option value="R04">영산강</option>
									</select>
									<span id="spanFact">&gt;</span>
										<select class="fixWidth11" id="factCode">
											<option value="all">전체</option>
										</select>
									<span id="spanBranch">&gt;</span>
									<select class="fixWidth11" id="branchNo" name="branchNo" disabled="disabled">
										<option value="all">전체</option>
									</select>
								</li>
								<li>
									<span class="fieldName">수동전파</span>
									<input type="checkbox" id="isPassive" onclick="javascript:FnIsPassive();"/>
								</li>
								<li>
									<span class="fieldName">조회기간</span>
									<input type="text" id="startDate" name="startDate" size="13" onchange="commonWork()" alt="조회시작일"/>
									<span>~</span>
									<input type="text" id="endDate" name="endDate" size="13" onchange="commonWork()" alt="조회종료일"/>
								</li>
								<li>
									<span class="fieldName">전파유형</span>
									<select id="type">
										<option value="ALL">전체</option>
										<option value="SMS">sms</option>
										<option value="ACS">acs</option>
									</select>
								</li>
								<li>
									<span class="fieldName">구분</span>
									<select id="isAuto">
										<option value="all">전체</option>
										<option value="auto">자동</option>
										<option value="manual">수동</option>
									</select>
								</li>
							</ul>
						</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:loadAlertList();" alt="조회하기" style="float:right;"/>
						</div>
						<!-- //경보 발령 이력 조회 -->
						
						<div id="btArea">
							<span id="p_total_cnt">[총 ${totCnt}건]</span>
						</div>
						
						<div class="table_wrapper">
							<table>
								<col width='45' />
								<col width='120' />
								<col width='130' />
								<col width='70' />
								<col width='110' />
								<col width='100' />
								<col width='80' />
								<col width='335' />
								<thead>
									<tr>
										<th scope='col'>NO        </th>
										<th scope='col'>발송시간  </th>
										<th scope='col'>소속      </th>
										<th scope='col'>성명      </th>
										<th scope='col'>전화번호  </th>
										<th scope='col'>유형      </th>
										<th scope='col'>수신여부  </th>
										<th scope='col'>전송메세지</th>
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
		
		<c:if test="${param.isPopup!='Y'}">
		<!-- Footer Start-->
		<div id="footer">
			<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
		<!-- Footer End-->
		</c:if>
	
</body>
</html>