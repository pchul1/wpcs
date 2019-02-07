<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
	
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

		 if(sys == "A")
		 {
			 $("#dataTable").attr("class", "dataTable_broad");
			 $("#dataTableHeader").attr("class", "dataTable_broad");

			 $("#overBoxHeader").css("overflow-y","scroll");
			 
			 $("#overConBox").css("height", "632px");
		 }
		 
		 itemSetting(sys);
		 makeHeader();
		 
		 reloadData();
		 alertTargetList();

		 $("#atDepth").change(function(){ changeDepth(); });

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
		 if(sys != "A")
		 {
			 itemCnt = 5;
			 itemArray = new Array(itemCnt);
			 itemCode = new Array(itemCnt);
			 itemArray[0] = "탁도<br/>(NTU)"; 	itemCode[0] = "TUR";
			 itemArray[1] = "수온<br/>(℃)";	itemCode[1] = "TMP";
			 itemArray[2] = "pH";	itemCode[2] = "PHY";
			 itemArray[3] = "DO<br/>(mg/L)";	itemCode[3] = "DOW";
			 itemArray[4] = "EC<br/>(mS/cm)";	itemCode[4] = "CON";
		 }
		 else if(sys=="A")
		 {
			 itemCnt = 45;
			 itemArray = new Array(itemCnt);
			 itemCode = new Array(itemCnt);
			 itemArray[0] = "pH1";			itemCode[0] = "PHY00";
			 itemArray[1] = "DO1<br/>(mg/L)";		itemCode[1] = "DOW00";
			 itemArray[2] = "EC1<br/>(mS/cm)";	itemCode[2] = "CON00";
			 itemArray[3] = "수온1<br/>(℃)"; 	itemCode[3] = "TMP00";
			 itemArray[4] = "pH2";			itemCode[4] = "PHY01";
			 itemArray[5] = "DO2<br/>(mg/L)";		itemCode[5] = "DOW01";
			 itemArray[6] = "EC2<br/>(mS/cm)";	itemCode[6] = "CON01";
			 itemArray[7] = "수온2<br/>(℃)"; 	itemCode[7] = "TMP01";
			 itemArray[8] = "탁도<br/>(NTU)";		itemCode[8] = "TUR01";
			 itemArray[9] = "임펄스<br/>"; 	itemCode[9] = "IMP00";
			 itemArray[10] = "임펄스<br/>(좌)";	itemCode[10] = "LIM00";
			 itemArray[11] = "임펄스<br/>(우)";	itemCode[11] = "RIM00";
			 itemArray[12] = "독성지수<br/>(좌)";	itemCode[12] = "LTX00";
			 itemArray[13] = "독성지수<br/>(우)";	itemCode[13] = "RTX00";
			 itemArray[14] = "미생물<br/>독성지수(%)";	itemCode[14] = "TOX00";
			 itemArray[15] = "조류<br/>독성지수";		itemCode[15] = "EVN00";
			 itemArray[16] = "클로로필-a";		itemCode[16] = "TOF00";
			 itemArray[17] = "염화메틸렌";	itemCode[17] = "VOC01";			 		 
			 itemArray[18] = "1.1.1-트리클로로에테인";	itemCode[18] = "VOC02";
			 itemArray[19] = "사염화탄소";		itemCode[19] = "VOC04";
			 itemArray[20] = "벤젠"; 	itemCode[20] = "VOC03";
			 itemArray[21] = "트리클로로에틸렌";	itemCode[21] = "VOC05";
			 itemArray[22] = "톨루엔";		itemCode[22] = "VOC06";
			 itemArray[23] = "테트라클로로에티렌";	itemCode[23] = "VOC07";			 		 
			 itemArray[24] = "에틸벤젠";	itemCode[24] = "VOC08";
			 itemArray[25] = "m,p-자일렌";	itemCode[25] = "VOC09";
			 itemArray[26] = "o-자일렌"; itemCode[26] = "VOC10";
			 itemArray[27] = "[ECD]염화메틸렌"; 	itemCode[27] = "VOC11";
			 itemArray[28] = "[ECD]1.1.1-트리클로로에테인";	itemCode[28] = "VOC12";
			 itemArray[29] = "[ECD]사염화탄소";	itemCode[29] = "VOC13";			 		 
			 itemArray[30] = "[ECD]트리클로로에틸렌";	itemCode[30] = "VOC14";
			 itemArray[31] = "[ECD]테트라클로로에티렌"; 	itemCode[31] = "VOC15";
			 itemArray[32] = "카드뮴";	itemCode[32] = "CAD00";
			 itemArray[33] = "납";	itemCode[33] = "PLU00";
			 itemArray[34] = "구리";	itemCode[34] = "COP00";
			 itemArray[35] = "아연";	itemCode[35] = "ZIN00";
			 itemArray[36] = "페놀1";	itemCode[36] = "PHE00";
			 itemArray[37] = "페놀2";	itemCode[37] = "PHL00";
			 itemArray[38] = "총유기탄소";	itemCode[38] = "TOC00";
			 itemArray[39] = "총질소";	itemCode[39] = "TON00";
			 itemArray[40] = "총인";	itemCode[40] = "TOP00";
			 itemArray[41] = "암모니아성질소";	itemCode[41] = "NH400";
			 itemArray[42] = "질산성질소";	itemCode[42] = "NO300";
			 itemArray[43] = "인산염인";	itemCode[43] = "PO400";
			 itemArray[44] = "강수량";	itemCode[44] = "RIN00";
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
							"<th colspan ='4' scope='col'>일반항목<br/>(내부)</th>"+
							"<th colspan ='5' scope='col'>일반항목<br/>(외부)</th>"+
							"<th colspan='1' scope='col'>생물독성<br/>(물고기)</th>" + 
							"<th colspan='2' scope='col'>생물독성<br/>(물벼룩1)</th>" +
							"<th colspan='2' scope='col'>생물독성<br/>(물벼룩2)</th>" +									
							"<th colspan='1' scope='col'>생물독성<br/>(미생물)</th>" +
							"<th colspan='1' scope='col'>생물독성<br/>(조류)</th>" +
							"<th colspan='1' scope='col'>클로로필-a</th>" +
							"<th colspan='15' scope='col'>휘발성<br/>유기화합물</th>" +
							"<th colspan='4' scope='col'>중금속</th>" +
							"<th colspan='2' scope='col'>페놀</th>" +
							"<th colspan='1' scope='col'>유기물질</th>" +
							"<th colspan='5' scope='col'>영양염류</th>" +
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


	
	function alertTargetList(){

		var atDepth = $("#atDepth").val();

		$("#alertDataList").html("");
		$("#alertDataList").html("<tr><td colspan='4'>데이터를 불러오는 중 입니다...</td></tr>");

		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/situationctl/getAlertTargetList.do'/>",
			data:{factCode:fact_code,
					branchNo:branch_no,
					atDepth:atDepth},
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
					 branch_no:branch_no},
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


	var turCnt = tmpCnt = phyCnt = dowCnt = conCnt = 0;
	var tmp2Cnt = phy2Cnt = dow2Cnt = con2Cnt = 0;
	var impCnt = limCnt = rimCnt = ltxCnt = rtxCnt = 0;
	var toxCnt = evnCnt = tofCnt = 0;
	var voc1Cnt = voc2Cnt = voc3Cnt = voc4Cnt = voc5Cnt = voc6Cnt = voc7Cnt = voc8Cnt = voc9Cnt = voc10Cnt = voc11Cnt = voc12Cnt = voc13Cnt = voc14Cnt = voc15Cnt = 0;
	var  copCnt = pulCnt = zinCnt = cadCnt = 0;
	var pheCnt = phlCnt = tocCnt = 0;
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
	    	$("#factName").text(result['refreshData'][0].branch_name + "-" + branch_no);

	        var idx = 0;
			for(var i=0; i < tot; i++){
				var obj = result['refreshData'][i];
	            var item;
	
	            branch_name = obj.min_time;

	
				item = "<tr code='"+obj.fact_code+"' branchNo='"+obj.branch_no+ "'>"
						+"<td>"+obj.min_time.substring(5,18)+"</td>";


						if(sys != "A")
						{
							item += "<td class='num'><span id='tur"+i+"'>" + ((obj.tur == "") ? "-" : obj.tur)+ "</span></td>"
							+"<td class='num'><span id='tmp"+i+"'>" + ((obj.tmp == "") ? "-" : obj.tmp)+ "</span></td>"
							+"<td class='num'><span id='phy"+i+"'>" + ((obj.phy == "") ? "-" : obj.phy)+ "</span></td>"
							+"<td class='num'><span id='dow"+i+"'>" + ((obj.dow == "") ? "-" : obj.dow)+ "</span></td>"
							+"<td class='num'><span id='con"+i+"'>" + ((obj.con == "") ? "-" : obj.con)+ "</span></td>";
						}
						if(sys == "A")
						{
							item += "<td class='num'><span id='phy"+i+"'>" + ((obj.phy == "") ? "-" : obj.phy)+ "</span></td>"
							+"<td class='num'><span id='dow"+i+"'>" + ((obj.dow == "") ? "-" : obj.dow)+ "</span></td>"
							+"<td class='num'><span id='con"+i+"'>" + ((obj.con == "") ? "-" : obj.con)+ "</span></td>"
							+"<td class='num'><span id='tmp"+i+"'>" + ((obj.tmp == "") ? "-" : obj.tmp)+ "</span></td>"
							+"<td class='num'><span id='phy2_"+i+"'>" + ((obj.phy2 == "") ? "-" : obj.phy2)+ "</span></td>"
							+"<td class='num'><span id='dow2_"+i+"'>" + ((obj.dow2 == "") ? "-" : obj.dow2)+ "</span></td>"
							+"<td class='num'><span id='con2_"+i+"'>" + ((obj.con2 == "") ? "-" : obj.con2)+ "</span></td>"
							+"<td class='num'><span id='tmp2_"+i+"'>" + ((obj.tmp2 == "") ? "-" : obj.tmp2)+ "</span></td>"
							+"<td class='num'><span id='tur"+i+"'>" + ((obj.tur == "") ? "-" : obj.tur)+ "</span></td>"
							+"<td class='num'><span id='imp"+i+"'>" + ((obj.imp == "") ? "-" : obj.imp)+ "</span></td>"
							+"<td class='num'><span id='lim"+i+"'>" + ((obj.lim == "") ? "-" : obj.lim)+ "</span></td>"
							+"<td class='num'><span id='rim"+i+"'>" + ((obj.rim == "") ? "-" : obj.rim)+ "</span></td>"
							+"<td class='num'><span id='ltx"+i+"'>" + ((obj.ltx == "") ? "-" : obj.ltx)+ "</span></td>"
							+"<td class='num'><span id='rtx"+i+"'>" + ((obj.rtx == "") ? "-" : obj.rtx)+ "</span></td>"
							+"<td class='num'><span id='tox"+i+"'>" + ((obj.tox == "") ? "-" : obj.tox)+ "</span></td>"
							+"<td class='num'><span id='evn"+i+"'>" + ((obj.evn == "") ? "-" : obj.evn)+ "</span></td>"
							+"<td class='num'><span id='tof"+i+"'>" + ((obj.tof == "") ? "-" : obj.tof)+ "</span></td>"
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
							+"<td class='num'><span id='cad"+i+"'>" + ((obj.cad == "") ? "-" : obj.cad)+ "</span></td>"
							+"<td class='num'><span id='pul"+i+"'>" + ((obj.pul == "") ? "-" : obj.pul)+ "</span></td>"
							+"<td class='num'><span id='cop"+i+"'>" + ((obj.cop == "") ? "-" : obj.cop)+ "</span></td>"
							+"<td class='num'><span id='zin"+i+"'>" + ((obj.zin == "") ? "-" : obj.zin)+ "</span></td>"
							+"<td class='num'><span id='phe"+i+"'>" + ((obj.phe == "") ? "-" : obj.phe)+ "</span></td>"
							+"<td class='num'><span id='phl"+i+"'>" + ((obj.phl == "") ? "-" : obj.phl)+ "</span></td>"
							+"<td class='num'><span id='toc"+i+"'>" + ((obj.toc == "") ? "-" : obj.toc)+ "</span></td>"
							+"<td class='num'><span id='ton"+i+"'>" + ((obj.ton == "") ? "-" : obj.ton)+ "</span></td>"
							+"<td class='num'><span id='top"+i+"'>" + ((obj.top == "") ? "-" : obj.top)+ "</span></td>"
							+"<td class='num'><span id='nh4"+i+"'>" + ((obj.nh4 == "") ? "-" : obj.nh4)+ "</span></td>"
							+"<td class='num'><span id='no3"+i+"'>" + ((obj.no3 == "") ? "-" : obj.no3)+ "</span></td>"
							+"<td class='num'><span id='po4"+i+"'>" + ((obj.po4 == "") ? "-" : obj.po4)+ "</span></td>"
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
				if(obj.pul != "")
					pulCnt++;
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
				setMinOr_Color(obj.pul_or, $("#pul" + i));
				setMinOr_Color(obj.cop_or, $("#cop" + i));
				setMinOr_Color(obj.zin_or, $("#zin" + i));

				setMinOr_Color(obj.phe_or, $("#phe" + i));
				setMinOr_Color(obj.phl_or, $("#phl" + i));

				setMinOr_Color(obj.toc_or, $("#toc" + i));
				
				setMinOr_Color(obj.ton_or, $("#ton" + i));
				setMinOr_Color(obj.top_or, $("#top" + i));
				setMinOr_Color(obj.nh4_or, $("#nh4" + i));
				setMinOr_Color(obj.no3_or, $("#no3" + i));
				setMinOr_Color(obj.po4_or, $("#po4" + i));

				setMinOr_Color(obj.rin_or, $("#rin" + i));

	   			idx++;		       
			}
	
			$("#valueDataList tr:odd").addClass("add");	
	    }

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
			setChartItem("수온2", "CON01");
		if(phy2Cnt > 0)
			setChartItem("pH2", "PHY01");
		if(dow2Cnt > 0)
			setChartItem("DO2", "DOW01");
		if(con2Cnt > 0)
			setChartItem("전기전도도2", "CON02");
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
			setChartItem("클로로필-a", "TOF00");
		if(voc1Cnt > 0)
			setChartItem("염화메틸렌", "VOC01");
		if(voc2Cnt > 0)
			setChartItem("1.1.1-트리크롤로에테인", "VOC02");
		if(voc3Cnt > 0)
			setChartItem("사염화탄소", "VOC03");
		if(voc4Cnt > 0)
			setChartItem("벤젠", "VOC04");
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
		if(pulCnt > 0)
			setChartItem("납", "PUL00");
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
				<h1 class="pop_tit"><img src="<c:url value='/images/popup/h1_totalmntpopdetail.gif'/>" alt="측정소별상세정보" /></h1>
			</div>
		</div>
	</div>
	<div class="pop_container">
		<div class="pop_container_r fixPop3Height">
<div class="totalmntPop3">
	<h1 id='factName' class="buRect_tit">-</h1>
		<div class="data" style="border:0;">
						<!--// areaTOver_totalmntpopdetail_simple  -->
						<div id="areaTOver_totalmntpopdetail_simple" class="areaTOver">
						<!-- areaTHeader_intercptn -->
						<div id="areaTHeader_intercptn">
							<table id="tableHeader_intercptn" class="dataTable" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
						   	<colgroup>						    	
						        <col width="80" />
						    </colgroup>
							<thead>						    
						    <tr>						    	
						        <th scope="col">시간</th>
						    </tr>
						    </thead>
						    </table>
						</div>
						<!--// areaTHeader_intercptn -->

						<!-- areaTHeader_top -->
						<div id="areaTHeader_top" >
							<table id="tableHeader_top" class="dataTable" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
						    <colgroup>
								<col width="62" />
								<col width="62" />
								<col width="62" />
								<col width="62" />
								<col class="lastth" />
							</colgroup>
							<thead>
						    <tr>
						    	<th scope="colgroup" colspan="5">수질정보</th>						        
						    </tr>
						    <tr>
						        <th scope="col">탁도<br />(NTU)</th>
						        <th scope="col">수온1<br />(℃)</th>
						        <th scope="col">pH</th>
						        <th scope="col">DO<br />(mg/L)</th>						        
						        <th scope="col">EC1<br />(mS/cm)</th>
						    </tr>
						    </thead>
						    </table>
						</div>
						<!--// areaTHeader_top -->

						<!-- areaTHeader_left -->
						<div id="areaTHeader_left" style="overflow:hidden;float:left;clear:left;">
							<table id="tableHeader_left" class="dataTable" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">							
							<colgroup>
						        <col width="80" />						        
						    </colgroup>
							<tbody>
							<%for(int i = 0 ; i < 20 ; i++) {%>
							<tr class="undefined">
						    	<td class="num"><span>10.15 10:40</span></td>						        
						    </tr>
						    <tr class="add">
						    	<td class="num"><span>10.15 10:40</span></td>
						    </tr>
							<%}%>
							</tbody>
						    </table>
						</div>
						<!-- // areaTHeader_left -->

						<!-- areaTData -->
						<div id="areaTData" onscroll="scroll()">
							<table id="tableData" class="dataTable" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
							<colgroup>
							       	<col width="62" />	
							       	<col width="62" />
							       	<col width="62" />
							       	<col width="62" />
							       	<col class="lasttd" />
							</colgroup>
					    	<tbody>
					    	<%for(int i = 0 ; i < 20 ; i++) {%>					    	
							<tr class="undefined">
						        <td class="num"><span id="tur0">tur0</span></td>  
						        <td class="num"><span id="tmp0">tmp0</span></td>
						        <td class="num"><span id="phy0">phy0</span></td>
						        <td class="num"><span id="dow0">dow0</span></td>								
						        <td class="num"><span id="con0">con0</span></td>
						    </tr>
						    <tr class="add">	
						        <td class="num"><span id="tur0">tur0</span></td>  
						        <td class="num"><span id="tmp0">tmp0</span></td>
						        <td class="num"><span id="phy0">phy0</span></td>
						        <td class="num"><span id="dow0">dow0</span></td>								
						        <td class="num"><span id="con0">con0</span></td>
						    </tr>
							<%}%>   
							</tr>
							</tbody>
						    </table>
						</div>
						<!-- areaTData -->

						<script type="text/javascript">
						var areaTHeader_top = document.getElementById("areaTHeader_top");
						var areaTHeader_left = document.getElementById("areaTHeader_left");
						var areaTData = document.getElementById("areaTData");
						function scroll()
						{
							areaTHeader_top.scrollLeft = areaTData.scrollLeft;
							areaTHeader_left.scrollTop = areaTData.scrollTop;
						}	
						</script>			
							
						</div>
						<!--// areaTOver_totalmntpopdetail_simple -->
		</div>
		 <!-- <h1 class="buRect_tit" style="float:right">수질변화 추이</h1>  -->
		<div class="graph">
	   		<div class="con_area">
			    <div class="tit_area" style="position:absolute;padding-left:590px;padding-top:0px">
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
						<select id="atDepth">
							<option value="all">전체</option>
							<option value="0">정상</option>
							<option value="1">관심</option>
							<option value="2">주의</option>
							<option value="3">경계</option>
							<option value="4">심각</option>
						</select>
					</p>
				</form>
			</div>
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
			<h2>상위 댐 정보  > <span>안동댐(02-2110-6325)</span></h2>
			<div class="overBox overBoxOther1">
				<table class="dataTable">
					<colgroup>
						<col width="" />
						<col width=""/>
						<col width=""/>
						<col width=""/>
						<col />
					</colgroup>
					<tr>
						<th>저수위</th>
						<th>저수량</th>
						<th>유입량</th> 
						<th>방류량</th> 
						<th>공용량</th> 
					</tr>
					<tr>
						<td class='num'><span>138845.5</span></td>
						<td class='num'><span>9112.0</span></td>
						<td class='num'><span>92.0</span></td>
						<td class='num'><span>92.8</span></td>
						<td class='num'><span>8473</span></td>
					</tr>
				</table>
			<h2 style="padding-top:15px">하위 취&middot;정수장 정보 > <span>공단정수장</span></h2>
			<!--  -->
			<div style="clear:both;">
				<table class="dataTable">
					<colgroup>
						<col width="" />
						<col width="" />
						<col />
					</colgroup>
					<tr>
						<th>담당자</th>
						<th>연락처</th>						
						<th>처리용량(㎥)</th>										
					</tr>
					<tr>
						<td>장경아</td>
						<td>054-450-4248</td>
						<td class='num'><span>40000</span></td>
					</tr>
				</table>
			</div>
			<!--  -->
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

