<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : factdetail.jsp
	 * Description : 측정소별 감시 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2010.05.17	khany		최초 생성
	 * 2013.11.06	lkh			리뉴얼
	 * 2014.10.27  mypark    페이징 처리 및 검색 개선
	 * 2014.11.13  mypark    그리드 걷어내고 테이블 처리
	 * 
	 * author khany
	 * since 2010.05.17
	 * 
	 * Copyright (C) 2010 by khany  All right reserved.  
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
		if(user_u_cnt == 0 && user_a_cnt == 0){
// 			alert('권한이 없습니다. 측정소를 등록해주세요.');
// 			window.location = "<c:url value='/main.do'/>";
		}
	}
	
//<![CDATA[
	var fact_name;
	var fact_code;
	var branch_no=1;
	var branch_name;
	var sys_kind;
	var itemCnt;
	var itemArray;
	var itemCode;
	var isFirst = true;

	$(function(){
//		$("#slickNullSearch").hide();

		//기간 세팅

		setDate();

		//user 측정소권한에 따른 수계 고정
		if(user_roleCode == 'ROLE_ADMIN'){
			selectedSugyeInMemberId(user_riverid, 'sugye');
			
			adjustGongku();
		}else{
			$("#sys option").remove();
			if(user_u_cnt != 0 ){
				$("#sys").append("<option value='U'>이동형측정기기</option>");
			}
			if(user_a_cnt != 0 ){
				$("#sys").append("<option value='A'>국가수질자동측정망</option>");
			}
			selectedSugyeInMemberIdNew(id, $('#sys').val(), 'sugye');
		}

// 		adjustGongku();

		//시스템

		$('#sys').change(function(){
			if(user_roleCode == 'ROLE_ADMIN'){
				selectedSugyeInMemberId(user_riverid, 'sugye');
				
				adjustGongku();
			}else{
				selectedSugyeInMemberIdNew(id, $('#sys').val(), 'sugye');
			}
		});

		

		//수계

		$('#sugye').change(function(){

			adjustGongku();

		});

		

		//측정소

		$('#factCode').change(function(){

			adjustBranchList();

		});



		$("#branch_no").change(function() {

			branch_no = this.value;

			//chart();

			//refresh_all();

		});

		/* $("#nearAll").change(function() {
			sys_kind = $("#sys").val();
			if(sys_kind == "U" ) {
				if(this.value == "all") {
					$("#branchNo").attr("disabled", true);
				} else {
					$("#branchNo").attr("disabled", false);		
				}
			}
		}); */

		

/* 		$("#graphItem").change(function() {

			showLoading();

			//chart();

		}); */

	});

	

	function setDate() {

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

		

		var todayObj = new Date(); 

		var yday = new Date(Date.parse(todayObj) - 2 * 1000 * 60 * 60 * 12);

		yday = yday.getFullYear()+ "/" + addzero(yday.getMonth()+1) + "/" + addzero(yday.getDate());

		var today = todayObj.getFullYear()+"/"+ addzero(todayObj.getMonth()+1) +"/"+ addzero(todayObj.getDate());

		

		function addzero(n) {

			return n < 10 ? "0" + n : n + "";

		}

		

		var time = todayObj.getHours();

		var timeStr = addzero(time);

		

		if(time <= 0) timeStr = "00";

		

		$("#frTime > option[value=" + timeStr + "]").attr("selected", "selected");

		$("#toTime > option[value=" + timeStr + "]").attr("selected", "selected");

		

		$("#startDate").val(yday);

		$("#endDate").val(today);

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

			if(sys_kind != "U")

				$("#factCode").attr("disabled", false);

		}

		

		if(sys_kind == "U") {

			$("#spanBranch").show();
			$("#spanNear").show();

			$("#branch_no").hide();

			//2014-10-27 mypark 검색 개선

			$("#spanFact").hide();

			$("#factCode").hide();

		} else {

			$("#spanBranch").hide();
			$("#spanNear").hide();

			$("#branch_no").show();

			//2014-10-27 mypark 검색 개선

			$("#spanFact").show();

		}

	}

	

	var firstFlag = false;

	function adjustGongku() {
		var sugyeCd = $('#sugye').val();
		var sys_kind = $("#sys").val();
		var dropDownSet = $('#factCode');
		var dropDownSet_branchNo = $('#branchNo');
		if( sugyeCd == 'all' || sys_kind == 'all' ){
			dropDownSet.attr("disabled", true);
			$("#factCode>option:first").attr("selected", "true");
			dropDownSet_branchNo.attr("disabled", true);
			$("#branchNo>option:first").attr("selected", "true");

			//dropDownSet.emptySelect();
		}else{
			dropDownSet.attr("disabled", false);
			dropDownSet.attr("style", "background:#ffffff;");
			$.getJSON("<c:url value='/waterpolmnt/waterinfo/getGongkuListNew.do'/>",
					{sugye:sugyeCd, system:sys_kind}, function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect(data.gongku);
					if (sys_kind == "U"){
						dropDownSet.attr("disabled", true);
						dropDownSet.attr("style", "background:#e9e9e9;");
					}
					sysChange();
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
					//console.log("결과:",data);
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect(data.branch);
					if(!firstFlag){
						reloadData('1');
						firstFlag = true;
					}
				} else {
					alert("공구 목록 가져오기 실패");
					return;
				}
			});
		}
	}

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
					//console.log("결과:",data);
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect(data.branch);
					if(!firstFlag){
						reloadData('1');
						firstFlag = true;
					}
				} else {
					alert("공구 목록 가져오기 실패");
					return;
				}
			});
		}
	}

	function getItemDropDown(sk){

		var sys = sk;

		var itemCode = "";

		

		if(sys == 'U' || sys == 'all'){

			itemCode = "22";

		}else if(sys == 'T'){

			itemCode = "23";

		}else if(sys == 'A'){

			itemCode = "37";

		}

		

		var dropDownSet = $('#graphItem');

		dropDownSet.attr("disabled", false);

		

		$.getJSON("<c:url value='/cmmn/getCode.do'/>", {code_id:itemCode}, function (data, status){

			if(status == 'success'){

				//item 객체에 SELECT 옵션내용 추가.

				dropDownSet.loadSelectDepth_factdetail(data.codes, sys);

			} else {

				//alert("ERROR!");

				return;

			}

		});

	}

	

	function reloadData(pageNo){

		if( validation() == false ) return;

		

		fact_code = $("#factCode").val();

		sys_kind = $("#sys").val();

		fact_name = "";

		getItemDropDown(sys_kind);

		getBranchList(fact_code, pageNo);

		refresh_all(pageNo);

	}

	

	function getBranchList(fc, pageNo){

		$.ajax({

			type:"post",

			url:"<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>",

			data:{factCode:fc},

			dataType:"json",

			success:function(result) {

				$("#branch_no").loadSelect(result['branch']);

				

				//브랜치 로드 까지 완료되어야 데이터를 불러올 수 있음

				refresh_all(pageNo);

				//chart();

			},

			error:function(result){

				alert("브런치 목록 가져오기 실패");

				return;

			}

		});

	}

	

	function refresh_all(pageNo){

		showLoading();

		

		$("#pagination").hide();

		$("#p_total_cnt").html("[총 0건]");

		if (pageNo == null) pageNo = 1;

		var frDate = $("#startDate").val2();

		var toDate = $("#endDate").val2();

		var frTime = $("#frTime").val();

		var toTime = $("#toTime").val();

		var branch_no = $("#branch_no").val();

		var near_all = $("#nearAll").val();

		var beforeBranchNo =  "1";

		var nextBranchNo = "1";		

		var sys_kind = $("#sys").val();

		

		if(branch_no == null || branch_no == "") branch_no = "1";		

		if(beforeBranchNo == null || beforeBranchNo == "") beforeBranchNo = "1";

		if(nextBranchNo == null || nextBranchNo == "")  nextBranchNo = "1";

		

		//IP-USN같은 경우에는 검색조건에 설정된 측정소 번호로 조회함

		if(sys_kind == "U") branch_no = $("#branchNo").val();

		var numberFormatter = function (row, cell, value, columnDef, dataContext) {

			var vId = columnDef.field + "_or";

			var vVal= dataContext[vId];

			if (vVal != 0 && vVal != null && vVal != "" && value != "-")  return '<font color="red">' + value + '</font>';

			else  return '<font>' + value + '</font>';

		}

		//헤더 세팅

		setHeader(sys_kind);

		

		$.ajax({

			type:"post",

			url:"<c:url value='/waterpolmnt/situationctl/getWatersysMntMainDetail_all.do'/>",

			data:{

				fact_code:fact_code,

				branch_no:branch_no,
				
				near_all:near_all,

				frDate:frDate,

				frTime:frTime,

				toDate:toDate,

				toTime:toTime,

				beforeBranchNo:beforeBranchNo,

				nextBranchNo:nextBranchNo,

				sys_kind:sys_kind,

				pageIndex:pageNo

			},

			dataType:"json",

			success:dataload_success,

			error:function(result){

				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21

				var oraErrorCode = "";

				if (result.responseText != null ) {

					var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);

					if (matchedValue != null && matchedValue.length > 0) {

						oraErrorCode = matchedValue[0].replace('ORA-', '');

					}

				}

				if(sys_kind == "A") {

					dataHtml="<tr><td colspan='44' style='text-align:left;padding-left:350px;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></tr>";

				} else {

					dataHtml="<tr><td colspan='9'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></tr>";

				}

				$("#dataList").html("");

				$('#dataList').append(dataHtml);

				closeLoading();

			}

		});

	}

	

	function setHeader(sys_kind) {

		var colHtml = "";

		var colWidthHtml = "";

		if(sys_kind == "A") {

			//국가수질자동측정망인 경우

			//구분

			colWidthHtml += "<col width='45' />";

			//기본정보

			colWidthHtml += "<col width='100' />";

			colWidthHtml += "<col width='100' />";

			//일반항목

			colWidthHtml += "<col width='80' />";

			colWidthHtml += "<col width='80' />";

			colWidthHtml += "<col width='80' />";

			colWidthHtml += "<col width='80' />";

			colWidthHtml += "<col width='80' />";

			//유기물질

			colWidthHtml += "<col width='80' />";

			//생물독성(물고기)

			colWidthHtml += "<col width='100' />";

			colWidthHtml += "<col width='80' />";

			//생물독성(물벼룩1)

			colWidthHtml += "<col width='80' />";

			colWidthHtml += "<col width='80' />";

			//생물독성(물벼룩2)

			colWidthHtml += "<col width='80' />";

			//생물독성(미생물)

			colWidthHtml += "<col width='110' />";

			//생물독성(조류)	

			colWidthHtml += "<col width='90' />";

			//휘발성유기화합물

			colWidthHtml += "<col width='80' />";

			colWidthHtml += "<col width='80' />";

			colWidthHtml += "<col width='80' />";

			colWidthHtml += "<col width='80' />";

			colWidthHtml += "<col width='80' />";

			colWidthHtml += "<col width='80' />";

			colWidthHtml += "<col width='80' />";

			colWidthHtml += "<col width='80' />";

			colWidthHtml += "<col width='80' />";

			colWidthHtml += "<col width='80' />";

			colWidthHtml += "<col width='80' />";

			colWidthHtml += "<col width='100' />";

			colWidthHtml += "<col width='80' />";

			colWidthHtml += "<col width='80' />";

			colWidthHtml += "<col width='80' />";

			//영양염류

			colWidthHtml += "<col width='80' />";

			colWidthHtml += "<col width='80' />";

			colWidthHtml += "<col width='90' />";

			colWidthHtml += "<col width='80' />";

			colWidthHtml += "<col width='80' />";

			//클로로필-a

			colWidthHtml += "<col width='80' />";

			//중금속

			colWidthHtml += "<col width='80' />";

			colWidthHtml += "<col width='80' />";

			colWidthHtml += "<col width='80' />";

			colWidthHtml += "<col width='80' />";

			//페놀

			colWidthHtml += "<col width='80' />";

			colWidthHtml += "<col width='80' />";

			//강수량계

			colWidthHtml += "<col width='100' />";

			colHtml += "<tr>";

			colHtml += "<th  scope='col'>구분</th>";

			colHtml += "<th  scope='col' colspan='2'>기본정보</th>";

			colHtml += "<th  scope='col' colspan='5'>일반항목</th>";

			colHtml += "<th  scope='col'>유기물질</th>";

			colHtml += "<th  scope='col'>생물독성(물고기)</th>";

			colHtml += "<th  scope='col' colspan='2'>생물독성(물벼룩1)</th>";

			colHtml += "<th  scope='col' colspan='2'>생물독성(물벼룩2)</th>";

			colHtml += "<th  scope='col'>생물독성(미생물)</th>";

			colHtml += "<th  scope='col'>생물독성(조류)</th>";

			colHtml += "<th  scope='col' colspan='15'>휘발성유기화합물</th>";

			colHtml += "<th  scope='col' colspan='5'>영양염류</th>";

			colHtml += "<th  scope='col'>클로로필-a</th>";

			colHtml += "<th  scope='col' colspan='4'>중금속</th>";

			colHtml += "<th  scope='col' colspan='2'>페놀</th>";

			colHtml += "<th  scope='col'>강수량계</th>";

			colHtml += "</tr>";

			colHtml += "<tr>";

			colHtml += "<th  scope='col'>NO</th>";

			colHtml += "<th  scope='col'>시간</th>";

			colHtml += "<th  scope='col'>측정소</th>";

			colHtml += "<th  scope='col'>탁도(NTU)</th>";

			colHtml += "<th  scope='col'>pH</th>";

			colHtml += "<th  scope='col'>DO(mg/L)</th>";

			//colHtml += "<th  scope='col'>EC(mS/cm)</th>";
			colHtml += "<th  scope='col'>EC(μS/cm)</th>";

			colHtml += "<th  scope='col'>수온(℃)</th>";

			colHtml += "<th  scope='col'>총유기탄소</th>";

			colHtml += "<th  scope='col'>임펄스</th>";

			colHtml += "<th  scope='col'>임펄스(좌)</th>";

			colHtml += "<th  scope='col'>임펄스(우)</th>";

			colHtml += "<th  scope='col'>독성지수(좌)</th>";

			colHtml += "<th  scope='col'>독성지수(우)</th>";

			colHtml += "<th  scope='col'>미생물독성지수(%)</th>";

			colHtml += "<th  scope='col'>조류독성지수</th>";

			colHtml += "<th  scope='col'>염화메틸렌</th>";

			colHtml += "<th  scope='col'>1.1.1-트리클로로에테인</th>";

			colHtml += "<th  scope='col'>벤젠</th>";

			colHtml += "<th  scope='col'>사염화탄소</th>";

			colHtml += "<th  scope='col'>트리클로로에틸렌</th>";

			colHtml += "<th  scope='col'>톨루엔</th>";

			colHtml += "<th  scope='col'>테트라클로로에티렌</th>";

			colHtml += "<th  scope='col'>에틸벤젠</th>";

			colHtml += "<th  scope='col'>m,p-자일렌</th>";

			colHtml += "<th  scope='col'>o-자일렌</th>";

			colHtml += "<th  scope='col'>[ECD]염화메틸렌</th>";

			colHtml += "<th  scope='col'>[ECD]1.1.1-트리클로로에테인</th>";

			colHtml += "<th  scope='col'>[ECD]사염화탄소</th>";

			colHtml += "<th  scope='col'>[ECD]트리클로로에틸렌</th>";

			colHtml += "<th  scope='col'>[ECD]테트라클로로에티렌</th>";

			colHtml += "<th  scope='col'>총질소</th>";

			colHtml += "<th  scope='col'>총인</th>";

			colHtml += "<th  scope='col'>암모니아성질소</th>";

			colHtml += "<th  scope='col'>질산성질소</th>";

			colHtml += "<th  scope='col'>인산염인</th>";

			colHtml += "<th  scope='col'>클로로필-a</th>";

			colHtml += "<th  scope='col'>카드뮴</th>";

			colHtml += "<th  scope='col'>납</th>";

			colHtml += "<th  scope='col'>구리</th>";

			colHtml += "<th  scope='col'>아연</th>";

			colHtml += "<th  scope='col'>페놀1</th>";

			colHtml += "<th  scope='col'>페놀2</th>";

			colHtml += "<th  scope='col'>강수량</th>";

			colHtml += "</tr>";

		} else {

			//IP-USN인 경우

			colWidthHtml += "<col width='45' />";

			colWidthHtml += "<col width='120' />";

			colWidthHtml += "<col width='120' />";

			colWidthHtml += "<col width='120' />";

			colWidthHtml += "<col width='120' />";

			colWidthHtml += "<col width='120' />";

			colWidthHtml += "<col width='120' />";

			colWidthHtml += "<col width='110' />";

			colWidthHtml += "<col width='110' />";

			colHtml += "<tr>";

			colHtml += "<th  scope='col'>구분</th>";

			colHtml += "<th  scope='col' colspan='2'>기본정보</th>";

			colHtml += "<th  scope='col' colspan='6'>수질항목</th>";

			colHtml += "</tr>";

			colHtml += "<tr>";

			colHtml += "<th  scope='col'>NO</th>";

			colHtml += "<th  scope='col'>시간</th>";

			colHtml += "<th  scope='col'>측정소</th>";

			colHtml += "<th  scope='col'>탁도(NTU)</th>";

			colHtml += "<th  scope='col'>수온(℃)</th>";

			colHtml += "<th  scope='col'>pH</th>";

			colHtml += "<th  scope='col'>DO(mg/L)</th>";

			colHtml += "<th  scope='col'>EC(mS/cm)</th>";

			colHtml += "<th  scope='col'>Chl-a((μg/L))</th>";

			colHtml += "</tr>";

		}

		

		$("#colWidth").html("");

		$('#colWidth').append(colWidthHtml);

		$("#headerList").html("");

		$('#headerList').append(colHtml);

		

		

		if(sys_kind == "A") {

			$("#table_over").addClass("table_over");

			$("#data_table").addClass("table_overWidth");

		}else {

			$("#table_over").removeClass("table_over");

			$("#data_table").removeClass("table_overWidth");

		}

	}



	function dataload_success(result) {

		//console.log("getWatersysMntMainDetail : ",result);

		

		var tot = 0;

		if(result['refreshData'] != null){

			tot = result['refreshData'].length;

		}

		

		//2014-10-21 mypark 페이징 추가

		var pageInfo = result['PaginationInfo'];

		var dataHtml="";

		if( tot <= 0 ){

			if(sys_kind == "A") {

				dataHtml="<tr><td colspan='44' style='text-align:left;padding-left:350px;'>조회 결과가 없습니다.</td></tr>";

			} else {

				dataHtml="<tr><td colspan='9'>조회 결과가 없습니다.</td></tr>";

			}

		} else {

			for(var i=0; i < tot; i++){

				var obj = result['refreshData'][i];

				var no = 0;

				no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;				

				obj.no = no;				

				obj.datetime = obj.min_time.substring(5,16);

				dataHtml += "<tr>";

				dataHtml += "<td>" + obj.no +"</td>";

				dataHtml += "<td>" + obj.datetime +"</td>";

				dataHtml += "<td>" + obj.branch_name +"</td>";

				

				if(sys_kind != "A") {

					obj.tur = (obj.tur != null && obj.tur != '') ? obj.tur : '-';

					obj.tmp = (obj.tmp != null && obj.tmp != '') ? obj.tmp : '-';

					obj.phy = (obj.phy != null && obj.phy != '') ? obj.phy : '-';

					obj.dow = (obj.dow != null && obj.dow != '') ? obj.dow : '-';

					obj.con = (obj.con != null && obj.con != '') ? obj.con : '-';

					obj.tof = (obj.tof != null && obj.tof != '') ? obj.tof : '-';

					

					dataHtml += "<td>" + obj.tur +"</td>";

					dataHtml += "<td>" + obj.tmp +"</td>";

					dataHtml += "<td>" + obj.phy +"</td>";

					dataHtml += "<td>" + obj.dow +"</td>";

					dataHtml += "<td>" + obj.con +"</td>";

					dataHtml += "<td>" + obj.tof +"</td>";

					

				} else {

					obj.tur = (obj.tur != null && obj.tur != '') ? obj.tur : '-';

					obj.phy = (obj.phy != null && obj.phy != '') ? obj.phy : '-';

					obj.dow = (obj.dow != null && obj.dow != '') ? obj.dow : '-';

					obj.con = (obj.con != null && obj.con != '') ? obj.con : '-';

					obj.tmp = (obj.tmp != null && obj.tmp != '') ? obj.tmp : '-';

					obj.toc = (obj.toc != null && obj.toc != '') ? obj.toc : '-';

					

					obj.imp = (obj.imp != null && obj.imp != '') ? obj.imp : '-';

					obj.lim = (obj.lim != null && obj.lim != '') ? obj.lim : '-';

					obj.rim = (obj.rim != null && obj.rim != '') ? obj.rim : '-';

					

					obj.ltx = (obj.ltx != null && obj.ltx != '') ? obj.ltx : '-';

					obj.rtx = (obj.rtx != null && obj.rtx != '') ? obj.rtx : '-';

					

					obj.tox = (obj.tox != null && obj.tox != '') ? obj.tox : '-';

					obj.evn = (obj.evn != null && obj.evn != '') ? obj.evn : '-';

					

					obj.voc1 = (obj.voc1 != null && obj.voc1 != '') ? obj.voc1 : '-';

					obj.voc2 = (obj.voc2 != null && obj.voc2 != '') ? obj.voc2 : '-';

					obj.voc3 = (obj.voc3 != null && obj.voc3 != '') ? obj.voc3 : '-';

					obj.voc4 = (obj.voc4 != null && obj.voc4 != '') ? obj.voc4 : '-';

					obj.voc5 = (obj.voc5 != null && obj.voc5 != '') ? obj.voc5 : '-';

					obj.voc6 = (obj.voc6 != null && obj.voc6 != '') ? obj.voc6 : '-';

					obj.voc7 = (obj.voc7 != null && obj.voc7 != '') ? obj.voc7 : '-';

					obj.voc8 = (obj.voc8 != null && obj.voc8 != '') ? obj.voc8 : '-';

					obj.voc9 = (obj.voc9 != null && obj.voc9 != '') ? obj.voc9 : '-';

					obj.voc10 = (obj.voc10 != null && obj.voc10 != '') ? obj.voc10 : '-';

					obj.voc11 = (obj.voc11 != null && obj.voc11 != '') ? obj.voc11 : '-';

					obj.voc12 = (obj.voc12 != null && obj.voc12 != '') ? obj.voc12 : '-';

					obj.voc13 = (obj.voc13 != null && obj.voc13 != '') ? obj.voc13 : '-';

					obj.voc14 = (obj.voc14 != null && obj.voc14 != '') ? obj.voc14 : '-';

					obj.voc15 = (obj.voc15 != null && obj.voc15 != '') ? obj.voc15 : '-';

					

					obj.tof = (obj.tof != null && obj.tof != '') ? obj.tof : '-';

					obj.ton = (obj.ton != null && obj.ton != '') ? obj.ton : '-';

					obj.top = (obj.top != null && obj.top != '') ? obj.top : '-';

					obj.nh4 = (obj.nh4 != null && obj.nh4 != '') ? obj.nh4 : '-';

					

					obj.no3 = (obj.no3 != null && obj.no3 != '') ? obj.no3 : '-';

					obj.po4 = (obj.po4 != null && obj.po4 != '') ? obj.po4 : '-';

					

					obj.cad = (obj.cad != null && obj.cad != '') ? obj.cad : '-';

					obj.plu = (obj.plu != null && obj.plu != '') ? obj.plu : '-';

					

					obj.cop = (obj.cop != null && obj.cop != '') ? obj.cop : '-';

					obj.zin = (obj.zin != null && obj.zin != '') ? obj.zin : '-';

					obj.phe = (obj.phe != null && obj.phe != '') ? obj.phe : '-';

					obj.phl = (obj.phl != null && obj.phl != '') ? obj.phl : '-';

					

					obj.rin = (obj.rin != null && obj.rin != '') ? obj.rin : '-';

					

					dataHtml += "<td>" + obj.tur +"</td>";

					dataHtml += "<td>" + obj.phy +"</td>";

					dataHtml += "<td>" + obj.dow +"</td>";

					dataHtml += "<td>" + obj.con +"</td>";

					dataHtml += "<td>" + obj.tmp +"</td>";

					dataHtml += "<td>" + obj.toc +"</td>";

					

					dataHtml += "<td>" + obj.imp +"</td>";

					dataHtml += "<td>" + obj.lim +"</td>";

					dataHtml += "<td>" + obj.rim +"</td>";

					

					dataHtml += "<td>" + obj.ltx +"</td>";

					dataHtml += "<td>" + obj.rtx +"</td>";

					

					dataHtml += "<td>" + obj.tox +"</td>";

					dataHtml += "<td>" + obj.evn +"</td>";

					

					dataHtml += "<td>" + obj.voc1 +"</td>";

					dataHtml += "<td>" + obj.voc2 +"</td>";

					dataHtml += "<td>" + obj.voc3 +"</td>";

					dataHtml += "<td>" + obj.voc4 +"</td>";

					dataHtml += "<td>" + obj.voc5 +"</td>";

					dataHtml += "<td>" + obj.voc6 +"</td>";

					dataHtml += "<td>" + obj.voc7 +"</td>";

					dataHtml += "<td>" + obj.voc8 +"</td>";

					dataHtml += "<td>" + obj.voc9 +"</td>";

					dataHtml += "<td>" + obj.voc10 +"</td>";

					dataHtml += "<td>" + obj.voc11 +"</td>";

					dataHtml += "<td>" + obj.voc12 +"</td>";

					dataHtml += "<td>" + obj.voc13 +"</td>";

					dataHtml += "<td>" + obj.voc14 +"</td>";

					dataHtml += "<td>" + obj.voc15 +"</td>";

					

					dataHtml += "<td>" + obj.tof +"</td>";

					dataHtml += "<td>" + obj.ton +"</td>";

					dataHtml += "<td>" + obj.top +"</td>";

					dataHtml += "<td>" + obj.nh4 +"</td>";

					

					dataHtml += "<td>" + obj.no3 +"</td>";

					dataHtml += "<td>" + obj.po4 +"</td>";

					

					dataHtml += "<td>" + obj.cad +"</td>";

					dataHtml += "<td>" + obj.plu +"</td>";

					

					dataHtml += "<td>" + obj.cop +"</td>";

					dataHtml += "<td>" + obj.zin +"</td>";

					dataHtml += "<td>" + obj.phe +"</td>";

					dataHtml += "<td>" + obj.phl +"</td>";

					

					dataHtml += "<td>" + obj.rin +"</td>";

				}

				dataHtml += "</tr>";

			}

		}

		

		$("#dataList").html("");

		$('#dataList').append(dataHtml);

		$("#dataList tr:odd").attr("class","even");

		

		//2014-10-21 mypark 페이징 추가

		var pageStr = makePaginationInfo(result['PaginationInfo']);

		$("#pagination").empty();

		$("#pagination").append(pageStr);

		$("#pagination").show();

		$("#p_total_cnt").html("[총 " + result['totCnt'] + "건]");

		closeLoading();

	}

	

	function chart(){

		/* 2014-10-21 mypark 차트 주석 

		var width = "975";

		var height = "210";

		var item = $("#graphItem").val();

		

		var fact_code = $("#factCode").val();

		var sys_kind = $("#sys").val();

		var fact_name = '';

		var branch_no= $("#branch_no").val();

		

		var frDate = $("#startDate").val2();

		var toDate = $("#endDate").val2();

		var frTime = $("#frTime").val();

		var toTime = $("#toTime").val();

		

		var branch_no_before = $("#branch_no_before").val();

		var branch_no_next = $("#branch_no_next").val();

		

		if(sys_kind == "U")

			branch_no = $("#branchNo").val();

		

		document.chartForm.target = "chart";

		document.chartForm.factCode.value = fact_code;

		document.chartForm.branchNo.value = branch_no;

		document.chartForm.branchNo_before.value = branch_no_before;

		document.chartForm.branchNo_next.value = branch_no_next;

		document.chartForm.branchName.value = branch_name;

		document.chartForm.sys_kind.value = sys_kind;

		document.chartForm.frDate.value = frDate;

		document.chartForm.frTime.value = frTime;

		document.chartForm.toDate.value = toDate;

		document.chartForm.toTime.value = toTime;

		document.chartForm.item.value = item;

		document.chartForm.width.value = width;

		document.chartForm.height.value = height;

		

		document.chartForm.action = "<c:url value='/waterpolmnt/situationctl/getWatersysMntDetailGraph.do?'/>";

		document.chartForm.submit(); */

	}

	

	function validation(){

		if( $('#startDate').val() == "" ){ alert("조회 시작일자를 선택하세요"); return false; }

		if( $('#endDate').val() == "" ){ alert("조회 종료일자를 선택하세요"); return false; }

		if(!timeCheck()) {return false;}

	}

	

	function timeCheck(){

		var stdt = document.getElementById("startDate");

		var endt = document.getElementById("endDate");

		

		if(stdt.value == endt.value) {

			var frTime = $("#frTime").val();

			var toTime = $("#toTime").val();

			

			if(frTime > toTime){

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

		

		var date = new Date(stdt.value).getTime();

		var overdate =  new Date(date + (60*60*24*31)*1000);

		var strdate = overdate.getFullYear()+ "/" + addzero(overdate.getMonth()+1) + "/" + addzero(overdate.getDate());

		

		if(endt.value != '' && stdt.value > endt.value) {
			alert("조회 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			if($(n).attr("id") == "startDate") {endt.value = ""; endt.focus();}
			if($(n).attr("id") == "endDate") {stdt.value = ""; stdt.focus();}
			stdt.focus();

		}

		

		if(endt.value != '' && strdate < endt.value) {
			alert("조회 기간은 한달 이내 입니다.\n\n다시 입력해 주십시오.");
			if($(n).attr("id") == "startDate") {endt.value = ""; endt.focus();}
			if($(n).attr("id") == "endDate") {stdt.value = ""; stdt.focus();}
			
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

		timeCheck();

	}

	

	// 2014-10-21 mypark 페이징 추가

	function linkPage(pageNo){

		reloadData(pageNo);

	}

	

	function press(event) {

		if (event.keyCode==13) {

			linkPage('1');

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

						

						<form id="chartForm" name="chartForm" method="post">

							<input type="hidden" name="factCode" />

							<input type="hidden" name="branchNo" />

							<input type="hidden" name="branchNo_before"/>

							<input type="hidden" name="branchNo_next"/>

							<input type="hidden" name="branchName" />

							<input type="hidden" name="sys_kind" />

							<input type="hidden" name="frDate" />

							<input type="hidden" name="frTime" />

							<input type="hidden" name="toDate" />

							<input type="hidden" name="toTime" />

							<input type="hidden" name="width"/>

							<input type="hidden" name="height"/>

							<input type="hidden" name="item"/>

						</form>

						

						<!-- 하천 수질 조회 -->

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
										<span class="fieldName">시스템</span>
										<select class="fixWidth13" id="sys" name="sys">
											<option value="U">이동형측정기기</option>
											<option value="A">국가수질자동측정망</option>
										</select>
									</li>

									<li>

										<span class="fieldName">측정소 위치</span>
										<select class="fixWidth7" id="sugye">
											<option value="R01">한강</option>
											<option value="R02">낙동강</option>
											<option value="R03">금강</option>
											<option value="R04">영산강</option>
										</select>

										<span id="spanFact">&gt;</span>
										<select class="fixWidth11" id="factCode">
											<option value="all">전체</option>
										</select>

										<span id="spanBranch" style="display:none">
											<span>&gt;</span>
											<select class="fixWidth11" id="branchNo" name="branchNo" disabled="disabled">
												<option value="all">전체</option>
											</select>
										</span>

										<span id="spanNear" style="display:none">
											<span>&gt;</span>
											<select class="fixWidth11" id="nearAll" name="nearAll">
												<option value="all">전체</option>
												<option value="near">인접</option>
											</select>
										</span>

									</li>

									<li>

										<span class="fieldName">조회기간</span>

										<input type="text" size="13" id="startDate" name="startDate" onchange="commonWork(this)"/>

										<select id="frTime" name="frTime" onchange="commonWork(this)">

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

										<input type="text" size="13" id="endDate" name="endDate" onchange="commonWork(this)"/>

										<select id="toTime" name="toTime" onchange="commonWork(this)">

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

									</li>

								</ul>

							</div>

							<div class="btnSearchDiv">

								<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData('1');" alt="조회하기" style="float:right;"/>

							</div>

						</form:form>

						<!-- //수질 조회 현황 -->

						

						<div id="btArea">

							<span id="p_total_cnt">[총 ${totCnt}건]</span>

							<span class="red">※조사결과는 확정자료가 아닙니다</span>

						</div>

						

						<form action="">

							<div class="table_wrapper">

								<div id="table_over">

									<table id="data_table" summary="게시판 구분 , 기본정보, 수질정보가 담김">

										<colgroup id="colWidth">

										</colgroup>

										<thead id="headerList">

										</thead>

										<tbody id="dataList">

										</tbody>

									</table>

								</div>

								<!-- 2014-10-21 mypark 페이징 추가-->

								<div class="paging">

									<div id="page_number">

										<ul class="paginate" id="pagination"></ul>

									</div>

								</div>

								<!-- //페이징 -->

							</div>

						</form>

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