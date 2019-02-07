<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
  /**
  * @Class Name : statsPrevent.jsp
  * @Description : Stats Prevent 화면
  * @Modification Information
  * 
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  *  2010.05.20     k        최초 생성
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
<%-- 	</sec:authorize>		 --%>
	<script>
		$(function () {

			$('#search').click(function () {
				search_data();
			});
							
			$('#print').click(function () {
				report();
			});

			$('#system').change(function(){							
				adjustGongkuDropDown2();
			});				

			$('#sugye').change(function(){
				adjustGongkuDropDown2();
			});

			$('#factCode').change(function(){
				adjustBranchDropDown();
			});

			$('#branchNo').change(function(){
				adjustItemList();
			});		

			setDate(1);

			$("#startDate").datepicker({
			    buttonText: '시작일자'			    
			});

			$("#endDate").datepicker({
			    buttonText: '종료일자'			    
			});
			
			$('input[name=dateType]').click(function(){							
				setDate(this.value);
			});	

			search_data();

			setDate(3);
		});			

		function setDate(mode) {
			var basic = new Date(0);
			var today = new Date();
			var rdate;
			var startDate = "";
			var endDate = today.getFullYear() + addzero(today.getMonth()+1) + addzero(today.getDate());

			if(mode == 1) {
				rdate = new Date((1000*60*60*24*(-365+((today-basic)/(1000*60*60*24)))));
				startDate = rdate.getFullYear() + addzero(rdate.getMonth()+1) + addzero(rdate.getDate());
				$('#startDate').attr('value', startDate);
				$('#endDate').attr('value', endDate);
			} else if(mode == 2) {
				rdate = new Date((1000*60*60*24*(-90+((today-basic)/(1000*60*60*24)))));
				startDate = rdate.getFullYear() + addzero(rdate.getMonth()+1) + addzero(rdate.getDate());
				$('#startDate').attr('value', startDate);
				$('#endDate').attr('value', endDate);				
			} else if(mode == 3) {				
				rdate = new Date((1000*60*60*24*(-30+((today-basic)/(1000*60*60*24)))));
				startDate = rdate.getFullYear() + addzero(rdate.getMonth()+1) + addzero(rdate.getDate());
				$('#startDate').attr('value', startDate);
				$('#endDate').attr('value', endDate);				
			} else if(mode == 4) {				
				rdate = new Date((1000*60*60*24*(-7+((today-basic)/(1000*60*60*24)))));
				startDate = rdate.getFullYear() + addzero(rdate.getMonth()+1) + addzero(rdate.getDate());
				$('#startDate').attr('value', startDate);
				$('#endDate').attr('value', endDate);				
			} else if(mode == 5) {
				$('#startDate').attr('value', endDate);
				$('#endDate').attr('value', endDate);				
			}
								
		}

		function report() {
			var sw=screen.width;
			var sh=screen.height;
			var winHeight = 600;
			var winWidth = 900;
			var winLeftPost = (sw - winWidth) / 2;var winTopPost = (sh - winHeight) / 2;
			var width = winWidth-40;
			var height = winHeight-40;

			var mrdFile = "statsPrevent";
			var param = "/rp ["+$('#startDate').val()+"] ["+$('#endDate').val()+"]";

			document.report.mrdpath.value = mrdFile;
			document.report.param.value = param;
			
			window.open("", 
					'reportView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);

			document.report.target = "reportView";
			document.report.submit();				
		}						

		function search_data(){

			showLoading();
			var system = $("#system").val();			
			var startDate = $('#startDate').val();
			var endDate = $('#endDate').val();
								
			$.ajax({
				type:"post",
				url:"<c:url value='/stats/getPreventStatsList.do'/>",
				data:{system:system, factCode:$("#factCode").val(), startDate:startDate, endDate:endDate},
				dataType:"json",
				success:function(result){
	                var tot = result['preventStatsList'].length;
	                                
	                var item;
	                var sysKind;
	                var total;
	                var val1;
	                var val2;
	                var val3;
	                var val4;
	                var val5;
	                var val6;
	                var val7;
	                var val8;

	                item = "";	    				              

	                $("#statsBody").html("");

	                if( tot <= "0" ){
	                	$("#statsBody").html("<tr><td colspan='10'>조회 결과가 없습니다</td></td>");
	                	closeLoading();    
	                } else {	        	                	        
		                for(var j=0; j < tot; j++){
		                    var obj = result['preventStatsList'][j];
	
		                    sysKind = obj.sysKind;
		                    total = obj.total;
		                    val1 = obj.val1;
		                    val2 = obj.val2;
		                    val3 = obj.val3;
		                    val4 = obj.val4;
		                    val5 = obj.val5;
		                    val6 = obj.val6;
		                    val7 = obj.val7;
		                    val8 = obj.val8;

		                    if(sysKind == "ALL")
			                    sysKind = "총계";
		                    else if(sysKind == "T")
			                    sysKind = "탁수 모니터링";
		                    else if(sysKind == "U")
			                    sysKind = "이동형측정기기";
		                    else if(sysKind == "A")
			                    sysKind = "국가수질자동측정망";		                    
		                
		    				item = "<tr>"
		    					 + "<td>"+sysKind+"</td>"
		    					 + "<td>"+total+"</td>"
		    					 + "<td>"+val1+"</td>"
		    					 + "<td>"+val2+"</td>"
		    					 + "<td>"+val3+"</td>"
		    					 + "<td>"+val4+"</td>"
		    					 + "<td>"+val5+"</td>"
		    					 + "<td>"+val6+"</td>"    					 
		    					 + "<td>"+val7+"</td>"    					 
		    					 + "<td>"+val8+"</td>"    					 
		    					 + "</tr>"; 
	
		       				$("#statsBody").append(item);
		                    item = "";
		                }		               
		                $('#statsBody tr:odd').addClass('add');
	                }
	                closeLoading();    
				},
	            error:function(result){}
			});
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
			<div class="content_wrap page_protectstat">
				<div class="inner_protstat">
					<!-- 방제조치 통계 검색 -->
					<div class="search_all_wrap">
					<form action="" onsubmit="return false">
						<dl>
							<dt><img src="<c:url value='/images/content/tit_search_system.gif'/>" alt="시스템" /></dt>
							<dd>
								<select class="fixWidth13" id="system" name="system">
										<option value="U" selected="selected">이동형측정기기</option>
<!-- 										<option value="T">탁수모니터링</option> -->
										<option value="A">국가수질자동측정망</option>
								</select>
							</dd>
							<dt style="visibility:hidden"><img src="<c:url value='/images/content/tit_search_div.gif'/>" alt="구분" /></dt>
							<dd style="visibility:hidden">
								<ul class="checkList first">
									<li><input type="radio" class="inputRadio" id="dateType" name="dateType" value="1" checked /><label for="">연간</label></li>
									<li><input type="radio" class="inputRadio" id="dateType" name="dateType" value="2"  /><label for="">분기</label></li>
									<li><input type="radio" class="inputRadio" id="dateType" name="dateType" value="3"  /><label for="">월간</label></li>
									<li><input type="radio" class="inputRadio" id="dateType" name="dateType" value="4"  /><label for="">주간</label></li>
									<li><input type="radio" class="inputRadio" id="dateType" name="dateType" value="5"  /><label for="">일간</label></li>
								</ul>
							</dd>
						</dl>
						<div class="btnInBox">
							<dl>
								<dt><img src="<c:url value='/images/content/tit_search_date.gif'/>" alt="조회기간" /></dt>
								<dd>
									<input type="text" class="inputText" id="startDate" name="startDate" size="8" readonly="readonly" />												
									<span class="space">~</span>
									<input type="text" class="inputText" id="endDate" name="endDate" size="8" readonly="readonly" />																							
								</dd>
							</dl>
							<p class="btn_search"><input id="search" type="image" src="<c:url value='/images/common/btn_search.gif'/>" alt="조회" /></p>
						</div>
					</form>
				    </div>
					<!-- //방제조치 통계 검색 -->
					<div class="showData">
						<ul class="dataBtn">
							<li><img id="print" src="<c:url value='/images/common/btn_print.gif'/>" alt="출력" /></li>
						</ul>
						<!-- 방제조치 통계 현황 -->
						<div class="data_wrap">
							<div class="overBox">
								<table class="dataTable">
									<colgroup>
										<col />
										<col width="80px" />
										<col width="80px" />
										<col width="80px" />
										<col width="80px" />
										<col width="80px" />
										<col width="80px" />
										<col width="80px" />
										<col width="80px" />
										<col width="80px" />										
									</colgroup>
									<thead>
										<tr>
											<th scope="col" rowspan="2">시스템</th>
											<th scope="col" colspan="5">경보</th>
											<th scope="col" colspan="4">조치</th>
										</tr>
										<tr>
											<th scope="col">계</th>
											<th scope="col">관심</th>
											<th scope="col">주의</th>
											<th scope="col">경계</th>
											<th scope="col">심각</th>
											<th scope="col">이상데이터</th>
											<th scope="col">측정기이상</th>
											<th scope="col">시료분석</th>
											<th scope="col">상황조치</th>
										</tr>									
									</thead>
									<tbody id="statsBody"></tbody>
								</table>
							</div>
						</div>
						<!-- //방제조치 통계 현황 -->
					</div><!-- //showData -->
				</div>
			</div>
		</div><!-- //content -->

	</div><!-- //container -->
	<div id="footer">
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div><!-- //footer -->
</div>
<form name="report" method="post" action="<c:url value='/common/rdView.do'/>">
	<input type="hidden" name="mrdpath" />
	<input type="hidden" name="param" />
</form>
</body>
</html>
