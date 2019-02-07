<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : select_data_his.jsp
	 * Description : 데이터선별이력
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2014.11.12	kyr		최초 생성
	 * 
	 * author kyr
	 * since select_data_his
	 * 
	 * Copyright (C) 2014 by smji  All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- <html xmlns="http://www.w3.org/1999/xhtml"> -->
<html>

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
		if(user_u_cnt == 0){
// 			alert('권한이 없습니다. 측정소를 등록해주세요.');
// 			window.location = "<c:url value='/main.do'/>";
		}
	}
	
//<![CDATA[
	$(document).ready(function(){
		var memFactCode = "${member.factCode}";
		var memRiverDiv = "${member.riverId}";
		
		//user 측정소권한에 따른 수계 고정
		if(user_roleCode == 'ROLE_ADMIN'){
			selectedSugyeInMemberId(user_riverid, 'riverDiv');
			
			adjustGongku();
		}else{
			selectedSugyeInMemberIdNew(id, 'U', 'riverDiv');
		}
		
		//메시지처리
		<c:if test="${not empty message }">
			alert("${message}");
		</c:if>
		
		$('#riverDiv').change(function(){
			adjustGongku();		//수계 2  조회
			//adjustBranchList();	//수계 3  조회
		});
		
		function addzero(n) {
			return n < 10 ? "0" + n : n + "";
		}
		
		var today = new Date();
		var year = "";
		var pre_year = today.getFullYear()-6;
		
		var month = "";
		
		if('${searchYear}' == ''){
			year = today.getFullYear();
		}else{
			year = '${searchYear}';
		}
		
		if('${searchMonth}' == ''){
			month = addzero(today.getMonth() + 1);
		}else{
			month = '${searchMonth}';
		}
		
		if(month=='01'){
			year = year-1;
		}
		for(var i=pre_year ; i<=year ; i++){
			var temp_year = "";
			if(i == year){
				temp_year = "<option value='"+i+"' selected>"+i+"</option>";
			}else{
				temp_year = "<option value='"+i+"'>"+i+"</option>";
			}
			$("#searchYear").append(temp_year);
		}
		var pre_month;
		if(month=='01'){
			pre_month = 12;
			month = 13;
		}else{
			pre_month = (today.getMonth() + 1)-1;
		}
		for(var i=1 ; i<month ; i++){
			var temp_month = "";
			var temp_i;
			if(i<10){
				temp_i = "0"+i;
			}else{
				temp_i = i;
			}
			if(i == pre_month){
				temp_month = "<option value='"+temp_i+"' selected>"+temp_i+"</option>";
			}else{
				temp_month = "<option value='"+temp_i+"'>"+temp_i+"</option>";
			}
			$("#searchMonth").append(temp_month);
		}
		
		
	});
	
	var firstFlag = false;
	
	function adjustGongku()
	{
		var riverDiv = $('#riverDiv').val();
		
		var factCode = $('#factCode');
		var branchNo = $('#branchNo');
		
		factCode.attr("style", "background:#ffffff;");
		branchNo.attr("style", "background:#ffffff;");
		
		$.getJSON("<c:url value='/waterpolmnt/waterinfo/getGongkuList.do'/>",
				{sugye:riverDiv, system:'U'},
				function (data, status){
				if(status == 'success'){
				
					factCode.loadSelect(data.gongku);
					factCode.attr("disabled", true);
					factCode.attr("style", "background:#e9e9e9;");
					
					adjustBranchListNew();
				} else { 
					alert("공구 목록 가져오기 실패");
					return;
				}
		});
	}
	
	
	function adjustFactList()
	{
		var riverDiv = $('#riverDiv').val();
		
		var factCode = $('#factCode');
		var branchNo = $('#branchNo');
		
		factCode.attr("style", "background:#ffffff;");
		branchNo.attr("style", "background:#ffffff;");
		
		$.getJSON("<c:url value='/waterpolmnt/waterinfo/getGongkuList.do'/>",
				{sugye:riverDiv, system:'U'},
				function (data, status){
				if(status == 'success'){
				
					factCode.loadSelect(data.gongku);
					factCode.attr("disabled", true);
					factCode.attr("style", "background:#e9e9e9;");
					
					adjustBranchList();
				} else { 
					alert("공구 목록 가져오기 실패");
					return;
				}
		});
	}
	
	//측정소 목록 가져오기
	function adjustBranchList()
	{	
		var factCode = $('#factCode').val();
		
		var branchNo = $('#branchNo');
		branchNo.attr("disabled", false);
		var url = "<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>";
		$.getJSON(url, {factCode:factCode}, function (data, status){
			if(status == 'success'){
				branchNo.loadSelect_all(data.branch);
				
				$("#branchNo>option[value="+data.branch[0].VALUE+"]").attr("selected", "selected");
				
				if(!firstFlag){
					reloadData();
					firstFlag = true;
				}
			} else { 
				alert("공구 목록 가져오기 실패");
				return;
			}
		});
		
		//2014-10-27 mypark 검색개선
		$('#factCode').hide();
	}
	
	function adjustBranchListNew()
	{	
		var url = "";
		
		if(user_roleCode == 'ROLE_ADMIN'){
			url = "<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>";
		}else{
			url = "<c:url value='/waterpolmnt/waterinfo/getBranchListNew.do'/>";
		}
		/* 
		var factCode = $('#factCode').val();
		
		var branchNo = $('#branchNo');
		branchNo.attr("disabled", false);
		 */
		var factCode = "";
		var branchNo = "";
		
		if($('#riverDiv option:selected').val() == 'all'){
			$('#factCode option:selected').val('all');
			$('#branchNo').val('all');
			factCode = $('#factCode').val();
			branchNo = $('#branchNo').val();
			$('#branchNo').attr('disabled', true);
		}else{
			factCode = $('#factCode').val();
			branchNo = $('#branchNo');
			branchNo.attr("disabled", false);			
		}
		$.getJSON(url, {factCode:factCode}, function (data, status){
			if(status == 'success'){
				/* 
				branchNo.loadSelect_all(data.branch);
				
				$("#branchNo>option[value="+data.branch[0].VALUE+"]").attr("selected", "selected");
				 */
				if(factCode != 'all'){
					branchNo.loadSelect_all(data.branch);
					$("#branchNo>option[value="+data.branch[0].VALUE+"]").attr("selected", "selected");	
				}else if(factCode == 'all'){
					$("#branchNo>option[value=all]").attr("selected", "selected");	
				}
				if(!firstFlag){
					reloadData();
					firstFlag = true;
				}
			} else { 
				alert("공구 목록 가져오기 실패");
				return;
			}
		});
		
		//2014-10-27 mypark 검색개선
		$('#factCode').hide();
	}
	
	function reloadData(pageNo){
		showLoading();
		
		var riverDiv = $("#riverDiv").val();
		var factCode = $("#factCode").val();
		var branchNo = $("#branchNo").val();
		var searchYear = $("#searchYear").val();
		var searchMonth = $("#searchMonth").val();
		var searchStatus = $("#searchStatus").val();
		var select_year = $("#searchYear").val();
		var select_month = $("#searchMonth").val();
		
		if (pageNo == null) pageNo = 1;
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/goSelectDataHisList.do'/>",
			data:{
					river_div:riverDiv,
					fact_code:factCode,
					branch_no:branchNo,
					searchYear:searchYear,
					searchMonth:searchMonth,
					select_year:select_year,
					select_month:select_month,
					searchStatus:searchStatus,
					pageIndex:pageNo
			},
			dataType:"json",
			success:function(result){
// 				console.log("결과 값 확인 : ",result);
				
				var tot = result['detailViewList'].length;
				var pageInfo = result['paginationInfo'];
				
// 				if(tot == 0 || tot == 1){
// 					$("#main_display").css("height", "55px");
// 				}else if(tot<20){
// 					$("#main_display").css("height", (tot*27)+18 + "px");
// 				}else{
// 					$("#main_display").css("height", "558px");
// 				}
				
				// 조회 데이터 표출
				var html = "";
				var main_html = "";
				
				if( tot <= 0 ){
					main_html += "<tr><td colspan='8'>조회 결과가 없습니다.</td></tr>";
					$("#dateLists").html(main_html);
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['detailViewList'][i];
						var trNo = i+1;
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
						
						var even = "";
						if(i%2 == 1){even = "even"}
						main_html += "	<tr id='tr"+trNo+"' class='tr"+i+"'></>";
						main_html += "		<td>"+no+"</td>";
						main_html += "		<td>"+obj.river_name+"</td>";
						main_html += "		<td>"+obj.branch_name+"</td>";
						main_html += "		<td>"+obj.select_year+"년 "+obj.select_month+"월</td>";
						main_html += "		<td>"+obj.reg_date+"</td>";
						main_html += "		<td>"+obj.reg_name+"</td>";
						if(obj.status == 'E' || obj.status == 'D'){
							main_html += "		<td>"+obj.confirm_name+"</td>";
						}else{
							main_html += "		<td>-</td>";
						}
						if(obj.status == 'C' || obj.status == 'D'){
							main_html += "		<td style='color:#FF0000;cursor:pointer;' onclick=\"javascript:cancelInfoPop(event,'"+obj.sel_his_seq+"');\">"+obj.status_name+"</td>";
						}else{
							main_html += "		<td>"+obj.status_name+"</td>";
						}
						main_html += "	</tr>";
					}
					$("#dateLists").html(main_html);
					$("#div_result tbody tr:odd").addClass("even");	
				}
				
				// 페이징 정보
				var pageStr = makePaginationInfo(result['paginationInfo']);
				$("#pagination").empty();
				$("#pagination").append(pageStr);
				
				$("#p_total_cnt").html("▶ 검색결과 [총 " + result['totCnt'] + "건]");
				
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
				alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				closeLoading();
			}
		});
	}
	
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("layerSelectData");
	}
	
	function abspos(e){
	     this.x = e.clientX + (document.documentElement.scrollLeft?document.documentElement.scrollLeft:document.body.scrollLeft);
	    this.y = e.clientY + (document.documentElement.scrollTop?document.documentElement.scrollTop:document.body.scrollTop);
	    return this;
	 }
	
	function cancelInfoPop(e, sel_his_seq){
		layerPopClose("layerSelectData");
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getCancelDataInfo.do'/>",
			data:{sel_his_seq:sel_his_seq
				},
			dataType:"json",
			success:function(result){
				var item = "";
				var obj = result['cancelDataInfo'][0];
				item += "<tr>"
					+"<td style='text-align:left; padding-left:5px; height:100px; width:300px;'>"+obj.cancel_content+"</td>"
					+"</tr>";
					
				$("#cancelData").html(item);
			},
	        error:function(result){
					$("#cancelData").html("<tr><td style='text-align:center;height:100px; width:300px;'>서버접속 실패</td></tr>");
		        }
		});
		
		var divTop = e.clientY; //상단 좌표
		var divLeft = e.clientX - 280; //좌측 좌표
		
		var name="layerSelectData";
			
		var win = $(window);
		var winH = divTop;
		var winW =divLeft;
		$('#'+ name).css('top', winH);
		$('#'+ name).css('left', winW);
		$('#'+ name).show();
		$('#'+ name).focus();
	}
	function fnSearchMonth(){
		var searchYear = $('#searchYear').val();
		var today = new Date();
		var year = today.getFullYear();
		
		$("select[name='searchMonth']").find('option').each(function() {
		    $(this).remove();
		   });
		
		if(searchYear<year){
			for(var i=1 ; i<13 ; i++){
				var temp_month = "";
				var temp_i;
				
				if(i<10){
					temp_i = "0"+i;
				}else{
					temp_i = i;
				}
				
				temp_month = "<option value='"+temp_i+"'>"+temp_i+"</option>";
				$("#searchMonth").append(temp_month);
			}
		}
		
		if(searchYear==year){
			var month = addzero(today.getMonth() + 1);
			
			if(month=='01'){
				pre_month = 12;
				month = 13;
			}else{
				pre_month = (today.getMonth() + 1)-1;
			}
			
			for(var i=1 ; i<month ; i++){
				var temp_month = "";
				var temp_i;
				if(i<10){
					temp_i = "0"+i;
				}else{
					temp_i = i;
				}
				if(i == pre_month){
					temp_month = "<option value='"+temp_i+"' selected>"+temp_i+"</option>";
				}else{
					temp_month = "<option value='"+temp_i+"'>"+temp_i+"</option>";
				}
				$("#searchMonth").append(temp_month);
			}
		}
	}
	// 페이지 번호 클릭
	function linkPage(pageNo){
		reloadData(pageNo);
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
						
						<!-- 선별 데이터 조회 현황 -->
						<form:form commandName="selectDataVO" name="listFrm"  id="listFrm" method="post">
						<div class="searchBox dataSearch">
							<ul>
								<li>
									<span class="fieldName">측정소 위치</span>
									<select id="riverDiv" class="width70">
										<option value="all">전체</option>
										<option value="R01">한강</option>
										<option value="R02">낙동강</option>
										<option value="R03">금강</option>
										<option value="R04">영산강</option>
									</select>
									 <span style="display:none;">&gt;</span>
									<select id="factCode" class="width110" name="factCode" style="display:none;">
										<option value="all">전체</option>
									</select>
									<span>&gt;</span>
									<select id="branchNo" class="width110" name="branchNo" disabled="disabled">
										<option value="all">전체</option>
									</select>
								</li>
								<li>
									<span class="fieldName">선별기간</span>
									<select name="searchYear" id="searchYear" style="width: 60px" onchange="fnSearchMonth();">
									</select>
									<select name="searchMonth" id="searchMonth" style="width: 50px">
									</select>
								</li>
								<li>
									<span class="fieldName">상태</span>
									<select id="searchStatus" name="searchStatus" class="width70">
										<option value="all">전체</option>
										<option value="S">선별</option>
										<option value="C">선별취소</option>
										<option value="E">확정</option>
										<option value="D">확정취소</option>
									</select>
								</li>
							</ul>
						</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData();" alt="조회하기" style="float:right;"/>
						</div>
						</form:form>
						<!-- //하천 수질 조회 -->

						<div>
							<div id="btArea" style="margin-top:0; border-top:2px;">
								<span id="p_total_cnt">▶ 검색결과 [총 ${totCnt}건]</span>
<!-- 								<input type="button" id="excel" name="excel" class="btn btn_excel" onclick="javascript:excelDown();" alt="엑셀"/> -->
							</div>
							<div id="div_result">
								<div class="table_wrapper">
									<table summary="게시판 목록. 번호, 수계, 지점명, 온도, 습도, 배터리, 접속시간, 위치, 장비상태가 담김">
										<colgroup>
											<col width="80px" />
											<col width="140px" />
											<col width="160px" />
											<col width="120px" />
											<col width="160px" />
											<col width="120px" />
											<col width="100px" />
											<col />
										</colgroup>
										<thead>
											<tr>
												<th scope="col">번호</th>
												<th scope="col">수계</th>
												<th scope="col">측정소</th>
												<th scope="col">선별기간</th>
												<th scope="col">저장/확정일시</th>
												<th scope="col">선별자</th>
												<th scope="col">확정자</th>
												<th scope="col">상태</th>
											</tr>
										</thead>
										<tbody id="dateLists">
										</tbody>
									</table>
								</div>
							</div>
							<div class="paging">
								<div id="page_number">
									<ul class="paginate" id="pagination"></ul>
								</div>
							</div>
							
						</div>
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
	<!-- //선택 수정 레이어 -->
	<div id="layerSelectData" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnSelectDataModXbox" name="btnSelectDataModXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerSelectData');" alt="닫기" />
		</div>
			<table style="width:100%; float:left; text-align:left; margin-bottom:10px" summary="취소사유">
				<colgroup>
					<col width="100%"/>
				</colgroup>
				<tbody id="cancelData"></tbody>
			</table>
	</div>
	<!-- //선택 수정 레이어 -->
</body>
</html>