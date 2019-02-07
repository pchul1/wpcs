<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * @Class Name : alertList.jsp
	 * @Description : Alert List 화면
	 * @Modification Information
	 * 
	 *   수정일         수정자                   수정내용
	 *  -------    --------    ---------------------------
	 *  2010.05.17             최초 생성
	 *
	 * author khany
	 * since 2010.05.17
	 *  
	 * Copyright (C) 2010 by khany  All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">


<%-- <sec:authorize ifNotGranted="ROLE_USER"> --%>
<!-- 	<script type='text/javascript'> -->
<!-- 		alert('로그인이 필요한 페이지 입니다'); -->
<%-- 		window.location = "<c:url value='/'/>";  --%>
<!-- 	</script> -->
<%-- </sec:authorize> --%>


<sec:authorize ifAnyGranted="ROLE_USER">
	<script type='text/javascript'>
		var user_dept_no = '<sec:authentication property="principal.userVO.deptNo"/>';
	</script>
</sec:authorize>


<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>

<link rel="stylesheet" type="text/css" href="css/common.css"/>
<link rel="stylesheet" type="text/css" href="css/site.css"/>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />

<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript" src="js/organictabs.jquery.js"></script>
<script type="text/javascript" src="js/UI.js"></script>

<script type='text/javascript'>
//<![CDATA[

	var memFactCode = "${member.factCode}";
	var memRiverDiv = "${member.riverId}";

	
$(function () {
	//초기 시작값의 현재 시각 선택
	var date = new Date();
	var hour = date.getHours();
	time=hour<10?"0"+hour:hour;
	t_time = hour-2>0?hour-2:0;
	fritime=t_time<10?"0"+t_time:t_time;
	$("#toTime option[value="+time+"]").attr("selected", "true");
	$("#frTime option[value="+fritime+"]").attr("selected", "true");
	
	set_User_deptNo(user_dept_no, "sugye");

	$.datepicker.setDefaults({
	    monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
	    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	    showMonthAfterYear:true,
	    dateFormat: 'yy/mm/dd',
	    showOn: 'both',
	    buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
	    buttonImageOnly: true
	});
	
	$("#startDate").datepicker({
	    buttonText: '시작일'
	    
	});
	$("#endDate").datepicker({
	    buttonText: '종료일'
	});
			
	var today = new Date(); 
	var yday = new Date(Date.parse(today) - 1 * 1000 * 60 * 60 * 12);

	yday = yday.getFullYear()+ "/" + addzero(yday.getMonth()+1) + "/" + addzero(yday.getDate());
	today = today.getFullYear()+ "/" + addzero(today.getMonth()+1) + "/" + addzero(today.getDate());

	function addzero(n) {
		 return n < 10 ? "0" + n : n + "";
	}

	$("#startDate").val(yday);
	$("#endDate").val(today);


	//시공사일경우 해당 공구만 선택할 수 있게
	if(memFactCode != null && memFactCode != "")
	{
		$("#sys > option[value=T]").attr("selected", "true");
		$("#sys").attr("disabled", "disabled");
		
		$("#sugye > option[value="+memRiverDiv+"]").attr("selected", "true");
		$("#sugye").attr("disabled", "disabled");
	} 
	
	
	adjustGongku();

	//탁수 전용페이지로 변경 - 2010. 10. 07
	//$('#sys').change(function(){
	//	adjustGongku();
	//});
	
  	$('#sugye')
  	.change(function(){
  		adjustGongku();
  	});
  	
	$('#factCode').change(function(){
		adjustBranchList();
	});

	$('#branchNo').change(function(){
		//setGraphBtn(true);
	});

	$("#dataList tr:odd").attr("class","add");

	reloadData();


	//탁수 전용페이지로 변경 - 2010. 10. 07
	itemSetting('T');
	makeHeader('T');
});

var itemCnt;

	//itemArray 셋팅 //탁수 전용페이지로 변경 - 2010. 10. 07 - sys parameter에 무조건 'T'만 들어옴
	function itemSetting(sys)
	{
		 if(sys != "A")
		 {
//			 itemCnt = 6;
			 itemCnt = 5;
			 itemArray = new Array(itemCnt);
			 itemCode = new Array(itemCnt);
			 itemArray[0] = "탁도(NTU)"; 	itemCode[0] = "TUR";
			 itemArray[1] = "수온(℃)";	itemCode[1] = "TMP";
			 itemArray[2] = "pH";	itemCode[2] = "PHY";
			 itemArray[3] = "DO(mg/L)";	itemCode[3] = "DOW";
			 itemArray[4] = "EC(mS/cm)";	itemCode[4] = "CON";
			 //itemArray[5] = "시간강수량(mm)"; itemCode[5] = "XXX";
		 }
		 else if(sys=="A")
		 {
			 itemCnt = 45;
			 itemArray = new Array(itemCnt);
			 itemCode = new Array(itemCnt);
			 itemArray[0] = "pH1";			itemCode[0] = "PHY00";
			 itemArray[1] = "DO1<br/>(mg/L)";		itemCode[1] = "DOW00";
			 //itemArray[2] = "EC1<br/>(mS/cm)";	itemCode[2] = "CON00";
			 itemArray[2] = "EC1<br/>(μS/cm)";	itemCode[2] = "CON00";
			 itemArray[3] = "수온1<br/>(℃)"; 	itemCode[3] = "TMP00";
			 itemArray[4] = "pH2";			itemCode[4] = "PHY01";
			 itemArray[5] = "DO2<br/>(mg/L)";		itemCode[5] = "DOW01";
			 //itemArray[6] = "EC2<br/>(mS/cm)";	itemCode[6] = "CON01";
			 itemArray[6] = "EC2<br/>(μS/cm)";	itemCode[6] = "CON01";
			 itemArray[7] = "수온2<br/>(℃)"; 	itemCode[7] = "TMP01";
			 itemArray[8] = "탁도<br/>(NTU)";		itemCode[8] = "TUR00";
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
			 itemArray[19] = "벤젠";		itemCode[19] = "VOC03";
			 itemArray[20] = "사염화탄소"; 	itemCode[20] = "VOC04";
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
	//탁수모니터링 전용페이지로 변경 - 2010. 10. 07 (sys가 'T'로 고정됨)
	function makeHeader(sys)
	{
		var header;

		var overBox = $("#overBox");

		overBox.html("");

		var table = "<table id='dataTable' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>"
						+"<colgroup>"
							+ "<col width='40px'></col>"
							+ "<col width='60px'></col>"
							+ "<col width='60px'></col>"
						+"</colgroup>"
					  	+ "<thead id='dataHeader'>" 
					  	+ "</thead>"
					  	+ "<tbody id='dataList'>"
					    + "</tbody>"
					  + "</table>";
					 
		overBox.html(table);
	
		if(sys != "A")
		{
			$("#dataTable").attr("class", "");
			$("#dataTable").attr("class", "dataTable");
			
			
			//헤더 생성
			$("#dataHeader").html("");
			header = "<tr>" + 
							"<th rowspan ='2' scope='col'>NO</th>" +
							"<th rowspan ='2' scope='col'>수계</th>" +
							"<th rowspan ='2' scope='col'>지역</th>" +
							"<th rowspan ='2' scope='col'>측정소</th>" +
							"<th rowspan ='2' scope='col'>수신일자</th>" +
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
			//$("#dataList").html("<tr><td colspan='"+(itemCnt + 6)+"'>데이터를 불러오는 중 입니다.</td></tr>");
		}
		else if(sys == "A")
		{
			$("#dataTable").attr("class", "");
			$("#dataTable").attr("class", "dataTable_broad");
			
			//헤더 생성
			$("#dataHeader").html("");
			header = "<tr>" + 
							"<th rowspan ='2' scope='col'>NO</th>" +
							"<th rowspan ='2' scope='col'>수계</th>" +
							"<th rowspan ='2' scope='col'>지역</th>" +
							"<th rowspan ='2' scope='col'>측정소</th>" +
							"<th rowspan ='2' scope='col'>수신일자</th>" +
							"<th rowspan ='2' scope='col'>수신시간</th>" +
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
		
			
			$("#dataHeader").append(header);
			//$("#dataList").html("<tr><td colspan='"+(itemCnt + 6)+"'>데이터를 불러오는 중 입니다.</td></tr>");
		}
	}
	
	//측정소가 전체가 아닐때만 그래프 버튼이 표시됩니다.
	function setGraphBtn()
	{
		if($('#branchNo').val() == "all")
	        {
		        $('#a_chartPopup').attr("href", "#");
		        $('#img_chartPopup').hide();
	        }
	        else
	        {
	        	$('#a_chartPopup').attr("href","javascript:chartPopup()");
	        	$('#img_chartPopup').fadeIn('fast');
	        }
	}
	
	function sysChange()
	{
		var sys_kind = $("#sys").val();

		if(sys_kind == "all")
		{
			$("#branchNo>option:first").attr("selected", "true");
			$("#factCode>option:first").attr("selected", "true");
			
			$("#branchNo").attr("disabled", "disabled");
			$("#factCode").attr("disabled", "disabled");
		}
		else
		{
			$("#branchNo>option:first").attr("selected", "true");
			$("#factCode>option:first").attr("selected", "true");
			
			$("#branchNo").attr("disabled", false);
			$("#factCode").attr("disabled", false);
		}

		//탁수 전용페이지로 변경 - 2010. 10. 07
		//f(sys_kind == 'A')
		//{
		//	$("#valid").show();
		//	$("#minor").hide();
		//}
		//else
		//{
		//	$("#valid").hide();
		//	$("#minor").show();
		//}

		//setGraphBtn();
	}

	
	function adjustGongku()
	{
		//var sugyeCd = $('#sugye').val();
		//var sys_kind = $("#sys").val();
		
		var sugyeCd = $('#sugye').val();

		//탁수 전용페이지로 변경 - 2010. 10. 07
		//var sys_kind = $("#sys").val();
		
		
		
		var dropDownSet = $('#factCode');
		var dropDownSet_branchNo = $('#branchNo');
		
		//탁수 전용페이지로 변경 - 2010. 10. 07
		if( sugyeCd == 'all'){// || sys_kind == 'all' ){
			dropDownSet.attr("disabled", true);
			$("#factCode>option:first").attr("selected", "true");
			dropDownSet_branchNo.attr("disabled", true);
			$("#branchNo>option:first").attr("selected", "true");
			//dropDownSet.emptySelect();
		}else{
			dropDownSet.attr("disabled", false);
			$.getJSON("<c:url value='/waterpolmnt/waterinfo/getGongkuList.do'/>", 
					{sugye:sugyeCd},
					//, system:sys_kind}, 
					function (data, status){
			     if(status == 'success'){     
			        //locId 객체에 SELECT 옵션내용 추가.
			       
			        dropDownSet.loadSelect_all(data.gongku);
			        
					sysChange();

					if(memFactCode != null && memFactCode != "")
					{
						$("#factCode>option[value="+memFactCode+"]").attr("selected", "selected");
						$("#factCode").attr("disabled", "disabled");
					}	

					adjustBranchList();
					
					if(memFactCode == 'all')
						dropDownSet_branchNo.attr("disabled", true);
					
			     } else { 
			    	 alert("공구 목록 가져오기 실패");
			        return;
			     }
			});
		}		
	}

	//측정소 목록 가져오기
	function adjustBranchList()
	{	
		var factCode = $('#factCode').val();
		var sys_kind = $("#sys").val();
		
		var dropDownSet = $('#branchNo');
		if( factCode == 'all' || sys_kind == 'all' ){
			dropDownSet.attr("disabled", true);
			$("#branchNo>option:first").attr("selected", "true");
		}else{
			dropDownSet.attr("disabled", false);
			var url = "<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>";
			$.getJSON(url, {factCode:factCode}, function (data, status){
			     if(status == 'success'){     
			        //locId 객체에 SELECT 옵션내용 추가.
			        dropDownSet.loadSelect_all(data.branch);
			        
			        if(typeof(adjustItemList) == "function") {
			        	adjustItemList();
			        }
	
			        //$("#branchNo>option[value='"+branch+"']").attr("selected", "selected");

			        //setGraphBtn();
			     } else { 
			    	 alert("공구 목록 가져오기 실패");
			        return;
			     }
			});
		}		
	}	

	function excelDown() {

		if( validation() == false ) return;

		var sugye = $("#sugye").val();
		//var gongku = $("#gongku").val();
		var gongku = $("#factCode").val();
		//var chukjeongso = $("#chukjeongso").val();
		var chukjeongso = $("#branchNo").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
	    var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();

		//탁수 전용페이지로 변경 - 2010. 10. 07
		//var sys = $("#sys").val();
		sys = 'T';
		var valid = 'all';
		
		var minor = $("#minorCheck").val();

		//if(valid == null || valid == undefined || valid == "")
		//	valid = "all";
		if(minor==null || minor==undefined||minor=="")
			minor = "all";

		var rType = $("#dataType").val();
		
        var param = "sugye=" + sugye + "&gongku=" + gongku + "&chukjeongso=" + chukjeongso +
         "&frDate=" + frDate + "&toDate=" + toDate + "&frTime=" + frTime + "&toTime=" + toTime + 
         "&sys=" + sys + 
         "&minor=" + minor +
         "&valid=" + valid +
		 "&dataType=" + rType
            
		location.href="<c:url value='/waterpolmnt/waterinfo/getExcelDetalViewRIVER.do'/>?"+param;
	}

	function chartPopup() {
		if( validation() == false ) return;

		var sugye = $("#sugye").val();
		var gongku = $("#factCode").val();
		var chukjeongso = $("#branchNo").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
	    var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();

		//탁수 전용페이지로 변경 - 2010. 10. 07
		var sys = 'T';
		var valid = 'all';
		var minor = $("#minorCheck").val();

		if(minor==null || minor==undefined||minor=="")
			minor = "all";

		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 800;
		var winWidth = 1000;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-20;
		var height = winHeight-20;
		
		if(sugye == "01") {
			sugye = "R01"
		} else if(sugye == "02") {
			sugye = "R02"
		} else if(sugye == "03") {
			sugye = "R03"
		} else if(sugye == "04") {
			sugye = "R04"
		}

		var rType = $("#dataType").val();
		
        var param = "sugye=" + sugye + "&gongku=" + gongku + "&chukjeongso=" + chukjeongso +
         "&frDate=" + frDate + "&toDate=" + toDate + "&frTime=" + frTime + "&toTime=" + toTime + 
         "&sys=" + sys + 
         "&valid=" + valid + 
         "&minor=" + minor +
		 "&dataType=" + rType + "&width=" + (winWidth-40) + "&height=" + (winHeight-40);

		 //stats/getAccidentStatsChart.do
		window.open("<c:url value='/waterpolmnt/waterinfo/goChartDetailRIVER.do'/>?"+encodeURI(param), 
				'chartDetailViewRIVER','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}	

	var tmpSys = "";
	
	function reloadData(pageNo){
//alert("test");
		if( validation() == false )
		{ 
			closeLoading();
			return;
		}
		
		setGraphBtn();
		showLoading(); 
			

		var sugye = $("#sugye").val();
		var gongku = $("#factCode").val();
//		alert("gongku : "+gongku);
		var chukjeongso = $("#branchNo").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
	    var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();

		//탁수 전용페이지로 변경 - 2010. 10. 07
		var sys = 'T'; //$("#sys").val();
		var valid = 'all'; //$("#validFlag").val();
		var minor = $("#minorCheck").val();

		//if(valid == null || valid == undefined || valid == "")
		//	valid = "all";
		if(minor==null || minor==undefined||minor=="")
			minor = "all";
		
		
		if(gongku == null || gongku == "unknowned")
			gongku = "all";
		if(sugye == null || sugye == "unknowned")
			sugye = "all";

		//탁수 전용페이지로 변경 - 2010. 10. 07
		//if(tmpSys != sys)
		//{
		//	itemSetting(sys);
		//	makeHeader(sys);
		//}	
			
		var rType = $("#dataType").val();

		if (pageNo == null) pageNo = 1;
	
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getDetailViewRIVER.do'/>",
			data:{sugye:sugye, 
				  gongku:gongku,
				  chukjeongso:chukjeongso,
				  frDate:frDate,
				  toDate:toDate,
				  frTime:frTime,
				  toTime:toTime,
				  sys:sys,
				  valid:valid,
				  minor:minor,
				  pageIndex:pageNo,
				  dataType:rType},
			dataType:"json",
			success:function(result){
                var tot = result['detailViewList'].length;
                var item;
				var trClass;
				
                $("#dataList").html("");

                if( tot <= "0" ){
            		$("#dataList").html("<tr><td colspan='11'>조회 결과가 없습니다</td></td>");
            		 closeLoading();
                }else{
	                for(var i=0; i < tot; i++){
		                
	                    var obj = result['detailViewList'][i];
	                    var pageInfo = result['paginationInfo'];


						var factNumber = "";
	                    
	                    if(sugye == 'R01')
	                    	factNumber = obj.factname.replace('한강', '');
	                    else if(sugye == 'R02')
	                    	factNumber = obj.factname.replace('낙동강', '');
	                    else if(sugye == 'R03')
	                    	factNumber = obj.factname.replace('금강', '');
	                    else if(sugye == 'R04')
	                    	factNumber = obj.factname.replace('영산강','');
	                    
	                    
	                    factNumber.replace("_", "");
                    	
	                    var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
	                    
	                   	item = "<tr class='"+trClass+"'><td class='num'><span>" + no + "</span></td>"
	                   		 +"<td>"+obj.river_name+"</td>" 
							 +"<td id='tur"+i+"'>"+factNumber+"</td>"
	    	                 +"<td id='dow"+i+"'>"+obj.branch_name+"</td>"
	    	                 +"<td id='rem"+i+"'>"+obj.strdate+"</td>"
	    	                 +"<td id='rem"+i+"'>"+obj.strtime+"</td>";

	    	               //탁수 전용페이지로 변경 - 2010. 10. 07	    	              
	    	               //if(sys != "A")
	    	               //  {
		                       	 item += "<td class='num'><span id='rem"+i+"'>"+(obj.tur=="" ? "-" : obj.tur) +"</td>"
		                       	 +"<td class='num'><span id='rem"+i+"'>"+(obj.tmp == "" ? "-" : obj.tmp) +"</td>"
		                       	 +"<td class='num'><span id='rem"+i+"'>"+(obj.phy =="" ? "-" : obj.phy) +"</td>"
		                       	 +"<td class='num'><span id='rem"+i+"'>"+(obj.dow == "" ? "-" : obj.dow)+"</td>"
		                       	 +"<td class='num'><span id='rem"+i+"'>"+(obj.con == "" ? "-" : obj.con)+"</td>";
								//+"<td class='num'><span>"+ obj.hour_rainfall +"</span></td>";
	    	                // }

			    	               
	    	                /* 
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
								+"<td class='num'><span id='plu"+i+"'>" + ((obj.plu == "") ? "-" : obj.plu)+ "</span></td>"
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
							*/
	                 	item += "</tr>";
	                 		 
	           			$("#dataList").append(item);

	           			$("#dataList tr:odd").attr("class","add"); 
	                }
                }

                // 페이징 정보
	            var pageStr = makePaginationInfo(result['paginationInfo']);
	            $("#pagination").empty();
	            $("#pagination").append(pageStr);	       

	            $("#p_total_cnt").html("[총 " + result['totCnt'] + "건] <span class='red'>※조회결과는 확정자료가 아닙니다.</span>");

	          	//탁수 전용페이지로 변경 - 2010. 10. 07
	            //tmpSys = sys;

	            closeLoading();
			},
            error:function(result){  
				$("#dataList").html("");
	            $("#dataList").html("<tr><td colspan='11'>서버 접속에 실패하였습니다!</td></td>");
	            closeLoading();
	        }
		});
		
		//setTimeout(reloadData, 60000);
	}    

	function validation(){
		if( $('#startDate').val() == "" ){ alert("조회 시작일자를 선택하세요"); return false; }
		if( $('#endDate').val() == "" ){ alert("조회 종료일자를 선택하세요"); return false; }
		if(!timeCheck()) {return false;}
	}

	function timeCheck()
	{
		var stdt = document.getElementById("startDate");
		var endt = document.getElementById("endDate");
		
		if(stdt.value == endt.value)
		{
			var frTime = $("#frTime").val();
			var toTime = $("#toTime").val();

			if(frTime > toTime)
			{
				alert("조회 종료시간이 시작시간보다 빠릅니다.\n\n다시 입력해 주십시오.");
				$("#frTime").val("");
				$("#toTime").val("");
				$("#frTime").focus();

				return false;
			}			
		}

		return true;
	}
	
	function commonWork() {
		var stdt = document.getElementById("startDate");
		var endt = document.getElementById("endDate");
		var dateCheck = /^(19[7-9][0-9]|20\d{2})\/(0[0-9]|1[0-2])\/(0[1-9]|[1-2][0-9]|3[0-1])$/;
		
		if(endt.value != '' && stdt.value > endt.value) {
			alert("조회 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			stdt.value = "";
			endt.value = "";
			stdt.focus();
		}
		if(stdt.value !=''){
			if(dateCheck.test(stdt.value)!=true){
				alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
				stdt.value = "";
				stdt.focus;
				return false;
			}
		}
		if(endt.value !=''){
			if(dateCheck.test(endt.value)!=true){
				alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
				endt.value = "";
				endt.focus;
				return false;
			}
		}

		timeCheck();
	} 

	// 페이지 번호 클릭	
	function linkPage(pageNo){
		reloadData(pageNo);
	} 
//]]>
</script>

</head>
<body>
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="" />
	</div>
	<div id="wrap">
		<div id="header">
			<c:import url="/common/menu/header.do" />
		</div>
		
		<!-- //header -->
		<div id="container">
			<div id="content_wrapper">
			
				<!--left menu Start-->
				<c:import url="/common/menu/left.do" />
				<!--left menu End-->

				<!-- content -->
				<div id="content">
				
					<!--sub title Start-->
					<div id="subTitArea">
						<img src="images/sub_tit01_1.gif" alt="이동형측정기기정보"/>
						<span><img src="images/icon_h.gif" alt=""/> 예방 > 수질오염감시 > 수질 정보 조회 > 이동형측정기기 정보</span>
					</div>
					<!--sub title End-->
					
					<div id="tabmenu">
						<!--tab menu Start-->
						<ul class="nav">
							<li><a href="#t01" class="current">이동형측정기기 정보</a></li>
							<li><a href="#t02">수질측정망정보</a></li>
							<li><a href="#t03">방류수수질정보</a></li>
						</ul>
						<!--tab menu End-->
						
						<form:form commandName="searchTaksuVO" name="listFrm" id="listFrm" method="post">
							<input type="hidden" name="pageIndex" id="pageIndex" value="${searchTaksuVO.pageIndex}" />
							<input type="hidden" name="chukjeongso" id="chukjeongso" />
							<input type="hidden" name="gongku" id="gongku" />
							<input type="hidden" name="sugye" id="river_div" />
							<input type="hidden" name="frDate" id="frDate" />
							<input type="hidden" name="toDate" id="toDate" />
							<input type="hidden" name="item01" id="item01" />
							<input type="hidden" name="item02" id="item02" />
							<input type="hidden" name="item03" id="item03" />
							<input type="hidden" name="item04" id="item04" />
							<input type="hidden" name="item05" id="item05" />
							
						<!--tab Contnet Start-->
						<div class="list-wrap">
							<div id="t01">
								<div class="searchBox">
									<ul>
										<li>
									<!-- //탁수 전용페이지로 변경 - 2010. 10. 07 
							<dt><img src="<c:url value='/images/content/tit_search_system.gif'/>" alt="시스템" /></dt>
							<dd>
								<select class="fixWidth13" id="sys" name="sys">
										<option value="U">이동형측정기기</option>
										<option value="T" selected="selected">탁수모니터링</option>
										<option value="A">국가수질자동측정망</option>
								</select>
							</dd>
							-->
<%-- 									<dt><img src="<c:url value='/images/content/tit_search_branch.gif'/>" alt="측정소" /></dt> --%>
<!-- 									<dd> -->
											<select class="fixWidth7" id="sugye">
												<option value="R01">한강</option>
												<option value="R02">낙동강</option>
												<option value="R03">금강</option>
												<option value="R04">영산강</option>
											</select>
												 <span>&gt;</span>
											<select class="fixWidth11" id="factCode">
												<option value="all">전체</option>
											</select>
											<span>&gt;</span>
											<select class="fixWidth11" id="branchNo" name="branchNo" disabled="disabled">
												<option value="all">전체</option>
											</select>
<!-- 									</dd> -->
										</li>
										<li>
											<input type="text" id="startDate" name="startDate" onchange="commonWork()" style="width:130px"/> <img src="images/ic_calendar.gif" alt="조회시작일"/>
											<select id="frTime" name="frTime" onchange="commonWork()" style="width:45px">
												<option value="00">00</option>
												<option value="01">01</option>
												<option value="02">02</option>
												<option value="03">03</option>
												<option value="04">04</option>
												<option value="05">05</option>
												<option value="06">06</option>
												<option value="07">07</option>
												<option value="08">08</option>
												<option value="09">09</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
												<option value="13">13</option>
												<option value="14">14</option>
												<option value="15">15</option>
												<option value="16">16</option>
												<option value="17">17</option>
												<option value="18">18</option>
												<option value="19">19</option>
												<option value="20">20</option>
												<option value="21">21</option>
												<option value="22">22</option>
												<option value="23">23</option>
											</select>
											<span>~</span>
											<input type="text" name="" value="" style="width:130px"/> <img src="images/ic_calendar.gif" alt=""/> 
											<input type="text" id="endDate" name="endDate" onchange="commonWork()" style="width:130px"/> <img src="images/ic_calendar.gif" alt="조회종료일"/>
											 <select id="toTime" name="toTime" onchange="commonWork()" style="width:45px">
												<option value="00">00</option>
												<option value="01">01</option>
												<option value="02">02</option>
												<option value="03">03</option>
												<option value="04">04</option>
												<option value="05">05</option>
												<option value="06">06</option>
												<option value="07">07</option>
												<option value="08">08</option>
												<option value="09">09</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
												<option value="13">13</option>
												<option value="14">14</option>
												<option value="15">15</option>
												<option value="16">16</option>
												<option value="17">17</option>
												<option value="18">18</option>
												<option value="19">19</option>
												<option value="20">20</option>
												<option value="21">21</option>
												<option value="22">22</option>
												<option value="23" selected="selected">23</option>
											</select>
										</li>
										<li>
<%-- 									<dt><img src="<c:url value='/images/content/tit_search_datatype.gif'/>" alt="수집 주기" /></dt> --%>
<!-- 									<dd> -->
											<span>수집 주기</span>
											<select id="dataType" name="dataType">
												<option id="rDataType" name="rDataType" value="2">10분자료</option>
												<option id="rDataType" name="rDataType" value="1">1시간자료</option>
											</select>
<!-- 									</dd> -->
										</li>
										<li>
<!-- 								</dl> -->
<!-- 								<div class="btnInBox"> -->
<!-- 									<dl> -->
										
<%-- 										<dt><img src="<c:url value='/images/content/tit_search_value.gif'/>" alt="기준치 구분" /></dt> --%>
										<!-- //탁수 전용페이지로 변경 - 2010. 10. 07
								<dd id="valid" style="display:none">
									<select id="validFlag" name="valid">
										<option value="all">전체(유효데이터)</option>
										<option value="N">일반데이터</option>
										<option value="Y">유효데이터</option>
									</select>
								</dd>
								-->
<!-- 										<dd id="minor"> -->
											<span>기준치 구분</span>
											<select id="minorCheck" name="minor">
												<option value="all">전체</option>
												<option value="0">정상</option>
												<option value="1">기준초과</option>
											</select>
										</li>
<!-- 										</dd> -->
<!-- 									</dl> -->
<!-- 									<dl style="display: none"> -->
<!-- 										<dt><label for="">대항목</label></dt> -->
<!-- 										<dd> -->
<!-- 											<select id="bitem" name="bitem" disabled="true"> -->
<!-- 												<option value="1">일반항목</option> -->
<!-- 											</select> -->
<!-- 										</dd> -->
<!-- 										<dt>소항목</dt> -->
<!-- 										<dd> -->
<!-- 											<ul class="checkList"> -->
<!-- 												<li id="sys0"><input type="checkbox" class="inputCheck" -->
<!-- 													id="i1" checked="checked" /><label for="">탁도</label> -->
<!-- 												</li> -->
<!-- 												<li id="sys1"><input type="checkbox" class="inputCheck" -->
<!-- 													id="i2" checked="checked" /><label for="">DO</label> -->
<!-- 												</li> -->
<!-- 												<li id="sys2"><input type="checkbox" class="inputCheck" -->
<!-- 													id="i3" checked="checked" /><label for="">수온</label> -->
<!-- 												</li> -->
<!-- 												<li id="sys3"><input type="checkbox" class="inputCheck" -->
<!-- 													id="i4" checked="checked" /><label for="">pH</label> -->
<!-- 												</li> -->
<!-- 												<li id="sys4"><input type="checkbox" class="inputCheck" -->
<!-- 													id="i5" checked="checked" /><label for="">전기전도도</label> -->
<!-- 												</li> -->
<!-- 											</ul> -->
<!-- 										</dd> -->
<!-- 									</dl> -->
<!-- 								<p class="btn_search"><a href="javascript:reloadData()"><img src="<c:url value='/images/common/btn_search.gif'/>" alt="조회" /></a></p> -->
<!-- 								</div> -->
										<li class="last">
											<input type="button" name="" value="조회" class="btn btn_search" />
										</li>
									</ul>
								</div>
								<!-- //수질 조회 현황 -->
							</form:form>
							
								<div id="btArea">
									[총 ${totCnt}건] <span class="red">※조사결과는 확정자료가 아닙니다</span>
									<input type="button" name="" value="엑셀" class="btn btn_basic" onclick="javascript:excelDown()" />
								</div>
								
<!-- 						</div> -->
								<!-- //하천 수질 조회 -->
							
								<div class="table_wrapper">
									<table id="dataTable" class="dataTable" oncontextmenu="return false" ondragstart="return false" onselectstart="return false" summary="이동형측정기기 정보" >
										<caption>이동형측정기기 정보</caption>
										<colgroup>
										<col width="30" />
										<col width="" />
										<col width="" />
										<col width=""/>
										<col width="" />
										<col width=""/>
										</colgroup>
										<thead id="dataHeader">
										</thead>
										<tbody id="dataList">
										</tbody>
									</table>
						
									<div class="paging">
										<div id="page_number">
											<ul class="paginate" id="pagination"></ul>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!--tab Contnet End-->
						
					</div>
				</div>	
			</div>
		</div>
		<!-- Body End-->

		<!-- Footer Start-->
		<div id="footer">
			<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
		<!-- Footer End-->
	</div>
</body>
</html>