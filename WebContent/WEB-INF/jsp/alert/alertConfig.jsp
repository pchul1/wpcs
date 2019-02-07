<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : alertConfig.jsp
	 * Description :경보환경설정 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2010.05.17	k			최초 생성
	 * 2013.10.20	lkh			리뉴얼
	 *
	 * author k
	 * since 2010.05.17
	 * 
	 * Copyright (C) 2010 by k All right reserved.
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
	var isProcess = false;

	$(function(){

		/*shows the loading div every time we have an Ajax call*/
		pageLoding();
		
		$('#alertListTbody tr:odd').addClass('add');

		$('#btnSearch').click(function () {
			if(isProcess) {
				alert("처리중입니다.");
				return;
			}
			isProcess = true;
			getAlertConfigList();
		});

		$('#btnSave').click(function () {
			if(isProcess) {
				alert("처리중입니다.");
				return; 
			}
			isProcess = true;
			setSave();
		});
		
		//시스템 고정 renew 전부터 고정되어 있는 상태
		$('#system').attr("disabled", true);
		$('#system').attr("style", "background:#e9e9e9;");
		
		$('#system').change(function(){
			adjustGongkuDropDown2();
		});

		$('#sugye').change(function(){
			adjustGongkuDropDown2();
		});

		$('#factCode').change(function(){
			adjustBranchDropDown();
		});

		adjustGongkuDropDown2();
		
		//getAlertConfigList();
		
// 		set_User_deptNo(user_dept_no, "sugye");
		selectedSugyeInMemberId(user_riverid , "sugye");
	});
	
	var firstFlag = true;
	function init() {
		if(firstFlag) {
			getAlertConfigList();
			firstFlag = false;
		}
	}
	function setSave(){ 
		var arsFlag = new Array();
		var smsFlag = new Array(); 
		$("input[name=arsFlag]").each(function() {
				if(this.checked){
					arsFlag.push("Y");
				}else{
					arsFlag.push("N");
				}
		});  
		$("input[name=smsFlag]").each(function() {
				if(this.checked){
					smsFlag.push("Y");
				}else{
					smsFlag.push("N");
				}
		});
		$("#arsStr").val(arsFlag);
		$("#smsStr").val(smsFlag);
		
		$('#listFrm').ajaxForm(function() {
			$.ajax({
			type:"post",
			url:"<c:url value='/alert/saveAlertConfigData.do'/>",
			data:$("#listFrm").serializeArray(),
			dataType:"json",
			success:function(result){
				alert("저장했습니다.");
				isProcess = false; 
				getAlertConfigList();
			},
			error:function(result){alert("error2!!");isProcess = false;}
			});
		}); 
	} 
	function getAlertConfigList() {
		$.ajax({
			type:"post",
			url:"<c:url value='/alert/getAlertConfigList.do'/>",
			data:{system:$('input[name=system]:checked').val(), factCode:$("#factCode").val(), branchNo:$("#branchNo").val()},
			dataType:"json",
			success:function(result){
				var tot = result['alertConfigList'].length;
				$("#alertListTbody").html("");

				if( tot <= "0" ){
					$("#alertListTbody").html("<tr><td colspan='3'>조회 결과가 없습니다</td></td>");
				} else {
					for(var j=0; j < tot; j++){
						var obj = result['alertConfigList'][j];
						
						setRow(obj.factCode, obj.branchNo, obj.itemCode, obj.itemName, obj.arsFlag, obj.smsFlag, obj.alertTerm, obj.used);
					}
				}
				isProcess = false;
			},
			error:function(result){alert("error");isProcess = false;}
		});
	}
	
	function saveAlertConfigData(factCode, branchNo, itemCode, arsFlag, smsFlag, alertTerm, used){
		$.ajax({
			type:"post",
			url:"<c:url value='/alert/saveAlertConfigData.do'/>",
			data:{factCode:factCode, branchNo:branchNo, itemCode:itemCode, arsFlag:arsFlag, smsFlag:smsFlag, alertTerm:alertTerm, used:used},
			dataType:"json",
			success:function(result){
				alert("저장했습니다.");
				isProcess = false;
				getAlertConfigList();	
			},
			error:function(result){alert("error");isProcess = false;}
		});			
	}				
	function setRow(factCode, branchNo, itemCode, itemName, arsFlag, smsFlag, alertTerm, used) {
		factCode		= nullToString(factCode);
		branchNo		= nullToString(branchNo);
		itemCode		= nullToString(itemCode);
		itemName		= nullToString(itemName);
		arsFlag		= nullToString(arsFlag);
		smsFlag		= nullToString(smsFlag);
		alertTerm		= nullToString(alertTerm);
		used			= nullToString(used);
		var str = ""; 
		var str = "<select name='used' id='used' style='width:100px'>";
		if(used == 'Y'){
			str += " <option value='Y' selected>사용</option>";
			str += " <option value='N'>미사용</option>";
		}else{
			str += " <option value='N' selected>미사용</option>";
			str += " <option value='Y'>사용</option>"; 
		} 
		$('<tr></tr>')
			.append($('<td></td>')
			.append(itemName)
			.append($('<input />').attr('name', 'factCode').attr('type', 'hidden').attr('value', factCode))
			.append($('<input />').attr('name', 'branchNo').attr('type', 'hidden').attr('value', branchNo)))
			.append($('<input />').attr('name', 'itemCode').attr('type', 'hidden').attr('value', itemCode))
			.append($('<td></td>')
			.append($('<input />').attr('name', 'arsFlag').attr('value', 'Y').attr('type', 'checkbox')
			.addClass('inputCheck'))
			.append($('<label></label>').attr('for', '').text('ACS'))
			.append($('<input />').attr('name', 'smsFlag').attr('value', 'Y').attr('type', 'checkbox')
			.addClass('inputCheck'))
			.append($('<label></label>').attr('for', '').text('SMS').addClass(' last'))
			.addClass('choice'))
			//.append($('<td></td>')
			//.append($('<input />').attr('name', 'alertTerm').attr('value', alertTerm).attr('type', 'text')
			//.addClass('inputText'))
			//.addClass('choice'))
			.append($('<td></td>')
			.append(str))	
			.appendTo("#alertListTbody");
					
		var trIdx = $('#alertListTbody tr').size()-1; 
		if(arsFlag == 'A')
			$('input[name=arsFlag]').eq(trIdx).attr('checked', true).attr('value', 'Y');
		else 
			$('input[name=arsFlag]').eq(trIdx).attr('checked', false).attr('value', 'N');
		if(smsFlag == 'S')
			$('input[name=smsFlag]').eq(trIdx).attr('checked', true).attr('value', 'Y');
		else 
			$('input[name=smsFlag]').eq(trIdx).attr('checked', false).attr('value', 'N');
		$('#alertListTbody tr:odd').addClass('add');
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

						<!-- 경보 기준 설정 검색 -->
						<form  action="" onsubmit="return false">
						
							<div class="searchBox dataSearch">
								<ul>
									<li>
										<span class="fieldName">측정소 위치</span>
										<select class="fixWidth7" id="sugye" name="sugye">
											<option value="R01">한강</option>
											<option value="R02">낙동강</option>
											<option value="R03">금강</option>
											<option value="R04">영산강</option>
										</select>
										<div style="display:none;">
											<span>&gt;</span>
											<select class="fixWidth11" id="factCode" name="factCode">
												<option value="all">전체</option>
											</select>
										</div>
										<span>&gt;</span>
										<select class="fixWidth11" id="branchNo" name="branchNo">
											<option value="all">전체</option>
										</select>
									</li>
									<li style="display:none;">
										<select class="fixWidth13" id="system" name="system">
												<option value="U" selected="selected">이동형측정기기</option>
												<!-- <option value="T">탁수모니터링</option> -->
												<!--  <option value="A">국가수질자동측정망</option>-->
										</select>
									</li>
									<li class="last">
										<input type="button" id="btnSearch" name="btnSearch" value="조회" class="btn btn_search" _onclick="javascript:getAlertLawList();" alt="조회"/>
									</li>
								</ul>
							</div>
						</form>
						<!-- //경보 기준 설정 검색 -->
						
						<div id="btArea">
							<span id="p_total_cnt">&nbsp;</span>
							<input type="button" id="btnSave" name="btnSave" value="저장" class="btn btn_basic" _onclick="javascript:setSave();" alt="저장" />
						</div>
						
						<!-- 경보 기준 설정 변경 -->
						<div class="table_wrapper">
						
							<form id="listFrm" name="listFrm" action="" onsubmit="return false">
								<input name="arsStr" id="arsStr" type="hidden"/>
								<input name="smsStr" id="smsStr" type="hidden"/>
							
								<div class="overBox">
									<table summary="경보기준정보" >
										<colgroup>
											<col width="300px" />
											<col width="300px" />
											<col />
										</colgroup>
										<thead>
											<tr>
												<th scope="col">측정 항목</th>
												<th scope="col">발령 종류</th>
												<th scope="col">사용 여부</th>
											</tr>
										</thead>
										<tbody id="alertListTbody">
										</tbody>
									</table>
								</div>
							</form>
						</div>
						<!-- //경보 기준 설정 변경 -->
						
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