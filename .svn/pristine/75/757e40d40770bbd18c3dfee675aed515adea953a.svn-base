<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
 /**
  * @Class Name  : ipusn.jsp
  * @Description : IP-USN 모니터링  화면
  * @Modification Information
  * @
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  *  2010.05.17             최초 생성
  *  2013.10.20             리뉴얼
  *
  *  @author kisspa
  *  @since 2010.07.02
  *  @version 1.0
  *  @see
  *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
		SearchDate();
		
		$("#Allckeck").change(function(){
			$("input[name='alrimIdCheck']").attr("checked",$("#Allckeck").is(":checked"));
		})
		
		$("input[name='alrimIdCheck']").change(function(){
			if($("input[name='alrimIdCheck']").length == $("input[name='alrimIdCheck']:checked").length )
				$("#Allckeck").attr("checked",true);
			else $("#Allckeck").attr("checked",false);
		});
	});
	
	function excelDown(){
		document.frm.action = "/ipusn/getExcelipusnlist.do";
		document.frm.submit();
	}

	function SearchDate(){
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yy/mm/dd',
			showOn: 'both',
			buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly: true
		});
		$("#searchStartDate").datepicker({
			buttonText: '시작일'
			
		});
		$("#searchEndDate").datepicker({
			buttonText: '종료일'
		});
	}
	
	function addzero(n) {
		return n < 10 ? "0" + n : n + "";
	}

	function fn_egov_select_noticeList(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.searchStartDate.value = '${fn:substring(param_s.searchStartDate,0,4)}/${fn:substring(param_s.searchStartDate,4,6)}/${fn:substring(param_s.searchStartDate,6,8)}';
		document.frm.searchEndDate.value = '${fn:substring(param_s.searchEndDate,0,4)}/${fn:substring(param_s.searchEndDate,4,6)}/${fn:substring(param_s.searchEndDate,6,8)}';
		document.frm.searchAlrimGubun.value = '${param_s.searchAlrimGubun}';
		document.frm.searchAlrimCheck.value = '${param_s.searchAlrimCheck}';
		document.frm.action = "<c:url value='/common/member/MyAlrim.do'/>";
		document.frm.submit();
	}
	
	function goSearch(){
		document.frm.pageIndex.value = "1";
		document.frm.action = "<c:url value='/common/member/MyAlrim.do'/>";
		document.frm.submit();
	}
	
	function goUpdateAlrimCheckList(){
		if($("input[name='alrimIdCheck']:checked").length < 1)
		{
			alert("확인할 알림을 선택해주세요.");
			return false;
		}
		
		if(confirm("선택한 항목을 일괄 확인하시겠습니까?")){
			document.frm.action = "<c:url value='/common/member/UpdateCheckAlrimList.do'/>";
			document.frm.submit();
		}
	}  
	
	function goDeleteAlrimCheckList(){
		if($("input[name='alrimIdCheck']:checked").length < 1)
		{
			alert("삭제할 알림을 선택해주세요");
			return false;
		}
		
		if(confirm("선택한 항목을 일괄 삭제하시겠습니까?")){
			document.frm.action = "<c:url value='/common/member/DeleteAlrimList.do'/>";
			document.frm.submit();
		}
	}
</script>
</head>
<body>
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="/images/common/ajax-loader2.gif" alt="로딩중.." />
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
					<div class="tab_container">
						<form method="post" name="frm">
						<input type="hidden" name="pageIndex" value="${param_s.pageIndex}">
						<div class="searchBox dataSearch">
							<ul>
								<li>
									<span class="fieldName">받은기간</span>
									<input type="text" name="searchStartDate" id="searchStartDate" size="13" value="${fn:substring(param_s.searchStartDate,0,4)}/${fn:substring(param_s.searchStartDate,4,6)}/${fn:substring(param_s.searchStartDate,6,8)}"> ~
									<input type="text" name="searchEndDate" id="searchEndDate" size="13" value="${fn:substring(param_s.searchEndDate,0,4)}/${fn:substring(param_s.searchEndDate,4,6)}/${fn:substring(param_s.searchEndDate,6,8)}">
								</li>
								<li>
									<span class="fieldName">알림구분</span>
									<select name="searchAlrimGubun" id="searchAlrimGubun" class="fixWidth11">
										<option value="">전체</option>
										<option value="P" <c:if test='${param_s.searchAlrimGubun eq "P"}'>selected="selected"</c:if>>사고발생</option>
										<option value="S" <c:if test='${param_s.searchAlrimGubun eq "S"}'>selected="selected"</c:if>>교육알림</option>
										<option value="W" <c:if test='${param_s.searchAlrimGubun eq "W"}'>selected="selected"</c:if>>확정알림</option>
										<option value="D" <c:if test='${param_s.searchAlrimGubun eq "D"}'>selected="selected"</c:if>>결재알림</option>
									</select>
								</li>
								<li>
									<span class="fieldName">확인상태</span>
									<select name="searchAlrimCheck" id="searchAlrimCheck" class="fixWidth11">
										<option value="">전체</option>
										<option value="N" <c:if test='${param_s.searchAlrimCheck eq "N"}'>selected="selected"</c:if>>확인대기</option>
										<option value="Y" <c:if test='${param_s.searchAlrimCheck eq "Y"}'>selected="selected"</c:if>>확인완료</option>
									</select>
								</li>
							</ul>
						</div>
						
						<div class="btnSearchDiv">
<!-- 								<a id="btnSearch" name="btnSearch" class="btn roundBox" onclick="javascript:reloadData();" style="float:right;">조회하기</a> -->
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:goSearch();" alt="조회하기" style="float:right;"/>
						</div>							
						<div id="btArea">
							<span id="p_total_cnt">▶ 검색결과 [총 ${totCnt}건]</span>
						</div>
						<div class="table_wrapper">
							<table>
								<colgroup>
									<col width="40" />
									<col width="50" />
									<col width="100" />
									<col width="140" />
									<col />
									<col width="70" />
									<col width="140" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col"><input type="checkbox" id="Allckeck"></th>
										<th scope="col">번호</th>
										<th scope="col">알림구분</th>
										<th scope="col">알림날짜</th>
										<th scope="col">내용</th>
										<th scope="col">확인상태</th>
										<th scope="col">확인날자</th>
									</tr>
								</thead>
								<tbody>
									<c:set var="i" value="0" />
									<c:forEach var="item" items="${List}" varStatus="count">
										<c:if test="${empty item.alrimCheck eq '확인대기'}">
											<c:set var="Alrimlink" value="javascript:goAlrimLink('${empty item.alrimLink ? '#': item.alrimLink}','${item.alrimId}','${item.alrimMenuId}')"/>
										</c:if>
										<c:if test="${!empty item.alrimCheck eq '확인대기'}">
											<c:set var="Alrimlink" value="javascript:goMenu('${empty item.alrimLink ? '#': item.alrimLink}','${item.alrimMenuId}')"/>
										</c:if>
										<c:set var="i" value="${i+1}" />
										<c:set var="even" value="" />
										<c:if test="${i%2 == 0}">
											<c:set var="even" value="even" />
										</c:if>
										<tr class="<c:out value="${even}"/>">
											<td><input type="checkbox" id="alrimIdCheck" name="alrimIdCheck" value="${item.alrimId}"></td>
											<td>${totCnt - ((paginationInfo.recordCountPerPage*(param_s.pageIndex-1)) + count.index)}</td>
											<td><a href="javascript:${Alrimlink}">${item.alrimGubun}</a></td>
											<td><a href="javascript:${Alrimlink}">${item.alrimDate}</a></td>
											<td><a href="javascript:${Alrimlink}">${item.alrimTitle}</a></td>
											<td><a href="javascript:${Alrimlink}">${item.alrimCheck}</a></td>
											<td><a href="javascript:${Alrimlink}">${item.alrimCheckDate}</a></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<div class="paging">
								<div id="page_number">
									<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_select_noticeList" />
								</div>
							</div>
							
							<div class="btnSearchDiv">
	<!-- 								<a id="btnSearch" name="btnSearch" class="btn roundBox" onclick="javascript:reloadData();" style="float:right;">조회하기</a> -->
								<input type="button" id="btnConfirm" name="btnConfirm" value="확인" class="btn btn_basic" onclick="javascript:goUpdateAlrimCheckList();" alt="확인" style="float:right;"/>
								<input type="button" id="btnDel" name="btnDel" value="삭제" class="btn btn_basic" onclick="javascript:goDeleteAlrimCheckList();" alt="삭제" style="float:right;"/>
							</div>					
						</div>
						</form>
					</div>
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
</body>
</html>