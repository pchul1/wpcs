<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : alertLaw.jsp
	 * Description : 경보기준설정 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			 수정내용
	 * -------		--------	---------------------------
	 * 2010.05.17	k			최초 생성
	 * 2013.10.20	lkh			리뉴얼
	 *
	 * author k
	 * since 2010.05.17
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
			getAlertLawList();
		});		

		$('#checkAll').click(function () {
			checkAll();
		});	
		/*
		$("#addRow").click(function () {
			setRow('', $("#factCode").val(), $("#branchNo").val());
		});

		$('#delRow').click(function () {
			if(isProcess) {
				alert("처리중입니다.");
				return; 
			}
			isProcess = true;
			setDel();
		});
		*/

		$('#btnSave').click(function () {
			if(isProcess) {
				alert("처리중입니다.");
				return; 
			}
			if(!validation()) { return; }
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

// 		set_User_deptNo(user_dept_no, "sugye");
		selectedSugyeInMemberId(user_riverid , "sugye");
	});

	function wrapFormValues(form) {
		form = "#" + form.attr("id") + " :input";
		form = $(form).serializeArray();
		var dataArray = new Object();
	 
		for( index in form)
		{	
			if(form[index].value) {
					dataArray[form[index].name] = form[index].value;
			}
		}
	
		return dataArray;
	}
	
	var firstFlag = true;
	function init() {
		if(firstFlag) {
			getAlertLawList();
			firstFlag = false;
		}
	}	
	function setSave(){	

		$('#listFrm').ajaxForm(function() {
			$.ajax({
			type:"post",
			url:"<c:url value='/alert/saveAlertLawData.do'/>",
			data:$("#listFrm").serializeArray(),
			dataType:"json",
			success:function(result){
				alert("저장했습니다.");
				isProcess = false; 
			},
			error:function(result){alert("error2!!");isProcess = false;}
			}); 
		});
	}
	/*
	function setDel() {
		var i=0;
		var cnt = 0;
		var lawId = new Array;
		var delRowIdx = new Array;

		$('input[name=chk]').each(function() {
			if($(this).attr('checked')) {
				delRowIdx.push(i);
				cnt++;
			}
			i++;
		});

		if(cnt == 0) {
			alert("삭제할 항목을 체크해주세요");
			isProcess = false;
			return false;
		}

		for(var i=delRowIdx.length; i>0; i--) {
			lawId.push($('input[name=lawId]').eq(delRowIdx[i-1]).val());
		}
		
		deleteAlertLawData(lawId, delRowIdx);
	}
	*/
	 
	function getAlertLawList() {
		$.ajax({
			type:"post",
			url:"<c:url value='/alert/getAlertLawList.do'/>",
			data:{factCode:$("#factCode").val(), branchNo:$("#branchNo").val()},
			dataType:"json",
			success:function(result){
				var tot = result['alertLawList'].length;
				$("#alertListTbody").html("");

				if( tot <= "0" ){
					$("#alertListTbody").html("<tr><td colspan='6'>조회 결과가 없습니다</td></td>");
				} else {
					for(var j=0; j < tot; j++){
						var obj = result['alertLawList'][j];

						if($("#system").val() == "A")
						{
							if(obj.itemCode != "VOC01"
								&& obj.itemCode != "VOC02"
								&& obj.itemCode != "VOC03"
								&& obj.itemCode != "VOC04"
								&& obj.itemCode != "VOC05"
								&& obj.itemCode != "VOC06"
								&& obj.itemCode != "VOC07"
								&& obj.itemCode != "VOC08"
								&& obj.itemCode != "VOC16" )
							{
								continue;
							}
						}
						
						setRow(obj.factCode, obj.branchNo, obj.itemCode, obj.itemName, obj.lawHighValueStr, obj.lawLowValueStr, obj.lawAlarm1ValueStr, obj.lawAlarm2ValueStr, obj.lawApply);
					}
				}
				isProcess = false;
			},
			error:function(result){alert("error1!!");isProcess = false;}
		});			
	}
	
	function saveAlertLawData(factCode, branchNo, itemCode, lawHighValue, lawLowValue, lawAlarm1Value, lawAlarm2Value, lawApply){
		$.ajax({
			type:"post",
			url:"<c:url value='/alert/saveAlertLawData.do'/>",
			data:{factCode:factCode, branchNo:branchNo, itemCode:itemCode, lawHighValue:lawHighValue, lawLowValue:lawLowValue,
					lawAlarm1Value:lawAlarm1Value, lawAlarm2Value:lawAlarm2Value, lawApply:lawApply},
			dataType:"json",
			success:function(result){
				alert("저장했습니다.");
				isProcess = false;
				getAlertLawList();
			},
			error:function(result){alert("error2!!");isProcess = false;}
		});			
	} 
	/*
	function deleteAlertLawData(lawId, delRowIdx){
		$.ajax({
			type:"post",
			url:"<c:url value='/alert/deleteAlertLawData.do'/>",
			data:{lawId:lawId},
			dataType:"json",
			success:function(result){
				for(var i=delRowIdx.length; i>0; i--) {
					$('#listFrm input[name=lawId]').eq(delRowIdx[i-1]).parent().parent().remove();
				}
				alert("삭제했습니다.");
				isProcess = false;
			},
			error:function(result){alert("error");isProcess = false;}
		});
	}
	*/

	function setRow(factCode, branchNo, itemCode, itemName, lawHighValue, lawLowValue, lawAlarm1Value, lawAlarm2Value, lawApply) {
		factCode			= nullToString(factCode);
		branchNo			= nullToString(branchNo);
		itemCode			= nullToString(itemCode);
		itemName			= nullToString(itemName);
		lawHighValue		= nullToString(lawHighValue);
		lawLowValue			= nullToString(lawLowValue);
		lawAlarm1Value		= nullToString(lawAlarm1Value);
		lawAlarm2Value		= nullToString(lawAlarm2Value);
		lawApply			= nullToString(lawApply); 
		var str = "";
		 //num.toFixed(2);
		var str = "<select name='lawApply'>";
		if(lawApply == 'Y'){
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
					.append($('<input />').attr('name', 'branchNo').attr('type', 'hidden').attr('value', branchNo))
					.append($('<input />').attr('name', 'itemCode').attr('type', 'hidden').attr('value', itemCode)))
			.append($('<td></td>')
						.append($('<input />').attr('name', 'lawHighValue').attr('value', lawHighValue).attr('type', 'text')
									.attr('style', 'width:130px').addClass('inputText')))
			.append($('<td></td>')
						.append($('<input />').attr('name', 'lawLowValue').attr('value', lawLowValue).attr('type', 'text')
									.attr('style', 'width:130px').addClass('inputText')))
			.append($('<td></td>')
						.append($('<input />').attr('name', 'lawAlarm1Value').attr('value', lawAlarm1Value).attr('type', 'text')
									.attr('style', 'width:130px').addClass('inputText')))
			.append($('<td></td>')
						.append($('<input />').attr('name', 'lawAlarm2Value').attr('value', lawAlarm2Value).attr('type', 'text')
									.attr('style', 'width:130px').addClass('inputText')))
			.append($('<td></td>')
						.append(str))
			.appendTo("#alertListTbody");

		var trIdx = $('#alertListTbody tr').size()-1;
		$('#alertListTbody tr:odd').addClass('add');
	}

	function checkAll(){
		var c = $('#checkAll').attr('checked');
		$('input[name=chk]').attr('checked',c);
	}

	function validation() {
		var i = 0;
		var cnt1 = 0;
		var cnt2 = 0;
		var cnt3 = 0;
		var cnt4 = 0;
		var cnt5 = 0;

		$('input[name=chk]').each(function() {
			if($('input[name=itemCode]').eq(i).val() == "") { cnt1++; }
			if($('input[name=lawHighValue]').eq(i).val() == "") { cnt2++; }
			if($('input[name=lawLowValue]').eq(i).val() == "") { cnt3++; }
			if($('input[name=lawAlarm1Value]').eq(i).val() == "") { cnt4++; }
			if($('input[name=lawAlarm2Value]').eq(i).val() == "") { cnt5++; }
			i++;
		});			

		if(cnt1 > 0) { alert("측정항목을 입력하여 주십시요."); return false; }
		if(cnt2 > 0) { alert("기준 상한을 입력하여 주십시요."); return false; }
		if(cnt3 > 0) { alert("기준 하한을 입력하여 주십시요."); return false; }
		if(cnt4 > 0) { alert("관심을 입력하여 주십시요."); return false; }
		if(cnt5 > 0) { alert("주의을 입력하여 주십시요."); return false; }
		return true;
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

						<!-- 수질 기준 설정 검색 -->
						<form action="" onsubmit="return false" method="post" >
						
							<div class="searchBox dataSearch">
								<ul>
									<li  style="display:none">
										<span class="fieldName">시스템</span>
										<select class="fixWidth13" id="system" name="system">
											<option value="U" selected="selected">이동형측정기기</option>
										</select>
									</li>
									<li>
										<span class="fieldName">측정소 위치</span>
										<select class="fixWidth7" id="sugye" name="sugye">
											<option value="R01">한강</option>
											<option value="R02">낙동강</option>
											<option value="R03">금강</option>
											<option value="R04">영산강</option>
										</select>
										<select class="fixWidth11" id="factCode" name="factCode" style="display:none;">
											<option value="all">전체</option>
										</select>
										<span>&gt;</span>
										<select class="fixWidth11" id="branchNo" name="branchNo">
											<option value="all">전체</option>
										</select>
									</li>
									<li class="last">
										<input type="button" id="btnSearch" name="btnSearch" value="조회" class="btn btn_search" _onclick="javascript:getAlertLawList();" alt="조회"/>
									</li>
								</ul>
							</div>
						</form>
						<!-- //수질 기준 설정 검색 -->
						
						<div id="btArea">
							<span id="p_total_cnt">&nbsp;</span>
							<input type="button" id="btnSave" name="btnSave" value="저장" class="btn btn_basic" _onclick="javascript:setSave();" alt="저장" />
						</div>
						
						<!-- 수질 기준 설정 추가,삭제, 저장 -->
						<div class="table_wrapper">
						
							<form id="listFrm" name="listFrm" action="/alert/saveAlertLawData.do" onsubmit="return false">
								<div class="overBox">
									<table summary="경보기준정보" >
										<colgroup>
											<col />
											<col width="150px" />
											<col width="150px" />
											<col width="150px" />
											<col width="150px" />
											<col width="110px" />
										</colgroup>
										<thead>
											<tr>
												<th scope="col">측정 항목</th>
												<th scope="col">기준 상한</th>
												<th scope="col">기준 하한</th>
												<th scope="col">관심</th>
												<th scope="col">주의</th>
												<th scope="col">사용여부</th>
											</tr>
										</thead>
										<tbody id="alertListTbody">
										</tbody>
									</table>
								</div>
							</form>
							
						</div>
						<!-- //수질 기준 설정 추가,삭제, 저장 -->

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