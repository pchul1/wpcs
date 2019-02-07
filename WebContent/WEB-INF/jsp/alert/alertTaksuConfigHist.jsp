<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
  /**
  * @Class Name : alertTargetConfigHist.jsp
  * @Description : Alert Target Config Hist List 화면
  * @Modification Information
  * 
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  *  2010.05.20     k        최초 생성
  *
  * author k
  * since 2010.05.20
  *  
  * Copyright (C) 2010 by k  All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />	
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />		
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
<%-- 	</sec:authorize>	 --%>
	<script>
		var isProcess = false;

		$(function(){
			
			$('#alertListTbody tr:odd').addClass('add');

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
			today = today.getFullYear()+ "/" + addzero(today.getMonth()+1) + "/"+ addzero(today.getDate());

			//var yday = new Date(Date.parse(today) - 1 * 1000 * 60 * 60 * 24);
			//yday = yday.getFullYear()+ addzero(yday.getMonth()+1) + addzero(yday.getDate());
		
			function addzero(n) {
				 return n < 10 ? "0" + n : n + "";
			}
		
			$("#startDate").val(today);
			$("#endDate").val(today);			

			$('#search').click(function () {
				if(isProcess) {
					alert("처리중입니다.");
					return; 
				}			
				isProcess = true;		
				getAlertTargetConfigHistList();
			});					

			$('#sugye').change(function(){
				adjustGongku();
			});		 

			adjustGongku();
			
			set_User_deptNo(user_dept_no, "sugye");
		});

		function adjustBranchDropDown() {
			init();
		}

		var firstFlag = true;
		function init() {
			if(firstFlag) {
				getAlertTargetConfigHistList();
				firstFlag = false;
			}
		}
		
		function getAlertTargetConfigHistList() {
			
			if(validation() == false) 
			{
				isProcess = false;
				return;
			}
			
			showLoading();
			
			var factCode = $("#factCode").val() == "all" ? "" : $("#factCode").val();
			var sugye = $("#sugye").val();
			
			$.ajax({
				type:"post",
				url:"<c:url value='/alert/getAlertTaksuConfigHistList.do'/>",
				data:{sugye:sugye, factCode:factCode, startDate:$("#startDate").val2(), endDate:$("#endDate").val2()},
				dataType:"json",
				success:function(result){
	                var tot = result['alertTaksuConfigHistList'].length;
	                $("#alertListTbody").html("");

	                if( tot <= "0" ){
	                	$("#alertListTbody").html("<tr><td colspan='4'>조회 결과가 없습니다</td></td>");
	                	closeLoading();
	                } else {	                
		                for(var j=0; j < tot; j++){
		                    var obj = result['alertTaksuConfigHistList'][j];          
		                    
		                    setRow(obj.factName, obj.histMsg, obj.memberId, obj.regDate);
		                }
	                }
	                isProcess = false;
	                closeLoading();
				},
	            error:function(result){closeLoading();}
			});			
		}
				
		function setRow(factName, histMsg, memberId, regDate) {
			factName 		= nullToString(factName);			
			histMsg 		= nullToString(histMsg);			
			memberId 		= nullToString(memberId);			
			regDate 		= nullToString(regDate);
			
			$('<tr></tr>')
				.append($('<td></td>')
							.append(factName))							
				.append($('<td></td>')
							.append(histMsg))
				.append($('<td></td>')
							.append(memberId))
				.append($('<td></td>')
							.append(regDate))				
				.appendTo("#alertListTbody");

			$('#alertListTbody tr:odd').addClass('add');	
		}


		// 공구 목록 가져오기
		function adjustGongku()
		{		
			var system = "T";
			
			var sugyeCd = $('#sugye').val();
			var dropDownSet = $('#factCode');
			
			if( sugyeCd == 'all' ){
				dropDownSet.attr("disabled", true);
				dropDownSet.emptySelect();
			}else{
				dropDownSet.attr("disabled", false);
				$.getJSON(ROOT_PATH+"waterpolmnt/waterinfo/getGongkuList.do", {system:system, sugye:sugyeCd}, function (data, status){
				     if(status == 'success'){     
				        //locId 객체에 SELECT 옵션내용 추가.
				        dropDownSet.loadSelect_all(data.gongku);
				        
				        //if(typeof(adjustBranchDropDown) == "function") {
				        //	adjustBranchDropDown();
				        //} else if(typeof(init) == "function") {
				        //	init();
				        //}

				        init();
				     } else { 
				    	 alert("공구 목록 가져오기 실패");
				        return;
				     }
				});
			}		
		}			

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


		function validation(){
			if( $('#startDate').val() == "" ){ alert("조회 시작일자를 선택하세요"); return false; }
			if( $('#endDate').val() == "" ){ alert("조회 종료일자를 선택하세요"); return false; }
		}

		function commonWork() {
			var stdt = document.getElementById("startDate");
			var endt = document.getElementById("endDate");
			var dateCheck = /^(19[7-9][0-9]|20\d{2})\/(0[0-9]|1[0-2])\/(0[1-9]|[1-2][0-9]|3[0-1])$/;
			
			if(endt.value != '' && stdt.value > endt.value) {
				alert("조회 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
				stdt.value = "";
				endt.value = "";
				stdt.focus();
			}
			if(stdt.value !=''){
				if(dateCheck.test(stdt.value)!=true){
					alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
					stdt.value = "";
					stdt.focus;
					return false;
				}
			}
			if(endt.value !=''){
				if(dateCheck.test(endt.value)!=true){
					alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
					endt.value = "";
					endt.focus;
					return false;
				}
			}

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
				<div class="inner_alarmstand">
					<!-- 경보 기준 설정 검색 -->
					<div class="search_all_wrap">
					<form action="" onsubmit="return false">	
						<div class="btnInBox">
							<dl>
								<dt><img src="<c:url value='/images/content/tit_search_branch.gif'/>" alt="측정소" /></dt>
								<dd>
									<select class="fixWidth7" id="sugye" name="sugye">
									   <option value="R01">한강</option>
									   <option value="R02">낙동강</option>
									   <option value="R03">금강</option>
									   <option value="R04">영산강</option>
									</select>
									<span>&gt;</span>
										<select class="fixWidth9" id="factCode" name="factCode">
										</select>
								</dd>
								<dt><img src="<c:url value='/images/content/tit_search_date.gif'/>" alt="조회기간" /></dt>
								<dd class="time">
									<input type="text" class="inputText" id="startDate" name="startDate" size="15" onchange="commonWork()"/>
									<span>~</span>
									<input type="text" class="inputText" id="endDate" name="endDate" size="15" onchange="commonWork()"/>
								</dd>
							</dl>
							<p class="btn_search"><input id="search" type="image" src="<c:url value='/images/common/btn_search.gif'/>" alt="조회" /></p>
						</div>
						</form>
				    </div> 
					<!-- //경보 기준 설정 검색 -->
					<!-- 경보 기준 설정 변경 -->					
					<form action="" onsubmit="return false">
						<fieldset>
							<legend class="hidden_phrase">탁수 경보 설정 이력</legend>
							<div class="data_wrap">												
								<div class="overBox">
									<table class="dataTable">
										<colgroup>
											<col width="150px" />																						
											<col />
											<col width="150px" />											
											<col width="150px" />
										</colgroup>
										<thead>
											<tr>
												<th scope="col">공구</th>
												<th scope="col">이력</th>
												<th scope="col">처리자</th>
												<th scope="col">처리일자</th>
											</tr>
										</thead>
										<tbody id="alertListTbody">											
										</tbody>
									</table>
								</div>								
							</div>
						</fieldset>
					</form>
					<!-- //경보 기준 설정 변경 -->
				</div>
			</div>
		</div><!-- //content -->

	</div><!-- //container -->
	<div id="footer">
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div><!-- //footer -->
</body>
</html>