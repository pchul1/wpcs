<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="/gis/css/common.css"/>
<link rel="stylesheet" type="text/css" href="/gis/css/gis_bj.css"/>
<!-- <link rel="stylesheet" href="http://js.arcgis.com/3.8/js/dojo/dijit/themes/claro/claro.css"/> -->
<!-- <link rel="stylesheet" href="http://js.arcgis.com/3.8/js/esri/css/esri.css"/> -->

<!-- <link rel="stylesheet" type="text/css" href="http://mleibman.github.io/SlickGrid/slick.grid.css"/> -->
<link rel="stylesheet" type="text/css" href="/slickgrid/css/slick.grid.css"/>
<link rel="stylesheet" type="text/css" href="/js/JQuery/css/ui.datepicker.css"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript" src="/slickgrid/js/jquery.event.drag-2.2.js"></script>
<script type="text/javascript" src="/slickgrid/js/slick.core.js"></script>
<!-- <script type="text/javascript" src="/slickgrid/js/slick.grid.js"></script> -->
<script type="text/javascript" src="/slickgrid/js/slick.grid_2.2.2.js"></script>
<script type="text/javascript" src="/slickgrid/js/slick.dataview.js"></script>
<script type="text/javascript" src="/slickgrid/js/slick.rowselectionmodel.js"></script>

<script type="text/javascript" src="/gis/js/organictabs.jquery.js"></script>
<script type="text/javascript" src="/gis/js/acco.js"></script>
<script type="text/javascript" src="/gis/js/UI.js"></script>



<!-- <script src="http://js.arcgis.com/3.8/"></script> -->

<script src="/gis/js/define.js"></script>
<script src="/gis/js/common.js"></script>
<!-- <script src="/gis/js/kecoMapSub.js"></script> -->
<script src="/gis/js/new_kecoMapSub.js"></script>
<script src="/gis/js/xml2json.js"></script>
<script src="/gis/js/new_control.js"></script>
<title>수질오염 방제정보 시스템</title>
<style>

/* #map table td img{vertical-align:baseline;} */
#map table {}
#map table tr {}
#map table td {}
#map table td img{}
img{}
/* table td img{vertical-align:super;} */

</style>
<script type="text/javascript">

$(function () {
	
	var dailyWorkAppCheck = '${dailyWorkAppCheck}';

	if(dailyWorkAppCheck=='Y'){
		layerPopOpen('layerApprovalIns');
	}
	
	_CoreMap.init('map',{
		satellite: true,
		measure:true,
		print:true,
		save:true,
		search:true,
		temp:true
	});
});

	var Request = function()
	{
		this.getParameter = function( name )
		{
			var rtnval = '';
			var nowAddress = unescape(location.href);
			var parameters = (nowAddress.slice(nowAddress.indexOf('?')+1,nowAddress.length)).split('&');
			
			for(var i = 0 ; i < parameters.length ; i++)
			{
				var varName = parameters[i].split('=')[0];
				if(varName.toUpperCase() == name.toUpperCase())
				{
					rtnval = parameters[i].split('=')[1];
					break;
				}
			}
			return rtnval;
		}
	}
	
	var request = new Request();

	var user_riverid = request.getParameter('riverid')
</script>
<<<<<<< HEAD
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript" src="/slickgrid/js/jquery.event.drag-2.2.js"></script>
<script type="text/javascript" src="/slickgrid/js/slick.core.js"></script>
<!-- <script type="text/javascript" src="/slickgrid/js/slick.grid.js"></script> -->
<script type="text/javascript" src="/slickgrid/js/slick.grid_2.2.2.js"></script>
<script type="text/javascript" src="/slickgrid/js/slick.dataview.js"></script>
<script type="text/javascript" src="/slickgrid/js/slick.rowselectionmodel.js"></script>

<script type="text/javascript" src="/gis/js/organictabs.jquery.js"></script>
<script type="text/javascript" src="/gis/js/acco.js"></script>
<script type="text/javascript" src="/gis/js/UI.js"></script>

<!-- <script type="text/javascript" src="/gis/gis/jsapi_vsdoc10_v36.js"></script> -->

<script type="text/javascript" src="/gis/js/jquery.dialog.custom.js"></script>
<script type="text/javascript" src="/js/JQuery/ui/ui.datepicker.js"></script>

<!-- <script src="http://js.arcgis.com/3.8/"></script> -->

<script src="/gis/js/define.js"></script>
<script src="/gis/js/common.js"></script>
<script src="/gis/js/new_kecoMap.js"></script>
<script src="/gis/js/xml2json.js"></script>
<script src="/gis/js/new_control.js"></script>

<script type="text/javascript" src="/gis/new_js/lib/proj4.js" ></script>
<script type="text/javascript" src="/gis/new_js/lib/mapEventBus.js" ></script>
<!-- <script type="text/javascript" src="/gis/new_js/lib/ol/ol.js"></script> -->
<script type="text/javascript" src="http://tsauerwein.github.io/ol3/mapbox-gl-js/build/ol.js"></script>
 
<script type="text/javascript" src="/gis/new_js/lib/jsts/jsts.min.js"></script>

<script type="text/javascript" src="/gis/new_js/mapService.js"></script>
<script type="text/javascript" src="/gis/new_js/lib/vworldLayer.js"></script>
<script type="text/javascript" src="/gis/new_js/lib/coreMap.js"></script>


<script>

$(function() {
	
	_CoreMap.init('map',{
		satellite: true,
		measure: true
	});
	
});

</script>
</head>

<body>
<div id="mapBoxBj">
	<div id="map" class="claro"></div>
	<!--우측 상단 버튼 Start-->
<!-- 	<div id="tool"> -->
<!-- 		<div class="tool_bu1"><a href="javascript:$kecoMap.model.generalMap();"	onmouseout="$kecoMap.controller.MM_swapImgRestore('Image1','/gis/images/tool_1_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image1','/gis/images/tool_1_over1.gif',1)" ><img idx="0" src="/gis/images/tool_1_over1.gif" id="Image1" width="42" height="24" border="0"></a></div> -->
<!-- 		<div class="tool_bu1"><a href="javascript:$kecoMap.model.flightMap();"	onmouseout="$kecoMap.controller.MM_swapImgRestore('Image2','/gis/images/tool_2_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image2','/gis/images/tool_2_over1.gif',1)" ><img idx="1" src="/gis/images/tool_2_off.gif" id="Image2" width="42" height="24" border="0"></a></div> -->
<!-- 		<div class="tool_bu2"><a href="javascript:$kecoMap.model.distances();"	onmouseout="$kecoMap.controller.MM_swapImgRestore('Image3','/gis/images/tool_3_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image3','/gis/images/tool_3_over.gif',1)" ><img idx="2" src="/gis/images/tool_3_off.gif" id="Image3" width="58" height="24" border="0"></a></div> -->
<!-- 		<div class="tool_bu2"><a href="javascript:$kecoMap.model.area()"		onmouseout="$kecoMap.controller.MM_swapImgRestore('Image4','/gis/images/tool_4_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image4','/gis/images/tool_4_over.gif',1)" ><img idx="3" src="/gis/images/tool_4_off.gif" id="Image4" width="58" height="24" border="0"></a></div> -->
<!-- <!-- 		<div class="tool_bu1"><a id="printBtn" href="javascript:void(0)"		onmouseout="$kecoMap.controller.MM_swapImgRestore('Image5','/gis/images/tool_5_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image5','/gis/images/tool_5_over.gif',1)" ><img idx="4" src="/gis/images/tool_5_off.gif" id="Image5" width="42" height="24" border="0"></a></div> --> -->
<!-- <!-- 		<div class="tool_bu1"><a id="save" href="javascript:void(0)"			onmouseout="$kecoMap.controller.MM_swapImgRestore('Image6','/gis/images/tool_6_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image6','/gis/images/tool_6_over.gif',1)" ><img idx="5" src="/gis/images/tool_6_off.gif" id="Image6" width="42" height="24" border="0"></a></div> --> -->
<!-- <!-- 		<div class="tool_bu1"><a href="javascript:void(0)"						onmouseout="$kecoMap.controller.MM_swapImgRestore('Image7','/gis/images/tool_7_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image7','/gis/images/tool_7_over.gif',1)" ><img  idx="6" src="/gis/images/tool_7_off.gif" id="Image7" width="42" height="24" border="0"></a></div> --> -->
<!-- 		<div class="tool_bu3"><a href="javascript:$kecoMap.model.clear()"		onmouseout="$kecoMap.controller.MM_swapImgRestore('Image8','/gis/images/tool_8_off.gif')" onmouseover="$kecoMap.controller.MM_swapImage('Image8','/gis/images/tool_8_over.gif',1)" ><img  idx="6" src="/gis/images/tool_8_off.gif" id="Image8" width="42" height="24" border="0"></a></div> -->
<!-- 	</div> -->
	<% 
	String menu = request.getParameter("menuID");
	String display = "";
	if("5120".equals(menu)){
		display = "display:none;";
	}
	%>
	<div id="leftSearchBx" style="<%=display%>">
		<div id="leftSearch">
			<div class="list-wrap">
				<div id="info">
					<span class="title">최근 1년간 사고 내역</span>
					<div class="divscroll" style="height:150px; overflow-y:visible;">
						<div id="slickNullSearch" class="slickNullSearch" style="left:90px; top:110px;">조회 결과가 없습니다.</div>
						<div id="accident_tab" class="table_info" style="height:150px;"></div>
					</div>
					<div class="divideBx"></div>
					<span class="title">사고지점 상하류 측정소 측정값조회</span>
					<div class="tabMenu">
						<div class="wrap on">
							<div class="tab"><a href="javascript:void(0)">상&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;류</a></div>
							<div class="cnt">
								<div class="subBx" id="acc01">
									<h2 class="acc_trigger"><a href="javascript:void(0)">수질자동측정망</a></h2>
									<div class="acc_container">
										<div class="block">
											<div id="stb01" class="stabMenu">
												<div class="swrap son">
													<div class="stab"><a href="javascript:void(0)">외&nbsp;&nbsp;&nbsp;부</a></div>
													<div class="scnt">
														<div class="divscroll">
															<table summary="수질자동측정망외부정보" class="table_info">
																<caption>수질자동측정망 외부</caption>
																<colgroup>
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="40px;" />
																</colgroup>
																<thead>
																	<tr>
																		<th scope="col">시설명</th>
																		<th scope="col">PH</th>
																		<th scope="col">DO</th>
																		<th scope="col">EC</th>
																		<th scope="col" class="last">TOC</th>
																	</tr>
																</thead>
																<tbody id="DG_A_out">
																	<tr>
																		<td></td>
																		<td></td>
																		<td></td>
																		<td></td>
																		<td class="last"></td>
																	</tr>
																</tbody>
															</table>
														</div>
													</div>
												</div>
												<div class="swrap">
													<div class="stab"><a href="javascript:void(0)">내&nbsp;&nbsp;&nbsp;부</a></div>
													<div class="scnt">
														<div class="divscroll">
															<table summary="" class="table_info">
																<caption>수질자동측정망 외부</caption>
																<colgroup>
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="40px;" />
																</colgroup>
																<thead>
																	<tr>
																		<th scope="col">시설명</th>
																		<th scope="col">PH</th>
																		<th scope="col">DO</th>
																		<th scope="col">EC</th>
																		<th scope="col" class="last">TOC</th>
																	</tr>
																</thead>
																<tbody id="DG_A_in">
																	<tr>
																		<td></td>
																		<td></td>
																		<td></td>
																		<td></td>
																		<td class="last"></td>
																	</tr>
																</tbody>
															</table>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<h2 class="acc_trigger"><a href="javascript:void(0)">이동형측정기기</a></h2>
									<div class="acc_container">
										<div class="block">
											<div class="divscroll">
												<table summary="" class="table_info">
													<caption>이동형측정기기</caption>
													<colgroup>
													<col width="" />
													<col width="" />
													<col width="" />
													</colgroup>
													<thead>
														<tr>
															<th scope="col">시설명</th>
															<th scope="col">PH</th>
															<th scope="col">DO</th>
															<th scope="col">EC</th>
															<th scope="col">수온</th>
															<th scope="col" class="last">탁도</th>
														</tr>
													</thead>
													<tbody id="DG_U">
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
								<div class="mt10">
									<span class="title">사고지점 상류댐 수치 조회</span>
									<div class="divscroll" style="height:120px;">
										<table summary="" class="table_info">
											<caption>사고지점 상류댐 수치</caption>
											<colgroup>
											<col width="" />
											<col width="" />
											<col width="" />
											<col width="" />
											<col width="" />
											</colgroup>
											<thead>
												<tr>
													<th scope="col">댐명</th>
													<th scope="col" class="last">TEL</th>
													<th scope="col">저수위</th>
													<th scope="col">유입량</th>
													<th scope="col">방류량</th>
													<th scope="col" class="last">공용량</th>
												</tr>
											</thead>
											<tbody id="dam_tab">
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						<div class="wrap">
							<div class="tab"><a href="javascript:void(0)">하&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;류</a></div>
							<div class="cnt">
								<div class="subBx" id="acc02">
									<h2 class="acc_trigger"><a href="javascript:void(0)">수질자동측정망</a></h2>
									<div class="acc_container">
										<div class="block">
											<div id="stb02" class="stabMenu" >
												<div class="swrap son">
													<div class="stab"><a href="javascript:void(0)">외&nbsp;&nbsp;&nbsp;부</a></div>
													<div class="scnt">
														<div class="divscroll">
															<table summary="" class="table_info">
																<caption>수질자동측정망 외부</caption>
																<colgroup>
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="40px;" />
																</colgroup>
																<thead>
																	<tr>
																		<th scope="col">시설명</th>
																		<th scope="col">PH</th>
																		<th scope="col">DO</th>
																		<th scope="col">EC</th>
																		<th scope="col" class="last">TOC</th>
																	</tr>
																</thead>
																<tbody id="DG_Adn_out">
																</tbody>
															</table>
														</div>
													</div>
												</div>
												<div class="swrap">
													<div class="stab"><a href="javascript:void(0)">내&nbsp;&nbsp;&nbsp;부</a></div>
													<div class="scnt">
														<div class="divscroll">
															<table summary="" class="table_info">
																<caption>수질자동측정망 내부</caption>
																<colgroup>
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="40px;" />
																</colgroup>
																<thead>
																	<tr>
																		<th scope="col">시설명</th>
																		<th scope="col">PH</th>
																		<th scope="col">DO</th>
																		<th scope="col">EC</th>
																		<th scope="col" class="last">TOC</th>
																	</tr>
																</thead>
																<tbody id="DG_Adn_in">
																</tbody>
															</table>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<h2 class="acc_trigger"><a href="javascript:void(0)">이동형측정기기</a></h2>
									<div class="acc_container">
										<div class="block">
											<div class="divscroll">
												<table summary="" class="table_info">
													<caption>이동형측정기기</caption>
													<colgroup>
													<col width="" />
													<col width="" />
													<col width="" />
													</colgroup>
													<thead>
														<tr>
															<th scope="col">시설명</th>
															<th scope="col">PH</th>
															<th scope="col">DO</th>
															<th scope="col">EC</th>
															<th scope="col">수온</th>
															<th scope="col" class="last">탁도</th>
														</tr>
													</thead>
													<tbody id="DG_Udn">
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
								<div class="mt10">
									<span class="title">사고지점 하류 취정수장 수치 조회</span>
									<div class="divscroll" style="height: 120px;">
										<table summary="" class="table_info">
											<caption>사고지점 상류댐 수치</caption>
											<colgroup>
											<col width="60" />
											<col width="50" />
											<col width="" />
											<col width="70" />
											</colgroup>
											<thead>
												<tr>
													<th scope="col">취수장명</th>
													<th scope="col">담당자</th>
													<th scope="col">처리용량(㎡/일)</th>
													<th scope="col" class="last">TEL</th>
												</tr>
											</thead>
											<tbody id="wc_tab">
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div style="margin-left:2px;">
						<div id="stb03" class="stabMenu">
							<div class="swrap son">
								<div class="stab"><a href="javascript:void(0)">방제업체</a></div>
								<div class="scnt h130">
									<div class="topBx mb5">
<!-- 									반경검색 : <select style="width:100px" id="C_radius"> -->
<!-- 										<option value="30">30Km</option> -->
<!-- 										<option value="40">40Km</option> -->
<!-- 										<option value="50">50Km</option> -->
<!-- 										<option value="60">60Km</option> -->
<!-- 										<option value="70">70Km</option> -->
<!-- 										<option value="80">80Km</option> -->
<!-- 										<option value="90">90Km</option> -->
<!-- 										<option value="100">100Km</option> -->
<!-- 									</select>  -->
										<input type="button" id="searchEcomBtn" value="검색" class="btn btn_basic" />
									</div>
									<div class="divscroll" style="height:138px;">
										<table summary="" class="table_info">
											<caption>수질자동측정망 외부</caption>
											<colgroup>
											<col width="" />
											<col width="" />
											<col width="" />
											<col width="40px;" />
											</colgroup>
											<thead>
												<tr>
													<th scope="col">수계</th>
													<th scope="col">시설명</th>
													<th scope="col" class="last">연락처</th>
												</tr>
											</thead>
											<tbody id="do_tab">
											</tbody>
										</table>
									</div>
								</div>
							</div>
							
							<div class="swrap">
								<div class="stab"><a href="javascript:void(0)">방제창고</a></div>
								<div class="scnt h130" >
									<div class="topBx mb5">
										<input type="button" id="searchWhBtn" value="검색" class="btn btn_basic" />
									</div>
									<div class="divscroll" style="height:138px;">
										<table summary="" class="table_info">
											<caption>수질자동측정망 외부</caption>
											<colgroup>
											<col width="" />
											<col width="" />
											<col width="" />
											</colgroup>
											<thead>
												<tr>
													<th scope="col">창고명</th>
													<th scope="col">관리자</th>
													<th scope="col" class="last">연락처</th>
												</tr>
											</thead>
											<tbody id="wh_tab">
											</tbody>
										</table>
									</div>
								</div>
							</div>
							
							<div class="swrap">
								<div class="stab"><a href="javascript:void(0)">오염원</a></div>
								<div class="scnt h130" >
									<div class="topBx mb5"><input type="button" id="searchFacBtn" value="검색" class="btn btn_basic" /></div>
									<div class="divscroll" style="height:138px;">
										<table summary="" class="table_info">
											<caption>수질자동측정망 외부</caption>
											<colgroup>
											<col width="" />
											<col width="" />
											<col width="" />
											<col width="40px;" />
											</colgroup>
											<thead>
												<tr>
													<th scope="col">점오염원</th>
													<th scope="col">수계</th>
													<th scope="col" class="last">주소</th>
												</tr>
											</thead>
											<tbody id="fac_tab">
												<tr>
													<td></td>
													<td></td>
													<td class="last"></td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
							
							
							<div class="swrap">
								<div class="stab"><a href="javascript:void(0)">도달시간</a></div>
								<div class="scnt h130" >
									<div class="topBx mb5" id="r01SelDiv">
				 						 구간 :
										<select id="r01Sel_sec" style="width:80px">
											<option value="전체">전체</option>
											<option value="화천~춘천">화천~춘천</option>
											<option value="춘천~의암">춘천~의암</option>
											<option value="의암~청평">의암~청평</option>
											<option value="청평~팔당">청평~팔당</option>
											<option value="충주~여주">충주~여주</option>
											<option value="여주~팔당">여주~팔당</option>
										</select>
										 유량 :
										<select id="r01Sel_flux" style="width:80px">
											<option value="전체">전체</option>
											<option value="1000">1000</option>
											<option value="2000">2000</option>
											<option value="3000">3000</option>
											<option value="5000">5000</option>
											<option value="7000">7000</option>
											<option value="10000">10000</option>
											<option value="15000">15000</option>
										</select>
									</div>
									<label id="unitLabel">단위 [유량 - 톤/일],[거리 - km],[도달시간 - 시:분]</label>
									<div class="divscroll" style="height:122px;">
										<table summary="" class="table_info">
											<caption>수질자동측정망 외부</caption>
											<colgroup>
												<col width="" />
												<col width="" />
												<col width="" />
												<col width="40px;" />
											</colgroup>
											<thead id="arrivalHd">
												<tr>
													<th scope="col">구간</th>
													<th scope="col">유량</th>
													<th scope="col">거리</th>
													<th scope="col" class="last">시간</th>
												</tr>
											</thead>
											<tbody id="arrival_tab">
												<tr>
													<td></td>
													<td></td>
													<td></td>
													<td class="last"></td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="search" class="hide">
					<span class="title">검색조건</span>
					<div id="search_terms">
						<ul>
							<li>
								<span>수계</span>
								<select id="selRDiv" style="width:180px">
								</select>
							</li>
							<li>
								<span>기간</span>
								<input type="text" id="startDate"  size="13" alt="조회시작일" style="width: 67px"/>-
								<input type="text" id="endDate" size="13" alt="조회종료일" style="width: 67px"/>
							</li>
							<li>
								<span>사고유형</span>
								<select id="selEventType" style="width:180px">
									<option value="all">전체</option>
									<option value="PA">유류유출</option>
									<option value="PB">물고기폐사</option>
									<option value="PC">화학물질</option>
									<option value="PD">기타</option>
									<option value="PT">테스트</option>
								</select>
							</li>
							<li>
								<span>방제현황</span>
								<select id="selStep" style="width:180px">
									<option value="all">전체</option>
									<option value="RCV">접수</option>
									<option value="ING">수습중</option>
									<option value="END">조치완료</option>
								</select>
							</li>
						</ul>
						<div class="btArea">
							<input type="button" id="acSearBtn" value="조회" class="btn_search" />
						</div>
					</div>
				</div>
				<div id="chk" class="hide">	
					<span class="title">측정소 정보</span>
					<div id="chkInfoBx" style="overflow: auto; height: 800px;"></div>
				</div>
			</div>
			<ul class="nav">
				<li class="nav-three"><a href="#chk"><img src="/gis/images/tab_txt3.png" alt="측정소"/></a></li>
				<li class="nav-two"><a href="#search"><img src="/gis/images/tab_txt2.png" alt="검색"/></a></li>
				<li class="nav-one"><a href="#info" class="current"><img src="/gis/images/tab_txt1.png" alt="정보"/></a></li>
			</ul>
		</div>
		<div id="searchToggle"><img src="/gis/images/toggle_in.png" alt="닫기"/></div>
	</div>
	<!--좌측 검색패널 End-->
	<!--우측 패널 Start-->
	<div id="rightBx">
		<div class="rightIn" id="acc03">
			<h2 class="acc_trigger"><a href="javascript:void(0)">이동형측정기기 위치정보</a></h2>
			<div class="h100p">
				<div class="block2">
					<div id="stb04" class="stabMenu">
						<div class="swrap son">
							<div class="stab"><a href="javascript:void(0)">기준위치 이탈정보</a></div>
							<div class="scnt" style="height:400px;">
								<div class="topBx tleft mb5">
									<input type="button" id="refreshOutIpusnBtn" value="새로고침" class="btn btn_basic" />
									<div class="fright">[단위:V(Vlot) 최대충전량:12V]</div>
								</div>
								<div class="divscroll">
									<table summary="" class="table_info">
										<caption></caption>
										<colgroup>
										<col width="" />
										<col width="" />
										<col width="" />
										<col width="40px;" />
										</colgroup>
										<thead>
											<tr>
												<th scope="col">시설명</th>
												<th scope="col">배터리</th>
												<th scope="col" class="last">최종수신시간</th>
											</tr>
										</thead>
										<tbody id="outIpusn_tab"></tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="swrap">
							<div class="stab"><a href="javascript:void(0)">실시간 현재위치정보</a></div>
							<div class="scnt"  style="height:400px;">
								<div class="topBx tleft mb5">
<!-- 									<input type="button" name="" value="on" class="btn btn_basic" /> -->
									<input type="button" id="refreshIpusnBtn" value="새로고침" class="btn btn_basic" />
									<div class="fright">[단위:V(Vlot)]</div>
								</div>
								<div class="divscroll">
									<table summary="" class="table_info">
										<caption>수질자동측정망 외부</caption>
										<colgroup>
										<col width="" />
										<col width="" />
										<col width="" />
										<col width="40px;" />
										</colgroup>
										<thead>
											<tr>
												<th scope="col">시설명</th>
												<th scope="col">배터리</th>
												<th scope="col" class="last">최종수신시간</th>
											</tr>
										</thead>
										<tbody id="ipusn_tab"></tbody>
									</table>
								</div>
							</div>
						</div>
					</div>	
				</div>
			</div>
		</div>
		<div id="rightToggle"><img src="/gis/images/toggle_rin.png" alt="닫기"/></div>
	</div>
	<!--우측 패널 End-->

	<!--우측 범례패널 Start-->
	<div id="berm">
		<ul>
			<li><span class="point1"></span>&nbsp;정상</li>
			<li><span class="point2"></span>&nbsp;관심</li>
			<li><span class="point3"></span>&nbsp;주의</li>
			<li><span class="point4"></span>&nbsp;경계</li>
			<li><span class="point5"></span>&nbsp;심각</li>
			<li><span class="point6"></span>&nbsp;미수집</li>
			<li><span class="point7"></span>&nbsp;점검중</li>
		</ul>
	</div>
	<!--우측 범례패널 End-->
	
	<!--상단 패널 Start-->
	<div id="topBx">
		<div class="tTit">반경검색</div>
		<div class="tOut">
			<div  class="tIn">
				<div class="mb5">50Km</div>
				<div id="slider3"></div>
				<div class="mt10 mb5" style="height:20px;">
					<ul><li style="float:left;">10km</li><li style="float:right;">100km</li></ul>
				</div>
<!-- 				<input type="button" name="" value="확인" class="btn btn_basic" /> -->
			</div>
			<div id="tpToggle"><img src="/gis/images/toggle_tin.png" alt="닫기"/></div>
		</div>
	</div>
		
	<!--경단 패널 End-->
	<!--하단 패널 Start-->
	<div id="bottomBx">
		<div id="slickNullSearch1" class="slickNullSearch" style="left:320px; top:110px;">조회 결과가 없습니다.</div>
		<div id="btToggle"><img src="/gis/images/toggle_bin.png" alt="닫기"/></div>
		<div class="btIn">
			<div id="accidentSear_tab" class="table_info" style="height:200px;"></div>
		</div>
	</div>
</div>

</body>
</html>