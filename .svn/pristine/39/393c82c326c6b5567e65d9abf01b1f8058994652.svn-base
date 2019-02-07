<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : select_his.jsp
	 * Description : IP-USN정보 선별 이력 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2014.10.13	smji		최초 생성
	 * 
	 * author smji
	 * since 2011.10.13
	 * `
	 * Copyright (C) 2014 by smji  All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- <html xmlns="http://www.w3.org/1999/xhtml"> -->
<html>

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />

<script type="text/javascript">
//<![CDATA[
	$(document).ready(function(){
		var memFactCode = "${member.factCode}";
		var memRiverDiv = "${member.riverId}";
		selectedSugyeInMemberId(user_riverid,'riverDiv');
		
		//메시지처리
		<c:if test="${not empty message }">
			alert("${message}");
		</c:if>
		
		//공통코드 등록 레이어
		$("#layerImg").draggable({
			containment: 'body',
			scroll: false
		});

		var date = new Date();
		var hour = date.getHours();
		time=hour<10?"0"+hour:hour;
		t_time = hour-2>0?hour-2:0;
		fritime=t_time<10?"0"+t_time:t_time;
		$("#toTime option[value="+time+"]").attr("selected", "true");
		$("#frTime option[value="+fritime+"]").attr("selected", "true");
		
		var today = new Date(); 
		var yday = new Date(Date.parse(today) - 1 * 1000 * 60 * 60 * 12);
		
		yday = yday.getFullYear()+ "/" + addzero(yday.getMonth()+1) + "/" + addzero(yday.getDate());
		today = today.getFullYear()+ "/" + addzero(today.getMonth()+1) + "/" + addzero(today.getDate());
		
		function addzero(n) {
			 return n < 10 ? "0" + n : n + "";
		}
		
		$("#startDate").val(yday);
		$("#endDate").val(today);
	});
	
	var memFactCode = "${member.factCode}";
	var memRiverDiv = "${member.riverId}";
	
	$(function () {
		//user deptNo에 따른 수계 고정
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
			buttonText: '시작일'
		});
		$("#endDate").datepicker({
			buttonText: '종료일'
		});
		
		//시공사일경우 해당 공구만 선택할 수 있게
		if(memFactCode != null && memFactCode != "")
		{
			$("#riverDiv > option[value="+memRiverDiv+"]").attr("selected", "true");
			$("#riverDiv").attr("disabled", "disabled");
		}
		
		adjustFactList();
		
		$('#riverDiv').change(function(){
			adjustFactList();		//수계 2  조회
			adjustBranchList();	//수계 3  조회
		});
		
	});
	
	var itemCnt;
	
	var firstFlag = false;
	
	function adjustFactList()
	{
		var riverDiv = $('#riverDiv').val();
		
		var factCode = $('#factCode');
		var branchNo = $('#branchNo');
		
		factCode.attr("style", "background:#ffffff;");
		branchNo.attr("style", "background:#ffffff;");
		
		$.getJSON("<c:url value='/waterpolmnt/waterinfo/getGongkuList.do'/>",
				{sugye:riverDiv, system:'U'},
				function (data, status){
				if(status == 'success'){
					if (data.gongku.length != 1) {
						factCode.loadSelect_all(data.gongku);
					} else {
						factCode.loadSelect(data.gongku);
						factCode.attr("disabled", true);
						factCode.attr("style", "background:#e9e9e9;");
					}
					
					if(memFactCode != null && memFactCode != "")
					{
						$("#factCode>option[value="+memFactCode+"]").attr("selected", "selected");
						$("#factCode").attr("disabled", "disabled");
					}
					
					adjustBranchList();
					
					if(memFactCode == 'all')
						branchNo.attr("disabled", true);
				
				} else { 
					alert("공구 목록 가져오기 실패");
					return;
				}
		});
	}
	
	//측정소 목록 가져오기
	function adjustBranchList()
	{	
		var factCode = $('#factCode').val();
		
		var branchNo = $('#branchNo');
		branchNo.attr("disabled", false);
		var url = "<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>";
		$.getJSON(url, {factCode:factCode}, function (data, status){
			if(status == 'success'){
				branchNo.loadSelect_all(data.branch);
				if(!firstFlag){
					reloadData();
					firstFlag = true;
				}
			} else { 
				alert("공구 목록 가져오기 실패");
				return;
			}
		});
		
		//2014-10-27 mypark 검색개선
		$('#factCode').hide();
	}
	
	
	/* 초기값 셋팅 */
	function initializeSetting(){
		LayerDiv(1);
	}
	
	
	/* 데이터 조회 */
	function reloadData(){
		
		if( validation() == false ) return;
		
		showLoading();
		
		var riverDiv = $("#riverDiv").val();
		var factCode = $("#factCode").val();
		var branchNo = $("#branchNo").val();
		var str_time = $("#startDate").val2()+"0000";
		var end_time = $("#endDate").val2()+"2359";
		var sel_item = $("#sel_item").val();
		var del_yn = $("#del_yn").val();
		var use_flag = $("#use_flag").val();
		
		if(factCode == null || factCode == "unknowned" || riverDiv == null || riverDiv == "unknowned"){
			alert("측정소 정보가 없습니다.");
			return;
		}
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getSelectHisList.do'/>",
			data:{
					river_div:riverDiv,
					fact_code:factCode,
					branch_no:branchNo,
					str_time:str_time,
					end_time:end_time,
					sel_item:sel_item,
					del_yn:del_yn,
					use_flag:use_flag
			},
			dataType:"json",
			success:function(result){
// 				console.log("결과 값 확인 : ",result);
				
				initializeSetting();
				
				$("#river_div").val(riverDiv);
				$("#fact_code").val(factCode);
				$("#branch_no").val(branchNo);
				$("#str_time").val(str_time);
				$("#end_time").val(end_time);
				
				var tot = result['detailViewList'].length;
				if(tot == 0 || tot == 1){
					$("#main_display").css("height", "55px");
				}else if(tot<20){
					$("#main_display").css("height", (tot*27)+18 + "px");
				}else{
					$("#main_display").css("height", "558px");
				}
				
				// 조회 데이터 표출
				var html = "";
				var main_html = "";
				
				html += "<table>";
				html += "	<colgroup>";
				html += "		<col width='40px' />";
				html += "		<col width='70px' />";
				html += "		<col width='110px' />";
				html += "		<col width='245px' />";
				html += "		<col width='85px' />";
				html += "		<col width='75px' />";
				html += "		<col width='75px' />";
				html += "		<col width='75px' />";
				html += "		<col width='130px' />";
				html += "		<col width='75px' />";
				html += "		<col width='200px' />";
				html += "		<col width='75px' />";
				html += "		<col width='130px' />";
				html += "		<col width='70px' />";
				html += "	</colgroup>";
				main_html = html;
				
				if( tot <= 0 ){
					main_html += "<table><tr><td colspan='14'>조회 결과가 없습니다.</td></tr></table>";
					$("#main_display").html(main_html);
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['detailViewList'][i];
						
						var no = i+1;
						obj.no = no;
						
						var result_str_time = obj.str_time.substr(0,4)+"/"+obj.str_time.substr(4,2)+"/"+obj.str_time.substr(6,2)+" "+obj.str_time.substr(8,2)+":"+obj.str_time.substr(10,2);
						var result_end_time = obj.end_time.substr(0,4)+"/"+obj.end_time.substr(4,2)+"/"+obj.end_time.substr(6,2)+" "+obj.end_time.substr(8,2)+":"+obj.end_time.substr(10,2);
						obj.str_time = result_str_time+" ~ "+result_end_time;
						
						obj.reg_date = obj.reg_date.substr(0,4)+"/"+obj.reg_date.substr(4,2)+"/"+obj.reg_date.substr(6,2)+" "+obj.reg_date.substr(8,2)+":"+obj.reg_date.substr(10,2);
						if(obj.del_date != ""){
							obj.del_date = obj.del_date.substr(0,4)+"/"+obj.del_date.substr(4,2)+"/"+obj.del_date.substr(6,2)+" "+obj.del_date.substr(8,2)+":"+obj.del_date.substr(10,2);
						}
						
						var even = "";
						if(i%2 == 1){even = "even"}
						main_html += "	<tr class='tr"+i+" "+even+"'>";
						main_html += "		<td>"+obj.no+"</td>";
						main_html += "		<td>"+obj.river_name+"</td>";
						main_html += "		<td>"+obj.branch_name+"</td>";
						main_html += "		<td>"+obj.str_time+"</td>";
						main_html += "		<td>"+obj.sel_item+"</td>";
						main_html += "		<td>"+obj.limit_yn+"</td>";
						main_html += "		<td>"+obj.del_yn+"</td>";
						main_html += "		<td>"+obj.reg_name+"</td>";
						main_html += "		<td>"+obj.reg_date+"</td>";
						main_html += "		<td style='"+stColor(obj.use_flag)+"'>"+obj.use_flag+"</td>";
						main_html += "		<td>"+obj.sel_reason+"</td>";
						main_html += "		<td>"+obj.del_name+"</td>";
						main_html += "		<td>"+obj.del_date+"</td>";
						if(obj.atch_file_id != ""){
							main_html += "		<td><img src='/images/board/ico_file.gif' alt='첨부파일' onclick='imgPopup(\""+obj.atch_file_id+"\");' /></td>";
						}else{
							main_html += "		<td></td>";
						}
						main_html += "	</tr>";
					}
					main_html += "</table>";
					$("#main_display").html(main_html);
				}
				
				$("#p_total_cnt").html("▶ 검색결과 [총 " + result['totCnt'] + "건]");
				
				dataViewSet(result);
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
				alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				closeLoading();
			}
		});
	}
	
	function stColor(use_flag){
		var returnVal = "";
		
		if(use_flag == "선별취소"){
			returnVal += "color:red;";
		}
		return returnVal;
	}
	
	
	function dataViewSet(result){
		var html = "";
		var riverName = $("#riverDiv :selected").html();
		var branchName = $("#branchNo :selected").html();
		
		/* table01 내용 입력 시작 */
		var date = new Date();
		var hour = date.getHours();
		var min = date.getMinutes();
		var time="(시간 "+(hour<10?"0"+hour:hour)+":"+(min<10?"0"+min:min)+")";
		today = date.getFullYear()+ "년 " + addzero(date.getMonth()+1) + "월 " + addzero(date.getDate())+"일 "+time;
		
		html = "";
		html += "<tr>";
		html += "	<th>지역</th>";
		html += "	<th>지점</th>";
		html += "	<th>통보일</th>";
		html += "</tr>";
		html += "<tr>";
		html += "	<td>"+riverName+"</td>";
		html += "	<td>"+branchName+"</td>";
		html += "	<td>"+today+"</td>";
		html += "</tr>";
		$(".table01").html(html);
		/* table01 내용 입력 끝 */
		
		/* table02 내용 입력 시작 */
		var str_time = $("#startDate").val2();
		var end_time = $("#endDate").val2();
		str_time = str_time.substr(0,4)+"년 "+str_time.substr(4,2)+"월 "+str_time.substr(6,2)+"일 (시간 00:00)";
		end_time = end_time.substr(0,4)+"년 "+end_time.substr(4,2)+"월 "+end_time.substr(6,2)+"일 (시간 23:59)";
		
		html = "";
		html += "<tr>";
		html += "	<th>기간</th>";
		html += "</tr>";
		html += "<tr>";
		html += "	<td>"+str_time+" ~ "+end_time+"</td>";
		html += "</tr>";
		$(".table02").html(html);
		/* table02 내용 입력 끝 */
		
		/* table03 내용 입력 시작 */
		html = "";
		html += "<tr>";
		html += "	<th>일시</th>";
		html += "	<th>측정항목</th>";
		html += "	<th>선별기준</th>";
		html += "	<th>구분</th>";
		html += "	<th>이상데이터 선별사유</th>";
		html += "	<th>첨부</th>";
		html += "</tr>";
		
		var cnt = 0;
		var imgCnt = 0;
		for(var i=0; i < result['detailViewList'].length; i++){
			var obj = result['detailViewList'][i];
			if(obj.use_flag == "선별"){
				cnt++;
				if(obj.atch_file_id != ""){
					imgCnt++;
				}
				html += "<tr>";
				html += "	<td>"+obj.str_time+"</td>";
				html += "	<td>"+obj.sel_item+"</td>";
				html += "	<td>"+obj.limit_yn+"</td>";
				html += "	<td>"+obj.del_yn+"</td>";
				html += "	<td>"+obj.sel_reason+"</td>";
				if(obj.atch_file_id != ""){
					html += "	<td>첨부"+imgCnt+"</td>";
				}else{
					html += "	<td></td>";
				}
				html += "</tr>";
			}
		}
		if(cnt == 0){
			html += "<tr>";
			html += "	<td colspan='6'>조회 결과가 없습니다.</td>";
			html += "</tr>";
		}
		
		$(".table03").html(html);
		/* table03 내용 입력 끝 */
		
		/* table04 내용 입력 시작 */
		html = "";
		html += "<tr>";
		html += "	<td>";
		html += "		<ul>";
		html += "			<li></li>";
		html += "			<li></li>";
		html += "			<li>장비고장 시 정상가동 예정 일시 :</li>";
		html += "		</ul>";
		html += "	</td>";
		html += "</tr>";
		$(".table04").html(html);
		/* table04 내용 입력 끝 */
		
		/* table05 내용 입력 시작 */
		html = "";
		html += "<tr>";
		html += "	<th>소속</th>";
		html += "	<th>직책</th>";
		html += "	<th>성명</th>";
		html += "</tr>";
		html += "<tr>";
		html += "	<td><c:out value='${member.deptNoName}'/></td>";
		html += "	<td><c:out value='${member.gradeName}'/></td>";
		html += "	<td><c:out value='${member.memberName}'/></td>";
		html += "</tr>";
		$(".table05").html(html);
		/* table05 내용 입력 끝 */
		
		/* table06 내용 입력 시작 */
		html = "";
		imgCnt = 0;
		for(var i=0; i < result['detailViewList'].length; i++){
			var obj = result['detailViewList'][i];
			if(obj.use_flag == "선별" && obj.atch_file_id != ""){
				imgCnt++;
				html += "<tr>";
				html += "	<td>첨부"+imgCnt+"</td>";
				html += "	<td>";
				html += "		<div class='imgDiv'>";
				html += "			<img src=\"<c:url value='/cmmn/getImage.do'/>?atchFileId="+obj.atch_file_id+"&fileSn=0&thumbnailFlag=N\" />";
				html += "		</div>";
				html += "	</td>";
				html += "</td></tr>";
			}
		}
		if(imgCnt > 0){
			$(".fileDiv").show();
		}else{
			$(".fileDiv").hide();
		}
		$(".table06").html(html);
		/* table06 내용 입력 끝 */
	}
	
	function imgPopup(file_id){
		layerPopOpen("layerImg");
		$("#img_preview").attr("src", "<c:url value='/cmmn/getImage.do'/>?atchFileId="+file_id+"&fileSn=0&thumbnailFlag=N");
	}
	
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("layerImg");
	}
	
	
	function validation(){
		if( $('#startDate').val() == "" ){ alert("조회 시작일자를 선택하세요"); return false; }
		if( $('#endDate').val() == "" ){ alert("조회 종료일자를 선택하세요"); return false; }
		if(!timeCheck("startDate", "endDate", "frTime", "toTime", "", "")) {return false;}
	}
	
	function timeCheck(strDateId, endDateId, frTimeId, toTimeId, frSelMinId, toSelMinId)
	{
		var stdt = document.getElementById(strDateId);
		var endt = document.getElementById(endDateId);
		
		if(stdt.value == endt.value)
		{
			var frTime = $("#"+frTimeId).val();
			var toTime = $("#"+toTimeId).val();
			
			if(frTime > toTime)
			{
				alert("조회 종료시간이 시작시간보다 빠릅니다.\n\n다시 입력해 주십시오.");
				$("#"+frTimeId).val("");
				$("#"+toTimeId).val("");
				$("#"+frTimeId).focus();
				
				return false;
			}
			else if((frSelMinId != "" && toSelMinId != "") &&  frTime == toTime)
			{
				var frSelMin = $("#"+frSelMinId).val();
				var toSelMin = $("#"+toSelMinId).val();
				
				if(frSelMin > toSelMin)
				{
					alert("조회 종료시간이 시작시간보다 빠릅니다.\n\n다시 입력해 주십시오.");
					$("#"+frSelMinId).val("");
					$("#"+toSelMinId).val("");
					$("#"+frSelMinId).focus();
					
					return false;
				}
			}
		}
		
		return true;
	}
	
	function commonWork(strDateId, endDateId, frTimeId, toTimeId, frSelMinId, toSelMinId) {
		var stdt = document.getElementById(strDateId);
		var endt = document.getElementById(endDateId);
		var dateCheck = /^(19[7-9][0-9]|20\d{2})\/(0[0-9]|1[0-2])\/(0[1-9]|[1-2][0-9]|3[0-1])$/;
		
		
		if(stdt.value !=''){
			if(dateCheck.test(stdt.value)!=true){
				
				var returnValue = commonWork2(stdt.value, strDateId);
				
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
				
				var returnValue = commonWork2(endt.value, endDateId);
				
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
		var overdate = new Date(date + (60*60*24*31)*1000);
		var strdate = overdate.getFullYear()+ "/" + addzero(overdate.getMonth()+1) + "/" + addzero(overdate.getDate());
		
		if(endt.value != '' && stdt.value > endt.value) {
			alert("조회 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			stdt.value = "";
			endt.value = "";
			stdt.focus();
		}
		
		if(endt.value != '' && strdate < endt.value) {
			alert("조회 기간은 한달 이내 입니다.\n\n다시 입력해 주십시오.");
			stdt.value = "";
			endt.value = "";
			stdt.focus();
		}
		
		timeCheck(strDateId, endDateId, frTimeId, toTimeId, frSelMinId, toSelMinId);
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
	
	
	function selectPrint() {
		//프린트시 첨부 이미지는 다음장부터 나오도록 높이 조절
		var preHeight = $("#print_first").height();
		var height = Math.round(preHeight/1000)*1000;
		$("#print_first").height(height);
		
		var popupWindow = window.open("", "_blank" );
		 
		popupWindow.document.write( "<head>");
		popupWindow.document.write( $('head').html() );
		popupWindow.document.write( '</head>' ); 
		
		var $table = $("#print_div");
		 
		popupWindow.document.write( '<body><div id="container" style="padding:0;">' );
		popupWindow.document.write( $table.html() );
		popupWindow.document.write( '</div></body>' );

		popupWindow.document.close();
		
		popupWindow.print();
// 		popupWindow.close();
		
		//원래 높이로 재조정
		$("#print_first").height(preHeight);
	}
	
	function LayerDiv(div){
		for(var j=1;j<=2; j++){
			var pop = document.getElementById("tpl_tab_"+j);
			if(div==j){
				pop.style.display = "block";
			}else{
				pop.style.display = "none";
			}
		}
	}
	
	function excelDown() {
		var riverDiv = $("#riverDiv").val();
		var factCode = $("#factCode").val();
		var branchNo = $("#branchNo").val();
		var str_time = $("#startDate").val2()+"0000";
		var end_time = $("#endDate").val2()+"2359";
		var sel_item = $("#sel_item").val();
		var del_yn = $("#del_yn").val();
		var use_flag = $("#use_flag").val();
		if(factCode == null || factCode == "unknowned" || riverDiv == null || riverDiv == "unknowned"){
			alert("측정소 정보가 없습니다.");
			return;
		}
		
		var param = "river_div=" + riverDiv + "&fact_code=" + factCode + "&branch_no=" + branchNo +
			"&str_time=" + str_time + "&end_time=" + end_time +
			"&sel_item=" + sel_item + "&del_yn=" + del_yn + "&use_flag=" + use_flag;
		
		location.href="<c:url value='/waterpolmnt/waterinfo/getSelectHisListExcel.do'/>?"+param;
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
						
						<!-- 선별 데이터 조회 현황 -->
						<form:form commandName="selectDataVO" name="listFrm"  id="listFrm" method="post">
							<input type="hidden" name="river_div" id="river_div"/>
							<input type="hidden" name="fact_code" id="fact_code"/>
							<input type="hidden" name="branch_no" id="branch_no"/>
							<input type="hidden" name="str_time" id="str_time"/>
							<input type="hidden" name="end_time" id="end_time"/>
							
						<div class="searchBox dataSearch">
							<ul>
								<li>
									<span class="fieldName">측정소 위치</span>
									<select id="riverDiv" class="width70">
										<option value="R01">한강</option>
										<option value="R02">낙동강</option>
										<option value="R03">금강</option>
										<option value="R04">영산강</option>
									</select>
									 <span style="display:none;">&gt;</span>
									<select id="factCode" class="width110" name="factCode" style="display:none;">
										<option value="all">전체</option>
									</select>
									<span>&gt;</span>
									<select id="branchNo" class="width110" name="branchNo" disabled="disabled">
										<option value="all">전체</option>
									</select>
								</li>
								<li>
									<span class="fieldName">선별항목</span>
									<select id="sel_item" class="width110">
										<option value="all">전체</option>
										<option value="TUR00">탁도</option>
										<option value="DOW00">DO</option>
										<option value="TMP00">수온</option>
										<option value="PHY00">pH</option>
										<option value="CON00">전기전도도</option>
										<option value="TOF00">Chl-a</option>
									</select>
								</li>
								<li>
									<span class="fieldName">선별일시</span>
									<input type="text" id="startDate" name="startDate" size="13" onchange="commonWork('startDate','endDate','','','','')" alt="선별시작일"/>
									<span>~</span>
									<input type="text" id="endDate" name="endDate" size="13" onchange="commonWork('startDate','endDate','','','','')" alt="선별종료일"/>
								</li>
								<li>
									<span class="fieldName">적용여부</span>
									<select id="del_yn" class="width70">
										<option value="all">전체</option>
										<option value="Y">삭제</option>
										<option value="N">적용</option>
									</select>
								</li>
								<li>
									<span class="fieldName">선별구분</span>
									<select id="use_flag" class="width70">
										<option value="all">전체</option>
										<option value="Y">선별</option>
										<option value="N">선별취소</option>
									</select>
								</li>
							</ul>
						</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData();" alt="조회하기" style="float:right;"/>
						</div>
						</form:form>
						<!-- //하천 수질 조회 -->

						<div id="tpl_tab_1" style="display: block;">
							<div id="btArea" style="margin-top:0; border-top:2px;">
								<span id="p_total_cnt">▶ 검색결과 [총 ${totCnt}건]</span>
								<input type="button" id="excel" name="excel" class="btn btn_excel" onclick="javascript:excelDown();" alt="엑셀"/>
								<input type="button" value="이상데이터 사유 통보" class="btn btn_basic" onclick="javascript:LayerDiv(2);" alt="이상데이터 사유 통보"/>
							</div>
							
							<div id="div_result">
								<div id="top_display">
									<table>
										<colgroup>
											<col width="40px" />
											<col width="70px" />
											<col width="110px" />
											<col width="245px" />
											<col width="85px" />
											<col width="75px" />
											<col width="75px" />
											<col width="75px" />
											<col width="130px" />
											<col width="75px" />
											<col width="200px" />
											<col width="75px" />
											<col width="130px" />
											<col width="70px" />
										</colgroup>
										<tr>
											<th>NO</th>
											<th>수계</th>
											<th>측정소</th>
											<th>선별 데이터 기간</th>
											<th>선별항목</th>
											<th>선별기준</th>
											<th>적용여부</th>
											<th>작업자</th>
											<th>선별일자</th>
											<th>선별구분</th>
											<th>사유</th>
											<th>선별취소자</th>
											<th>선별취소일자</th>
											<th>첨부파일</th>
										</tr>
									</table>
								</div>
								
								<div id="main_display" onscroll="scrollAll();">
									<table>
										<colgroup>
											<col width="40px" />
											<col width="70px" />
											<col width="110px" />
											<col width="245px" />
											<col width="85px" />
											<col width="75px" />
											<col width="75px" />
											<col width="75px" />
											<col width="130px" />
											<col width="75px" />
											<col width="200px" />
											<col width="75px" />
											<col width="130px" />
											<col width="70px" />
										</colgroup>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
									</table>
								</div>
							</div>
							
						</div>
						
						<div id="tpl_tab_2" style="display: none;">
							<div id="btArea" style="margin-top:0; border-top:2px;">
								<input type="button" id="print" name="print" class="btn btn_print" onclick="javascript:selectPrint();" alt="프린트" />
								<input type="button" value="리스트" class="btn btn_basic" onclick="javascript:LayerDiv(1);" alt="리스트"/>
							</div>
						
							<div id="print_div">
								<div class="table_wrapper">
									<div id="dataView" class="dataView">
										<div id="print_first">
										
											<p class="top_line">이동형 측정기기 표준운영절차서</p>
											<h2>이동형 측정기기의 이상데이터 발생 사유 통보</h2>
											<p class="sub_tit">○ 측정기기 위치</p>
											<table class="table01">
												<tr>
													<th>지역</th>
													<th>지점</th>
													<th>통보일</th>
												</tr>
												<tr>
													<td></td>
													<td></td>
													<td></td>
												</tr>
											</table>
											
											<p class="sub_tit">○ 측정기기 기간 및 상세</p>
											<table class="table02">
												<tr>
													<th>기간</th>
												</tr>
												<tr>
													<td></td>
												</tr>
											</table>
											<table class="table03">
												<tr>
													<th>일시</th>
													<th>측정항목</th>
													<th>구분</th>
													<th>이상데이터 선별사유</th>
													<th>상태코드</th>
													<th>첨부</th>
												</tr>
												<tr>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
												</tr>
											</table>
											
											<p class="sub_tit">○ 기타사항</p>
											<table class="table04">
												<tr>
													<td>	</td>
												</tr>
											</table>
											
											<p class="sub_tit">○ 작성자</p>
											<table class="table05">
												<tr>
													<th>소속</th>
													<th>직책</th>
													<th>성명</th>
												</tr>
												<tr>
													<td></td>
													<td></td>
													<td></td>
												</tr>
											</table>
											
										</div>
										
										<div class="fileDiv" style="display:none;">
											<p class="middle_line"></p>
											<p class="sub_tit">○ 첨부파일</p>
											<table class="table06">
												<tr>
													<td>첨부1</td>
													<td>
														<div class='imgDiv'></div>
													</td>
												</tr>
											</table>
										</div>
										
									</div>
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
	<!-- //선택 수정 레이어 -->
	<div id="layerImg" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnImgXbox" name="btnImgXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerImg');" alt="닫기" />
		</div>
		<table style="width:100%; float:left; text-align:left; margin-bottom:10px" summary="선별정보">
			<tr>
				<td>
					<img id="img_preview" style="max-height:500px; max-width:500px;"/>
				</td>
			</tr>
		</table>
	</div>
	<!-- //선택 수정 레이어 -->
	
</body>
</html>