<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page import="daewooInfo.common.security.util.TmsUserDetailsHelper" %>
<%@ page import="daewooInfo.common.login.bean.LoginVO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>국가수질자동측정망 수계별 실시간 감시</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />
	<style type="text/css">
		* {margin:0; padding:0;}
		table tr{height:32px}
		.header_left th.num {text-align:left;padding-left:5px}
		#header_top tr th {border-left:0px;}
		#dataTable tr td {border-left:0px}	
		.totalmntPop2 {width:1280px; margin:0 auto;}	
		.dataTable {width:100px !important;overflow:hidden; }
		
	</style>
	<script src="<c:url value='/js/JQuery/jquery-1.3.2.min.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js" type="text/javascript'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>
	<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.datepicker.js'/>"></script>
	
	<script type='text/javascript'>

		var river_div = "${param.river_div}";
		
		$(function(){

			//초기 수계선택
			$("#river_div > option[value=" + river_div + "]").attr("selected", "selected");
			
			reloadData();
			
			$("#river_div").change(
				function()
				{
					riverDivChange();
				}
			);

			$("#chkCycle").click(function() {
				riverCycle();
			});
		});


		var interval;
		var cycleDiv = 1;

		//수계 순환
		function riverCycle()
		{
			if($("#chkCycle").is(":checked")) {
				cycle();
				interval = setInterval(cycle, (1000 * 15));
			}
			else
			{
				cycleDiv = 1;
				clearInterval(interval);
			}
		}

		function cycle()
		{
			if(cycleDiv > 5)
				cycleDiv = 1;

			//수계선택 변경
			$("#river_div > option[value=R0" + cycleDiv + "]").attr("selected", "selected");
			cycleDiv++;

			riverDivChange();
		}
		
		function riverDivChange()
		{
			var div = $("#river_div").val();

			overboxHeaderTop.scrollLeft = 0;
			overboxHeaderLeft.scrollTop = 0;
			overboxData.scrollLeft = 0;
			overboxData.scrollTop = 0;
			
			var col1 = 1520;
			var col2 = 1440;
			var col3 = 880;
			var col4 = 640;
			
			
			if(div == "all")
			{
				$("#colGroup > col[value=colR01]").attr("width", col1);
				$("#colGroup > col[value=colR02]").attr("width", col2);
				$("#colGroup > col[value=colR03]").attr("width", col3);
				$("#colGroup > col[value=colR04]").attr("width", col4);
				
				$("#colGroup > col[value=colR03]").show();
				$("#colGroup > col[value=colR04]").show();
				
				$("#dataHeader_top1 > tr > th[value=thR01]").show();
				$("#dataHeader_top2 > tr > th[value=thR01]").show();
				
				$("#dataHeader_top1 > tr > th[value=thR02]").show();
				$("#dataHeader_top2 > tr > th[value=thR02]").show();
				
				$("#dataHeader_top1 > tr > th[value=thR03]").show();
				$("#dataHeader_top2 > tr > th[value=thR03]").show();
				
				$("#dataHeader_top1 > tr > th[value=thR04]").show();
				$("#dataHeader_top2 > tr > th[value=thR04]").show();

				$("#dataList > tr > td[value=tdR01]").show();
				$("#dataList > tr > td[value=tdR02]").show();
				$("#dataList > tr > td[value=tdR03]").show();
				$("#dataList > tr > td[value=tdR04]").show();
			}
			else
			{
				var colWidth = 0;
				if(div == "R01")
					colWidth = col1;
				else if(div == "R02")
					colWidth = col2;
				else if(div == "R03")
					colWidth = col3;
				else if(div == "R04")
					colWidth = col4;
				
				$("#colGroup > col[value=colR01]").attr("width", colWidth);
				$("#colGroup > col[value=colR02]").attr("width", 1);
				//$("#colGroup > col[value=colR03]").attr("width", 1);
				$("#colGroup > col[value=colR03]").hide();
				//$("#colGroup > col[value=colR04]").attr("width", 1);
				$("#colGroup > col[value=colR04]").hide();
				//$("#colGroup > col[value=colTmp]").attr("width", 560);
				
				$("#dataHeader_top1 > tr > th[value=thR01]").hide();
				$("#dataHeader_top2 > tr > th[value=thR01]").hide();
				
				$("#dataHeader_top1 > tr > th[value=thR02]").hide();
				$("#dataHeader_top2 > tr > th[value=thR02]").hide();
				
				$("#dataHeader_top1 > tr > th[value=thR03]").hide();
				$("#dataHeader_top2 > tr > th[value=thR03]").hide();
				
				$("#dataHeader_top1 > tr > th[value=thR04]").hide();
				$("#dataHeader_top2 > tr > th[value=thR04]").hide();

				$("#dataList > tr > td[value=tdR01]").hide();
				$("#dataList > tr > td[value=tdR02]").hide();
				$("#dataList > tr > td[value=tdR03]").hide();
				$("#dataList > tr > td[value=tdR04]").hide();

				
				$("#dataHeader_top1 > tr > th[value=th"+div+"]").show();
				$("#dataHeader_top2 > tr > th[value=th"+div+"]").show();
				$("#dataList > tr > td[value=td"+div+"]").show();


				
				//$("#colGroup > col[value=colTmp]").show();
			}
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


		
		function refresh()
		{
			reloadData();
		}
		

		//데이터 로드
		function reloadData(){

			showLoading();
			
			$.ajax({
				type:"post",
				url:"<c:url value='/waterpolmnt/situationctl/getAutoData.do'/>",
				dataType:"json",
				success:function(result){
	                var tot = result['autoData'].length;
	                var item;
					var trClass;
					
	                $("#dataList").html("");

	                if( tot <= "0" ){
	            		//$("#dataList").html("<tr><td colspan='11'>조회 결과가 없습니다</td></td>");
	            		 closeLoading();
	                }else{
		                for(var i=0; i < tot; i++){
			                
		                    var obj = result['autoData'][i];


			                var item = "<tr>";


			                <%String idxStr = "";%>
			                
			                <%for(int idx=1; idx <= 19 ;idx++){ // 한강 19 측정소
			                	
			                	if(idx < 10) 
				                	idxStr = "0" + idx;
			                	else
				                	idxStr = idx +"";
			                %>
			                	item += "<td id='"+(i + "_" + "<%=idx%>")+"' value='tdR01' class='num'><span>" + eval("obj.val" + "<%=idxStr%>") + "</span></td>";
		                 	<%}%>	 
		                 	
		                 	 <%for(int idx=20; idx <= 37 ;idx++){ // 낙동강 18 측정소%>
			                	item += "<td id='"+(i + "_" +  "<%=idx%>")+"' value='tdR02' class='num'><span>" + eval("obj.val" + "<%=idx%>") + "</span></td>";
		                 	<%}%>	 

		                 	<%for(int idx=38; idx <= 48 ;idx++){ // 금강 11 측정소%>
			                	item += "<td id='"+(i + "_" +  "<%=idx%>")+"' value='tdR03' class='num'><span>" + eval("obj.val" + "<%=idx%>") + "</span></td>";
		                 	<%}%>	

		                 	<%for(int idx=49; idx <= 56 ;idx++){ // 영산강 8 측정소%>
			                	item += "<td id='"+(i + "_" +  "<%=idx%>")+"' value='tdR04' class='num'><span>" + eval("obj.val" + "<%=idx%>") + "</span></td>";	
		                 	<%}%>	
		                 	
		                 	item += "</tr>";

		           			$("#dataList").append(item);

		           			<% for (int idx = 1 ; idx <= 56 ; idx ++) { //56개 측정소%>
	           					setSt_Color(eval("obj.con" + "<%=idx%>"), $("#" + i + "_" +  "<%=idx%>"));
		           			<%}%>
		                }
	                }

	           
		            closeLoading();
					riverDivChange();
		            setTimeout(refresh, (1000 * 60));
		            
				},
	            error:function(result){  
					$("#dataList").html("");
		            closeLoading();
		        }
			});
		}    


		//상태별 색상 변화
		function setSt_Color(st, tdObj)
		{
			//tdObj.css("font-weight", "bold");

			//st = "10";
			if(tdObj.text() == "")
				tdObj.html("<span>-</span>");
			
			
			switch(st)
			{
				case "0":	//정상
					tdObj.css("color", "black");
					break;
				case "1" :	//가동중지
					tdObj.css("color", "#A6A600");
					break;
				case "3" :	//교정중
					tdObj.css("color", "#A2E3FF");
					break; 
				case "4" :	//정검/보수중
					tdObj.css("color", "#8080FF");
					break; 
				case "5" : //통신관련(미수신)
					tdObj.css("color", "#B5B5B5");
					break;
				case "6" : //장비이상
					tdObj.css("color", "#EA00EA");
					break;
				case "7" : //전원이상
					tdObj.css("color", "#FF44A2");
					break;
				case "8" : //시운전
					tdObj.css("color", "black");
					break;
				case "9" : //재전송
					tdObj.css("color", "black");
					break;
				case "10" : //기준초과
					tdObj.css("color", "orange");
					break;
				default :
					//tdObj.css("color", "black");
					tdObj.css("color", "black");
					break;
			}
		}
	</script>
	
</head>
<body class="subPop">

<div id='loadingDiv' style="visibility:hidden;position:absolute;">
	<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />	
</div>
<div class="headerWrap">
	<div class="headerBg_r">
		<div class="header">
			<h1 style='padding-top:15px;font-size:18px;font-weight:bold;color:white'>국가수질자동측정망 수계별 실시간 감시</h1>
		</div>
	</div>
</div>

<div class="contentWrap">
<div class="contentBg_r">
<div class="contentBox">
<div class="contentPad">
<!-- totalmntPop2 -->				
<div class="totalmntPop_a">
	<!-- content -->
	<div class="content" style="padding-top:15px">
		<!-- selectList -->
		<ul class="selectList">
			<li><span class="buArrow_tit">수계선택</span>
				<select id="river_div">
					<option value="all" >전체</option>
					<option value="R01">한강</option>
					<option value="R02">낙동강</option>
					<option value="R03">금강</option>
					<option value="R04">영산강</option>
				</select>
			</li>
			<li>
				<span class="buArrow_tit">수계순환</span>
				<input type="checkbox" id="chkCycle"/>
			</li>
			<li style="padding-left:434px;"><img src="<c:url value='/images/popup/colorchip08.gif'/>" width="10" height="10"/><b>기준초과</b></li>
			<li><img src="<c:url value='/images/popup/colorchip01.gif'/>" width="10" height="10"/><b>정상</b></li>
			<li><img src="<c:url value='/images/popup/colorchip02.gif'/>" width="10" height="10"/><b>점검/보수중</b></li>
			<li><img src="<c:url value='/images/popup/colorchip03.gif'/>" width="10" height="10"/><b>교정중</b></li>
			<li><img src="<c:url value='/images/popup/colorchip04.gif'/>" width="10" height="10"/><b>장비이상</b></li>
			<li><img src="<c:url value='/images/popup/colorchip05.gif'/>" width="10" height="10"/><b>전원이상</b></li>
			<li><img src="<c:url value='/images/popup/colorchip06.gif'/>" width="10" height="10"/><b>미수신</b></li>
			<li><img src="<c:url value='/images/popup/colorchip07.gif'/>" width="10" height="10"/><b>가동중지</b></li>
		</ul>
		<!--// selectList -->
		<!-- Left-->
		<div style="float:left;clear:left">
			<table class="dataTable" id="dataTableHeader1" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
				<colgroup>
					<col width="120px" />
					<col width="195px" />
					<col width="60px" />
				</colgroup>
				<thead id="dataHeader">
					<tr>
						<th colspan="3">수계</th>
					</tr>
					<tr>
						<th>측정기명</th>
						<th>측정항목명</th>
						<th>단위</th>
					</tr>
				</thead>
			</table>
		</div>
		<!--// Left -->
		<!-- overBoxHeader_Top -->
		<div id="overBoxHeader_top" style="overflow:hidden;width:831px;">
			<!--  -->
			<table class="dataTable">
				<colgroup id="colGroup">
					<col value="colR01" width="1520px"/>					
					<col value="colR02" width="1440px"/>
					<col value="colR03" width="880px"/>
					<col value="colR04" width="640px"/>
					<col value="colTmp"/>					
				</colgroup>
				<thead id="dataHeader_top1">
					<tr>
						<th value="thR01" style="border-left:0px;border-bottom:0px">한강</th>
						<th value="thR02" style="border-left:0px;border-bottom:0px">낙동강</th>
						<th value="thR03" style="border-left:0px;border-bottom:0px">금강</th>
						<th value="thR04" style="border-left:0px;border-bottom:0px">영산강</th>
					</tr>
				</thead>
			</table>
			<!--// -->			
			<!-- header_top -->
			<table class="dataTable" id="header_top" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
				<colgroup>
					<% for(int i = 0 ; i < 56 ; i++) {%>
						<col width="80px"/>
					<%}%>
				</colgroup>
				<thead id="dataHeader_top2" class="dataList_header">
					<tr>
						<!-- 한강 -->
						<th value="thR01">가평</th>
						<th value="thR01">강천</th>
						<th value="thR01">경안천</th>
						<th value="thR01">구리</th>
						<th value="thR01">단양</th>
						<th value="thR01">달천</th>
						<th value="thR01">미산</th>
						<th value="thR01">서상</th>
						<th value="thR01">신천</th>
						<th value="thR01">양평</th>
						<th value="thR01">여주</th>
						<th value="thR01">원주</th>
						<th value="thR01">의암호</th>
						<th value="thR01">인제</th> 
						<th value="thR01">충주</th>
						<th value="thR01">평창강</th>
						<th value="thR01">포천</th>
						<th value="thR01">한탄강</th>
						<th value="thR01">화천</th>
						<!-- 낙동강 -->
						<th value="thR02">강창</th>
						<th value="thR02">고령</th>
						<th value="thR02">남천</th>
						<th value="thR02">봉화</th>
						<th value="thR02">상동</th>
						<th value="thR02">성서</th>
						<th value="thR02">성주</th>
						<th value="thR02">예천</th>
						<th value="thR02">왜관</th>
						<th value="thR02">임하호</th>
						<th value="thR02">적포</th>
						<th value="thR02">진주</th>
						<th value="thR02">창암</th>
						<th value="thR02">청암</th>
						<th value="thR02">칠곡</th>
						<th value="thR02">칠서</th>
						<th value="thR02">풍양</th>
						<th value="thR02">해평</th>
						<!-- 금강 -->
						<th value="thR03">갑천</th>
						<th value="thR03">공주</th>
						<th value="thR03">대청호</th>
						<th value="thR03">미호천</th>
						<th value="thR03">봉황천</th>
						<th value="thR03">부여</th>
						<th value="thR03">옥천천</th>
						<th value="thR03">용담호</th>
						<th value="thR03">이원</th>
						<th value="thR03">장계</th>
						<th value="thR03">현도</th>
						<!-- 영산강 -->
						<th value="thR04">구례</th>
						<th value="thR04">나주</th>
						<th value="thR04">동복호</th>
						<th value="thR04">서창교</th>
						<th value="thR04">옥정호</th>
						<th value="thR04">주암호</th>
						<th value="thR04">탐진호</th>
						<th value="thR04">황룡강</th>
					</tr>
				</thead>
			</table>
			<!--// header_top -->
		</div>
		<!-- overBoxHeader_Top -->
		<!-- overBoxHeader_Left -->
		<div id="overBoxHeader_left" style="float:left;clear:left;height:583px;overflow:hidden;">
			<table class="dataTable" id="dataTableHeader" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
				<colgroup>
					<col width="120px" />
					<col width="195px" />
					<col width="60px" />
				</colgroup>
				<thead id="dataHeader" class="header_left">
					<tr>
						<th rowspan="5">일반항목<br/></th>
						<th class="num">탁도</th>
						<th>NTU</th>
					</tr>
					<tr>
						<th class="num">수소이온농도1</th>
						<th> </th>
					</tr>
					<tr>
						<th class="num">용존산소1</th>
						<th>mg/L</th>
					</tr>
					<tr>
						<th class="num">전기전도도1</th>
						<th>mS/cm</th>
					</tr>
					<tr>
						<th class="num">수온1</th>
						<th>℃</th>
					</tr>
					<tr>
						<th>유기물질</th>
						<th class="num">총유기탄소</th>
						<th>mg/L</th>
					</tr>
					<tr>
						<th>생물독성(물고기)</th>
						<th class="num">임펄스</th>
						<th rowspan="3">pulse</th>
					</tr>
					<tr>
						<th rowspan="2">생물독성<br/>(물벼룩1)</th>
						<th class="num">임펄스(좌)</th>
					</tr>
					<tr>
						<th class="num">임펄스(우)</th>
					</tr>
					<tr>
						<th rowspan="2">생물독성<br/>(물벼룩2)</th>
						<th class="num">독성지수(좌)</th>
						<th rowspan="2">TOX</th>
					</tr>
					<tr>
						<th class="num">독성지수(우)</th>
					</tr>
					<tr>
						<th>생물독성(미생물)</th>
						<th class="num">미생물 독성지수</th>
						<th>%</th>
					</tr>
					<tr>
						<th>생물독성(조류)</th>
						<th class="num">조류 독성지수</th>
						<th>TOX</th>
					</tr>
					<tr>
						<th rowspan="15">휘발성<br/>유기화합물</th>
						<th class="num">염화메틸렌</th>
						<th rowspan='15'>μg/L</th>
					</tr>
					<tr>
						<th class="num">1.1.1-트리클로로에테인</th>
					</tr>
					<tr>
						<th class="num">벤젠</th>
					</tr>
					<tr>
						<th class="num">사염화탄소</th>
					</tr>
					<tr>
						<th class="num">트리클로로에틸렌</th>
					</tr>
					<tr>
						<th class="num">톨루엔</th>
					</tr>
					<tr>
						<th class="num">테트라클로로에틸렌</th>
					</tr>
					<tr>
						<th class="num">에틸벤젠</th>
					</tr>
					<tr>
						<th class="num">m,p-자일렌</th>
					</tr>
					<tr>
						<th class="num">o-자일렌</th>
					</tr>
					<tr>
						<th class="num">[ECD]염화메틸렌</th>
					</tr>
					<tr>
						<th class="num">[ECD]1.1.1-트리클로로에테인</th>
					</tr>
					<tr>
						<th class="num">[ECD]사염화탄소</th>
					</tr>
					<tr>
						<th class="num">[ECD]트리클로로에틸렌</th>
					</tr>
					<tr>
						<th class="num">[ECD]테트라클로로에틸렌</th>
					</tr>
					<tr>
						<th rowspan="5">영양염류</th>
						<th class="num">총질소</th>
						<th rowspan="5">mg/L</th>
					</tr>
					<tr>
						<th class="num">총인</th>
					</tr>
					<tr>
						<th class="num">암모니아성 질소</th>
					</tr>
					<tr>
						<th class="num">질산성 질소</th>
					</tr>
					<tr>
						<th class="num">인산염인</th>
					</tr>
					<tr>
						<th>클로로필-a</th>
						<th class="num">클로로필-a</th>
						<th>μg/L</th>
					</tr>
					<tr>
						<th rowspan="4">중금속</th>
						<th class="num">카드뮴</th>
						<th rowspan="4">mg/L</th>
					</tr>
					<tr>
						<th class="num">납</th>
					</tr>
					<tr>
						<th class="num">구리</th>
					</tr>
					<tr>
						<th class="num">아연</th>
					</tr>
					<tr>
						<th rowspan="2">페놀</th>
						<th class="num">페놀1</th>
						<th rowspan="2">mg/L</th>
					</tr>
					<tr>
						<th class="num">페놀2</th>
					</tr>
					<tr>
						<th>강수량계</th>
						<th class="num">강수량</th>
						<th>mm/h</th>
					</tr>
				</thead>
			</table>
		</div>
		<!--// overBoxHeader_Left -->
		<!-- overBoxData -->
		<div id="overBoxData" style="overflow:scroll;height:600px;width:848px" onscroll="scroll()">
			<table class="dataTable" id="dataTable" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
				<colgroup>
					<%for(int i = 0 ; i < 56 ; i++) {%>
						<col width="80px"/>
					<%}%>
				</colgroup>
				<tbody id="dataList" class="dataList1"">
				</tbody>
			</table>
		</div>
		<!--// overBoxData -->
	</div>
	<!--// content -->
</div>
<!-- totalmntPop2 -->	

</div>
</div>
</div>
</div>

<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div>
<script type="text/javascript">
	var overboxHeaderTop = document.getElementById("overBoxHeader_top");
	var overboxHeaderLeft = document.getElementById("overBoxHeader_left");
	var overboxData = document.getElementById("overBoxData");
	function scroll()
	{
		overboxHeaderTop.scrollLeft = overboxData.scrollLeft;
		overboxHeaderLeft.scrollTop = overboxData.scrollTop;
	}
	
</script>
</body>
</html>