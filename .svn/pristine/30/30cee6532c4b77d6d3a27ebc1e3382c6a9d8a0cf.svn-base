<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : seminarApplicationList.jsp
	 * Description : 교육신청내역 화면
	 * Modification Information
	 * 
	 * 수정일         		수정자                   수정내용
	 * -------    			--------    ---------------------------
	 * 2014.09.19		mypark		최초생성
	 *
	 * author mypark
	 * since 2014.09.19
	 *  
	 * Copyright (C) 2014 by 이용 All right reserved.
	 */  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>
<title>한국환경공단 수질오염 방제정보 시스템</title>
<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />
<script type="text/javascript" src="<c:url value='/js/bbs/EgovBBSMng.js' />" ></script>
<script type="text/javascript">
//<![CDATA[
	$(document).ready(function() {
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yy/mm/dd',
			showOn: 'both',
			buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly: true
		});
		$("#searchBgnDe").datepicker({
			buttonText: '시작일'
			
		});
		$("#searchEndDe").datepicker({
			buttonText: '종료일'
		});
	});
//]]>

</script>
<script type="text/javascript">
	//교육 기간 검색 날짜 선택 체크
	function commonWork() {
		var stdt = document.getElementById("searchBgnDe");
		var endt = document.getElementById("searchEndDe");
	
		if(endt.value != '' && stdt.value > endt.value) {
			alert("교육기간 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			stdt.value = "";
			endt.value = "";
			stdt.focus();
		}
	}
	
	//목록
	function fn_egov_List(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/seminar/SeminarApplicationList.do'/>";
		document.frm.submit();
	}
	
	function press(event) {
		if (event.keyCode==13) {
			fn_egov_List('1');
		}
	}
	
	//레이어 닫기
	function layerPopCloseAll() {
		layerPopClose("layerEntryMemList");
	}
	
	//레이어 닫기
	function layerPopCloseAll2() {
		layerPopClose("layerExcept");
	}
	
	//상세보기
	function fn_egov_View(seminarId) {
		document.frm.seminarId.value = seminarId;
		document.frm.action = "<c:url value='/seminar/SeminarApplicationView.do'/>";
		document.frm.urlStr.value = "SeminarApplicationList.do";
		document.frm.submit();
	}
	
	//교육 참여자 제외 레이어 표시
	function fn_egov_Except(){
		var form = document.memEntryForm;
		if ( $('input:checkbox[name="checkNo"]:checked').length > 0 ){
			if(confirm("선택하신 참여자를 제외 하시겠습니까?")){
				var chked_val = "";
				$(":checkbox[name='checkNo']:checked").each(function(pi,po){
					chked_val += ","+po.value;
				});
				if(chked_val!="")	chked_val = chked_val.substring(1);
				form.checkSeminarId.value = chked_val;
				form.entryYn.value = 'N';
				layerPopCloseAll('layerDeptMemList');
				layerPopOpen('layerExcept');
			}
    	}else{
    		alert("제외할 참석자를 선택해주세요.");
			return false;
    	}
    }
	
	//참여자 제외 처리
	function fn_egov_Disapprover() {
		var pageNo = document.memEntryForm.pageIndex.value;
		var seminarId = document.memEntryForm.seminarId.value;
		var urlStr = document.memEntryForm.urlStr.value;
		var checkSeminarId = document.memEntryForm.checkSeminarId.value;
		if (pageNo == null) pageNo = 1;
		$.ajax({
			type: "POST",
			url: "<c:url value='/seminar/UpdateSeminarEntry.do'/>",
			data: {
					entryYn:'N',
					seminarId:seminarId,
					pageIndex:pageNo,
					urlStr:urlStr,
					checkSeminarId:checkSeminarId,
					entryReason:$('#entryReason').val()
				},
			dataType:"json",
			success : function(result){
				document.memEntryForm.action = "<c:url value='/seminar/SeminarApplicationList.do'/>";
				document.memEntryForm.submit();
			}
		});
	}
	
	//교육 신청 참여자
	function popOpen(seminarId){
		$.ajax({
			type: "POST",
			url: "<c:url value='/seminar/selSeminarEntryView.do'/>",
			data: {seminarId:seminarId},	
			dataType:"json",
			success : function(result){
				if(result != null) {
					var list = result['resultList'];
					var memHtml = "";
					var titleHtml = "";
					 for(var i = 0; i < list.length; i++) {
						if(i == 0) titleHtml += list[i].seminarTitle;
						memHtml += "<tr><td><input type=\"checkbox\" id=\"checkNo\" name=\"checkNo\" value=\""+ list[i].seminarEntryId+ "//" + list[i].seminarMemId +"\"/></td>"; 
						memHtml += "<td>" + list[i].seminarMemName + "</td>";
						memHtml += "<td>" + list[i].memDeptName + "</td>";
						memHtml += "<td>" + list[i].memEmail + "</td>";
						memHtml += "<td>" + list[i].memTel + "</td></tr>";
					}
					$('#memList').html("");
					$('#seminarEntryTitle').html("");
					$('#seminarEntryTitle').append("<span>" + titleHtml + "</span>");
					$('#memList').append(memHtml);
					$("#memList tr:odd").attr("class","even");
					document.memEntryForm.seminarId.value = seminarId;
					
					// 체크 박스 모두 체크
					$("#checkAll").click(function() {
						if($(this).attr("checked")== "checked"){
							$("input[name=checkNo]").attr("checked", true);
						}else{
							$("input[name=checkNo]").attr("checked", false);
						}
					});
			    	
					$("input[name=checkNo]").click(function() {
						$("input[name=checkAll]").attr("checked", false);
					});
					
					layerPopOpen('layerEntryMemList');
				}
			}
		});
	}
	
	function excelDown(){
		document.frm.action = "<c:url value='/seminar/ApplicationListExcel.do'/>";
		document.frm.submit();
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
						<!-- 내용 보기 -->
						<form name="frm" action ="" method="post">
							<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />
							<input type="hidden" name="seminarId" value="" />
							<input type="hidden" name="urlStr" value="SeminarApplicationList.do" />
							<!--top Search Start-->
							<div class="searchBox dataSearch">
								<ul>
									<li>
										<span class="fieldName">교육기간&nbsp;&nbsp;</span>
										<input type="text" id="searchBgnDe" name="searchBgnDe" size="13" value="<c:out value="${searchVO.searchBgnDe}"/>" onchange="commonWork()" alt="조회시작일"/>
										<span>~</span>
										<input type="text" id="searchEndDe" name="searchEndDe" size="13" value="<c:out value="${searchVO.searchEndDe}"/>" onchange="commonWork()" alt="조회종료일"/>
									</li>
									<li>
										<span class="fieldName">검색&nbsp;&nbsp;</span>
										<select name="searchCnd" id="searchCnd" class="select">
											<option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >전체</option>
											<option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >교육명</option>
											<option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if> >교육내용</option>
										</select>
										<input type="text" name="searchWrd" id="searchWrd" size="50" class="inputText" value='<c:out value="${searchVO.searchWrd}"/>' onkeypress="press(event);" title="검색어입력" />
									</li>
								</ul>
							</div>
							<div class="btnSearchDiv">
								<input type="button" id="btnSearch" name="btnSearch"   value="조회하기" class="btn btn_search" onclick="javascript:fn_egov_List('1');" alt="조회하기" style="float:right;">
							</div>
							<!--top Search End-->
							<div id="btArea">
								<span id="p_total_cnt">▶ 검색결과 (총 <c:out value="${resultCnt}"/>건)</span>
 								<input type="button" id="excel" name="excel" class="btn btn_excel"  onclick="javascript:excelDown();" alt="엑셀">
							</div>
							<!-- 글목록 내용 -->
							<div class="table_wrapper">
								<table summary="게시판 리스트. 번호, 교육명, 교육기간, 교육시간, 교육장소, 참여인원, 상태가 담김">
									<colgroup>
										<col width="50" />
										<col />
										<col width="120" />
										<col width="100" />
										<col width="120" />
										<col width="120" />
										<col width="100" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">No.</th>
											<th scope="col">교육명</th>
											<th scope="col">교육기간</th>
											<th scope="col">교육시간</th>
											<th scope="col">교육장소</th>
											<th scope="col">참여인원</th>
											<th scope="col">상태</th>
										</tr>
									</thead>
									<tbody>
										<c:set var="i" value="0" />
										<c:forEach var="result" items="${resultList}" varStatus="status">
											<c:set var="i" value="${i+1}" />
											<c:set var="even" value="" />
											<c:if test="${i%2 == 0}">
												<c:set var="even" value="even" />
											</c:if>
										<tr class="<c:out value="${even}"/>">
											<td>
												<c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/>
											</td>
											<td class="con" style="text-align:left; padding:0px 10px;">
												<a href="javascript:fn_egov_View('<c:out value="${result.seminarId}"/>')">
												<u><c:out value="${result.seminarTitle}"/></u></a>
											</td>
											<td><c:out value="${result.seminarDate}"/></td>
											<td><c:out value="${result.seminarTimeFrom}"/> ~ <c:out value="${result.seminarTimeTo}"/></td>
											<td><c:out value="${result.seminarPlace}"/></td>
											<td>
												<c:out value="${result.entryCount}"/> / <c:out value="${result.seminarCount}"/>
												<c:if test="${result.entryCount > 0}">
													<a href="javascript:popOpen('<c:out value="${result.seminarId}"/>');">[보기]</a>
												</c:if>
											</td>
											<td><c:out value="${result.seminarClosingStateName}"/></td>
										</tr>
										</c:forEach>
										
										<c:if test="${fn:length(resultList) == 0}">
											<tr>
												<td class="listCenter" colspan="7" ><spring:message code="common.nodata.msg" /></td>
											</tr>
										</c:if>
									</tbody>
								</table>
								<!-- 페이징 -->
								<div class="paging">
									<div id="page_number">
										<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_List" />
									</div>
								</div>
								<!-- //페이징 -->
							</div>
							<!-- //글목록 내용 -->
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
	<!-- 담당자 선택 레이어 -->
	<div id="layerEntryMemList" class="divPopup" style="background-color:#FFFFFF;">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnFacSizeModXbox" name="btnFacSizeModXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopCloseAll('layerDeptMemList');" alt="닫기" />
		</div>
		<div id="MemList">
			<div id="seminarEntryTitle"></div>
			<div style="width: 530px; height:400px; overflow-x: auto;">
				<div class="table_wrapper" style="width:500px;  text-align: center;">
					<table summary="알림 목록. 구분, 알림날짜, 알림내용, 확인이 담김">
						<colgroup>
							<col width="30" />
							<col width="100" />
							<col width="120" />
							<col width="130" />
							<col width="120" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col"><input type="checkbox" id="checkAll" name="checkAll"/></th>
								<th scope="col">이름</th>
								<th scope="col">소속</th>
								<th scope="col">이메일</th>
								<th scope="col">연락처</th>
							</tr>
						</thead>
						<tbody id="memList">
							<tr>
								<th scope="col" colspan='5'></th>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div id="btArea">
				<input type="button" id="btnExcept" name="btnExcept" value="제외" class="btn btn_basic" onclick="javascript:fn_egov_Except();" alt="제외" />
				<input type="button" id="btnClose" name="btnClose" value="확인" class="btn btn_basic" onclick="javascript:layerPopCloseAll('layerDeptMemList');" alt="확인" />
			</div>
		</div>
	</div>
	<!-- 교육 참석자 제외 사유  -->
	<div id="layerExcept" class="divPopup" Style="background-color:#FFFFFF;" >
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnFacSizeModXbox" name="btnFacSizeModXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopCloseAll2();" alt="닫기" />
		</div>
		<form id="memEntryForm" name="memEntryForm" method="post">
			<input type="hidden" name="checkSeminarId" id="checkSeminarId" value="" />
			<input type="hidden" name="entryYn" value="" />
			<input type="hidden" name="seminarId" value="" />
			<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />
			<input type="hidden" name="urlStr" value="SeminarApplicationList.do" />
			<div id="deptList" style="background-color:#FFFFFF;">
				<div class="gBox" style="width:430px;height:210px;border:0;">
					<textarea id="entryReason" name="entryReason" style="width:410px;height:150px;"></textarea>
					<div id="btArea">
						<input type="button" id="btnRegist" name="btnRegist" value="확인" class="btn btn_basic" onclick="javascript:fn_egov_Disapprover();" alt="확인" />
					</div>
				</div>
			</div>
		</form>
	</div>
</body>
</html>