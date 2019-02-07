<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />
	<script src="<c:url value='/js/JQuery/jquery-1.3.2.min.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js" type="text/javascript'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>
	
	<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.datepicker.js'/>"></script>

<c:set var="river_div" scope="request" value="${param.river_div}"/>
	<script type="text/javascript">
		var user_riverid = '<sec:authentication property="principal.userVO.riverId"/>';
	</script>

<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
	
<script type="text/javascript">
	$(function(){
	
		$("#mainBody").css("overflow","hidden");
		
		showLoading();
		
		var sys = '${param.sys}';
		var pointVal = '${param.pointVal}';
		$("#pointVal").val(pointVal);
		
		//var sysTemp = '${SelectSys}';
		//var SelectPointVal = '${SelectPointVal}';
		var river_div = '${param.river_div}';
		
		$("#river > option[value="+river_div+"]").attr("selected", "true");
		
		if('${param.sys}' == 'A'){
			$("#sys > option[value="+sys+"]").attr("selected", "true");
		}
		
		tableWidth = $("#dataTable").width();
		
		selectedSugyeInMemberId(user_riverid , 'river');
		
		//startScroll();		
		var itemOpt = $(':radio[name="itemOpt"]:checked').val();
		if(itemOpt == "1"){
			$("#multiItem").hide();
		}
		else if(itemOpt == "2"){
			$("#multiItem").show();
		}
		
		$(":radio[name='itemOpt']").click(function(){
			if($(this).val() == "1"){
				$("#multiItem").hide();				
								
				aloneChart($("#graphType").val());				
			}
			else if($(this).val() == "2"){
				$("#multiItem").show();
			}
		});
		
		$("#multiSear").click(function(){
			var multiVal = "";
			$("input[name=multiItem]:checked").each(function() {
				var test = $(this).val();
				multiVal += test+",";
			});
			
			var graphTy = $("#graphType option:selected").val();
			multiChart(multiVal, graphTy);
		});
		
		$("#graphType").change(function(){
			var chk = $(':radio[name="itemOpt"]:checked').val();
			if(chk == "1"){
				aloneChart($(this).val());
			}
			else if(chk == "2"){
				var multiVal = "";
				$("input[name=multiItem]:checked").each(function() {
					var test = $(this).val();
					multiVal += test+",";
				});
				
				multiChart(multiVal, $(this).val());
			}
		});
		
		$('#sys').change(function(){
			showLoading();
			resultObj = null;
			setGauge();
			riverMapReload();
			getItemDropDown2();
			chart();
		})
		
		$('#river').change(function(){
			showLoading();
			resultObj = null;
			refresh();
			riverMapReload();
			chart();
		})
		
		$('#bItem').change(function(){
			getItemDropDown2();
			bItemChange();
		});
		
		$("#itemCode").change(function(){
			chart();
		});
		
		$('#btnOK').click(function() { refresh(); });
		
		itemSetting("T");
		makeHeader();
		makeItemList();
		setLegend("T");
		
		alphaDivLeftSet();
		
		reloadData();
		
		getItemDropDown();
		getItemDropDown2();
		
		$('#objectBox').mouseout(function(){
		hideData();
		})
	});
	
	function setLegend(sys)
	{
		if(sys == "T")
		{
			$("#li_normal").show();
			$("#li_interest").hide();
			$("#li_caution").hide();
			$("#li_alert_t").show();
			$("#li_alert").hide();
			$("#li_over").hide();
		}
		else if(sys == "U")
		{
			$("#li_normal").show();
			$("#li_interest").show();
			$("#li_caution").show();
			$("#li_alert_t").hide();
			$("#li_alert").show();
			$("#li_over").show();
		}
		else if(sys == "A")
		{
			$("#li_normal").show();
			$("#li_interest").show();
			$("#li_caution").show();
			$("#li_alert_t").hide();
			$("#li_alert").show();
			$("#li_over").show();
		}
	}
	
	var itemCnt;
	var itemArray;
	var itemCode;
	var itemEName;
	
	//itemArray 셋팅
	function itemSetting(sys)
	{
		itemArray = new Array(itemCnt);
		itemCode = new Array(itemCnt);
		itemEName = new Array(itemCnt);
		
		if(sys == "A")
		{
			//itemCnt =41;
			itemCnt =6;
			
			itemArray[0] = "탁도(NTU)";			itemCode[0] = "TUR00";			itemEName[0] = "tur";
			itemArray[1] = "pH";				itemCode[1] = "PHY00";			itemEName[1] = "phy";
			itemArray[2] = "DO(mg/L)";			itemCode[2] = "DOW00";			itemEName[2] = "dow";
			//itemArray[3] = "EC(mS/cm)";			itemCode[3] = "CON00";			itemEName[3] = "con";
			itemArray[3] = "EC(μS/cm)";			itemCode[3] = "CON00";			itemEName[3] = "con";
			itemArray[4] = "수온(℃)";				itemCode[4] = "TMP00";			itemEName[4] = "tmp";
			itemArray[5] = "Chl-a";			itemCode[5] = "TOF00";			itemEName[5] = "tof";
// 			itemArray[4] = "pH2";				itemCode[4] = "PHY01";			itemEName[4] = "phy2";
// 			itemArray[5] = "DO2(mg/L)";			itemCode[5] = "DOW01";			itemEName[5] = "dow2";
// 			itemArray[6] = "EC2(mS/cm)";		itemCode[6] = "CON01";			itemEName[6] = "con2";
// 			itemArray[7] = "수온2(℃)";			itemCode[7] = "TMP01";			itemEName[7] = "tmp2";
			/* itemArray[5] = "총유기탄소";			itemCode[5] = "TOC00";			itemEName[5] = "toc";
			itemArray[6] = "임펄스";				itemCode[6] = "IMP00";			itemEName[6] = "imp";
			itemArray[7] = "임펄스(좌)";			itemCode[7] = "LIM00";			itemEName[7] = "lim";
			itemArray[8] = "임펄스(우)";			itemCode[8] = "RIM00";			itemEName[8] = "rim";
			itemArray[9] = "독성지수(좌)";			itemCode[9] = "LTX00";			itemEName[9] = "ltx";
			itemArray[10] = "독성지수(우)";			itemCode[10] = "RTX00";			itemEName[10] = "rtx";
			itemArray[11] = "미생물독성지수(%)";		itemCode[11] = "TOX00";			itemEName[11] = "tox";
			itemArray[12] = "조류독성지수";			itemCode[12] = "EVN00";			itemEName[12] = "evn";
			itemArray[13] = "염화메틸렌";			itemCode[13] = "VOC01";			itemEName[13] = "voc1";
			itemArray[14] = "1.1.1-트리클로로에테인";	itemCode[14] = "VOC02";			itemEName[14] = "voc2";
			itemArray[15] = "벤젠";				itemCode[15] = "VOC03";			itemEName[15] = "voc3";
			itemArray[16] = "사염화탄소";			itemCode[16] = "VOC04";			itemEName[16] = "voc4";
			itemArray[17] = "트리클로로에틸렌";		itemCode[17] = "VOC05";			itemEName[17] = "voc5";
			itemArray[18] = "톨루엔";				itemCode[18] = "VOC06";			itemEName[18] = "voc6";
			itemArray[19] = "테트라클로로에티렌";		itemCode[19] = "VOC07";			itemEName[19] = "voc7";
			itemArray[20] = "에틸벤젠";			itemCode[20] = "VOC08";			itemEName[20] = "voc8";
			itemArray[21] = "m,p-자일렌";			itemCode[21] = "VOC09";			itemEName[21] = "voc9";
			itemArray[22] = "o-자일렌";			itemCode[22] = "VOC10";			itemEName[22] = "voc10";
			itemArray[23] = "[ECD]염화메틸렌";		itemCode[23] = "VOC11";			itemEName[23] = "voc11";
			itemArray[24] = "[ECD]1.1.1-트리클로로에테인";	itemCode[24] = "VOC12";	itemEName[24] = "voc12";
			itemArray[25] = "[ECD]사염화탄소";		itemCode[25] = "VOC13";			itemEName[25] = "voc13";
			itemArray[26] = "[ECD]트리클로로에틸렌";	itemCode[26] = "VOC14";			itemEName[26] = "voc14";
			itemArray[27] = "[ECD]테트라클로로에티렌";	itemCode[27] = "VOC15";			itemEName[27] = "voc15";
			itemArray[28] = "총질소";				itemCode[28] = "TON00";			itemEName[28] = "ton";
			itemArray[29] = "총인";				itemCode[29] = "TOP00";			itemEName[29] = "top";
			itemArray[30] = "암모니아성질소";		itemCode[30] = "NH400";			itemEName[30] = "nh4";
			itemArray[31] = "질산성질소";			itemCode[31] = "NO300";			itemEName[31] = "no3";
			itemArray[32] = "인산염인";			itemCode[32] = "PO400";			itemEName[32] = "po4";
			itemArray[33] = "Chl-a";			itemCode[33] = "TOF00";			itemEName[33] = "tof";
			itemArray[34] = "카드뮴";				itemCode[34] = "CAD00";			itemEName[34] = "cad";
			itemArray[35] = "납";				itemCode[35] = "PLU00";			itemEName[35] = "plu";
			itemArray[36] = "구리";				itemCode[36] = "COP00";			itemEName[36] = "cop";
			itemArray[37] = "아연";				itemCode[37] = "ZIN00";			itemEName[37] = "zin";
			itemArray[38] = "페놀1";				itemCode[38] = "PHE00";			itemEName[38] = "phe";
			itemArray[39] = "페놀2";				itemCode[39] = "PHL00";			itemEName[39] = "phl";
			itemArray[40] = "강수량";				itemCode[40] = "RIN00";			itemEName[40] = "rin"; */
		}
		else if(sys != "A")
		{
			itemCnt =5;
			
			itemArray[0] = "탁도(NTU)";	itemCode[0] = "TUR";
			itemArray[1] = "수온(℃)";		itemCode[1] = "TMP";
			itemArray[2] = "pH";		itemCode[2] = "PHY";
			itemArray[3] = "DO(mg/L)";	itemCode[3] = "DOW";
			itemArray[4] = "EC(mS/cm)";	itemCode[4] = "CON";
			
			if(sys == "U")
			{
				itemCnt = 6;
				itemArray[5] = "Chl-a(μg/L)";	itemCode[5] = "TOF";
			}
		}
	}
	
	//테이블 헤더 생성
	function makeHeader()
	{
		var header;
		var sys = $("#sys").val();
		
		//헤더 생성
		$("#dataBox").html("");
		
		/* if(sys == 'A'){
			columns = "<th colspan ='5' scope='col'>일반항목</th>"+
					//<th colspan ='5' scope='col'>일반항목(외부)</th>"+
					"<th colspan='1' scope='col'>유기물질</th>" +
					"<th colspan='1' scope='col'>생물독성(물고기)</th>" + 
					"<th colspan='2' scope='col'>생물독성(물벼룩1)</th>" +
					"<th colspan='2' scope='col'>생물독성(물벼룩2)</th>" +
					"<th colspan='1' scope='col'>생물독성(미생물)</th>" +
					"<th colspan='1' scope='col'>생물독성(조류)</th>" +
					"<th colspan='15' scope='col'>휘발성 유기화합물</th>" +
					"<th colspan='5' scope='col'>영양염류</th>" +
					"<th colspan='1' scope='col'>Chl-a</th>" +
					"<th colspan='4' scope='col'>중금속</th>" +
					"<th colspan='2' scope='col'>페놀</th>" +
					"<th colspan='1' scope='col'>강수량계</th>";
		}else{ */
			columns = "<th colspan ='"+itemCnt+"' scope='col'>측정항목</th>";
		/* } */
		
		//header = "<table oncontextmenu='return false' ondragstart='return false' onselectstart='return false' class='"+(sys=='A'?'dataTable_broad':'dataTable')+"'>" +
		/* header = "<table oncontextmenu='return false' ondragstart='return false' onselectstart='return false' class='"+(sys=='A'?'dataTable':'dataTable')+"'>" +
					"<tr>" + 
						//"<th rowspan ='2' scope='col'>지역</th>" +
						"<th rowspan ='2' scope='col'>수계</th>" +
						"<th rowspan ='2' scope='col'>측정소</th>" +
						columns +
						//"<th rowspan ='2' scope='col' style='width:135px'>수신시간</th>" +
						"<th rowspan ='2' scope='col' style='width:80px'>상태</th>" +
						"<th rowspan ='2' scope='col'>경보발령</th>" +
						"<th rowspan ='2' scope='col'>추이보기</th>" +
						"<th rowspan ='2' scope='col'>지도보기</th>" +
					"</tr>" +
					"<tr>";
		
		for(var rowIdx=0;rowIdx<itemCnt;rowIdx++)
		{
			header += "<th scope='col'>"+itemArray[rowIdx]+"</th>";
		} */
		
		header = "<table oncontextmenu='return false' ondragstart='return false' onselectstart='return false' class='"+(sys=='A'?'dataTable':'dataTable')+"'>";
		header += "<tr>";
			//"<th rowspan ='2' scope='col'>지역</th>" +
		header += "<th  scope='col'>수계</th>";
		header +="<th  scope='col'>측정소</th>";
			//columns +
			//"<th rowspan ='2' scope='col' style='width:135px'>수신시간</th>" +
			for(var rowIdx=0;rowIdx<itemCnt;rowIdx++)
			{
			header += "<th scope='col'>"+itemArray[rowIdx]+"</th>";
			}
			header += "<th  scope='col' style='width:80px'>상태</th>";
			header += "<th  scope='col'>경보발령</th>";
			header += "<th  scope='col'>추이보기</th>";
			header += "<th  scope='col'>지도보기</th>";
			header += "</tr>";

/* for(var rowIdx=0;rowIdx<itemCnt;rowIdx++)
{
header += "<th scope='col'>"+itemArray[rowIdx]+"</th>";
} */
					
		header += "<tbody id='dataList'>" + 
						"</tbody>" + 
						"</table>";
						
		/* header += "<table id='exSpan' style='display:none;'><tr><td><span>인접지역</span></td></tr></table>";
		header += "<table id='exTable' style='display:none;' oncontextmenu='return false' ondragstart='return false' onselectstart='return false' class='"+(sys=='A'?'dataTable_broad':'dataTable')+"'>";
		header += "<tr>";
		header += "<th rowspan ='2' scope='col'>수계</th>";
		header += "<th rowspan ='2' scope='col'>측정소</th>";
		header += columns;
		header += "<th rowspan ='2' scope='col' style='width:80px'>상태</th>";
		header += "<th rowspan ='2' scope='col'>경보발령</th>";
		header += "<th rowspan ='2' scope='col'>추이보기</th>";
		header += "<th rowspan ='2' scope='col'>지도보기</th>";
		header += "</tr>";
		header += "<tr>";		
		
		for(var cnt=0; cnt<itemCnt; cnt++)
		{
			header += "<th scope='col'>"+itemArray[cnt]+"</th>";
		}	 */
		
		header += "<table id='exSpan' style='display:none;'><tr><td><span>인접지역</span></td></tr></table>";
		header += "<table id='exTable' style='display:none;' oncontextmenu='return false' ondragstart='return false' onselectstart='return false' class='"+(sys=='A'?'dataTable':'dataTable')+"'>";
		header += "<tr>";
		header += "<th rowspan ='2' scope='col'>수계</th>";
		header += "<th rowspan ='2' scope='col'>측정소</th>";
		for(var cnt=0; cnt<itemCnt; cnt++)
		{
			header += "<th scope='col'>"+itemArray[cnt]+"</th>";
		}	
		header += "<th rowspan ='2' scope='col' style='width:80px'>상태</th>";
		header += "<th rowspan ='2' scope='col'>경보발령</th>";
		header += "<th rowspan ='2' scope='col'>추이보기</th>";
		header += "<th rowspan ='2' scope='col'>지도보기</th>";
		header += "</tr>";
		header += "<tbody id='dataListEx'>";
		header += "</tbody>";
		header += "</table>";
						
		$("#dataBox").append(header);
		
		if(itemCnt == 0) itemCnt = 1;
		$("#dataList").html("<tr><td colspan='"+(itemCnt + 5)+"'>데이터를 불러오는 중 입니다...</td></tr>");
	}
	
	
	function makeItemList(){
		/*
		var header = "";

		$("#topDataList").html("");

		var first = itemArray[0];
		if(first != null)
		{
			for(var idx=0;idx < itemCnt;idx++)
			{
				header += "<tr>"
								+ "<td><span style='background-color:#;'>"+itemArray[idx]+"</span></td>"
								+ "<td class='num'><span id='topMinvl"+itemCode[idx]+"'></span></td>"
								+ "<td id='topMinor"+itemCode[idx]+"'></td>"
							+ "</tr>";

			}
	
			$("#topDataList").append(header);
		}
		*/
	}
	
	//게이지 클리어
	function clearGauge()
	{
		
		for(var sq = 1; sq <= 3;sq++)
		{
			$("#fact" + sq).text("-");
			setWeatherData(null, sq);
			//$("#weatherSpan" + sq).text("-");
			
			$('#turGauge' + sq).hide();
			$('#tur_val'+sq).text("");
			setOrImg('-', 'tur', sq);
			
			$("#tmpGauge" + sq).hide();
			$('#tmp_val'+sq).text("");
			setOrImg('-', 'tmp', sq);
			
			$("#phGauge" + sq).hide();
			$('#ph_val'+sq).text("");
			setOrImg('-', 'ph', sq);
			
			$("#doGauge" + sq).hide();
			$('#do_val'+sq).text("");
			setOrImg('-', 'do', sq);
			
			$("#ecGauge" + sq).hide();
			$('#ec_val'+sq).text("");
			setOrImg('-', 'ec', sq); 
		}
	}
	
	//값 반올림
	function valRound(val)
	{
		val = val.split(',').join("");
		val = new Number(val).toFixed(2) + "";
		return val;
	}
	
	//탁도 그래프 표시
	function setTurChart(val, sq, or_val, factCode, branchNo, sys)
	{
		if(val == null || val == "-" || val == "")
		{
			$('#turGauge' + sq).hide();
			$("#tur_val" + sq).text("");
		}
		else
		{
			val = valRound(val);
			
			var src = "<c:url value='/waterpolmnt/situationctl/getTurGauge.do'/>?fact_code="+factCode+"&branch_no="+branchNo+"&width=160&height=25&minVl=" + val + "&lawVl=50&minOr=" + or_val + "&sys=" + sys;
			$("#turGauge" + sq).show();
			$("#turGauge" + sq).attr("src", src);
			$("#tur_val" + sq).text(val);
		}
		setOrImg(or_val, 'tur', sq);
	}
	//수온 그래프 표시
	function setTmpChart(val, sq, or_val, factCode, branchNo)
	{
		if(val == null || val == "-" || val == "")
		{
			$("#tmpGauge" + sq).hide();
			$("#tmp_val" + sq).text("");
		}
		else
		{
			val = valRound(val);
			
			var src = "<c:url value='/waterpolmnt/situationctl/getTempGauge.do'/>?fact_code="+factCode+"&branch_no="+branchNo+"&width=160&height=25&minVl=" + val + "&minOr=" + or_val;
			$("#tmpGauge" + sq).show();
			$("#tmpGauge" + sq).attr("src", src);
			$("#tmp_val" + sq).text(val);
		}
		setOrImg(or_val, 'tmp', sq);
	}
	//ph그래프 표시
	function setPhChart(val, sq, or_val, factCode, branchNo)
	{
		if(val == null || val == "-" || val == "")
		{
			$("#phGauge" + sq).hide();
			$("#ph_val" + sq).text("");
		}
		else
		{
			val = valRound(val);
			
			var src = "<c:url value='/waterpolmnt/situationctl/getPhGauge.do'/>?fact_code="+factCode+"&branch_no="+branchNo+"&width=160&height=25&minVl=" + val + "&lawVl=6.5&lawMax=8.5&minOr=" + or_val;;
			$("#phGauge" + sq).show();
			$("#phGauge" + sq).attr("src", src);
			$("#ph_val" + sq).text(val);
		}
		
		setOrImg(or_val, 'ph', sq);
	}
	//do그래프 표시
	function setDoChart(val, sq, or_val, factCode, branchNo)
	{
		if(val == null || val == "-" || val == "")
		{
			$("#doGauge" + sq).hide();
			$("#do_val" + sq).text("");
		}
		else
		{
			val = valRound(val);
			
			var src = "<c:url value='/waterpolmnt/situationctl/getDoGauge.do'/>?fact_code="+factCode+"&branch_no="+branchNo+"&width=160&height=25&minVl=" + val + "&lawVl=5&minOr=" + or_val;
			$("#doGauge" + sq).show();
			$("#doGauge" + sq).attr("src", src);
			$("#do_val" + sq).text(val);
		}
		setOrImg(or_val, 'do', sq);
	}
	//ec그래프 표시
	function setEcChart(val, sq, or_val, factCode, branchNo, sys)
	{
		if(val == null || val == "-" || val == "")
		{
			$("#ecGauge" + sq).hide();
			$("#ec_val" + sq).text("");
		}
		else
		{
			val = valRound(val);
			
			var src = "<c:url value='/waterpolmnt/situationctl/getEcGauge.do'/>?fact_code="+factCode+"&branch_no="+branchNo+"&width=160&height=25&minVl=" + val + "&lawVl=0.4&minOr=" + or_val  + "&sys=" + sys;
			$("#ecGauge" + sq).show();
			$("#ecGauge" + sq).attr("src", src);
			$("#ec_val" + sq).text(val);
		}
		setOrImg(or_val, 'ec', sq);
	}
	
	//측정망 항목별 그래프 표시
	function setChart(id, val, sq, or_val, factCode, branchNo, sys)
	{
		if(val == null || val == "-" || val == "")
		{
			$("#" + id + sq).hide();
			$("#" + id  + "_val" + sq).text("");
		}
		else
		{
			val = valRound(val);
			
			var src = "<c:url value='/waterpolmnt/situationctl/getGauge.do'/>?itemCode="+id+"&fact_code="+factCode+"&branch_no="+branchNo+"&width=160&height=25&minVl=" + val + "&lawVl=0.4&minOr=" + or_val  + "&sys=" + sys;
			$("#" + id + sq).show();
			$("#" + id + sq).attr("src", src);
			$("#" + id +"_val" + sq).text(val);
		}
		
		setOrImg(or_val, id, sq);
	}
	
	//Minor 값에 따른 ● 이미지 변화
	function setOrImg(or_val, item, sq)
	{
		var img = $("#" + item + "_or" + sq);
		var result = "<c:url value='/images/popup/bu_circle_'/>";
		
		switch(or_val)
		{
		case "0":
			result += "green.gif";
			break;
		case "1":
			result += "blue.gif";
			break;
		case "2":
			result += "yellow.gif";
			break;
		case "3":
			result += "orange.gif";
			break;
		case "4":
			result += "red.gif";
			break;
		default :
			result += "black.gif";
			break;
		}
		
		img.attr("src", result);
	}
	
	//소항목 채우기
	function getItemDropDown2(){
		var sys = $('#sys').val();
		
		if(sys == "A")
		{
			var bItem = $("#bItem").val();
			
			if('${param.sys}' == 'A' && bItem == "all")
				bItem = "COM1";
// 			console.log("bItem : ",bItem);
			
			var dropDownSet = $('#itemCode'); 
			dropDownSet.attr("disabled", false);
			$.getJSON("<c:url value='/waterpolmnt/waterinfo/getItemList2.do'/>", {itemKind:bItem}, function (data, status){
				if(status == 'success'){
					//item 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelectDepth3(data.item, sys);
					
					chart();
				} else { 
					//alert("ERROR!");
					return;
				}
			});
		}
		else
		{
			var itemCode = "";
			
			if(sys == 'U' || sys == 'all'){
				itemCode = "22";
			}else if(sys == 'T'){
				itemCode = "23";
			}else if(sys == 'A'){
				itemCode = "37";
			}
			
			var dropDownSet = $('#itemCode');
			
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
	}
	
	//자동측정망일때 게이지그래프를 표시할 대항목 선택
	function getItemDropDown(){
		var itemCode = "";
		
		itemCode = "42";
		
		var dropDownSet = $('#bItem');
		
		dropDownSet.attr("disabled", false);
		
		$.getJSON("<c:url value='/cmmn/getCode.do'/>", {code_id:itemCode}, function (data, status){
			if(status == 'success'){
				//item 객체에 SELECT 옵션내용 추가.
				dropDownSet.loadSelectDepth3(data.codes, "A");
				
				if(bItem == "all")
					$("#bItem > option[value=COM1]").attr("selected", "selected");
				else
					$("#bItem > option[value=" + bItem + "]").attr("selected", "selected");
			
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
					
					if(sys != "A")
						optionData.VALUE = optionData.VALUE + "00";
					
					var option = new Option(optionData.CAPTION, optionData.VALUE);
					
					var first = new Option("전체", 'all');
					
					if ($.browser.msie) {
						selectElement.add(option);
					}
					else {
						selectElement.add(option,null);
					}
				});
				
				selectElement.add(new Option("Chl-a", "TOF00"))
			}
		});
	 }
	})(jQuery);


	function setGauge()
	{
		var sys = $("#sys").val();

		if(sys == "A")
			bItemChange();
		else
			setGaugeList();
		refresh();
	}
	
	//IP, 탁수일때 게이지 차트 항목 생성
	function setGaugeList()
	{
		var lower = 0;
		var upper = 3;
		
		var sys = $("#sys").val();
		
		/*
		for(var sq = 1; sq <= 3; sq++)
		{
			record = "";
			
			record +="<tr>";
			record +="<th scope='row'>탁도</th>";
			record +="<td><span class='alr_noRcv'><img id='tur_or"+sq+"' src=\"<c:url value='/images/popup/bu_circle_black.gif'/>\"></span></td>";
			record +="<td style='border-right:0px'><img id='turGauge"+sq+"' style='display:none'/></td>";
			record +="<td class='num' style='width:50px;border-left:0px'><span id='tur_val"+sq+"' style='color:gray'></span></td>";
			record +="</tr>";
			record +="<tr>";
			record +="<th scope='row'>수온</th>";
			record +="<td><span class='alr_normal'><img id='tmp_or"+sq+"' src=\"<c:url value='/images/popup/bu_circle_black.gif'/>\"></span></td>";
			record +="<td style='border-right:0px'><img id='tmpGauge"+sq+"' style='display:none'/></td>";
			record +="<td class='num' style='width:50px;border-left:0px'><span id='tmp_val"+sq+"' style='color:gray'></span></td>";
			record +="</tr>";
			record +="<tr>";
			record +="<th scope='row'>pH</th>";
			record +="<td><span class='alr_interest'><img id='ph_or"+sq+"' src=\"<c:url value='/images/popup/bu_circle_black.gif'/>\"></span></td>";
			record +="<td style='border-right:0px'><img id='phGauge"+sq+"' style='display:none'/></td>";
			record +="<td class='num' style='width:50px;border-left:0px'><span id='ph_val"+sq+"' style='color:gray'></span></td>";
			record +="</tr>";
			record +="<tr>";
			record +="<th scope='row'>DO</th>";
			record +="<td><span class='alr_caution'><img id='do_or"+sq+"' src=\"<c:url value='/images/popup/bu_circle_black.gif'/>\"></span></td>";
			record +="<td style='border-right:0px'><img id='doGauge"+sq+"' style='display:none'/></td>";
			record +="<td class='num' style='width:50px;border-left:0px'><span id='do_val"+sq+"' style='color:gray'></span></td>";
			record +="</tr>";
			record +="<tr>";
			record +="<th scope='row'>EC</th>";
			record +="<td><span class='alr_alert'><img id='ec_or"+sq+"' src=\"<c:url value='/images/popup/bu_circle_black.gif'/>\"></span></td>";
			record +="<td style='border-right:0px'><img id='ecGauge"+sq+"' style='display:none'/></td>";
			record +="<td class='num' style='width:50px;border-left:0px'><span id='ec_val"+sq+"' style='color:gray'></span></td>";
			record +="</tr>";

			$("#gaugeList" + sq).html("");
			$("#gaugeList" + sq).html(record);
		}

		*/
		$("#infoDiv").css("width", "395px");
		
		var divTable = "<table id='divDataTable' class='dataTable' style='height:70px;table-layout:auto'>";
			divTable += "<colgroup>";
			divTable += "<col width='90' />";
			divTable += "<col width='' />";
			divTable += "<col width='' />";
			divTable += "<col width='' />";
			divTable += "<col width='' />";
			divTable += "<col width='' />";
		if(sys == "U")
			divTable += "<col width='' />";
			
		divTable += "</colgroup>";
		divTable += "<thead id='divDataHeader'>";
		divTable += "</thead>";
		divTable += "<tbody id='divDataList'>";
		divTable += "</tbody>";
		divTable += "</table>";
		
		$("#infoDiv").html("");
		$("#infoDiv").html(divTable);
		
			
		var div ="<tr>";
		div+="<th scope='col'>측정소</th>";
		div+="<th scope='col'>탁도</th>";
		div+="<th scope='col'>수온</th>"; 
		div+="<th scope='col'>pH</th>";
		div+="<th scope='col'>DO</th>"; 
		div+="<th scope='col'>EC</th>"; 
		if(sys == "U")
			div+="<th scope='col'>Chl-a</th>"; 
		div+="</tr>";
		
		$("#divDataHeader").html("");
		$("#divDataHeader").html(div);
		
		var dataDiv = "";
		dataDiv += "<tr>";
		dataDiv += "<td><span id='divBranch'></span></td>";
		dataDiv += "<td><span id='divData'></span></td>	";
		dataDiv += "<td><span id='divData_tmp'></span></td>";
		dataDiv += "<td><span id='divData_phy'></span></td>";
		dataDiv += "<td><span id='divData_dow'></span></td>";
		dataDiv += "<td><span id='divData_con'></span></td>";
		if(sys == "U")
			dataDiv += "<td><span id='divData_tof'></span></td>";
		dataDiv += "</tr>";
		
		$("#divDataList").html("");
		$("#divDataList").html(dataDiv);
		$("#dataBox").css("height", "474px");
	}
	
	var upper;
	var lower;
	
	//수질측정망일때, 게이지차트표시 대항목 선택 변경
	function bItemChange()
	{
		//showLoading();
		
		itemSetting("A");
		
		var bItem = $("#bItem").val();
		
		var record = "";
		upper = 0;
		lower = 0;
		dataBoxHeight =  0;
		
		if(bItem == "COM1")
		{
			lower = 0;
			upper = 4;
		}
		else if(bItem == "ORGA")
		{
			lower = 5;
			upper = 5;
		}
		else if(bItem == "BIO1")
		{
			lower = 6;
			upper = 6;
		}
		else if(bItem == "BIO2")
		{
			lower = 7;
			upper = 8;
		}
		else if(bItem == "BIO3")
		{
			lower = 9;
			upper = 10;
		}
		else if(bItem == "BIO4")
		{
			lower = 11;
			upper = 11;
		}
		else if(bItem == "BIO5")
		{
			lower = 12;
			upper = 12;
		}
		else if(bItem == "VOCS")
		{
			lower = 13;
			upper = 27;
		}
		else if(bItem == "NUTR")
		{
			lower = 28;
			upper = 32;
		}
		else if(bItem == "CHLA")
		{
			lower = 33;
			upper = 33;
		}
		else if(bItem == "METL")
		{
			lower = 34;
			upper = 37;
		}
		else if(bItem == "PHEN")
		{
			lower = 38;
			upper = 39;
		}
		else if(bItem == "RAIN")
		{
			lower = 40;
			upper = 40;
		}
		
		/*
		if(bItem != "VOCS")
		{
			dataBoxHeight = 474 + ((4-(upper-lower)) * 36);
			$("#dataBox").css("height", dataBoxHeight + "px");
		}
		else
		{
			$("#dataBox").css("height", "474px");
		}

		for(var sq = 1; sq <= 3; sq++)
		{
			record = "";
			
			for(idx = lower;idx <= upper;idx++)
			{
				var iName = itemArray[idx];
				var iCode = itemCode[idx];
	
				record += "<tr>";
				record += "<th scope='row' style='font-size:0.80em'>"+iName+"</th>";
				record +="<td><span class='alr_noRcv'><img id='"+iCode+"_or"+sq+"' src=\"<c:url value='/images/popup/bu_circle_black.gif'/>\"></span></td>";
				record +="<td style='border-right:0px'><img id='"+ iCode+ sq +"' style='display:none'/></td>";
				record += "<td class='num' style='width:50px;border-left:0px'><span id='"+iCode+"_val"+sq+"' style='color:gray'></span></td>";
				record +="</tr>";
			}

			$("#gaugeList" + sq).html("");
			$("#gaugeList" + sq).html(record);
		}
		*/
		
		$("#infoDiv").css("height", "70px");
		
		if(bItem == "BIO1")
		{
			$("#divDataTable").css("width", "170px");
			$("#infoDiv").css("width", "170px");
		}
		else if(bItem == "BIO2")
		{
			$("#divDataTable").css("width", "270px");
			$("#infoDiv").css("width", "270px");
		}
		else if(bItem == "BIO3")
		{
			$("#divDataTable").css("width", "270px");
			$("#infoDiv").css("width", "270px");
		}
		else if(bItem == "BIO4")
		{
			$("#divDataTable").css("width", "170px");
			$("#infoDiv").css("width", "170px");
		}
		else if(bItem == "BIO5")
		{
			$("#divDataTable").css("width", "170px");
			$("#infoDiv").css("width", "170px");
		}
		else if(bItem == "CHLA")
		{
			$("#divDataTable").css("width", "170px");
			$("#infoDiv").css("width", "170px");
		}
		else if(bItem == "PHEN")
		{
			$("#divDataTable").css("width", "270px");
			$("#infoDiv").css("width", "270px");
		}
		else if(bItem == "ORGA")
		{
			$("#divDataTable").css("width", "170px");
			$("#infoDiv").css("width", "170px");
		}
		else if(bItem == "RAIN")
		{
			$("#divDataTable").css("width", "170px");
			$("#infoDiv").css("width", "170px");
		}
		else if(bItem == "VOCS")
		{
			$("#infoDiv").css("width", "1095px");
			$("#infoDiv").css("height", "81px");
		}
		else
		{
			$("#infoDiv").css("width", "395px");
		}
			
		var divTable = "<table id='divDataTable' class='dataTable' style='height:70px;table-layout:auto'>";
		divTable += "<colgroup>";
		divTable += "<col width='90' />";
		divTable += "<col width='' />";
		divTable += "<col width='' />";
		divTable += "<col width='' />";
		divTable += "<col width='' />";
		divTable += "<col width='' />";
		divTable += "</colgroup>";
		divTable += "<thead id='divDataHeader'>";
		divTable += "</thead>";
		divTable += "<tbody id='divDataList'>";
		divTable += "</tbody>";
		divTable += "</table>";
		
		$("#infoDiv").html("");
		$("#infoDiv").html(divTable);
		
		var div ="<tr>";
		div+="<th scope='col'>측정소</th>";
		
		var dataDiv = "<tr>";
		dataDiv += "<td><span id='divBranch'></span></td>"
			
		for(idx = lower;idx <= upper;idx++)
		{
			var iName = itemArray[idx];
			var iCode = itemCode[idx];
			
			div+="<th scope='col'>"+iName+"</th>";
			dataDiv += "<td><span id='divData_"+iCode+"'></span></td>";
		}
		
		div+="</tr>";
		dataDiv += "</tr>";
		
		$("#divDataHeader").html("");
		$("#divDataHeader").html(div);
		
		$("#divDataList").html("");
		$("#divDataList").html(dataDiv);
		
	}
	
	//상단에 표시할 데이터 셋팅
	function setTopData(idx, factCode, branchNo){
		
		if(resultObj != null)
		{
			var sys = $("#sys").val();
			var rowData = resultObj[idx];
			if(rowData != null)
			{
				/*
				if(sys != "A")
				{
					//처음에 3부분 전부 채움
					if(idx == 0)
					{
						for(var firstIdx = 0; firstIdx < 3; firstIdx++)
						{
							if(firstIdx >= resultObj.length)
								break;
								
							var getIdx = firstIdx+1;
							
							rowData = resultObj[firstIdx];
							
							$("#fact" + getIdx).text(setTopFactName(rowData.fact_name) + "(" + rowData.branch_name + ")");
							setTurChart(rowData.tur, getIdx, rowData.tur_or, factCode, branchNo, sys);
							setTmpChart(rowData.tmp, getIdx, rowData.tmp_or, factCode, branchNo);
							setPhChart(rowData.phy, getIdx, rowData.phy_or, factCode, branchNo);
							setDoChart(rowData.dow,getIdx, rowData.dow_or, factCode, branchNo);
							setEcChart(rowData.con, getIdx, rowData.con_or, factCode, branchNo, sys);
							
							getWeatherInfo(rowData.fact_code, rowData.branch_no, getIdx);
						}
					}
					else if(idx < 3)
					{
						//3번째까지 그냥 통과
					}
					else	//3번째 이후로는 왼쪽으로 하나씩 밀자
					{
						incIdx = 1;
						
						for(var bfIdx = 2 ; bfIdx >= 0 ; bfIdx--)
						{
							var getIdx = (idx - bfIdx);
							
							rowData = resultObj[getIdx];
							
							$("#fact" + incIdx).text(setTopFactName(rowData.fact_name) + "(" + rowData.branch_name + ")");
							setTurChart(rowData.tur, incIdx, rowData.tur_or, factCode, branchNo, sys);
							setTmpChart(rowData.tmp, incIdx, rowData.tmp_or, factCode, branchNo);
							setPhChart(rowData.phy, incIdx, rowData.phy_or, factCode, branchNo);
							setDoChart(rowData.dow, incIdx, rowData.dow_or, factCode, branchNo);
							setEcChart(rowData.con, incIdx, rowData.con_or, factCode, branchNo, sys);
							
							getWeatherInfo(rowData.fact_code, branchNo, incIdx);
							
							incIdx++;
						}
					}
				}
				else
				{
					//setGauge(id, val, sq, or_val, factCode, branchNo, sys)
					
					
					//처음에 3부분 전부 채움
					if(idx == 0)
					{
						for(var firstIdx = 0; firstIdx < 3; firstIdx++)
						{
							if(firstIdx >= resultObj.length)
								break;
								
							var getIdx = firstIdx+1;
							
							rowData = resultObj[firstIdx];
							
							$("#fact" + getIdx).text(setTopFactName(rowData.fact_name) + "(" + rowData.branch_name + ")");
							
							for(var i = lower ; i <= upper;i++)
							{
								var iName = itemArray[i];
								var iCode = itemCode[i];
								var eName = itemEName[i];
								
								var val = eval("rowData." + eName);
								var val_or = eval("rowData." + eName + "_or");
										
								setChart(iCode, val, getIdx, val_or, factCode, branchNo, sys)
							}
							
							getWeatherInfo(rowData.fact_code, rowData.branch_no, getIdx);
						}
					}
					else if(idx < 3)
					{
						//3번째까지 그냥 통과
					}
					else	//3번째 이후로는 왼쪽으로 하나씩 밀자
					{
						incIdx = 1;
										
						for(var bfIdx = 2 ; bfIdx >= 0 ; bfIdx--){
							var getIdx = (idx - bfIdx);
							
							rowData = resultObj[getIdx];
							
							$("#fact" + incIdx).text(setTopFactName(rowData.fact_name) + "(" + rowData.branch_name + ")");
							
							for(var i = lower ; i <= upper;i++)
							{
								var iName = itemArray[i];
								var iCode = itemCode[i];
								var eName = itemEName[i];
									
								var val = eval("rowData." + eName);
								var val_or = eval("rowData." + eName + "_or");
								
								setChart(iCode, val, incIdx, val_or, factCode, branchNo, sys)
							}
							getWeatherInfo(rowData.fact_code, branchNo, incIdx);
							
							incIdx++;
						}
					}
				}
				*/
				
				rowData = resultObj[idx];
				//선택된 놈의 수계표 좌표 가져오기
				var coord = 0;
				var tmpFact = rowData.fact_code + "_" + rowData.branch_no;
				if(sys == "T")
				{
					var idx = arrPointMap[tmpFact];
					coord = arrPointY[idx];
				}
				else if(sys == "U")
				{
					var idx = u_arrPointMap[tmpFact];
					coord = u_arrPointY[idx];
				}
				else if(sys == "A")
				{
					var idx = a_arrPointMap[tmpFact];
					coord = a_arrPointY[idx];
				}
				
				//선택된 놈의 좌표로 투명 박스 이동
				alphaDivMove(coord);
			}
		}
	}
	
	function setTopFactName(fact_name){
		var river = $('#river').val();
		
		if(river == 'R01')
			factNumber = fact_name.replace('한강', '');
		else if(river == 'R02')
			factNumber = fact_name.replace('낙동강', '');
		else if(river == 'R03')
			factNumber = fact_name.replace('금강', '');
		else if(river == 'R04')
			factNumber = fact_name.replace('영산강','');
		
		return factNumber
	}
	
	function reloadData(){
		refresh();	//데이터 불러오기
		riverMapReload();	//수계맵 초기화
		chart(); //차트 다시그리기
		setTimeout(reloadData, 600000);
	}
	
	//Top Data표시용 정보 저장
	var resultObj;
	//왼쪽 수계 맵 표시용 정보 저장
	var riverMapData = new Object();
	var riverMapData_con = new Object();
	var riverMapData_tmp = new Object();
	var riverMapData_phy = new Object();
	var riverMapData_dow = new Object();
	var riverMapData_tof = new Object();
	var riverMapDataOr = new Object();
	var riverMapDataOr_con = new Object();
	var riverMapDataOr_tmp = new Object();
	var riverMapDataOr_dow = new Object();
	var riverMapDataOr_phy = new Object();
	var riverMapDataOr_tof = new Object();
	var riverMapBranch = new Object();
	
	function refresh(){
		var river = $('#river').val();
		var sys = $('#sys').val();
		
		var pointVal = '${param.pointVal}';
		
		if(sys == "A")
			//$("#bItemLi").show();
			$("#bItemLi").hide();
		else
			$("#bItemLi").hide();
		
		//setGauge();
		
		firstFlag = true;
		chartIdx = 0;
		noScrollIdx = 0;
		clearGauge();
		chartVisibleSet();
		setLegend(sys);
		itemSetting(sys);
		makeHeader();
		makeItemList();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/situationctl/getSelectWATERSYSMNT.do'/>",
			data:{sys:sys,
				pointVal:pointVal},
			dataType:"json",
			success:function(result){
				
				resultObj = result['refreshData'];
				
				var tot = result['refreshData'].length;
				var exTot = result['refreshDataEx'].length;
				var trClass;
				var maxMinTime = 0;
				var maxTime = "";
				
				$("#dataList").html("");
				$("#dataListEx").html("");
				
				if( tot <= 0 ){
					$("#dataList").html("<tr><td colspan='"+(itemCnt + 5)+"'>조회 결과가 없습니다</td></tr>");
					setWeatherData("no");
					resultObj=null;
					//for(var i=0; i<50; i++){
					//$("#dataList").append("<tr code=1234 branchNo='1'><td colspan='"+(itemCnt + 5)+"'>"+i+"조회 결과가 없습니다</td></tr>");
					// }
					riverMapReload();
					
				}else{
					
					var idx = 0;
					//선택포인트
					var selectObj = result['selectPoint'];
					
					for(var i=0; i < tot; i++){
						
						var obj = result['refreshData'][i];					
						
						var or_status;
						if(obj.con_or == '2' || obj.dow_or == '2' || obj.phy_or == '2'){
							or_status = '2';
						}
						else if(obj.con_or == '1' || obj.dow_or == '1' || obj.phy_or == '1'){
							or_status = '1';
						}
						else{
							or_status = '0';
						}
						var or_statusKor = or_status > '0' ? (or_status > '1' ? '주의' : '관심') : '정상';
						
						var item;
						var subItem;
						//var branchName = obj.fact_name;
						var maxor = obj.tur_or;
						
						/*ChangePoint(obj.fact_code + "_" + obj.branch_no, 0);
						 ChangePoint(obj.fact_code + "_" + obj.branch_no, obj.tur_or);
						
						 if(obj.tmp_or != null && obj.tmp_or != "" && obj.tmp_or > maxor)
						{
							maxor = obj.tmp_or;
							ChangePoint(obj.fact_code + "_" + obj.branch_no, obj.tmp_or);
						}
						if(obj.phy_or != null && obj.phy_or != "" && obj.phy_or > maxor)
						{
							maxor = obj.phy_or;
							ChangePoint(obj.fact_code + "_" + obj.branch_no, obj.phy_or);
						}
						if(obj.dow_or != null && obj.dow_or != "" && obj.dow_or > maxor)
						{
							maxor = obj.dow_or;
							ChangePoint(obj.fact_code + "_" + obj.branch_no, obj.dow_or);
						}
						if(obj.con_or != null && obj.con_or != "" && obj.con_or > maxor)
						{
							maxor = obj.con_or;
							ChangePoint(obj.fact_code + "_" + obj.branch_no, obj.con_or);
						} */
						
						riverMapData[obj.fact_code + "_" + obj.branch_no] = obj.tur;
						riverMapData_tmp[obj.fact_code + "_" + obj.branch_no] = obj.tmp;
						riverMapData_phy[obj.fact_code + "_" + obj.branch_no] = obj.phy;
						riverMapData_dow[obj.fact_code + "_" + obj.branch_no] = obj.dow;
						riverMapData_con[obj.fact_code + "_" + obj.branch_no] = obj.con;
						riverMapData_tof[obj.fact_code + "_" + obj.branch_no] = obj.tof;
						
						riverMapDataOr_phy[obj.fact_code + "_" + obj.branch_no] = obj.phy_or;
						riverMapDataOr_tmp[obj.fact_code + "_" + obj.branch_no] = obj.tmp_or;
						riverMapDataOr_dow[obj.fact_code + "_" + obj.branch_no] = obj.dow_or;
						riverMapDataOr_con[obj.fact_code + "_" + obj.branch_no] = obj.con_or;
						riverMapDataOr_tof[obj.fact_code + "_" + obj.branch_no] = obj.tof_or;
						riverMapDataOr[obj.fact_code + "_" + obj.branch_no] = obj.tur_or;
						riverMapBranch[obj.fact_code + "_" + obj.branch_no] = obj.branch_name;
						
						for(idx = 0;idx < 45;idx++)
						{
							var iName = itemArray[idx];
							var iCode = itemCode[idx];
							
							riverMapData[obj.fact_code + "_" + obj.branch_no + "_" + iCode] = eval("obj." + itemEName[idx]);
							riverMapDataOr[obj.fact_code + "_" + obj.branch_no + "_" + iCode] = eval("obj." + itemEName[idx] + "_or");
						}
						
						var factNumber = "";
						
						if(river == 'R01')
							factNumber = obj.fact_name.replace('한강', '');
						else if(river == 'R02')
							factNumber = obj.fact_name.replace('낙동강', '');
						else if(river == 'R03')
							factNumber = obj.fact_name.replace('금강', '');
						else if(river == 'R04')
							factNumber = obj.fact_name.replace('영산강','');
				
// 						chartFX gauge 라이센스??? 에러가뜸
// 						var onclick = "onclick=\"javascript:fndetailchart('"+obj.fact_code+"', '" + obj.branch_no + "', this.id);detailPopup('"+obj.fact_code+"', '" + obj.sys_kind + "', '" + obj.fact_name + "', '" +obj.branch_no+ "')\" style='cursor:pointer'";
						
						if(sys == 'A'){
							subItem = ""
									+"<td class='num' "+onclick+"><span id='tur"+i+"'>" + ((obj.tur == "") ? "-" : obj.tur)+ "</span></td>"
									+ "<td class='num' "+onclick+"><span id='phy"+i+"'>" + ((obj.phy == "") ? "-" : obj.phy)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='dow"+i+"'>" + ((obj.dow == "") ? "-" : obj.dow)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='con"+i+"'>" + ((obj.con == "") ? "-" : obj.con)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='tmp"+i+"'>" + ((obj.tmp == "") ? "-" : obj.tmp)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='tof"+i+"'>" + ((obj.tof == "") ? "-" : obj.tof)+ "</span></td>";
									//+"<td class='num' "+onclick+"><span id='phy2_"+i+"'>" + ((obj.phy2 == "") ? "-" : obj.phy2)+ "</span></td>"
									//+"<td class='num' "+onclick+"><span id='dow2_"+i+"'>" + ((obj.dow2 == "") ? "-" : obj.dow2)+ "</span></td>"
									//+"<td class='num' "+onclick+"><span id='con2_"+i+"'>" + ((obj.con2 == "") ? "-" : obj.con2)+ "</span></td>"
									//+"<td class='num' "+onclick+"><span id='tmp2_"+i+"'>" + ((obj.tmp2 == "") ? "-" : obj.tmp2)+ "</span></td>"
									/* +"<td class='num' "+onclick+"><span id='toc"+i+"'>" + ((obj.toc == "") ? "-" : obj.toc)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='imp"+i+"'>" + ((obj.imp == "") ? "-" : obj.imp)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='lim"+i+"'>" + ((obj.lim == "") ? "-" : obj.lim)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='rim"+i+"'>" + ((obj.rim == "") ? "-" : obj.rim)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='ltx"+i+"'>" + ((obj.ltx == "") ? "-" : obj.ltx)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='rtx"+i+"'>" + ((obj.rtx == "") ? "-" : obj.rtx)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='tox"+i+"'>" + ((obj.tox == "") ? "-" : obj.tox)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='evn"+i+"'>" + ((obj.evn == "") ? "-" : obj.evn)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='voc1_"+i+"'>" + ((obj.voc1 == "") ? "-" : obj.voc1)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='voc2_"+i+"'>" + ((obj.voc2 == "") ? "-" : obj.voc2)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='voc3_"+i+"'>" + ((obj.voc3 == "") ? "-" : obj.voc3)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='voc4_"+i+"'>" + ((obj.voc4 == "") ? "-" : obj.voc4)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='voc5_"+i+"'>" + ((obj.voc5 == "") ? "-" : obj.voc5)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='voc6_"+i+"'>" + ((obj.voc6 == "") ? "-" : obj.voc6)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='voc7_"+i+"'>" + ((obj.voc7 == "") ? "-" : obj.voc7)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='voc8_"+i+"'>" + ((obj.voc8 == "") ? "-" : obj.voc8)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='voc9_"+i+"'>" + ((obj.voc9 == "") ? "-" : obj.voc9)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='voc10_"+i+"'>" + ((obj.voc10 == "") ? "-" : obj.voc10)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='voc11_"+i+"'>" + ((obj.voc11 == "") ? "-" : obj.voc11)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='voc12_"+i+"'>" + ((obj.voc12 == "") ? "-" : obj.voc12)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='voc13_"+i+"'>" + ((obj.voc13 == "") ? "-" : obj.voc13)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='voc14_"+i+"'>" + ((obj.voc14 == "") ? "-" : obj.voc14)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='voc15_"+i+"'>" + ((obj.voc15 == "") ? "-" : obj.voc15)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='ton"+i+"'>" + ((obj.ton == "") ? "-" : obj.ton)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='top"+i+"'>" + ((obj.top == "") ? "-" : obj.top)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='nh4"+i+"'>" + ((obj.nh4 == "") ? "-" : obj.nh4)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='no3"+i+"'>" + ((obj.no3 == "") ? "-" : obj.no3)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='po4"+i+"'>" + ((obj.po4 == "") ? "-" : obj.po4)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='tof"+i+"'>" + ((obj.tof == "") ? "-" : obj.tof)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='cad"+i+"'>" + ((obj.cad == "") ? "-" : obj.cad)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='plu"+i+"'>" + ((obj.plu == "") ? "-" : obj.plu)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='cop"+i+"'>" + ((obj.cop == "") ? "-" : obj.cop)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='zin"+i+"'>" + ((obj.zin == "") ? "-" : obj.zin)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='phe"+i+"'>" + ((obj.phe == "") ? "-" : obj.phe)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='phl"+i+"'>" + ((obj.phl == "") ? "-" : obj.phl)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='rin"+i+"'>" + ((obj.rin == "") ? "-" : obj.rin)+ "</span></td>"; */
						}else{
							subItem = "<td class='num' "+onclick+"><span id='tur"+i+"'>" + ((obj.tur == "") ? "-" : obj.tur)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='tmp"+i+"'>" + ((obj.tmp == "") ? "-" : obj.tmp)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='phy"+i+"'>" + ((obj.phy == "") ? "-" : obj.phy)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='dow"+i+"'>" + ((obj.dow == "") ? "-" : obj.dow)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='con"+i+"'>" + ((obj.con == "") ? "-" : obj.con)+ "</span></td>";
							if(sys == "U")
								subItem += "<td class='num' "+onclick+"><span id='tof"+i+"'>" + ((obj.tof == "") ? "-" : obj.tof)+ "</span></td>";
						}						

						var strTemp="";
						if(obj.fact_code == selectObj.factCode && obj.branch_no == selectObj.branchNo){
							strTemp = "<tr style='background-color: #ffff48;' id='"+(i+1)+"' code='"+obj.fact_code+"' branchNo='"+obj.branch_no+ "'>";
						}
						else{
							strTemp = "<tr id='"+(i+1)+"' code='"+obj.fact_code+"' branchNo='"+obj.branch_no+ "'>";
						}						
						item = strTemp
								//+"<td "+onclick+">"+factNumber+"</td>"
								+"<td "+onclick+">"+obj.river_name+"</td>"
								+"<td "+onclick+">"+obj.branch_name+"</td>"+subItem;
						
						//item += "<td>"+obj.min_date +  "  " + obj.min_time+"</td>";
						//item += "<td><span id='status_name"+i+"'>"+obj.status_name +"</span></td>";
						//item += "<td><span id='or_status"+i+"'>"+or_statusKor +"</span></td>";
						item += "<td "+onclick+">"+obj.status_name +"</td>";
						item += "<td "+onclick+">"+or_statusKor +"</td>";
						item += "<td><img src=\"<c:url value='/images/common/btn_progress.gif'/>\"  style='cursor:pointer' onclick=\"transitionPopup('" + obj.fact_code + "', '" + obj.branch_no + "')\" alt='추이' /></td>";
						item += "<td><img src=\"<c:url value='/images/common/btn_map.gif'/>\" style='cursor:pointer' onclick=\"mapPopup('" + obj.fact_code + "', '" + obj.branch_no + "')\" alt='지도' /></a></td></tr>";
						
						var tmpMinTime = eval(obj.min_time.replace(":", "").substring(11,16));
						
						var temp1 = obj.min_time.replace("/", "-");
						var temp2 = temp1.replace("/", "-");
						
						$("#currDate").text("[ 최종수신일자 : " + temp2 + " ]");
						
						//if(tmpMinTime > maxMinTime)
						//{
							//maxMinTime = tmpMinTime;
							//maxTime = obj.min_date;// + " " + obj.min_time;
						//}
						
						$("#dataList").append(item);
						
						//$('#dataList').hover(stopScroll, startScroll);
						
						setMinOr_Color(or_status, $("#status_name" + i));
						setMinOr_Color(or_status, $("#or_status" + i));
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
						setMinOr_Color(obj.nh4_or, $("#nh4" + i));
						setMinOr_Color(obj.no3_or, $("#no3" + i));
						setMinOr_Color(obj.po4_or, $("#po4" + i));
						
						setMinOr_Color(obj.rin_or, $("#rin" + i));
						idx++;
					}
				}
				
				if(exTot < 1){
					$("#exSpan").css("display", "none");
					$("#exTable").css("display", "none");
				}
				else{
					$("#exSpan").css("display", "block");
					$("#exTable").css("display", "block");
					
					var exIdx = 0;
					//선택포인트
					
					for(var i=0; i < exTot; i++){
						
						var obj = result['refreshDataEx'][i];
						
						var or_status;
						if(obj.con_or == '2' || obj.dow_or == '2' || obj.phy_or == '2'){
							or_status = '2';
						}
						else if(obj.con_or == '1' || obj.dow_or == '1' || obj.phy_or == '1'){
							or_status = '1';
						}
						else{
							or_status = '0';
						}
						var or_statusKor = or_status > '0' ? (or_status > '1' ? '주의' : '관심') : '정상';
						
						var item;
						var subItem;
						//var branchName = obj.fact_name;
						var maxor = obj.tur_or;
						
						/*ChangePoint(obj.fact_code + "_" + obj.branch_no, 0);
						 ChangePoint(obj.fact_code + "_" + obj.branch_no, obj.tur_or);
						
						 if(obj.tmp_or != null && obj.tmp_or != "" && obj.tmp_or > maxor)
						{
							maxor = obj.tmp_or;
							ChangePoint(obj.fact_code + "_" + obj.branch_no, obj.tmp_or);
						}
						if(obj.phy_or != null && obj.phy_or != "" && obj.phy_or > maxor)
						{
							maxor = obj.phy_or;
							ChangePoint(obj.fact_code + "_" + obj.branch_no, obj.phy_or);
						}
						if(obj.dow_or != null && obj.dow_or != "" && obj.dow_or > maxor)
						{
							maxor = obj.dow_or;
							ChangePoint(obj.fact_code + "_" + obj.branch_no, obj.dow_or);
						}
						if(obj.con_or != null && obj.con_or != "" && obj.con_or > maxor)
						{
							maxor = obj.con_or;
							ChangePoint(obj.fact_code + "_" + obj.branch_no, obj.con_or);
						} */
						
						/* riverMapData[obj.fact_code + "_" + obj.branch_no] = obj.tur;
						riverMapData_tmp[obj.fact_code + "_" + obj.branch_no] = obj.tmp;
						riverMapData_phy[obj.fact_code + "_" + obj.branch_no] = obj.phy;
						riverMapData_dow[obj.fact_code + "_" + obj.branch_no] = obj.dow;
						riverMapData_con[obj.fact_code + "_" + obj.branch_no] = obj.con;
						riverMapData_tof[obj.fact_code + "_" + obj.branch_no] = obj.tof;
						
						riverMapDataOr_phy[obj.fact_code + "_" + obj.branch_no] = obj.phy_or;
						riverMapDataOr_tmp[obj.fact_code + "_" + obj.branch_no] = obj.tmp_or;
						riverMapDataOr_dow[obj.fact_code + "_" + obj.branch_no] = obj.dow_or;
						riverMapDataOr_con[obj.fact_code + "_" + obj.branch_no] = obj.con_or;
						riverMapDataOr_tof[obj.fact_code + "_" + obj.branch_no] = obj.tof_or;
						riverMapDataOr[obj.fact_code + "_" + obj.branch_no] = obj.tur_or;
						riverMapBranch[obj.fact_code + "_" + obj.branch_no] = obj.branch_name; */
						
						/* for(exIdx = 0;exIdx < 45;exIdx++)
						{
							var iName = itemArray[exIdx];
							var iCode = itemCode[exIdx];
							
							riverMapData[obj.fact_code + "_" + obj.branch_no + "_" + iCode] = eval("obj." + itemEName[exIdx]);
							riverMapDataOr[obj.fact_code + "_" + obj.branch_no + "_" + iCode] = eval("obj." + itemEName[exIdx] + "_or");
						} */
						
						var factNumber = "";
						
						/* if(river == 'R01')
							factNumber = obj.fact_name.replace('한강', '');
						else if(river == 'R02')
							factNumber = obj.fact_name.replace('낙동강', '');
						else if(river == 'R03')
							factNumber = obj.fact_name.replace('금강', '');
						else if(river == 'R04')
							factNumber = obj.fact_name.replace('영산강',''); */
				
// 						chartFX gauge 라이센스??? 에러가뜸
// 						var onclick = "onclick=\"javascript:fndetailchart('"+obj.fact_code+"', '" + obj.branch_no + "', this.id);detailPopup('"+obj.fact_code+"', '" + obj.sys_kind + "', '" + obj.fact_name + "', '" +obj.branch_no+ "')\" style='cursor:pointer'";
						
						if(sys == 'A'){
							subItem = ""
									+"<td class='num' "+onclick+"><span id='extur"+i+"'>" + ((obj.tur == "") ? "-" : obj.tur)+ "</span></td>"
									+ "<td class='num' "+onclick+"><span id='exphy"+i+"'>" + ((obj.phy == "") ? "-" : obj.phy)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exdow"+i+"'>" + ((obj.dow == "") ? "-" : obj.dow)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='excon"+i+"'>" + ((obj.con == "") ? "-" : obj.con)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='extmp"+i+"'>" + ((obj.tmp == "") ? "-" : obj.tmp)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='extof"+i+"'>" + ((obj.tof == "") ? "-" : obj.tof)+ "</span></td>";
									//+"<td class='num' "+onclick+"><span id='phy2_"+i+"'>" + ((obj.phy2 == "") ? "-" : obj.phy2)+ "</span></td>"
									//+"<td class='num' "+onclick+"><span id='dow2_"+i+"'>" + ((obj.dow2 == "") ? "-" : obj.dow2)+ "</span></td>"
									//+"<td class='num' "+onclick+"><span id='con2_"+i+"'>" + ((obj.con2 == "") ? "-" : obj.con2)+ "</span></td>"
									//+"<td class='num' "+onclick+"><span id='tmp2_"+i+"'>" + ((obj.tmp2 == "") ? "-" : obj.tmp2)+ "</span></td>"
									/* +"<td class='num' "+onclick+"><span id='extoc"+i+"'>" + ((obj.toc == "") ? "-" : obj.toc)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='eximp"+i+"'>" + ((obj.imp == "") ? "-" : obj.imp)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exlim"+i+"'>" + ((obj.lim == "") ? "-" : obj.lim)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exrim"+i+"'>" + ((obj.rim == "") ? "-" : obj.rim)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exltx"+i+"'>" + ((obj.ltx == "") ? "-" : obj.ltx)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exrtx"+i+"'>" + ((obj.rtx == "") ? "-" : obj.rtx)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='extox"+i+"'>" + ((obj.tox == "") ? "-" : obj.tox)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exevn"+i+"'>" + ((obj.evn == "") ? "-" : obj.evn)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exvoc1_"+i+"'>" + ((obj.voc1 == "") ? "-" : obj.voc1)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exvoc2_"+i+"'>" + ((obj.voc2 == "") ? "-" : obj.voc2)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exvoc3_"+i+"'>" + ((obj.voc3 == "") ? "-" : obj.voc3)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exvoc4_"+i+"'>" + ((obj.voc4 == "") ? "-" : obj.voc4)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exvoc5_"+i+"'>" + ((obj.voc5 == "") ? "-" : obj.voc5)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exvoc6_"+i+"'>" + ((obj.voc6 == "") ? "-" : obj.voc6)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exvoc7_"+i+"'>" + ((obj.voc7 == "") ? "-" : obj.voc7)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exvoc8_"+i+"'>" + ((obj.voc8 == "") ? "-" : obj.voc8)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exvoc9_"+i+"'>" + ((obj.voc9 == "") ? "-" : obj.voc9)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exvoc10_"+i+"'>" + ((obj.voc10 == "") ? "-" : obj.voc10)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exvoc11_"+i+"'>" + ((obj.voc11 == "") ? "-" : obj.voc11)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exvoc12_"+i+"'>" + ((obj.voc12 == "") ? "-" : obj.voc12)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exvoc13_"+i+"'>" + ((obj.voc13 == "") ? "-" : obj.voc13)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exvoc14_"+i+"'>" + ((obj.voc14 == "") ? "-" : obj.voc14)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exvoc15_"+i+"'>" + ((obj.voc15 == "") ? "-" : obj.voc15)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exton"+i+"'>" + ((obj.ton == "") ? "-" : obj.ton)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='extop"+i+"'>" + ((obj.top == "") ? "-" : obj.top)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exnh4"+i+"'>" + ((obj.nh4 == "") ? "-" : obj.nh4)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exno3"+i+"'>" + ((obj.no3 == "") ? "-" : obj.no3)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='expo4"+i+"'>" + ((obj.po4 == "") ? "-" : obj.po4)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='extof"+i+"'>" + ((obj.tof == "") ? "-" : obj.tof)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='excad"+i+"'>" + ((obj.cad == "") ? "-" : obj.cad)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='explu"+i+"'>" + ((obj.plu == "") ? "-" : obj.plu)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='excop"+i+"'>" + ((obj.cop == "") ? "-" : obj.cop)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exzin"+i+"'>" + ((obj.zin == "") ? "-" : obj.zin)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exphe"+i+"'>" + ((obj.phe == "") ? "-" : obj.phe)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exphl"+i+"'>" + ((obj.phl == "") ? "-" : obj.phl)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exrin"+i+"'>" + ((obj.rin == "") ? "-" : obj.rin)+ "</span></td>"; */
						}else{
							subItem = "<td class='num' "+onclick+"><span id='extur"+i+"'>" + ((obj.tur == "") ? "-" : obj.tur)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='extmp"+i+"'>" + ((obj.tmp == "") ? "-" : obj.tmp)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exphy"+i+"'>" + ((obj.phy == "") ? "-" : obj.phy)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='exdow"+i+"'>" + ((obj.dow == "") ? "-" : obj.dow)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='excon"+i+"'>" + ((obj.con == "") ? "-" : obj.con)+ "</span></td>";
							if(sys == "U")
								subItem += "<td class='num' "+onclick+"><span id='extof"+i+"'>" + ((obj.tof == "") ? "-" : obj.tof)+ "</span></td>";
						}						

						var strTemp = "<tr id=ex'"+(i+1)+"' code='"+obj.fact_code+"' branchNo='"+obj.branch_no+ "'>";
												
						item = strTemp
								//+"<td "+onclick+">"+factNumber+"</td>"
								+"<td "+onclick+">"+obj.river_name+"</td>"
								+"<td "+onclick+">"+obj.branch_name+"</td>"+subItem;
						
						//item += "<td>"+obj.min_date +  "  " + obj.min_time+"</td>";
						//item += "<td><span id='status_name"+i+"'>"+obj.status_name +"</span></td>";
						//item += "<td><span id='or_status"+i+"'>"+or_statusKor +"</span></td>";
						item += "<td "+onclick+">"+obj.status_name +"</td>";
						item += "<td "+onclick+">"+or_statusKor +"</td>";
						item += "<td><img src=\"<c:url value='/images/common/btn_progress.gif'/>\"  style='cursor:pointer' onclick=\"transitionPopup('" + obj.fact_code + "', '" + obj.branch_no + "')\" alt='추이' /></td>";
						item += "<td><img src=\"<c:url value='/images/common/btn_map.gif'/>\" style='cursor:pointer' onclick=\"mapPopup('" + obj.fact_code + "', '" + obj.branch_no + "')\" alt='지도' /></a></td></tr>";
						
						var tmpMinTime = eval(obj.min_time.replace(":", "").substring(11,16));
						
						var temp1 = obj.min_time.replace("/", "-");
						var temp2 = temp1.replace("/", "-");
						
						$("#currDate").text("[ 최종수신일자 : " + temp2 + " ]");
						
						//if(tmpMinTime > maxMinTime)
						//{
							//maxMinTime = tmpMinTime;
							//maxTime = obj.min_date;// + " " + obj.min_time;
						//}
						
						$("#dataListEx").append(item);
						
						//$('#dataList').hover(stopScroll, startScroll);
						
						setMinOr_Color(or_status, $("#exstatus_name" + i));
						setMinOr_Color(or_status, $("#exor_status" + i));
						setMinOr_Color(obj.tur_or, $("#extur" + i));
						setMinOr_Color(obj.tmp_or, $("#extmp" + i));
						setMinOr_Color(obj.phy_or, $("#exphy" + i));
						setMinOr_Color(obj.dow_or, $("#exdow" + i));
						setMinOr_Color(obj.con_or, $("#excon" + i));
						
						setMinOr_Color(obj.phy2_or, $("#exphy2_" + i));
						setMinOr_Color(obj.dow2_or, $("#exdow2_" + i));
						setMinOr_Color(obj.con2_or, $("#excon2_" + i));
						setMinOr_Color(obj.tmp2_or, $("#extmp2_" + i));
						
						setMinOr_Color(obj.imp_or, $("#eximp" + i));
						setMinOr_Color(obj.lim_or, $("#exlim" + i));
						setMinOr_Color(obj.rim_or, $("#exrim" + i));
						setMinOr_Color(obj.ltx_or, $("#exltx" + i));
						setMinOr_Color(obj.rtx_or, $("#exrtx" + i));
						setMinOr_Color(obj.tox_or, $("#extox" + i));
						setMinOr_Color(obj.evn_or, $("#exevn" + i));
						setMinOr_Color(obj.tof_or, $("#extof" + i));
						
						setMinOr_Color(obj.voc1_or, $("#exvoc1_" + i));
						setMinOr_Color(obj.voc2_or, $("#exvoc2_" + i));
						setMinOr_Color(obj.voc3_or, $("#exvoc3_" + i));
						setMinOr_Color(obj.voc4_or, $("#exvoc4_" + i));
						setMinOr_Color(obj.voc5_or, $("#exvoc5_" + i));
						setMinOr_Color(obj.voc6_or, $("#exvoc6_" + i));
						setMinOr_Color(obj.voc7_or, $("#exvoc7_" + i));
						setMinOr_Color(obj.voc8_or, $("#exvoc8_" + i));
						setMinOr_Color(obj.voc9_or, $("#exvoc9_" + i));
						setMinOr_Color(obj.voc10_or, $("#exvoc10_" + i));
						setMinOr_Color(obj.voc11_or, $("#exvoc11_" + i));
						setMinOr_Color(obj.voc12_or, $("#exvoc12_" + i));
						setMinOr_Color(obj.voc13_or, $("#exvoc13_" + i));
						setMinOr_Color(obj.voc14_or, $("#exvoc14_" + i));
						setMinOr_Color(obj.voc15_or, $("#exvoc15_" + i));
						
						setMinOr_Color(obj.cad_or, $("#excad" + i));
						setMinOr_Color(obj.plu_or, $("#explu" + i));
						setMinOr_Color(obj.cop_or, $("#excop" + i));
						setMinOr_Color(obj.zin_or, $("#exzin" + i));
						setMinOr_Color(obj.phe_or, $("#exphe" + i));
						setMinOr_Color(obj.phl_or, $("#exphl" + i));
						setMinOr_Color(obj.toc_or, $("#extoc" + i));
						setMinOr_Color(obj.ton_or, $("#exton" + i));
						setMinOr_Color(obj.top_or, $("#extop" + i));
						setMinOr_Color(obj.nh4_or, $("#exnh4" + i));
						setMinOr_Color(obj.no3_or, $("#exno3" + i));
						setMinOr_Color(obj.po4_or, $("#expo4" + i));
						
						setMinOr_Color(obj.rin_or, $("#exrin" + i));
						exIdx++;
					}
				}
			
				//AutoScroll();
				closeLoading();
				riverMapReload();
				
			//TR색 변경
			//  $("#dataList tr:nth-child(even)").addClass("add");
				
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
				
				$("#dataList").html("<tr><td colspan='"+(itemCnt + 5)+"'>서버 접속에 실패하였습니다!</td></tr>");	
				$("#loadingDiv").dialog("close");
				$("#mainBody").css("overflow","auto");
				
				closeLoading();
			}
		});
	}
	
	//Min or  값에 따른 값의 색 변화 
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
	
	function detailPopup(fact_code, sys_kind, fact_name, branch_no) {
		/*  팝업 안나오게 하랍니다~
		var sw=screen.width;var sh=screen.height;
		var winHeight = 890;
		var winWidth = 1260;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;


		var src = "<c:url value='/waterpolmnt/situationctl/goWatersysMntMainDetail.do'/>?fact_code="+fact_code+"&branch_no=" +branch_no + "&sys_kind=" + sys_kind + "&fact_name=" + encodeURI(fact_name);

		window.open(src,	
				'WatersysMntMainDetail','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
		*/
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
	
	function chartVisibleSet()
	{
		var sysKind = $('#sys').val();
		
		if(sysKind == 'T'){
			
			if(!$("#chkTUR").is(":checked"))
				$('#gauge1').slideUp('500', null);
			else
				$('#gauge1').show();
			
			if(!$("#chkCON").is(":checked"))
				$('#gauge2').slideUp('500', null);
			else
				$('#gauge2').show();
			
			$('#gauge3').slideUp('500', null);
			$('#gauge4').slideUp('500', null);
			$('#gauge5').slideUp('500', null);
		}else if(sysKind == 'U'){
			
			if(!$("#chkTUR").is(":checked"))
				$('#gauge1').slideUp('500', null);
			else
				$('#gauge1').show();
			
			if(!$("#chkDOW").is(":checked"))
				$('#gauge2').slideUp('500',null);
			else
				$('#gauge2').show();
				
			if(!$("#chkTMP").is(":checked"))
				$('#gauge3').slideUp('500', null);
			else
				$('#gauge3').show();
			
			if(!$("#chkPHY").is(":checked"))
				$('#gauge4').slideUp('500',null);
			else
				$('#gauge4').show();
			
			if(!$("#chkCON").is(":checked"))
				$('#gauge5').slideUp('500', null);
			else
				$('#gauge5').show();
				
		}else if(sysKind == 'A'){
			if(!$("#chkAA1").is(":checked"))
				$('#gauge1').slideUp('500', null);
			else
				$('#gauge1').show();
				
			if(!$("#chkAA2").is(":checked"))
				$('#gauge2').slideUp('500',null);
			else
				$('#gauge2').show();
			
			if(!$("#chkAA3").is(":checked"))
				$('#gauge3').slideUp('500', null);
			else
				$('#gauge3').show();
				
			if(!$("#chkAA4").is(":checked"))
				$('#gauge4').slideUp('500',null);
			else
				$('#gauge4').show();
				
			$('#gauge5').slideUp('500', null);
		}
	}
	
	function fndetailchart(factCode, branchNo){
		//차트변경시 Top Data변경
		
		if(factCode == null || factCode == undefined) { factCode = ""; return;}
		if(branchNo==null ||  branchNo == undefined) { branchNo = "1"; return; }
		var cnt;
		var itemCode;
		var width=200;
		var height=25;
		var sysKind = $('#sys').val();
		var riverDiv = $('#river').val();
		
		var src = "<c:url value='/waterpolmnt/situationctl/getRiverGaugeChart.do'/>?riverDiv="+riverDiv+"&sysKind="+sysKind+"&itemCode="
			+itemCode+"&itemName="+'TUR'+"&width="+width+"&height="+height+"&factCode="+factCode+"&branchNo="
			+branchNo;
		
// 		$("#chart").attr("src", src);
	}
	
	function getSrc(param, no){
	
		$.get(param,null,
				function(data){
					var src = $(data).attr("src");
					$('#gauge'+no).attr("src", src);
					//$('#gauge'+no).show();
				}
		);
	}
	
	var chartIdx = 0;
	var noScrollIdx = 0;
	var firstFlag = true;
	function AutoScroll() {
		
		var sHeight = $("#dataList").attr("scrollHeight");
		
		var factCode = $('tbody#dataList tr:nth-child(' + (chartIdx+1) + ')').attr('code');
		var branchNo = $('tbody#dataList tr:nth-child(' + (chartIdx+1) + ')').attr('branchNo');
		
		//TR색 변경
		//if(chartIdx != 0)
		$("tbody#dataList tr").attr("class","");
		$("tbody#dataList tr:nth-child("+(chartIdx+1)+")").addClass("add");
		
		//462
		if(sHeight >= 455)
		{
			if(!firstFlag)
			{
				$('tbody#dataList tr:first').attr("class", "");
				$('tbody#dataList tr:first').appendTo('#dataList');
				$('tbody#dataList tr:first').attr("class", "");
				$('tbody#dataList tr:first').addClass("add");
			}
			firstFlag = false;
			
			if(resultObj != null){
				setTopData(noScrollIdx, factCode, branchNo);
			}
			
			noScrollIdx++;
			
			if(noScrollIdx >= $('tbody#dataList tr').size())
			{  
				noScrollIdx = 0;
			}
		}
		else
		{
			if(chartIdx == 0)
			{
				clearGauge();	//처음으로 돌아갈때 클리어시킴
				clearWeather();
			}
			
			if(resultObj != null){
				setTopData(chartIdx, factCode, branchNo);
			}
			
			chartIdx++;
			
			if(chartIdx >= $('tbody#dataList tr').size())
			{  
				chartIdx = 0;
			}
		}
	}
	
	
	var runScroll;
	
	function toggleScroll(action){
		if( action == 'start' ){
			runScroll=setInterval('AutoScroll()', (1000*10));
		}else if( action == 'stop' ){
			clearInterval(runScroll);
		}	
	}
	
	function stopScroll(){
		toggleScroll('stop');
	}
	
	function startScroll(){
		toggleScroll('start');
	}
	
	function getWeatherInfo(factCode, branchNo, sq)
	{
		var sys = $("#sys");
		//if(sys != "U" && factCode != "47T2023")
		//{
		//	branchNo = '1';
		//}
		
		$.ajax({
			type:"post",
			url:"<c:url value='/weather/getCurrentWeather.do'/>",
			cache:false,
			data:{factCode:factCode, branchNo:branchNo},
			dataType:"json",
			success:function(result) { setWeatherData(result['weatherInfo'], sq); },
			error:function() { }
		});
	}
	
	function clearWeather()
	{
		for(var idx = 1 ; idx <= 3; idx++)
		{
			var weatherImg = $("#weatherImg" + idx);
			var weatherForecast = $("#weatherSpan" + idx);
			
			weatherImg.hide();
			//weatherImg.attr("src", "<c:url value='/images/content/NB01.png'/>");
			weatherForecast.text("");
		}
	}
	
	function setWeatherData(data, sq)
	{
		if(data != null)
		{
				var weatherImg = $("#weatherImg" + sq);
				var weatherForecast = $("#weatherSpan" + sq);
				
				weatherImg.show();
				
				var src = "<c:url value='/images/content/'/>";
				var weather = "";
				
				if(data.current_weather == null || data.current_weather == "")
					data.current_weather =  data.weather_sky;
				
				switch(data.current_weather)
				{
				case "맑음" : 
					src += "NB01.png";
					break;
				case "구름조금" :
					src += "NB02.png";
					break;
				case "소나기 끝":
				case "구름많음" :
					src += "NB03.png";
					break;
				case "소낙눈 끝":
				case "진눈개비끝" :
				case "눈 끝남" :
				case "비 끝남" : 
				case "흐림" :
					src += "NB04.png";
					break;
				case "소나기" :
					src += "NB05.png";
					break;
				case "뇌우끝,비" :
				case "약한비단속" :
				case "약한비계속" :
				case "보통비계속" :
				case "보통비단속" :
				case "구름조금 비" :
				case "구름많음 비" :
				case "약한이슬비":
				case "보통이슬비":
				case "보통소나기":
				case "약한소나기":
				case "이슬비 끝":
				case "흐림 비":
				case "비" :
					src += "NB08.png";
					break;
				case "약한눈단속" :
				case "약한눈계속" :
				case "보통눈계속" :
				case "보통눈단속" :
				case "구름조금 눈":
				case "구름많음 눈":
				case "흐림 눈":
				case "눈" :
					src += "NB11.png";
					break;
				case "약진눈개비":
				case "강진눈개비":
				case "구름조금 비/눈":
				case "구름많음 비/눈":
				case "흐림 비/눈":
				case "비 또는 눈" : 
					src += "NB12.png";
					break;
				case "눈 또는 비" : 
					src += "NB13.png";
					break;
				case "뇌우" :
				case "천둥번개" : 
					src += "NB14.png";
					break;
				case "안개강해짐" :
				case "안개변화무" :
				case "안개 끝" :
				case "안개" :
					src += "NB15.png";
					break;
				case "박무" :
					src += "NB17.png";
					break;
				case "황사" :
					src += "NB16.png";
					break;
				case "안개엷어짐":
				case "연무" :
					src += "NB18.png";
					break;
				default :
					src += "NB01_N.png";
					weatherImg.hide();
					break;
				}
				
				weatherImg.attr("src", src);
				weatherForecast.text(data.current_weather + " (" + data.temp + " ℃)");
		}
	}
	
	// 왼쪽 수계표 관련 
	var page = 0; //낙동강 페이징 관련
	
	function riverMapReload()
	{
		page = 0;
		riverPageBtnInit(); // 페이지 표시 초기화
		InitPoint();
	}
	
	//탁수
	var arrPointX = new Array();
	var arrPointY = new Array();
	var arrPointId = new Array();
	var arrPointNm = new Array();
	var arrPointSt = new Array();
	var arrPointRiverDiv = new Array();
	var arrPointMap = new Object();
	
	//IP_USN
	var u_arrPointX = new Array();
	var u_arrPointY = new Array();
	var u_arrPointId = new Array();
	var u_arrPointNm = new Array();
	var u_arrPointSt = new Array();
	var u_arrPointRiverDiv = new Array();
	var u_arrPointMap = new Object();
	
	//수질자동측정
	var a_arrPointX = new Array();
	var a_arrPointY = new Array();
	var a_arrPointId = new Array();
	var a_arrPointNm = new Array();
	var a_arrPointSt = new Array();
	var a_arrPointRiverDiv = new Array();
	var a_arrPointMap = new Object();
	
	/*
	국가수질자동측정망 좌표 
	*/
	<c:forEach items="${a_coordData}" var="a_coordData"  varStatus="status">
		a_arrPointX[${status.index}] = ${a_coordData.coord_x};
		a_arrPointY[${status.index}] = ${a_coordData.coord_y};
		a_arrPointSt[${status.index}] = 5;
		a_arrPointId[${status.index}] = '${a_coordData.fact_code}_${a_coordData.branch_no}';
		a_arrPointNm[${status.index}] = '${a_coordData.branch_name}-${a_coordData.branch_no}';
		a_arrPointRiverDiv[${status.index}] = '${a_coordData.river_div}'
		a_arrPointMap['${a_coordData.fact_code}_${a_coordData.branch_no}'] = ${status.index};
	</c:forEach>
	
	/*
	탁수 모니터링 좌표 
	*/
	<c:forEach items="${t_coordData}"  var="t_coordData"  varStatus="status">
		arrPointX[${status.index}] = ${t_coordData.coord_x};
		arrPointY[${status.index}] = ${t_coordData.coord_y};
		arrPointSt[${status.index}] = 5;
		arrPointId[${status.index}] = '${t_coordData.fact_code}_${t_coordData.branch_no}';
		arrPointNm[${status.index}] = '${t_coordData.branch_name}-${t_coordData.branch_no}';
		arrPointRiverDiv[${status.index}] = '${t_coordData.river_div}'
		arrPointMap['${t_coordData.fact_code}_${t_coordData.branch_no}'] = ${status.index};
	</c:forEach>
	
		
	/*
	  IP- USN 좌표
	 */
	<c:forEach items="${u_coordData}"  var="u_coordData"  varStatus="status">
		u_arrPointX[${status.index}] = ${u_coordData.coord_x};  
		u_arrPointY[${status.index}] = ${u_coordData.coord_y};  
		u_arrPointSt[${status.index}] = 5;
		u_arrPointId[${status.index}] = '${u_coordData.fact_code}_${u_coordData.branch_no}';
		u_arrPointNm[${status.index}] = '${u_coordData.branch_name}-${u_coordData.branch_no}';
		u_arrPointRiverDiv[${status.index}] = '${u_coordData.river_div}'
		u_arrPointMap['${u_coordData.fact_code}_${u_coordData.branch_no}'] = ${status.index};
	</c:forEach>
	
	function SetWichi(nLeft, nTop, sNm, sId, nSt){
	
		var result = "<c:url value='/images/popup/bu_circle_'/>";
		
		//testImg = new Image();
		var src;
		
		if (nSt == 0)
			src = result += "green.gif";
		else if (nSt == 1)
			src = result += "blue.gif";
		else if (nSt == 2)
			src = result += "yellow.gif";
		else if (nSt == 3)
			src = result += "orange.gif";
		else if (nSt == 4)
			src = result += "red.gif";
		else src = result += "black.gif";
		
		objArea = document.getElementById('objectBox');
		//objArea = $("#objectBox");
		//testImg.style.left = nLeft+objArea.offsetLeft-15;
		//testImg.style.top  = nTop+objArea.offsetTop-10;
		//testImg.alt		= sNm;
		//testImg.id		 = sId;
		
		var left = nLeft+$("#objectBox").offset().left-5;
		var top  = nTop+$("#objectBox").offset().top-5;
		
		var alt = sNm;
		var id = sId;
		
		//var tgStrImg = "<img src='"+testImg.src+"' id='img_"+testImg.id+"' onClick='' onMouseOver='' style='cursor:hand; position:absolute; top:"+testImg.style.top+"; left:"+testImg.style.left+"; dispaly:; z-index:2;' alt='"+testImg.alt+"["+testImg.id+"]'></img>";
		//var tgStrImg = "<img src='"+testImg.src+"' id='img_"+testImg.id+"' onClick='alert(\""+testImg.alt+"["+testImg.id+"]\")' onMouseOver='showData(\""+testImg.style.top+"\",\"" +testImg.style.left+ "\",\"" + sId + "\",\"" + sNm + "\")' onMouseOut='hideData()'  style='cursor:hand; position:absolute; top:"+testImg.style.top+"; left:"+testImg.style.left+"; dispaly:; z-index:2;' alt='"+testImg.alt+"["+testImg.id+"]'></img>";
		var tgStrImg = "<img class='chroma' src='"+src+"' id='img_"+id+"' onMouseOver='showData(\""+top+"\",\"" +left+ "\",\"" + sId + "\",\"" + sNm + "\")' onMouseOut='hideData()'  style='cursor:hand; position:absolute; top:"+top+"px; left:"+left+"px; dispaly:; z-index:2;' alt='"+alt+"["+id+"]'></img>";
		//var tgStrImg = "<img src='"+testImg.src+"' id='img_"+testImg.id+"' onClick='' onMouseOver='' style='cursor:hand; position:absolute; top:"+(document.getElementById('baseMap').style.top.value+testImg.style.top)+"; left:"+(document.getElementById('baseMap').style.left.value+testImg.style.left)+"; dispaly:; z-index:2;' alt='"+testImg.alt+"["+testImg.id+"]'></img>";
		
		//var tgStrImg = "<img src='"+testImg.src+"' id='img_"+testImg.id+"' onClick='' onMouseOver='' style='cursor:hand; position:absolute; top:"+(objArea.style.top+testImg.style.top.value)+"; left:"+(objArea.style.left.value+testImg.style.left)+"; dispaly:; z-index:2;' alt='"+testImg.alt+"["+testImg.id+"]'></img>";
		//objArea.insertAdjacentHTML('beforeEnd', tgStrImg);
		
		$("#objectBox").append(tgStrImg);
	}
	
	// 아이콘 초기화
	function InitPoint()
	{
		var river = $('#river').val();
		var sys = $('#sys').val();
		
		$("#objectBox").html("");
		
		var imgFile = river;
		
		if(page == 1)
			imgFile = river + "_2";
		
		$("#objectBox").html("<img src='<c:url value='/images/content/"+ imgFile +".jpg'/>' width='100%' height='100%'/>");
		
		if(sys == "T")
		{
			for (i = 0 ; i < arrPointId.length ; i++){
					
					if(arrPointRiverDiv[i] == river)
					{
						//해당 페이지에 해당하는 측정소만 표시 (Y좌표 1000단위로 페이지 구분함)
						if((1000 * page) <= arrPointY[i] && (1000*(page+1)) >= arrPointY[i])
						{
							var tmpArrPointY = arrPointY[i] - (1000 * page);
							
							SetWichi(arrPointX[i], tmpArrPointY, arrPointNm[i], arrPointId[i], arrPointSt[i]);
						}
					}
			}
		}
		else if(sys == "A")
		{
			for (i = 0  ; i < a_arrPointId.length ; i++){
				
				if(a_arrPointRiverDiv[i] == river)
				{
					if((1000 * page) <= a_arrPointY[i] && (1000*(page+1)) >= a_arrPointY[i])
					{
						var tmpArrPointY = a_arrPointY[i] - (1000 * page);
						SetWichi(a_arrPointX[i], tmpArrPointY, a_arrPointNm[i], a_arrPointId[i], a_arrPointSt[i]);
					}
				}
			}
		}
		else if(sys == "U")
		{
			for (i = 0  ; i < u_arrPointId.length ; i++){
				
				if(u_arrPointRiverDiv[i] == river)
				{
					if((1000 * page) <= u_arrPointY[i] && (1000*(page+1)) >= u_arrPointY[i])
					{
						var tmpArrPointY = u_arrPointY[i] - (1000 * page);
						SetWichi(u_arrPointX[i], tmpArrPointY, u_arrPointNm[i], u_arrPointId[i], u_arrPointSt[i]);
					}
				}
			}
		}
	}
		// 윈도우 리사이즈시 호출됨.
	jQuery(window).resize(function(){
		//showData(viewType);
		InitPoint();
		alphaDivLeftSet();
	});
	
	//투명 위치 확인 창 왼쪽 맞춤 (덤으로 next, prev 버튼도 위치 맞춰줌)
	function alphaDivLeftSet()
	{
		objArea = document.getElementById('objectBox');
		var river = $("#river").val();
			
		var left = $("#objectBox").offset().left;
		var top = $("#objectBox").offset().top;
		
		$("#alphaDiv").css("left", left);
		
		if(river == "R01")
		{
			$("#btnNext").attr("src", "<c:url value='/images/waterpolmnt/arrow_prev.png'/>");
			$("#btnNext").css("top", top+290);
			$("#btnNext").css("left", left+4);
			$("#btnPrev").attr("src", "<c:url value='/images/waterpolmnt/arrow_next.png'/>");
			$("#btnPrev").css("top", top+290);
			$("#btnPrev").css("left", left+150);
		}
		if(river == "R02")
		{
			$("#btnNext").attr("src", "<c:url value='/images/waterpolmnt/arrow_down.png'/>");
			$("#btnNext").css("top", top+653);
			$("#btnNext").css("left", left+140);
			$("#btnPrev").attr("src", "<c:url value='/images/waterpolmnt/arrow_up.png'/>");
			$("#btnPrev").css("top", top+0);
			$("#btnPrev").css("left", left+140);
		}
		
	}
	
	//투명창 이동
	var moveAlphaDiv;
	
	function alphaDivMove(topCoord)
	{
		//현재 페이지에 해당하는 측정소일때만 투명창  표시
		if(topCoord >= (page*1000) && topCoord <= ((page+1) * 1000))
		{
			objArea = document.getElementById('objectBox');
			var top  = topCoord+$("#objectBox").offset().top-25;
			
			top = top - (page * 1000);
			
			/* fadeIn - fadeout */
			$("#alphaDiv").fadeOut("normal", function() { 
				$("#alphaDiv").css("top", top);
				$("#alphaDiv").fadeIn("normal");
			});
			
			/* 위치로 스크롤링 */
			/*
			//현재 투명창 위치
			var offset = $("#alphaDiv").offset();
			var currentTop = offset.top;
			
			var upDown = ''
			
			if(currentTop > top)
				upDown = 'up';
			else if(currentTop < top)
				upDown = 'down';
			else
				return;
			
			moveAlphaDiv=setInterval('moveDiv(\"'+top+'\", \"'+upDown+'\")', 10);
			*/
		}
		else if(topCoord == null || topCoord == 0)
		{
			$("#alphaDiv").fadeOut('fast');
		}
		else
		{
			$("#alphaDiv").fadeOut('fast');
			
			if(page == 0)
				riverMapNext();
			else if(page == 1)
				riverMapPrev();
				
			alphaDivMove(topCoord);
		}
	}
	
	//투명창 스크롤링 
	function moveDiv(topCoord, upDown)
	{
		//현재 투명창 위치
		var offset = $("#alphaDiv").offset();
		var currentTop = offset.top;
		
		if(upDown == 'up')
		{
			currentTop -= 5;
			
			if(topCoord >= currentTop)
			{
				$("#alphaDiv").css("top", topCoord);
				clearInterval(moveAlphaDiv);
			}
			else
				$("#alphaDiv").css("top", currentTop);
		}
		else if(upDown == 'down')
		{
			currentTop += 5;
			
			if(topCoord <= currentTop)
			{
				$("#alphaDiv").css("top", topCoord);
				clearInterval(moveAlphaDiv);
			}
			else
				$("#alphaDiv").css("top", currentTop);
		}
	}
	
	//맵 클릭 - Admin 권한일 때 좌표수정 팝업 표시
	function riverMapClick(e)
	{
		modifyPopup();
	}
	
	// 아이콘 색상 변경
	function ChangePoint(sId, nSt){
		var sys = $('#sys').val();
	
		if(sys == "T")
		{
			for (i = 0  ; i < arrPointId.length ; i++){
				
				if(sId == arrPointId[i]){
					
					if((1000 * page) <= arrPointY[i] && (1000*(page+1)) >= arrPointY[i])
					{
						arrPointSt[i] = nSt;
						
						objId = "img_" + arrPointId[i];
						objImg = document.getElementById(objId);
						//alert(objImg);
						
						var result = "<c:url value='/images/popup/bu_circle_'/>";
						
						if (nSt == 0){
							objImg.src = result += "green.gif";
						}else if (nSt == 1){
							objImg.src = result += "blue.gif";
						}else if (nSt == 2){
							objImg.src = result += "yellow.gif";
						}else if (nSt == 3){
							objImg.src = result += "orange.gif";
						}
						else if (nSt == 4){
							objImg.src = result += "red.gif";
						}
						else
							objImg.src = result += "black.gif";
					}
					else
					{
						arrPointSt[i] = nSt;
					}
				}
			}
		}
		else if(sys == "U")
		{
			
			for (i = 0  ; i < u_arrPointId.length ; i++){
				
				if(sId == u_arrPointId[i]){
					
					if((1000 * page) <= u_arrPointY[i] && (1000*(page+1)) >= u_arrPointY[i])
					{
						
						u_arrPointSt[i] = nSt;
						
						objId = "img_" + u_arrPointId[i];
						objImg = document.getElementById(objId);
						
						
						var result = "<c:url value='/images/popup/bu_circle_'/>";
						
						if (nSt == 0){
							objImg.src = result += "green.gif";
						}else if (nSt == 1){
							objImg.src = result += "blue.gif";
						}else if (nSt == 2){
							objImg.src = result += "yellow.gif";
						}else if (nSt == 3){
							objImg.src = result += "orange.gif";
						}
						else if (nSt == 4){
							objImg.src = result += "red.gif";
						}
						else
							objImg.src = result += "black.gif";
						
					}
					else
					{
						u_arrPointSt[i] = nSt;
					}
				}
			}
		}
		else if(sys == "A")
		{
			for (i = 0  ; i < a_arrPointId.length ; i++){
				if(sId == a_arrPointId[i]){
					if((1000 * page) <= a_arrPointY[i] && (1000*(page+1)) >= a_arrPointY[i])
					{
						a_arrPointSt[i] = nSt;
						
						objId = "img_" + a_arrPointId[i];
						objImg = document.getElementById(objId);
						//alert(objImg);
						
						var result = "<c:url value='/images/popup/bu_circle_'/>";
						
						if (nSt == 0){
							objImg.src = result += "green.gif";
						}else if (nSt == 1){
							objImg.src = result += "blue.gif";
						}else if (nSt == 2){
							objImg.src = result += "yellow.gif";
						}else if (nSt == 3){
							objImg.src = result += "orange.gif";
						}
						else if (nSt == 4){
							objImg.src = result += "red.gif";
						}
						else
							objImg.src = result += "black.gif";
					}
				}
				else
				{
					a_arrPointSt[i] = nSt;
				}
			}
		}
	}
	
	//수계맵 측정소 측정값 표시(탁도)
	function showData(top, left, sId, sNm)
	{
		var sys = $("#sys").val();
	
		if(sys != "A")
		{
			var branch = sNm;
			var data = riverMapData[sId];
			var or = riverMapDataOr[sId];
			
			var tmp = riverMapData_tmp[sId];
			var tmpor = riverMapDataOr_tmp[sId];
			
			var dow = riverMapData_dow[sId];
			var dowor = riverMapDataOr_dow[sId];
			
			var phy = riverMapData_phy[sId];
			var phyor = riverMapDataOr_phy[sId];
			
			var con = riverMapData_con[sId];
			var conor = riverMapDataOr_con[sId];
			
			var tof = riverMapData_tof[sId];
			var tofor = riverMapDataOr_tof[sId];
			
			if(riverMapBranch[sId] != undefined)
				branch = riverMapBranch[sId];
				
			if(data == undefined || data == '')
				data = "-";
			
			if(dow == undefined || dow == '')
				dow = "-";
			
			if(con == undefined || con == '')
				con = "-";
			
			if(tmp == undefined || tmp == '')
				tmp = "-";
			
			if(phy == undefined || phy == '')
				phy = "-";
				
			if(tof == undefined || tof == '')
				tof = "-";
				
			var l = eval(left.replace("px", "")) + 20;
			var t = eval(top.replace("px", "")) + 10;
			
			$("#divBranch").text(branch);
			$("#divData").text(data);
			$("#divData_tmp").text(tmp);
			$("#divData_dow").text(dow);
			$("#divData_con").text(con);
			$("#divData_phy").text(phy);
			$("#divData_tof").text(tof);
			
			$("#infoDiv").css("top", t);
			$("#infoDiv").css("left", l);
			$("#infoDiv").fadeIn('normal');
			$("#infoDiv").css("z-index", '99');
			
			setMinOr_Color(or, $("#divData"));
			setMinOr_Color(tmpor, $("#divData_tmp"));
			setMinOr_Color(dowor, $("#divData_dow"));
			setMinOr_Color(conor, $("#divData_con"));
			setMinOr_Color(phyor, $("#divData_phy"));
			setMinOr_Color(tofor, $("#divData_tof"));
		}
		else
		{
			var branch = sNm;
			
			for(idx = lower;idx <= upper;idx++)
			{
				var iName = itemArray[idx];
				var iCode = itemCode[idx];
				
				var data = riverMapData[sId + "_" + iCode];
				var or = riverMapDataOr[sId + "_" + iCode];
				
				if(riverMapBranch[sId] != undefined)
					branch = riverMapBranch[sId];
					
				if(data == undefined || data == '')
					data = "-";
				
				var l = eval(left.replace("px", "")) + 20;
				var t = eval(top.replace("px", "")) + 10;
				
				$("#divBranch").text(branch);
				$("#divData_" + iCode).text(data);
						
				$("#infoDiv").css("top", t);
				$("#infoDiv").css("left", l);
				$("#infoDiv").fadeIn('normal');
				$("#infoDiv").css("z-index", '99');
				
				setMinOr_Color(or, $("#divData_" + iCode));
			}
		}
	}
	
	//수계맵 측정소 측정값 숨기기
	function hideData()
	{
		$("#infoDiv").hide();
	}
	
	//수계 좌표 설정 창 표시 - Admin 권한일 때만
	function modifyPopup() {
	<sec:authorize ifAnyGranted="ROLE_ADMIN">
		var river = $('#river').val();
		var sys = $('#sys').val();
		
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 850;
		var winWidth = 500;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
	
		var src = "<c:url value='/waterpolmnt/situationctl/goWatersysMntCoordMng.do'/>?river_div="+river+"&sys="+sys;
	
		window.open(src,
				'WatersysMntMainDetail','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	</sec:authorize>
	}
	
	function riverPageBtnInit()
	{
		var river = $("#river").val();
		
		if(river == "R02" || river == "R01")
		{
			if(page == 0)
			{
				$("#btnNext").show();
				$("#btnPrev").hide();
			}
			else if(page == 1)
			{
				$("#btnNext").hide();
				$("#btnPrev").show();
			}
		}
		else
		{
			$("#btnNext").hide();
			$("#btnPrev").hide();
		}
	}
	
	//수계 맵 다음 페이지로
	function riverMapNext()
	{
		page = 1;
		
		var river = $("#river").val();
		
		if(river == "R02"  || river == "R01")
		{
			$("#btnNext").hide();
			$("#btnPrev").show();
		}
		
		$("#alphaDiv").fadeOut('fast');
		
		InitPoint();
	}
	
	//수계 맵 이전 페이지로
	function riverMapPrev()
	{
		page = 0;
		
		var river = $("#river").val();
		
		if(river == "R02" || river == "R01")
		{
			$("#btnNext").show();
			$("#btnPrev").hide();
		}
		
		$("#alphaDiv").fadeOut('fast');
		
		InitPoint();
	}
	
	//추이 팝업
	function transitionPopup(factCode, branchNo)
	{
		var sys = $("#sys").val();
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 800;
		var winWidth = 1000;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		
		var param = "factCode=" + factCode + "&branchNo=" +  branchNo + "&sys=" + sys;
		
		var src = "<c:url value='/waterpolmnt/situationctl/goWatersysMntTransition.do'/>?" + param;
		
		window.open(src,
				'watersysMntTransition','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	//지도 팝업
	function mapPopup(factCode, branchNo){
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/waterpolmnt/situationctl/sysMntMap.do'/>",
			data: {
					fact_code:factCode,
					branch_no:branchNo
				},
			dataType:"json",
			success : function(result){
// 					console.log("sysMntMap : ",result);
				
					var longitude = result['resultList'].longitude;
					var latitude = result['resultList'].latitude;
					var sys = result['resultList'].sys_kind;
					
					window.open("/psupport/MNT_POP.html?riverid=" + user_riverid + "&menuid=mnt&longitude=" + longitude + "&latitude=" + latitude + "&sys=" + sys,
							'sysMntMap','width='+window.screen.width+',height='+window.screen.height+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left=0,top=0');
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
				alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
			}
		});
	}
	
	function chart_load()
	{
		$("#span_loading").css("display", "none");
	}
	
	function chart(){
		$("#span_loading").show();
		
		var width = "935";
		var height = "254";
		
		var sys = $("#sys").val();
		var river = $("#river").val();
		var item = $("#itemCode").val();
		var pointVal = '${param.pointVal}';
		
		var chartType = "2";
		
		var param = "sys="+sys+"&" + "river="+river+"&item="+item
		+"&itemName=탁도"+"&width="+width+"&height="+height+"&chartType="+chartType+"&pointVal="+pointVal;
		
		var src = "<c:url value='/waterpolmnt/situationctl/getSelectTotalMntGraph.do?'/>";
		$('#chart').attr("src", src + encodeURI(param));
	}
	
	function aloneChart(type){
		$("#span_loading").show();
		
		var width = "935";
		var height = "254";
		
		var sys = $("#sys").val();
		var river = $("#river").val();
		var item = $("#itemCode").val();
		var pointVal = '${param.pointVal}';
		
		var chartType = type;
		
		var param = "sys="+sys+"&" + "river="+river+"&item="+item
		+"&itemName=탁도"+"&width="+width+"&height="+height+"&chartType="+chartType+"&pointVal="+pointVal;
		
		var src = "<c:url value='/waterpolmnt/situationctl/getSelectTotalMntGraph.do?'/>";
		$('#chart').attr("src", src + encodeURI(param));
	}
	
	function multiChart(str, type){
		$("#span_loading").show();
		
		var width = "920";
		var height = "254";
		
		var sys = $("#sys").val();
		var river = $("#river").val();
		var item = str;
		var pointVal = '${param.pointVal}';
		
		var chartType = type;
		
		var param = "sys="+sys+"&" + "river="+river+"&item="+item
		+"&itemName=탁도"+"&width="+width+"&height="+height+"&chartType="+chartType+"&pointVal="+pointVal;
		
		var src = "<c:url value='/waterpolmnt/situationctl/getSelectMultiTotalMntGraph.do?'/>";
		$('#chart').attr("src", src + encodeURI(param));
	}
</script>
</head>

<body class="popup" id="mainBody">
	<div id='loadingDiv'>
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div id="infoDiv" style="auto;z-index;10;font-size:9pt;background-color:white;width:395px;height:70px;border:solid 1px #aaaaaa;display:none;position:absolute">
		<table id="divDataTable" class="dataTable" style="height:70px;table-layout:auto">
			<colgroup>
				<col width="90" />
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
			</colgroup>
			<thead id="divDataHeader">
				<tr>
					<th scope="col">측정소</th>
					<th scope="col">탁도</th> 
					<th scope="col">수온</th> 
					<th scope="col">pH</th> 
					<th scope="col">DO</th> 
					<th scope="col">EC</th> 
				</tr>
			</thead>
		<tbody id="divDataList">
			<tr>
				<td><span id="divBranch"></span></td>
				<td><span id="divData"></span></td>
				<td><span id="divData_tmp"></span></td>
				<td><span id="divData_phy"></span></td>
				<td><span id="divData_dow"></span></td>
				<td><span id="divData_con"></span></td>
			</tr>
		</tbody>
		</table>
	</div>
	<div id="wrap" class="mainPop" style="margin-left:0px; width: 955px !important;">
		<div class="pop_header" style="width: 955px !important;">
			<div class="bg_header_r">
				<div class="bg_header">
<%--					<h1 class="pop_tit"><img src="<c:url value='/images/popup/h1_watersysmnt.gif'/>" alt="수계별통합감시" /></h1> --%>
					<h1 class="pop_tit"><c:if test="${param.sys eq 'A'}">국가수질</c:if><c:if test="${param.sys eq 'U'}">이동형측정기기</c:if> 경보발령지점 추이</h1>
					<!-- <p class="dateTime" id="currDate">[ 최종수신일자: - ]</p> --> 
				</div>
			</div>
		</div>
		<div class="pop_container"style="width:954px !important;">
			<div class="pop_container_r">
		<div id="container" >
			<!-- content -->
			<div id="content" class="sub_waterpolmnt">
				<div class="content_wrap page_situationctl">
					<div class="inner_watersysmnt">
						<div class="watersysmnt_wrap">
							<!-- 좌측 이미지 영역 스타트-->
							<div class="data_graph" style="display: none;">
								<div class="data">
									<p>
										<select id="river" style="width:85px">
											<option value="R01">한강</option>
											<option value="R02">낙동강</option>
											<option value="R03">금강</option>
											<option value="R04">영산강</option>
										</select>
										<select id="sys" style="width:153px">
											<option value="U" selected="selected">이동형측정기기</option>
											<option value="A">국가수질자동측정망</option>
										</select>
									</p>
										<ul class="radio_area">
											<li class="first">
												&nbsp;
											</li>
										</ul>
								</div>
								<div id="alphaDiv" style="background-color:gray;width:242px;height:50px;position:absolute;top:220;opacity:0.35;filter:alpha(style=0, opacity=35, finishopacity=0)">&nbsp;</div>
								
								<img id='btnNext' onclick='riverMapNext()' src="<c:url value='/images/waterpolmnt/arrow_down.png'/>" style='z-index:11;position:absolute;top:460px;float:right;cursor:pointer;display:block'/>
								<img id='btnPrev' onclick='riverMapPrev()' src="<c:url value='/images/waterpolmnt/arrow_up.png'/>" style='z-index:11;position:absolute;top:460px;float:left;cursor:pointer;display:block'/>
								
								<div class="objectBox" id="objectBox" style="padding-top:0px;border:solid 1px #ccc;height:698px;width:240px" onclick='riverMapClick(event)'>
										<img id='riverMapImg' src="<c:url value='/images/content/R01.jpg'/>"/>
								</div>
							</div>
							<!-- 좌측 이미지 영역 엔드 -->
							<div><tr><td><input id="pointVal" style="display:none;"/></td></tr></div>
							<!-- 우측 챠트 영역 시작 -->
							<div class="watersysmnt_con">
								<div id="topData" style="border:solid 1px #CCC;height:258px; width:928px !important;">
										<div class="top_l"><div class="top_r"><div class="top"></div></div></div>
										<div class="con" style="height:auto;overflow:auto;">
											<div class="con_r" style="height:auto;overflow:auto;">
												<ul class="notes" style="float:left;position:absolute;margin:0 0 0 0;padding-top:5px"> 
													<li>
														<input type="radio" name="itemOpt" value="1" checked="checked"/>
														&nbsp;&nbsp;<span style="font-size:9pt;">단일항목</span>
														<span id="bItemLi" style="display:none">
															<select id="bItem" style="height:20px;">
																<option value="all" selected="selected">전체</option>
<!-- 																<option value="COM1" selected="selected">일반항목</option> -->
															</select>
														</span>
														<select id="itemCode" style="height:20px;">
															<option value="TUR00" selected="selected">탁도</option>
														</select>
													</li>													
													<li><input type="radio" name="itemOpt" value="2" />
													<span>다중항목</span></li>
													<li id="multiItem">
														<input type="checkbox" name="multiItem" value="TUR" checked="true"/>탁도
														<input type="checkbox" name="multiItem" value="TMP" checked="true"/>수온
														<input type="checkbox" name="multiItem" value="PHY" checked="true"/>pH
														<input type="checkbox" name="multiItem" value="DOW" checked="true"/>DO(mg/L)
														<input type="checkbox" name="multiItem" value="CON" checked="true"/>EC(mS/cm)
														<input type="checkbox" name="multiItem" value="TOF" checked="true"/>Chl-a&nbsp;
														<span class="fieldName" id="multiSear" style="cursor: pointer; margin-right:12px; padding:3px 12px; font-weight:bold; color:#ffffff; background:#5ab1c0; border-radius:10px; -webkit-border-radius:10px; -moz-border-radius:10px;">조회</span>
														<!-- <img id="multiSear" alt="조회" style="cursor:pointer" src="/images/common/btn_progress.gif"> -->
													</li>	
													<li>
														<span class="buArrow_tit" >그래프</span>
														<select id="graphType">															
															<option value="2" selected = "selected">막대형</option>
															<option value="1">선형</option>
														</select>
													</li>													
												</ul>
												<ul class="notes" style="display:none"> 
													<li><span><img style="vertical-align:middle;" src="<c:url value='/images/content/txt_notes.gif'/>" alt="범례" /></span></li>
													<li id="li_normal"><span class="alr_normal"><img src="<c:url value='/images/popup/bu_circle_green.gif'/>" /></span> 정상</li>
													<li id="li_interest"><span class="alr_interest"><img src="<c:url value='/images/popup/bu_circle_blue.gif'/>" /></span> 관심</li>
													<li id="li_caution"><span class="alr_caution"><img src="<c:url value='/images/popup/bu_circle_yellow.gif'/>" /></span> 주의</li>
													<li id="li_alert_t"><span class="alr_alert"><img src="<c:url value='/images/popup/bu_circle_orange.gif'/>" /></span> 경보</li>
													<li id="li_alert"><span class="alr_alert"><img src="<c:url value='/images/popup/bu_circle_orange.gif'/>" /></span> 경계</li>
													<li id="li_over"><span class="alr_over"><img src="<c:url value='/images/popup/bu_circle_red.gif'/>" /></span> 심각</li>
												</ul>
												<div id="topData1" style="width:100%;height:249px;overflow-y:hidden;padding-top:7px">
													<span id="span_loading" style="position:absolute;padding-top:23px">데이터를 불러오는 중 입니다...</span>
													<iframe id="chart" name="chartFrame" onload="javascript:chart_load();" src="" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" width="100%" height="100%"></iframe>
												</div>
											</div>
										</div>
										<div class="bot_l"><div class="bot_r"><div class="bot"></div></div></div>
									</div>
								<div class="dataBox" id="dataBox" style="height:200px; width: 930px;">
									<table id="dataTable" class="dataTable" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
										<colgroup>
											<col width="" />
											<col width="" />
											<col width="" />
											<col />
										</colgroup>
										<thead id="dataHeader">
											<tr>
												<th scope="col">측정소</th>
												<th scope="col">측정항목</th>
												<th scope="col">일자</th>
												<th scope="col">시간</th>
												<th scope="col">측정값</th>
												<th scope="col">날씨</th>
											</tr>
										</thead>
									<tbody id="dataList">
										<tr>
											<td>&nbsp;</td>
											<td></td>
											<td></td>
											<td></td>
											<td class="num"><span></span></td>
											<td></td>
										</tr>
										<tr class="add">
											<td>&nbsp;</td>
											<td></td>
											<td></td>
											<td></td>
											<td class="num"><span></span></td>
											<td></td>
										</tr>
									</tbody>
									</table>
								</div>
							</div>
							<!-- 우측 챠트 영역 엔드 -->
						</div>
					</div>
				</div>
			</div><!-- //content -->
		</div><!-- //container -->
			</div>
		</div>
		<div class="pop_footer">
			<div class="bg_footer_r">
				<div class="bg_footer">
				</div>
			</div>
		</div>	
	</div>
</body>
</html>