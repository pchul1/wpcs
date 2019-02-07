<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : modelingRegist.jsp
	 * Description : 모델링 예측자료 입력화면
	 * Modification Information
	 * 
	 * 수정일			 수정자		수정내용
	 * ----------	--------	---------------------------
	 * 2018.11.08	assist5		최초생성
	 * 
	 * author choi hoe seop
	 * since 2018
	 * 
	 * Copyright (C) 2018 by waterkorea All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />
<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="initial-scale=1, maximum-scale=1,user-scalable=no" />

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />

<script type="text/javascript">
	//<![CDATA[
	var EventDivobj = null;
	var memFactCode = "${member.factCode}";
	var memRiverDiv = "${member.riverId}";

	var options = {
		enableColumnReorder : false,
		enableCellNavigation : true,
		multiColumnSort : true
	};

	$(function() {
		setDate();
		var tab = $('.tabs');

		function onSelectTab() {
			var t = $(this);
			var myClass = t.parent('li').attr('class');

			t.parents('.tabs:first').attr('class', 'tabs ' + myClass);
			t.parent().parent().find("li").removeClass("on");
			t.parent('li').addClass("on");
		}
		tab.find('>li>a').click(onSelectTab).focus(onSelectTab);

		reloadData();

	});
	
	function fnSpotManageRegist() {
		document.frm.action = "<c:url value='/waterpolmnt/waterinfo/modelingExcelRegist.do'/>";
		document.frm.submit();
	}
	
	function fnModelingImageRegist() {
		document.frm.action = "<c:url value='/waterpolmnt/waterinfo/modelingImageRegist.do'/>";
		document.frm.submit();
	}
	
	function setDate() {
		var date = new Date();
		var hour = date.getHours();
		time=hour<10?"0"+hour:hour;
		$("#toTime option[value="+time+"]").attr("selected", "true");
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
		var yday = new Date();		
		yday = yday.getFullYear()+ "/" + addzero(yday.getMonth()+1) + "/" + addzero(yday.getDate());
		var today = todayObj.getFullYear()+"/"+ addzero(todayObj.getMonth()+1) +"/"+ addzero(todayObj.getDate());		
		
		function addzero(n) {
			 return n < 10 ? "0" + n : n + "";
		}		
		$("#startDate").val(yday);
		$("#endDate").val(today);
	}

	//저장된 항목 가져오기
	var itemList;


	function reloadData(pageNo) {
		//측정소(지점)정보 */
		dataView = new Slick.Data.DataView();

		showLoading();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		var factCode = $("#factCode").val();
		
		if (pageNo == null)
			pageNo = 1;
		$
				.ajax({
					type : "post",
					url : "<c:url value='/waterpolmnt/waterinfo/modelingResultList.do'/>",
					data : {
						pageIndex : pageNo,
						frDate:frDate,
						toDate:toDate,
						factCode:factCode
					},
					dataType : "json",
					success : function(result) {
						var tot = result['detailViewList'].length;
						var html = "";
						if (tot <= 0) {
							html += "<tr><td colspan='8'>조회 결과가 없습니다.</td></tr>";
						} else {
							for (var i = 0; i < tot; i++) {
								var obj = result['detailViewList'][i];
								var pageInfo = result['paginationInfo'];

								obj.no = i
										+ ((pageInfo.currentPageNo - 1) * pageInfo.recordCountPerPage)
										+ 1;

								trclass = "";
								if (i % 2 == 1)
									trclass = "class=\"even\"";
								var trNo = i + 1;

								html += "<tr "
										+ trclass
										+ " id='tr"
										+ trNo
										+ "' class='tr"
										+ i
										+ "' onclick=\"javascript:clickTrEvent(this);EventDiv('"
										+ JSONtoString(obj)
										+ "',"+obj.no+");\" style='cursor:pointer;'>";
								html += "<td>" + obj.no + "</td>";
								html += "<td>" + obj.factName + "</td>";
								html += "<td>" + obj.modelDate + "</td>";
								html += "<td>" + obj.mesuValu + "</td>";
								html += "<td>" + obj.predValu1 + "</td>";
								html += "<td>" + obj.predValu2 + "</td>";
								html += "<td>" + obj.nierFrom + "</td>";
								html += "<td>" + obj.nierTo + "</td>";

								html += "</tr>";
							}
							// 페이징 정보
							var pageStr = makePaginationInfo(result['paginationInfo']);
							$("#pagination").empty();
							$("#pagination").append(pageStr);
							$("#rpage").val(pageNo);
						}
						$("#dataList").html(html);
						$("#usnDataList").html("");
						closeLoading();
					},
					error : function(result) {
						var html = "";
						html += "<tr><td colspan='8'>서버 접속에 실패하였습니다.</td></tr>";
						$("#dataList").html(html);
						$("#usnDataList").html("");
						closeLoading();
					}
				});
	}

	function clickTrEvent(trObj) {
		var tr = eval("document.getElementById(\"" + trObj.id + "\")");
		$(tr).parent().find("tr td").removeClass("tr_on");
		$(tr).find("td").addClass("tr_on");
	}

	function getUsnList(obj, no) {
		var objs = JSON.parse(StringtoJson(obj));
		var factCode = objs.factCode;
		var modelSeq = objs.modelSeq;
		
		showLoading();
		$("#usnDataList").html("");

		var indate = "";
		var outdate = "";

		$.ajax({
					type : "post",
					url : "<c:url value='/waterpolmnt/waterinfo/modelingResultDetail.do'/>",
					data : {
						modelSeq:modelSeq
					},
					dataType : "json",
					success : function(result) {
						var tot = result['getModelingResultDetail'].length;
						if (tot <= 0) {

						} else {
							for (var i = 0; i < tot; i++) {
								var obj = result['getModelingResultDetail'][i];
								var item;

								item = "<tr>";
								item += "<td>"
										+ no
										+ "<input type='hidden' name='factCode' value="+obj.factCode+" />"
										+ "<input type='hidden' name='factName' value="+obj.factName+" />"
										+ "<input type='hidden' name='modelDate' value="+obj.modelDate+" />"
										+ "<input type='hidden' name='modelSeq' value="+obj.modelSeq+" /></td>"
										+ "<td>" + obj.factName + "</td>"
										+ "<td>" + obj.modelDate + "</td>"
										/* + "<td><input type='text' name='tur' value='" + obj.tur + "' size='15'/></td>"
										+ "<td><input type='text' name='tmp' value='" + obj.tmp + "' size='15'/></td>"
										+ "<td><input type='text' name='phy' value='" + obj.phy + "' size='15'/></td>"
										+ "<td><input type='text' name='dow' value='" + obj.dow + "' size='15'/></td>"
										+ "<td><input type='text' name='con' value='" + obj.con + "' size='15'/></td>"
										+ "<td><input type='text' name='tof' value='" + obj.tof + "' size='15'/></td>" */
										+ "<td>" + obj.mesuValu + "</td>"
										+ "<td>" + obj.predValu1 + "</td>"
										+ "<td>" + obj.predValu2 + "</td>"
										+ "<td>" + obj.nierFrom + "</td>"
										+ "<td>" + obj.nierTo + "</td>"
								item += "</tr>";
								$("#usnDataList").append(item);
								$("#usnDataList tr:odd").attr("class",
										"add");
							}
							indate = "";
							outdate = "";
						}
						closeLoading();
					},
					error : function(result) {
						// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
						var oraErrorCode = "";
						if (result.responseText != null) {
							var matchedValue = result.responseText
									.match(/ORA-[0-9]{5}/);
							if (matchedValue != null
									&& matchedValue.length > 0) {
								oraErrorCode = matchedValue[0].replace(
										'ORA-', '');
							}
						}
						;
						$("#usnDataList").html(
								"<tr><td colspan='8'>서버 접속에 실패하였습니다! [CODE:"
										+ oraErrorCode + "]</td></td>");
						closeLoading();
					}
				});
	}

	function EventDiv(obj, no) {
		if (obj != undefined) {
			EventDivobj = obj;
		}
		getUsnList(EventDivobj, no);
		/* getEqList(EventDivobj);
		getItemList(EventDivobj);
		getSmsList(EventDivobj); */
	}

	// 페이지 번호 클릭
	function linkPage(pageNo) {
		reloadData(pageNo);
	}

	// 페이지 네비게이션 만들기
	function makePaginationInfo_(result) {
		var str = "";

		if (result.currentPageNo > result.pageSize) {
			str += "<li><a style='cursor:pointer' onclick=\"linkPage_('"
					+ result.firstPageNo + "')\">[처음]</a></li>";
			str += "<li><a style='cursor:pointer' onclick=\"linkPage_('"
					+ (result.firstPageNoOnPageList - 1) + "')\">[이전]</a></li>";
		}

		var idx = 0;
		for (var i = result.firstPageNoOnPageList; i <= result.lastPageNoOnPageList; i++) {
			if (result.currentPageNo == i) {
				str += "<li><em>" + i + "</em></li>";
			} else {
				str += "<li><a style='cursor:pointer' onclick=\"linkPage_('"
						+ i + "')\">" + i + "</a></li>";
			}
			idx++;
		}

		if (result.currentPageNo < result.lastPageNo && idx == result.pageSize
				&& result.pageSize < result.lastPageNo) {
			str += "<li><a style='cursor:pointer' onclick=\"linkPage_('"
					+ (result.lastPageNoOnPageList + 1) + "')\">[다음]</a></li>";
			str += "<li><a style='cursor:pointer' onclick=\"linkPage_('"
					+ result.lastPageNo + "')\">[마지막]</a></li>";
		}

		return str;
	}
	
	function excelDown() {
		var riverDiv = $("select[name=c_river_div]").val();
		var sysKind = $("select[name=c_sys_kind]").val();
		var branchName = $("#c_branch_name").val();
		var searchText;

		if ($("#c_branch_name").val() != "") {
			searchText = branchName;
		} else {
			searchText = "";
		}
		var param = "sysKind=" + sysKind + "&riverDiv=" + riverDiv
				+ "& searchText=" + searchText;
		location.href = "<c:url value='/spotmanage/getExcelSpotmgrList.do'/>?"
				+ param;
	}

	function addzero(n) {
		return n < 10 ? "0" + n : n + "";
	}

	function JSONtoString(object) {
		var results = [];
		for ( var property in object) {
			var value = object[property];
			if (value)
				results.push(property.toString() + ': ' + value);
		}

		return '{' + results.join(', ') + '}';
	}

	function StringtoJson(object) {
		object = object.replace(/\s/g, "");
		object = object.replace(/\{/g, "{\"");
		object = object.replace(/\}/g, "\"}");
		object = object.replace(/\:/g, "\":\"");
		object = object.replace(/\,/g, "\",\"");
		return object;
	}

	function clickTrEvent(trObj) {
		var tr = eval("document.getElementById(\"" + trObj.id + "\")");
		$(tr).parent().find("tr td").removeClass("tr_on");
		$(tr).find("td").addClass("tr_on");
	}
	
	function clickTrEventUSN(trObj, frdate, seq) {
		var tr = eval("document.getElementById(\"" + trObj.id + "\")");

		$(tr).parent().find("tr td").removeClass("tr_on");
		$(tr).find("td").addClass("tr_on");
		$("#UsnHistoryInfoDate").val(frdate);

		$("#introDate").val($("#str" + seq).val());
		$("#outDate").val($("#end" + seq).val());
	}

	function numberCheck(n) {
		var temp = n.value
		if (isNaN(temp) == true) {
			n.value = "";
			alert("숫자만 입력해 주세요");
		}
	};

	function makeTr(i, s, e) {
		var trclass = "class=\"even\"";
		var trNo = i + 1;

		if (s == "") {
			return "<tr style='cursor:pointer;' " + trclass + " id='treq"
					+ trNo + "' class='tr" + i
					+ "'  onclick='javascript:clickTrEvent(this);usnDateSet("
					+ "\"" + s + "\",\"" + e + "\");'><td>최초설치~" + e
					+ "</td></tr>";
		} else {
			return "<tr style='cursor:pointer;' " + trclass + " id='treq"
					+ trNo + "' class='tr" + i
					+ "'  onclick='javascript:clickTrEvent(this);usnDateSet("
					+ "\"" + s + "\",\"" + e + "\");'><td>" + s + "~" + e
					+ "</td></tr>";
		}
	}
	function usnDateSet(s, e) {
		$("#introDate").val(s);
		$("#outDate").val(e);
		goUsnEqHistoryTerm();
	}

	$(function() {
		$.datepicker.setDefaults({
			monthNames : [ '년 1월', '년 2월', '년 3월', '년 4월', '년 5월', '년 6월',
					'년 7월', '년 8월', '년 9월', '년 10월', '년 11월', '년 12월' ],
			dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
			showMonthAfterYear : true,
			dateFormat : 'yy/mm/dd',
			showOn : 'both',
			buttonImage : "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly : true
		});
		$("#usnsearchDate1").datepicker({
			buttonText : '시작일'
		});
		$("#usnsearchDate2").datepicker({
			buttonText : '종료일'
		});

	});
	
	function commonWork(n) {
		var stdt = document.getElementById("startDate");
		//var endt = document.getElementById("endDate");
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
		/* if(endt.value !=''){
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
		} */
		
		var date = new Date(stdt.value).getTime();
		var overdate =  new Date(date + (60*60*24*31)*1000);
		var strdate = overdate.getFullYear()+ "/" + addzero(overdate.getMonth()+1) + "/" + addzero(overdate.getDate());
		
		/* if(endt.value != '' && stdt.value > endt.value) {
			alert("조회 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			if($(n).attr("id") == "startDate") {endt.value = ""; endt.focus();}
			if($(n).attr("id") == "endDate") {stdt.value = ""; stdt.focus();}
		} */
		
		/* if(endt.value != '' && strdate < endt.value) {
			alert("조회 기간은 한달 이내 입니다.\n\n다시 입력해 주십시오.");
			if($(n).attr("id") == "startDate") {endt.value = ""; endt.focus();}
			if($(n).attr("id") == "endDate") {stdt.value = ""; stdt.focus();}
		} */
		
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

	//]]>
</script>
</head>

<body>
	<iframe id="downFrame" id="downFrame" width="0" height="0"
		frameborder="0"></iframe>
	<input type="hidden" id="d_det_code" name="d_det_code" />
	<input type="hidden" id="d_sys_kind" name="d_sys_kind" />
	<input type="hidden" id="member_id" name="member_id" />
	<input type="hidden" id="indexNum" name="indexNum" />
	<input type="hidden" id="index" name="index" />
	<input type="hidden" id="UpdateSeq" name="UpdateSeq" />
	<input type="hidden" id="itemCnt" name="itemCnt" />

	<input type="hidden" id="UsnfactCode" name="UsnfactCode"></input>
	<input type="hidden" id="UsnBranchNo" name="UsnBranchNo"></input>
	<input type="hidden" id="introDate" name="introDate"></input>
	<input type="hidden" id="outDate" name="outDate"></input>

	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>"
			alt="로딩중.." />
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

					<div class="searchBox dataSearch">
						<ul>
							<li>
								<span class="fieldName">조회지점</span>
								<select class="fixWidth7" name="factCode" id="factCode">
										<option value="">전체</option>
										<option value="2011801">칠곡보</option>
										<option value="2011802">강정고령보</option>
										<option value="2017801">창령·함안보</option>
								</select>
							</li>
							<li>
								<span class="fieldName">조회기간</span>
								<input type="text" size="13" id="startDate" name="startDate" onchange="commonWork(this)"/>
								<span>~</span>
								<input type="text" size="13" id="endDate" name="endDate" onchange="commonWork(this)"/>
							</li>
						</ul>
					</div>
					<div class="btnSearchDiv">
						<input type="button" id="btnSearch" name="btnSearch" value="조회하기"
							class="btn btn_search" onclick="javascript:reloadData();"
							alt="조회하기" style="float: right;" />
					</div>

					<input type="hidden" id="rlongitude" name="rlongitude" /> <input
						type="hidden" id="rlatitude" name="rlatitude" /> <input
						type="hidden" id="rpage" name="rpage" />
					<form name="frm" action="" method="post">
						<!--tab Contnet Start-->
						<div class="table_wrapper">
							<table>
								<colgroup id="colWidth">
									<col width='45' />
									<col width='160' />
									<col width='130' />
									<col width='130' />
									<col width='130' />
									<col width='130' />
									<col width='100' />
									<col width='100' />
								</colgroup>
								<thead>
									<tr>
										<th scope='col'>NO</th>
										<th scope='col'>지점명</th>
										<th scope='col'>검사년월일</th>
										<th scope='col'>실측값</th>
										<th scope='col'>회귀분석</th>
										<th scope='col'>요인분석+회귀분석</th>
										<th colspan='2' scope='col'>과학원예측범위</th>
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
							<div style="padding-bottom:20px">
								<input type="button" id="btnSpotManageInsert"
									name="btnSpotManageInsert" value="엑셀업로드" style="float: right"
									class="btn btn_basic" onclick="javascript:fnSpotManageRegist();"
									alt="엑셀업로드" />
								<input type="button" id="btnSpotManageInsert"
									name="btnSpotManageInsert" value="이미지등록" style="float: right"
									class="btn btn_basic" onclick="javascript:fnModelingImageRegist();"
									alt="이미지등록" />
							</div>
						</div>
					</form>

					<!-- tab2 -->
					<!--top Search Start-->
					<div id="tpl_tab_1">
						<div style="text-align: left;">
							<span id="usnBranchName"></span> <input type="hidden" id="fc" />
							<input type="hidden" id="bc" />
						</div>
						<!--top Search End-->

						<div class="table_wrapper">

							<table id="tab_1_1" summary="usn정보">
								<colgroup id="colWidth">
									<col width='45' />
									<col width='160' />
									<col width='130' />
									<col width='130' />
									<col width='130' />
									<col width='130' />
									<col width='100' />
									<col width='100' />
								</colgroup>
								<thead>
									<tr>
										<th scope='col'>NO</th>
										<th scope='col'>지점명</th>
										<th scope='col'>검사년월일</th>
										<th scope='col'>실측값</th>
										<th scope='col'>회귀분석</th>
										<th scope='col'>요인분석+회귀분석</th>
										<th colspan='2' scope='col'>과학원예측범위</th>
									</tr>
								</thead>
								<tbody id="usnDataList">
									<tr>
										<td>&nbsp;</td>
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
					</div>
					<!-- //tab2 -->

				</div>
				<!--tab Contnet End-->
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