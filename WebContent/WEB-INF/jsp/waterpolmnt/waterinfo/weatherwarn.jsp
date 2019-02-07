<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : weatherwarn.jsp
	 * Description : 기상특보이력 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2010.05.17	khany		최초 생성
	 * 2013.10.20	lkh			리뉴얼
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
	$(function () {
// 		set_User_deptNo(user_dept_no, "sugye");
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
		
		var today = new Date(); 
		var yday = new Date(Date.parse(today) - 7 * 1000 * 60 * 60 * 24);
		
		yday = yday.getFullYear()+ "/" + addzero(yday.getMonth()+1) + "/" + addzero(yday.getDate());
		today = today.getFullYear()+"/"+ addzero(today.getMonth()+1) + "/" + addzero(today.getDate());
		
		function addzero(n) {
			return n < 10 ? "0" + n : n + "";
		}
		
		$("#startDate").val(yday);
		$("#endDate").val(today);
		
		reloadData();
	});
	
	function reloadData(pageNo){

		showLoading();
	
	if( validation() == false ) return;

	var frDate = $("#startDate").val2();
	var toDate = $("#endDate").val2();
    var frTime = $("#frTime").val();
	var toTime = $("#toTime").val();

	if (pageNo == null) pageNo = 1;

	//document.listFrm.action = "<c:url value='/waterpolmnt/waterinfo/getWeatherInfoList.do'/>";
	//document.listFrm.submit();

	$.ajax({
		type:"post",
		url:"<c:url value='/waterpolmnt/waterinfo/getWeatherWarnList.do'/>",
		data:{
			  frDate:frDate,
			  toDate:toDate,
			  frTime:"00",
			  toTime:"23",
			  pageIndex:pageNo
			  },
		dataType:"json",
		success:function(result){
            var tot = result['dataList'].length;
            var item;
			var trClass;
			
            $("#dataList").html("");

            if( tot <= "0" ){
        		$("#dataList").html("<tr><td colspan='4'>조회 결과가 없습니다</td></td>");
        		 closeLoading();
            }else{
                for(var i=0; i < tot; i++){
                    var obj = result['dataList'][i];
                    var pageInfo = result['paginationInfo'];
                    var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
                	var w = obj.warning_content.split("\n");
					var wc = "";
					
					for(var idx  = 0 ; idx < w.length ; idx++) {
						w[idx] = w[idx].replace("o ", " ");
						wc += "<br/><b>" + (idx+1) + ".</b> " + w[idx] + "<br/>&nbsp;";
					}
					
					var trClass = "";
					if(i%2 == 1){trClass = "even"}
                   	item = "<tr class='"+trClass+"'><td class='num'><span>" + no + "</span></td>"
                   		 +"<td>"+obj.announce_time+"</td>" 
						 +"<td>"+obj.announce_seq +"</td>"
    	                 +"<td style='padding-left:10px;text-align:left'>"+wc+"</td>"

                 	item += "</tr>";
                 		 
           			$("#dataList").append(item);

           			//$("#dataList tr:odd").attr("class","add"); 
                }
            }

            // 페이징 정보
            var pageStr = makePaginationInfo(result['paginationInfo']);
            $("#pagination").empty();
            $("#pagination").append(pageStr);	       

            $("#p_total_cnt").html("총 " + result['totCnt'] + "건");

            closeLoading();
		},
        error:function(result){  
			$("#dataList").html("");
            $("#dataList").html("<tr><td colspan='4'>서버 접속에 실패하였습니다!</td></td>");
            closeLoading();
        }
	});
	
	//setTimeout(reloadData, 60000);
}    
	
	function sysChange()
	{
		var sys_kind = $("#sys").val();
		
		if(sys_kind == "all")
		{
			$("#branchNo>option:first").attr("selected", "true");
			$("#factCode>option:first").attr("selected", "true");
			
			$("#branchNo").attr("disabled", "disabled");
			$("#factCode").attr("disabled", "disabled");
		}
		else
		{
			$("#branchNo>option:first").attr("selected", "true");
			$("#factCode>option:first").attr("selected", "true");
			
			$("#branchNo").attr("disabled", false);
			$("#factCode").attr("disabled", false);
		}
		
		if(sys_kind == "U")
		{
			$("#branchNo").show();
			$("#spanBranch").show();
		}
		else
		{
			$("#branchNo").hide();
			$("#spanBranch").hide();
		}
	}
	
	function excelDown() {
		
		if( validation() == false ) return;
		
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();
		
		var param = "&frDate=" + frDate + "&toDate=" + toDate + "&frTime=" + frTime + "&toTime=" + toTime;
		
		location.href="<c:url value='/waterpolmnt/waterinfo/getWeatherWarnList_forExcel.do'/>?"+param;
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
		
		//timeCheck();
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
					
					<!-- 하천 수질 조회 -->
						<form:form commandName="warningDataVO" name="listFrm"  id="listFrm" method="post">
							<input type="hidden" name="pageIndex" id="pageIndex" value="${searchTaksuVO.pageIndex}"/>
							<input type="hidden" name="branch_no" id="chukjeongso"/>
							<input type="hidden" name="factCode" id="gongku"/>
							<input type="hidden" name="sugye" id="river_div"/>
							<input type="hidden" name="frDate" id="frDate"/>
							<input type="hidden" name="toDate" id="toDate"/>
						
						<div class="searchBox dataSearch">
							<ul>
								<li>
									<span class="fieldName">조회기간</span>
									<input type="text" id="startDate" name="startDate" onchange="commonWork()" style="width:80px"/>
									<span>~</span>
									<input type="text" id="endDate" name="endDate" onchange="commonWork()" style="width:80px"/>
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
							<input type="button" id="btnBasic" name="btnBasic" class="btn btn_excel" onclick="javascript:excelDown()" />
						</div>
						<div class="table_wrapper">
							<table id="dataTable" class="dataTable" oncontextmenu="return false" ondragstart="return false" onselectstart="return false"><!-- 컬럼 개수가 늘어날수록 width값도 증가해야합니다. -->
								<colgroup>
									<col width='40px'/>
									<col width='140px'/>
									<col width='80px'/>
									<col width=''/>
								</colgroup>
								<thead id="dataHeader">
									<th>NO</th>
									<th>발표시간</th>
									<th>발표번호</th>
									<th>내용</th>
								</thead>

								<tbody id="dataList">
								</tbody>								
							</table>
							<ul class="paginate" id="pagination">
							</ul>
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