<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : selectDataReport.jsp
	 * Description : 데이터선별 선별보고서
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2014.11.11	kyr			최초생성
	 * 
	 * author kyr
	 * since 2014.11.11
	 * 
	 * Copyright (C) 2010 by k All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>선별보고서</title>
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/site.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />
	<script src="<c:url value='/js/JQuery/jquery-1.3.2.min.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js" type="text/javascript'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>
	<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/jquery.form.js'/>"></script>
	<script type="text/javascript">
	//<![CDATA[
		$(document).ready(function() {
			// 체크 박스 모두 체크
			$("#checkAll").click(function() {
				if($("#checkAll").attr("checked")== true){
					$("input[name=checkSeq]").attr("checked", true);
				}else{
					$("input[name=checkSeq]").attr("checked", false);
				}
				
			});
	    	
			$("input[name=checkSeq]").click(function() {
				$("input[name=checkAll]").attr("checked", false);
			});
			
		});
		
		function selectPrint() {
			$('#btArea').hide();
			window.print();
			window.close();
		}
		
		function saveSelectData(gubun){
			var str = "저장";
			if(gubun=='C') str = "확정 요청";
			if(confirm(str + " 하시겠습니까?")){
				var river_div = $('#river_div').val();
				var fact_code = $('#fact_code').val();
				var branch_no = $('#branch_no').val();
				var etc_content = $("#etc_content").val();
				var select_year = $("#searchYear").val();
				var select_month = $("#searchMonth").val();
				
				showLoading();
				
				$.ajax({
					type:"post",
					url:"<c:url value='/waterpolmnt/waterinfo/saveSelectDataInfo.do'/>",
					data:{
							river_div:river_div,
							fact_code:fact_code,
							branch_no:branch_no,
							select_year:select_year,
							select_month:select_month,
							etc_content:etc_content,
							gubun:gubun
					},
					dataType:"json",
					success:function(result){
// 						console.log("결과 값 확인 : ",result);
						alert("정상적으로 " + str + " 되었습니다.");
						closeLoading();
						
						opener.reloadData();
						window.close();
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
						dataView.getItemMetadata = function () {
							return {"columns":{0:{"colspan":"*"}}};
						}
						closeLoading();
					}
				});
			}
		}
		
		function deleteSelectData(){
			var chkLen = $("input:checkbox[name=checkSeq]").length;
			
			var chkTLen = $("input:checkbox[name=checkSeq]:checked").length;
			
			if(chkTLen> 0 ){
				if(confirm("선별초기화 하시겠습니까?")){
					var river_div = $('#river_div').val();
					var fact_code = $('#fact_code').val();
					var branch_no = $('#branch_no').val();
					var select_year = $("#searchYear").val();
					var select_month = $("#searchMonth").val();
					
					showLoading();
					
					//선별 전체 초기화
					if(chkLen==chkTLen){
						$.ajax({
							type:"post",
							url:"<c:url value='/waterpolmnt/waterinfo/initSelectData.do'/>",
							data:{
									river_div:river_div,
									fact_code:fact_code,
									branch_no:branch_no,
									select_year:select_year,
									select_month:select_month
							},
							dataType:"json",
							success:function(result){
		// 						console.log("결과 값 확인 : ",result);
								alert("정상적으로 초기화 되었습니다.");
								closeLoading();
								
								opener.reloadData();
								window.close();
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
								dataView.getItemMetadata = function () {
									return {"columns":{0:{"colspan":"*"}}};
								}
								closeLoading();
							}
						});
					}else{
						var check_sel_seq = $("#searchMonth").val();
						var chked_val = "";
						$(":checkbox[name='checkSeq']:checked").each(function(pi,po){
							chked_val += ","+po.value;
						});
						
						if(chked_val!="")chked_val = chked_val.substring(1);
		  				
						var chk_sel_seq = chked_val; 
						$.ajax({
							type:"post",
							url:"<c:url value='/waterpolmnt/waterinfo/initCheckSelectData.do'/>",
							data:{
									river_div:river_div,
									fact_code:fact_code,
									branch_no:branch_no,
									select_year:select_year,
									select_month:select_month,
									chk_sel_seq:chk_sel_seq
							},
							dataType:"json",
							success:function(result){
		// 						console.log("결과 값 확인 : ",result);
								alert("정상적으로 초기화 되었습니다.");
								closeLoading();
								
								opener.reloadData();
								window.close();
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
								dataView.getItemMetadata = function () {
									return {"columns":{0:{"colspan":"*"}}};
								}
								closeLoading();
							}
						});
					}
				}
			}else{
				alert("초기화 데이터를 선택해주세요.");
				return false;
			}
		}
		
		function excelDown() {
			var searchYear = $("#searchYear").val();
			var searchMonth = $("#searchMonth").val();
			var fact_code = $("#fact_code").val();
			var branch_no = $("#branch_no").val();
			var lastDay = $("#lastDay").val();
			var sel_seq = $("#sel_seq").val();
			
			var param = "searchYear="+searchYear+"&searchMonth="+searchMonth+"&fact_code="+fact_code+"&branch_no="+branch_no+"&lastDay="+lastDay+"&sel_seq="+sel_seq;
			
			location.href="<c:url value='/waterpolmnt/waterinfo/getSelectDataReportExcel.do'/>?"+param;
		}
	 //]]>
	</script>
</head>

<body class="pop_basic" style="overflow-X:hidden">
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div class="table_wrapper">
	<div style="margin-top:20px; margin-bottom:20px;">
		<div id="dataView" class="dataView">
			<form id="selectDataform" name="selectDataform" method="post">
			<input type="hidden" name="river_div" id="river_div" value="<c:out value='${selectDataInfo.river_div}'/>"/>
			<input type="hidden" name="fact_code" id="fact_code" value="<c:out value='${selectDataInfo.fact_code}'/>"/>
			<input type="hidden" name="branch_no" id="branch_no" value="<c:out value='${selectDataInfo.branch_no}'/>"/>
			<input type="hidden" name="gubun" id="gubun" value="S"/>
			<input type="hidden" name="searchYear" id="searchYear" value="<c:out value='${selectDataVO.searchYear}'/>"/>
			<input type="hidden" name="searchMonth" id="searchMonth" value="<c:out value='${selectDataVO.searchMonth}'/>"/>
			<input type="hidden" name="lastDay" id="lastDay" value="<c:out value='${selectDataVO.lastDay}'/>"/>
			<input type="hidden" name="sel_seq" id="sel_seq" value="<c:out value='${selectDataVO.sel_seq}'/>"/>
			
			<div id="print_first" style="margin-left:5px;margin-right:5px;">
				<p class="top_line">이동형 측정기기 표준운영절차서</p>
				<h2>이동형 측정기기의 이상데이터 발생 사유 통보</h2>
				<p class="sub_tit">○ 측정기기 위치</p>
				<table class="table01" style="width:100%;">
					<colgroup>
					<col width="20%" />
					<col width="20%" />
					<col />
					</colgroup>
					<tr>
						<th style="vertical-align:middle;">지역</th>
						<th style="vertical-align:middle;">지점</th>
						<th style="vertical-align:middle;">통보일</th>
					</tr>
					<tr>
						<td style="text-align:center; vertical-align:middle;"><c:out value='${selectDataInfo.river_name}'/></td> 
						<td style="text-align:center; vertical-align:middle;"><c:out value='${selectDataInfo.branch_name}'/></td>
						<td style="text-align:center; vertical-align:middle;">
							<c:if test="${selectDataVO.pop_gubun == 'view'}">
							<c:out value='${selectDataViewInfo.reg_date}'/>
							</c:if>
							<c:if test="${selectDataVO.pop_gubun != 'view'}">
							<c:out value='${selectDataInfo.reg_date}'/>
							</c:if>
						</td>
					</tr>
				</table>
				
				<p class="sub_tit">○ 측정기기 기간 및 상세</p>
				<table class="table02" style="width:100%;">
					<tr>
						<th style="vertical-align:middle;">선별기간</th>
					</tr>
					<tr>
						<td style="text-align:center; vertical-align:middle;"><c:out value='${selectDataVO.searchYear}'/>년 <c:out value='${selectDataVO.searchMonth}'/>월</td>
					</tr>
				</table>
				<table class="table03" style="width:100%;">
					<colgroup>
					<c:if test="${selectDataVO.pop_gubun != 'view'}">
					<col width="5%" />
					</c:if>
					<col width="18%" />
					<col width="11%" />
					<col width="9%" />
					<col width="6%" />
					<col />
					<col width="6%" />
					</colgroup>
					<tr>
						<c:if test="${selectDataVO.pop_gubun != 'view'}">
						<th style="vertical-align:middle;"><input type="checkbox" id="checkAll" name="checkAll" /></th>
						</c:if>
						<th style="vertical-align:middle;">일시</th>
						<th style="vertical-align:middle;">측정항목</th>
						<th style="vertical-align:middle;">선별기준</th>
						<th style="vertical-align:middle;">구분</th>
						<th style="vertical-align:middle;">선별사유</th>
						<th style="vertical-align:middle;">첨부</th>
					</tr>
					<c:forEach var="result" items="${detailViewList}" varStatus="status">
					<tr>
						<c:if test="${selectDataVO.pop_gubun != 'view'}">
						<td style="text-align:center; vertical-align:middle;"><input type="checkbox" id="checkSeq" name="checkSeq" value="${result.sel_seq}" /></td>
						</c:if>
						<td style="text-align:left; vertical-align:middle;"><span style="padding-left:21px;"><c:out value="${result.str_time}"/></span>&nbsp;<br /><span style="padding-left:11px;">~&nbsp;<c:out value="${result.end_time}"/></span></td>
						<td style="text-align:center; vertical-align:middle;"><c:out value="${result.sel_item}"/></td>
						<td style="text-align:center; vertical-align:middle;"><c:out value="${result.limit_yn}"/></td>
						<td style="text-align:center; vertical-align:middle;"><c:out value="${result.del_yn}"/></td>
						<td style="text-align:left;padding-left:3px; vertical-align:middle;">
							<c:if test="${result.status_content ne null}">
								<c:out value="${result.status_content}"/><br />
							</c:if>
							<c:out value="${result.sel_reason}"/>
						</td>
						<td style="text-align:center; vertical-align:middle;"><c:out value="${result.file_cnt}"/></td>
					</tr>
					</c:forEach>
					<c:if test="${fn:length(detailViewList) == 0}">
						<tr>
							<c:if test="${selectDataVO.pop_gubun != 'view'}">
							<td class="listCenter" colspan="7"  style="text-align:center;padding-top:9px;">
								조회 결과가 없습니다.
							</td>
							</c:if>
							<c:if test="${selectDataVO.pop_gubun == 'view'}">
							<td class="listCenter" colspan="6"  style="text-align:center;padding-top:9px;">
								조회 결과가 없습니다.
							</td>
							</c:if>
						</tr>
					</c:if>
				</table>
				
				<p class="sub_tit">○ 기타사항</p>
				<table class="table04" style="width:100%;">
					<tr>
						<c:if test="${selectDataVO.pop_gubun == 'view'}">
						<td style="padding-left:5px; height:70px;padding-top:9px;">
							<c:out value='${selectDataViewInfo.etc_content}'/>
						</td>
						</c:if>
						<c:if test="${selectDataVO.pop_gubun != 'view'}">
						<td>
						<textarea name="etc_content" id="etc_content" rows="4" style="width:99%;">${selectDataViewInfo.etc_content}</textarea>
						</td>
						</c:if>
					</tr>
				</table>
				
				<p class="sub_tit">○ 작성자</p>
				<table class="table05" style="width:100%;">
					<colgroup>
					<col />
					<col width="25%" />
					<col width="25%" />
					</colgroup>
					<tr>
						<th>소속</th>
						<th>직책</th>
						<th>성명</th>
					</tr>
					<tr>
						<td style="text-align:center; vertical-align:middle;"><c:out value='${member.deptNoName}'/></td>
						<td style="text-align:center; vertical-align:middle;"><c:out value='${member.gradeName}'/></td>
						<td style="text-align:center; vertical-align:middle;"><c:out value='${member.memberName}'/></td>
					</tr>
				</table>
			</div>
			<div class="fileDiv" style="padding-left:5px; padding-right:5px;">
				<p class="middle_line"></p>
				<p class="sub_tit">○ 첨부파일</p>
				<table class="table06">
					<colgroup>
					<col width="100%" />
					</colgroup>
					<c:forEach var="result" items="${fileList}" varStatus="status">
					<c:if test="${not empty result.atch_file_id}">
						<tr>
							<td style="padding-left:5px;">
							[<c:out value='${result.str_time}'/>&nbsp;~&nbsp;<c:out value='${result.end_time}'/>&nbsp;&nbsp;<c:out value='${result.sel_item}'/>&nbsp;<c:out value='${result.orignl_file_name}'/>]
							</td>
						</tr> 
						<tr>
							<td style="padding-left:5px; padding-bottom:15px;">
							<div class='imgDiv'>
								<img src="<c:url value='/cmmn/getImage.do'/>?atchFileId=<c:out value='${result.atch_file_id}'/>&fileSn=<c:out value='${result.file_seq}'/>&thumbnailFlag=N" tooltip="test" />
							</div>
							</td>
						</tr>
					</c:if>
					</c:forEach>
				</table>
				<p class="middle_line"></p>
			</div>
			<div id="btArea" style="margin-top:0; border-top:2px; padding-right:5px;">
				<input type="button" id="print" name="print" class="btn btn_print" onclick="javascript:selectPrint();" alt="프린트" />
				<c:if test="${selectDataVO.pop_gubun == 'view'}">
				<input type="button" id="excel" name="excel" class="btn btn_excel" onclick="javascript:excelDown();" alt="엑셀"/>
				</c:if>
				<c:if test="${selectDataVO.pop_gubun != 'view'}">
				<input type="button" value="저장" class="btn btn_basic" onclick="javascript:saveSelectData('S');" alt="저장"/>
				<input type="button" value="확정요청" class="btn btn_basic" onclick="javascript:saveSelectData('C');" alt="확정요청"/>
				<input type="button" value="선별초기화" class="btn btn_basic" onclick="javascript:deleteSelectData();" alt="선별초기화"/>
				</c:if>
			</div>
			</form>
		</div>
	</div>
	</div>
</body>
</html>