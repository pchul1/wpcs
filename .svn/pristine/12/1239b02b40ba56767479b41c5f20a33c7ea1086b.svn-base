<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : riverwater_u.jsp
	 * Description : IP-USN정보 화면
	 * Modification Information
	 * 
	 * 수정일			 수정자		수정내용
	 * ----------	--------	---------------------------
	 * 2010.05.17	khany		최초 생성
	 * 2013.10.20	lkh			리뉴얼
	 * 2014.10.27  mypark     검색개선
	 * 2014.11.14  mypark    그리드 걷어내고 테이블 처리
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
	//관리자 외에 등록 된 측정소가 없을 경우 메인으로 이동
	if(user_roleCode != 'ROLE_ADMIN'){
		if(user_u_cnt == 0){
			
		}
	}

//<![CDATA[
	$(document).ready(function(){
	
	//메시지처리
	<c:if test="${not empty message }">
		alert("${message}");
	</c:if>
	});
	
	var memFactCode = "${member.factCode}";
	var memRiverDiv = "${member.riverId}";
	var firstFlag = false;
	$(document).ready(function(){
		//초기 시작값의 현재 시각 선택
		var date = new Date();
		var hour = date.getHours();
		time=hour<10?"0"+hour:hour;
		t_time = hour-2>0?hour-2:0;
		fritime=t_time<10?"0"+t_time:t_time;
		$("#toTime option[value="+time+"]").attr("selected", "true");
		$("#frTime option[value="+fritime+"]").attr("selected", "true");
		
		//user 측정소권한에 따른 수계 고정
		if(user_roleCode == 'ROLE_ADMIN'){
			selectedSugyeInMemberId(user_riverid, 'sugye');
			
			adjustGongku();
		}else{
			selectedSugyeInMemberIdNew(id, 'U', 'sugye');
		}
		
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
		
		//시공사일경우 해당 공구만 선택할 수 있게
		if(memFactCode != null && memFactCode != "") {
			$("#sys > option[value=T]").attr("selected", "true");
			$("#sys").attr("disabled", "disabled");
			
			$("#sugye > option[value="+memRiverDiv+"]").attr("selected", "true");
			$("#sugye").attr("disabled", "disabled");
		}
		
// 		adjustGongku();
		
		$('#sugye').change(function(){
			adjustGongku();		//수계 2  조회
			adjustBranchListNew();	//수계 3  조회
		});
		
		$('#branchNo').change(function(){
			//setGraphBtn();
		});
	});
	
	//측정소가 전체가 아닐때만 그래프 버튼이 표시됩니다.
	function setGraphBtn() {
		if($('#branchNo').val() == "all") {
//			$('#a_chartPopup').attr("href", "#");
//			$('#img_chartPopup').hide();
// 			$('#a_chartPopup').attr("onclick", "#");
			$('#a_chartPopup').css("display","none");
		} else {
//			$('#a_chartPopup').attr("href","javascript:chartPopup()");
//			$('#img_chartPopup').fadeIn('fast');
			$('#a_chartPopup').attr("onclick","javascript:chartPopup()");
			$('#a_chartPopup').css("display","");
		}
	}
	
	function sysChange() {
		var sys_kind = $("#sys").val();
		
		if(sys_kind == "all") {
			$("#branchNo>option:first").attr("selected", "true");
			$("#factCode>option:first").attr("selected", "true");
			
			$("#branchNo").attr("disabled", "disabled");
			$("#factCode").attr("disabled", "disabled");
		} else {
			$("#branchNo>option:first").attr("selected", "true");
			$("#factCode>option:first").attr("selected", "true");
			
			$("#branchNo").attr("disabled", false);
			$("#factCode").attr("disabled", false);
		}

	}
	
	function adjustGongku() {
		//var sugyeCd = $('#sugye').val();
		//var sys_kind = $("#sys").val();
		
		var sugyeCd = $('#sugye').val();
		
		//IP-USN 전용페이지로 변경 - 2010. 10. 07
		//var sys_kind = $("#sys").val();
		
		var dropDownSet = $('#factCode');
		var dropDownSet_branchNo = $('#branchNo');
		
		dropDownSet.attr("style", "background:#ffffff;");
		dropDownSet_branchNo.attr("style", "background:#ffffff;");
		//IP-USN 전용페이지로 변경 - 2010. 10. 07
		if( sugyeCd == 'all'){// || sys_kind == 'all' ){
			dropDownSet.attr("disabled", true);
			$("#factCode>option:first").attr("selected", "true");
			dropDownSet_branchNo.attr("disabled", true);
			$("#branchNo>option:first").attr("selected", "true");
			dropDownSet.emptySelect();
		}else{
			//dropDownSet.attr("disabled", false);
			$.getJSON("<c:url value='/waterpolmnt/waterinfo/getGongkuList.do'/>",
					{sugye:sugyeCd, system:'U'},
					function (data, status){
					if(status == 'success'){
						dropDownSet.loadSelect(data.gongku);
						
						adjustBranchListNew();
					
					} else { 
						alert("공구 목록 가져오기 실패");
						return;
					}
			});
		}		
	}
		
	//측정소 목록 가져오기
	function adjustBranchList() {
		var factCode = $('#factCode').val();
		var sys_kind = $("#sys").val();
		
		var dropDownSet = $('#branchNo');
		if( factCode == 'all' || sys_kind == 'all' ){
			dropDownSet.attr("disabled", true);
			$("#branchNo>option:first").attr("selected", "true");
		}else{
			dropDownSet.attr("disabled", false);
			var url = "<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>";
			$.getJSON(url, {factCode:factCode}, function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect_all(data.branch);
					
					$("#branchNo>option[value="+data.branch[0].VALUE+"]").attr("selected", "selected");
					
					if(typeof(adjustItemList) == "function") {
						adjustItemList();
					}
					//$("#branchNo>option[value='"+branch+"']").attr("selected", "selected");
					
					if(!firstFlag) {
						reloadData();
					}
					
				} else { 
					alert("공구 목록 가져오기 실패");
					return;
				}
			});
		}
		
		//2014-10-27 mypark 검색개선
		$('#factCode').hide();
	}
	
	//측정소 목록 가져오기
	function adjustBranchListNew() {
		var url = "";
		
		if(user_roleCode == 'ROLE_ADMIN'){
			url = "<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>";
		}else{
			url = "<c:url value='/waterpolmnt/waterinfo/getBranchListNew.do'/>";
		}
		var factCode = $('#factCode').val();
		var sys_kind = $("#sys").val();
		
		var dropDownSet = $('#branchNo');
		if( factCode == 'all' || sys_kind == 'all' ){
			dropDownSet.attr("disabled", true);
			$("#branchNo>option:first").attr("selected", "true");
		}else{
			dropDownSet.attr("disabled", false);
			
			$.getJSON(url, {factCode:factCode}, function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect_all(data.branch);
					
					$("#branchNo>option[value="+data.branch[0].VALUE+"]").attr("selected", "selected");
					
					if(typeof(adjustItemList) == "function") {
						adjustItemList();
					}
					//$("#branchNo>option[value='"+branch+"']").attr("selected", "selected");
					
					if(!firstFlag) {
						reloadData();
					}
					
				} else { 
					alert("공구 목록 가져오기 실패");
					return;
				}
			});
		}
		
		//2014-10-27 mypark 검색개선
		$('#factCode').hide();
	}
	
	function excelDown() {
		
		if( validation() == false ) return;
		
		var sugye = $("#sugye").val();
		//var gongku = $("#gongku").val();
		var gongku = $("#factCode").val();
		//var chukjeongso = $("#chukjeongso").val();
		var chukjeongso = $("#branchNo").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();
		
		//IP-USN 전용페이지로 변경 - 2010. 10. 07
		//var sys = $("#sys").val();
		sys = 'U';
		var valid = 'all';
		
		var minor = $("#minorCheck").val();
		
		//if(valid == null || valid == undefined || valid == "")
		//	valid = "all";
		if(minor==null || minor==undefined||minor=="")
			minor = "all";
		
		var rType = $("#dataType").val();
		
		var param = "sugye=" + sugye + "&gongku=" + gongku + "&chukjeongso=" + chukjeongso +
			"&frDate=" + frDate + "&toDate=" + toDate + "&frTime=" + frTime + "&toTime=" + toTime + 
			"&sys=" + sys + 
			"&minor=" + minor +
			"&valid=" + valid +
			"&dataType=" + rType;
			
		location.href="<c:url value='/waterpolmnt/waterinfo/getExcelDetalViewRIVER.do'/>?"+param;
	}
	
	function chartPopup() {
		if( validation() == false ) return;
		
		var sugye = $("#sugye").val();
		var gongku = $("#factCode").val();
		var chukjeongso = $("#branchNo").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();
		var bItem = $("#item").val(); //대항목 선택값
		
		//IP-USN 전용페이지로 변경 - 2010. 10. 07
		var sys = 'U';
		var valid = 'all';
		var minor = $("#minorCheck").val();
		
		if(minor==null || minor==undefined||minor=="")
			minor = "all";
		
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 800;
		var winWidth = 1000;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-20;
		var height = winHeight-20;
		
		if(sugye == "01") {
			sugye = "R01";
		} else if(sugye == "02") {
			sugye = "R02";
		} else if(sugye == "03") {
			sugye = "R03";
		} else if(sugye == "04") {
			sugye = "R04";
		}
		
		var rType = $("#dataType").val();
		
		var param = "sugye=" + sugye 
			+ "&gongku=" + gongku 
			+ "&chukjeongso=" + chukjeongso 
			+ "&frDate=" + frDate 
			+ "&toDate=" + toDate 
			+ "&frTime=" + frTime 
			+ "&toTime=" + toTime 
			+ "&sys=" + sys 
			+ "&valid=" + valid 
			+ "&minor=" + minor 
			+ "&dataType=" + rType 
			+ "&width=" + (winWidth-40) 
			+ "&height=" + (winHeight-40) 
			+ "&item=" + bItem;
		
		window.open("<c:url value='/waterpolmnt/waterinfo/goChartDetailRIVER.do'/>?"+encodeURI(param), 
				'chartDetailViewRIVER','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	function reloadData(pageNo){		
		if( validation() == false ) return;
		
		setGraphBtn();
		showLoading();
		
		var sugye = $("#sugye").val();
		var gongku = $("#factCode").val();
		var chukjeongso = $("#branchNo").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();
		//IP-USN 전용페이지로 변경 - 2010. 10. 07
		var sys = 'U'; //$("#sys").val();
		var valid = 'all'; //$("#validFlag").val();
		var minor = $("#minorCheck").val();
		
		//if(valid == null || valid == undefined || valid == "")
		//	valid = "all";
		if(minor==null || minor==undefined||minor=="")
			minor = "all";
		if(gongku == null || gongku == "unknowned")
			gongku = "all";
		if(sugye == null || sugye == "unknowned")
			sugye = "all";
			
		//var lately = $("#lately").is(":checked");
		var lately = true;
		var orderType1 = lately ? "desc" : "asc";
		var useflag = ($("#past").is(":checked")) ? "all" : "";
			
		var rType = $("#dataType").val();
		
		if (pageNo == null) pageNo = 1;
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getDetailViewRIVER.do'/>",
			data:{
					sugye:sugye, 
					gongku:gongku,
					chukjeongso:chukjeongso,
					frDate:frDate,
					toDate:toDate,
					frTime:frTime,
					toTime:toTime,
					sys:sys,
					valid:valid,
					minor:minor,
					pageIndex:pageNo,
					dataType:rType,
					orderType1:orderType1,
					useflag:useflag
			},
			dataType:"json",
			success:function(result){
// 				console.log("결과 값 확인 : ",result);
				var tot = result['detailViewList'].length;
				var pageInfo = result['paginationInfo'];
				var dataHtml="";
				if( tot <= 0 ){
					dataHtml="<tr><td colspan='11'>조회 결과가 없습니다.</td></tr>";
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['detailViewList'][i];
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
						
						obj.tur = (obj.tur != null && obj.tur != '') ? obj.tur : '-';
						obj.tmp = (obj.tmp != null && obj.tmp != '') ? obj.tmp : '-';
						obj.phy = (obj.phy != null && obj.phy != '') ? obj.phy : '-';
						obj.dow = (obj.dow != null && obj.dow != '') ? obj.dow : '-';
						obj.con = (obj.con != null && obj.con != '') ? obj.con : '-';
						obj.tof = (obj.tof != null && obj.tof != '') ? obj.tof : '-';
						
						dataHtml += "<tr>";
						dataHtml += "<td>" + obj.no +"</td>";
						dataHtml += "<td>" + obj.river_name +"</td>";
						dataHtml += "<td>" + obj.branch_name +"</td>";
						dataHtml += "<td>" + obj.strdate +"</td>";
						dataHtml += "<td>" + obj.strtime +"</td>";
						dataHtml += "<td class='dt' style='"+stColor(obj.tur_or)+"'>" + obj.tur +"</td>";
						dataHtml += "<td class='dt' style='"+stColor(obj.tmp_or)+"'>" + obj.tmp +"</a></td>";
						dataHtml += "<td class='dt' style='"+stColor(obj.phy_or)+"'>" + obj.phy +"</td>";
						dataHtml += "<td class='dt' style='"+stColor(obj.dow_or)+"'>" + obj.dow +"</td>";
						dataHtml += "<td class='dt' style='"+stColor(obj.con_or)+"'>" + obj.con +"</a></td>";
						dataHtml += "<td class='dt' style='"+stColor(obj.tof_or)+"'>" + obj.tof +"</td>";
						dataHtml += "</tr>";
					}
				}
				
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
				$("#dataList tr:odd").attr("class","even");
				
				// 페이징 정보
				var pageStr = makePaginationInfo(result['paginationInfo']);
				$("#pagination").empty();
				$("#pagination").append(pageStr);
				
				$("#p_total_cnt").html("[총 " + result['totCnt'] + "건] <span class='red'>※조회결과는 확정자료가 아닙니다.</span>");
				//IP-USN 전용페이지로 변경 - 2010. 10. 07
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
				
				var dataHtml="<tr colspan='11'><td>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "</td></tr>";
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
				closeLoading();
			}
		});
	}
	
	function stColor(val_or){
		var returnVal = "";
		
		if(val_or > 0){
			returnVal += "color:red;";
		}
		return returnVal;
	}
	
	function validation(){
		if( $('#startDate').val() == "" ){ alert("조회 시작일자를 선택하세요"); return false; }
		if( $('#endDate').val() == "" ){ alert("조회 종료일자를 선택하세요"); return false; }
		if(!timeCheck()) {return false;}
	}
	
	function timeCheck() {
		var stdt = document.getElementById("startDate");
		var endt = document.getElementById("endDate");
		
		if(stdt.value == endt.value) {
			var frTime = $("#frTime").val();
			var toTime = $("#toTime").val();
			
			if(frTime > toTime) {
				alert("조회 종료시간이 시작시간보다 빠릅니다.\n\n다시 입력해 주십시오.");
				$("#frTime").val("");
				$("#toTime").val("");
				$("#frTime").focus();
				return false;
			}
		}
		return true;
	}
	
	function commonWork(n) {
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
		
		var date = new Date(stdt.value).getTime();
		var overdate =  new Date(date + (60*60*24*31)*1000);
		var strdate = overdate.getFullYear()+ "/" + addzero(overdate.getMonth()+1) + "/" + addzero(overdate.getDate());
		
		if(endt.value != '' && stdt.value > endt.value) {
			alert("조회 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			if($(n).attr("id") == "startDate") {endt.value = ""; endt.focus();}
			if($(n).attr("id") == "endDate") {stdt.value = ""; stdt.focus();}
		}
		
		if(endt.value != '' && strdate < endt.value) {
			alert("조회 기간은 한달 이내 입니다.\n\n다시 입력해 주십시오.");
			if($(n).attr("id") == "startDate") {endt.value = ""; endt.focus();}
			if($(n).attr("id") == "endDate") {stdt.value = ""; stdt.focus();}
		}
		
		timeCheck();
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
	
	// 페이지 번호 클릭
	function linkPage(pageNo){
		reloadData(pageNo);
	}
//]]>
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
						
						<!-- 수질 조회 현황 -->
						<form:form commandName="searchTaksuVO" name="listFrm"  id="listFrm" method="post">
							<input type="hidden" name="pageIndex" id="pageIndex" value="${searchTaksuVO.pageIndex}"/>
							<input type="hidden" name="chukjeongso" id="chukjeongso"/>
							<input type="hidden" name="gongku" id="gongku"/>
							<input type="hidden" name="sugye" id="river_div"/>
							<input type="hidden" name="frDate" id="frDate"/>
							<input type="hidden" name="toDate" id="toDate"/>
							<input type="hidden" name="item01" id="item01"/>
							<input type="hidden" name="item02" id="item02"/>
							<input type="hidden" name="item03" id="item03"/>
							<input type="hidden" name="item04" id="item04"/>
							<input type="hidden" name="item05" id="item05"/>
						
						<div class="searchBox dataSearch">
							<ul>
								<li>
									<span class="fieldName">측정소 위치</span>
									<select class="fixWidth7" id="sugye">
										<option value="R01">한강</option>
										<option value="R02">낙동강</option>
										<option value="R03">금강</option>
										<option value="R04">영산강</option>
									</select>
									<span style="display:none;">&gt;</span>
									<select class="fixWidth11" id="factCode" name="factCode" style="display:none;">
										<option value="all">전체</option>
									</select>
									<span>&gt;</span>
									<select class="fixWidth11" id="branchNo" name="branchNo" disabled="disabled">
										<option value="all">전체</option>
									</select>
								</li>
								<li>
									<span class="fieldName">조회기간</span>
									<input type="text" id="startDate" name="startDate" size="13" onchange="commonWork(this)" alt="조회시작일"/>
									<select id="frTime" name="frTime" onchange="commonWork(this)" style="width:45px">
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
									</select>
									<span>~</span>
									<input type="text" id="endDate" name="endDate" size="13" onchange="commonWork(this)" alt="조회종료일"/>
									<select id="toTime" name="toTime" onchange="commonWork(this)" style="width:45px">
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
									</select>
<!--									<label>&nbsp;최근 <input type="checkbox" name="lately" id="lately" checked="checked"/></label> -->
								</li>
								<li>
									<span class="fieldName">수집 주기</span>
									<select id="dataType" name="dataType">
										<option value="2">10분자료</option>
										<option value="1">1시간자료</option>
									</select>
								</li>
								<li>
									<span class="fieldName">기준치 구분</span>
									<select id="minorCheck" name="minor">
										<option value="all">전체</option>
										<option value="0">정상</option>
										<option value="1">기준초과</option>
									</select>
								</li>
								<li style="display:none;">
									<span class="fieldName">측정항목</span>
									<select id="item" name="bItem" style="width:126px">
										<option value="all">전체</option>
										<option value="TUR00">탁도</option>
										<option value="DOW00">DO</option>
										<option value="TMP00">수온</option>
										<option value="PHY00">pH</option>
										<option value="CON00">전기전도도</option>
										<option value="TOF00">Chl-a</option>
									</select>
								</li>
								<li style="display:none;">
									<span class="fieldName">과거자료포함</span>
									<input type="checkbox" name="past" id="past"/>
								</li>
							</ul>
						</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData();" alt="조회하기" style="float:right;"/>
						</div>
						</form:form>
						<!-- //하천 수질 조회 -->
						
						<div id="btArea">
							<span id="p_total_cnt">[총 ${totCnt}건]</span>
							<input type="button" id="a_chartPopup" name="a_chartPopup" class="btn btn_graph" style="display:none" alt="그래프" />
							<input type="button" id="excel" name="excel" class="btn btn_excel" onclick="javascript:excelDown();" alt="엑셀"/>
						</div>
						
						<div class="table_wrapper">
							<table summary="게시판 목록. 번호, 수계, 지역, 측정소, 수신일자, 수신시간, 탁도(NTU), 수온(℃), pH, DO(mg/L), EC(μS/cm), Chl-a(μg/L) 가 담김">
								<colgroup>
									<col width="45" />
									<col width="80" />
									<col width="110" />
									<col width="100" />
									<col width="80" />
									<col width="90" />
									<col width="90" />
									<col width="80" />
									<col width="90" />
									<col width="90" />
									<col width="105" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">No.</th>
										<th scope="col">수계</th>
										<th scope="col">측정소</th>
										<th scope="col">수신일자</th>
										<th scope="col">수신시간</th>
										<th scope="col">탁도(NTU)</th>
										<th scope="col">수온(℃)</th>
										<th scope="col">pH</th>
										<th scope="col">DO(mg/L)</th>
										<!-- <th scope="col">EC(mS/cm)</th> -->
										<th scope="col">EC(μS/cm)</th>
										<th scope="col">Chl-a(μg/L)</th>
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