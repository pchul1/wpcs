<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : select_definite.jsp
	 * Description : IP-USN정보 확정 데이터 조회
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2014.09.16	smji		최초 생성
	 * 
	 * author smji
	 * since 2014.09.16
	 * `
	 * Copyright (C) 2014 by smji  All right reserved.
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
// 			alert('권한이 없습니다. 측정소를 등록해주세요.');
// 			window.location = "<c:url value='/main.do'/>";
		}
	}
//<![CDATA[
	$(document).ready(function(){
		var memFactCode = "${member.factCode}";
		var memRiverDiv = "${member.riverId}";
		
		//user 측정소권한에 따른 수계 고정
		if(user_roleCode == 'ROLE_ADMIN'){
			selectedSugyeInMemberId(user_riverid, 'riverDiv');
			
			adjustGongku();
		}else{
			selectedSugyeInMemberIdNew(id, 'U', 'riverDiv');
		}
		
		//메시지처리
		<c:if test="${not empty message }">
			alert("${message}");
		</c:if>
		
		//공통코드 등록 레이어
		$("#layerSelectData").draggable({
			containment: 'body',
			scroll: false
		});
		
		$("#all_check").change(function(){
			if(this.checked){
				$(".inputCheck").attr("checked",true);
			}else{
				$(".inputCheck").attr("checked",false);
			}
		});
		
		$(".inputCheck").change(function(){
			var cnt = 0;
			for(var i=0;i<listFrm.item_code.length;i++){
				if(listFrm.item_code[i].checked){
					cnt++;
				};
			}
			if(listFrm.item_code.length > cnt){
				$("#all_check").attr("checked",false);
			}
		});
		
		function addzero(n) {
			return n < 10 ? "0" + n : n + "";
		}
		
		var today = new Date();
		var year = "";
		var pre_year = today.getFullYear()-6;
		
		var month = "";
		var day = "";
		
		if('${searchYear}' == ''){
			year = today.getFullYear();
		}else{
			year = '${searchYear}';
		}
		
		if('${searchMonth}' == ''){
			month = addzero(today.getMonth() + 1);
		}else{
			month = '${searchMonth}';
		}
		
		if('${searchDay1}' == ''){
			day = addzero(today.getDate());
		}else{
			day = '${searchDay1}';
		}
		
		
		if(month=='01'){
			year = year-1;
		}
		for(var i=pre_year ; i<=year ; i++){
			var temp_year = "";
			if(i == year){
				temp_year = "<option value='"+i+"' selected>"+i+"</option>";
			}else{
				temp_year = "<option value='"+i+"'>"+i+"</option>";
			}
			$("#searchYear").append(temp_year);
		}
		var pre_month;
		if(month=='01'){
			pre_month = 12;
			month = 13;
		}else{
			pre_month = (today.getMonth() + 1)-1;
		}
		for(var i=1 ; i<=month ; i++){
			var temp_month = "";
			var temp_i;
			if(i<10){
				temp_i = "0"+i;
			}else{
				temp_i = i;
			}
			//if(i == pre_month){
			if(i == month){
				temp_month = "<option value='"+temp_i+"' selected>"+temp_i+"</option>";
			}else{
				temp_month = "<option value='"+temp_i+"'>"+temp_i+"</option>";
			}
			$("#searchMonth").append(temp_month);
		}
		
		fnSearchDay();
		
	});
	
	var memFactCode = "${member.factCode}";
	var memRiverDiv = "${member.riverId}";
	
	$(function () {
		//시공사일경우 해당 공구만 선택할 수 있게
		if(memFactCode != null && memFactCode != "")
		{
			$("#riverDiv > option[value="+memRiverDiv+"]").attr("selected", "true");
			$("#riverDiv").attr("disabled", "disabled");
		}
		
// 		adjustFactList();
		
		$('#riverDiv').change(function(){
			adjustGongku();		//수계 2  조회
			adjustBranchList();	//수계 3  조회
		});
		
	});
	
	var itemCnt;
	
	//측정소가 전체가 아닐때만 그래프 버튼이 표시
	function setGraphBtn()
	{
		var param = "?fact_code=" + $("#factCode").val();
		param += "&branch_no=" + $("#branchNo").val();
		param += "&item_code=TUR00";
		param += "&min_time=" + $("#searchYear").val() + $("#searchMonth").val() + $("#searchDay1").val() + $("#searchDay2").val();
		window.open("<c:url value='/waterpolmnt/waterinfo/definiteDataChartView.do'/>"+ param,'Pop_graph','resizable=yes,scrollbars=yes,width=800,height=600');
	}
	
	var firstFlag = false;
	
	function adjustGongku()
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
					
					factCode.loadSelect(data.gongku);
					factCode.attr("disabled", true);
					factCode.attr("style", "background:#e9e9e9;");
					
					adjustBranchListNew();
					
				
				} else { 
					alert("공구 목록 가져오기 실패");
					return;
				}
		});
	}
	
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
					
					factCode.loadSelect(data.gongku);
					factCode.attr("disabled", true);
					factCode.attr("style", "background:#e9e9e9;");
					
					adjustBranchList();
					
				
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
// 				branchNo.loadSelect_all(data.branch);
				//2014.11.10 kyr 전체 삭제
				branchNo.loadSelect(data.branch);
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
	
	function adjustBranchListNew()
	{	
		var url = "";
		
		if(user_roleCode == 'ROLE_ADMIN'){
			url = "<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>";
		}else{
			url = "<c:url value='/waterpolmnt/waterinfo/getBranchListNew.do'/>";
		}
		
		var factCode = $('#factCode').val();
		var branchNo = $('#branchNo');
		branchNo.attr("disabled", false);
		$.getJSON(url, {factCode:factCode}, function (data, status){
			if(status == 'success'){
// 				branchNo.loadSelect_all(data.branch);
				//2014.11.10 kyr 전체 삭제
				branchNo.loadSelect(data.branch);
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
	
	/* 데이터 조회 */
	function reloadData(pageNo){
		
		//월 마지막 일자 구하기
		var newDay = new Date( $("#searchYear").val(), $("#searchMonth").val(), "");
	    var lastDay = newDay.getDate();
		
 		//if( validation() == false ) return;
		
		var riverDiv = $("#riverDiv").val();
		var factCode = $("#factCode").val();
		var branchNo = $("#branchNo").val();
// 		var str_time = $("#startDate").val2()+""+$("#frTime").val()+"00";
// 		var end_time = $("#endDate").val2()+""+$("#toTime").val()+"59";
		var searchYear = $("#searchYear").val();
		var searchMonth = $("#searchMonth").val();
		var searchDay1 = $("#searchDay1").val();
		var searchDay2 = $("#searchDay2").val();
		var data_type = $("#dataType").val();
		var definite_type = $("#definite_type").val();
		var strange = $("#strange").val();
		
		var definite_type = $("#definite_type").val();
		var tur_chk = "N";
		var tmp_chk = "N";
		var phy_chk = "N";
		var dow_chk = "N";
		var con_chk = "N";
		var tof_chk = "N";
		
		var item = $(".inputCheck");
		var item_list_text = "";
		var chk_cnt = 0;
		
		for(var i=0;i<item.length;i++){
			if(item[i].checked == true){
				if(chk_cnt == 0){
					chk_cnt++;
				}else{
					item_list_text += ",";
				}
				item_list_text += item[i].value;
				
				if(item[i].value == "TUR00"){
					tur_chk = "Y";
				}else if(item[i].value == "TMP00"){
					tmp_chk ="Y";
				}else if(item[i].value == "PHY00"){
					phy_chk ="Y";
				}else if(item[i].value == "DOW00"){
					dow_chk ="Y";
				}else if(item[i].value == "CON00"){
					con_chk ="Y";
				}else if(item[i].value == "TOF00"){
					tof_chk ="Y";
				}
			}
		}
		
		if(chk_cnt == 0){
			alert("측정항목을 선택하세요.");
			return;
		}
		
		if(factCode == null || factCode == "unknowned" || riverDiv == null || riverDiv == "unknowned"){
			alert("측정소 정보가 없습니다.");
			return;
		}
		
		var stdt = $("#searchDay1").val();
		var endt = $("#searchDay2").val();
			
		if(stdt > endt)
		{
			alert("조회 종료일자가 시작일자보다 빠릅니다.\n\n다시 선택해 주십시오.");
			return false;
		}
		
// 		setGraphBtn();
		showLoading();
		
		if (pageNo == null) pageNo = 1;
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getDefiniteDataList.do'/>",
			data:{
					river_div:riverDiv,
					fact_code:factCode,
					branch_no:branchNo,
					searchYear:searchYear,
					searchMonth:searchMonth,
					searchDay1:searchDay1,
					searchDay2:searchDay2,
					lastDay:lastDay,
 					item_list_text:item_list_text,
 					pageIndex:pageNo,
 					data_type:data_type,
 					definite_type:definite_type,
					strange:strange
			},
			dataType:"json",
			success:function(result){
// 				console.log("결과 값 확인 : ",result);
				
				$("#river_div").val(riverDiv);
				$("#fact_code").val(factCode);
				$("#branch_no").val(branchNo);
				$("#searchYear").val(searchYear);
				$("#searchMonth").val(searchMonth);
				$("#searchDay1").val(searchDay1);
				$("#searchDay2").val(searchDay2);
				
				var tot = result['detailViewList'].length;
				var pageInfo = result['paginationInfo'];
				
				if(tot == 0 || tot == 1){
					$("#main_display").css("height", "55px");
				}else if(tot<20){
					$("#main_display").css("height", (tot*27)+18 + "px");
				}else{
					$("#main_display").css("height", "558px");
				}
				
				// 조회 데이터 표출
				var html = "";
				
				html += "<table>";
				html += "<thead>";
				html += "	<colgroup>";
				html += "		<col width='40px' />";
				html += "		<col width='50px' />";
				html += "		<col width='80px' />";
				html += "		<col width='80px' />";
				html += "		<col width='55px' />";
				if(tur_chk == "Y"){
					if(definite_type == "all"){
						html += "		<col width='55px' />";
						html += "		<col width='55px' />";
					}else{
						html += "		<col width='55px' />";
					}
				}
				if(tmp_chk == "Y"){
					if(definite_type == "all"){
						html += "		<col width='55px' />";
						html += "		<col width='55px' />";
					}else{
						html += "		<col width='55px' />";
					}
				}
				if(phy_chk == "Y"){
					if(definite_type == "all"){
						html += "		<col width='55px' />";
						html += "		<col width='55px' />";
					}else{
						html += "		<col width='55px' />";
					}
				}
				if(dow_chk == "Y"){
					if(definite_type == "all"){
						html += "		<col width='55px' />";
						html += "		<col width='55px' />";
					}else{
						html += "		<col width='55px' />";
					}
				}
				if(con_chk == "Y"){
					if(definite_type == "all"){
						html += "		<col width='55px' />";
						html += "		<col width='55px' />";
					}else{
						html += "		<col width='55px' />";
					}
				}
				if(tof_chk == "Y"){
					if(definite_type == "all"){
						html += "		<col width='55px' />";
						html += "		<col width='55px' />";
					}else{
						html += "		<col width='55px' />";
					}
				}
				html += "	</colgroup>";
				
				html += "<thead>";
				html += "	<tr>";
				html += "		<th rowspan='2'>NO</th>";
				html += "		<th rowspan='2'>수계</th>";
				html += "		<th rowspan='2'>측정소</th>";
				html += "		<th rowspan='2'>수신일자</th>";
				html += "		<th rowspan='2'>수신시간</th>";
				
				if(tur_chk == "Y"){
					if(definite_type == "all"){
						html += "		<th colspan='2'>탁도(NTU)</th>";
					}else{
						html += "		<th>탁도(NTU)</th>";
					}
				}
				if(tmp_chk == "Y"){
					if(definite_type == "all"){
						html += "		<th colspan='2'>수온(℃)</th>";
					}else{
						html += "		<th>수온(℃)</th>";
					}
				}
				if(phy_chk == "Y"){
					if(definite_type == "all"){
						html += "		<th colspan='2'>pH</th>";
					}else{
						html += "		<th>pH</th>";
					}
				}
				if(dow_chk == "Y"){
					if(definite_type == "all"){
						html += "		<th colspan='2'>DO(mg/L)</th>";
					}else{
						html += "		<th>DO(mg/L)</th>";
					}
				}
				if(con_chk == "Y"){
					if(definite_type == "all"){
						html += "		<th colspan='2'>EC(mS/cm)</th>";
					}else{
						html += "		<th>EC(mS/cm)</th>";
					}
				}
				if(tof_chk == "Y"){
					if(definite_type == "all"){
						html += "		<th colspan='2'>Chl-a(μg/L)</th>";
					}else{
						html += "		<th>Chl-a(μg/L)</th>";
					}
				}
				html += "	</tr>";
				html += "	<tr>";
				
				if(tur_chk == "Y"){
					if(definite_type == "all" || definite_type == "before"){
						html += "		<th>확정전</th>";
					}
					if(definite_type == "all" || definite_type == "after"){
						html += "		<th>확정후</th>";
					}
				}
				if(tmp_chk == "Y"){
					if(definite_type == "all" || definite_type == "before"){
						html += "		<th>확정전</th>";
					}
					if(definite_type == "all" || definite_type == "after"){
						html += "		<th>확정후</th>";
					}
				}
				if(phy_chk == "Y"){
					if(definite_type == "all" || definite_type == "before"){
						html += "		<th>확정전</th>";
					}
					if(definite_type == "all" || definite_type == "after"){
						html += "		<th>확정후</th>";
					}
				}
				if(dow_chk == "Y"){
					if(definite_type == "all" || definite_type == "before"){
						html += "		<th>확정전</th>";
					}
					if(definite_type == "all" || definite_type == "after"){
						html += "		<th>확정후</th>";
					}
				}
				if(con_chk == "Y"){
					if(definite_type == "all" || definite_type == "before"){
						html += "		<th>확정전</th>";
					}
					if(definite_type == "all" || definite_type == "after"){
						html += "		<th>확정후</th>";
					}
				}
				if(tof_chk == "Y"){
					if(definite_type == "all" || definite_type == "before"){
						html += "		<th>확정전</th>";
					}
					if(definite_type == "all" || definite_type == "after"){
						html += "		<th>확정후</th>";
					}
				}
				html += "	</tr>";
				html += "</thead>";
				html += "<tbody>";
				
				if( tot <= 0 ){
					var length = 5;
					length = length+item.length;
					html += "<tr><td colspan='"+length+"' style='text-align:center;'>조회 결과가 없습니다.</td></tr>";
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
						
						obj.tur2 = (obj.tur2 != null && obj.tur2 != '') ? stValue(obj.tur2,obj.tur_st) : '-';
						obj.tmp2 = (obj.tmp2 != null && obj.tmp2 != '') ? stValue(obj.tmp2,obj.tmp_st) : '-';
						obj.phy2 = (obj.phy2 != null && obj.phy2 != '') ? stValue(obj.phy2,obj.phy_st) : '-';
						obj.dow2 = (obj.dow2 != null && obj.dow2 != '') ? stValue(obj.dow2,obj.dow_st) : '-';
						obj.con2 = (obj.con2 != null && obj.con2 != '') ? stValue(obj.con2,obj.con_st) : '-';
						obj.tof2 = (obj.tof2 != null && obj.tof2 != '') ? stValue(obj.tof2,obj.tof_st) : '-';
						
						html += "	<tr>";
						html += "		<td style='text-align:center;'>"+obj.no+"</td>";
						html += "		<td style='text-align:center;'>"+obj.river_name+"</td>";
						html += "		<td style='text-align:center;'>"+obj.branch_name+"</td>";
						html += "		<td style='text-align:center;'>"+obj.str_date+"</td>";
						html += "		<td style='text-align:center;'>"+obj.str_time+"</td>";
						
						if(tur_chk == "Y"){
							if(definite_type == "all" || definite_type == "before"){
								html += "		<td style='"+stColor(obj.tur, obj.tur_or, obj.tur_over, obj.tur_st)+";text-align:center;'>"+obj.tur+"</td>";
							}
							if(definite_type == "all" || definite_type == "after"){
								if(obj.tur_st2 != 0){
									html += "		<td style='"+stColor(obj.tur2, obj.tur_or, obj.tur_over, obj.tur_st2)+";text-align:center; cursor:pointer;' onclick=\"fnSelectReason(event,'"+obj.fact_code+"','"+obj.branch_no+"','TUR00','"+obj.min_time+"');\">"+obj.tur2+"</td>";	
								}else{
									html += "		<td style='"+stColor(obj.tur2, obj.tur_or, obj.tur_over, obj.tur_st2)+";text-align:center;'>"+obj.tur2+"</td>";	
								}
								
							}
						}
						if(tmp_chk == "Y"){
							if(definite_type == "all" || definite_type == "before"){
								html += "		<td style='"+stColor(obj.tmp, obj.tmp_or, obj.tmp_over, obj.tmp_st)+";text-align:center;'>"+obj.tmp+"</td>";
							}
							if(definite_type == "all" || definite_type == "after"){
								
								if(obj.tmp_st2 != 0){
									html += "		<td style='"+stColor(obj.tmp2, obj.tmp_or, obj.tmp_over, obj.tmp_st2)+";text-align:center; cursor:pointer;' onclick=\"fnSelectReason(event,'"+obj.fact_code+"','"+obj.branch_no+"','TMP00','"+obj.min_time+"');\">"+obj.tmp2+"</td>";	
								}else{
									html += "		<td style='"+stColor(obj.tmp2, obj.tmp_or, obj.tmp_over, obj.tmp_st2)+";text-align:center;'>"+obj.tmp2+"</td>";
								}
							}
						}
						if(phy_chk == "Y"){
							if(definite_type == "all" || definite_type == "before"){
								html += "		<td style='"+stColor(obj.phy, obj.phy_or, obj.phy_over, obj.phy_st)+";text-align:center;'>"+obj.phy+"</td>";
							}
							if(definite_type == "all" || definite_type == "after"){
								if(obj.phy_st2 != 0){
									html += "		<td style='"+stColor(obj.phy2, obj.phy_or, obj.phy_over, obj.phy_st2)+";text-align:center; cursor:pointer;' onclick=\"fnSelectReason(event,'"+obj.fact_code+"','"+obj.branch_no+"','PHY00','"+obj.min_time+"');\">"+obj.phy2+"</td>";	
								}else{
									html += "		<td style='"+stColor(obj.phy2, obj.phy_or, obj.phy_over, obj.phy_st2)+";text-align:center;'>"+obj.phy2+"</td>";
								}
							}
						}
						if(dow_chk == "Y"){
							if(definite_type == "all" || definite_type == "before"){
								html += "		<td style='"+stColor(obj.dow, obj.dow_or, obj.dow_over, obj.dow_st)+";text-align:center;'>"+obj.dow+"</td>";
							}
							if(definite_type == "all" || definite_type == "after"){
								if(obj.dow_st2 != 0){
									html += "		<td style='"+stColor(obj.dow2, obj.dow_or, obj.dow_over, obj.dow_st2)+";text-align:center; cursor:pointer;' onclick=\"fnSelectReason(event,'"+obj.fact_code+"','"+obj.branch_no+"','DOW00','"+obj.min_time+"');\">"+obj.dow2+"</td>";	
								}else{
									html += "		<td style='"+stColor(obj.dow2, obj.dow_or, obj.dow_over, obj.dow_st2)+";text-align:center;'>"+obj.dow2+"</td>";
								}
							}
						}
						if(con_chk == "Y"){
							if(definite_type == "all" || definite_type == "before"){
								html += "		<td style='"+stColor(obj.con, obj.con_or, obj.con_over, obj.con_st)+";text-align:center;'>"+obj.con+"</td>";
							}
							if(definite_type == "all" || definite_type == "after"){
								if(obj.con_st2 != 0){
									html += "		<td style='"+stColor(obj.con2, obj.con_or, obj.con_over, obj.con_st2)+";text-align:center; cursor:pointer;' onclick=\"fnSelectReason(event,'"+obj.fact_code+"','"+obj.branch_no+"','CON00','"+obj.min_time+"');\">"+obj.con2+"</td>";	
								}else{
									html += "		<td style='"+stColor(obj.con2, obj.con_or, obj.con_over, obj.con_st2)+";text-align:center;'>"+obj.con2+"</td>";
								}
							}
						}
						if(tof_chk == "Y"){
							if(definite_type == "all" || definite_type == "before"){
								html += "		<td style='"+stColor(obj.tof, obj.tof_or, obj.tof_over, obj.tof_st)+";text-align:center;'>"+obj.tof+"</td>";
							}
							if(definite_type == "all" || definite_type == "after"){
								if(obj.tof_st2 != 0){
									html += "		<td style='"+stColor(obj.tof2, obj.tof_or, obj.tof_over, obj.tof_st2)+";text-align:center; cursor:pointer;' onclick=\"fnSelectReason(event,'"+obj.fact_code+"','"+obj.branch_no+"','TOF00','"+obj.min_time+"');\">"+obj.tof2+"</td>";	
								}else{
									html += "		<td style='"+stColor(obj.tof2, obj.tof_or, obj.tof_over, obj.tof_st2)+";text-align:center;'>"+obj.tof2+"</td>";
								}
							}
						}
						html += "	</tr>";
					}
					html += "</tbody>";
					html += "</table>";
				}
				$("#div_result").html(html);
				$("#div_result tbody tr:odd").addClass("even");	
				
				// 연산 데이터 표출 (최소, 최대, 평균)
				var sumData = result['sumData'];
				$(".tur_dis_th").hide();
				$(".tmp_dis_th").hide();
				$(".phy_dis_th").hide();
				$(".dow_dis_th").hide();
				$(".con_dis_th").hide();
				$(".tof_dis_th").hide();
				$(".tur_dis").hide();
				$(".tmp_dis").hide();
				$(".phy_dis").hide();
				$(".dow_dis").hide();
				$(".con_dis").hide();
				$(".tof_dis").hide();
				$(".tur2_dis").hide();
				$(".tmp2_dis").hide();
				$(".phy2_dis").hide();
				$(".dow2_dis").hide();
				$(".con2_dis").hide();
				$(".tof2_dis").hide();
				
				sumData.tur_min = (sumData.tur_min != null && sumData.tur_min != '') ? sumData.tur_min : '-';
				sumData.tur2_min = (sumData.tur2_min != null && sumData.tur2_min != '') ? sumData.tur2_min : '-';
				sumData.tmp_min = (sumData.tmp_min != null && sumData.tmp_min != '') ? sumData.tmp_min : '-';
				sumData.tmp2_min = (sumData.tmp2_min != null && sumData.tmp2_min != '') ? sumData.tmp2_min : '-';
				sumData.phy_min = (sumData.phy_min != null && sumData.phy_min != '') ? sumData.phy_min : '-';
				sumData.phy2_min = (sumData.phy2_min != null && sumData.phy2_min != '') ? sumData.phy2_min : '-';
				sumData.dow_min = (sumData.dow_min != null && sumData.dow_min != '') ? sumData.dow_min : '-';
				sumData.dow2_min = (sumData.dow2_min != null && sumData.dow2_min != '') ? sumData.dow2_min : '-';
				sumData.con_min = (sumData.con_min != null && sumData.con_min != '') ? sumData.con_min : '-';
				sumData.con2_min = (sumData.con2_min != null && sumData.con2_min != '') ? sumData.con2_min : '-';
				sumData.tof_min = (sumData.tof_min != null && sumData.tof_min != '') ? sumData.tof_min : '-';
				sumData.tof2_min = (sumData.tof2_min != null && sumData.tof2_min != '') ? sumData.tof2_min : '-';
				
				sumData.tur_max = (sumData.tur_max != null && sumData.tur_max != '') ? sumData.tur_max : '-';
				sumData.tur2_max = (sumData.tur2_max != null && sumData.tur2_max != '') ? sumData.tur2_max : '-';
				sumData.tmp_max = (sumData.tmp_max != null && sumData.tmp_max != '') ? sumData.tmp_max : '-';
				sumData.tmp2_max = (sumData.tmp2_max != null && sumData.tmp2_max != '') ? sumData.tmp2_max : '-';
				sumData.phy_max = (sumData.phy_max != null && sumData.phy_max != '') ? sumData.phy_max : '-';
				sumData.phy2_max = (sumData.phy2_max != null && sumData.phy2_max != '') ? sumData.phy2_max : '-';
				sumData.dow_max = (sumData.dow_max != null && sumData.dow_max != '') ? sumData.dow_max : '-';
				sumData.dow2_max = (sumData.dow2_max != null && sumData.dow2_max != '') ? sumData.dow2_max : '-';
				sumData.con_max = (sumData.con_max != null && sumData.con_max != '') ? sumData.con_max : '-';
				sumData.con2_max = (sumData.con2_max != null && sumData.con2_max != '') ? sumData.con2_max : '-';
				sumData.tof_max = (sumData.tof_max != null && sumData.tof_max != '') ? sumData.tof_max : '-';
				sumData.tof2_max = (sumData.tof2_max != null && sumData.tof2_max != '') ? sumData.tof2_max : '-';
				
				sumData.tur_avg = (sumData.tur_avg != null && sumData.tur_avg != '') ? sumData.tur_avg : '-';
				sumData.tur2_avg = (sumData.tur2_avg != null && sumData.tur2_avg != '') ? sumData.tur2_avg : '-';
				sumData.tmp_avg = (sumData.tmp_avg != null && sumData.tmp_avg != '') ? sumData.tmp_avg : '-';
				sumData.tmp2_avg = (sumData.tmp2_avg != null && sumData.tmp2_avg != '') ? sumData.tmp2_avg : '-';
				sumData.phy_avg = (sumData.phy_avg != null && sumData.phy_avg != '') ? sumData.phy_avg : '-';
				sumData.phy2_avg = (sumData.phy2_avg != null && sumData.phy2_avg != '') ? sumData.phy2_avg : '-';
				sumData.dow_avg = (sumData.dow_avg != null && sumData.dow_avg != '') ? sumData.dow_avg : '-';
				sumData.dow2_avg = (sumData.dow2_avg != null && sumData.dow2_avg != '') ? sumData.dow2_avg : '-';
				sumData.con_avg = (sumData.con_avg != null && sumData.con_avg != '') ? sumData.con_avg : '-';
				sumData.con2_avg = (sumData.con2_avg != null && sumData.con2_avg != '') ? sumData.con2_avg : '-';
				sumData.tof_avg = (sumData.tof_avg != null && sumData.tof_avg != '') ? sumData.tof_avg : '-';
				sumData.tof2_avg = (sumData.tof2_avg != null && sumData.tof2_avg != '') ? sumData.tof2_avg : '-';
				
				if(tur_chk == "Y"){
					$(".tur_dis_th").show();
					if(definite_type == 'all'){
						$(".tur_dis_th").attr("colspan","2");
					}else{
						$(".tur_dis_th").attr("colspan","1");
					}
					if(definite_type == 'all' || definite_type == 'before'){
						$(".tur_dis").show();
						$("#tur_min").html(sumData.tur_min);
						$("#tur_max").html(sumData.tur_max);
						$("#tur_avg").html(sumData.tur_avg);
					}
					if(definite_type == 'all' || definite_type == 'after'){
						$(".tur2_dis").show();
						$("#tur2_min").html(sumData.tur2_min);
						$("#tur2_max").html(sumData.tur2_max);
						$("#tur2_avg").html(sumData.tur2_avg);
					}
				}
				if(tmp_chk == "Y"){
					$(".tmp_dis_th").show();
					if(definite_type == 'all'){
						$(".tmp_dis_th").attr("colspan","2");
					}else{
						$(".tmp_dis_th").attr("colspan","1");
					}
					if(definite_type == 'all' || definite_type == 'before'){
						$(".tmp_dis").show();
						$("#tmp_min").html(sumData.tmp_min);
						$("#tmp_max").html(sumData.tmp_max);
						$("#tmp_avg").html(sumData.tmp_avg);
					}
					if(definite_type == 'all' || definite_type == 'after'){
						$(".tmp2_dis").show();
						$("#tmp2_min").html(sumData.tmp2_min);
						$("#tmp2_max").html(sumData.tmp2_max);
						$("#tmp2_avg").html(sumData.tmp2_avg);
					}
				}
				if(phy_chk == "Y"){
					$(".phy_dis_th").show();
					if(definite_type == 'all'){
						$(".phy_dis_th").attr("colspan","2");
					}else{
						$(".phy_dis_th").attr("colspan","1");
					}
					if(definite_type == 'all' || definite_type == 'before'){
						$(".phy_dis").show();
						$("#phy_min").html(sumData.phy_min);
						$("#phy_max").html(sumData.phy_max);
						$("#phy_avg").html(sumData.phy_avg);
					}
					if(definite_type == 'all' || definite_type == 'after'){
						$(".phy2_dis").show();
						$("#phy2_min").html(sumData.phy2_min);
						$("#phy2_max").html(sumData.phy2_max);
						$("#phy2_avg").html(sumData.phy2_avg);
					}
				}
				if(dow_chk == "Y"){
					$(".dow_dis_th").show();
					if(definite_type == 'all'){
						$(".dow_dis_th").attr("colspan","2");
					}else{
						$(".dow_dis_th").attr("colspan","1");
					}
					if(definite_type == 'all' || definite_type == 'before'){
						$(".dow_dis").show();
						$("#dow_min").html(sumData.dow_min);
						$("#dow_max").html(sumData.dow_max);
						$("#dow_avg").html(sumData.dow_avg);
					}
					if(definite_type == 'all' || definite_type == 'after'){
						$(".dow2_dis").show();
						$("#dow2_min").html(sumData.dow2_min);
						$("#dow2_max").html(sumData.dow2_max);
						$("#dow2_avg").html(sumData.dow2_avg);
					}
				}
				if(con_chk == "Y"){
					$(".con_dis_th").show();
					if(definite_type == 'all'){
						$(".con_dis_th").attr("colspan","2");
					}else{
						$(".con_dis_th").attr("colspan","1");
					}
					if(definite_type == 'all' || definite_type == 'before'){
						$(".con_dis").show();
						$("#con_min").html(sumData.con_min);
						$("#con_max").html(sumData.con_max);
						$("#con_avg").html(sumData.con_avg);
					}
					if(definite_type == 'all' || definite_type == 'after'){
						$(".con2_dis").show();
						$("#con2_min").html(sumData.con2_min);
						$("#con2_max").html(sumData.con2_max);
						$("#con2_avg").html(sumData.con2_avg);
					}
				}
				if(tof_chk == "Y"){
					$(".tof_dis_th").show();
					if(definite_type == 'all'){
						$(".tof_dis_th").attr("colspan","2");
					}else{
						$(".tof_dis_th").attr("colspan","1");
					}
					if(definite_type == 'all' || definite_type == 'before'){
						$(".tof_dis").show();
						$("#tof_min").html(sumData.tof_min);
						$("#tof_max").html(sumData.tof_max);
						$("#tof_avg").html(sumData.tof_avg);
					}
					if(definite_type == 'all' || definite_type == 'after'){
						$(".tof2_dis").show();
						$("#tof2_min").html(sumData.tof2_min);
						$("#tof2_max").html(sumData.tof2_max);
						$("#tof2_avg").html(sumData.tof2_avg);
					}
				}
				
				// 페이징 정보
				var pageStr = makePaginationInfo(result['paginationInfo']);
				$("#pagination").empty();
				$("#pagination").append(pageStr);
				
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
	
	
	function stValue(value, val_st){
		var returnVal = "";
		if(value == "999,999.00" || value == "999,999.000"){
			if(val_st != null){
// 				if(val_st == 0){returnVal = "장비정상";}
				if(val_st == 0){returnVal = "D";}
				if(val_st == 1){returnVal = "가동중지";}
				if(val_st == 2){returnVal = "환경변화";}
				if(val_st == 3){returnVal = "교정중";}
				if(val_st == 4){returnVal = "점검보수중";}
				if(val_st == 5){returnVal = "통신관련";}
				if(val_st == 6){returnVal = "장비이상";}
				if(val_st == 7){returnVal = "전원이상";}
				if(val_st == 8){returnVal = "시운전";}
				if(val_st == 9){returnVal = "재전송";}
			}else{
 				returnVal = "삭제";
			}
		}else{
			returnVal = value;
		}
		return returnVal;
	}

	function stColor(value, val_or, val_over, val_st){
		var returnVal = "";
		
		if(val_over > 0){
			returnVal += "background:#FFD8D8; ";
		}
		if(value == "999,999.00"){
			returnVal += "background:#D9E5FF; ";
		}else if(value == "-"){
// 			returnVal += "background:none; ";
		}
		
		if(val_or > 0){
			returnVal += "color:red;";
		}else{
			if(val_st > 0){
				returnVal += "font-weight:bold;";
				if(val_st == 1){returnVal += "color:#AB9C12;";}
				if(val_st == 2){returnVal += "color:#2F9D27;";}
				if(val_st == 3){returnVal += "color:#5CD1E5;";}
				if(val_st == 4){returnVal += "color:#6799FF;";}
				if(val_st == 5){returnVal += "color:#A6A6A6;";}
				if(val_st == 6){returnVal += "color:#F361DC;";}
				if(val_st == 7){returnVal += "color:#F361A6;";}
				if(val_st == 8){returnVal += "color:#2F9D27;";}
				if(val_st == 9){returnVal += "color:#2F9D27;";}
			}
		}
		return returnVal;
	}
	
	
	function validation(){
		if(!dayCheck("searchDay1", "searchDay2")) {return false;}
	}
	
	function dayCheck(strDateId, endDateId)
	{
		var stdt = document.getElementById(strDateId);
		var endt = document.getElementById(endDateId);
			
		if(stdt > endt)
		{
			alert("조회 종료일자가 시작일자보다 빠릅니다.\n\n다시 선택해 주십시오.");
			return false;
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
		var overdate =  new Date(date + (60*60*24*31)*1000);
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
	
	
	function excelDown() {
		//월 마지막 일자 구하기
		var newDay = new Date( $("#searchYear").val(), $("#searchMonth").val(), "");
	    var lastDay = newDay.getDate();
	    
		var riverDiv = $("#riverDiv").val();
		var factCode = $("#factCode").val();
		var branchNo = $("#branchNo").val();
// 		var str_time = $("#startDate").val2()+""+$("#frTime").val()+"00";
// 		var end_time = $("#endDate").val2()+""+$("#toTime").val()+"59";
		var searchYear = $("#searchYear").val();
		var searchMonth = $("#searchMonth").val();
		var searchDay1 = $("#searchDay1").val();
		var searchDay2 = $("#searchDay2").val();
		var definite_type = $("#definite_type").val();
		var strange = $("#strange").val();
		
		var item = $(".inputCheck");
		var item_list_text = "";
		var chk_cnt = 0;
		
		for(var i=0;i<item.length;i++){
			if(item[i].checked == true){
				if(chk_cnt == 0){
					chk_cnt++;
				}else{
					item_list_text += ",";
				}
				item_list_text += item[i].value;
			}
		}
		
		if(chk_cnt == 0){
			alert("측정항목을 선택하세요.");
			return;
		}
		
		if(factCode == null || factCode == "unknowned" || riverDiv == null || riverDiv == "unknowned"){
			alert("측정소 정보가 없습니다.");
			return;
		}
		
		var param = "river_div=" + riverDiv + "&fact_code=" + factCode + "&branch_no=" + branchNo +
			"&searchYear=" + searchYear + "&searchMonth=" + searchMonth + "&searchDay1=" + searchDay1 + "&searchDay2=" + searchDay2 +
			"&definite_type=" + definite_type + "&strange=" + strange + "&item_list_text=" + item_list_text+"&lastDay="+lastDay;
		
		location.href="<c:url value='/waterpolmnt/waterinfo/getDefiniteDataListExcel.do'/>?"+param;
	}
	
	// 페이지 번호 클릭
	function linkPage(pageNo){
		reloadData(pageNo);
	}
	
	function fnSelectReason(e, fact_code, branch_no, item_code, min_time){
// 		layerPopCloseAll();
		$('#layerSelectDataReason').hide();

		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getSelectDataReason.do'/>",
			data:{
					fact_code:fact_code,
					branch_no:branch_no,
					item_code:item_code,
					min_time:min_time
			},
			dataType:"json",
			success:function(result){
				var item = "";
				var obj = result['selectDataReason'];
				item += obj.status_content+"<br />"+obj.sel_reason
				$("#selectDataReason").html(item);
					
// 				layerPopOpen("layerSelectDataReason");
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
			}
		});
		
		 var divTop = e.clientY; //상단 좌표
		 var divLeft = e.clientX - 250; //좌측 좌표

		 var name="layerSelectDataReason";
			
		var win = $(window);
		var winH = divTop;
		var winW =divLeft;
		$('#'+ name).css('top', winH);
		$('#'+ name).css('left', winW);
		$('#'+ name).show();
		$('#'+ name).focus();
	}
	
	function fnSearchMonth(){
		var searchYear = $('#searchYear').val();
		var today = new Date();
		var year = today.getFullYear();
		
		$("select[name='searchMonth']").find('option').each(function() {
		    $(this).remove();
		   });
		
		if(searchYear<year){
			for(var i=1 ; i<13 ; i++){
				var temp_month = "";
				var temp_i;
				
				if(i<10){
					temp_i = "0"+i;
				}else{
					temp_i = i;
				}
				
				temp_month = "<option value='"+temp_i+"'>"+temp_i+"</option>";
				$("#searchMonth").append(temp_month);
			}
		}
		
		if(searchYear==year){
			var month = addzero(today.getMonth() + 1);
			
			if(month=='01'){
				pre_month = 12;
				month = 13;
			}else{
				pre_month = (today.getMonth() + 1)-1;
			}
			
			for(var i=1 ; i<=month ; i++){
				var temp_month = "";
				var temp_i;
				if(i<10){
					temp_i = "0"+i;
				}else{
					temp_i = i;
				}
				//if(i == pre_month){
				if(i == month){
					temp_month = "<option value='"+temp_i+"' selected>"+temp_i+"</option>";
				}else{
					temp_month = "<option value='"+temp_i+"'>"+temp_i+"</option>";
				}
				$("#searchMonth").append(temp_month);
			}
		}
	}
	
	function fnSearchDay()
	{
		var searchYear = $('#searchYear').val();
		var searchMonth = $('#searchMonth').val();
		var lastday = ( new Date(searchYear, searchMonth, 0) ).getDate();
		
		$("select[name='searchDay1']").find('option').remove();
		$("select[name='searchDay2']").find('option').remove();

		for(var i=1 ; i<=lastday ; i++){
			var temp_i;
			
			if(i<10){
				temp_i = "0"+i;
			}else{
				temp_i = i;
			}
			
			$("#searchDay1").append("<option value='"+temp_i+"'>"+temp_i+"</option>");
			$("#searchDay2").append("<option value='"+temp_i+"'>"+temp_i+"</option>");
		}
		
	}
	
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("layerSelectDataReason");
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
									<span class="fieldName">조회구분</span>
									<select id="definite_type" class="width70">
										<option value="all">전체</option>
										<option value="before">확정전</option>
										<option value="after">확정후</option>
									</select>
								</li>
								<li>
									<span class="fieldName">조회기간</span>
									<select name="searchYear" id="searchYear" style="width: 60px" onchange="fnSearchMonth();">
									</select>
									<select name="searchMonth" id="searchMonth" style="width: 50px" onchange="fnSearchDay();">
									</select>
									<select name="searchDay1" id="searchDay1" style="width: 50px">
									</select> ~
									<select name="searchDay2" id="searchDay2" style="width: 50px">
									</select>
								</li>
								<li>
									<span class="fieldName">수집 주기</span>
									<select id="dataType" class="width110">
										<option value="2">10분자료</option>
										<option value="1">1시간자료</option>
									</select>
								</li>
								<li>
									<span class="fieldName">구분</span>
									<select id="strange" class="width110">
										<option value="all">전체</option>
										<option value="over">이상데이터</option>
									</select>
								</li>
								<li>
									<span class="fieldName">측정항목</span>
									<input type="checkbox" class="inputCheck" id="all_check" value="all" name="item_code" checked="checked"/><label for="all_check">전체</label>
									<input type="checkbox" class="inputCheck" id="i1" value="TUR00" name="item_code" checked="checked"/><label for="i1">탁도</label>
									<input type="checkbox" class="inputCheck" id="i2" value="TMP00" name="item_code" checked="checked"/><label for="i2">수온</label>
									<input type="checkbox" class="inputCheck" id="i3" value="PHY00" name="item_code" checked="checked"/><label for="i3">pH</label>
									<input type="checkbox" class="inputCheck" id="i4" value="DOW00" name="item_code" checked="checked"/><label for="i4">DO</label>
									<input type="checkbox" class="inputCheck" id="i5" value="CON00" name="item_code" checked="checked"/><label for="i5">전기전도도</label>
									<input type="checkbox" class="inputCheck" id="i6" value="TOF00" name="item_code" checked="checked"/><label for="i6">Chl-a</label>
								</li>
							</ul>
						</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData();" alt="조회하기" style="float:right;"/>
						</div>
						</form:form>
						<!-- //하천 수질 조회 -->
						
						<div id="btArea">
							<input type="button" id="a_chartPopup" name="a_chartPopup" class="btn btn_graph" alt="그래프" onclick="setGraphBtn();"/>
							<input type="button" id="excel" name="excel" class="btn btn_excel" onclick="javascript:excelDown();" alt="엑셀"/>
							<ul class='info'>
								<li class="li01_new">경보기준 이상</li>
								<li class="li02_new">정상</li>
								<li class="li03_new">전원이상</li>
								<li class="li04_new">점검보수중</li>
								<li class="li05_new">장비이상</li>
								<li class="li06_new">통신관련</li>
								<li class="li07_new">교정중</li>
								<li class="li08_new">시운전</li>
								<li class="li09_new">가동중지</li>
								<li class="li10_new">재전송</li>
								<li class="li11_new">환경변화</li>
							</ul>
						</div>
						
						<div class="table_wrapper">
							<div id="div_result">
								<table>
									<colgroup>
										<col width="40px" />
										<col width="50px" />
										<col width="80px" />
										<col width="80px" />
										<col width="55px" />
										<col width="55px" />
										<col width="55px" />
										<col width="55px" />
										<col width="55px" />
										<col width="55px" />
										<col width="55px" />
										<col width="55px" />
										<col width="55px" />
										<col width="55px" />
										<col width="55px" />
										<col width="55px" />
										<col width="55px" />
									</colgroup>
									<thead>
										<tr>
											<th rowspan="2">NO</th>
											<th rowspan="2">수계</th>
											<th rowspan="2">측정소</th>
											<th rowspan="2">수신일자</th>
											<th rowspan="2">수신시간</th>
											<th colspan="2">탁도(NTU)</th>
											<th colspan="2">수온(℃)</th>
											<th colspan="2">pH</th>
											<th colspan="2">DO(mg/L)</th>
											<th colspan="2">EC(mS/cm)</th>
											<th colspan="2">Chl-a(μg/L)</th>
										</tr>
										<tr>
											<th>확정전</th>
											<th>확정후</th>
											<th>확정전</th>
											<th>확정후</th>
											<th>확정전</th>
											<th>확정후</th>
											<th>확정전</th>
											<th>확정후</th>
											<th>확정전</th>
											<th>확정후</th>
											<th>확정전</th>
											<th>확정후</th>
										</tr>
									</thead>
									<tbody>
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
											<td></td>
											<td></td>
											<td></td>
									</tr>
									</tbody>
								</table>
							</div>
							
							<div class="paging">
								<div id="page_number">
									<ul class="paginate" id="pagination"></ul>
								</div>
							</div> 
						
							<div id="avgData" class="avgData">
								<table>
									<tr>
										<th rowspan="2"></th>
										<th class="tur_dis_th" colspan="2">탁도</th>
										<th class="tmp_dis_th" colspan="2">수온</th>
										<th class="phy_dis_th" colspan="2">ph</th>
										<th class="dow_dis_th" colspan="2">DO</th>
										<th class="con_dis_th" colspan="2">EC</th>
										<th class="tof_dis_th" colspan="2">Chl-a</th>
									</tr>
									<tr>
										<th class="tur_dis">확정전</th>
										<th class="tur2_dis">확정후</th>
										<th class="tmp_dis">확정전</th>
										<th class="tmp2_dis">확정후</th>
										<th class="phy_dis">확정전</th>
										<th class="phy2_dis">확정후</th>
										<th class="dow_dis">확정전</th>
										<th class="dow2_dis">확정후</th>
										<th class="con_dis">확정전</th>
										<th class="con2_dis">확정후</th>
										<th class="tof_dis">확정전</th>
										<th class="tof2_dis">확정후</th>
									</tr>
									<tr>
										<th>최소</th>
										<td class="tur_dis" style="text-align:center;"><span id="tur_min"></span></td>
										<td class="tur2_dis" style="text-align:center;"><span id="tur2_min"></span></td>
										<td class="tmp_dis" style="text-align:center;"><span id="tmp_min"></span></td>
										<td class="tmp2_dis" style="text-align:center;"><span id="tmp2_min"></span></td>
										<td class="phy_dis" style="text-align:center;"><span id="phy_min"></span></td>
										<td class="phy2_dis" style="text-align:center;"><span id="phy2_min"></span></td>
										<td class="dow_dis" style="text-align:center;"><span id="dow_min"></span></td>
										<td class="dow2_dis" style="text-align:center;"><span id="dow2_min"></span></td>
										<td class="con_dis" style="text-align:center;"><span id="con_min"></span></td>
										<td class="con2_dis" style="text-align:center;"><span id="con2_min"></span></td>
										<td class="tof_dis" style="text-align:center;"><span id="tof_min"></span></td>
										<td class="tof2_dis" style="text-align:center;"><span id="tof2_min"></span></td>
									</tr>
									<tr>
										<th>평균</th>
										<td class="tur_dis" style="text-align:center;"><span id="tur_avg"></span></td>
										<td class="tur2_dis" style="text-align:center;"><span id="tur2_avg"></span></td>
										<td class="tmp_dis" style="text-align:center;"><span id="tmp_avg"></span></td>
										<td class="tmp2_dis" style="text-align:center;"><span id="tmp2_avg"></span></td>
										<td class="phy_dis" style="text-align:center;"><span id="phy_avg"></span></td>
										<td class="phy2_dis" style="text-align:center;"><span id="phy2_avg"></span></td>
										<td class="dow_dis" style="text-align:center;"><span id="dow_avg"></span></td>
										<td class="dow2_dis" style="text-align:center;"><span id="dow2_avg"></span></td>
										<td class="con_dis" style="text-align:center;"><span id="con_avg"></span></td>
										<td class="con2_dis" style="text-align:center;"><span id="con2_avg"></span></td>
										<td class="tof_dis" style="text-align:center;"><span id="tof_avg"></span></td>
										<td class="tof2_dis" style="text-align:center;"><span id="tof2_avg"></span></td>
									</tr>
									<tr>
										<th>최대</th>
										<td class="tur_dis" style="text-align:center;"><span id="tur_max"></span></td>
										<td class="tur2_dis" style="text-align:center;"><span id="tur2_max"></span></td>
										<td class="tmp_dis" style="text-align:center;"><span id="tmp_max"></span></td>
										<td class="tmp2_dis" style="text-align:center;"><span id="tmp2_max"></span></td>
										<td class="phy_dis" style="text-align:center;"><span id="phy_max"></span></td>
										<td class="phy2_dis" style="text-align:center;"><span id="phy2_max"></span></td>
										<td class="dow_dis" style="text-align:center;"><span id="dow_max"></span></td>
										<td class="dow2_dis" style="text-align:center;"><span id="dow2_max"></span></td>
										<td class="con_dis" style="text-align:center;"><span id="con_max"></span></td>
										<td class="con2_dis" style="text-align:center;"><span id="con2_max"></span></td>
										<td class="tof_dis" style="text-align:center;"><span id="tof_max"></span></td>
										<td class="tof2_dis" style="text-align:center;"><span id="tof2_max"></span></td>
									</tr>
									<!-- <tr>
										<th>가동율</th>
										<td class="tur_dis" style="text-align:center;"><span id="tur_max"></span></td>
										<td class="tur2_dis" style="text-align:center;"><span id="tur2_max"></span></td>
										<td class="tmp_dis" style="text-align:center;"><span id="tmp_max"></span></td>
										<td class="tmp2_dis" style="text-align:center;"><span id="tmp2_max"></span></td>
										<td class="phy_dis" style="text-align:center;"><span id="phy_max"></span></td>
										<td class="phy2_dis" style="text-align:center;"><span id="phy2_max"></span></td>
										<td class="dow_dis" style="text-align:center;"><span id="dow_max"></span></td>
										<td class="dow2_dis" style="text-align:center;"><span id="dow2_max"></span></td>
										<td class="con_dis" style="text-align:center;"><span id="con_max"></span></td>
										<td class="con2_dis" style="text-align:center;"><span id="con2_max"></span></td>
										<td class="tof_dis" style="text-align:center;"><span id="tof_max"></span></td>
										<td class="tof2_dis" style="text-align:center;"><span id="tof2_max"></span></td>
									</tr>
									<tr>
										<th>전송율</th>
										<td class="tur_dis" style="text-align:center;"><span id="tur_max"></span></td>
										<td class="tur2_dis" style="text-align:center;"><span id="tur2_max"></span></td>
										<td class="tmp_dis" style="text-align:center;"><span id="tmp_max"></span></td>
										<td class="tmp2_dis" style="text-align:center;"><span id="tmp2_max"></span></td>
										<td class="phy_dis" style="text-align:center;"><span id="phy_max"></span></td>
										<td class="phy2_dis" style="text-align:center;"><span id="phy2_max"></span></td>
										<td class="dow_dis" style="text-align:center;"><span id="dow_max"></span></td>
										<td class="dow2_dis" style="text-align:center;"><span id="dow2_max"></span></td>
										<td class="con_dis" style="text-align:center;"><span id="con_max"></span></td>
										<td class="con2_dis" style="text-align:center;"><span id="con2_max"></span></td>
										<td class="tof_dis" style="text-align:center;"><span id="tof_max"></span></td>
										<td class="tof2_dis" style="text-align:center;"><span id="tof2_max"></span></td>
									</tr>
									<tr>
										<th>전체<br/>가동율</th>
										<td class="tur_dis" style="text-align:center;"><span id="tur_max"></span></td>
										<td class="tur2_dis" style="text-align:center;"><span id="tur2_max"></span></td>
										<td class="tmp_dis" style="text-align:center;"><span id="tmp_max"></span></td>
										<td class="tmp2_dis" style="text-align:center;"><span id="tmp2_max"></span></td>
										<td class="phy_dis" style="text-align:center;"><span id="phy_max"></span></td>
										<td class="phy2_dis" style="text-align:center;"><span id="phy2_max"></span></td>
										<td class="dow_dis" style="text-align:center;"><span id="dow_max"></span></td>
										<td class="dow2_dis" style="text-align:center;"><span id="dow2_max"></span></td>
										<td class="con_dis" style="text-align:center;"><span id="con_max"></span></td>
										<td class="con2_dis" style="text-align:center;"><span id="con2_max"></span></td>
										<td class="tof_dis" style="text-align:center;"><span id="tof_max"></span></td>
										<td class="tof2_dis" style="text-align:center;"><span id="tof2_max"></span></td>
									</tr>
									<tr>
										<th>전체<br/>전송율</th>
										<td class="tur_dis" style="text-align:center;"><span id="tur_max"></span></td>
										<td class="tur2_dis" style="text-align:center;"><span id="tur2_max"></span></td>
										<td class="tmp_dis" style="text-align:center;"><span id="tmp_max"></span></td>
										<td class="tmp2_dis" style="text-align:center;"><span id="tmp2_max"></span></td>
										<td class="phy_dis" style="text-align:center;"><span id="phy_max"></span></td>
										<td class="phy2_dis" style="text-align:center;"><span id="phy2_max"></span></td>
										<td class="dow_dis" style="text-align:center;"><span id="dow_max"></span></td>
										<td class="dow2_dis" style="text-align:center;"><span id="dow2_max"></span></td>
										<td class="con_dis" style="text-align:center;"><span id="con_max"></span></td>
										<td class="con2_dis" style="text-align:center;"><span id="con2_max"></span></td>
										<td class="tof_dis" style="text-align:center;"><span id="tof_max"></span></td>
										<td class="tof2_dis" style="text-align:center;"><span id="tof2_max"></span></td>
									</tr> -->
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
	<!-- //선택 수정 레이어 -->
	<div id="layerSelectDataReason" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnSelectDataModXbox" name="btnSelectDataModXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerSelectDataReason');" alt="닫기" />
		</div>
		<table summary="선별사유"style="text-align:left;">
			<tr>
				<th scope="col" style="width:100px;">선별사유</th>
				<td id="selectDataReason" style='text-align:left;width:300px;padding-left:10px;'></td>
			</tr>
			
		</table>
	</div>
</body>
</html>