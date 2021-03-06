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
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />
	
	<script src="<c:url value='/js/JQuery/jquery-1.3.2.min.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js" type="text/javascript'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>
	
	<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.datepicker.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery.fixedheader.js'/>"></script>
	
	<script type='text/javascript'>
	var sys;
	var river;
	var step;
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
		
		sys = '${param.sys}';
		river = '${param.river}';
		step = '${param.step}';
		
		var headertext = "";
		
		switch(step)
		{
			case "0":
				headertext = "정상";
			    break;
			case "1":
				if(sys == "T")
				{
					headertext = "주의(70%)";
				}
				else
				{
					headertext = "관심";
				}
			    break;
			case "2":
				if(sys == "T")
				{
					headertext = "경보(90%)";
				}
				else
				{
					headertext = "주의";
				}
			    break;
			case "3":
				if(sys == "T")
				{
					headertext = "초과";
				}
				else
				{
					headertext = "경계";
				}
			    break;
			case "4":
				headertext = "심각";
			    break;
		}
		
		
		if(sys == "A")
		{
			$("#dataTable").attr("class", "dataTable_broad");
			$("#overBox").css("overflow", "scroll");
			$("#dataTableHeader").attr("class", "dataTable_broad");
			$("#overBoxHeader").attr("style", "overflow-x:hidden;overflow-y:scroll");
			
		}
		
		$("#header").html("<h1>경보단계별 상세정보[" + headertext + "]</h1>");
		itemSetting();
		makeHeader();
		
		dataLoad();
		reloadData();
	});
	
	function loadingClose()
	{
		$("#loadingDiv").dialog("close");
	}
	
	//itemArray 셋팅 
	function itemSetting()
	{
		
		if(sys == "T")
		{
			itemCnt = 6;
			itemArray = new Array(itemCnt);
			itemCode = new Array(itemCnt);
			itemArray[0] = "pH";	itemCode[0] = "PHY";
			itemArray[1] = "BOD(ppm)";	itemCode[1] = "BOD";
			itemArray[2] = "COD(ppm)";	itemCode[2] = "COD";
			itemArray[3] = "SS(mg/L)";	itemCode[3] = "SUS";
			itemArray[4] = "T-N(mg/L)";	itemCode[4] = "TON";
			itemArray[5] = "T-P(mg/L)";	itemCode[5] = "TOP";
			
		}
		if(sys == "U")
		{
			itemCnt = 6;
			itemArray = new Array(itemCnt);
			itemCode = new Array(itemCnt);
			itemArray[0] = "탁도(NTU)";	itemCode[0] = "TUR";
			itemArray[1] = "수온(℃)";	itemCode[1] = "TMP";
			itemArray[2] = "pH";	itemCode[2] = "PHY";
			itemArray[3] = "DO(mg/L)";	itemCode[3] = "DOW";
			itemArray[4] = "EC(mS/cm)";	itemCode[4] = "CON";
			itemArray[5] = "Chl-a(μg/L)";	itemCode[5] = "TOF";
		}
		else if(sys=="A")
		{
			itemCnt = 41;
			itemArray = new Array(itemCnt);
			itemCode = new Array(itemCnt);
			itemArray[0] = "탁도<br/>(NTU)";		itemCode[0] = "TUR00";
			itemArray[1] = "pH";			itemCode[1] = "PHY00";
			itemArray[2] = "DO<br/>(mg/L)";		itemCode[2] = "DOW00";
			//itemArray[3] = "EC<br/>(mS/cm)";	itemCode[3] = "CON00";
			itemArray[3] = "EC<br/>(μS/cm)";	itemCode[3] = "CON00";
			itemArray[4] = "수온<br/>(℃)";	itemCode[4] = "TMP00";
			//itemArray[5] = "pH2";			itemCode[5] = "PHY01";
			//itemArray[6] = "DO2<br/>(mg/L)";		itemCode[6] = "DOW01";
			//itemArray[7] = "EC2<br/>(mS/cm)";	itemCode[7] = "CON01";
			//itemArray[8] = "수온2<br/>(℃)";	itemCode[8] = "TMP01";
			itemArray[5] = "총유기탄소";	itemCode[5] = "TOC00";
			itemArray[6] = "임펄스<br/>";	itemCode[6] = "IMP00";
			itemArray[7] = "임펄스<br/>(좌)";	itemCode[7] = "LIM00";
			itemArray[8] = "임펄스<br/>(우)";	itemCode[8] = "RIM00";
			itemArray[9] = "독성지수<br/>(좌)";	itemCode[9] = "LTX00";
			itemArray[10] = "독성지수<br/>(우)";	itemCode[10] = "RTX00";
			itemArray[11] = "미생물<br/>독성지수(%)";	itemCode[11] = "TOX00";
			itemArray[12] = "조류<br/>독성지수";		itemCode[12] = "EVN00";
			itemArray[13] = "염화메틸렌";	itemCode[13] = "VOC01";
			itemArray[14] = "1.1.1-트리클로로에테인";	itemCode[14] = "VOC02";
			itemArray[15] = "벤젠";		itemCode[15] = "VOC03";
			itemArray[16] = "사염화탄소";	itemCode[16] = "VOC04";
			itemArray[17] = "트리클로로에틸렌";	itemCode[17] = "VOC05";
			itemArray[18] = "톨루엔";		itemCode[18] = "VOC06";
			itemArray[19] = "테트라클로로에티렌";	itemCode[19] = "VOC07";
			itemArray[20] = "에틸벤젠";	itemCode[20] = "VOC08";
			itemArray[21] = "m,p-자일렌";	itemCode[21] = "VOC09";
			itemArray[22] = "o-자일렌"; itemCode[22] = "VOC10";
			itemArray[23] = "[ECD]염화메틸렌";	itemCode[23] = "VOC11";
			itemArray[24] = "[ECD]1.1.1-트리클로로에테인";	itemCode[24] = "VOC12";
			itemArray[25] = "[ECD]사염화탄소";	itemCode[25] = "VOC13";
			itemArray[26] = "[ECD]트리클로로에틸렌";	itemCode[26] = "VOC14";
			itemArray[27] = "[ECD]테트라클로로에티렌";	itemCode[27] = "VOC15";
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
			$("#dataHeader").html("");
			header = "<tr>" + 
							"<th rowspan ='2' scope='col'>지역</th>" +
							"<th rowspan ='2' scope='col'>측정소</th>" +
							"<th rowspan ='2' scope='col'>수신시간</th>" +
							"<th colspan ='"+itemCnt+"' scope='col'>수질정보</th>" +
						"</tr>" +
						"<tr>"
						
						for(var rowIdx=0;rowIdx<itemCnt;rowIdx++)
						{
							header += "<th scope='col'>"+itemArray[rowIdx]+"</th>";
						}
						header += "</tr>";
			
			$("#dataHeader").append(header);
			$("#dataList").html("<tr><td colspan='"+(itemCnt + 3)+"'>데이터를 불러오는 중 입니다.</td></tr>");
			
		}
		else if(sys == "A")
		{
			//헤더 생성
			$("#dataHeader").html("");
			header = "<tr>" + 
							"<th rowspan ='2' scope='col'>지역</th>" +
							"<th rowspan ='2' scope='col'>측정소</th>" +
							"<th rowspan ='2' scope='col''>수신시간</th>" +
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
						
			$("#dataHeader").append(header);
			$("#dataList").html("<tr><td colspan='"+(itemCnt + 3)+"'>데이터를 불러오는 중 입니다.</td></tr>");
		}
	}
	
	//데이터 불러오기
	function dataLoad()
	{
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/situationctl/getTotalMntSummary.do'/>",
			data:{sys:sys,
					river:river,
					step:step},
			dataType:"json",
			success:dataLoad_success,
			error:function(result){
					$("#dataList").html("<tr><td colspan='"+(itemCnt + 3)+"'>서버 접속에 실패하였습니다!</td></tr>");
			}
		});
		loadingClose();
	}
	
	function dataLoad_success(result)
	{
		var tot = result['refreshData'].length;
		var trClass;
		
		$("#dataList").html("");
		
		if( tot <= "0" ){
			$("#dataList").html("<tr><td colspan='"+(itemCnt + 3)+"'>조회 결과가 없습니다</td></tr>");
			
			//for(var i=0; i<1000; i++){
			//	$("#dataList").append("<tr code=1234 branchNo='1'><td colspan='"+(2 + itemCnt)+"'>"+i+"조회 결과가 없습니다</td></tr>");
			//}
		}
		else
		{
			var idx = 0;
			for(var i=0; i < tot; i++){
				
				var obj = result['refreshData'][i];
				var item;
				
				//var branchName = obj.fact_name;
				
				if(obj.min_time == "")
				{
					obj.min_time = "미수신";
				}
				
				var factNum;
				
				if(river=="R01")
					factNum = obj.fact_name.replace("한강", "");
				else if(river == "R02")
					factNum = obj.fact_name.replace("낙동강", "");
				else if(river == "R03")
					factNum = obj.fact_name.replace("금강","");
				else if(river == "R04")
					factNum = obj.fact_name.replace("영산강","");
				
				item = "<tr code='"+obj.fact_code+"' branchNo='"+obj.branch_no+ "'>"
						+"<td>"+factNum+"</td>"
						+"<td>"+obj.branch_name+"</td>"
						+"<td>"+obj.min_time.substring(5,16)+"</td>";
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
							+"<td class='num'><span id='phy"+i+"'>" + ((obj.phy == "") ? "-" : obj.phy)+ "</span></td>"
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
						//+"<td id='rem"+idx+"'>"+getMin_or(obj.min_or)+"</td>";
						
				$("#dataList").append(item);
				
				setMinOr_Color(obj.tur_or, $("#tur" + i));
				setMinOr_Color(obj.tmp_or, $("#tmp" + i));
				setMinOr_Color(obj.phy_or, $("#phy" + i));
				setMinOr_Color(obj.dow_or, $("#dow" + i));
				setMinOr_Color(obj.con_or, $("#con" + i));
				
				//setMinOr_Color(obj.phy2_or, $("#phy2_" + i));
				//setMinOr_Color(obj.dow2_or, $("#dow2_" + i));
				//setMinOr_Color(obj.con2_or, $("#con2_" + i));
				//setMinOr_Color(obj.tmp2_or, $("#tmp2_" + i));
				
				setMinOr_Color(obj.imp_or, $("#imp" + i));
				setMinOr_Color(obj.lim_or, $("#lim" + i));
				setMinOr_Color(obj.rim_or, $("#rim" + i));
				setMinOr_Color(obj.ltx_or, $("#ltx" + i));
				setMinOr_Color(obj.rtx_or, $("#rtx" + i));
				setMinOr_Color(obj.tox_or, $("#tox" + i));
				setMinOr_Color(obj.evn_or, $("#evn" + i));
				
				setMinOr_Color(obj.bod_or, $("#bod" + i));
				setMinOr_Color(obj.cod_or, $("#cod" + i));
				setMinOr_Color(obj.sus_or, $("#sus" + i));
				
				
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
				setMinOr_Color(obj.nh4_or, $("#nh4" + i));
				setMinOr_Color(obj.no3_or, $("#no3" + i));
				setMinOr_Color(obj.po4_or, $("#po4" + i));
				
				setMinOr_Color(obj.rin_or, $("#rin" + i));
				
				idx++;
			}
			$("#dataList tr:odd").addClass("add");
			loadingClose();
		}
	}

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
	
	function getMin_or(minorVal)
	{
		var result = "";
		
		switch(minorVal)
		{
			case "0":
				result = "  [정상]";
				break;
			case "1" :
				result = "  [관심]";
				break;
			case "2" :
				result = "  [주의]";
				break;
			case "3" :
				result = "  [경계]";
				break; 
			case "4" :
				result = "  [심각]";
				break;
			default :
				result = "";
				break;
		}
		
		return result;
	}
	
	function reloadData(){
		setTimeout(dataLoad, 10000);
	}
	</script>
</head>
<body class="subPop"><!-- 추가 및 수정 -->
	<div id='loadingDiv'>
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div class="headerWrap">
		<div class="headerBg_r">
			<div class="header" id="header">
				<h1>경보단계별 상세정보</h1>
			</div>
		</div>
	</div>
	<div class="contentWrap">
		<div class="contentBg_r">
			<div class="contentBox">
				<div class="contentPad"><!-- //추가 및 수정 -->
					<div class="totalmntPop1">
						<div class="content">
							<div class="overBox_header" id="overBoxHeader" style="overflow:hidden">
								<table class="dataTable" id="dataTableHeader" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
									<colgroup id="colgroup_header">
									<c:if test="${param.sys == 'U'}">
										<col width="70px" />
										<col width="100px" />
										<col width="100px" />
										<col width="75px" />
										<col width="75px" />
										<col width="75px" />
										<col width="75px" />
										<col width="75px" />
										<col width="" />
									</c:if>
									<c:if test="${param.sys == 'T'}">
										<col width="70px" />
										<col width="100px" />
										<col width="100px" />
										<col width="75px" />
										<col width="75px" />
										<col width="75px" />
										<col width="75px" />
										<col width="75px" />
										<col width="" />
									</c:if>
									<c:if test="${param.sys == 'A'}">
										<col width="70px" />
										<col width="100px" />
										<col width="100px" />
										<col width="94px" />
										<col width="94px" />
										<col width="94px" />
										<col width="94px" />
										<col width="" />
									</c:if>
									</colgroup>
									<thead id="dataHeader">
									</thead>
								</table>
							</div>
							<div class="overBox" id="overBox" style="border-top:solid 0px white;overflow:auto;height:300px;" onscroll="scrollX()">
								<table class="dataTable"  id="dataTable" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
									<c:if test="${param.sys == 'U'}">
										<col width="70px" />
										<col width="100px" />
										<col width="100px" />
										<col width="75px" />
										<col width="75px" />
										<col width="75px" />
										<col width="75px" />
										<col width="75px" />
										<col width="" />
									</c:if>
									<c:if test="${param.sys == 'T'}">
										<col width="70px" />
										<col width="100px" />
										<col width="100px" />
										<col width="75px" />
										<col width="75px" />
										<col width="75px" />
										<col width="75px" />
										<col width="75px" />
										<col width="" />
									</c:if>
									<c:if test="${param.sys == 'A'}">
										<col width="70px" />
										<col width="100px" />
										<col width="100px" />
										<col width="94px" />
										<col width="94px" />
										<col width="94px" />
										<col width="94px" />
										<col width="" />
									</c:if>
									<tbody id="dataList">
										<tr>
											<td colspan="8">데이터를 불러오는 중 입니다...</td>
										</tr>
									</tbody>
								</table>
							</div>
							<script type="text/javascript">
								function scrollX()
								{
									document.getElementById("overBoxHeader").scrollLeft = document.getElementById("overBox").scrollLeft;
								}
							</script>
						</div>
					</div>
				</div><!-- 추가 및 수정 -->
			</div>
		</div>
	</div>
	<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div><!-- //추가 및 수정 -->
</body>
</html>
