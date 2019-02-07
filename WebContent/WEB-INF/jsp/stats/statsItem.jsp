<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : statsItem.jsp
	 * Description : Stats Item 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2010.05.20	k			최초 생성
	 *
	 * author k
	 * since 2010.05.20
	 *  
	 * Copyright (C) 2010 by k All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
	<sec:authorize ifAnyGranted="ROLE_USER">
		<script  type='text/javascript'>
			var user_dept_no = '<sec:authentication property="principal.userVO.deptNo"/>';
		</script>
	</sec:authorize>
	
<%-- 	<sec:authorize ifNotGranted="ROLE_USER"> --%>
<!-- 		<script  type='text/javascript'> -->
<!-- 			alert('로그인이 필요한 페이지 입니다'); -->
<%-- 			window.location = "<c:url value='/'/>";  --%>
<!-- 		</script>  -->
<%-- 	</sec:authorize> --%>
	<script>
		$(function () {

			$('#search').click(function () {
				search_data();
			});
			
			$('#chart').click(function () {
				chart_popup();
			});
			
			$('#excel').click(function () {
				excel_down();
			});

			$('#system').change(function(){
				adjustGongkuDropDown2();
			});

			$('#sugye').change(function(){
				adjustGongkuDropDown2();
				//adjustItemList();
			});			
			$('#factCode').change(function(){
				adjustBranchDropDown();
			});

			$('#branchNo').change(function(){
				adjustItemList();
			});
			adjustItemList();
			adjustGongkuDropDown2();

			$(":radio[name=gubun]")
			.click(function(){
				var gubun = $(":radio[name=gubun]:checked").val();
				if(gubun == 1) {
					$("#year").show();
					$("#month").hide();
					$("#day").hide();
				} else if(gubun == 2) {
					$("#year").show();
					$("#month").show();
					$("#day").hide();
				} else if(gubun == 3) {
					$("#year").show();
					$("#month").show();
					$("#day").show();
				}	
			});

			var today = new Date(); 
			
			var yArr = new Array();
			for(var i=6; i>=0; i--) {
				var tmp = Number(today.getFullYear())-i;
				yArr.push({CAPTION:tmp+"년",VALUE:tmp});
			}
			$('#year').loadSelect(yArr);
			$('#year').attr('value', today.getFullYear());

			var mArr = new Array();
			for(var i=0; i<12; i++) {
				var tmp = addzero(i+1);
				mArr.push({CAPTION:tmp+"월",VALUE:tmp});
			}
			$('#month').loadSelect(mArr);
			$('#month').attr('value', addzero(today.getMonth()+1));

			var dArr = new Array();
			for(var i=0; i<31; i++) {
				var tmp = addzero(i+1);
				dArr.push({CAPTION:tmp+"일",VALUE:tmp});
			}
			$('#day').loadSelect(dArr);
			$('#day').attr('value', addzero(today.getDate()));

			set_User_deptNo(user_dept_no, "sugye");
		});
		
		//측정항목 목록 가져오기
		function adjustItemList()
		{	
			var system = "";
			
			if($('#system').val() == undefined) {
				system = "all";
			} else {
				system = $('#system').val();
			}
			
			var sugye = $('#sugye').val();

			if(system == "all") {
				$("#itemList").html("");
				
				var item = '<li><input type="radio" class="inputRadio" id="itemCode" name="itemCode" label="pH" value="PHY00" checked /><label for="">pH</label></li>';									
				item += '<li><input type="radio" class="inputRadio" id="itemCode" name="itemCode" label="전기전도도" value="CON00" /><label for="">전기전도도</label></li>';									
				item += '<li><input type="radio" class="inputRadio" id="itemCode" name="itemCode" label="용존산소" value="DOW00" /><label for="">용존산소</label></li>';									
				item += '<li><input type="radio" class="inputRadio" id="itemCode" name="itemCode" label="탁도" value="TUR00" /><label for="">탁도</label></li>';									
				item += '<li><input type="radio" class="inputRadio" id="itemCode" name="itemCode" label="수온" value="TMP00" /><label for="">수온</label></li>';									
				
				$("#itemList").append(item);
			} else {
				$.ajax({
					type:"post",
					url:"<c:url value='/waterpolmnt/waterinfo/getItemList.do'/>",
					data:{system:system, sugye:sugye},
					dataType:"json",
					success:function(result){
						var tot = result['item'].length;
	
						var item;
						var caption;
						var value;
	
						item = "";
	
						$("#itemList").html("");
	
						for(var j=0; j < tot; j++){
							var obj = result['item'][j];
	
							caption = obj.CAPTION;
							value = obj.VALUE;
							
							if(j == 0) 
								item = '<li><input type="radio" class="inputRadio" id="itemCode" name="itemCode" checked label="'+caption+'" value="'+value+'" /><label for="">'+caption+'</label></li>';
							else
								item = '<li><input type="radio" class="inputRadio" id="itemCode" name="itemCode" label="'+caption+'" value="'+value+'" /><label for="">'+caption+'</label></li>';
							$("#itemList").append(item);
							item = "";
						}
						init();
					}
				});	
			}
			//search_data();
		}

		var firstFlag = true;
		function init() {
			if(firstFlag) {
				search_data();
				firstFlag = false;
			}
		}	

		function search_data(){

			 showLoading();
			
			var searchDate = "";
			var itemCode = "";
			var gubun = $(":radio[name=gubun]:checked").val();
			
			if(gubun == 1) {
				searchDate = $("#year").val();
			} else if(gubun == 2) {
				searchDate = $("#year").val() + $("#month").val();
			} else if(gubun == 3) {
				searchDate = $("#year").val() + $("#month").val() + $("#day").val();
			}

			$('input[name=itemCode]:checked').each(function() {
				itemCode = $(this).val();
			});

			$.ajax({
				type:"post",
				url:"<c:url value='/stats/getItemStatsList.do'/>",
				data:{system:$("#system").val(), riverId:$("#sugye").val(), itemCode:itemCode, startDate:searchDate, gubun:gubun},
				dataType:"json",
				success:function(result){
					var tot = result['itemStatsList'].length;

					var item;
					var riverName;
					var factName;
					var branchNo;
					var itemName;
					var timeFrm;
					var vlStrMax;
					var vlStrMin;
					var vlStrAvg;

					item = "";

					$("#statsBody").html("");

					if( tot <= "0" ){
						$("#statsBody").html("<tr><td colspan='8'>조회 결과가 없습니다</td></td>");
						closeLoading();
					} else {
						for(var j=0; j < tot; j++){
							var obj = result['itemStatsList'][j];
	
							riverName = obj.riverName;
							factName = obj.factName;
							branchNo = obj.branchNo;
							itemName = obj.itemName;
							timeFrm = obj.timeFrm;
							vlStrMax = obj.vlStrMax;
							vlStrMin = obj.vlStrMin;
							vlStrAvg = obj.vlStrAvg;
						
							item = "<tr>"
								 + "<td>"+riverName+"</td>"
								 + "<td>"+factName+"</td>"
								 + "<td>"+branchNo+"</td>"
								 + "<td>"+itemName+"</td>"
								 + "<td>"+timeFrm+"</td>"
								 + "<td>"+vlStrMax+"</td>"
								 + "<td>"+vlStrMin+"</td>"
								 + "<td>"+vlStrAvg+"</td>"
								 + "</tr>"; 
	
							$("#statsBody").append(item);
							item = "";
						}
						$('#statsBody tr:odd').addClass('add');

						closeLoading();
					}
				}
			});
		}

		function chart_popup() {
			var searchDate = "";
			var itemCode = "";
			var itemName = "";
			var gubun = $(":radio[name=gubun]:checked").val();

			var sw=screen.width;
			var sh=screen.height;
			var winHeight = 500;
			var winWidth = 680;
			var winLeftPost = (sw - winWidth) / 2;
			var winTopPost = (sh - winHeight) / 2;
			var width = winWidth-20;
			var height = winHeight-20;
			
			if(gubun == 1) {
				searchDate = $("#year").val();
			} else if(gubun == 2) {
				searchDate = $("#year").val() + $("#month").val();
			} else if(gubun == 3) {
				searchDate = $("#year").val() + $("#month").val() + $("#day").val();
			}

			$('input[name=itemCode]:checked').each(function() {
				itemCode = $(this).val();
				itemName = $(this).attr('label');
			});

			var param = "system="+$("#system").val()+"&riverName="+$(":select[name=sugye] > option:selected").text()+"&riverId="+$("#sugye").val()+"&itemCode="+itemCode
						+"&itemName="+itemName+"&startDate="+searchDate+"&gubun="+gubun+"&width="+width+"&height="+height;							

			window.open("<c:url value='/stats/getItemStatsChart.do'/>?"+encodeURI(param), 
					'chartView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,left='+winLeftPost+',top='+winTopPost);
		}

		function excel_down() {
			var searchDate = "";
			var itemCode = "";
			var itemName = "";
			var gubun = $(":radio[name=gubun]:checked").val();

			if(gubun == 1) {
				searchDate = $("#year").val();
			} else if(gubun == 2) {
				searchDate = $("#year").val() + $("#month").val();
			} else if(gubun == 3) {
				searchDate = $("#year").val() + $("#month").val() + $("#day").val();
			}

			$('input[name=itemCode]:checked').each(function() {
				itemCode = $(this).val();
				itemName = $(this).attr('label');
			});
	
			var param = "system="+$("#system").val()+"&riverName="+$(":select[name=sugye] > option:selected").text()+"&riverId="+$("#sugye").val()+"&itemCode="+itemCode
						+"&itemName="+itemName+"&startDate="+searchDate+"&gubun="+gubun;

			location.href="<c:url value='/stats/getItemStatsExcel.do'/>?"+param;
		}
	</script>
</head>

<body>
<div id='loadingDiv' style="visibility:hidden;position:absolute;">
	<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
</div>
<div id="wrap">
	<div id="header">
		<c:import url="/common/menu/header.do" />
	</div><!-- //header -->
	<div id="container">
		<!-- 사이드 리스트 -->
		<div id="snb" class="snb">
			<c:import url="/common/menu/left.do" />
		</div>
		<!-- //사이드 리스트 -->
		<!-- navi 리스트 -->
		<div>
			<c:import url="/common/menu/navi.do" />
		</div>
		<!-- //navi 리스트 -->
		<!-- content -->
		<div id="content" class="sub_situationmng">
			<div class="content_wrap page_waterpolstat">
				<div class="inner_itemstat">
					<!-- 유역별 통계 검색 -->
					<div class="search_all_wrap">
					<form action="" onsubmit="return false">
						<dl>
							<dt><img src="<c:url value='/images/content/tit_search_system.gif'/>" alt="시스템" /></dt>
							<dd>
								<select class="fixWidth13" id="system" name="system">
										<option value="U" selected="selected">이동형측정기기</option>
<!-- 										<option value="T">탁수모니터링</option> -->
										<option value="W">수질 원격 감시 체계</option>
										<option value="A">국가수질자동측정망</option>
								</select>
							</dd>
							<dt><img src="<c:url value='/images/content/tit_search_branch.gif'/>" alt="측정소" /></dt>
							<dd>
								<select class="fixWidth7"	id="sugye" name="sugye">
									<option value="R01">한강</option>
									<option value="R02">낙동강</option>
									<option value="R03">금강</option>
									<option value="R04">영산강</option>
								</select>
							</dd>
								<div style="visibility:hidden">
									<span>&gt;</span>
										<select class="fixWidth11"  id="factCode" name="factCode">
											<option value="none">선택</option>
										</select>
									<span>&gt;</span>
									<select class="fixWidth11"  id="branchNo" name="branchNo">
										<option value="1">제 1 측정소</option>
									</select>
								</div>
						</dl>
						<dl>
							<dt><img src="<c:url value='/images/content/tit_search_div.gif'/>" alt="구분" /></dt>
							<dd>
								<ul class="checkList">
									<li><input type="radio" class="inputRadio" id="" name="gubun" value="1" checked="checked" /><label for="">년평균</label></li>
									<li><input type="radio" class="inputRadio" id="" name="gubun" value="2" /><label for="">월평균</label></li>
									<li><input type="radio" class="inputRadio" id="" name="gubun" value="3" /><label for="">일평균</label></li>
								</ul>
							</dd>
							<dt><label for=""></label></dt>
							<dd>
								<p class="part1">
									<select id="year" name="year" style="width:80px;">
									</select>
									<select id="month" name="month" style="width:60px;display:none">
									</select>
									<select id="day" name="day" style="width:60px;display:none">
									</select>
								</p>
							</dd>
						</dl>
						<div class="btnInBox">
							<dl>
								<dt><img src="<c:url value='/images/content/tit_search_item.gif'/>" alt="측정항목" /></dt>
								<dd>
									<ul class="checkList" id="itemList"></ul>
								</dd>
							</dl>
							<p class="btn_search"><input id="search" type="image" src="<c:url value='/images/common/btn_search.gif'/>" alt="조회" /></p>
						</div>
					</form>
					</div>

					<!-- //항목별 통계 검색 -->
					<div class="showData">
						<ul class="dataBtn">
							<li><img id="chart" src="<c:url value='/images/common/btn_graph.gif'/>" alt="그래프" /></li>
							<li><img id="excel" src="<c:url value='/images/common/btn_excel.gif'/>" alt="엑셀" /></li>
						</ul>
						<!-- 항목별 통계 현황 -->
						<div class="data_wrap">
							<div class="overBox">
								<table class="dataTable">
									<colgroup>
										<col width="130px" />
										<col width="140px" />
										<col width="90px" />
										<col width="100px" />
										<col width="160px" />
										<col />
										<col />
										<col />
									</colgroup>
									<thead>
										<tr>
											<th scope="col" rowspan="2">수계</th>
											<th scope="col" rowspan="2">공구</th>
											<th scope="col" rowspan="2">측정소</th>
											<th scope="col" rowspan="2">측정항목</th>
											<th scope="col" rowspan="2">기준일시</th>
											<th scope="col" colspan="3">통계</th>
										</tr>
										<tr>
											<th scope="col">최대</th>
											<th scope="col">최소</th>
											<th scope="col">평균</th>
										</tr>
									</thead>
									<tbody id="statsBody"></tbody>
								</table>
							</div>
						</div>
						<!-- //항목별 통계 현황 -->
					</div><!-- //showData -->
				</div>
			</div>
		</div><!-- //content -->

	</div><!-- //container -->
	<div id="footer">
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div><!-- //footer -->
</div>
</body>
</html>
