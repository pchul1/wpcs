<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />
	
	<script src="<c:url value='/js/JQuery/jquery-1.3.2.min.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js" type="text/javascript'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>
	
	<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.datepicker.js'/>"></script>
	
	<script type='text/javascript'>
	var fact_name;
	var fact_code;
	var branch_no;
	var branch_name;
	var sys;
	var itemCnt;
	var itemArray;
	var itemCode;
	var sugye;
	
	
	$(function(){

		$("#loadingDiv").dialog({
			modal:true,
			open:function() 
			{
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
			width:85,
			height:75,
		    showCaption:false,
		    resizable:false
		});
		
		 fact_code = '${param.fact_code}';
		 branch_no = '${param.branch_no}';
		 sys = '${param.sys_kind}';
		 fact_name = '${param.branchName}'; 
		 sugye = '${param.sugye}';

		 if(sys == "A")
		 {
			 $("#dataTable").attr("class", "dataTable_broad");
			 $("#dataTableHeader").attr("class", "dataTable_broad");

			 $("#overBoxHeader").css("overflow-y","scroll");
			 
			 $("#overConBox").css("height", "632px");
		 }

		 getHighDamData();
		 getLowWaterDCCenter();
		 
		 itemSetting(sys);
		 makeHeader();
		 
		 reloadData();
		 alertTargetList();

		 adjustDept();
		 
		 $("#dept").change(function(){ changeDepth(); });

		 $("#select_item").change(
	 		function() { 

	 			showLoading();
	 			
	 			chart();

	 			if($("#select_item").val() != "all")
	 			{
	 				$("#graphName").text($("#select_item [selected=selected]").text());
	 			}
	 			else
	 			{
	 				$("#graphName").text("");
	 			}		 		
			}
	 	);
	});	


	///동적 SELECTBOX 구현을 위한 사용자 함수
	(function($) {

	//SELECT OPTION 삭제
	$.fn.emptySelect = function() {
	     return this.each(function(){
	       if (this.tagName=='SELECT') this.options.length = 0;
	     });
	  }


	  //SELECT OPTION 등록 - 전체 포함
	  $.fn.loadSelect_all = function(optionsDataArray) {
	     return this.emptySelect().each(function(){
	       if (this.tagName=='SELECT') {
	           var selectElement = this;

	           var first = new Option('전체', 'all');

		       	if ($.browser.msie)
					 selectElement.add(first);
				else
					selectElement.add(first);
			
	           $.each(optionsDataArray,function(idx, optionData){
	               var option = new Option(optionData.CAPTION, optionData.VALUE);

					if ($.browser.msie) {
						selectElement.add(option);
					}
					else {
						selectElement.add(option,null);
					}
	           });
	       }
	    });
	  }
	})(jQuery);

	

	function showLoading()
	{
		$("#loadingDiv").dialog("open");
	}

	function chartLoaded()
	{
		$("#loadingDiv").dialog("close");
	}
	

	function changeDepth()
	{
		alertTargetList();
	}
	
	function reloadData(){
		refresh();
		alertTargetList();
		//chart();
		setTimeout(reloadData, 600000);
	}

	//itemArray 셋팅
	function itemSetting(sys_kind)
	{
		if(sys == "T")
		 {
			itemCnt = 6;
			itemArray = new Array(itemCnt);
			itemCode = new Array(itemCnt);
			itemArray[0] = "pH";	itemCode[0] = "PHY";
			itemArray[1] = "BOD<br/><font style='font-size:10px'>(ppm)</font>";	itemCode[1] = "BOD";
			itemArray[2] = "COD<br/><font style='font-size:10px'>(ppm)</font>";	itemCode[2] = "COD";
			itemArray[3] = "SS<br/><font style='font-size:10px'>(mg/L)</font>";	itemCode[3] = "SUS";
			itemArray[4] = "T-N<br/><font style='font-size:10px'>(mg/L)</font>";	itemCode[4] = "TON";
			itemArray[5] = "T-P<br/><font style='font-size:10px'>(mg/L)</font>";	itemCode[5] = "TOP";
		 }
		 if(sys == "U")
		 {
			 itemCnt = 6;
			 itemArray = new Array(itemCnt);
			 itemCode = new Array(itemCnt);
			 itemArray[0] = "탁도<br/><font style='font-size:10px'>(NTU)</font>"; 	itemCode[0] = "TUR";
			 itemArray[1] = "수온<br/><font style='font-size:10px'>(℃)</font>";	itemCode[1] = "TMP";
			 itemArray[2] = "pH";	itemCode[2] = "PHY";
			 itemArray[3] = "DO<br/><font style='font-size:10px'>(mg/L)</font>";	itemCode[3] = "DOW";
			 itemArray[4] = "EC<br/><font style='font-size:10px'>(mS/cm)</font>";	itemCode[4] = "CON";
			 itemArray[5] = "Chl-a<br/><font style='font-size:10px'>(μg/L)</font>";	itemCode[4] = "TOF";
		 }
		 else if(sys=="A")
		 {
			 itemCnt = 41;
			 itemArray = new Array(itemCnt);
			 itemCode = new Array(itemCnt);
			 itemArray[0] = "탁도<br/>(NTU)";		itemCode[0] = "TUR00";
			 itemArray[1] = "pH";			itemCode[1] = "PHY00";
			 itemArray[2] = "DO<br/>(mg/L)";		itemCode[2] = "DOW00";
			 itemArray[3] = "EC<br/>(mS/cm)";	itemCode[3] = "CON00";
			 itemArray[4] = "수온<br/>(℃)"; 	itemCode[4] = "TMP00";
			 //itemArray[5] = "pH2";			itemCode[5] = "PHY01";
			 //itemArray[6] = "DO2<br/>(mg/L)";		itemCode[6] = "DOW01";
			 //itemArray[7] = "EC2<br/>(mS/cm)";	itemCode[7] = "CON01";
			 //itemArray[8] = "수온2<br/>(℃)"; 	itemCode[8] = "TMP01";
			 itemArray[5] = "총유기탄소";	itemCode[5] = "TOC00";
			 itemArray[6] = "임펄스<br/>"; 	itemCode[6] = "IMP00";
			 itemArray[7] = "임펄스<br/>(좌)";	itemCode[7] = "LIM00";
			 itemArray[8] = "임펄스<br/>(우)";	itemCode[8] = "RIM00";
			 itemArray[9] = "독성지수<br/>(좌)";	itemCode[9] = "LTX00";
			 itemArray[10] = "독성지수<br/>(우)";	itemCode[10] = "RTX00";
			 itemArray[11] = "미생물<br/>독성지수(%)";	itemCode[11] = "TOX00";
			 itemArray[12] = "조류<br/>독성지수";		itemCode[12] = "EVN00";
			 itemArray[13] = "염화메틸렌";	itemCode[13] = "VOC01";			 		 
			 itemArray[14] = "1.1.1-트리클로로에테인";	itemCode[14] = "VOC02";
			 itemArray[15] = "벤젠";		itemCode[15] = "VOC03";
			 itemArray[16] = "사염화탄소"; 	itemCode[16] = "VOC04";
			 itemArray[17] = "트리클로로에틸렌";	itemCode[17] = "VOC05";
			 itemArray[18] = "톨루엔";		itemCode[18] = "VOC06";
			 itemArray[19] = "테트라클로로에티렌";	itemCode[19] = "VOC07";			 		 
			 itemArray[20] = "에틸벤젠";	itemCode[20] = "VOC08";
			 itemArray[21] = "m,p-자일렌";	itemCode[21] = "VOC09";
			 itemArray[22] = "o-자일렌"; itemCode[22] = "VOC10";
			 itemArray[23] = "[ECD]염화메틸렌"; 	itemCode[23] = "VOC11";
			 itemArray[24] = "[ECD]1.1.1-트리클로로에테인";	itemCode[24] = "VOC12";
			 itemArray[25] = "[ECD]사염화탄소";	itemCode[25] = "VOC13";			 		 
			 itemArray[26] = "[ECD]트리클로로에틸렌";	itemCode[26] = "VOC14";
			 itemArray[27] = "[ECD]테트라클로로에티렌"; 	itemCode[27] = "VOC15";
			 itemArray[28] = "총질소";	itemCode[28] = "TON00";
			 itemArray[29] = "총인";	itemCode[29] = "TOP00";
			 itemArray[30] = "암모니아성질소";	itemCode[30] = "NH400";
			 itemArray[31] = "질산성질소";	itemCode[31] = "NO300";
			 itemArray[32] = "인산염인";	itemCode[32] = "PO400";
			 itemArray[33] = "클로로필-a";		itemCode[33] = "TOF00";
			 itemArray[34] = "카드뮴";	itemCode[34] = "CAD00";
			 itemArray[35] = "납";	itemCode[35] = "PLU00";
			 itemArray[36] = "구리";	itemCode[36] = "COP00";
			 itemArray[37] = "아연";	itemCode[37] = "ZIN00";
			 itemArray[38] = "페놀1";	itemCode[38] = "PHE00";
			 itemArray[39] = "페놀2";	itemCode[39] = "PHL00";
			 itemArray[40] = "강수량";	itemCode[40] = "RIN00";
		 }
	}

	//테이블 헤더 생성
	function makeHeader()
	{
		var header;
		
		if(sys != "A")
		{
			//헤더 생성
			$("#valueDataHeader").html("");
			header = "<tr>" + 
							"<th rowspan ='2' scope='col'>시간</th>" +
							"<th colspan ='"+itemCnt+"' scope='col'>수질정보</th>" + 						
						"</tr>" + 
						"<tr>"
		
						for(var rowIdx=0;rowIdx<itemCnt;rowIdx++)
						{
							header += "<th scope='col'>"+itemArray[rowIdx]+"</th>";
						}
		
						header += "</tr>";
		
			
			$("#valueDataHeader").append(header);
			$("#valueDataList").html("<tr><td colspan='"+(itemCnt + 1)+"'>데이터를 불러오는 중 입니다.</td></tr>");

			
		}
		else if(sys == "A")
		{
			//헤더 생성
			$("#valueDataHeader").html("");
			header = "<tr>" + 
							"<th rowspan ='2' scope='col'>시간</th>" +
							"<th colspan ='5' scope='col'>일반항목</th>"+
							//"<th colspan ='4' scope='col'>일반항목<br/>(외부)</th>"+
							"<th colspan='1' scope='col'>유기물질</th>" +
							"<th colspan='1' scope='col'>생물독성<br/>(물고기)</th>" + 
							"<th colspan='2' scope='col'>생물독성<br/>(물벼룩1)</th>" +
							"<th colspan='2' scope='col'>생물독성<br/>(물벼룩2)</th>" +									
							"<th colspan='1' scope='col'>생물독성<br/>(미생물)</th>" +
							"<th colspan='1' scope='col'>생물독성<br/>(조류)</th>" +
							"<th colspan='15' scope='col'>휘발성<br/>유기화합물</th>" +
							"<th colspan='5' scope='col'>영양염류</th>" +
							"<th colspan='1' scope='col'>클로로필-a</th>" +
							"<th colspan='4' scope='col'>중금속</th>" +
							"<th colspan='2' scope='col'>페놀</th>" +
							"<th colspan='1' scope='col'>강수량계</th>" +							
						"</tr>" + 
						"<tr>"
		
						for(var rowIdx=0;rowIdx<itemCnt;rowIdx++)
						{
							header += "<th scope='col'>"+itemArray[rowIdx]+"</th>";
						}
		
						header += "</tr>";
		
			
			$("#valueDataHeader").append(header);
			$("#valueDataList").html("<tr><td colspan='"+(itemCnt + 3)+"'>데이터를 불러오는 중 입니다.</td></tr>");
		}
	}


	function adjustDept()
	{
		var dropDownSet = $("#dept");
		
		$.getJSON("<c:url value='/waterpolmnt/situationctl/getDepts.do'/>", 
				function (data, status){
		     if(status == 'success'){     
		        //locId 객체에 SELECT 옵션내용 추가.
		        dropDownSet.loadSelect_all(data.depts);
		     } else { 
		    	// alert("공구 목록 가져오기 실패");
		        return;
		     }
		});
	}

	
	function alertTargetList(){

		var dept = $("#dept").val();

		$("#alertDataList").html("");
		$("#alertDataList").html("<tr><td colspan='4'>데이터를 불러오는 중 입니다...</td></tr>");

		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/situationctl/getAlertTargetList.do'/>",
			data:{factCode:fact_code,
					branchNo:branch_no,
					dept:dept},
			dataType:"json",
			success:function(result){
	            var tot = result['refreshData'].length;
				var trClass;

				$("#alertDataList").html("");
	            if( tot <= "0" ){
					$("#alertDataList").html("<tr><td colspan='4'>조회 결과가 없습니다</td></tr>");
	
					// for(var i=0; i<1000; i++){
					//		$("#dataList").append("<tr code=1234 branchNo='1'><td colspan='4'>"+i+"조회 결과가 없습니다</td></tr>");
				    // }	
	            }else{
					for(var i=0; i < tot; i++){
						var obj = result['refreshData'][i];
		
		                var item;

						var dept = obj.atDept;

						if(dept.split('>').length > 1)
							dept = dept.split('>')[0];						
	                    
						item = "<tr>"
								+"<td>"+obj.atName+"</td>"
								+"<td class='txtP'><span>"+dept+"</span></td>"
								+"<td>"+obj.atPosition+"</td>"
								+"<td>"+obj.atSmsTele+"</td>"
								+"</tr>";
								
						$("#alertDataList").append(item);
					}
	            }

	            $("#alertDataList tr:odd").addClass("add");	
	
			},
	        error:function(result){
					$("#alertDataList").html("<tr><td colspan='4'>서버접속 실패</td></tr>");
		        }
		});
	}


	function refresh(){
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/situationctl/getTotalMntMainDetailTS.do'/>",
			data:{fact_code:fact_code,
					 branch_no:branch_no,
					 sys_kind:sys},
			dataType:"json",
			success:dataload_success,
	        error:function(result){
				$("#valueDataList").html("<tr><td colspan='"+(itemCnt + 1)+"'>서버 접속에 실패하였습니다!</td></tr>");
			}
		});
	}

	function setChartItem(caption, value)
	{
		 var option = "<option value='"+value+"'>"+caption+"</option>"
		 
 		 var selectElement = $("#select_item");
		 
		selectElement.append(option);
	}
	
	function initChartItem()
	{
		
		 
 		 var selectElement = $("#select_item");
		 
		selectElement.html("");
	}


	var turCnt = tmpCnt = phyCnt = dowCnt = conCnt = 0;
	var tmp2Cnt = phy2Cnt = dow2Cnt = con2Cnt = 0;
	var impCnt = limCnt = rimCnt = ltxCnt = rtxCnt = 0;
	var toxCnt = evnCnt = tofCnt = 0;
	var voc1Cnt = voc2Cnt = voc3Cnt = voc4Cnt = voc5Cnt = voc6Cnt = voc7Cnt = voc8Cnt = voc9Cnt = voc10Cnt = voc11Cnt = voc12Cnt = voc13Cnt = voc14Cnt = voc15Cnt = 0;
	var  copCnt = pluCnt = zinCnt = cadCnt = 0;
	var pheCnt = phlCnt = tocCnt = bodCnt = codCnt = susCnt = 0;
	var tonCnt = topCnt = nh4Cnt = no3Cnt = po4Cnt = rinCnt = 0;
	
	
	function dataload_success(result)
	{
		var tot = result['refreshData'].length;
		var trClass;

	    $("#valueDataList").html("");
	
	    if( tot <= "0" ){
			$("#valueDataList").html("<tr><td colspan='"+(itemCnt + 1)+"'>조회 결과가 없습니다</td></tr>");
	
			//for(var i=0; i<1000; i++){
			//	$("#dataList").append("<tr code=1234 branchNo='1'><td colspan='"+(2 + itemCnt)+"'>"+i+"조회 결과가 없습니다</td></tr>");
		   //}	
	    }
	    else
	    {
	    	$("#factName").text(result['refreshData'][0].branch_name);

	        var idx = 0;
			for(var i=0; i < tot; i++){
				var obj = result['refreshData'][i];
	            var item;
	
	            branch_name = obj.min_time;

	
				item = "<tr code='"+obj.fact_code+"' branchNo='"+obj.branch_no+ "'>";

					item += "<td>"+obj.strdate.substring(5,10) +" "+ obj.strtime+"</td>";


						if(sys != "A")
						{
							if(sys == "U")
							{
								item += "<td class='num'><span id='tur"+i+"'>" + ((obj.tur == "") ? "-" : obj.tur)+ "</span></td>"
								+"<td class='num'><span id='tmp"+i+"'>" + ((obj.tmp == "") ? "-" : obj.tmp)+ "</span></td>"
								+"<td class='num'><span id='phy"+i+"'>" + ((obj.phy == "") ? "-" : obj.phy)+ "</span></td>"
								+"<td class='num'><span id='dow"+i+"'>" + ((obj.dow == "") ? "-" : obj.dow)+ "</span></td>"
								+"<td class='num'><span id='con"+i+"'>" + ((obj.con == "") ? "-" : obj.con)+ "</span></td>";							
								 item += "<td class='num'><span id='tof"+i+"'>" + ((obj.tof == "") ? "-" : obj.tof)+ "</span></td>";
							}
							else
							{
								item += "<td class='num'><span id='phy"+i+"'>" + ((obj.phy == "") ? "-" : obj.phy)+ "</span></td>"
								+"<td class='num'><span id='bod"+i+"'>" + ((obj.bod == "") ? "-" : obj.bod)+ "</span></td>"
								+"<td class='num'><span id='cod"+i+"'>" + ((obj.cod == "") ? "-" : obj.cod)+ "</span></td>"
								+"<td class='num'><span id='sus"+i+"'>" + ((obj.sus == "") ? "-" : obj.sus)+ "</span></td>"
								+"<td class='num'><span id='ton"+i+"'>" + ((obj.ton == "") ? "-" : obj.ton)+ "</span></td>";							
								 item += "<td class='num'><span id='top"+i+"'>" + ((obj.top == "") ? "-" : obj.top)+ "</span></td>";
								
							}
						}
						if(sys == "A")
						{
							item += ""
							+"<td class='num'><span id='tur"+i+"'>" + ((obj.tur == "") ? "-" : obj.tur)+ "</span></td>"
							+ "<td class='num'><span id='phy"+i+"'>" + ((obj.phy == "") ? "-" : obj.phy)+ "</span></td>"
							+"<td class='num'><span id='dow"+i+"'>" + ((obj.dow == "") ? "-" : obj.dow)+ "</span></td>"
							+"<td class='num'><span id='con"+i+"'>" + ((obj.con == "") ? "-" : obj.con)+ "</span></td>"
							+"<td class='num'><span id='tmp"+i+"'>" + ((obj.tmp == "") ? "-" : obj.tmp)+ "</span></td>"
							//+"<td class='num'><span id='phy2_"+i+"'>" + ((obj.phy2 == "") ? "-" : obj.phy2)+ "</span></td>"
							//+"<td class='num'><span id='dow2_"+i+"'>" + ((obj.dow2 == "") ? "-" : obj.dow2)+ "</span></td>"
							//+"<td class='num'><span id='con2_"+i+"'>" + ((obj.con2 == "") ? "-" : obj.con2)+ "</span></td>"
							//+"<td class='num'><span id='tmp2_"+i+"'>" + ((obj.tmp2 == "") ? "-" : obj.tmp2)+ "</span></td>"
							+"<td class='num'><span id='toc"+i+"'>" + ((obj.toc == "") ? "-" : obj.toc)+ "</span></td>"
							+"<td class='num'><span id='imp"+i+"'>" + ((obj.imp == "") ? "-" : obj.imp)+ "</span></td>"
							+"<td class='num'><span id='lim"+i+"'>" + ((obj.lim == "") ? "-" : obj.lim)+ "</span></td>"
							+"<td class='num'><span id='rim"+i+"'>" + ((obj.rim == "") ? "-" : obj.rim)+ "</span></td>"
							+"<td class='num'><span id='ltx"+i+"'>" + ((obj.ltx == "") ? "-" : obj.ltx)+ "</span></td>"
							+"<td class='num'><span id='rtx"+i+"'>" + ((obj.rtx == "") ? "-" : obj.rtx)+ "</span></td>"
							+"<td class='num'><span id='tox"+i+"'>" + ((obj.tox == "") ? "-" : obj.tox)+ "</span></td>"
							+"<td class='num'><span id='evn"+i+"'>" + ((obj.evn == "") ? "-" : obj.evn)+ "</span></td>"
							+"<td class='num'><span id='voc1_"+i+"'>" + ((obj.voc1 == "") ? "-" : obj.voc1)+ "</span></td>"
							+"<td class='num'><span id='voc2_"+i+"'>" + ((obj.voc2 == "") ? "-" : obj.voc2)+ "</span></td>"
							+"<td class='num'><span id='voc3_"+i+"'>" + ((obj.voc3 == "") ? "-" : obj.voc3)+ "</span></td>"
							+"<td class='num'><span id='voc4_"+i+"'>" + ((obj.voc4 == "") ? "-" : obj.voc4)+ "</span></td>"
							+"<td class='num'><span id='voc5_"+i+"'>" + ((obj.voc5 == "") ? "-" : obj.voc5)+ "</span></td>"
							+"<td class='num'><span id='voc6_"+i+"'>" + ((obj.voc6 == "") ? "-" : obj.voc6)+ "</span></td>"
							+"<td class='num'><span id='voc7_"+i+"'>" + ((obj.voc7 == "") ? "-" : obj.voc7)+ "</span></td>"
							+"<td class='num'><span id='voc8_"+i+"'>" + ((obj.voc8 == "") ? "-" : obj.voc8)+ "</span></td>"
							+"<td class='num'><span id='voc9_"+i+"'>" + ((obj.voc9 == "") ? "-" : obj.voc9)+ "</span></td>"
							+"<td class='num'><span id='voc10_"+i+"'>" + ((obj.voc10 == "") ? "-" : obj.voc10)+ "</span></td>"
							+"<td class='num'><span id='voc11_"+i+"'>" + ((obj.voc11 == "") ? "-" : obj.voc11)+ "</span></td>"
							+"<td class='num'><span id='voc12_"+i+"'>" + ((obj.voc12 == "") ? "-" : obj.voc12)+ "</span></td>"
							+"<td class='num'><span id='voc13_"+i+"'>" + ((obj.voc13 == "") ? "-" : obj.voc13)+ "</span></td>"
							+"<td class='num'><span id='voc14_"+i+"'>" + ((obj.voc14 == "") ? "-" : obj.voc14)+ "</span></td>"
							+"<td class='num'><span id='voc15_"+i+"'>" + ((obj.voc15 == "") ? "-" : obj.voc15)+ "</span></td>"
							+"<td class='num'><span id='ton"+i+"'>" + ((obj.ton == "") ? "-" : obj.ton)+ "</span></td>"
							+"<td class='num'><span id='top"+i+"'>" + ((obj.top == "") ? "-" : obj.top)+ "</span></td>"
							+"<td class='num'><span id='nh4"+i+"'>" + ((obj.nh4 == "") ? "-" : obj.nh4)+ "</span></td>"
							+"<td class='num'><span id='no3"+i+"'>" + ((obj.no3 == "") ? "-" : obj.no3)+ "</span></td>"
							+"<td class='num'><span id='po4"+i+"'>" + ((obj.po4 == "") ? "-" : obj.po4)+ "</span></td>"
							+"<td class='num'><span id='tof"+i+"'>" + ((obj.tof == "") ? "-" : obj.tof)+ "</span></td>"
							+"<td class='num'><span id='cad"+i+"'>" + ((obj.cad == "") ? "-" : obj.cad)+ "</span></td>"
							+"<td class='num'><span id='plu"+i+"'>" + ((obj.plu == "") ? "-" : obj.plu)+ "</span></td>"
							+"<td class='num'><span id='cop"+i+"'>" + ((obj.cop == "") ? "-" : obj.cop)+ "</span></td>"
							+"<td class='num'><span id='zin"+i+"'>" + ((obj.zin == "") ? "-" : obj.zin)+ "</span></td>"
							+"<td class='num'><span id='phe"+i+"'>" + ((obj.phe == "") ? "-" : obj.phe)+ "</span></td>"
							+"<td class='num'><span id='phl"+i+"'>" + ((obj.phl == "") ? "-" : obj.phl)+ "</span></td>"
							+"<td class='num'><span id='rin"+i+"'>" + ((obj.rin == "") ? "-" : obj.rin)+ "</span></td>";
						}

						
				item += "</tr>";


				//없는 데이터 체크
				if(obj.tur != "")
					turCnt++;
				if(obj.tmp != "")
					tmpCnt++;
				if(obj.phy != "")
					phyCnt++;
				if(obj.dow != "")
					dowCnt++;
				if(obj.con != "")
					conCnt++;
				if(obj.tmp2 != "")
					tmp2Cnt++;
				if(obj.phy2 != "")
					phy2Cnt++;
				if(obj.dow2 != "")
					dow2Cnt++;
				if(obj.con2 != "")
					con2Cnt++;
				if(obj.imp != "")
					impCnt++;
				if(obj.lim != "")
					limCnt++;
				if(obj.rim != "")
					rimCnt++;
				if(obj.ltx != "")
					ltxCnt++;
				if(obj.rtx != "")
					rtxCnt++;
				if(obj.tox != "")
					toxCnt++;
				if(obj.evn != "")
					evnCnt++;
				if(obj.tof != "")
					tofCnt++;
				if(obj.voc1 != "")
					voc1Cnt++;
				if(obj.voc2 != "")
					voc2Cnt++;
				if(obj.voc3 != "")
					voc3Cnt++;
				if(obj.voc4 != "")
					voc4Cnt++;
				if(obj.voc5 != "")
					voc5Cnt++;
				if(obj.voc6 != "")
					voc6Cnt++;
				if(obj.voc7 != "")
					voc7Cnt++;
				if(obj.voc8 != "")
					voc8Cnt++;
				if(obj.voc9 != "")
					voc9Cnt++;
				if(obj.voc10 != "")
					voc10Cnt++;
				if(obj.voc11 != "")
					voc11Cnt++;
				if(obj.voc12 != "")
					voc12Cnt++;
				if(obj.voc13 != "")
					voc13Cnt++;
				if(obj.voc14 != "")
					voc14Cnt++;
				if(obj.voc15 != "")
					voc15Cnt++;
				if(obj.cop != "")
					copCnt++;
				if(obj.plu != "")
					pluCnt++;
				if(obj.zin != "")
					zinCnt++;
				if(obj.cad != "")
					cadCnt++;
				if(obj.phe != "")
					pheCnt++;
				if(obj.phl != "")
					phlCnt++;
				if(obj.toc != "")
					tocCnt++;
				if(obj.ton != "")
					tonCnt++;
				if(obj.top != "")
					topCnt++;
				if(obj.nh4 != "")
					nh4Cnt++;
				if(obj.po4 != "")
					po4Cnt++;
				if(obj.rin != "")
					rinCnt++;
				if(obj.cod != "")
					codCnt++;
				if(obj.bod != "")
					bodCnt++;
				if(obj.sus != "")
					susCnt++;
				

				$("#valueDataList").append(item);

				setMinOr_Color(obj.tur_or, $("#tur" + i));
				setMinOr_Color(obj.tmp_or, $("#tmp" + i));
				setMinOr_Color(obj.phy_or, $("#phy" + i));
				setMinOr_Color(obj.dow_or, $("#dow" + i));
				setMinOr_Color(obj.con_or, $("#con" + i));

				setMinOr_Color(obj.phy2_or, $("#phy2_" + i));
				setMinOr_Color(obj.dow2_or, $("#dow2_" + i));
				setMinOr_Color(obj.con2_or, $("#con2_" + i));
				setMinOr_Color(obj.tmp2_or, $("#tmp2_" + i));
				
				setMinOr_Color(obj.imp_or, $("#imp" + i));
				setMinOr_Color(obj.lim_or, $("#lim" + i));
				setMinOr_Color(obj.rim_or, $("#rim" + i));
				setMinOr_Color(obj.ltx_or, $("#ltx" + i));
				setMinOr_Color(obj.rtx_or, $("#rtx" + i));
				setMinOr_Color(obj.tox_or, $("#tox" + i));
				setMinOr_Color(obj.evn_or, $("#evn" + i));
				setMinOr_Color(obj.tof_or, $("#tof" + i));
				
				setMinOr_Color(obj.voc1_or, $("#voc1_" + i));
				setMinOr_Color(obj.voc2_or, $("#voc2_" + i));
				setMinOr_Color(obj.voc3_or, $("#voc3_" + i));
				setMinOr_Color(obj.voc4_or, $("#voc4_" + i));
				setMinOr_Color(obj.voc5_or, $("#voc5_" + i));
				setMinOr_Color(obj.voc6_or, $("#voc6_" + i));
				setMinOr_Color(obj.voc7_or, $("#voc7_" + i));
				setMinOr_Color(obj.voc8_or, $("#voc8_" + i));
				setMinOr_Color(obj.voc9_or, $("#voc9_" + i));
				setMinOr_Color(obj.voc10_or, $("#voc10_" + i));
				setMinOr_Color(obj.voc11_or, $("#voc11_" + i));
				setMinOr_Color(obj.voc12_or, $("#voc12_" + i));
				setMinOr_Color(obj.voc13_or, $("#voc13_" + i));
				setMinOr_Color(obj.voc14_or, $("#voc14_" + i));
				setMinOr_Color(obj.voc15_or, $("#voc15_" + i));

				setMinOr_Color(obj.cad_or, $("#cad" + i));
				setMinOr_Color(obj.plu_or, $("#plu" + i));
				setMinOr_Color(obj.cop_or, $("#cop" + i));
				setMinOr_Color(obj.zin_or, $("#zin" + i));

				setMinOr_Color(obj.phe_or, $("#phe" + i));
				setMinOr_Color(obj.phl_or, $("#phl" + i));

				setMinOr_Color(obj.toc_or, $("#toc" + i));
				
				setMinOr_Color(obj.ton_or, $("#ton" + i));
				setMinOr_Color(obj.top_or, $("#top" + i));
				setMinOr_Color(obj.bod_or, $("#bod" + i));
				setMinOr_Color(obj.cod_or, $("#cod" + i));
				setMinOr_Color(obj.sus_or, $("#sus" + i));
				setMinOr_Color(obj.nh4_or, $("#nh4" + i));
				setMinOr_Color(obj.no3_or, $("#no3" + i));
				setMinOr_Color(obj.po4_or, $("#po4" + i));

				setMinOr_Color(obj.rin_or, $("#rin" + i));

	   			idx++;		       
			}
	
			$("#valueDataList tr:odd").addClass("add");	
	    }
	    
	    
	    initChartItem();
	    
	    if(sys != "A")
	    {
	        setChartItem("표시항목(전체)", "all");
	    }

	    //하번이라도 측정된 데이터가 있을 때에만 SelectBox에 표시
	    if(turCnt > 0)
			setChartItem("탁도", "TUR00");
		if(tmpCnt >0)
			setChartItem("수온", "TMP00");
		if(phyCnt >0)
			setChartItem("pH", "PHY00");
		if(dowCnt >0)
			setChartItem("DO", "DOW00");
		if(conCnt >0)
			setChartItem("전기전도도", "CON00");
		if(tmp2Cnt > 0)
			setChartItem("수온", "CON01");
		if(phy2Cnt > 0)
			setChartItem("pH", "PHY01");
		if(dow2Cnt > 0)
			setChartItem("DO", "DOW01");
		if(con2Cnt > 0)
			setChartItem("전기전도도", "CON01");
		if(impCnt > 0)
			setChartItem("임펄스", "IMP00");
		if(limCnt > 0)
			setChartItem("임펄스(좌)", "LIM00");
		if(rimCnt > 0)
			setChartItem("임펄스(우)", "RIM00");
		if(ltxCnt > 0)
			setChartItem("독성지수(좌)", "LTX00");
		if(rtxCnt > 0)
			setChartItem("독성지수(우)", "RTX00");
		if(toxCnt > 0)
			setChartItem("미생물 독성지수", "TOX00");
		if(evnCnt > 0)
			setChartItem("조류 독성지수", "EVN00");
		if(tofCnt > 0)
			setChartItem("Chl-a", "TOF00");
		if(voc1Cnt > 0)
			setChartItem("염화메틸렌", "VOC01");
		if(voc2Cnt > 0)
			setChartItem("1.1.1-트리크롤로에테인", "VOC02");
		if(voc3Cnt > 0)
			setChartItem("벤젠", "VOC03");
		if(voc4Cnt > 0)
			setChartItem("사염화탄소", "VOC04");
		if(voc5Cnt > 0)
			setChartItem("트리클로로에틸렌", "VOC05");
		if(voc6Cnt > 0)
			setChartItem("톨루엔", "VOC06");
		if(voc7Cnt > 0)
			setChartItem("테트라클로로에틸렌", "VOC07");
		if(voc8Cnt > 0)
			setChartItem("에틸벤젠", "VOC08");
		if(voc9Cnt > 0)
			setChartItem("m,p-자일렌", "VOC09");
		if(voc10Cnt > 0)
			setChartItem("o-자일렌", "VOC10");
		if(voc11Cnt > 0)
			setChartItem("[ECD]염화메틸렌", "VOC11");
		if(voc12Cnt > 0)
			setChartItem("[ECD]1.1.1-트리클로로에테인", "VOC12");
		if(voc13Cnt > 0)
			setChartItem("[ECD]사염화탄소", "VOC13");
		if(voc14Cnt > 0)
			setChartItem("[ECD]트리클로로에틸렌", "VOC14");
		if(voc15Cnt > 0)
			setChartItem("[ECD]테트라클로로에틸렌", "VOC15");
		if(copCnt > 0)
			setChartItem("구리", "COP00");
		if(pluCnt > 0)
			setChartItem("납", "PLU00");
		if(zinCnt > 0)
			setChartItem("아연", "ZIN00");
		if(cadCnt > 0)
			setChartItem("카드뮴", "CAD00");
		if(pheCnt > 0)
			setChartItem("페놀1", "PHE00");
		if(phlCnt > 0)
			setChartItem("페놀2", "PHL00");
		if(tocCnt > 0)
			setChartItem("총유기탄소", "TOC00");
		if(tonCnt > 0)
			setChartItem("총질소", "TON00");
		if(topCnt > 0)
			setChartItem("총인", "TOP00");
		if(nh4Cnt > 0)
			setChartItem("암모니아성질소", "NH400");
		if(no3Cnt > 0)
			setChartItem("질산성질소", "NO300");
		if(po4Cnt > 0)
			setChartItem("인산염인", "PO400");
		if(rinCnt > 0)
			setChartItem("강수량", "RIN00");
		if(bodCnt > 0)
			setChartItem("BOD", "BOD00");
		if(codCnt > 0)
			setChartItem("COD", "COD00");
		if(susCnt > 0)
			setChartItem("SS", "SUS00");
		
		chart();

	    //else
		//{
		//    getItemDropDown();
	    //}
	    
	    
	}

	function getItemDropDown(){

		var itemCode = "";
		
		itemCode = "37";
		
		var dropDownSet = $('#select_item');

		dropDownSet.attr("disabled", false);
		$.getJSON("<c:url value='/cmmn/getCode.do'/>", {code_id:itemCode}, function (data, status){
		     if(status == 'success'){     
		        //item 객체에 SELECT 옵션내용 추가.
		        dropDownSet.loadSelectDepth3(data.codes, sys);

		        chart();
		     } else { 
		        //alert("ERROR!");
		        return;
		     }
		});	
	}

	//동적 SELECTBOX 구현을 위한 사용자 함수
	(function($) {

	//SELECT OPTION 삭제
	$.fn.emptySelect = function() {
	    return this.each(function(){
	      if (this.tagName=='SELECT') this.options.length = 0;
	    });
	 }

	//SELECT OPTION 등록
	$.fn.loadSelectDepth3 = function(optionsDataArray, sys) {
	    return this.emptySelect().each(function(){
	      if (this.tagName=='SELECT') {
	          var selectElement = this;
	          $.each(optionsDataArray,function(idx, optionData){

	              var option = new Option(optionData.CAPTION, optionData.VALUE);
	              //var first = new Option(TITLE, 'all');
	              if ($.browser.msie) {
						//if(idx == 0){selectElement.add(first);}
		                 
	                  selectElement.add(option);
	              }
	              else {
						//if(idx == 0){selectElement.add(first);}
	                  selectElement.add(option,null);
	              }
	          });

	      }
	   });
	 }
	})(jQuery);
	

	function setMinOr_Color(minorVal, tdObj)
	{
		tdObj.css("font-weight", "bold");
		
		switch(minorVal)
		{
			case "0":
				tdObj.css("color", "green");
				break;
			case "1" :
				tdObj.css("color", "blue");
				break;
			case "2" :
				tdObj.css("color", "#F0D010");
				break;
			case "3" :
				tdObj.css("color", "orange");
				break; 
			case "4" :
				tdObj.css("color", "red");
				break;
			default :
				//tdObj.css("color", "black");
				tdObj.css("color", "green");
				break;
		}
	}
	
    function chart(){

		var width = "800";
		var height = "473";

		var selectedItem = $("#select_item").val();

		document.chartForm.target = "chart";
		
		document.chartForm.factCode.value = fact_code;
		document.chartForm.branchNo.value = branch_no;
		document.chartForm.branchName.value = branch_name;
		document.chartForm.sys_kind.value = sys;
		document.chartForm.width.value = width;
		document.chartForm.height.value = height;
		document.chartForm.item.value = selectedItem;

		
		
		document.chartForm.action = "<c:url value='/waterpolmnt/situationctl/getTotalMntDetailGraph.do'/>";
		
		document.chartForm.submit();
	}



    
	function getHighDamData()
	{
		$("#damData").html("");
		
		if(sugye=="R01")
		{
			$("#spanDamName").text("충주댐 (042-629-3486)");
            var item;
			item = "<tr>"
					+"<td class='num'><span>139</span></td>"
					+"<td class='num'><span>54,302</span></td>"
					+"<td class='num'><span>290.07</span></td>"
					+"<td class='num'><span>401.01</span></td>"
					+"<td class='num'><span>68,725</span></td>"
					+"</tr>";
			$("#damData").append(item);
		}
		if(sugye=="R02")
		{
			$("#spanDamName").text("안동댐 (042-629-3462)");
            var item;
			item = "<tr>"
					+"<td class='num'><span>139</span></td>"
					+"<td class='num'><span>64,014</span></td>"
					+"<td class='num'><span>122</span></td>"
					+"<td class='num'><span>146.6</span></td>"
					+"<td class='num'><span>60,786</span></td>"
					+"</tr>";
			$("#damData").append(item);
		}
		if(sugye=="R03")
		{
			$("#spanDamName").text("용담댐 (042-629-3462)");
            var item;
			item = "<tr>"
					+"<td class='num'><span>244</span></td>"
					+"<td class='num'><span>62,111</span></td>"
					+"<td class='num'><span>22</span></td>"
					+"<td class='num'><span>11</span></td>"
					+"<td class='num'><span>19,386</span></td>"
					+"</tr>";
			$("#damData").append(item);
		}
		if(sugye=="R04")
		{
			$("#spanDamName").text("담양댐 (-)");
            var item;
			item = "<tr>"
					+"<td class='num'><span>-</span></td>"
					+"<td class='num'><span>-</span></td>"
					+"<td class='num'><span>-</span></td>"
					+"<td class='num'><span>-</span></td>"
					+"<td class='num'><span>-</span></td>"
					+"</tr>";
			$("#damData").append(item);
		}
		
		/* 실제 값을 가져오는 로직입니다. 맵핑테이블이 미완이라 봉인됨
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/situationctl/getHighDamInfo.do'/>",
			data:{factCode:fact_code,
					branchNo:branch_no
					},
			dataType:"json",
			success:function(result){
	            var obj = result['result'];
	            
				$("#damData").html("");
				
	            if( obj == null ){
					$("#damData").html("<tr><td colspan='5'>조회 결과가 없습니다</td></tr>");
	            }else{

						var damName = "";

						damName = obj.name + "(" + obj.ngiPhone + ")"
						$("#spanDamName").text(damName);
						
			            var item;
	                    
						item = "<tr>"
								+"<td class='num'><span>"+obj.swl+"</span></td>"
								+"<td class='num'><span>"+obj.sfw+"</span></td>"
								+"<td class='num'><span>"+obj.inf+"</span></td>"
								+"<td class='num'><span>"+obj.otf+"</span></td>"
								+"<td class='num'><span>"+obj.ecpc+"</span></td>"
								+"</tr>";
								
						$("#damData").append(item);
	            }
			},
	        error:function(result){
					$("#damData").html("<tr><td colspan='5'>서버접속 실패</td></tr>");
		        }
		});
		*/
	}


	function getLowWaterDCCenter()
	{
		$("#dcData").html("");
		if(sugye=="R01")
		{
			$("#spanDCName").text("광주정수장");
            var item;
			item = "<tr>"
					+"<td>조재하</td>"
					+"<td>031-760-2609</td>"
					+"<td class='num'><span>60,000</span></td>"
					+"</tr>";
			$("#dcData").append(item);
		}
		if(sugye=="R02")
		{
			$("#spanDCName").text("해평취수장");
            var item;
			item = "<tr>"
					+"<td>장경아</td>"
					+"<td>054-450-4248</td>"
					+"<td class='num'><span>464,000</span></td>"
					+"</tr>";
			$("#dcData").append(item);
		}
		if(sugye=="R03")
		{
			$("#spanDCName").text("옥천취수장");
            var item;
			item = "<tr>"
					+"<td>김성남</td>"
					+"<td><span>043-730-4852</td>"
					+"<td><span>20,000</td>"
					+"</tr>";
			$("#dcData").append(item);
		}
		if(sugye=="R04")
		{
			$("#spanDCName").text("-");
            var item;
			item = "<tr>"
					+"<tr><td colspan='3'>조회 결과가 없습니다</td></tr>"
					+"</tr>";
			$("#dcData").append(item);
		}
		
		/* 실제 값을 가져오는 로직입니다. 맵핑테이블이 미완이라 봉인됨
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/situationctl/getLowWaterDCCenter.do'/>",
			data:{factCode:fact_code,
					branchNo:branch_no
					},
			dataType:"json",
			success:function(result){
	            var obj = result['result'];
	            
				$("#dcData").html("");
				
	            if( obj == null ){
					$("#dcData").html("<tr><td colspan='3'>조회 결과가 없습니다</td></tr>");
	            }else{

						var damName = "";
						damName = obj.name;
						$("#spanDCName").text(damName);

			            var item;
	                    
						item = "<tr>"
								+"<td>"+obj.manager+"</td>"
								+"<td>"+obj.phone+"</td>"
								+"<td class='num'><span>"+obj.procQty+"</span></td>"
								+"</tr>";
								
						$("#dcData").append(item);
	            }
			},
	        error:function(result){
					$("#dcData").html("<tr><td colspan='3'>서버접속 실패</td></tr>");
		        }
		});
		*/
	}
	
</script>
</head>
<body class="popup">
<div id='loadingDiv'>
	<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />	
</div>
	<form id="chartForm" name="chartForm" method="post">
		<input type="hidden" name="factCode" />
		<input type="hidden" name="branchNo" />
		<input type="hidden" name="branchName" />
		<input type="hidden" name="sys_kind" />
		<input type="hidden" name="width"/>
		<input type="hidden" name="height"/>
		<input type="hidden" name="item"/>
	</form>
<div id="wrap" class="mainPop"> 
	<div class="pop_header">
		<div class="bg_header_r">
			<div class="bg_header">
<%-- 				<h1 class="pop_tit"><img src="<c:url value='/images/popup/h1_totalmntpopdetail.gif'/>" alt="측정소별상세정보" /></h1> --%>
				<h1 class="pop_tit">측정소별 상세 정보</h1>
			</div>
		</div>
	</div>
	<div class="pop_container">
		<div class="pop_container_r fixPop3Height">
<div class="totalmntPop3">
	<h1 id='factName' class="buRect_tit">-</h1>
		<div class="data">
			<div class="overBox_header" id="overBoxHeader" style="overflow:hidden;">
				<table class="dataTable titleTable" id="dataTableHeader" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
					<colgroup id="dataTableHeaderColGroup">
						<c:if test="${param.sys_kind == 'T'}">
							<col width="71px" />
							<col width="51px" />
							<col width="51px" />
							<col width="51px" />
							<col width="51px" />
							<col width="51px" />
							<col width="100%"/>
						</c:if>
						<c:if test="${param.sys_kind == 'U'}">
							<col width="71px" />
							<col width="51px" />
							<col width="51px" />
							<col width="51px" />
							<col width="51px" />
							<col width="51px" />
							<col width="100%"/>
						</c:if>
						<c:if test="${param.sys_kind == 'A'}">
							<col width="75px" />
							<col width="58px" />
							<col width="58px" />
							<col width="58px" />
							<col width="58px" />
							<col width="58px" />
							<col width="58px" />
							<col width="58px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />	
							<col width="100%"/>
						</c:if>
						<col/>
					</colgroup>
					<thead id="valueDataHeader">
					</thead>
				</table>
			</div>
			<div class="overConBox" id="overConBox" onscroll="scrollX()">
				<table class="dataTable conTable"  id="dataTable" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
					<colgroup id="dataTableColGroup">
						<c:if test="${param.sys_kind == 'T'}">
								<col width="71px" />
							<col width="51px" />
							<col width="51px" />
							<col width="51px" />
							<col width="51px" />
							<col width="51px" />
							<col width="100%"/>
						</c:if>
						<c:if test="${param.sys_kind == 'U'}">
							<col width="71px" />
							<col width="51px" />
							<col width="51px" />
							<col width="51px" />
							<col width="51px" />
							<col width="51px" />
							<col width="100%"/>
						</c:if>
						<c:if test="${param.sys_kind == 'A'}">
							<col width="75px" />
							<col width="58px" />
							<col width="58px" />
							<col width="58px" />
							<col width="58px" />
							<col width="58px" />
							<col width="58px" />
							<col width="58px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="85px" />
							<col width="100%"/>
						</c:if>
					</colgroup>
					<tbody id="valueDataList">
					</tbody>
				</table>
			</div>
			<script type="text/javascript">
			function scrollX()
			{		
						document.getElementById("overBoxHeader").scrollLeft = document.getElementById("overConBox").scrollLeft;
			}
			</script>
		</div>
		 <!-- <h1 class="buRect_tit" style="float:right">수질변화 추이</h1>  -->
		<div class="graph">
	   		<div class="con_area">
			    <div class="tit_area" style="position:absolute;padding-left:10px;padding-top:0px">
			    <p>
			    	 <span class="buArrow_tit">수질 항목</span>&nbsp;
				     <select id="select_item"></select>
			    </p>
			   </div>
		   		<iframe id="chart"  name="chart" onload='chartLoaded();' src="" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" width="100%" height="472px"></iframe>
		   </div>
		</div>
	<div class="sta_info_area">
		<div class="listBox firstBox">
			<div class="tit_select">
				<h2>상황전파 대상</h2>
				<form action="">
					<p class="select">
						<select id="dept">
							<option value="all">전체</option>
						</select>
					</p>
				</form>
			</div>
			<div style="clear:both">
				<table class="dataTable">
					<colgroup>
						<col width="50px" />
						<col width="140px" />
						<col width="70px" />
						<col width="" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">이름</th>
							<th scope="col">소속</th>
							<th scope="col">직책</th>
							<th scope="col">연락처</th>
						</tr>
					</thead>
				</table>
			</div>
			<div class="overBox">
				<table class="dataTable">
					<colgroup>
						<col width="50px" />
						<col width="140px" />
						<col width="70px" />
						<col width="" />
					</colgroup>
					<tbody id="alertDataList">
						<tr>
							<td colspan="4">데이터를 불러오는 중 입니다...</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="listBox">
			<h2>상위 댐 정보  > <span id="spanDamName">-</span></h2>
			<div class="overBox overBoxOther1">
				<table class="dataTable">
					<colgroup>
						<col width="" />
						<col width=""/>
						<col width=""/>
						<col width=""/>
						<col />
					</colgroup>
					<thead>
						<tr>
							<th>저수위<br/>(m)</th>
							<th>저수량<br/>(㎥)</th>
							<th>유입량<br/>(㎥/s)</th> 
							<th>방류량<br/>(㎥/s)</th> 
							<th>공용량<br/>(㎥)</th> 
						</tr>
					</thead>
					<tbody id="damData">
						<tr>
							<td colspan="5">데이터를 불러오고있습니다...</td>
						</tr>
					</tbody>
				</table>
			<h2 style="padding-top:15px; float:none;">하위 취&middot;정수장 정보 > <span id="spanDCName">-</span></h2>
			<div>
				<table class="dataTable">
					<colgroup>
						<col width="" />
						<col width="" />
						<col />
					</colgroup>
					<thead>
						<tr>
							<th>담당자</th>
							<th>연락처</th>						
							<th>처리용량(㎥)</th>										
						</tr>
					</thead>
					<tbody id="dcData">
						<tr>
							<td colspan="3">데이터를 불러오고있습니다...</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
</div>
	</div>
	<div class="pop_footer">
		<div class="bg_footer_r">
			<div class="bg_footer">
			</div>
		</div>
	</div>
</div>
</div>
</body>
</html>

