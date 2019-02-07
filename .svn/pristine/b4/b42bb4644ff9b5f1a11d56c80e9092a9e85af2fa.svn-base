<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : waterDcCenterList.jsp
	 * Description : 취정수장 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2014.02.19	lkh			리뉴얼
	 * 
	 * author lkh 
	 * since 2014.02.19
	 * 
	 * Copyright (C) 2014by lkh  All right reserved.
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
		var dctype = $("#dctype option:selected").val();
		var searchKeyword = $("#searchKeyword").val();
		
		if (pageNo == null) pageNo = 0;
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/waterpolmnt/waterinfo/getWaterDcCenterList.do'/>",
			data: { 
					pageIndex:pageNo,
					sugye:sugye,
					dctype:dctype,
					searchKeyword:searchKeyword
				},
			dataType:"json",
			success : function(result){
				var tot = result['detailViewList'].length;
				var pageInfo = result['paginationInfo'];
				
				if( tot <= 0 ){
					$('#dataList').html("<tr><td colspan='4' class='txtC'>조회 결과가 없습니다.</td></tr>");
				}else{
					var item="";
					for(var i=0; i < tot; i++){
						var obj = result['detailViewList'][i];
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						
						obj.no = no;
						
						item += "<tr style='cursor:pointer;' onclick=\"itemInsert('"+obj.longitude+"','"+obj.latitude+"','"+obj.id+"','"+obj.name+"','"+obj.type+"','"+obj.manage+"','"+obj.manager+"','"+obj.phone+"','"+obj.river_div+"','"+obj.proc_qty+"','"+obj.cont_term+"','"+obj.supply_region+"','"+obj.run_day+"','"+obj.address+"'"+")\">"			                   	 
						+"<td style='text-align:center;'><span>"+obj.no+"</span></td>"
                 		+"<td class='txtL'>"+obj.name+"</td>"
             		 	+"</tr>";

		          		$("#dataList").html(item);
		          		$("#dataList tr:odd").attr("class","even");
					}
				}
				
				// 총건수 표시
				$("#p_total_cnt").html("[총 " + result['totCnt'] + "건]");
				
				itemInsert(result['detailViewList'][0].longitude, result['detailViewList'][0].latitude, result['detailViewList'][0].id, result['detailViewList'][0].name, result['detailViewList'][0].type, result['detailViewList'][0].manage, result['detailViewList'][0].manager, result['detailViewList'][0].phone, result['detailViewList'][0].river_div, result['detailViewList'][0].proc_qty, result['detailViewList'][0].cont_term, result['detailViewList'][0].supply_region, result['detailViewList'][0].run_day, result['detailViewList'][0].address)
				
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
	
	function itemInsert(longitude, latitude, id, name, type, manage, manager, phone, river_div, proc_qty, cont_term, supply_region, run_day, address) {
		var item="";
		
		item += "<tr>"			                   	 
		+"<td style='text-align:center;'>ID</td>"
 		+"<td class='txtL'>"+id+"</td>"
		+"</tr>"
		+"<tr>"			                   	 
		+"<td style='text-align:center;'>시설명</td>"
 		+"<td class='txtL'>"+name+"</td>"
		+"</tr>"
		+"<tr>"			                   	 
		+"<td style='text-align:center;'>구분</td>"
 		+"<td class='txtL'>"+type+"</td>"
		+"</tr>"
		+"<tr>"			                   	 
		+"<td style='text-align:center;'>담당처</td>"
 		+"<td class='txtL'>"+manage+"</td>"
		+"</tr>"
		+"<tr>"			                   	 
		+"<td style='text-align:center;'>담당자</td>"
 		+"<td class='txtL'>"+manager+"</td>"
		+"</tr>"
		+"<tr>"			                   	 
		+"<td style='text-align:center;'>전화번호</td>"
 		+"<td class='txtL'>"+phone+"</td>"
		+"</tr>"
		+"<tr>"			                   	 
		+"<td style='text-align:center;'>관련수계</td>"
 		+"<td class='txtL'>"+river_div+"</td>"
		+"</tr>"
		+"<tr>"			                   	 
		+"<td style='text-align:center;'>시설용량</td>"
 		+"<td class='txtL'>"+proc_qty+"</td>"
		+"</tr>"
		+"<tr>"			                   	 
		+"<td style='text-align:center;'>공구</td>"
 		+"<td class='txtL'>"+cont_term+"</td>"
		+"</tr>"
		+"<tr>"			                   	 
		+"<td style='text-align:center;'>급수지역</td>"
 		+"<td class='txtL'>"+supply_region+"</td>"
		+"</tr>"
		+"<tr>"			                   	 
		+"<td style='text-align:center;'>가동일수</td>"
 		+"<td class='txtL'>"+run_day+"</td>"
		+"</tr>"
		+"<tr>"			                   	 
		+"<td style='text-align:center;'>위도</td>"
 		+"<td class='txtL'>"+latitude+"</td>"
		+"</tr>"
		+"<tr>"			                   	 
		+"<td style='text-align:center;'>경도</td>"
 		+"<td class='txtL'>"+longitude+"</td>"
		+"</tr>"
		+"<tr>"			                   	 
		+"<td style='text-align:center;'>주소</td>"
 		+"<td class='txtL'>"+address+"</td>"
		+"</tr>"
		

  		$("#dataList_Group").html(item);
  		$("#dataList_Group tr:odd").attr("class","even");
	}
	
	function popupMapOpen(){
		var longitude = $("#rlongitude").val();
		var latitude = $("#rlatitude").val();
		
		window.open("/psupport/WPCS_POP.html?riverid=" + user_riverid + "&menuid=dcce&longitude=" + longitude + "&latitude=" + latitude, 
				'psView','width='+window.screen.width+',height='+window.screen.height+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left=0,top=0');
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
									<span class="fieldName">구분</span>
									<select id="dctype">
										<option value="all">선택</option>
										<option value="D">취수장</option>
										<option value="C">정수장</option>
									</select>
								</li>
								<li>
									<span class="fieldName">취정수장명</span>
									<input type="text" id="searchKeyword" name="searchKeyword" value="${searchVO.searchKeyword}" style="width: 195px; ime-mode:active;"/>
								</li>
							</ul>
						</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData();" alt="조회하기" style="float:right;"/>
						</div>
						
						<div class="divisionBx" id="btArea">
							<div class="div40" style="margin-bottom: 15px;">
								<div id="btSmallArea" style="margin-bottom: 10px;">
									<span id="p_total_cnt">[총 ${totCnt}건]</span>
								</div>
								<div  style="overflow-x: hidden; overflow-y: scroll; width: 390px; height: 416px;">
									<table>
										<colgroup>
											<col width="80" />
											<col />
										</colgroup>
										<thead>
										<tr>
											<th scope="col">NO</th>
											<th scope="col">시설명</th>
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
									<span><img src="/images/common/bu_square.gif"></img>&nbsp; 취정수장 상세정보</span>
									<input type="button" id="btnMap" name="btnMap" value="지도보기" class="btn btn_basic" style="margin-top:0px;" onclick='javascript:popupMapOpen()' alt="지도보기"/>
								</div>
								<div  style="overflow-x: hidden; overflow-y: hidden; width: 592px; height: 430px;">
									<table>
										<colgroup>
											<col width="120" />
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