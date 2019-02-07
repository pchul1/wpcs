<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
  /**
  * Class Name : statsItemAnalysis.jsp
  * Description : Stats ItemAnalysis 화면
  * Modification Information
  * 
  * 수정일         수정자                   수정내용
  * -------    --------    ---------------------------
  * 2010.05.20     k        최초 생성
  *
  * author k
  * since 2010.05.20
  *  
  * Copyright (C) 2010 by k  All right reserved.
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
		var chkCnt = 0;
		
		$(function () {

			$('#search').click(function () {
				search_data();
			});

			$('#system').change(function(){
				adjustGongkuDropDownX();
				adjustGongkuDropDownY();
			});

			$('#sugyeX').change(function(){
				adjustGongkuDropDownX();
			});			

			$('#factCodeX').change(function(){
				adjustBranchDropDownX();
			});

			$('#branchNoX').change(function(){
				adjustItemListX();
			});	

			$('#sugyeY').change(function(){
				adjustGongkuDropDownY();
			});			

			$('#factCodeY').change(function(){
				adjustBranchDropDownY();
			});

			$('#branchNoY').change(function(){
				adjustItemListY();
			});


			var today = new Date(); 
			var yday = new Date(Date.parse(today) - 2 * 1000 * 60 * 60 * 12);
			
			var todayStr = today.getFullYear() + addzero(today.getMonth()+1) + addzero(today.getDate());
			var yday = yday.getFullYear()+ addzero(yday.getMonth()+1) + addzero(yday.getDate());

			$("#startDate").datepicker({
			    buttonText: '시작일자'
			});

			$("#endDate").datepicker({
			    buttonText: '종료일자'
			});
			
			$('#startDate').val(yday);
			$('#endDate').attr('value', todayStr);

			var mArr = new Array();
			for(var i=0; i<23; i++) {
				var tmp = addzero(i+1);
				mArr.push({CAPTION:tmp+"시",VALUE:tmp});
			}
			$('#startTime').loadSelect(mArr);
			$('#startTime').attr('value', '01');
			$('#endTime').loadSelect(mArr);
			$('#endTime').attr('value', '01');
			
			adjustGongkuDropDownX();
			adjustGongkuDropDownY();

			set_User_deptNo(user_dept_no, "sugyeX");
			set_User_deptNo(user_dept_no, "sugyeY");
		});

		// 공구 목록 가져오기
		function adjustGongkuDropDownX()
		{		
			var system = "";
			if($('#system').val() == undefined) {
				system = "all";
			} else {
				system = $('#system').val();
			}
			
			var sugyeCd = $('#sugyeX').val();
			var dropDownSet = $('#factCodeX');
			if( sugyeCd == 'all' ){
				dropDownSet.attr("disabled", true);
				dropDownSet.emptySelect();
			}else{
				dropDownSet.attr("disabled", false);
				$.getJSON(ROOT_PATH+"waterpolmnt/waterinfo/getGongkuList.do", {system:system, sugye:sugyeCd}, function (data, status){
				     if(status == 'success'){     
				        //locId 객체에 SELECT 옵션내용 추가.
				        dropDownSet.loadSelect(data.gongku);
				        
				        adjustBranchDropDownX();
				     } else { 
				    	 alert("공구 목록 가져오기 실패");
				        return;
				     }
				});
			}
		}
		
		//측정소 목록 가져오기
		function adjustBranchDropDownX()
		{	
			var factCode = $('#factCodeX').val();
			var dropDownSet = $('#branchNoX');
			if( factCode == 'all' ){
				dropDownSet.attr("disabled", true);
				dropDownSet.emptySelect();
			}else{
				dropDownSet.attr("disabled", false);
				$.getJSON(ROOT_PATH+"waterpolmnt/waterinfo/getBranchList.do", {factCode:factCode}, function (data, status){
				     if(status == 'success'){     
				        //locId 객체에 SELECT 옵션내용 추가.
				        dropDownSet.loadSelect(data.branch);
				        
				        adjustItemListX();
				     } else { 
				    	 alert("공구 목록 가져오기 실패");
				        return;
				     }
				});
			}
		}

		//측정항목 목록 가져오기
		function adjustItemListX()
		{	
			var factCode = $('#factCodeX').val();
			var branchNo = $('#branchNoX').val();
			
			if(factCode == null) 
				factCode = "";
			
			if(branchNo == null) 
				branchNo = "";

			$.ajax({
				type:"post",
				url:"<c:url value='/waterpolmnt/waterinfo/getItemList.do'/>",
				data:{factCode:factCode, branchNo:branchNo},
				dataType:"json",
				success:function(result){
	                var tot = result['item'].length;

	                var item;
	                var caption;
	                var value;

	                item = "";

	                $("#itemListX").html("");

	                for(var j=0; j < tot; j++){
	                    var obj = result['item'][j];

	                    caption = obj.CAPTION;
	                    value = obj.VALUE;

	                    if(j == 0) 
	    					item = '<li><input type="radio" class="inputRadio" id="itemCodeX" name="itemCodeX" checked label="'+caption+'" value="'+value+'" /><label for="">'+caption+'</label></li>';
    					else
    						item = '<li><input type="radio" class="inputRadio" id="itemCodeX" name="itemCodeX" label="'+caption+'" value="'+value+'" /><label for="">'+caption+'</label></li>';
    					
	       				$("#itemListX").append(item);
	                    item = "";
	                }

	            	chkCnt++;

	            	if(chkCnt == 2)
		                init();
				},
	            error:function(result){}
			});
		}


		var firstFlag = true;
		
		// 공구 목록 가져오기
		function adjustGongkuDropDownY()
		{		
			var system = "";
			if($('#system').val() == undefined) {
				system = "all";
			} else {
				system = $('#system').val();
			}
			
			var sugyeCd = $('#sugyeY').val();
			var dropDownSet = $('#factCodeY');
			if( sugyeCd == 'all' ){
				dropDownSet.attr("disabled", true);
				dropDownSet.emptySelect();
			}else{
				dropDownSet.attr("disabled", false);
				$.getJSON(ROOT_PATH+"waterpolmnt/waterinfo/getGongkuList.do", {system:system, sugye:sugyeCd}, function (data, status){
				     if(status == 'success'){     
				        //locId 객체에 SELECT 옵션내용 추가.
				        dropDownSet.loadSelect(data.gongku);


				        if(firstFlag)
				        {
					        var idx = 0;
				        	$('#factCodeY > option').each(function(){
					        	idx++;
					        	if(idx == 2)
						        	$(this).attr("selected", "selected");
				        	});
				        }

				        
				        adjustBranchDropDownY();

				     } else { 
				    	 alert("공구 목록 가져오기 실패");
				        return;
				     }
				});
			}
		}

		//측정소 목록 가져오기
		function adjustBranchDropDownY()
		{	
			var factCode = $('#factCodeY').val();
			var dropDownSet = $('#branchNoY');
			if( factCode == 'all' ){
				dropDownSet.attr("disabled", true);
				dropDownSet.emptySelect();
			}else{
				dropDownSet.attr("disabled", false);
				$.getJSON(ROOT_PATH+"waterpolmnt/waterinfo/getBranchList.do", {factCode:factCode}, function (data, status){
				     if(status == 'success'){     
				        //locId 객체에 SELECT 옵션내용 추가.
				        dropDownSet.loadSelect(data.branch);
				        
				        adjustItemListY();
				     } else { 
				    	 alert("공구 목록 가져오기 실패");
				        return;
				     }
				});
			}		
		}		

		//측정항목 목록 가져오기
		function adjustItemListY()
		{	
			var factCode = $('#factCodeY').val();
			var branchNo = $('#branchNoY').val();
			
			if(factCode == null) 
				factCode = "";
			
			if(branchNo == null) 
				branchNo = "";

			$.ajax({
				type:"post",
				url:"<c:url value='/waterpolmnt/waterinfo/getItemList.do'/>",
				data:{factCode:factCode, branchNo:branchNo},
				dataType:"json",
				success:function(result){
	                var tot = result['item'].length;

	                var item;
	                var caption;
	                var value;

	                item = "";

	                $("#itemListY").html("");

	                for(var j=0; j < tot; j++){
	                    var obj = result['item'][j];

	                    caption = obj.CAPTION;
	                    value = obj.VALUE;

	                    if(j == 0)
	       					item = '<li><input type="radio" class="inputRadio" id="itemCodeY" name="itemCodeY" checked label="'+caption+'" value="'+value+'" /><label for="">'+caption+'</label></li>';
       					else
       						item = '<li><input type="radio" class="inputRadio" id="itemCodeY" name="itemCodeY" label="'+caption+'" value="'+value+'" /><label for="">'+caption+'</label></li>';	       					       			
	       				$("#itemListY").append(item);
	                    item = "";
	                }		                

	                chkCnt++;

					if(chkCnt==2)
		                init();
				},
	            error:function(result){}
			});	
		}					

		var firstFlag = true;
		function init() {
			//if(firstFlag) {
			//	search_data();
			//	firstFlag = false;
			//}
		}	

		function search_data(){

			showLoading();
			
			var startDate = "";
			var endDate = "";
			var itemCodeX = "";
			var itemCodeXName = "";
			var itemCodeY = "";
			var itemCodeYName = "";

			startDate = $("#startDate").val() + $("#startTime").val();            			
			endDate = $("#endDate").val() + $("#endTime").val();            			

			$('input[name=itemCodeX]:checked').each(function() {
				itemCodeX = $(this).val();								
				itemCodeXName = $(this).attr('label');							
			});

			$('input[name=itemCodeY]:checked').each(function() {
				itemCodeY = $(this).val();			
				itemCodeYName = $(this).attr('label');					
			});

			var flagX = true;
			var flagY = true;
			
			$.ajax({
				type:"post",
				url:"<c:url value='/stats/getItemAnalysisStatsList.do'/>",
				data:{system:$("#system").val(), factCodeX:$("#factCodeX").val(), branchNoX:$("#branchNoX").val(), factCodeY:$("#factCodeY").val(), branchNoY:$("#branchNoY").val(), itemCodeX:itemCodeX, itemCodeY:itemCodeY, startDate:startDate, endDate:endDate},				
				dataType:"json",
				success:function(result){
					$("#coefCorr").html("상관계수 : " + (result['coefCorr'] == "�" ? "-" : result['coefCorr']));		
	                var tot = result['itemAnalysisStatsList'].length;

	                var item;                
	                var timeFrm;
	                var itemXVlStr;
	                var itemYVlStr;

	                item = "";

	                $("#statsBody").html("");

	                if( tot <= "0" ){
	                	$("#statsBody").html("<tr><td colspan='3'>조회 결과가 없습니다</td></td>");
	                	closeLoading();
	                } else {	                
		                for(var j=0; j < tot; j++){
		                    var obj = result['itemAnalysisStatsList'][j];
	                    
		                    timeFrm = obj.timeFrm;
		                    itemXVlStr = obj.itemXVlStr;
		                    itemYVlStr = obj.itemYVlStr;
		                
		    				item = "<tr>"
		    					 + "<td>"+timeFrm+"</td>"
		    					 + "<td>"+itemXVlStr+"</td>"
		    					 + "<td>"+itemYVlStr+"</td>"    					 
		    					 + "</tr>"; 
	
		       				$("#statsBody").append(item);
		                    item = "";

		                    if(itemYVlStr != 0)
			                    flagY = false;
		                    if(itemXVlStr != 0)
			                    flagX = false;
		                }
	
		                $("#itemXTitle").html(itemCodeXName + "(x축)");
		                $("#itemYTitle").html(itemCodeYName + "(y축)");	                
	
		                $('#statsBody tr:odd').addClass('add');

		                
		                if(flagX)
		                {
		                	$("#coefCorr").html("상관계수 : "+itemCodeXName+"(x축) 데이터 검색 결과가 없어 상관계수를 구할 수 없습니다.");
		                }
		                else if(flagY)
		                {
		                	$("#coefCorr").html("상관계수 : "+itemCodeYName+"(y축) 데이터 검색 결과가 없어 상관계수를 구할 수 없습니다.");
		                }
	
	
		                chart_popup();	            
		                
	                }    	                	        
                	closeLoading();      
				},
	            error:function(result){}
			});
		}    				

		function chart_popup() {
			var startDate = "";
			var endDate = "";
			var itemCodeX = "";
			var itemCodeXName = "";
			var itemCodeY = "";
			var itemCodeYName = "";

			var sw=screen.width;
			var sh=screen.height;
			var winHeight = 400;
			var winWidth = 600;
			var winLeftPost = (sw - winWidth) / 2;
			var winTopPost = (sh - winHeight) / 2;
			var width = winWidth-20;
			var height = winHeight-20;			

			startDate = $("#startDate").val() + $("#startTime").val();            			
			endDate = $("#endDate").val() + $("#endTime").val();            			

			$('input[name=itemCodeX]:checked').each(function() {
				itemCodeX = $(this).val();								
				itemCodeXName = $(this).attr('label');							
			});

			$('input[name=itemCodeY]:checked').each(function() {
				itemCodeY = $(this).val();			
				itemCodeYName = $(this).attr('label');					
			});

            var param = "system="+$("#system").val()+"&factNameX="+$(":select[name=factCodeX]>option:selected").text()+"&factCodeX="+$("#factCodeX").val()+"&branchNoX="+$("#branchNoX").val()+"&itemCodeX="+itemCodeX
            			+"&factNameY="+$(":select[name=factCodeY]>option:selected").text()+"&factCodeY="+$("#factCodeY").val()+"&branchNoY="+$("#branchNoY").val()+"&itemCodeY="+itemCodeY+"&itemNameX="+itemCodeXName+"&itemNameY="+itemCodeYName
            			+"&startDate="+startDate+"&endDate="+endDate+"&width="+width+"&height="+height;			

            chartIfrm.location.href="<c:url value='/stats/getItemAnalysisStatsChart.do'/>?"+encodeURI(param);
		}	


		function showLoading()
		{
			$("#loadingDiv").dialog({
				modal:true,
				open:function() 
				{
					$("#loadingDiv").css("visibility","visible");
					$(this).parents(".ui-dialog:first").find(".ui-dialog-titlebar-close").hide();
					$(this).parents(".ui-dialog:first").find(".ui-dialog-titlebar").hide();
					$(this).parents(".ui-dialog:first").find(".ui-dialog-resizing").hide();
					$(this).parents(".ui-dialog:first").find(".ui-dialog-buttonpane").hide();
					$(this).parents(".ui-dialog:first").find(".ui-dialog-dragging").hide();
					$(this).parents(".ui-dialog:first").css("width", "85px");
					$(this).parents(".ui-dialog:first").css("height", "75px");
					$(this).parents(".ui-dialog:first").css("overflow", "hidden");
					$("#loadingDiv").css("float", "left");
				},
				width:0,
				height:0,
			    showCaption:false,
			    resizable:false
			});
			
			$("#loadingDiv").dialog("open");
		}

		function closeLoading()
		{
			$("#loadingDiv").dialog("close");
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
			<div class="content_wrap page_correlation">
				<div class="inner_itemanalysis">
					<!-- 수질 항목별 관계 분석 검색 -->
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
								<select class="fixWidth7" id="sugyeX" name="sugyeX">
								   <option value="R01" selected="selected">한강</option>
								   <option value="R02">낙동강</option>
								   <option value="R03">금강</option>
								   <option value="R04">영산강</option>
								</select>
								<span>&gt;</span>
									<select class="fixWidth11" id="factCodeX" name="factCodeX">
										<option value="none">선택</option>
									</select>		
								<span>&gt;</span>
								<select class="fixWidth11"  id="branchNoX" name="branchNoX">
									<option value="1">제 1 측정소</option>
								</select>
							</dd>
						</dl>
						<dl>
							<dt><img src="<c:url value='/images/content/tit_search_item_x.gif'/>" alt="측정항목 x축" /></dt>
							<dd>
								<ul class="checkList" id="itemListX"></ul>
							</dd>
						</dl>
						<dl>
							<dt><img src="<c:url value='/images/content/tit_search_branch.gif'/>" alt="측정소" /></dt>
							<dd>
								<select class="fixWidth7" id="sugyeY" name="sugyeY">
								   <option value="R01">한강</option>
								   <option value="R02">낙동강</option>
								   <option value="R03">금강</option>
								   <option value="R04">영산강</option>
								</select>
								<span>&gt;</span>
									<select class="fixWidth11" id="factCodeY" name="factCodeY">
										<option value="none">선택</option>
									</select>		
								<span>&gt;</span>
								<select class="fixWidth11"  id="branchNoY" name="branchNoY">
									<option value="1">제 1 측정소</option>
								</select>
							</dd>
							<dt><img src="<c:url value='/images/content/tit_search_date.gif'/>" alt="조회기간"/></dt>
							<dd>
								<input type="text" class="inputText" id="startDate" name="startDate" size="8" readonly="readonly"/>												
								<select id="startTime" name="startTime">
								</select>
								<span class="space">~</span>
								<input type="text" class="inputText" id="endDate" name="endDate" size="8" readonly="readonly"/>																							
								<select id="endTime" name="endTime">
									<option value=""></option>
								</select>
							</dd>
						</dl>
						<div class="btnInBox">
							<dl>											
								<dt><img src="<c:url value='/images/content/tit_search_item_y.gif'/>" alt="측정항목y측"/></dt>
								<dd>
									<ul class="checkList" id="itemListY"></ul>
								</dd>
							</dl>	
						<p class="btn_search"><input id="search" type="image" src="<c:url value='/images/common/btn_search.gif'/>" alt="조회" /></p>
						</div>
					</form>
				    </div>
					<!-- //수질 항목별 관계 분석 검색 -->
					<!-- 수질 항목별 관계 분석 현황 -->
					<div class="showData_graph">
						<div class="graph">
							<div class="graph_p">
								<div class="roundBox roundBox3">
									<div class="top_l"><div class="top_r"><div class="top"></div></div></div>
									<div class="con">
										<p id="coefCorr">상관 계수 : </p>
									</div>
									<div class="bot_l"><div class="bot_r"><div class="bot"></div></div></div>
								</div>
								<div class="graph_box">
									<iframe src="" id="chartIfrm" name="chartIfrm" frameborder="0" width="100%" height="100%"></iframe>									
								</div>
							</div>
						</div>
						<div class="data_wrap">
							<div class="overBox">
								<table class="dataTable">
									<colgroup>
										<col />
										<col width="90px" />
										<col width="90px" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">년월일시</th>
											<th scope="col" id="itemXTitle"></th>
											<th scope="col" id="itemYTitle"></th>
										</tr>
									</thead>
									<tbody id="statsBody"></tbody>
								</table>
							</div>
						</div>
						<!-- //수질 항목별 관계 분석 현황 -->
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
