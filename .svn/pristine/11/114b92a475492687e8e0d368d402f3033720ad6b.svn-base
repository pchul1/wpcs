<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : smsmanage.jsp
	 * Description : sms관리 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2013.11.05	lkh			리뉴얼
	 * 2014.11.20  mypark    그리드 걷어내고 테이블 처리
	 * 
	 * author lkh
	 * since 2013.11.05
	 *
	 * Copyright (C) 2013 by lkh All right reserved.
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
	$(function (){
		reloadData();
		
		//등록 레이어
		$("#layerDetConReg").draggable({
			containment: 'body',
			scroll: false
		});
		//설정 레이어
		$("#layerBraConMod").draggable({
			containment: 'body',
			scroll: false
		});
		//삭제 레이어
		$("#layerGroDel").draggable({
			containment: 'body',
			scroll: false
		});
		//공통수신자 레이어
/* 		$("#layerComRec").draggable({
			containment: 'body',
			scroll: false
		}); */
		
		$("#sugye").change(function(){
			adjustGongku();
		});
		
		$("#factCodeX").change(function(){
			adjustBranchList();
		});
		
		$("#branchNoX").change(function(){
// 			smsBranchCfgList();
		});
	});
	
	//그리드 권한 항목 변경시 값을 그리드 컬럼으로 셋팅.
/* 	function itemChange(vRow, vItem) {
		//var obj = dataView.getItem(vRow);
		obj.useFlag = vItem;
	}
	
	//SMS공통수신자리스트 체크 그리드 권한 항목 변경시 값을 그리드 컬럼으로 셋팅.
	function itemCheckChange(vRow, vid) {
		//var obj = dataView1.getItem(vRow);
		
		if (vid.checked)
			obj.useChecked = true;
		else
			obj.useChecked = false;
	}
	
	//SMS공통수신대상자 체크 그리드 권한 항목 변경시 값을 그리드 컬럼으로 셋팅.
	function itemTargetCheckChange(vRow, vid) {
		//var obj = dataView2.getItem(vRow);
		
		if (vid.checked)
			obj.useChecked = true;
		else
			obj.useChecked = false;
	}
	
	//지점별sms대상 내역  사용여부 설정
	function itemUseFlagChange(vRow, vItem) {
		var obj = dataView3.getItem(vRow);
		obj.use_flag = vItem;
	} */
	
/* 	//지점별sms대상 내역  설정
	function itemContantsChange(vRow, vItem, vid) {
// 		console.log("vRow : ",vRow);
// 		console.log("vItem : ",vItem);
// 		console.log("vid: ",vid);
		var obj = dataView3.getItem(vRow);
		
		if (vid == "not_send_from")
			obj.not_send_from = vItem;
		else if (vid == "not_send_to")
			obj.not_send_to = vItem;
		else if (vid == "chk_delay")
			obj.chk_delay = vItem;
		else if (vid == "chk_loc")
			obj.chk_loc = vItem;
		else if (vid == "not_rcv")
			obj.not_rcv = vItem;
		else if (vid == "detail_explan")
			obj.detail_explan = vItem;
	}
	 */
	function reloadData(){
		showLoading();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/smsmanage/getSmsList.do'/>",
			data:{},
			dataType:"json",
			success:function(result){
// 				console.log("getSmsList : ",result);
				var tot = result['detailViewList'].length;
				var dataHtml = "";
				if( tot <= 0 ){
					dataHtml="<tr><td colspan='6'>조회 결과가 없습니다.</td></tr>";
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['detailViewList'][i];
						obj.no = i + 1; 
						obj.useFlag = obj.dpYn;
						
						var strSelect = "<select tabIndex='0' name='useFlag' id='useFlag"+ i + "'>";
						if(obj.useFlag == "Y"){
							strSelect += "<option value='Y' selected='true'>사용</option>"
									  + "<option value='N'>미사용</option>";
						} else {
							strSelect += "<option value='Y'>사용</option>"
									  + "<option value='N' selected='true'>미사용</option>";
						}
						strSelect += "</select>";
						
						strSelect +="<input type='hidden' name='detCode' id='detCode"+ i + "' value='" + obj.detCode +  "'>";
						strSelect +="<input type='hidden' name='sysKind' id='sysKind"+ i + "' value='" + obj.sysKind +  "'>";
						strSelect +="<input type='hidden' name='dpYn' id='dpYn"+ i + "' value='" + obj.dpYn +  "'>";
						
						dataHtml +="<tr style='cursor:pointer;' onclick='tdClick(" +i +")'>";
						dataHtml += "<td style='cursor:pointer;' onclick='getIndex(" + i + ",\"" + obj.detCode + "\",\"" + obj.sysKind + "\")'>" + obj.no +"</td>";
						dataHtml += "<td style='cursor:pointer;' onclick='getIndex(" + i + ",\"" + obj.detCode + "\",\"" + obj.sysKind + "\")'>" + obj.detCode +"</td>";
						dataHtml += "<td style='cursor:pointer;' onclick='getIndex(" + i + ",\"" + obj.detCode + "\",\"" + obj.sysKind + "\")'>" + obj.detContent +"</td>";
						dataHtml += "<td style='cursor:pointer;' onclick='getIndex(" + i + ",\"" + obj.detCode + "\",\"" + obj.sysKind + "\")'>" + obj.detDetailContent +"</td>";
						dataHtml += "<td style='cursor:pointer;' onclick='getIndex(" + i + ",\"" + obj.detCode + "\",\"" + obj.sysKind + "\")'>" + obj.detCycle +"</td>";
						dataHtml += "<td>" + strSelect +"</td>";
						dataHtml += "</tr>";
					}
				}
				
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
				$("#dataList tr:odd").attr("class","even");
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
				
				var dataHtml="<tr><td colspan='6'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "</td></tr>";
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
				
				closeLoading();
			}
		});
	}
	 
	//측정소 클릭시
	function tdClick(idx) {
		$("#dataList tr td").removeClass("tr_on");
		$("#dataList tr:nth(" + idx + ") td").addClass("tr_on");
	}
	
	function smsDetInsert(){
		showLoading();
		
		var sysType = $("#sysType").val();
		var DetCycleInsert = $("#DetCycleInsert").val();
		var DetDetailContentInsert = $("#DetDetailContentInsert").val();
		var DetContentInsert = $("#DetContentInsert").val();
		var dpYnInsert = $("#dpYnInsert").val();
		
		if(vaildateItem() == true){
			
			var detContent = sysKindName(sysType) + " " + detContentName(DetContentInsert);
			//alert("코드내용:" + detContent);
			
			$.ajax({
				type:"post",
				url:"<c:url value='/smsmanage/smsDetInsert.do'/>",
				data:{
					detCode:DetContentInsert,
					sysKind:sysType,
					detCycle:DetCycleInsert,
					detDetailContent:DetDetailContentInsert,
					detContent:detContent,
					dpYn:dpYnInsert
				},
				dataType:"json",
				success:function(result){
					reloadData();
					layerPopClose('layerDetConReg');
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
					
// 					$("#dataList").html("");
					$("#dataList").html("<tr><td colspan='7' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
					closeLoading();
				}
			});
		}
	}
	
	function vaildateItem(){
		if ($("#sysType").val() == ""){
			alert("시스템을 선택해주세요.");
			closeLoading();
			return false;
		}
		if ($("#DetCycleInsert").val() == ""){
			alert("검출주기를 입력해주세요.");
			closeLoading();
			return false;
		}
		if ( $("#DetDetailContentInsert").val() == ""){
			alert("검출세부내용을 입력해주세요.");
			closeLoading();
			return false;
		}
		if ($("#DetContentInsert").val() == ""){
			alert("검출내용을 선택해주세요.");
			closeLoading();
			return false;
		}
		return true;
	}
	
	function smsDetDelete(detCode){
		showLoading(); 
		$.ajax({
			type:"post",
			url:"<c:url value='/smsmanage/smsDetDelete.do'/>",
			data:{
				detCode:detCode
			},
			dataType:"json",
			success:function(result){
				reloadData();
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
				$("#dataList").html("<tr><td colspan='7' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}
	
	function smsMultiple(){
		if (confirm('사용여부에 체크된 모든 검출사항이 삭제됩니다.\n삭제하시겠습니까?')) {
			if($("input[name=smsDetCheck]:checked").length>0){
				$("input[name=smsDetCheck]").each(function(){
					if(this.checked){
						smsDetDelete(this.value);
					}
				});
			}else{
				alert("체크된 항목이 없습니다.");
				return;
			}
		}
	}
	
	function smsMultipleSave(){
		//if($("input[name=smsDetCheck]:checked").length>0){
		showLoading();
		var cnt = 0;
		var sCnt = 0;
		var total = document.frm.detCode.length;
		for (var i=0 ; i < total ; i++) {
			var detCode = document.frm.detCode[i].value;
			var dpYn = document.frm.dpYn[i].value;
			var sysKind = document.frm.sysKind[i].value;
			var useFlag = document.frm.useFlag[i].value;
			if (dpYn != useFlag) {
				dpYn = useFlag;
				cnt++;
				$.ajax({
					type:"post",
					url:"<c:url value='/smsmanage/smsDetMultipleSave.do'/>",
					data:{
						detCode:detCode,
						dpYn:dpYn,
						sysKind:sysKind
					},
					dataType:"json",
					success:function(result){
						sCnt++;
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
						
// 						alert("서버 접속에 실패하였습니다. [CODE:" + oraErrorCode + "]");
						alert("서버 접속에 실패하였습니다.");
						reloadData();
						closeLoading();
						return;
					}
				});
			}
		}
		
		if (cnt < 1) {
			alert("원하시는 대상의 사용여부를 변경 후 저장하시기 바랍니다.");
		} else {
			reloadData();
			
			if (cnt != sCnt) {
				alert("사용여부 변경저장 중 일부 사항이 변경되지 않았습니다.");
			} else {
				alert("사용여부 " + sCnt + "건이 변경 저장되었습니다.")
			}
		}
		closeLoading();
	}
	
	//측정소 리스트 사용
	function getBranchList(){
		showLoading(); 
		
		var detCode;
		var indexNum = $("#indexNum").val();
		
		if (indexNum == "" || indexNum == "undefined"){
			alert("검출지점을 선택하세요.");
			$("select[name=c_river_div]").val('ALL');
			closeLoading();
			return;
		}
		
		if($("#detCode").val() != ""){
			detCode = $("#detCode").val(); 
		}else{
			alert("검출지점을 선택하세요.");
			closeLoading();
			return;
		}
		
		var riverDiv = $("select[name=c_river_div]").val();
		//var sysKind = $("select[name=c_sys_kind]").val();
// 		var syskind = $("#msysType"+indexNum).val();
		var syskind = "U";	//IP_USN만 관리하기로 결정 2014.03.17 김경환
		if (syskind == "" || syskind == "undefined"){
			alert("입력값이 정확하지 않습니다.\n확인해 주세요.");
			closeLoading();
			return;
		}
		var pageNo;
		
		if (pageNo == null) pageNo = 1;
		
		$.ajax({
			type:"post",
			url:"<c:url value='/smsmanage/getBranchList.do'/>",
			data:{
					pageIndex:pageNo,
					sysKind:syskind,
					riverDiv:riverDiv,
					detCode:detCode
				},
			dataType:"json",
			success:function(result){
// 				console.log("getBranchList result : ", result);
				var tot = result['detailViewList'].length;
				$("#branchDateList").html("");
				
				if( tot <= 0 ){
					$("#branchDateList").html("<tr><td colspan='4' style='text-align:center;'>조회 결과가 없습니다.</td></td>");
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['detailViewList'][i];
						
							var item = "<tr>";
							item +="<td>"+obj.branchName+"</td>"
								+ "<td id='st"+i+"'>"+obj.sysKind+"</td>"
								+ "<td id='rn"+i+"'>"+obj.riverName+"</td>"
								+ "<td><input type='checkbox' id='branchCheck' name='branchCheck' value='"+obj.factCode+"/"+obj.branchNo+"' /></td>"
								+ "</tr>";
						$("#branchDateList").append(item);
						$("#branchDateList tr:odd").attr("class","add");
					}
				} 
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
				$("#branchDateList").html("<tr><td colspan='4' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}
	
	//체크 측정소 추가
	function branchMultipleAdd(){
		if($("input[name=branchCheck]:checked").length>0){
			$("input[name=branchCheck]").each(function(){
				if(this.checked){
					var check = this.value.split('/');
					goSmsBranchSave(check[0],check[1]);
				}
			});
			getBranchList();
		}else{
			alert("체크된 항목이 없습니다.");
			return;
		}
	}
	
	function goSmsBranchSave(factCode,branchNo){
		var detCode = $("#detCode").val();
		showLoading();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/smsmanage/goSmsBranchSave.do'/>",
			data:{
				detCode:detCode,
				factCode:factCode,
				branchNo:branchNo
			},
			dataType:"json",
			success:function(result){
				getSMSBranchList($("#detCode").val());
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
				$("#dataList").html("<tr><td colspan='7' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}
	
	//SMS검출대상선택 리스트
	function getSMSBranchList(detCode){
		$("#detCode").val(detCode);
		$("#factCode").val("");
		$("#branchNo").val("");
		
		var indexNum = $("#indexNum").val();
		
		if (indexNum == "" || indexNum == "undefined"){
			alert("검출지점을 선택해 주세요.");
			closeLoading();
			return;
		}
		
// 		var syskind = $("#msysType"+indexNum).val();
		var syskind = "U";	//IP_USN만 관리하기로 결정 2014.03.17 김경환
		//alert("syskind:"+syskind);
		if (syskind == "" || syskind == "undefined"){
			alert("입력값이 정확하지 않습니다.\n확인해 주세요.");
			closeLoading();
			return;
		}
		
		getBranchList();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/smsmanage/getSMSBranchList.do'/>",
			data:{
				detCode:detCode,
				sysKind:syskind
			},
			dataType:"json",
			success:function(result){
				var tot = result['detailViewList'].length;
				$("#SMSBranchDateList").html("");
				
				if( tot <= 0 ){
					$("#SMSBranchDateList").html("<tr><td colspan='5' style='text-align:center;'>조회 결과가 없습니다.</td></td>");
				}else{
					for(var i=0; i < tot; i++){
						
						var obj = result['detailViewList'][i];
							var no = i+1;
							var item = "<tr>"
									+ "<td>"+ no +"</td>"
									+ "<td><a href=javascript:getSMSList('"+obj.factCode+"','"+obj.branchNo+"')>"+obj.branchName+"</td>"
									+ "<td id='rd"+i+"'><a href=javascript:getSMSList('"+obj.factCode+"','"+obj.branchNo+"')>"+obj.factCode+"</a></td>"
									+ "<td id='st"+i+"'>"+obj.branchNo+"</td>"
									+ "<td><input type='checkbox' id='smsbranchCheck' name='smsbranchCheck' value='"+obj.factCode+"/"+obj.branchNo+"' /></td>"
									+ "</tr>";
						
						$("#SMSBranchDateList").append(item);
						$("#SMSBranchDateList tr:odd").attr("class","add"); 
					}
				}
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
				$("#SMSBranchDateList").html("<tr><td colspan='7' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
			}
		});
		closeLoading();
// 		getAllUserList();	//sms대상자 선택 사용자 소속 리스트
		getSMSList();		//sms대상자 선택 리스트
// 		getSMSTargetList();	//sms수신대상자
	}
	
	function MultipleSMSBranchCheck(){
		if($("input[name=smsbranchCheck]:checked").length>0){
			showLoading();
			$("input[name=smsbranchCheck]").each(function(){
				var dpYn;
				var check = this.value.split('/');
				if(this.checked){
					dpYn="Y";
				}else{
					dpYn="N";
				}
				$.ajax({
					type:"post",
					url:"<c:url value='/smsmanage/goSmsBranchDpYn.do'/>",
					data:{
						detCode:$("#detCode").val(),
						factCode:check[0],
						branchNo:check[1],
						dpYn:dpYn
					},
					dataType:"json",
					success:function(result){
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
						$("#SMSBranchDateList").html("<tr><td colspan='7' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
						closeLoading();
					}
				});
			});
		}else{
			alert("체크된 항목이 없습니다.");
			return;
		}
	}
	
	function MultiBranchDel(){
		if (confirm('사용여부에 체크된 모든 검출대상이 삭제됩니다.\n삭제하시겠습니까?')) {
			if($("input[name=smsbranchCheck]:checked").length>0){
				$("input[name=smsbranchCheck]").each(function(){
					if(this.checked){
						var check = this.value.split('/');
						SMSBranchDelete(check[0],check[1]);
					}
				});
			}else{
				alert("체크된 항목이 없습니다.");
				return;
			}
		}
	}
	
	function SMSBranchDelete(factCode,branchNo){
		$.ajax({
			type:"post",
			url:"<c:url value='/smsmanage/SMSBranchDelete.do'/>",
			data:{
				detCode:$("#detCode").val(),
				factCode:factCode,
				branchNo:branchNo
			},
			dataType:"json",
			success:function(result){
				getBranchList();
				getSMSBranchList($("#detCode").val());
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
				$("#SMSBranchDateList").html("<tr><td colspan='5' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}
	
	//해당측정소별 지점별 SMS수신대상자 가져오기
	function getSMSList(factCode, branchNo) {
		$("#factCode").val(factCode);
		$("#branchNo").val(branchNo);
		
		getAllUserList();	//사용자 소속 리스트 
		getSMSTargetList(factCode, branchNo);	//sms수신대상자
	}
	
	//사용자 소속 리스트 
	function getAllUserList(){
		showLoading(); 
		if($("#factCode").val() == "" || $("#branchNo").val() == "") {
			$("#userList").html("<tr><td colspan='3' style='text-align:center;'>검출대상지점을 선택해 주세요.</td></td>");
			closeLoading();
		}else{
			$("select[name=c_dept_code]").val('1000');
			var deptCode = $("select[name=c_dept_code]").val();
			var factCode = $("#factCode").val();
			var branchNo = $("#branchNo").val();
			var pageNo;
			if (pageNo == null) pageNo = 1;
			$.ajax({
				type:"post",
				url:"<c:url value='/smsmanage/getAllUserList.do'/>",
				data:{
					pageIndex:pageNo,
					deptCode:deptCode,
					factCode:factCode,
					branchNo:branchNo
				},
				dataType:"json",
				success:function(result){
					var tot = result['detailViewList'].length;
					$("#userList").html("");
					
					if( tot <= 0 ){
						$("#userList").html("<tr><td colspan='3' style='text-align:center;'>조회 결과가 없습니다.</td></td>");
					}else{
						for(var i=0; i < tot; i++){
							var obj = result['detailViewList'][i];
							var item = "<tr>"
								+ "<td id='mem"+i+"'>"+obj.MEMBER_NAME+"</td>"
								+ "<td id='off"+i+"'>"+obj.OFFICE_NAME+"</td>"
								+ "<td><input type='checkbox' id='userCheck' name='userCheck' value='"+obj.MEMBER_ID+"' /></td>"
								+ "</tr>"; 
								
							$("#userList").append(item);
							$("#userList tr:odd").attr("class","add");
						}
					}
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
					$("#userList").html("<tr><td colspan='3' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
					closeLoading();
				}
			});
		}
	}
	
	//SMS공통수신대상자 리스트
	function getCommAllUserList(){
		showLoading();
		
		var detCode = $("#detCode").val();
		var deptCode = $("select[name=c_dept_code2]").val();
		var sKeyword = $('#branch_mgr_name').val();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/smsmanage/getAllUserList.do'/>",
			data:{
				detCode:detCode,
				deptCode:deptCode,
				sKeyword:sKeyword
			},
			dataType:"json",
			success:function(result){
				var tot = result['detailViewList'].length;
				var dataHtml="";
				if( tot <= 0 ){
					dataHtml="<tr><td colspan='8'>조회 결과가 없습니다.</td></tr>";
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['detailViewList'][i];
						var no = i + 1; 
						obj.no = no;
						
						var userCheck="<input type='checkbox' id='commUserCheck' name='commUserCheck' value='" + obj.MEMBER_ID + "' style='margin-top:4px;' />";
						
						dataHtml +="<tr>";
						dataHtml += "<td>" + obj.no +"</td>";
						dataHtml += "<td>" + obj.MEMBER_NAME +"</td>";
						dataHtml += "<td>" + obj.OFFICE_NAME +"</td>";
						dataHtml += "<td>" + userCheck +"</td>";
						dataHtml += "</tr>";
					}
				}
				$("#dataList1").html("");
				$('#dataList1').append(dataHtml);
				$("#dataList1 tr:odd").attr("class","even");
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
				var dataHtml="<tr><td colspan='4'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "</td></tr>";
				$("#dataList1").html("");
				$('#dataList1').append(dataHtml);				
				closeLoading();
			}
		});
	}
	
	//체크 소속 사용자 추가
	function userMultipleAdd(){
		if($("input[name=userCheck]:checked").length>0){
			$("input[name=userCheck]").each(function(){
				if(this.checked){
					var check = this.value;
					goSmsTargetSave(check);
				}
			});
			//getBranchList();
		}else{
			alert("체크된 항목이 없습니다.");
			return;
		}
	}
	
	//SMS공통수신대상자  추가
	function commUserReg(){
/* 		var cnt = 0;
// 		console.log("grid1.getDataLength() : ",grid1.getDataLength());
		for (var i=0 ; i < grid1.getDataLength() ; i++) {
			if (grid1.getDataItem(i).useChecked) {
				cnt++;
// 				console.log("cnt : ",cnt);
				var memberId = grid1.getDataItem(i).MEMBER_ID;
					goCommSmsTargetSave(memberId);
			}
		}
		if (cnt < 1) {
			alert("체크된 항목이 없습니다.");
			return;
		} */
		
		var form = document.frm1;
		if ( $('input:checkbox[name="commUserCheck"]:checked').length > 0 ){
			$(":checkbox[name='commUserCheck']:checked").each(function(pi,po){
				goCommSmsTargetSave(po.value);
			});
		} else {
			alert("체크된 항목이 없습니다.");
			return;
		}
	}
	
	function getSMSTargetList(factCode, branchNo) {
		var detCode = $("#detCode").val();
		// SMS 지점별 수신 대상자조회
		if($("#factCode").val() == "" || $("#branchNo").val() == "") {
			$("#smsTargetList").html("<tr><td colspan='5' style='text-align:center;'>검출대상지점을 선택해 주세요.</td></td>");
		}else{
			showLoading();
			var pageNo;
			if (pageNo == null) pageNo = 1;
			$.ajax({
				type:"post",
				url:"<c:url value='/smsmanage/getSMSTargetList.do'/>",
				data:{
					pageIndex:pageNo,
					factCode:factCode,
					branchNo:branchNo,
					detCode:detCode,
					recvType:"B"
				},
				dataType:"json",
				success:function(result){
					var tot = result['detailViewList'].length;
					$("#smsTargetList").html("");
					
					if( tot <= 0 ){
						$("#smsTargetList").html("<tr><td colspan='5' style='text-align:center;'>조회 결과가 없습니다.</td></td>");
						 closeLoading();
					}else{
						for(var i=0; i < tot; i++){
							var obj = result['detailViewList'][i];
							var no = i+1;
							var item = "<tr>"
									+ "<td>"+ no +"</td>"
									+ "<td id='mem"+i+"'>"+obj.MEMBER_NAME+"</td>"
									+ "<td id='off"+i+"'>"+obj.OFFICE_NAME+"</td>"
									+ "<td id='mob"+i+"'>"+obj.MOBILE_NO+"</td>"
									+ "<td><input type='checkbox' id='targetCheck' name='targetCheck' value='"+obj.SMS_TARGET_NO+"' /></td>"
									+ "</tr>"; 
							
							$("#smsTargetList").append(item);
							$("#smsTargetList tr:odd").attr("class","add");
						}
					} 
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
					$("#smsTargetList").html("<tr><td colspan='5' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
					closeLoading();
				}
			});
		}
	}
	
	function getCommSMSTargetList() {
		// SMS 지점별 수신 대상자조회
		//SMS공통수신대상자
		var detCode = $("#detCode").val();
		if(detCode == "") {
			alert("검출대상이 존재하지 않습니다.");
			return;
		}
		showLoading();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/smsmanage/getSMSTargetList.do'/>",
			data:{
					detCode:detCode,
					recvType:"C"
				},
			dataType:"json",
			success:function(result){
// 				console.log("getCommSMSTargetList : ", result);
				var tot = result['detailViewList'].length;
				var dataHtml="";
				if( tot <= 0 ){
					dataHtml="<tr><td colspan='5'>조회 결과가 없습니다.</td></tr>";
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['detailViewList'][i];
						var no = i + 1;
						obj.no = no;
						
						var checkHtml = "<input type='checkbox' id='commUserCheck1' name='commUserCheck1' value='" + obj.SMS_TARGET_NO + "' style='margin-top:4px;' />";
						
						dataHtml +="<tr>";
						dataHtml += "<td>" + obj.no +"</td>";
						dataHtml += "<td>" + obj.MEMBER_NAME +"</td>";
						dataHtml += "<td>" + obj.OFFICE_NAME +"</td>";
						dataHtml += "<td>" + obj.MOBILE_NO +"</td>";
						dataHtml += "<td>" + checkHtml +"</td>";
						dataHtml += "</tr>";
					}					
				}
				$("#dataList2").html("");
				$('#dataList2').append(dataHtml);
				$("#dataList2 tr:odd").attr("class","even");
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
				var dataHtml="<tr><td colspan='5'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "</td></tr>";
				$("#dataList2").html("");
				$('#dataList2').append(dataHtml);
				
				closeLoading();
			}
		});
	}
	
	//SMS 수신 대상자 추가
	function goSmsTargetSave(memberId){
		var factCode = $("#factCode").val();
		var branchNo = $("#branchNo").val();
		var detCode = $("#detCode").val();
		
		showLoading(); 
		$.ajax({
			type:"post",
			url:"<c:url value='/smsmanage/goSmsTargetSave.do'/>",
			data:{
				factCode:factCode,
				branchNo:branchNo,
				memberId:memberId,
				detCode:detCode,
				recvType:'B'
			},
			dataType:"json",
			success:function(result){
				getAllUserList();
				getSMSTargetList(factCode, branchNo);
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
				$("#smsTargetList").html("<tr><td colspan='5' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}
	
	//SMS 공통 수신 대상자 추가
	function goCommSmsTargetSave(memberId){
		var detCode = $("#detCode").val();
		showLoading(); 
		
		$.ajax({
			type:"post",
			url:"<c:url value='/smsmanage/goSmsTargetSave.do'/>",
			data:{
					detCode:detCode,
					memberId:memberId,
					recvType:"C"
				},
			dataType:"json",
			success:function(result){
				getCommAllUserList();
				getCommSMSTargetList();
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
				$("#commmsTargetList").html("<tr><td colspan='5' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}
	
	//SMS 대상 수신자 저장
	function goSmsTargetMultipleSave(){
		if($("input[name=targetCheck]:checked").length>0){
			showLoading(); 
			$("input[name=targetCheck]").each(function(){
				if(this.checked){
					useFlag = "Y";
				}else{
					useFlag = "N";
				}
				
				$.ajax({
					type:"post",
					url:"<c:url value='/smsmanage/goSmsTargetMultipleSave.do'/>",
					data:{
						smsTargetNo:this.value,
						useFlag:useFlag
					},
					dataType:"json",
					success:function(result){
						getAllUserList();
						getSMSTargetList($("#factCode").val(), $("#branchNo").val());
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
						$("#smsTargetList").html("<tr><td colspan='5' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
						closeLoading();
					}
				});
			});
		}else{
			alert("체크된 항목이 없습니다.");
			return;
		}
	}
	
	//SMS 대상 수신자 삭제
	function goSmsTargetMultipleDelete(){
		
		if (confirm('선택에 체크된 모든 SMS수신대상이 삭제됩니다.\n삭제하시겠습니까?')) {
			if($("input[name=targetCheck]:checked").length>0){
				showLoading(); 
				$("input[name=targetCheck]").each(function(){
					if(this.checked){
						smsTargetNo = this.value;
					}else{
						smsTargetNo = 0;
					}
					$.ajax({
						type:"post",
						url:"<c:url value='/smsmanage/goSmsTargetMultipleDelete.do'/>",
						data:{
							smsTargetNo:smsTargetNo
						},
						dataType:"json",
						success:function(result){
							getAllUserList();
							getSMSTargetList($("#factCode").val(), $("#branchNo").val());
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
							$("#smsTargetList").html("<tr><td colspan='5' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
							closeLoading();
						}
					});
				});
			}else{
				alert("체크된 항목이 없습니다.");
				return;
			}
		}
	}
	
	//SMS 공통대상 수신자 삭제
	function goCommSmsTargetDelete(){
		var cnt = 0;
		var sCnt = 0;
// 		console.log("grid2.getDataLength() : ",grid1.getDataLength());
		var form = document.frm2;
		$(":checkbox[name='commUserCheck1']:checked").each(function(pi,po){
				cnt++;
				var smsTargetNo = po.value;
				$.ajax({
					type:"post",
					url:"<c:url value='/smsmanage/goSmsTargetMultipleDelete.do'/>",
					data:{
						smsTargetNo:smsTargetNo
					},
					dataType:"json",
					success:function(result){
						sCnt++;
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
// 						alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
						alert("서버 접속에 실패하였습니다.");
						getCommAllUserList();
						getCommSMSTargetList();
						closeLoading();
						return;
					}
				});
		});
		
		if (cnt < 1) {
			alert("체크된 항목이 없습니다.");
		} else {
			getCommAllUserList();
			getCommSMSTargetList();
			
			if (cnt != sCnt) {
				alert("공통수신대상자 삭제 중 일부 대상자가 삭제되지 않았습니다.");
			} else {
				alert("공통수신대상자 " + sCnt + "명이 삭제되었습니다.")
			}
		}
		closeLoading();
	}
	
	function getIndex(index,detCode,sysKind){
		$("#detCode").val(detCode);
		$("#sysKind").val(sysKind);
		
		$("#indexNum").val(index);
		
		getSMSBranchList(detCode);
	}
	
// 	function smsMultipleUpdate(sysType,detCode,detDetailContent,detCycle,dpYn){
		
// 		layerPopOpen('layerBraConModForm');
		
// 		if (sysType == "U"){
// 			$("#sysTypeUp > option[value='U']").attr("selected", "selected");
// 		} else {
// 			$("#sysTypeUp > option[value='A']").attr("selected", "selected");
// 		}
		
// 		if (detCode == "100"){
// 			$("#DetContentInsertUp > option[value='100']").attr("selected", "selected");
// 		} else if (detCode == "200"){
// 			$("#DetContentInsertUp > option[value='200']").attr("selected", "selected");
// 		} else {
// 			$("#DetContentInsertUp > option[value='300']").attr("selected", "selected");
// 		}
		
// 		if (dpYn == "Y"){
// 			$("#dpYnInsertUp > option[value='Y']").attr("selected", "selected");
// 		} else {
// 			$("#dpYnInsertUp > option[value='N']").attr("selected", "selected");
// 		}
		
// 		$("#DetCycleInsertUp").val(detCycle);
// 		$("#DetDetailContentInsertUp").val(detDetailContent);
// 	}
	
	function layerComRec() {
		if($("#detCode").val() == ""){
			alert("검출대상을 선택하세요.");
			return;
		} else {
			getCommAllUserList();
			getCommSMSTargetList();
		}
		layerPopOpen("layerComRec");
	}
	
	function layerBraConMod() {
		if($("#detCode").val() == ""){
			alert("검출대상을 선택하세요.");
			return;
		} else {
			$("#sugye>option:first").attr("selected", "true");
			adjustGongku();
			smsBranchCfgList();
		}
		layerPopOpen("layerBraConMod");
	}
	
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("layerDetConReg");
		layerPopClose("layerBraConMod");
		layerPopClose("layerGroDel");
		layerPopClose("layerComRec");
	}

	//공통수신자관리자 검색(정)
	
	//관리자정보 확인
	function dispSearchTable(result){
		
		var tot = result.length;
// 		$("#memberLayer").show();
		$("#commUserList").html("");
		if(tot == 0){
			$("#commUserList").html("<tr><td colspan='3'>조회 결과가 없습니다.</td></td>");
		}
		else{
			var item = "";
			
			for(var i = 0 ; i < tot ; i++){
				var obj = result[i];
				
// 				item = "<tr style='cursor:pointer;' onclick='javascript:onSelMember('" + obj + "')>"
				item = "<tr>"
					+ "<td>"+obj.memberName+"</td>"
					+ "<td>"+obj.deptName+"</td>"
// 					+"<td>"+obj.gradeName+"</td>"
					+ "<td><input type='checkbox' id='commUserCheck' name='commUserCheck' value='"+obj.memberid+"' /></td>"
					+ "</tr>";
				$("#commUserList").append(item);
				$("#commUserList tr:odd").addClass("add");
			}
		}
	}
	
	function onSelMember(memberName, memberId, phoneNo){
		$("#branch_mgr_name").val(memberName);
		$("#branch_mgr_tel_no").val(phoneNo);
		$("#branch_mgr").val(memberId);
		
// 		layerController("member");
	}
	
	function adjustGongku() {
		var sugye = $("#sugye").val();
		var system = $("#sysKind").val();
		var dropDownSet = $('#factCodeX');
		
		dropDownSet.attr({ disabled: false, style:"background:#ffffff;" });
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getGongkuList.do'/>",
			data:{
				sugye:sugye,
				system:system
			},
			dataType:"json",
			success:function(result){
// 				console.log("getGongkuList:",result);
				dropDownSet.loadSelect(result.gongku);
				
				if(system == "U"){
					dropDownSet.attr({ disabled: true, style:"background:#e9e9e9;" });
					dropDownSet.hide();
				}
				adjustBranchList();
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
// 				alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				alert("공구 목록 가져오기 실패");
				closeLoading();
			}
		});
	}
	
	//측정소 목록 가져오기
	function adjustBranchList() {
		var system = $("#sysKind").val();
		var factCode = $("#factCodeX").val();
		var dropDownSet = $("#branchNoX");
		
		dropDownSet.attr({ disabled: false, style:"background:#ffffff;" });
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>",
			data:{
				factCode:factCode
			},
			dataType:"json",
			success:function(result){
// 				console.log("getBranchList:",result);
				//locId 객체에 SELECT 옵션내용 추가.
				dropDownSet.loadSelect(result.branch);
				
				if (system == "A"){
					dropDownSet.attr({ disabled: true, style:"background:#e9e9e9;" });
					dropDownSet.hide();
				}
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
// 				alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				alert("공구 목록 가져오기 실패");
				closeLoading();
			}
		});
	}
	
	//지점별 SMS 유형별 검출내역 리스트
	function smsBranchCfgList() {
// 		var sysKind = $("#sysKind").val();
		var detCode = $("#detCode").val();
		var factCode = $("#factCodeX").val();
		var branchNo = $("#branchNoX").val();
// 		var branchNoName = $("#branchNoX > option[value="+branchNo+"]").html();
		var branchNoName = $("#branchNoX > option:selected").text();

		$.ajax({
			type:"post",
			url:"<c:url value='/smsmanage/getSmsBranchCfgList.do'/>",
			data:{
				detCode:detCode,
				factCode:factCode,
				branchNo:branchNo
			},
			dataType:"json",
			success:function(result){
// 				console.log("getSmsBranchCfgList:",result);
				var tot = result['detailViewList'].length;
				var dataHtml="";
				if( tot <= 0 ){
					var total = 3;
					if(detCode == "200" || detCode == "210"){
						total = 2;
					}
					for(var i=0; i < total; i++){
						var obj = {};
						obj.branch_no = branchNo;
						obj.branch_no_name = branchNoName;
						obj.chk_delay = "";
						obj.chk_loc = "";
						obj.chk_range = "";
						obj.contant = "";
						obj.det_code = detCode;
						obj.det_type = i+1;
						obj.detail_explan = "";
						obj.fact_code = factCode;
						obj.no = i+1;
						obj.not_rcv = "";
						obj.not_send_from = "";
						obj.not_send_to = "";
						obj.same_val = "";
						obj.use_flag = "N";
						
						if(detCode == "100") {
							if(i==0){
								obj.contant = "보내지 않는 시간";
								$('#det_code').val(obj.det_code);
							}else if(i==1){
								obj.contant = "검출 지연 시간(분)";
							}else{
								obj.contant = "수신율 몇% 미만";
							}
						} else if(detCode == "200" || detCode == "210"){
							if(i==0){
								obj.contant = "보내지 않는 시간";
								$('#det_code').val(obj.det_code);
							}else{
								obj.contant = "검출 지연 시간(분)";
							}
						} else {
							if(i==0){
								obj.contant = "보내지 않는 시간";
								$('#det_code').val(obj.det_code);
							}else if(i==1){
								obj.contant = "검출 지연 시간(분)";
							}else{
								obj.contant = "위치 이탈 범위 지정(M)";
							}
						}
						
						//조건값 설정
						var detTypeHtml = "";
						if(obj.det_type == "1"){
							detTypeHtml="<input id='not_send_from" + obj.det_type + "' name='not_send_from' value='" + obj.not_send_from + "' style='width:20px' tabIndex='0' >";
							detTypeHtml+="&nbsp;~&nbsp;<input id='not_send_to" + obj.det_type + "' name='not_send_to' value='"+obj.not_send_to+"' style='width:20px' tabIndex='1' >";
							detTypeHtml+="<input type='hidden' id='chk_delay" + obj.det_type + "' name='chk_delay' value='" + obj.chk_delay + "'style='width:70px' >";
							detTypeHtml+="<input type='hidden' id='not_rcv" + obj.det_type + "' name='not_rcv' value='" + obj.not_rcv + "'style='width:70px' >";
						}else if(obj.det_type == "2"){
							detTypeHtml="<input id='chk_delay" + obj.det_type + "' name='chk_delay' value='" + obj.chk_delay + "'style='width:70px' >";
							detTypeHtml+="<input type='hidden' id='not_rcv" + obj.det_type + "' name='not_rcv' value='" + obj.not_rcv + "'style='width:70px' >";
							detTypeHtml+="<input type='hidden' id='not_send_from" + obj.det_type + "' name='not_send_from' value='" + obj.not_send_from + "' style='width:20px' tabIndex='0' >";
							detTypeHtml+="<input type='hidden' id='not_send_to" + obj.det_type + "' name='not_send_to' value='"+obj.not_send_to+"' style='width:20px' tabIndex='1' >";
						}else{
							detTypeHtml="<input id='not_rcv" + obj.det_type + "' name='not_rcv' value='" + obj.not_rcv + "'style='width:70px' >";
							detTypeHtml+="<input type='hidden' id='chk_delay" + obj.det_type + "' name='chk_delay' value='" + obj.chk_delay + "'style='width:70px' >";
							detTypeHtml+="<input type='hidden' id='not_send_from" + obj.det_type + "' name='not_send_from' value='" + obj.not_send_from + "' style='width:20px' tabIndex='0' >";
							detTypeHtml+="<input type='hidden' id='not_send_to" + obj.det_type + "' name='not_send_to' value='"+obj.not_send_to+"' style='width:20px' tabIndex='1' >";
						}
						
						//세부설명
						var detailExplan = "<input id='detail_explan" + obj.det_type + "' name='detail_explan' value='" + obj.detail_explan + "'style='width:280px' >";
						detailExplan += "<input type='hidden' id='chk_loc" + obj.det_type + "' name='chk_loc' value='" + obj.chk_loc + "' >";
						
						//사용여부 설정
						var useFlagHtml = "";
						useFlagHtml += "<select id='use_flag" + obj.det_type + "' name='use_flag' >";
						if(obj.use_flag == "Y"){
							useFlagHtml += "<option value='Y' selected='true'>사용</option><option value='N'>미사용</option>";
						}else{
							useFlagHtml += "<option value='Y'>사용</option><option value='N' selected='true'>미사용</option>";
						}
						useFlagHtml += "</select>";
						
						dataHtml +="<tr>";
						dataHtml += "<td>" + obj.det_code +"</td>";
						dataHtml += "<td>" + obj.branch_no_name +"</td>";
						dataHtml += "<td>" + obj.contant +"</td>";
						dataHtml += "<td>" + detTypeHtml +"</td>";
						dataHtml += "<td>" + detailExplan +"</td>";
						dataHtml += "<td>" + useFlagHtml +"</td>";
						dataHtml += "</tr>";
					}
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['detailViewList'][i];
						var no = i + 1;
						obj.no = no;
						if(obj.det_type == "1"){
							obj.contant = "보내지 않는 시간";
						}else if(obj.det_type == "2"){
							obj.contant = "검출 지연 시간(분)";
						}else if(detCode != 300 && obj.det_type == "3"){
							obj.contant = "수신율 몇% 미만";
						}else{
							obj.contant = "위치 이탈 범위 지정(M)";
						}
						
						if(i==0) $('#det_code').val(obj.det_code);
						
						//조건값 설정
						var detTypeHtml = "";
						if(obj.det_type == "1"){
							detTypeHtml="<input id='not_send_from" + obj.det_type + "' name='not_send_from' value='" + obj.not_send_from + "' style='width:20px' tabIndex='0' >";
							detTypeHtml+="&nbsp;~&nbsp;<input id='not_send_to" + obj.det_type + "' name='not_send_to' value='"+obj.not_send_to+"' style='width:20px' tabIndex='1' >";
							detTypeHtml+="<input type='hidden' id='chk_delay" + obj.det_type + "' name='chk_delay' value='" + obj.chk_delay + "'style='width:70px' >";
							detTypeHtml+="<input type='hidden' id='not_rcv" + obj.det_type + "' name='not_rcv' value='" + obj.not_rcv + "'style='width:70px' >";
						}else if(obj.det_type == "2"){
							detTypeHtml="<input id='chk_delay" + obj.det_type + "' name='chk_delay' value='" + obj.chk_delay + "'style='width:70px' >";
							detTypeHtml+="<input type='hidden' id='not_rcv" + obj.det_type + "' name='not_rcv' value='" + obj.not_rcv + "'style='width:70px' >";
							detTypeHtml+="<input type='hidden' id='not_send_from" + obj.det_type + "' name='not_send_from' value='" + obj.not_send_from + "' style='width:20px' tabIndex='0' >";
							detTypeHtml+="<input type='hidden' id='not_send_to" + obj.det_type + "' name='not_send_to' value='"+obj.not_send_to+"' style='width:20px' tabIndex='1' >";
						}else{
							detTypeHtml="<input id='not_rcv" + obj.det_type + "' name='not_rcv' value='" + obj.not_rcv + "'style='width:70px' >";
							detTypeHtml+="<input type='hidden' id='chk_delay" + obj.det_type + "' name='chk_delay' value='" + obj.chk_delay + "'style='width:70px' >";
							detTypeHtml+="<input type='hidden' id='not_send_from" + obj.det_type + "' name='not_send_from' value='" + obj.not_send_from + "' style='width:20px' tabIndex='0' >";
							detTypeHtml+="<input type='hidden' id='not_send_to" + obj.det_type + "' name='not_send_to' value='"+obj.not_send_to+"' style='width:20px' tabIndex='1' >";
						}
						
						//세부설명
						var detailExplan = "<input id='detail_explan" + obj.det_type + "' name='detail_explan' value='" + obj.detail_explan + "'style='width:280px' >";
						detailExplan += "<input type='hidden' id='chk_loc" + obj.det_type + "' name='chk_loc' value='" + obj.chk_loc + "' >";
						
						//사용여부 설정
						var useFlagHtml = "";
						useFlagHtml += "<select id='use_flag" + obj.det_type + "' name='use_flag' >";
						if(obj.use_flag == "Y"){
							useFlagHtml += "<option value='Y' selected='true'>사용</option><option value='N'>미사용</option>";
						}else{
							useFlagHtml += "<option value='Y'>사용</option><option value='N' selected='true'>미사용</option>";
						}
						useFlagHtml += "</select>";
						
						dataHtml +="<tr>";
						dataHtml += "<td>" + obj.det_code +"</td>";
						dataHtml += "<td>" + obj.branch_no_name +"</td>";
						dataHtml += "<td>" + obj.contant +"</td>";
						dataHtml += "<td>" + detTypeHtml +"</td>";
						dataHtml += "<td>" + detailExplan +"</td>";
						dataHtml += "<td>" + useFlagHtml +"</td>";
						dataHtml += "</tr>";
					}
				}
				$("#dataList3").html("");
				$('#dataList3').append(dataHtml);
				$("#dataList3 tr:odd").attr("class","even");
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
				
				var dataHtml="<tr><td colspan='6'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "</td></tr>";
				$("#dataList3").html("");
				$('#dataList3').append(dataHtml);
				closeLoading();
			}
		});
	}
	
	//지점별 SMS 유형별 검출내역 업데이트
	function smsBranchDetUpdate(){
		showLoading();
		
		var cnt = 0;
		var falg = false;
		
		var fact_code = $('#factCodeX').val();
		var branch_no = $('#branchNoX').val();
		var det_code = $('#det_code').val();
		
		var total = document.frm3.detail_explan.length;
		for (var i=0 ; i < total ; i++) {
			if(falg)  return;
			var det_type = i+1;
			var not_send_from = document.frm3.not_send_from[i].value;
			var not_send_to = document.frm3.not_send_to[i].value;
			var chk_delay = document.frm3.chk_delay[i].value;
			var chk_loc = document.frm3.chk_loc[i].value;
			var not_rcv = document.frm3.not_rcv[i].value;
			var use_flag = document.frm3.use_flag[i].value;
			var detail_explan = document.frm3.detail_explan[i].value;
			
			$.ajax({
				type:"post",
				url:"<c:url value='/smsmanage/smsBranchDetInsert.do'/>",
				data:{
					 det_code:det_code
					,fact_code:fact_code
					,branch_no:branch_no
					,det_type:det_type
					,not_send_from:not_send_from
					,not_send_to:not_send_to
					,chk_delay:chk_delay
// 					,chk_range:chk_range
					,chk_loc:chk_loc
					,not_rcv:not_rcv
// 					,same_val:same_val
					,use_flag:use_flag
					,detail_explan:detail_explan
				},
				dataType:"json",
				success:function(result){
					cnt++;
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
// 					alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
					alert("서버 접속에 실패하였습니다. [i:" + i + "]");
					falg = true;
					closeLoading();
				}
			});
		}
		
		if(cnt >= 3)
			alert("저장되었습니다.");
		else
			alert("일부 내용이 저장 되지 않았습니다. 다시 저장해 주세요.");
		closeLoading();
	}
//]]>
</script>
</head>

<body>
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div id="layerFullBgDiv"></div>
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
						
						<input type="hidden" id="indexNum" name="indexNum" />
						<input type="hidden" id="detCode" name="detCode" />
						<input type="hidden" id="factCode" name="factCode" />
						<input type="hidden" id="branchNo" name="branchNo" />
						<input type="hidden" id="sysKind" name="sysKind" />
						
						<!--top Search Start-->
						<div class="topBx" style="padding-bottom:10px;">
							<input type="button" id="btnInitSmsMultiple" name="btnInitSmsMultiple" value="공통수신자추가" class="btn btn_basic" onclick="javascript:layerComRec();" alt="공통수신자추가" />
							<input type="button" id="btnSetSmsMultiple" name="btnSetSmsMultiple" value="설정" class="btn btn_basic" onclick="javascript:layerBraConMod();" alt="설정" />
							<input type="button" id="btnInsertSmsMultiple" name="btnInsertSmsMultiple" value="등록" class="btn btn_basic" onclick="javascript:layerPopOpen('layerDetConReg');" alt="등록" />
<!-- 							<input type="button" id="btnDeleteSmsMultiple" name="btnDeleteSmsMultiple" value="삭제" class="btn btn_basic" onclick="javascript:smsMultiple();" alt="삭제" /> -->
							<input type="button" id="btnUpdateSmsMultiple" name="btnUpdateSmsMultiple" value="저장" class="btn btn_basic" onclick="javascript:smsMultipleSave();" alt="저장" />
						</div>
						<!--top Search End-->
						
						<div class="table_wrapper">
							<form id="frm" name="frm" action ="" method="post">
							<table summary="게시판 목록. 번호, 검출코드, 검출내용, 검출세부내용, 검출주기, 사용여부가 담김">
								<colgroup>
									<col width="45" />
									<col width="125" />
									<col width="290" />
									<col width="290" />
									<col width="130" />
									<col width="110" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">No</th>
										<th scope="col">검출코드</th>
										<th scope="col">검출내용</th>
										<th scope="col">검출세부내용</th>
										<th scope="col">검출주기</th>
										<th scope="col">사용여부</th>
									</tr>
								</thead>
								<tbody id="dataList" class="dataList">
								</tbody>
							</table>
							</form>
						</div>
						
						<div class="divisionBx" >
							<div class="div50">
								<div class="topBx">
									<span>검출대상선택</span>
								</div>
								<div class="searchBox" style="width:470px;margin-top:10px;">
									<ul>
										<li>
										<span class="fieldName">수계</span>
											<select name="c_river_div" onchange="javascript:getBranchList();">
												<option value="ALL">전체</option>
												<option value="R01">한강</option>
												<option value="R02">낙동강</option>
												<option value="R03">금강</option>
												<option value="R04">영산강</option>
											</select>
										</li>
<!--											<li>
										<span>시스템</span> -->
<!-- 											<select name="c_sys_kind" style="width:90%;" class="select" onchange="javascript:getBranchList();">
												<option value="U">이동형측정기기</option>
												<option value="T">탁수모니터링</option>
												<option value="A">국가수질자동측정망</option>
												<option value="W">방류수질정보</option>
											</select>
										</li> -->
										<li class="last">
											<input type="button" id="btnBranchMultipleAdd" name="btnBranchMultipleAdd" value="추가" class="btn btn_basic" onclick="javascript:branchMultipleAdd();" alt="추가"/>
										</li>
									</ul>
								</div>
								
								<div class="overBox" style="height:150px">
									<table id="tab_1_1" summary="수계정보">
										<colgroup>
											<col width="30%"></col>
											<col width="25%"></col>
											<col width="20%"></col>
											<col width="*"></col>
										</colgroup>
											<tr>
												<th>지점명</th>
												<th>시스템</th>
												<th>수계</th>
												<th>선택</th>
											</tr>
										<tbody id="branchDateList">
											<tr> 
												<td>&nbsp;</td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
											<tr class="add">
												<td>&nbsp;</td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
										</tbody>
									</table>
								</div>
								<br />
								<div class="topBx">
									<span>검출대상지점</span>
									<input type="button" id="btnDeleteSMSBranch" name="btnDeleteSMSBranch" value="삭제" class="btn btn_basic" onclick="javascript:MultiBranchDel();" alt="삭제" />
<!--										<input type="button" id="btnInsertSMSBranch" name="btnInsertSMSBranch" value="저장" class="btn btn_basic" onclick="javascript:MultipleSMSBranchCheck();" alt="저장" /> -->
								</div>
								
								<div class="overBox mtop10" style="height:200px">
									<table id="tab_1_1" summary="검출대상지점정보">
										<colgroup>
											<col width="10%"></col>
											<col></col>
											<col width="20%"></col>
											<col width="20%"></col>
											<col width="20%"></col>
										</colgroup>
											<tr>
												<th>연번</th>
												<th>지점명</th>
												<th>지점코드</th>
												<th>측정소번호</th>
												<th>선택</th>
											</tr>
										<tbody id="SMSBranchDateList">
											<tr> 
												<td>&nbsp;</td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
											<tr class="add">
												<td>&nbsp;</td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
								
							<div class="div50 last">
								<div class="topBx">
									<span>SMS수신대상자선택</span>
								</div>
								<div class="searchBox" style="width:470px;margin-top:10px;">
									<ul>
										<li>
										<span class="fieldName">소속</span>
											<select name="c_dept_code" onchange="javascript:getAllUserList();">
												<!-- <option value="">전체</option> -->
												<c:forEach var="list" items="${positionList }">
												<option value="${list.DEPT_CODE }">${list.DEPT_NAME }</option>
												</c:forEach>
											</select>
										</li>
										<li class="last">
											<input type="button" id="btnUserMultipleAdd" name="btnUserMultipleAdd" value="추가" class="btn btn_basic" onclick="javascript:userMultipleAdd();" alt="추가"/>
										</li>
									</ul>
								</div>
								
								<div class="overBox" style="height:150px">
									<table id="tab_1_1" summary="수신자정보">
										<colgroup>
											<col width="30%"></col>
											<col width="*"></col>
											<col width="25%"></col>
										</colgroup>
											<tr>
												<th>이름</th>
												<th>소속</th>
												<th>선택</th>
											</tr>
										<tbody id="userList">
											<tr> 
												<td>&nbsp;</td>
												<td></td>
												<td></td>
											</tr>
											<tr class="add">
												<td>&nbsp;</td>
												<td></td>
												<td></td>
											</tr>
										</tbody>
									</table>
								</div>
								<br />
								<div class="topBx">
									<span>SMS수신대상자</span>
									<input type="button" id="btnSmsTargetMultipleDelete" name="btnSmsTargetMultipleDelete" value="삭제" class="btn btn_basic" onclick="javascript:goSmsTargetMultipleDelete();" alt="삭제" />
<!--									<input type="button" id="btnSmsTargetMultipleSave" name="btnSmsTargetMultipleSave" value="저장" class="btn btn_basic" onclick="javascript:goSmsTargetMultipleSave();" alt="저장" /> -->
								</div>
								
								<div class="overBox mtop10" style="height:200px">
									<table id="tab_1_1" summary="SMS수신대상자정보">
										<colgroup>
											<col width="10%"></col>
											<col width="20%"></col>
											<col width="*"></col>
											<col width="25%"></col>
											<col width="10%"></col>
										</colgroup>
											<tr>
												<th>연번</th>
												<th>이름</th>
												<th>소속</th>
												<th>전화번호</th>
												<th>선택</th>
											</tr>
										<tbody id="smsTargetList">
											<tr> 
												<td>&nbsp;</td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
											<tr class="add">
												<td>&nbsp;</td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						
					</div>
					<!--tab Contnet End-->
				</div>
			</div>
		</div>
		<!-- Body End-->
		
		<!-- Footer Start-->
		<div id="footer">
			<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
		<!-- Footer End-->
	</div>
	
	<!-- 검출내용 등록 레이어 팝업 -->
	<div id="layerDetConReg" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnSmsUpdXbox" name="btnSmsUpdXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerDetConReg');" alt="닫기" />
		</div>
		<table summary="시스템등록정보">
			<colgroup>
				<col width="130" />
				<col />
			</colgroup>
			<tr>
				<th scope="col">시스템</th>
				<td>
					<select name="sysType" id="sysType" style="width:100%">
						<option value="">선택해주세요.</option>
						<option value="U">이동형측정기기</option>
<!-- 						<option value="T">탁수모니터링</option> -->
						<option value="A">국가수질자동측정망</option>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="col">검출내용</th>
				<td>
					<select id="DetContentInsert" name="DetContentInsert" style="width:100%">
						<option value="">선택해주세요.</option>
						<option value="100">데이터미수신</option>
						<option value="200">이상데이터 </option>
						<option value="210">기준치조과</option>
						<option value="300">위치이탈</option>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="col">검출주기</th>
				<td><input type="text" id="DetCycleInsert" name="DetCycleInsert" style="width:150px"/> 분</td>
			</tr>
			<tr>
				<th scope="col">사용여부</th>
				<td>
					<select name="dpYnInsert" id="dpYnInsert" style="width:100%">
						<option value="Y">사용</option>
						<option value="N">미사용</option>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="col">검출세부내용</th>
				<td><textarea id="DetDetailContentInsert" name="DetDetailContentInsert" rows="3" cols="24"></textarea></td>
			</tr>
		</table>
		<div id="btCarea">
			<input type="button" id="btnDetConReg" name="btnDetConReg" value="등록" class="btn btn_white" onclick="javascript:smsDetInsert();" alt="등록" />
		</div>
	</div>
	
	<!--검출내용 설정 -->
	<div id="layerBraConMod" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnSmsUpdXbox" name="btnSmsUpdXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerBraConMod');" alt="닫기"/>
		</div>
		<div class="searchBox" style="background: #fff; width:770px">
			<ul>
				<li>
					<span class="fieldName">측정소</span>
					<select class="fixWidth7" id="sugye" name="sugye">
						<option value="R01">한강</option>
						<option value="R02">낙동강</option>
						<option value="R03">금강</option>
						<option value="R04">영산강</option>
					</select>
					<span >&gt;</span>
					<select class="fixWidth11" id="factCodeX" name="factCodeX" style="display:none;">
						<option value="none">전체</option>
					</select>
					<span style="display:none;">&gt;</span>
					<select class="fixWidth11" id="branchNoX" name="branchNoX">
						<option value="none">전체</option>
					</select>
				</li>
				<li class="last">
					<input type="button" id="btnSearch" name="btnSearch" value="검색" class="btn btn_search" onclick="javascript:smsBranchCfgList();"/>
				</li>
			</ul>
		</div>
		<div class="dataList" style="width:790px; text-align:center;overflow:auto;height:110px;background:#FFFFFF;">
			<form id="frm3" name="frm3" action ="" method="post">
			<input type='hidden' id='det_code' name='det_code'  />
			<table summary="게시판 목록. 검출코드, 지점, 조건내용, 조건값, 세부설명, 사용여부가 담김">
				<colgroup>
					<col width="70" />
					<col width="100" />
					<col width="140" />
					<col width="100" />
					<col width="300" />
					<col width="80" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">검출코드</th>
						<th scope="col">지점</th>
						<th scope="col">조건내용</th>
						<th scope="col">조건값</th>
						<th scope="col">세부설명</th>
						<th scope="col">사용여부</th>
					</tr>
				</thead>
				<tbody id="dataList3"  class="dataList">
				</tbody>
			</table>
			</form>
		</div>
		<div id="btCarea">
			<input type="button" id="btnBraConReg" name="btnBraConReg" value="저장" class="btn btn_white" onclick="javascript:smsBranchDetUpdate();" alt="저장" />
		</div>
	</div>
	
	<div id="layerGroDel" class="divPopup">
		<table style="width:230px !important;" summary="그룹코드정보">
			<colgroup>
				<col width="*" />
				<col width="30%" />
			</colgroup>
			<tr>
				<th scope="col">그룹코드</th>
				<td><input type="button" id="btnlayerGroDelListForm" name="btnlayerGroDelListForm" value="닫기" class="btn btn_basic" onclick="javascript:layerPopClose('layerGroDelListForm');" alt="닫기" /></td>
			</tr>
			<tr>
				<td>
				<select id="delGroupCode">
					<option value="">선택해주세요.</option>
					<option value="U">이동형측정기기</option>
					<option value="A">국가수질자동측정망</option>
				</select>
				</td>
				<td><input type="button" id="btnGroDel" name="btnGroDel" value="삭제" class="btn btn_basic" onclick="javascript:goGroupDel();" alt="삭제" /></td>
			</tr>
		</table>
	</div>
	<!-- 공통수신자 추가 레이어 -->
	<div id="layerComRec" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnComRecXbox" name="btnComRecXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerComRec');" alt="닫기"/>
		</div>
		<div class="searchBox" style="width:600px; background: #fff">
			<ul>
				<li>
					<span class="fieldName">소속</span>
					<select name="c_dept_code2">
						<option value="">전체</option>
						<c:forEach var="list" items="${positionList}">
						<option value="${list.DEPT_CODE}">${list.DEPT_NAME}</option>
						</c:forEach>
					</select>
				</li>
				<li>
					<span class="fieldName">공통수신대상자명</span>
					<input type="text" id="branch_mgr_name" name="branch_mgr_name" value="" style="width:100px" onkeydown="javascript:if(event.keyCode==13) getCommAllUserList()" />
					<input type="hidden" id="branch_mgr" name="branch_mgr" value="" /><!-- (두글자 이상 입력) -->
				</li>
				<li class="last">
					<input type="button" id="btnCmnSearch" name="btnCmnSearch" value="조회" class="btn btn_search" onclick="javascript:getCommAllUserList();" alt="조회" />
				</li>
			</ul>
		</div>
		<div style="background:#fff; margin-bottom:15px">
			<div id="btArea" style="padding:10px">
				<span style="text-color:#2f8bc0;">SMS공통수신대상자선택</span>
				<input type="button" id="btnCommUserReg" name="btnCommUserReg" value="추가" class="btn btn_basic" onclick="javascript:commUserReg();" alt="추가" />
			</div>
			<div class="dataList"style="width:620px;text-align:center;overflow:auto;height:180px;">
				<form name="frm1" action ="" method="post">
				<table summary="게시판 목록. 번호, 이름, 소속, 선택이 담김">
					<colgroup>
						<col width="45" />
						<col width="150" />
						<col width="290" />
						<col width="135" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">No</th>
							<th scope="col">이름</th>
							<th scope="col">소속</th>
							<th scope="col">선택</th>
						</tr>
					</thead>
					<tbody id="dataList1" class="dataList">
					</tbody>
				</table>
				</form>
			</div>
		</div>
		<div style="background:#fff;">
			<div id="btArea" style="padding:10px">
				<span style="text-color:#2f8bc0;">SMS공통수신대상자</span>
<!-- 				<input type="button" id="btnLayerSmsTargetMultipleSave" name="btnLayerSmsTargetMultipleSave" value="저장" class="btn btn_basic" onclick="javascript:goSmsTargetMultipleSave();" alt="저장" /> -->
				<input type="button" id="btnCommSmsTargeteDel" name="btnCommSmsTargeteDel" value="삭제" class="btn btn_basic" onclick="javascript:goCommSmsTargetDelete();" alt="삭제" />
			</div>
			<div  class="dataList" style="width:620px; text-align:center;overflow:auto;height:180px;">
				<form name="frm2" action ="" method="post">
				<table summary="게시판 목록. 번호, 이름, 소속, 선택이 담김">
					<colgroup>
						<col width="45" />
						<col width="110" />
						<col width="230" />
						<col width="130" />
						<col width="105" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">No</th>
							<th scope="col">이름</th>
							<th scope="col">소속</th>
							<th scope="col">전화번호</th>
							<th scope="col">선택</th>
						</tr>
					</thead>
					<tbody id="dataList2" class="dataList">
					</tbody>
				</table>
				</form>
			</div>
		</div>
	</div>
	<!-- //레이어 팝업 -->
</body>
</html>