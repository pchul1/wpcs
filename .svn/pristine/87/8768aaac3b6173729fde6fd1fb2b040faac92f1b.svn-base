<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : itemCalculateManageList.jsp
	 * Description : 방제물품 보유현황 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2013.10.20	lkh			리뉴얼
	 * 
	 * author lkh
	 * since 2013.10.20
	 * 
	 * Copyright (C) 2013 by lkh All right reserved.
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

<%
	String strSearchType = (String)request.getAttribute("strSearchType");
%>

<script type="text/javascript">
//<![CDATA[
	var options = {
			enableColumnReorder: false,
			enableCellNavigation: true,
			multiColumnSort: true
	};
		
	$(function () {
<%-- 		var strSearchType = '<%=strSearchType%>'; --%>
		
// 		if(strSearchType != 'null'){
// 			$("input[name=searchType]")[2].checked = true;
// 		}else if(strSearchType == 'null'){
// 			$("input[name=searchType]")[0].checked = true;
// 			$("#hiddenRow_2").attr("style","display:none");
// 		}
		
		dataLoad();
		
		//getUpperGroupCode(); //대분류코드
		
		//radio 버튼 클릭시
		$("[name=searchType]").click(function(){
			dataLoad();
		})
		selectedSugyeInMemberId(user_riverid , 'searchRiverId');
		
		//물품별 창고 분포 조회 레이어
		$("#itemWhLayer").draggable({
			containment: 'body',
			scroll: false
		});
	});
	
	// 목록 읽어오기 
	function dataLoad(pageNo){
		var clickValue = 'item';
		
// 		$('[name=searchType]').each(function(){
// 			// this(현재선택된 input문의) 체크박스가 checked 되어 있다면
// 			if ( $(this).is(":checked") )
// 				clickValue = $(this).val();
// 		});
		
		showLoading();
		
		if (pageNo == null) pageNo = 1;
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/itemCalculateManageList.do'/>",
			data: {
					pageIndex : pageNo,
					searchUpperGroupCode : $('#searchUpperGroupCode').val(),
					searchGroupCode : $('#searchGroupCode').val(),
					searchWhCode : $('#searchWhCode').val(),
					searchRiverId : $('#searchRiverId').val(),
					searchItemName : $('#searchItemName').val(),
					searchType : clickValue
				},
			dataType:"json",
			success : function(result){
				var tot = result['list'].length;
				
				var colgroup ;
	       		var thead ;

	           	$("#dataList").html("");
	           	$("#colgroupID").html('');
				$("#theadID").html('');

				$('#selectedItemName').val("");
				$("#dataList1").html("");
				
				if(clickValue == 'river'){
					if( tot <= 0 ){
		            	$("#dataList").html("<tr><td colspan='6'>조회 결과 없음</td></tr>");
		            }else{			            		
	            		
	            		colgroup = "<col width='35px'/>"
	                		         + "<col width='15%'/>"			                 				
	                				 //+ "<col width='15%'/>"
	                				 //+ "<col width='15%'/>"
	                				 + "<col width=''/>"
	                				 + "<col width='10%'/>";

	        				 thead = "<tr>"
	            				   + "<th scope='col'>NO</th>"
	            				   + "<th scope='col'>수계</th>"		                 				   
	            				   //+ "<th scope='col'>대분류</th>"
	            				   //+ "<th scope='col'>중분류</th>"
	            				   + "<th scope='col'>물품</th>"
	            				   + "<th scope='col'>개수</th>"
	            				   + "</tr>";

	        				$("#colgroupID").append(colgroup);
	        				$("#theadID").append(thead);

		                for(var i=0; i < tot; i++){
		                    var obj = result['list'][i];
							var item;
							
							item = "<tr>"							     			                   	 
									+"<td>"+obj.num+"</td>"
			                 		+"<td>"+obj.riverDivName+"</td>"						                 		
			                 		//+"<td>"+obj.upperGroupName+"</td>"
			                 		//+"<td>"+obj.groupName+"</td>"
			                 		+"<td>"+obj.itemName+"</td>"
			                 		+"<td>"+obj.amt+"</td>"
			                 		+"</tr>";	                 		

		              		$("#dataList").append(item);

		              		$("#dataList tr:odd").attr("class","add");
		                }
		            }
					// 페이징 정보				            
		            var pageStr = makePaginationInfo(result['paginationInfo']);
		            $("#pagination").empty();
		            $("#pagination").append(pageStr);

		         	// 총건수 표시
					$("#p_total_cnt").html("[총 "+result['paginationInfo'].totalRecordCount+"건]");
				}else if(clickValue == 'warehouse'){
					if( tot <= 0 ){
						
		            	$("#dataList").html("<tr><td colspan='7'>조회 결과 없음</td></tr>");
		            }else{			            		
	            		
	            		colgroup = "<col width='35px'/>"
	                		         + "<col width='15%'/>"
	                				 + "<col width='15%'/>"
	                				 //+ "<col width='15%'/>"
	                				 //+ "<col width='15%'/>"
	                				 + "<col width=''/>"
	                				 + "<col width='10%'/>";

	        				 thead = "<tr>"
	            				   + "<th scope='col'>NO</th>"
	            				   + "<th scope='col'>수계</th>"
	            				   + "<th scope='col'>창고</th>"
	            				   //+ "<th scope='col'>대분류</th>"
	            				   //+ "<th scope='col'>중분류</th>"
	            				   + "<th scope='col'>물품</th>"
	            				   + "<th scope='col'>개수</th>"
	            				   + "</tr>";

	        				$("#colgroupID").append(colgroup);
	        				$("#theadID").append(thead);

		                for(var i=0; i < tot; i++){
		                    var obj = result['list'][i];
							var item;
							
							item = "<tr>"							     			                   	 
									+"<td>"+obj.num+"</td>"
			                 		+"<td>"+obj.riverDivName+"</td>"
			                 		+"<td>"+obj.whName+"</td>"
			                 		//+"<td>"+obj.upperGroupName+"</td>"
			                 		//+"<td>"+obj.groupName+"</td>"
			                 		+"<td>"+obj.itemName+"</td>"
			                 		+"<td>"+obj.amt+"</td>"
			                 		+"</tr>";	                 		
			                
		              		$("#dataList").append(item);

		              		$("#dataList tr:odd").attr("class","add");
		                }
		            }

					// 페이징 정보				            
		            var pageStr = makePaginationInfo(result['paginationInfo']);
		            $("#pagination").empty();
		            $("#pagination").append(pageStr);

		         	// 총건수 표시
					$("#p_total_cnt").html("[총 "+result['paginationInfo'].totalRecordCount+"건]");
				}else if(clickValue == 'item'){
					if( tot <= 0 ){
						
		            	$("#dataList").html("<tr><td colspan='5'>조회 결과 없음</td></tr>");
		            }else{			            		
	            		
	            		colgroup = "<col width='35px'/>"
	                		         //+ "<col width='15%'/>"
	                		         //+ "<col width='15%'/>"
	                				 + "<col width=''/>"
	                				 + "<col width='20%'/>";
	                				

	        				 thead = "<tr>"
	            				   + "<th scope='col'>NO</th>"
	            				   //+ "<th scope='col'>대분류</th>"
	            				   //+ "<th scope='col'>중분류</th>"
	            				   + "<th scope='col'>물품</th>"
	            				   + "<th scope='col'>총개수</th>"            				  		                 				   
	            				   + "</tr>";

	        				$("#colgroupID").append(colgroup);
	        				$("#theadID").append(thead);

		                for(var i=0; i < tot; i++){
		                    var obj = result['list'][i];
							var item;
							
							trclass = "";
							if(i % 2 == 1) trclass = "class=\"even\"";
							var trNo = i+1;
							
							item = "<tr "+trclass+" id='wtr"+trNo+"' class='tr"+i+"' style='cursor:pointer;' onclick=\"clickTrEvent(this);dataLoadDetailList('"+obj.itemCode+"','"+obj.itemName+"'"+")\">"							     			                   	 
									+"<td>"+obj.num+"</td>"
									//+"<td>"+obj.upperGroupName+"</td>"
			                 		//+"<td>"+obj.groupName+"</td>"
			                 		+"<td>"+obj.itemName+"</td>"
			                 		+"<td>"+obj.amtItem+"</td>"		                 		
			                 		+"</tr>";	                 		

		              		$("#dataList").append(item);

		              		$("#dataList tr:odd").attr("class","add");
		                }
		            }
					// 페이징 정보				            
		            var pageStr = makePaginationInfo(result['paginationInfo']);
		            $("#pagination").empty();
		            $("#pagination").append(pageStr);

		         	// 총건수 표시
					$("#p_total_cnt").html("[총 "+result['paginationInfo'].totalRecordCount+"건]");
					
				} //물품 success
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
				
				$('#dataList').html("<tr><td colspan='9'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></tr>");
				
				closeLoading();
			}
		});
	}
	
	/*	대분류 중분류 삭제 2016.12.22 KANG JI NAM
	//대분류 코드 불러오기
	function getUpperGroupCode(){
		$.ajax({
			type:"POST",
			url:"<c:url value='/warehouse/itemManageUpperGroupCode.do'/>",
			data:{},
			dataType:"json",
			beforeSend:function(){
				$('#searchUpperGroupCode').attr("disabled", true);
			},
			success:function(result){
				var dropDownSet = $('#searchUpperGroupCode');
				dropDownSet.loadSelectWareHouse(result.codes, '전체', 'VALUE', 'CAPTION');
				$('#searchUpperGroupCode').attr("disabled", false);
				
				if( $('#search_UpperGroupCode').val() != ''){
					getGroupCode();
				}
			}
		});
	}
	
	//중분류 코드 불러오기
	function getGroupCode(){
		var upperGroupCode = $('#searchUpperGroupCode').val();
		
		if(upperGroupCode == ''){
			$('#searchGroupCode').html("<option value=''>전체</option>");
		}else{
			$.ajax({
				type:"POST",
				url:"<c:url value='/warehouse/itemManageGroupCode.do'/>",
				data:{
					upperGroupCode : upperGroupCode
					},
				dataType:"json",
				beforeSend:function(){
					$('#searchGroupCode').attr("disabled", true);
				},
				success:function(result){
					var dropDownSet = $('#searchGroupCode');
					dropDownSet.loadSelectWareHouse(result.codes, '전체', 'VALUE', 'CAPTION');
					$('#searchGroupCode').attr("disabled", false);
				}
			});
		}
	}
	*/
	
	// 페이지 번호 클릭
	function linkPage(pageNo){
		dataLoad(pageNo);
	}
	
	function onSelItemWh(itemCode){
		dataView1 = new Slick.Data.DataView();
		
		var columns1 = [
						{ id: "nog", name: "No", field: "no", width: 45, sortable: false },
						{ id: "riverDivNameg", name: "수계", field: "riverDivName", width: 80, sortable: false },
						{ id: "whNameg", name: "창고", field: "whName", width: 120, sortable: false },
						{ id: "itemNameg", name: "물품", field: "itemName", width: 140/* , sortable: false */ },
						{ id: "amtg", name: "개수", field: "amt", width: 115, cssClass: "text-align-right20"/* , sortable: false */ }
					];
		
		grid1 = new Slick.Grid("#dataList1", dataView1, columns1, options);
		grid1.setSelectionModel(new Slick.RowSelectionModel());
		
		grid1.onSelectedRowsChanged.subscribe(function() {
			grid1.resetActiveCell();
			var obj = grid1.getDataItem(grid1.getSelectedRows());
			setFactinfoCode(obj);
		});
		
		dataView1.onRowCountChanged.subscribe(function (e, args) {
			grid1.updateRowCount();
			grid1.render();
		});
		
		grid1.onSort.subscribe(function (e, args) {
			var cols = args.sortCols;
			
			dataView1.sort(function (dataRow1, dataRow2) {
				for (var i = 0, l = cols.length; i < l; i++) {
					var field = cols[i].sortCol.field;
					var sign = cols[i].sortAsc ? 1 : -1;
					var value1 = dataRow1[field], value2 = dataRow2[field];
					var result = (value1 == value2 ? 0 : (value1 > value2 ? 1 : -1)) * sign;
					if (result != 0) {
						return result;
					}
				}
				return 0;
			});
			grid1.invalidate();
			grid1.render();
		});
		
		$.ajax({
			type:"POST",
			url:"<c:url value='/warehouse/itemWarehouseManage.do'/>",
			data:{
				itemCode : itemCode
				},
			dataType:"json",
			success : function(result){
// 				console.log("itemWarehouseManage : ",result);
				var tot = result['list'].length;
				
				dataView1.setItems([]);
				layerPopOpen("itemWhLayer");
				
				var height = sGridCmn(1,result['list'],10);
				$("#dataList1").css("height", height + "px");
				grid1.resizeCanvas();
				
				var data = [];
				
				if( tot <= 0 ){
					dataView1.getItemMetadata = function () {
						return {"columns":{0:{"colspan":"*"}}};
					}
					data.push({no:"조회 결과가 없습니다."});
					dataView1.setItems(data, 'no');
					
					var height = sGridCmn(1,data,1);
					$("#dataList1").css("height", height + "px");
					grid1.resizeCanvas();
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['list'][i];
						
						obj.no = i + 1;
						
						data.push(obj);
					}
					dataView1.beginUpdate();
					dataView1.setItems(data, 'no');
					dataView1.endUpdate();
				}
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
				dataView1.getItemMetadata = function () {
					return {"columns":{0:{"colspan":"*"}}};
				}
				var data = [];
				data.push({no:"서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]"});
				dataView1.setItems(data, 'no');
				
				var height = sGridCmn(1,data,1);
				$("#dataList1").css("height", height + "px");
				grid1.resizeCanvas();
				
				closeLoading();
			}
		});
	}
	
	//재고 현황 데이터 로딩 
	function dataLoadDetailList(itemCode, itemName){
		showLoading();
		$('#selectedItemName').val(itemName);
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/itemCalculateManageDetailList.do'/>",
			data: { 
						itemCode:itemCode,
						itemName:itemName
				},	
			dataType:"json",
			success : function(result){
				var tot = result['list'].length;
				
				if( tot <= 0 ){
					$('#dataList1').html("<tr><td colspan='7'>조회 결과가 없습니다.</td></tr>");
				}else{
					var item="";
					for(var i=0; i < tot; i++){
						var obj = result['list'][i];
						
	                   	item += "<tr>"			                   	 
								+"<td class='num'><span>"+obj.riverName+"</span></td>"
		                 		+"<td>"+obj.whName+"</td>"
		                 		+"<td>"+obj.deptName+"</td>"
		                 		+"<td>"+obj.memberName+"</td>"
		                 		+"<td>"+obj.adminTelNo+"</td>"
		                 		+"<td>"+obj.itemName+"</td>"
		                 		+"<td>"+obj.itemCnt+"</td>"
		                 		+"</tr>";

	                 	$("#dataList1").html(item);

	              		$("#dataList1 tr:odd").attr("class","even");
						
					}
					
				}

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
				$('#dataList1').html("<tr><td colspan='7'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></tr>");
				
				closeLoading();
			}
		});
	}
	
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("itemWhLayer");
	}
	
	/* 클릭(선택)시 강조(노랑) 마크 */
	function clickTrEvent(trObj) {
		var tr = eval("document.getElementById(\"" + trObj.id + "\")");
		$(tr).parent().find("tr td").removeClass("tr_on");
		$(tr).find("td").addClass("tr_on");
	}
	
//]]>
</script>
</head>

<body>
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div id="layerFullBgDiv"></div>
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
						
						<form id="hiddenForm" action="" method="post">
							<input type="hidden" id="itemCode" name="itemCode" value=""/>
						</form>
						<form id="searchForm" action="" class="formBox2" onsubmit="return false;">
							<input type="hidden" id="search_RiverId"		name="search_RiverId" value="${searchVO.searchRiverId}"/>
							<input type="hidden" id="search_UpperGroupCode" name="search_UpperGroupCode" value="${searchVO.searchUpperGroupCode}"/>
							<input type="hidden" id="search_GroupCode"	  name="search_GroupCode" value="${searchVO.searchGroupCode}"/>
							
							<div class="searchBox dataSearch">
								<ul>
<!-- 									<li> -->
<!-- 										<span class="fieldName">구분</span> -->
<!-- 										<input type="radio" id="searchType" name="searchType" value="river" />수계별  -->
<!-- 										<input type="radio" id="searchType" name="searchType" value="warehouse"/>창고별 -->
<!-- 										<input type="radio" id="searchType" name="searchType" value="item"/>물품별 -->
<!-- 									</li> -->
<!-- 									<li id="hiddenRow_1"> -->
<!-- 										<span class="fieldName">수계</span> -->
<!-- 										<select id="searchRiverId" name="searchRiverId"> -->
<!-- 											<option value="">전체</option> -->
<!-- 											<option value="R01">한강</option> -->
<!-- 											<option value="R02">낙동강</option> -->
<!-- 											<option value="R03">금강</option> -->
<!-- 											<option value="R04">영산강</option> -->
<!-- 										</select> -->
<!-- 									</li> -->

									<li id="hiddenRow_2">
										<span class="fieldName">물품명</span>
<!-- 											<input type="text" id="searchWhCode" name="searchWhCode" value="${searchVO.searchWhCode}" style="width: 195px; ime-mode:active;"/> -->
										<input type="text" id="searchItemName" name="searchItemName" value="${searchVO.searchItemName}" style="width: 195px; ime-mode:active;"/>
									</li>
								</ul>
							</div>
							
							<div class="btnSearchDiv">
								<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:dataLoad();" alt="조회하기" style="float:right;"/>
							</div>
						</form>
						
						<div id="btArea">
							<span id="p_total_cnt">[총 ${totCnt}건]</span>
						</div>
						
						<form id="groupListForm" action="" onsubmit="return false;">
							<div class="table_wrapper">
								<div  style="overflow-x: hidden; overflow-y: scroll; width: 100%; height: 250px;">
									<table>
										<colgroup id="colgroupID"></colgroup>
										<thead id="theadID"></thead>
										<tbody id="dataList"></tbody>
									</table>
								</div>
							</div>
						</form>
						<div class="table_wrapper">
							<div style="text-align:left;">
								<span>물품상세 내역: 
									<input type="text" size="50" id="selectedItemName" name="selectedItemName" readonly="readonly" style="color:red;border:none;border-right:1px; border-top:1px; boder-left:1px; boder-bottom:1px;"/>
								</span>
							</div>
							<table summary="물품상세">
								<colgroup>
									<col width="60" />
									<col />
									<col width="150" />
									<col width="110" />
									<col width="150" />
									<col width="100" />
									<col width="110" />
								</colgroup>
								<thead>
								<tr>
									<th scope="col">수계</th>
									<th scope="col">창고명</th>
									<th scope="col">담당부서</th>
									<th scope="col">담당자</th>
									<th scope="col">연락처</th>
									<th scope="col">물품</th>
									<th scope="col">재고대수</th>
								</tr>
								</thead>
								<tbody  id="dataList1">
									<tr>
										<td colspan="7">방제물품을 선택해 주세요.</td>
									</tr>
								</tbody>
							</table>
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
	<!--물품별 찯고분포 내역-->
	<div id="itemWhLayer" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnItemWhXbox" name="btnItemWhXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('itemWhLayer');" alt="닫기"/>
		</div>
		<div id="dataList1" class="dataList" style="width:500px; text-align:center;"></div>
	</div>
	<!--//측정소 검색 레이어-->
</body>
</html>