<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
 /**
  * @Class Name  : MySeminarSchedule.jsp
  * @Description : 나의 교육 신청현황  화면
  * @Modification Information
  * @
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  *  2014.10.20             최초 생성
  *
  *  @author mypark
  *  @since 2014.10.20
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
    $(document).ready(function() {
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
	
	function press(event) {
		if (event.keyCode==13) {
			fn_egov_List('1');
		}
	}
	
	//목록 페이지 이동
	function fn_egov_List(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/common/member/MySeminarSchedule.do'/>";
		document.frm.submit();
	}
	
	//교육 신청 취소 처리
	function fn_egov_EntryCencel() {
		var chked_val = "";
		if ( $('input:checkbox[name="checkNo"]:checked').length > 0 ){
			if(confirm("선택하신 교육을 취소 하시겠습니까?")){
				$(":checkbox[name='checkNo']:checked").each(function(pi,po){
					chked_val += ","+po.value;
				});
				if(chked_val!="")	chked_val = chked_val.substring(1);
				var array = new Array();
				if(chked_val.indexOf(",") > 0) {
					array = chked_val.split(",");
				} else {
					array[0] = chked_val;
				}
				
				document.frm.checkSeminarId.value = chked_val;
				document.frm.action = "<c:url value='/common/member/UpdateSeminarEntry.do'/>";
				document.frm.submit();
			}
		} else {
			alert("신청 취소할 교육을 선택해주세요.");
			return false;
		}
	}
	
	function excelDown() {
		document.frm.action = "<c:url value='/common/member/MySeminarScheduleExcel.do'/>";
		document.frm.submit();
	}
	
	function fn_egov_View(seminarId) {
		goMenu("/seminar/SeminarApplicationView.do?urlStr=SeminarScheduleList.do&seminarId=" + seminarId,34100);
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
						
					<!--tab Contnet Start-->
					<div class="tab_container">
						<!-- 내용 보기 -->
						<form name="frm" action ="" method="post">
							<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />
							<input type="hidden" name="seminarId" value="" />
							<input type="hidden" name="checkSeminarId" value="" />
							<input type="hidden" name="urlStr" value="" />
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
										<span class="fieldName">구분&nbsp;&nbsp;</span>
										<select name="searchGubun" id="searchGubun" class="select">
											<option value="">전체</option>
											<option value="L" <c:if test="${searchVO.searchGubun == 'L'}">selected="selected"</c:if>>강사신청</option>
											<option value="S" <c:if test="${searchVO.searchGubun == 'S'}">selected="selected"</c:if>>교육신청</option>
										</select>
									</li>
									<li>
										<span class="fieldName">상태&nbsp;&nbsp;</span>
										<select name="searchClosingState" id="searchClosingState" class="select">
											<option value="">전체</option>
											<option value="Y" <c:if test="${searchVO.searchClosingState == 'Y'}">selected="selected"</c:if>>신청</option>
											<option value="N" <c:if test="${searchVO.searchClosingState == 'N'}">selected="selected"</c:if>>마감</option>
										</select>
									</li>
									<li>
										<span class="fieldName">검색&nbsp;&nbsp;</span>
										<select name="searchCnd" id="searchCnd" class="select">
											<option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >전체</option>
											<option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >교육명</option>
											<option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if> >교육내용</option>
										</select>
										<input type="text" name="searchWrd" id="searchWrd" size="50"  class="inputText" value='<c:out value="${searchVO.searchWrd}"/>' onkeypress="press(event);" title="검색어입력" />
									</li>
								</ul>
							</div>
							<div class="btnSearchDiv">
								<input type="button" id="btnSearch" name="btnSearch"   value="조회하기" class="btn btn_search" onclick="javascript:fn_egov_List('1');" alt="조회하기" style="float:right;">
							</div>
							<!--top Search End-->
							<div id="btArea">
								<span id="p_total_cnt">▶ 검색결과 (총 ${resultCnt}건)</span>
 								<input type="button" id="excel" name="excel" class="btn btn_excel"  onclick="javascript:excelDown();" alt="엑셀">
							</div>
							<!-- 글목록 내용 -->
							<div class="table_wrapper">
								<table summary="게시판 리스트. 번호, 교육명, 교육기간, 교육시간, 교육장소, 참여인원, 상태가 담김">
									<colgroup>
										<col width="30" />
										<col width="50" />
										<col />
										<col width="120" />
										<col width="100" />
										<col width="120" />
										<col width="80" />
										<col width="110" />
										<col width="60" />
										<col width="70" />
										<col width="70" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col"><input type="checkbox" id="checkAll" name="checkAll"/></th>
											<th scope="col">No.</th>
											<th scope="col">교육명</th>
											<th scope="col">교육기간</th>
											<th scope="col">교육시간</th>
											<th scope="col">교육장소</th>
											<th scope="col">담당자</th>
											<th scope="col">연락처</th>
											<th scope="col">참여인원</th>
											<th scope="col">구분</th>
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
										<tr  class="<c:out value="${even}"/>">
											<td>
												<c:if test="${result.seminarClosingStateName == '신청가능'}">
													<input type="checkbox" id="checkNo" name="checkNo" value="<c:out value='${result.seminarEntryId}'/>"/>
												</c:if>
											</td>
											<td>
												<c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/>
											</td>
											<td class="con" style="text-align:left; padding:0px 10px;">
												<a href="javascript:fn_egov_View('<c:out value="${result.seminarId}"/>')">
												<c:out value="${result.seminarTitle}"/></a>
											</td>
											<td><c:out value="${result.seminarDate}"/></td>
											<td><c:out value="${result.seminarTimeFrom}"/> ~ <c:out value="${result.seminarTimeTo}"/></td>
											<td><c:out value="${result.seminarPlace}"/></td>
											<td><c:out value="${result.seminarLectName}"/></td>
											<td><c:out value="${result.seminarLectTel}"/></td>
											<td>
												<c:out value="${result.entryCount}"/> / <c:out value="${result.seminarCount}"/>
											</td>
											<td><c:out value="${result.seminarGubunName}"/></td>
											<td><c:out value="${result.seminarClosingStateName}"/></td>
										</tr>
									</c:forEach>
									<c:if test="${fn:length(resultList) == 0}">
										<tr>
											<td class="listCenter" colspan="11" ><spring:message code="common.nodata.msg" /></td>
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
								<div style="text-align:left;font-weight:bold;">
										신청가능 상태일 경우에만 신청취소가 가능합니다
								</div>
								<!-- 버튼 메뉴 -->
								<div id="btArea">
									<input type="button" id="btnCencel" name="btnCencel" value="신청취소" class="btn btn_basic" onclick="javascript:fn_egov_EntryCencel();" alt="신청취소" />
								</div>
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
</body>
</html>