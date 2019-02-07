<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : damList.jsp
	 * Description : 댐 정보 화면
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
			url: "<c:url value='/waterpolmnt/waterinfo/getDamList.do'/>",
			data: { 
					pageIndex:pageNo,
					sugye:sugye,
					searchKeyword:searchKeyword
				},
			dataType:"json",
			success : function(result){
// 				console.log("결과 값 확인 : ",result);
				
				var tot = result['detailViewList'].length;
				var pageInfo = result['paginationInfo'];
				
				if( tot <= 0 ){
					$('#dataList').html("<tr><td colspan='2' class='txtC'>조회 결과가 없습니다.</td></tr>");
				}else{
					var item="";
					for(var i=0; i < tot; i++){
						var obj = result['detailViewList'][i];
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						
						obj.no = no;
						
						item += "<tr style='cursor:pointer;' onclick=\"itemInsert('"+obj.id+"','"+obj.name+"','"+obj.manage+"','"+obj.manage_phone+"','"+obj.etc_manage+"','"+obj.etc_phone+"','"+obj.river_div+"','"+obj.ngi_manage+"','"+obj.ngi_phone+"','"+obj.river_nm+"','"+obj.type+"','"+obj.kind+"','"+obj.l_bank_address+"','"+obj.r_bank_address+"','"+obj.height+"','"+obj.length+"','"+obj.volume+"','"+obj.altitude+"','"+obj.basin_area+"','"+obj.store_area+"','"+obj.basin_annual_inflow+"','"+obj.basin_annual_rainfall+"','"+obj.planed_flood_level+"','"+obj.normal_full_level+"','"+obj.normal_full_level_volume+"','"+obj.flood_limit_level+"','"+obj.flood_control_volume+"','"+obj.store_wlevel_volume+"','"+obj.supply_enable_wlevel+"','"+obj.total_store+"','"+obj.valid_store+"','"+obj.minimum_store+"','"+obj.emergency_supply+"','"+obj.reservoir_length+"','"+obj.designed_flood+"','"+obj.minimum_wl+"','"+obj.discharge_wl+"','"+obj.latitude+"','"+obj.longitude+"','"+obj.address+"'"+")\">"			                   	 
						+"<td style='text-align:center;'><span>"+obj.no+"</span></td>"
                 		+"<td class='txtL'>"+obj.name+"</td>"
             		 	+"</tr>";

		          		$("#dataList").html(item);
		          		$("#dataList tr:odd").attr("class","even");
					}
					
					
					itemInsert(result['detailViewList'][0].id, result['detailViewList'][0].name, result['detailViewList'][0].manage, result['detailViewList'][0].manage_phone, result['detailViewList'][0].etc_manage, result['detailViewList'][0].etc_phone, result['detailViewList'][0].river_div, result['detailViewList'][0].ngi_manage, result['detailViewList'][0].ngi_phone, result['detailViewList'][0].river_nm, result['detailViewList'][0].type, result['detailViewList'][0].kind, result['detailViewList'][0].l_bank_address, result['detailViewList'][0].r_bank_address, result['detailViewList'][0].height, result['detailViewList'][0].length, result['detailViewList'][0].volume, result['detailViewList'][0].altitude, result['detailViewList'][0].basin_area, result['detailViewList'][0].store_area, result['detailViewList'][0].basin_annual_inflow, result['detailViewList'][0].basin_annual_rainfall, result['detailViewList'][0].planed_flood_level, result['detailViewList'][0].normal_full_level, result['detailViewList'][0].normal_full_level_volume, result['detailViewList'][0].flood_limit_level, result['detailViewList'][0].flood_control_volume, result['detailViewList'][0].store_wlevel_volume, result['detailViewList'][0].supply_enable_wlevel, result['detailViewList'][0].total_store, result['detailViewList'][0].valid_store, result['detailViewList'][0].minimum_store, result['detailViewList'][0].emergency_supply, result['detailViewList'][0].reservoir_length, result['detailViewList'][0].designed_flood, result['detailViewList'][0].minimum_wl, result['detailViewList'][0].discharge_wl, result['detailViewList'][0].latitude, result['detailViewList'][0].longitude, result['detailViewList'][0].address);
				}
				// 페이징 정보
//				var pageStr = makePaginationInfo(result['paginationInfo']);
//				$("#pagination").empty();
//				$("#pagination").append(pageStr);
				
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
	
	function itemInsert(id, name, manage, manage_phone, etc_manage, etc_phone, river_div, ngi_manage, ngi_phone, river_nm, type, kind, l_bank_address, r_bank_address, height, length, volume, altitude, basin_area, store_area, basin_annual_inflow, basin_annual_rainfall, planed_flood_level, normal_full_level, normal_full_level_volume, flood_limit_level, flood_control_volume, store_wlevel_volume, supply_enable_wlevel, total_store, valid_store, minimum_store, emergency_supply, reservoir_length, designed_flood, minimum_wl, discharge_wl, latitude, longitude, address) 
	{
		//지도보기 참조
		$("#rlongitude").val(longitude)
		$("#rlatitude").val(latitude);
		
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
			+"<td style='text-align:center;'>관할기관</td>"
	 		+"<td class='txtL'>"+manage+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>관할기관연락처</td>"
	 		+"<td class='txtL'>"+manage_phone+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>기타연락처명</td>"
	 		+"<td class='txtL'>"+etc_manage+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>기타연락처</td>"
	 		+"<td class='txtL'>"+etc_phone+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>관련수계</td>"
	 		+"<td class='txtL'>"+river_div+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>국토부연락처명</td>"
	 		+"<td class='txtL'>"+ngi_manage+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>국토부연락처</td>"
	 		+"<td class='txtL'>"+ngi_phone+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>하천명</td>"
	 		+"<td class='txtL'>"+river_nm+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>댐형식</td>"
	 		+"<td class='txtL'>"+type+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>댐종류</td>"
	 		+"<td class='txtL'>"+kind+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>좌안주소</td>"
	 		+"<td class='txtL'>"+l_bank_address+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>우안주소</td>"
	 		+"<td class='txtL'>"+r_bank_address+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>댐높이(m)</td>"
	 		+"<td class='txtL'>"+height+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>댐길이</td>"
	 		+"<td class='txtL'>"+length+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>댐체적(천㎥)</td>"
	 		+"<td class='txtL'>"+volume+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>정상표고(m)</td>"
	 		+"<td class='txtL'>"+altitude+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>유역면적(㎢)</td>"
	 		+"<td class='txtL'>"+basin_area+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>저수면적(㎢)</td>"
	 		+"<td class='txtL'>"+store_area+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>연평균유입량(CMS)</td>"
	 		+"<td class='txtL'>"+basin_annual_inflow+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>연평균강우량(mm)</td>"
	 		+"<td class='txtL'>"+basin_annual_rainfall+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>계획홍수위(m)</td>"
	 		+"<td class='txtL'>"+planed_flood_level+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>상시만수위(m)</td>"
	 		+"<td class='txtL'>"+normal_full_level+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>상시만수위용량(백만㎥)</td>"
	 		+"<td class='txtL'>"+normal_full_level_volume+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>홍수기제한수위(m)</td>"
	 		+"<td class='txtL'>"+flood_limit_level+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>홍수조절용량(백만㎥)</td>"
	 		+"<td class='txtL'>"+flood_control_volume+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>저수위용량(백만㎥)</td>"
	 		+"<td class='txtL'>"+store_wlevel_volume+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>용수공급가능수위(m)</td>"
	 		+"<td class='txtL'>"+supply_enable_wlevel+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>총저수용량(백만㎥)</td>"
	 		+"<td class='txtL'>"+total_store+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>유효저수용량(백만㎥)</td>"
	 		+"<td class='txtL'>"+valid_store+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>사수용량(백만㎥)</td>"
	 		+"<td class='txtL'>"+minimum_store+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>비상용수공급량(백만㎥)</td>"
	 		+"<td class='txtL'>"+emergency_supply+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>저수지길이(m)</td>"
	 		+"<td class='txtL'>"+reservoir_length+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>설계홍수량(백만㎥)</td>"
	 		+"<td class='txtL'>"+designed_flood+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>사수위(m)</td>"
	 		+"<td class='txtL'>"+minimum_wl+"</td>"
			+"</tr>"
			+"<tr>"
			+"<td style='text-align:center;'>방수위(m)</td>"
	 		+"<td class='txtL'>"+discharge_wl+"</td>"
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
		
		window.open("/psupport/WPCS_POP.html?riverid=" + user_riverid + "&menuid=dam&longitude=" + longitude + "&latitude=" + latitude,
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
								<span class="fieldName">댐명</span>
								<input type="text" id="searchKeyword" name="searchKeyword" value="${searchVO.searchKeyword}" style="width: 195px; ime-mode:active;"/>
							</li>
						</ul>
					</div>
					<div class="btnSearchDiv">
						<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData();" alt="조회하기" style="float:right;"/>
					</div>
					<div class="divisionBx" id="btArea">
						<div class="div40">
						
							<div id="btSmallArea">
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
										<th scope="col">댐명</th>
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
							<div id="btSmallArea">
								<span><img src="/images/common/bu_square.gif"></img>&nbsp; 댐 상세정보</span>
								<input type="button" id="btnMap" name="btnMap" value="지도보기" class="btn btn_basic" onclick='javascript:popupMapOpen()' alt="지도보기"/>
								
							</div>
							<div  style="overflow-x: hidden; overflow-y: scroll; width: 592px; height: 443px;">
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