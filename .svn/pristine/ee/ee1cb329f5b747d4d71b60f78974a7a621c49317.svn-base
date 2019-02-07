<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : beamList.jsp
	 * Description : 보 목록 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2014.02.19	lkh			리뉴얼
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
	});
	
	// 데이터 목록 불러오기
	function reloadData(pageNo){
		showLoading();
		//수계
		var sugye = $("#sugye option:selected").val();
		var searchKeyword = $("#searchKeyword").val();
		
		if (pageNo == null) pageNo = 0;
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/waterpolmnt/waterinfo/getBoObsInfoList.do'/>",
			data: { 
					pageIndex:pageNo,
					sugye:sugye,
					searchKeyword:searchKeyword
				},
			dataType:"json",
			success : function(result){
// 				console.log("결과 값 확인 : ",result);
				
				var tot = result['resultList'].length;
				var pageInfo = result['paginationInfo'];
				
				if( tot <= 0 ){
					$('#dataList').html("<tr><td colspan='2' class='txtC'>조회 결과가 없습니다.</td></tr>");
				}else{
					var item="";
					for(var i=0; i < tot; i++){
						var obj = result['resultList'][i];
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						
						obj.no = no;
						
						item += "<tr style='cursor:pointer;' onclick=\"itemInsert('"+obj.boobscd+"','"+obj.obsnm+"','"+obj.river_div+"','"+obj.agccd+"','"+obj.hgt+"','"+obj.bsnara+"','"+obj.pfh+"','"+obj.pfhcpc+"','"+obj.totstrcpc+"','"+obj.fbscd+"','"+obj.spcwl+"','"+obj.hlmwl+"','"+obj.llmwl+"','"+obj.stqty+"','"+obj.spccpc+"','"+obj.llmcpc+"','"+obj.gtty+"','"+obj.gtelm+"','"+obj.egty+"','"+obj.egusqty+"','"+obj.fwty+"','"+obj.fwusqty+"'"+")\">"                   	 
						+"<td style='text-align:center;'><span>"+obj.no+"</span></td>"
                 		+"<td class='txtL'>"+obj.obsnm+"</td>"
             		 	+"</tr>";

		          		$("#dataList").html(item);
		          		$("#dataList tr:odd").attr("class","even");
					}
					
					itemInsert(result['resultList'][0].boobscd, result['resultList'][0].obsnm, result['resultList'][0].river_div, result['resultList'][0].agccd, result['resultList'][0].hgt, result['resultList'][0].bsnara, result['resultList'][0].pfh, result['resultList'][0].pfhcpc, result['resultList'][0].totstrcpc, result['resultList'][0].fbscd, result['resultList'][0].spcwl, result['resultList'][0].hlmwl, result['resultList'][0].llmwl, result['resultList'][0].stqty, result['resultList'][0].spccpc, result['resultList'][0].llmcpc, result['resultList'][0].gtty, result['resultList'][0].gtelm, result['resultList'][0].egty, result['resultList'][0].egusqty, result['resultList'][0].fwty, result['resultList'][0].fwusqty);
				}
				
				// 총건수 표시
				$("#p_total_cnt").html("[총 "+result['paginationInfo'].totalRecordCount+"건]");
				
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
		$("#lon").val(lon);
		$("#lat").val(lat);
		$("#addr").val(addr.replace('한국 ',''));
	}
	
	function itemInsert(boobscd, obsnm, river_div, agccd, hgt, bsnara, pfh, pfhcpc, totstrcpc, fbscd, spcwl, hlmwl, llmwl, stqty, spccpc, llmcpc, gtty, gtelm, egty, egusqty, fwty, fwusqty) {
		var item="";
		
		item += "<tr>"			                   	 
			+"<td style='text-align:center;'>ID</td>"
	 		+"<td class='txtL'>"+boobscd+"</td>"
			+"</tr>"
			+"<tr>"			                   	 
			+"<td style='text-align:center;'>보명</td>"
	 		+"<td class='txtL'>"+obsnm+"</td>"
			+"</tr>"
			+"<tr>"			                   	 
			+"<td style='text-align:center;'>관련수계</td>"
	 		+"<td class='txtL'>"+river_div+"</td>"
			+"</tr>"
			+"<tr>"			                   	 
			+"<td style='text-align:center;'>관리기관코드</td>"
	 		+"<td class='txtL'>"+agccd+"</td>"
			+"</tr>"
			+"<tr>"			                   	 
			+"<td style='text-align:center;'>높이(단위:m)</td>"
	 		+"<td class='txtL'>"+hgt+"</td>"
			+"</tr>"
			+"<tr>"			                   	 
			+"<td style='text-align:center;'>유역면적(단위:km^2)</td>"
	 		+"<td class='txtL'>"+bsnara+"</td>"
			+"</tr>"
			+"<tr>"			                   	 
			+"<td style='text-align:center;'>계획홍수위(단위:m)</td>"
	 		+"<td class='txtL'>"+pfh+"</td>"
			+"</tr>"
			+"<tr>"			                   	 
			+"<td style='text-align:center;'>계획홍수위_용량(단위:백만m^3)</td>"
	 		+"<td class='txtL'>"+pfhcpc+"</td>"
			+"</tr>"
			+"<tr>"			                   	 
			+"<td style='text-align:center;'>총 저수용량(단위:백만m^3)</td>"
	 		+"<td class='txtL'>"+totstrcpc+"</td>"
			+"</tr>"
			+"<tr>"			                   	 
			+"<td style='text-align:center;'>예보유역코드</td>"
	 		+"<td class='txtL'>"+fbscd+"</td>"
			+"</tr>"
			+"<tr>"			                   	 
			+"<td style='text-align:center;'>관리수위(EL.m)</td>"
	 		+"<td class='txtL'>"+spcwl+"</td>"
			+"</tr>"
			+"<tr>"			                   	 
			+"<td style='text-align:center;'>상한수위(EL.m)</td>"
	 		+"<td class='txtL'>"+hlmwl+"</td>"
			+"</tr>"
			+"<tr>"			                   	 
			+"<td style='text-align:center;'>하한수위(EL.m)</td>"
	 		+"<td class='txtL'>"+llmwl+"</td>"
			+"</tr>"
			+"<tr>"			                   	 
			+"<td style='text-align:center;'>갈수위(EL.m)</td>"
	 		+"<td class='txtL'>"+stqty+"</td>"
			+"</tr>"
			+"<tr>"			                   	 
			+"<td style='text-align:center;'>관리수위 저수용량(백만m^3)</td>"
	 		+"<td class='txtL'>"+spccpc+"</td>"
			+"</tr>"
			+"<tr>"			                   	 
			+"<td style='text-align:center;'>하한수위 저수용량(백만m^3)</td>"
	 		+"<td class='txtL'>"+llmcpc+"</td>"
			+"</tr>"
			+"<tr>"			                   	 
			+"<td style='text-align:center;'>수문부(가동보) 형식</td>"
	 		+"<td class='txtL'>"+gtty+"</td>"
			+"</tr>"
			+"<tr>"			                   	 
			+"<td style='text-align:center;'>수문부(가동보) 월류언 표고(EL.m)</td>"
	 		+"<td class='txtL'>"+gtelm+"</td>"
			+"</tr>"
			+"<tr>"			                   	 
			+"<td style='text-align:center;'>소수력 형식</td>"
	 		+"<td class='txtL'>"+egty+"</td>"
			+"</tr>"
			+"<tr>"			                   	 
			+"<td style='text-align:center;'>소수력 사용수량(m^3/sec)</td>"
	 		+"<td class='txtL'>"+egusqty+"</td>"
			+"</tr>"
			+"<tr>"			                   	 
			+"<td style='text-align:center;'>어도 형식</td>"
	 		+"<td class='txtL'>"+fwty+"</td>"
			+"</tr>"
			+"<tr>"			                   	 
			+"<td style='text-align:center;'>어도 사용수량(m^3/sec)</td>"
	 		+"<td class='txtL'>"+fwusqty+"</td>"
			+"</tr>"
		

  		$("#dataList_Group").html(item);
  		$("#dataList_Group tr:odd").attr("class","even");
  		
	}
	
	function popupMapOpen(){
		var longitude = $("#longitude").val();
		var latitude = $("#latitude").val();
		
		window.open("/psupport/WPCS_POP.html?riverid=" + user_riverid + "&menuid=boob&longitude=" + longitude + "&latitude=" + latitude,
				'wpcsView','width='+window.screen.width+',height='+window.screen.height+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left=0,top=0');
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
									<span class="fieldName">보명</span>
									<input type="text" id="searchKeyword" name="searchKeyword" value="${searchVO.searchKeyword}" style="width: 195px; ime-mode:active;"/>
								</li>
							</ul>
						</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData();" alt="조회하기" style="float:right;"/>
						</div>
						
						<div class="divisionBx" id="btArea" style="margin-top: 0px;">
							<div class="div40" style="margin-bottom: 15px;">
								<div id="btSmallArea" style="margin-bottom: 10px;">
									<span id="p_total_cnt">[총 ${totCnt}건]</span>
								</div>
								<div  style="overflow-x: hidden; overflow-y: scroll; width: 390px; height: 443px;">
									<table>
										<colgroup>
											<col width="80" />
											<col />
										</colgroup>
										<thead>
										<tr>
											<th scope="col">NO</th>
											<th scope="col">보명</th>
										</tr>
										</thead>
										<tbody  id="dataList">
										<tr>
											<td colspan="2" class='txtC'>조회 결과가 없습니다.</td>
										</tr>
										</tbody>
									</table>
								</div>
							</div>
							
							<div class="div60">
								<input type="hidden" id="rlongitude" name="rlongitude" value="" />
								<input type="hidden" id="rlatitude" name="rlatitude" value="" />
								<div id="btSmallArea" style="margin-bottom: 10px;">
									<span><img src="/images/common/bu_square.gif"></img>&nbsp; 보 상세정보</span>
<!-- 									 현재 위도, 경도 값이 DB에 없어 지도보기 막음. -->
<!-- 									<input type="button" id="btnMap" name="btnMap" value="지도보기" class="btn btn_basicM" style="margin-top:0px;" onclick='javascript:popupMapOpen()' alt="지도보기"/> -->
								</div>
								<div  style="overflow-x: hidden; overflow-y: scroll; width: 592px; height: 443px;">
									<table>
										<colgroup>
											<col width="300" />
											<col />
										</colgroup>
										<thead>
										<tr>
											<th scope="col">구분</th>
											<th scope="col">내용</th>
										</tr>
										</thead>
										<tbody  id="dataList_Group">
										<tr>
											<td colspan="2" class='txtC'>조회 결과가 없습니다.</td>
										</tr>
										</tbody>
									</table>
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
</body>
</html>