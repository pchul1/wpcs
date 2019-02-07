<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : factoryIndustList.jsp
	 * Description : 점오염원 정보 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2014.02.19	lkh			 리뉴얼
	 * 
	 * author lkh
	 * since 2014.02.19
	 * 
	 * Copyright (C) 2014by lkh All right reserved.
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
		selectedSugyeInMemberId(user_riverid , 'sugye');
		// 목록 데이터 가져오기
		reloadData();
		
		//radio 버튼 클릭시
		$("[name=searchType]").click(function(){
			$(this).each(function(pageNo){
				reloadData(pageNo)
			});
		});
		
		//레이어 움직임 제어
		//수정 레이어
		$("#layerFacMod").draggable({
			containment: 'body',
			scroll: false
		});
		//사업장규모별 수정 레이어
		$("#layerFacSizeMod").draggable({
			containment: 'body',
			scroll: false
		});
		//오염물질별 수정 레이어
		$("#layerFacSpecMod").draggable({
			containment: 'body',
			scroll: false
		});
	});
	
	// 데이터 목록 불러오기
	function reloadData(pageNo){
		showLoading();
		
		var searchType = "";
		$("[name=searchType]").each(function(){
			// this(현재선택된 input문의) 체크박스가 checked 되어 있다면
			if ( $(this).is(":checked") ){
				searchType = $(this).val();
			}
		});
		
		//수계
		var sugye = $("#sugye option:selected").val();
		var searchKeyword = $("#searchKeyword").val();
		
		if (pageNo == null) pageNo = 0;
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/waterpolmnt/waterinfo/getFactoryIndustList.do'/>",
			data: { 
					pageIndex:pageNo,
					searchType:searchType,
					sugye:sugye,
					searchKeyword:searchKeyword
				},
			dataType:"json",
			success : function(result){
				var tot = result['resultlist'].length;
				var pageInfo = result['paginationInfo'];
				
				if( tot <= 0 ){
					$('#dataList').html("<tr><td colspan='2' class='txtC'>조회 결과가 없습니다.</td></tr>");
				}else{
					var item="";
					for(var i=0; i < tot; i++){
						var obj = result['resultlist'][i];
						
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
	                   	item += "<tr style='cursor:pointer;' onclick=\"itemNmList('"+obj.id+"'"+");itemList('"+obj.id+"'"+")\">"			                   	 
								+"<td style='text-align:center;'><span>"+obj.no+"</span></td>"
		                 		+"<td class='txtL'>"+obj.name+"</td>"
	                 		 	+"</tr>";
	
	              		$("#dataList").html(item);
	              		$("#dataList tr:odd").attr("class","even");
					}
					
				}
				
				// 총건수 표시
				$("#p_total_cnt").html("[총 " + result['totCnt'] + "건]");
				
				itemNmList(result['resultlist'][0].id);
				itemList(result['resultlist'][0].id);
				
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
				$('#dataList').html("<tr><td colspan='2' class='txtC'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></tr>");
				
				closeLoading();
			}
		}); 
	}
	
	// 페이지 번호 클릭
	function linkPage(pageNo){
		reloadData(pageNo);
	}
	
	// 좌표 지정 팝업
	function lon_lat(){
		window.open("<c:url value='/addrMap.jsp'/>",'popupMap','resizable=yes,scrollbars=yes,width=960,height=800');
	}
	
	// 좌표 및 주소 반영
	function applyLonLat(lon, lat, addr) {
		$("#longitude").val(lon);
		$("#latitude").val(lat);
		$("#address").val(addr.replace('한국 ',''));
	}
	
	function itemNmList(sId) {
		$("#id_mod").val(sId);
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/waterpolmnt/waterinfo/getFactoryIndustIdList.do'/>",
			data: {
					sId:sId
				},
			dataType:"json",
			success : function(result){
// 				console.log("결과 값 확인1 : ",result);
				
				var tot = result['resultlist'].length;
				
				if( tot <= 0 ){
					$('#dataList1').html("<tr><td colspan='3' class='txtC'>조회 결과가 없습니다.</td></tr>");
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['resultlist'][i];
						
						var item = "";
						var item1 = "";
						
						item = "<tr><th>ID</th><td class='txtL'>" + obj.id + "</td></tr>"
							+ "<tr><th>점오염원명</th><td class='txtL'>" + obj.name + "</td></tr>"
							+ "<tr><th>관련수계</th><td class='txtL'>" + obj.river_nm + "</td></tr>"
							+ "<tr><th>관련하천</th><td class='txtL'>" + obj.basin_large_nm + " " + obj.basin_middle_nm + "</td></tr>"
							+ "<tr><th>위도</th><td class='txtL'>" + obj.latitude + "</td></tr>"
							+ "<tr><th>경도</th><td class='txtL'>" + obj.longitude + "</td></tr>"
							+ "<tr><th>주소</th><td class='txtL'>" + obj.address + "</td></tr>";
						
						// 수정을 위한 레이어에 값 입력
						$("#id").val(obj.id);
						$("#name").val(obj.name);
						$("#latitude").val(obj.latitude);
						$("#longitude").val(obj.longitude);
						$("#address").val(obj.address);
						
						//지도보기 참조
						$("#rlongitude").val(obj.longitude)
						$("#rlatitude").val(obj.latitude);
						
						$("#do_code").val(obj.do_code)
						$("#cty_code").val(obj.cty_code);
						$("#dataList1").html(item);
						
						getBasinLarge(obj.basin_large);
						getBasinMiddle(obj.basin_large, obj.basin_middle);
						
						$("#river_id > option[value=" + obj.river_id + "]").attr("selected", true);
					}
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
				$('#dataList1').html("<tr><td colspan='3' class='txtC'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></tr>");
			}
		});
	}
	
	function itemList(sId) {
		
		var searchType = "";
		
		$("[name=searchType]").each(function(){
			// this(현재선택된 input문의) 체크박스가 checked 되어 있다면
			if ( $(this).is(":checked") ){
				searchType = $(this).val();
			}
		});
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/waterpolmnt/waterinfo/getFactoryIndustSizeSpecList.do'/>",
			data: {
					sId:sId,
					searchType:searchType
				},
			dataType:"json",
			success : function(result){
// 				console.log("결과 값 확인2 : ",result);
				
				var obj = result['resultlist'][0];
				
				var specTitleText = ["구리(Cu)","납(Pb)","수은(Hg)","시안(Cn)","비소(As)","유기인","6가크롬","카드뮴(Cd)","테트라크로로에틸렌(Pce)","트리크로로에틸렌(Tce)","페놀","PCB","셀레늄","벤젠","사염화탄소","디클로로메탄","1.1디틀로로에틸렌","1.2디클로로에탄","클로로폼"];
				var specText = ["cu","pb","hg","cn","as","yugi","cr6","cd","pce","tce","c6h5oh","pcb","se","c6h6","cci4","ch2cl2","dce","edc","chci3"];
				
				var item;
				var item1;
				
				if (searchType == "size") {
					item = "<tr><th rowspan='3'>계</th><td class='txtL'>업소수</td><td class='txtL'>" +obj.cnt_t + "</td></tr>"
						+ "<tr><td class='txtL'>폐수 방류량</td><td class='txtL'>" + obj.disc_amt_t + "</td></tr>"
						+ "<tr><td class='txtL'>유기물질 부하량</td><td class='txtL'>" + obj.load_amt_t + "</td></tr>";
						
					for(var ii=1; ii < 6; ii++) {
						var add = "";
						
						if (ii % 2 == 1) add = " class='add'";
						
						item += "<tr" + add + "><th rowspan='3'>" + ii + "종</th><td class='txtL'>업소수</td><td class='txtL'>" + eval("obj.cnt_" + ii) + "</td></tr>"
							+ "<tr" + add + "><td class='txtL'>폐수 방류량</td><td class='txtL'>" + eval("obj.disc_amt_" + ii) + "</td></tr>"
							+ "<tr" + add + "><td class='txtL'>유기물질 부하량</td><td class='txtL'>" + eval("obj.load_amt_" + ii) + "</td></tr>"
					}
				} else {
					item = "<tr><th rowspan='2'>계</th><td class='txtL'>업소수</td><td class='txtL'>" + obj.cnt_t + "</td></tr>"
						+ "<tr><td class='txtL'>부하량</td><td class='txtL'>" + obj.load_amt_t + "</td></tr>"
						
						for (var jj=0; jj < specText.length; jj++) {
							var add = "";
							
							if (jj % 2 == 0) add = " class='add'";
						
							item += "<tr" + add + "><th rowspan='2'>" + specTitleText[jj] + "</th><td class='txtL'>업소수</td><td class='txtL'>" + eval("obj." + specText[jj] + "_cnt") + "</td></tr>"
							+ "<tr" + add + "><td class='txtL'>부하량</td><td class='txtL'>" + eval("obj."+ specText[jj] + "_load_amt") + "</td></tr>";
						}
				}
				$('#itemDateList').html(item);
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
				$('#itemDateList').html("<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></tr>");
			}
		});
	}
	
	function itemListMod() {
		var searchType = "";
		
		$("[name=searchType]").each(function(){
			// this(현재선택된 input문의) 체크박스가 checked 되어 있다면
			if ( $(this).is(":checked") ){
				searchType = $(this).val();
			}
		});
		getFacSizeSpecList(searchType);
		
		if(searchType == "size") {
			layerPopOpen('layerFacSizeMod');
		} else {
			layerPopOpen('layerFacSpecMod');
		}
		
	}
	
	function getFacSizeSpecList(searchType) {
		var sId = $("#id_mod").val();
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/waterpolmnt/waterinfo/getFactoryIndustSizeSpecList.do'/>",
			data: {
					sId:sId,
					searchType:searchType
				},
			dataType:"json",
			success : function(result){
// 				console.log("결과 값 확인12 : ",result);
				
				var obj = result['resultlist'][0];
				
				var specText = ["cu","pb","hg","cn","as","yugi","cr6","cd","pce","tce","c6h5oh","pcb","se","c6h6","cci4","ch2cl2","dce","edc","chci3"];
				
				if (searchType == "size") {
					$("#sizeId").val(sId);
					$("#cnt_t").val(obj.cnt_t);
					$("#disc_amt_t").val(obj.disc_amt_t);
					$("#load_amt_t").val(obj.load_amt_t);
					
					$("#cnt_t").attr("disabled",true);
					$("#disc_amt_t").attr("disabled",true);
					$("#load_amt_t").attr("disabled",true);
					
					for (var ii=1; ii < 6; ii++) {
						$("#cnt_" + ii).val(eval("obj.cnt_" + ii));
						$("#disc_amt_" + ii).val(eval("obj.disc_amt_" + ii));
						$("#load_amt_" + ii).val(eval("obj.load_amt_" + ii));
					}
				} else {
					$("#specId").val(sId);
					$("#cnt_ts").val(obj.cnt_t);
					$("#load_amt_ts").val(obj.load_amt_t);
					
					$("#cnt_ts").attr("disabled",true);
					$("#load_amt_ts").attr("disabled",true);
					
					for (var jj=0; jj < specText.length; jj++) {
						$("#" + specText[jj] + "_cnt").val(eval("obj." + specText[jj] + "_cnt"));
						$("#" + specText[jj] + "_load_amt").val(eval("obj." + specText[jj] + "_load_amt"));
					}
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
				//$('#itemDateList').html("<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></tr>");
			}
		});
	}
	
	function getBasinLarge(basinLarge) {
		
		if (basinLarge == undefined || basinLarge == null) basinLarge = "all";
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/waterpolmnt/waterinfo/getBasinLargeList.do'/>",
			data: {},
			dataType:"json",
			success : function(result){
// 				console.log("결과 값 확인3 : ",result);
				
				// 유역 구분
				var dropDownSet = $('#basin_large');
				dropDownSet.loadSelectCmn(result.resultlist,'선택', 'basin_large', 'basin_large_nm');
				
				$("#basin_large > option[value="+basinLarge+"]").attr("selected", true);
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
				$('#basin_large').html("<option value='all'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</option>");
			}
		});
	}
	
	function getBasinMiddle(basinLarge, basinMiddle) {
		
		if (basinLarge == undefined || basinLarge == null) basinLarge = "all";
		if (basinMiddle == undefined || basinMiddle == null) basinMiddle = "all";
		
		$('#basin_middle').attr("disabled",false);
		$('#basin_middle').attr("style","width:188px; background-color:#ffffff;");
		
		if (basinLarge != "all") {
			$.ajax({
				type: "POST",
				url: "<c:url value='/waterpolmnt/waterinfo/getBasinMiddleList.do'/>",
				data: {
					basinLarge:basinLarge
					},
				dataType:"json",
				success : function(result){
// 					console.log("결과 값 확인4 : ",result);
					
					// 유역 구분
					var dropDownSet = $('#basin_middle');
					dropDownSet.loadSelectCmn(result.resultlist,'선택', 'basin_middle', 'basin_middle_nm');
					
					$("#basin_middle > option[value="+basinMiddle+"]").attr("selected", true);
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
					$('#basin_middle').html("<option value='all'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</option>");
				}
			});
		} else {
// 			console.log("이게뭐지? ",basinLarge);
			$('#basin_middle').html("<option value='all'>선택</option>");
			$('#basin_middle').attr("disabled",true);
			$('#basin_middle').attr("style","width:188px; background-color:#f2f2f2;");
		}
	}
	
	function popupMapOpen(){
		var longitude = $("#rlongitude").val();
		var latitude = $("#rlatitude").val();
		
		window.open("/psupport/WPCS_POP.html?riverid=" + user_riverid + "&menuid=fact&longitude=" + longitude + "&latitude=" + latitude,
				'wpcsView','width='+window.screen.width+',height='+window.screen.height+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left=0,top=0');
	}
	
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("layerFacMod");
		layerPopClose("layerFacSizeMod");
		layerPopClose("layerFacSpecMod");
	}
	
	function LayerPopEditOpen(flag) {
		
		if (flag == 'reg') {
			// 등록을 위한 레이어에 초기화
			$("#id").attr({ value: "", style: "width:380px;background-color:#ffffff;", readonly: false });
			$("#name").val("");
			$("#latitude").val("");
			$("#longitude").val("");
			$("#address").val("");
			
			//지도보기 참조
// 			$("#rlongitude").val(obj.longitude);
// 			$("#rlatitude").val(obj.latitude);
			$("#rlongitude").val();
			$("#rlatitude").val();
			
			$("#do_code").val("");
			$("#cty_code").val("");
// 			$("#btnRegist").attr({ value: "등록", onclick: "javascript:goFacReg();", alt: "등록" });
			
			$("#river_id > option[value='all']").attr("selected", "true");
			
			getBasinLarge();
			$('#basin_middle').html("<option value='all'>선택</option>");
			$('#basin_middle').attr({ disabled: true, style: "width:188px; background-color:#f2f2f2;" });
			
			$("#btnFacRegist").show();
			$("#btnFacModify").hide();
		} else {
			$("#id").attr({ style: "width:380px;background-color:#f2f2f2;", readonly: true });
// 			$("#btnRegist").attr({ value: "수정", onclick: "javascript:goFacMod();", alt: "수정" });
			
			var sId = $("#id_mod").val();
			itemNmList(sId);
			
			$("#btnFacRegist").hide();
			$("#btnFacModify").show();
		}
		layerPopOpen("layerFacMod");
	}
	
	function validateFactory() {
		
		if($("#id").val().length == 0) {
			alert('ID를 입력해 주세요.');
			return false;
		}
		
		if($("#name").val().length == 0) {
			alert('점오염원명를 입력해 주세요.');
			return false;
		}
		
		if($("#river_id option:selected").val() == 'all') {
			alert('수계을 선택해 주세요.');
			return false;
		}
		
		if($("#basin_large option:selected").val() == 'all' || $("#basin_middle option:selected").val() == 'all') {
			alert('관련하천을 선택해 주세요.');
			return false;
		}
		
		if($("#latitude").val().length == 0 || $("#longitude").val().length == 0 || $("#address").val().length == 0) {
			alert('좌표를 선택해 주세요.');
			return false;
		}
		return true;
	}
	
	// 점오염원 등록
	function goFacReg(){
		var $formFac = $("#modifyFacForm");
		
		if(validateFactory()) {
			$.ajax({
				type: "POST",
				url: "<c:url value='/waterpolmnt/waterinfo/insertFactoryIndust.do'/>",
				data: $formFac.serialize(),
				dataType:"json",
				success : function(result){
					
					if (result.duplicateCnt != undefined && result.duplicateCnt > 0) {
						alert("이미 사용중인 ID입니다.\n\n다시 시도해 주세요.");
					} else {
						
						if (!result.updateCnt) {
							alert("등록 되지 않았습니다.\n\n다시 시도해 주세요.");
						} else {
							alert("등록 되었습니다.");
							reloadData();
							layerPopCloseAll();
						}
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
					alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				}
			});
		}
	}
	
	// 사업소 수정
	function goFacMod(){
		
		if(validateFactory) {
			var sId = $("#id_mod").val();
			var formFac = $("#modifyFacForm");
			
			$.ajax({
				type: "POST",
				url: "<c:url value='/waterpolmnt/waterinfo/updatFactoryIndust.do'/>",
				data: formFac.serialize(),
				dataType:"json",
				success : function(result){
					
					if (!result.updateCnt) {
						alert("수정되지 않았습니다.\n\n다시 시도해 주세요.");
					} else {
						alert("수정 되었습니다.");
						itemNmList(sId);
						itemList(sId);
						layerPopCloseAll();
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
					alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				}
			});
		} else {
			return false;
		}
	}
	
	// 사업소 삭제
	function fnGoFacDelete(){
		
		if (confirm('삭제하시겠습니까?')) {
			var sId = $("#id_mod").val();
			
			$.ajax({
				type: "POST",
				url: "<c:url value='/waterpolmnt/waterinfo/deleteFactoryIndust.do'/>",
				data: {
					sId:sId
					},
				dataType:"json",
				success : function(result){
// 					console.log("Del Fac : ",result);
					
					if (result.updateCnt != 1) {
						alert("삭제되지 않았습니다.\n\n다시 시도해 주세요.");
					} else {
						alert("삭제 되었습니다.");
						reloadData();
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
					alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				}
			});
		}
	}
	
	// 사업소 size 수정
	function goFacSizeMod(){
		var sId = $("#id_mod").val();
		var $formSize = $("#modifySizeForm");
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/waterpolmnt/waterinfo/updateFactoryIndustSize.do'/>",
			data: $formSize.serialize(),
			dataType:"json",
			success : function(result){
// 				console.log("Mod Size 결과 값 확인 : ",result);
				
				if (!result.updateCnt) {
					alert("수정되지 않았습니다.\n\n다시 시도해 주세요.");
				} else {
					alert("수정 되었습니다.");
					itemList(sId);
					layerPopCloseAll();
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
				alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
			}
		});
	}
	
	// 사업소 spec 수정
	function goFacSpecMod(){
		var sId = $("#id_mod").val();
		var $formSpec = $("#modifySpecForm");
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/waterpolmnt/waterinfo/updateFactoryIndustSpec.do'/>",
			data: $formSpec.serialize(),
			dataType:"json",
			success : function(result){
// 				console.log("Mod Spec 결과 값 확인 : ",result);
				
				if (!result.updateCnt) {
					alert("수정되지 않았습니다.\n\n다시 시도해 주세요.");
				} else {
					alert("수정 되었습니다.");
					itemList(sId);
					layerPopCloseAll();
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
				alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
			}
		});
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
			<form id="hiddenForm">
				<input type="hidden" id="memberName" name="memberName"/>
			</form>
			
			<div id="content_wrapper">
			
				<!--left menu Start-->
				<c:import url="/common/menu/left.do" />
				<!--left menu End-->
				
				<!-- Content Start-->
				<div id="content">
				
					<!-- navi, tab menu Start-->
					<c:import url="/common/menu/navi.do" />
					<!-- navi, tab menu End-->
					
						<div class="searchBox dataSearch">
							<ul>
								<li>
									<span class="fieldName">구분</span>
									<input type="radio" name="searchType" value="size" checked="checked" />사업장규모별
									<input type="radio" name="searchType" value="spec" />오염물질별
									
								</li>
								<li>
									<span class="fieldName">수계</span>
									<select id="sugye">
										<option value="all">전체</option>
										<option value="R01">한강</option>
										<option value="R02">낙동강</option>
										<option value="R03">금강</option>
										<option value="R04">영산강</option>
									</select>
								</li>
								<li>
									<span class="fieldName">점오염원명</span>
									<input type="text" id="searchKeyword" name="searchKeyword" value="${searchVO.searchKeyword}" style="width: 195px; ime-mode:active;"/>
								</li>
							</ul>
						</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData();" alt="조회하기" style="float:right;"/>
						</div>
						
						<div class="divisionBx" id="btArea">
							<div class="div40" style="margin-bottom: 15px;">
								<div id="btSmallArea">
									<span id="p_total_cnt">[총 ${totCnt}건]</span>
								</div>
								<div  style="overflow-x: hidden; overflow-y: scroll; width: 380px; height: 758px;">
									<table>
										<colgroup>
											<col width="60" />
											<col />
										</colgroup>
										<thead>
										<tr>
											<th scope="col">NO</th>
											<th scope="col">점오염원명</th>
										</tr>
										</thead>
										<tbody  id="dataList">
										<tr>
											<td colspan="2" class='txtC'>조회 결과가 없습니다.</td>
										</tr>
										</tbody>
									</table>
								</div>
								<div style="padding-top:5px;">
									<input type="button" id="btnFactoryRegist" name="btnFactoryRegist" value="등록" class="btn btn_basic" onclick="javascript:LayerPopEditOpen('reg')" alt="등록" style="float:right; margin-right:10px;"/>
								</div>
							</div>
							
							<div class="div60">
								<div id="btSmallArea">
									<span><img src="/images/common/bu_square.gif"></img>&nbsp; 점오염원 상세정보</span>
								</div>
								<input type="hidden" id="id_mod" name="id_mod" value="" />
								<input type="hidden" id="rlongitude" name="rlongitude" value="" />
								<input type="hidden" id="rlatitude" name="rlatitude" value="" />
								<table summary="점오염원정보">
									<colgroup>
										<col width="200" />
										<col />
									</colgroup>
									<tbody id="dataList1">
										<tr><td class='txtC'>조회 결과가 없습니다.</td></tr>
									</tbody>
								</table>
								<div style="float:right; padding-top:5px;">
								<input type="button" id="btnModifyFactory" name="btnModifyFactory" value="수정" class="btn btn_basic" onclick="javascript:LayerPopEditOpen()" alt="수정" />
								<input type="button" id="btnDeleteFactory" name="btnDeleteFactory" value="삭제" class="btn btn_basic" onclick="javascript:fnGoFacDelete()" alt="삭제" />
								<input type="button" id="btnMap" name="btnMap" value="지도보기" class="btn btn_basic" onclick="javascript:popupMapOpen()" alt="지도보기" />
								</div>
								<div id="btSmallArea" style="margin-top: 10px; margin-bottom: 10px;">
									<img src="/images/common/bu_square.gif"></img>&nbsp;&nbsp;<span id="titleText">사업장규모별</span>&nbsp;(단위 : 개, ㎡/일, kg/일)
								</div>
								<div class="overBox" style="height:451px; ">
									<table summary="점오염원세부정보">
										<colgroup>
											<col width="180" />
											<col width="180" />
											<col />
										</colgroup>
										<tbody id="itemDateList">
											<tr><td colspan="3" class='txtC'>조회 결과가 없습니다.</td></tr>
										</tbody>
									</table>
								</div>
								<div style="padding-top:5px;">
									<input type="button" id="btnModify" name="btnModify" value="수정" class="btn btn_basic" onclick="javascript:itemListMod();" alt="수정" style="float:right;"/>
								</div>
							</div>
						</div>
					
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
	<!-- 점오염원 등록 레이어 -->
	<div id="layerFacMod" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnFacModXbox" name="btnFacModXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerFacMod');" alt="닫기" />
		</div>
		<form id="modifyFacForm" name="modifyFacForm" method="post">
			<input type="hidden" id="do_code" name="do_code" />
			<input type="hidden" id="cty_code" name="cty_code" />
			
			<table style="width:100%; float:left; margin-bottom:10px" summary="점오염원 정보">
				<colgroup>
					<col width="120" />
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">ID</th>
						<td class="txtL"><input type="text" id="id" name="id" style="width:380px; background-color:#f2f2f2;" readonly="readonly" /></td>
					</tr>
					<tr>
						<th scope="row">점오염원명</th>
						<td class="txtL"><input type="text" id="name" name="name" style="width:380px" /></td>
					</tr>
					<tr>
						<th scope="row">관련수계</th>
						<td class="txtL">
							<select id="river_id" name="river_id" style="width:100%">
								<option value="all">전체</option>
								<option value="R01">한강</option>
								<option value="R02">낙동강</option>
								<option value="R03">금강</option>
								<option value="R04">영산강</option>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">관련하천</th>
						<td class="txtL">
							<select id="basin_large" name="basin_large" style="width:193px;" onchange="javascript:getBasinMiddle(this.value)">
								<option value="all">선택</option>
							</select>&nbsp;
							<select id="basin_middle" name="basin_middle" style="width:192px">
								<option value="all">선택</option>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">좌표</th>
						<td class="txtL">
							<input type="text" id="latitude" name="latitude" style="width:144px; background-color:#f2f2f2;" readonly="readonly" />&nbsp;
							<input type="text" id="longitude" name="longitude" style="width:143px; background-color:#f2f2f2;" readonly="readonly" />
							<input type="button" id="btnLonlat" name="btnLonlat" value="좌표선택" class="btn btn_search" onclick="javascript:lon_lat();" alt="좌표선택"/>
						</td>
					</tr>
					<tr>
						<th scope="row">주소</th>
						<td class="txtL"><input type="text" id="address" name="address" style="width:380px; background-color:#f2f2f2;" readonly="readonly" /></td>
					</tr>
				</tbody>
			</table>
		</form>
		<div id="btCarea">
			<input type="button" id="btnFacRegist" name="btnFacRegist" value="등록" class="btn btn_white" onclick="javascript:goFacReg();" alt="등록" />
			<input type="button" id="btnFacModify" name="btnFacModify" value="수정" class="btn btn_white" onclick="javascript:goFacMod();" alt="수정" />
		</div>
	</div>
	<!-- //등록 레이어 -->
	<!-- 사멉장규모별 레이어 -->
	<div id="layerFacSizeMod" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnFacSizeModXbox" name="btnFacSizeModXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerFacSizeMod');" alt="닫기" />
		</div>
		<form id="modifySizeForm" name="modifySizeForm" method="post">
			<input type="hidden" id="sizeId" name="id" />
			
			<table style="width:100%; float:left; text-align:center; margin-bottom:10px" summary="사업장규모별 상세정보">
				<colgroup>
					<col width="100" />
					<col width="150" />
					<col width="150" />
				</colgroup>
				<tbody>
					<tr><th rowspan='3'>계</th><td>업소수</td><td><input type="text" id="cnt_t" name="cnt_t" style="width:148px" /></td></tr>
					<tr><td>폐수 방류량</td><td><input type="text" id="disc_amt_t" name="disc_amt_t" style="width:148px" /></td></tr>
					<tr><td>유기물질 부하량</td><td><input type="text" id="load_amt_t" name="load_amt_t" style="width:148px" /></td></tr>
					<tr class="add"><th rowspan='3'>1종</th><td>업소수</td><td><input type="text" id="cnt_1" name="cnt_1" style="width:148px" /></td></tr>
					<tr class="add"><td>폐수 방류량</td><td><input type="text" id="disc_amt_1" name="disc_amt_1" style="width:148px" /></td></tr>
					<tr class="add"><td>유기물질 부하량</td><td><input type="text" id="load_amt_1" name="load_amt_1" style="width:148px" /></td></tr>
					<tr><th rowspan='3'>2종</th><td>업소수</td><td><input type="text" id="cnt_2" name="cnt_2" style="width:148px" /></td></tr>
					<tr><td>폐수 방류량</td><td><input type="text" id="disc_amt_2" name="disc_amt_2" style="width:148px" /></td></tr>
					<tr><td>유기물질 부하량</td><td><input type="text" id="load_amt_2" name="load_amt_2" style="width:148px" /></td></tr>
					<tr class="add"><th rowspan='3'>3종</th><td>업소수</td><td><input type="text" id="cnt_3" name="cnt_3" style="width:148px" /></td></tr>
					<tr class="add"><td>폐수 방류량</td><td><input type="text" id="disc_amt_3" name="disc_amt_3" style="width:148px" /></td></tr>
					<tr class="add"><td>유기물질 부하량</td><td><input type="text" id="load_amt_3" name="load_amt_3" style="width:148px" /></td></tr>
					<tr><th rowspan='3'>4종</th><td>업소수</td><td><input type="text" id="cnt_4" name="cnt_4" style="width:148px" /></td></tr>
					<tr><td>폐수 방류량</td><td><input type="text" id="disc_amt_4" name="disc_amt_4" style="width:148px" /></td></tr>
					<tr><td>유기물질 부하량</td><td><input type="text" id="load_amt_4" name="load_amt_4" style="width:148px" /></td></tr>
					<tr class="add"><th rowspan='3'>5종</th><td>업소수</td><td><input type="text" id="cnt_5" name="cnt_5" style="width:148px" /></td></tr>
					<tr class="add"><td>폐수 방류량</td><td><input type="text" id="disc_amt_5" name="disc_amt_5" style="width:148px" /></td></tr>
					<tr class="add"><td>유기물질 부하량</td><td><input type="text" id="load_amt_5" name="load_amt_5" style="width:148px" /></td></tr>
				</tbody>
			</table>
		</form>
		<div id="btCarea">
			<input type="button" id="btnSizeMod" name="btnSizeMod" value="수정" class="btn btn_white" onclick="javascript:goFacSizeMod();" alt="수정" />
		</div>
	</div>
	<!-- //사업장규모별 레이어 -->
	<!-- 오염물질별 레이어 -->
	<div id="layerFacSpecMod" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnFacSpecModXbox" name="btnFacSpecModXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerFacSpecMod');" alt="닫기" />
		</div>
		<form id="modifySpecForm" name="modifySpecForm" method="post">
			<input type="hidden" id="specId" name="id"></input>
			
			<div class="overBox" style="height:486px;">
				<table class="dataTable" style="width:100%; text-align:center; float:left;">
					<colgroup>
						<col width="150" />
						<col width="150" />
						<col width="150" />
					</colgroup>
					<tbody>
						<tr><th rowspan='2'>계</th><td>업소수</td><td><input type="text" id="cnt_ts" name="cnt_ts" style="width:148px" /></td></tr>
						<tr><td>부하량</td><td><input type="text" id="load_amt_ts" name="load_amt_ts" style="width:148px" /></td></tr>
						<tr class="add"><th rowspan='2'>구리(Cu)</th><td>업소수</td><td><input type="text" id="cu_cnt" name="cu_cnt" style="width:148px" /></td></tr>
						<tr class="add"><td>부하량</td><td><input type="text" id="cu_load_amt" name="cu_load_amt" style="width:148px" /></td></tr>
						<tr><th rowspan='2'>납(Pb)</th><td>업소수</td><td><input type="text" id="pb_cnt" name="pb_cnt" style="width:148px" /></td></tr>
						<tr><td>부하량</td><td><input type="text" id="pb_load_amt" name="pb_load_amt" style="width:148px" /></td></tr>
						<tr class="add"><th rowspan='2'>수은(Hg)</th><td>업소수</td><td><input type="text" id="hg_cnt" name="hg_cnt" style="width:148px" /></td></tr>
						<tr class="add"><td>부하량</td><td><input type="text" id="hg_load_amt" name="hg_load_amt" style="width:148px" /></td></tr>
						<tr><th rowspan='2'>시안(Cn)</th><td>업소수</td><td><input type="text" id="cn_cnt" name="cn_cnt" style="width:148px" /></td></tr>
						<tr><td>부하량</td><td><input type="text" id="cn_load_amt" name="cn_load_amt" style="width:148px" /></td></tr>
						<tr class="add"><th rowspan='2'>비소(As)</th><td>업소수</td><td><input type="text" id="as_cnt" name="as_cnt" style="width:148px" /></td></tr>
						<tr class="add"><td>부하량</td><td><input type="text" id="as_load_amt" name="as_load_amt" style="width:148px" /></td></tr>
						<tr><th rowspan='2'>유기인</th><td>업소수</td><td><input type="text" id="yugi_cnt" name="yugi_cnt" style="width:148px" /></td></tr>
						<tr><td>부하량</td><td><input type="text" id="yugi_load_amt" name="yugi_load_amt" style="width:148px" /></td></tr>
						<tr class="add"><th rowspan='2'>6가크롬</th><td>업소수</td><td><input type="text" id="cr6_cnt" name="cr6_cnt" style="width:148px" /></td></tr>
						<tr class="add"><td>부하량</td><td><input type="text" id="cr6_load_amt" name="cr6_load_amt" style="width:148px" /></td></tr>
						<tr><th rowspan='2'>카드뮴(Cd)</th><td>업소수</td><td><input type="text" id="cd_cnt" name="cd_cnt" style="width:148px" /></td></tr>
						<tr><td>부하량</td><td><input type="text" id="cd_load_amt" name="cd_load_amt" style="width:148px" /></td></tr>
						<tr class="add"><th rowspan='2'>테트라크로로<br/>에틸렌(Pce)</th><td>업소수</td><td><input type="text" id="pce_cnt" name="pce_cnt" style="width:148px" /></td></tr>
						<tr class="add"><td>부하량</td><td><input type="text" id="pce_load_amt" name="pce_load_amt" style="width:148px" /></td></tr>
						<tr><th rowspan='2'>트리크로로<br/>에틸렌(Tce)</th><td>업소수</td><td><input type="text" id="tce_cnt" name="tce_cnt" style="width:148px" /></td></tr>
						<tr><td>부하량</td><td><input type="text" id="tce_load_amt" name="tce_load_amt" style="width:148px" /></td></tr>
						<tr class="add"><th rowspan='2'>페놀</th><td>업소수</td><td><input type="text" id="c6h5oh_cnt" name="c6h5oh_cnt" style="width:148px" /></td></tr>
						<tr class="add"><td>부하량</td><td><input type="text" id="c6h5oh_load_amt" name="c6h5oh_load_amt" style="width:148px" /></td></tr>
						<tr><th rowspan='2'>PCB</th><td>업소수</td><td><input type="text" id="pcb_cnt" name="pcb_cnt" style="width:148px" /></td></tr>
						<tr><td>부하량</td><td><input type="text" id="pcb_load_amt" name="pcb_load_amt" style="width:148px" /></td></tr>
						<tr class="add"><th rowspan='2'>셀레늄</th><td>업소수</td><td><input type="text" id="se_cnt" name="se_cnt" style="width:148px" /></td></tr>
						<tr class="add"><td>부하량</td><td><input type="text" id="se_load_amt" name="se_load_amt" style="width:148px" /></td></tr>
						<tr><th rowspan='2'>벤젠</th><td>업소수</td><td><input type="text" id="c6h6_cnt" name="c6h6_cnt" style="width:148px" /></td></tr>
						<tr><td>부하량</td><td><input type="text" id="c6h6_load_amt" name="c6h6_load_amt" style="width:148px" /></td></tr>
						<tr class="add"><th rowspan='2'>사염화탄소</th><td>업소수</td><td><input type="text" id="cci4_cnt" name="cci4_cnt" style="width:148px" /></td></tr>
						<tr class="add"><td>부하량</td><td><input type="text" id="cci4_load_amt" name="cci4_load_amt" style="width:148px" /></td></tr>
						<tr><th rowspan='2'>디클로로<br/>메탄</th><td>업소수</td><td><input type="text" id="ch2cl2_cnt" name="ch2cl2_cnt" style="width:148px" /></td></tr>
						<tr><td>부하량</td><td><input type="text" id="ch2cl2_load_amt" name="ch2cl2_load_amt" style="width:148px" /></td></tr>
						<tr class="add"><th rowspan='2'>1.1디틀로로<br/>에틸렌</th><td>업소수</td><td><input type="text" id="dce_cnt" name="dce_cnt" style="width:148px" /></td></tr>
						<tr class="add"><td>부하량</td><td><input type="text" id="dce_load_amt" name="dce_load_amt" style="width:148px" /></td></tr>
						<tr><th rowspan='2'>1.2디클로로<br/>에탄</th><td>업소수</td><td><input type="text" id="edc_cnt" name="edc_cnt" style="width:148px" /></td></tr>
						<tr><td>부하량</td><td><input type="text" id="edc_load_amt" name="edc_load_amt" style="width:148px" /></td></tr>
						<tr class="add"><th rowspan='2'>클로로폼</th><td>업소수</td><td><input type="text" id="chci3_cnt" name="chci3_cnt" style="width:148px" /></td></tr>
						<tr class="add"><td>부하량</td><td><input type="text" id="chci3_load_amt" name="chci3_load_amt" style="width:148px" /></td></tr>
					</tbody>
				</table>
			</div>
		</form>
		<div id="btCarea">
			<input type="button" id="btnSpecMod" name="btnSpecMod" value="수정" class="btn btn_white" onclick="javascript:goFacSpecMod();" alt="수정" />
		</div>
	</div>
	<!-- //오염물질별 레이어 -->
</body>
</html>