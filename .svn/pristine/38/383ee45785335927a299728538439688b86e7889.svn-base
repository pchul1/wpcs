<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />		
	<script>	
		$(function(){
			$('#pointSchBtn').click(function () {		
				loadPointList();
			});					
		});
			
		function loadPointList(){
			var pointName = $("#schPointName").val();
			$.ajax({
				type:"post",
				url:"<c:url value='/mock/getPointList.do'/>",
				data:{riverId:$("#sugye").val()},
				dataType:"json",
				success:function(result){
	                var tot = result['pointList'].length;
	                var item;
	                var tmpIdx = 1;
	                
	                $("#pointTb").html("");
	                
	                if( tot <= "0" ){
	                	$("#pointTb").html("<tr><td colspan='5'>조회 결과가 없습니다</td></td>");
	                }else{
		                for(var i=0; i < tot; i++){
		                    var obj = result['pointList'][i];

		                    var tmp = obj.pointName.replace(new RegExp(pointName, "gi"), "<span style='background-color:yellow'>"+pointName+"</span>");
		            		if(obj.pointId == null || obj.pointId == "") {
		            			item = "<input type='checkbox' class='inputcheck' name='chk' style='display:none' />"
			            			+"<input type='hidden' name='sectionId' value='"+obj.sectionId+"' />"
			                    	+"<input type='hidden' name='pointId' value='' />"
			                    	+"<input type='hidden' name='sectionName' value='"+obj.sectionName+"' />"
			                    	+"<input type='hidden' name='pointName' value='' />";			            		
		            		} else {
			                    item = "<tr>"
				                    +"<td><input type='checkbox' class='inputcheck' name='chk' />"
				                    +"<input type='hidden' name='sectionId' value='"+obj.sectionId+"' />"
				                    +"<input type='hidden' name='pointId' value='"+obj.pointId+"' />"
				                    +"<input type='hidden' name='sectionName' value='"+obj.sectionName+"' />"
				                    +"<input type='hidden' name='pointName' value='"+obj.pointName+"' />"
				                    +"</td>"
									+"<td>"+(tmpIdx++)+"</td>"
									+"<td>"+obj.riverName+"</td>"
									+"<td>"+obj.sectionName+"</td>"
									+"<td>"+tmp+"</td>"
									+"</tr>";		 
		            		}      
		                 		 
		           			$("#pointTb").append(item);
		                    
		                }
	                }
				},
	            error:function(result){alert("error");}
			});			
		}	


		function selectData() {
			var i=0;
			var cnt=0;

			var sectionIds = new Array;
			var sectionNames = new Array;
			var pointIds = new Array;
			var pointNames = new Array;
			
			var selIdx = new Array;

			var firstYN = true;
			var firstCheck;
			var lastCheck;

			$('input[name=chk]').each(function() {
				if($(this).attr('checked')) {
					if(firstYN) {
						firstCheck = i;
						firstYN = false;
					}
					
					selIdx.push(i);
					cnt++;

					lastCheck = i;
				}
				i++;
			});

			if(cnt == 0) {
				alert("분석할 지점을 체크해주세요");
				return;
			}			
			
			for(var i=firstCheck; i<=lastCheck; i++) {
				var tmp = false;
				for(var j=0; j<selIdx.length; j++) {
					if(i == selIdx[j]) { 
						tmp = true;
						break;
					}
				}
				
				if(tmp) {
					sectionIds.push($('input[name=sectionId]').eq(i).val());				
					sectionNames.push($('input[name=sectionName]').eq(i).val());				
					pointIds.push($('input[name=pointId]').eq(i).val());				
					pointNames.push($('input[name=pointName]').eq(i).val());				
				} else {
					sectionIds.push($('input[name=sectionId]').eq(i).val());				
					sectionNames.push($('input[name=sectionName]').eq(i).val());				
					pointIds.push("");				
					pointNames.push("");					
				}				
			}			
			addData(sectionIds, sectionNames, pointIds, pointNames);	
		}



		//숫자만 입력 가능 (onKeyDown 이벤트) 
		function numOnly(){
		 	var code = window.event.keyCode;
		  	if( !event.ctrlKey && !event.shiftKey){
			 	if ((code > 47 && code < 58) || (code > 95 && code < 106) || code == 190 || code == 8 || code == 9 || code == 13 || code == 46) {
			  		window.event.returnValue = true;
			  		return;
			 	}
		  	}

		 	window.event.returnValue = false;
		}
		

		function addData(sectionIds, sectionNames, pointIds, pointNames) {
			$("#sectionTbLst").html("");
			$("#pointTbLst").html("");

			var preSectionId = "";
			var sectionItem = "";
			var pointItem = "";
			var sectionIdx = 1;
			var pointIdx = 1;
			
			for(var i=0; i<sectionIds.length; i++) {
				if(preSectionId != sectionIds[i]) {
					sectionItem += "<tr>";					
					sectionItem += "<td>"+(sectionIdx++)+"</td>";					
					sectionItem += "<td>"+sectionNames[i]+"</td>";					
					sectionItem += "<td><input type='text' class='inputText' style='ime-mode:disabled' name='sectionFlow' onkeydown='numOnly()'/>";
					sectionItem += "<input type='hidden' name='flowId' value='"+sectionIds[i]+"'/></td>";					
					sectionItem +="</tr>";		

					preSectionId = sectionIds[i];
				}		

				if(pointIds[i] != null && pointIds[i] != "") {
					pointItem += "<tr>";					
					pointItem += "<td>"+(pointIdx++)+"</td>";					
					pointItem += "<td>"+pointNames[i]+"<input type='hidden' name='pointId' value='"+pointIds[i]+"'/>";
					pointItem += "<input type='hidden' name='sectionId' value='"+sectionIds[i]+"' /></td>";										
					pointItem +="</tr>";
				}						
				
			}

			$("#sectionTbLst").append(sectionItem);
			$("#pointTbLst").append(pointItem);
			
		}

		function submitMockTest() {

			if(document.mockTestFrm.sectionFlow != null && document.mockTestFrm.sectionFlow.value != "")
			{
				var value = document.mockTestFrm.sectionFlow.value;
				
				if(value.split(".").length > 2 || value[0] == ".")
				{
					alert('모의유량 수치가 잘못되었습니다');
					return;
				}
					
				document.mockTestFrm.action = "<c:url value='/mock/mockTestResult.do'/>";			
				document.mockTestFrm.submit(); 
			}		
		}
	</script>
</head>
<body>
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
			<div class="content_wrap page_correlation">
				<div class="inner_inCorrelation">
                    
					<div class="formWrap">
						<div class="list1">
							<div class="roundBox roundBox3">
								<div class="top_l"><div class="top_r"><div class="top"></div></div></div>
								<div class="con">
									<form action="" onsubmit="return false;">
										<ul class="searchBox">
											<li class="first">
												<select id="sugye" name="sugye">
													<option value="01">한강</option>
													<option value="02">낙동강</option>
													<option value="03">금강</option>
													<option value="04">영산강</option>
												</select>
											</li>											
											<li>
												<input type="text" class="inputText" name="schPointName" id="schPointName" />&nbsp;												
												<img id="pointSchBtn" style="cursor:pointer" src="<c:url value='/images/common/btn_search4.gif'/>" alt="검색" />&nbsp;
											</li>
										</ul>
									</form>
								</div>
								<div class="bot_l"><div class="bot_r"><div class="bot"></div></div></div>
							</div>
							<table class="dataTable">
								<colgroup>
									<col width="35px" />
									<col width="65px" />
									<col width="100px" />
									<col width="200px" />
									<col width="" />
								</colgroup>
								<tr>
									<th scope="col">선택</th>
									<th scope="col">순서</th>
									<th scope="col">수계</th>
									<th scope="col">등속 구간</th>
									<th scope="col">지점</th>
								</tr>
							</table>
							<div class="over_con_dataTable">
								<table class="dataTable">
									<colgroup>
										<col width="35px" />
										<col width="65px" />
										<col width="100px" />
										<col width="200px" />
										<col width="" />
									</colgroup>
									<tbody id="pointTb">
									</tbody>
								</table>
							</div>
						</div>
						<div class="list2">
							<p class="first"><a href="javascript:selectData()">선택</a></p>							
						</div>
						<div class="list3">
							<form method="post" name="mockTestFrm" onsubmit="return submitMockTest()">
							<div class="roundBox roundBox3">
								<div class="top_l"><div class="top_r"><div class="top"></div></div></div>
								<div class="con">
									<p>분석정보</p>
								</div>
								<div class="bot_l"><div class="bot_r"><div class="bot"></div></div></div>
							</div>
							<p class="tit">[등속 구간]</p>
							<table class="dataTable">
								<colgroup>
									<col width="50px" />
									<col width="120px" />
									<col width="" />
								</colgroup>
								<tr>
									<th scope="col">순서</th>
									<th scope="col">등속 구간</th>
									<th scope="col">모의 유량</th>
								</tr>
							</table>
							<div class="over_con_dataTable1">
								<table class="dataTable">
									<colgroup>
									<col width="50px" />
									<col width="120px" />
									<col width="" />
									</colgroup>
									<tbody id="sectionTbLst">
									</tbody>
								</table>
							</div>
							<p class="tit">[주요 지점]</p>
							<table class="dataTable">
								<colgroup>
									<col width="50px" />
									<col width="" />
								</colgroup>
								<tr>
									<th scope="col">순서</th>
									<th scope="col">지점</th>
								</tr>
							</table>
							<div class="over_con_dataTable2">
								<table class="dataTable">
									<colgroup>
										<col width="50px" />
										<col width="" />
									</colgroup>
									<tbody id="pointTbLst">
									</tbody>
								</table>
							</div>
							<p><input type="image" src="<c:url value='/images/common/btn_analysis.gif'/>" alt="분석하기" /></p>
							</form>
						</div>
					</div>
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

