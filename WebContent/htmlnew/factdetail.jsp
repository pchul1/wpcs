<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : alertList.jsp
	 * Description : Alert List 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2010.05.17	khany		 최초 생성
	 *
	 * author khany
	 * since 2010.05.17
	 *  
	 * Copyright (C) 2010 by khany  All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">


<sec:authorize ifAnyGranted="ROLE_USER">
	<script  type='text/javascript'>
		var user_dept_no = '<sec:authentication property="principal.userVO.deptNo"/>';
	</script> 
</sec:authorize>

<sec:authorize ifNotGranted="ROLE_USER">
	<script  type='text/javascript'>
		alert('로그인이 필요한 페이지 입니다');
		window.location = "<c:url value='/'/>"; 
	</script> 
</sec:authorize>


<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<title>한국환경공단 수질오염 방제정보 시스템</title>
<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />
<script src="<c:url value='/js/JQuery/jquery-1.3.2.min.js" type="text/javascript'/>"></script>
<script src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js" type="text/javascript'/>"></script>
<script src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js" type="text/javascript'/>"></script>
<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>

<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.datepicker.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/JQuery/jquery.form.js'/>"></script>
 

<script type='text/javascript'>
	var fact_name;
	var fact_code;
	var branch_no=1;
	var branch_name;
	var sys_kind;
	var itemCnt;
	var itemArray;
	var itemCode;
	var isFirst = true;

	
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

		
		 //fact_code = '${param.fact_code}';
		 //sys_kind = '${param.sys_kind}';
		 //fact_name = '${param.fact_name}';
		 //branch_no = '${param.branch_no}'


		 fact_code = '41T1004';
		 sys_kind = 'T';
		 fact_name = '';
		 branch_no='1';
			 
		 if(sys_kind == "A")
		 {
			 $("#dataTable_before").attr("class", "dataTable_broad");
			 $("#dataTableHeader_before").attr("class", "dataTable_broad");
			 
			 $("#dataTable_next").attr("class", "dataTable_broad");
			 $("#dataTableHeader_next").attr("class", "dataTable_broad");
			 
			 $("#dataTable").attr("class", "dataTable_broad");
			 $("#dataTableHeader").attr("class", "dataTable_broad");
					 
			 $("#overBoxHeader").css("overflow-y","scroll");
			 $("#overBoxHeader_next").css("overflow-y","scroll");
			 $("#overBoxHeader_before").css("overflow-y","scroll");
			 
			 $("#overBox").css("height", "426px");
			// $("#overBox_before").css("height", "494px");
			 //$("#overBox_next").css("height", "494px");
		 }

		 
		 adjustGongku();

		$('#sys').change(function(){
			adjustGongku();
		});
		
		$('#sugye')
		.change(function(){
			adjustGongku();
		});

		$('#factCode').change(function(){
			adjustBranchList();
		});	 

		//reloadData();
		 

		 $("#branch_no").change(function() { 
				showLoading();
				branch_no = this.value;
				chart();
				refresh();
		 });

		 $("#branch_no_before").change(function() {
				showLoading();
				chart(); 
				refresh_before();
		 });
				
		 $("#branch_no_next").change(function() {
				showLoading();
				chart(); 
				refresh_next();
		 });

		 $("#graphItem").change(function() {
				showLoading();
				chart();
		 });
	});	

	
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

		if(sys_kind == "U")
		{
			$("#spanBranch").show();
			$("#branch_no").hide();
			$("#branch_no_next").hide();
			$("#branch_no_before").hide();
		}
		else
		{
			$("#spanBranch").hide();
			$("#branch_no").show();
			$("#branch_no_next").show();
			$("#branch_no_before").show();
		}
	}


	//user deptNo에 따른 수계 고정
	function set_User_deptNo()
	{
	
		var riverDept = "";
		var isNull = false;
		
		switch(user_dept_no)
		{
		case "1002":
			riverDept = "R01";
			break;
		case "1004":
			riverDept = "R02";
			break;
		case "1003":
			riverDept = "R03";
			break;
		case "1005":
			riverDept = "R04";
			break;
		default :
			//Null이거나 속하지않으면 전체 표시
			isNull = true;	
		}
	
		if(!isNull)
		{
			$("#sugye > option[value="+riverDept+"]").attr("selected", "true");
			$("#sugye").attr("disabled", "disabled");
		}	
		else
		{
			//$("#sugye").attr("disabled", "disabled");
		}
	}


	
	var firstFlag = false;
	
	function adjustGongku()
	{
		//var sugyeCd = $('#sugye').val();
		//var sys_kind = $("#sys").val();
		
		var sugyeCd = $('#sugye').val();
		var sys_kind = $("#sys").val();

		
		
		var dropDownSet = $('#factCode');
		var dropDownSet_branchNo = $('#branchNo');
		
		
		if( sugyeCd == 'all' || sys_kind == 'all' ){
			dropDownSet.attr("disabled", true);
			$("#factCode>option:first").attr("selected", "true");
			dropDownSet_branchNo.attr("disabled", true);
			$("#branchNo>option:first").attr("selected", "true");
			//dropDownSet.emptySelect();
		}else{
			dropDownSet.attr("disabled", false);
			$.getJSON("<c:url value='/waterpolmnt/waterinfo/getGongkuList.do'/>",
					{sugye:sugyeCd, system:sys_kind}, function (data, status){
				 if(status == 'success'){	 
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect(data.gongku);
					sysChange();


					adjustBranchList();

					
					if(!firstFlag)
					{
						reloadData();
						firstFlag = true;
					}


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
					dropDownSet.loadSelect(data.branch);
				 } else { 
					 alert("공구 목록 가져오기 실패");
					return;
				 }
			});
		}		
	}	


	
	function showLoading()
	{
		$("#loadingDiv").dialog("open");
	}

	function chartLoaded()
	{
		$("#loadingDiv").dialog("close");
	}

	function getItemDropDown(sk){
		var sys = sk;
		var itemCode = "";
		
		if(sys == 'U' || sys == 'all'){
			itemCode = "22";
		}else if(sys == 'T'){
			itemCode = "23";
		}else if(sys == 'A'){
			itemCode = "37";
		}
		
		var dropDownSet = $('#graphItem');

		dropDownSet.attr("disabled", false);
		$.getJSON("<c:url value='/cmmn/getCode.do'/>", {code_id:itemCode}, function (data, status){
			if(status == 'success'){
				//item 객체에 SELECT 옵션내용 추가.
				dropDownSet.loadSelectDepth_factdetail(data.codes, sys);
			} else { 
				//alert("ERROR!");
				return;
			}
		});	
	}
	
	function reloadData(){

		showLoading();
		
		fact_code = $("#factCode").val();
		alert("fact_code : "+fact_code);
		sys_kind = $("#sys").val();
		alert("sys_kind : "+sys_kind);
		fact_name = '';
		branch_no= $("#branch_no").val();
		alert("branch_no : "+branch_no);


		itemSetting(sys_kind);
		makeHeader();

		getItemDropDown(sys_kind);
		getBranchList(fact_code);
	}

	//itemArray 셋팅
	function itemSetting(sys_kind)
	{
		if(sys_kind != "A")
		{
			itemCnt = 5;
			itemArray = new Array(itemCnt);
			itemCode = new Array(itemCnt);
			itemArray[0] = "탁도<br/>(NTU)";	itemCode[0] = "TUR";
			itemArray[1] = "수온<br/>(℃)";	itemCode[1] = "TMP";
			itemArray[2] = "pH";	itemCode[2] = "PHY";
			itemArray[3] = "DO<br/>(mg/L)";	itemCode[3] = "DOW";
			itemArray[4] = "EC<br/>(mS/cm)";	itemCode[4] = "CON";
		 }
		 else if(sys_kind=="A")
		 {
			itemCnt = 45;
			itemArray = new Array(itemCnt);
			itemCode = new Array(itemCnt);
			itemArray[0] = "pH1";			itemCode[0] = "PHY00";
			itemArray[1] = "DO1<br/>(mg/L)";		itemCode[1] = "DOW00";
			itemArray[2] = "EC1<br/>(mS/cm)";	itemCode[2] = "CON00";
			itemArray[3] = "수온1<br/>(℃)";	itemCode[3] = "TMP00";
			itemArray[4] = "pH2";			itemCode[4] = "PHY01";
			itemArray[5] = "DO2<br/>(mg/L)";		itemCode[5] = "DOW01";
			itemArray[6] = "EC2<br/>(mS/cm)";	itemCode[6] = "CON01";
			itemArray[7] = "수온2<br/>(℃)";	itemCode[7] = "TMP01";
			itemArray[8] = "탁도<br/>(NTU)";		itemCode[8] = "TUR01";
			itemArray[9] = "임펄스";	itemCode[9] = "IMP00";
			itemArray[10] = "임펄스(좌)";	itemCode[10] = "LIM00";
			itemArray[11] = "임펄스(우)";	itemCode[11] = "RIM00";
			itemArray[12] = "독성지수(좌)";	itemCode[12] = "LTX00";
			itemArray[13] = "독성지수(우)";	itemCode[13] = "RTX00";
			itemArray[14] = "미생물<br/>독성지수(%)";	itemCode[14] = "TOX00";
			itemArray[15] = "조류<br/>독성지수";		itemCode[15] = "EVN00";
			itemArray[16] = "클로로필-a";		itemCode[16] = "TOF00";
			itemArray[17] = "염화메틸렌";	itemCode[17] = "VOC01";
			itemArray[18] = "1.1.1-트리클로로<br/>에테인";	itemCode[18] = "VOC02";
			itemArray[19] = "사염화탄소";		itemCode[19] = "VOC04";
			itemArray[20] = "벤젠";	itemCode[20] = "VOC03";
			itemArray[21] = "트리클로로<br/>에틸렌";	itemCode[21] = "VOC05";
			itemArray[22] = "톨루엔";		itemCode[22] = "VOC06";
			itemArray[23] = "테트라클로로<br/>에티렌";	itemCode[23] = "VOC07";
			itemArray[24] = "에틸<br/>벤젠";	itemCode[24] = "VOC08";
			itemArray[25] = "m,p-자일렌";	itemCode[25] = "VOC09";
			itemArray[26] = "o-자일렌";itemCode[26] = "VOC10";
			itemArray[27] = "[ECD]염화<br/>메틸렌";	itemCode[27] = "VOC11";
			itemArray[28] = "[ECD]1.1.1-<br/>트리클로로에테인";	itemCode[28] = "VOC12";
			itemArray[29] = "[ECD]사염화<br/>탄소";	itemCode[29] = "VOC13";
			itemArray[30] = "[ECD]트리클<br/>로로에틸렌";	itemCode[30] = "VOC14";
			itemArray[31] = "[ECD]테트라<br/>클로로에티렌";	itemCode[31] = "VOC15";
			itemArray[32] = "카드뮴";	itemCode[32] = "CAD00";
			itemArray[33] = "납";	itemCode[33] = "PLU00";
			itemArray[34] = "구리";	itemCode[34] = "COP00";
			itemArray[35] = "아연";	itemCode[35] = "ZIN00";
			itemArray[36] = "페놀1";	itemCode[36] = "PHE00";
			itemArray[37] = "페놀2";	itemCode[37] = "PHL00";
			itemArray[38] = "총유기탄소";	itemCode[38] = "TOC00";
			itemArray[39] = "총질소";	itemCode[39] = "TON00";
			itemArray[40] = "총인";	itemCode[40] = "TOP00";
			itemArray[41] = "암모니아성<br/>질소";	itemCode[41] = "NH400";
			itemArray[42] = "질산성<br/>질소";	itemCode[42] = "NO300";
			itemArray[43] = "인산염인";	itemCode[43] = "PO400";
			itemArray[44] = "강수량";	itemCode[44] = "RIN00";
		 }
	}

	//테이블 헤더 생성
	function makeHeader()
	{
		var header;

		if(sys_kind != "A")
		{
			//시스템에 따른 테이블 헤더 형식 변경
			//이전 공구
			$("#overBoxHeader_before").html("");

			var table_before = "	<table class='dataTable'  id='dataTableHeader_before' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>";
				  table_before += "<colgroup><col width='50px' /><col width='50px' /><col width='50px' /><col width='50px' /><col width='50px' /><col width=''/></colgroup>";
				  table_before += "<thead id='valueDataHeader1_before'></thead>";
				  table_before += "</table>";
				
			$("#overBoxHeader_before").html(table_before);

			//선택 공구
			$("#overBoxHeader").html("");

			var table = "	<table class='dataTable'  id='dataTableHeader' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>";
				table += "<colgroup><col width='50px' /><col width='50px' /><col width='50px' /><col width='50px' /><col width='50px' /><col width=''/></colgroup>";
				table += "<thead id='valueDataHeader'></thead>";
				table += "</table>";
				
			$("#overBoxHeader").html(table);

			//다음 공구
			$("#overBoxHeader_next").html("");

			var table_next = "	<table class='dataTable' id='dataTableHeader_next' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>";
				table_next += "<colgroup><col width='50px' /><col width='50px' /><col width='50px' /><col width='50px' /><col width='50px' /><col width=''/></colgroup>";
				table_next += "<thead id='valueDataHeader1_next'></thead>";
				table_next += "</table>";
				
			$("#overBoxHeader_next").html(table_next);


			
			//헤더 생성
			$("#valueDataHeader").html("");
			$("#valueDataHeader1_before").html("");
			$("#valueDataHeader1_next").html("");
			
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
			$("#valueDataHeader1_before").append(header);
			$("#valueDataHeader1_next").append(header);

			
			$("#valueDataList").html("<tr><td colspan='"+(itemCnt + 1)+"'>데이터를 불러오는 중 입니다.</td></tr>");
			$("#valueDataList_before").html("<tr><td colspan='"+(itemCnt + 1)+"'>데이터를 불러오는 중 입니다.</td></tr>");
			$("#valueDataList_next").html("<tr><td colspan='"+(itemCnt + 1)+"'>데이터를 불러오는 중 입니다.</td></tr>");
			
		}
		else if(sys_kind == "A")	 //측정망일 경우
		{
			//시스템에 따른 테이블 헤더 형식 변경
			//이전 공구
			$("#overBoxHeader_before").html("");

			var table_before = "	<table class='dataTable_broad' id='dataTableHeader_before' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>";
				table_before += "<colgroup><col width='50px' /><col width='50px' /><col width='50px' /><col width='50px' /><col width='50px' />";

				for(var idx = 0 ; idx < 40 ; idx ++)
				{
						table_before += "<col width=''/>";
				}
				
				table_before += "<col width=''/></colgroup>";
				table_before += "<thead id='valueDataHeader1_before'></thead>";
				table_before += "</table>";
				
			$("#overBoxHeader_before").html(table_before);

			//선택 공구
			$("#overBoxHeader").html("");

			var table = "	<table class='dataTable_broad' id='dataTableHeader' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>";
				table += "<colgroup><col width='50px' /><col width='50px' /><col width='50px' /><col width='50px' /><col width='50px' />";

				for(var idx = 0 ; idx < 40 ; idx ++)
				{
						table += "<col width=''/>";
				}
				
				table += "<col width=''/></colgroup>";
				table += "<thead id='valueDataHeader'></thead>";
				table += "</table>";
				
			$("#overBoxHeader").html(table);

			//다음 공구
			$("#overBoxHeader_next").html("");

			var table_next = "	<table class='dataTable_broad' id='dataTableHeader_next' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>";
				table_next += "<colgroup><col width='50px' /><col width='50px' /><col width='50px' /><col width='50px' /><col width='50px' />";

				for(var idx = 0 ; idx < 40 ; idx ++)
				{
						table_next += "<col width=''/>";
				}
				
				table_next += "<col width=''/></colgroup>";
				table_next += "<thead id='valueDataHeader1_next'></thead>";
				table_next += "</table>";
				
			$("#overBoxHeader_next").html(table_next);

			
			
			//헤더 생성
			$("#valueDataHeader").html("");
			$("#valueDataHeader1_before").html("");
			$("#valueDataHeader1_next").html("");
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
			$("#valueDataHeader1_before").append(header);
			$("#valueDataHeader1_next").append(header);
			
			$("#valueDataList").html("<tr><td colspan='"+(itemCnt + 1)+"'>데이터를 불러오는 중 입니다.</td></tr>");
			$("#valueDataList_before").html("<tr><td colspan='"+(itemCnt + 1)+"'>데이터를 불러오는 중 입니다.</td></tr>");
			$("#valueDataList_next").html("<tr><td colspan='"+(itemCnt + 1)+"'>데이터를 불러오는 중 입니다.</td></tr>");
		}
		else
		{
			$("#valueDataHeader2_before").hide();
			$("#valueDataHeader2_next").hide();
		}
	}


	function getBranchList(fc){
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>",
			data:{factCode:fc},
			dataType:"json",
			success:function(result) {
				//branch_name = result['branch'][0].CAPTION;
				//$("#fact_branch_cnt").text(result['branch'].length);
				$("#branch_no").loadSelect(result['branch']);



				//브랜치 로드 까지 완료되어야 데이터를 불러올 수 있음
				refresh();
				refresh_before();
				refresh_next();
			},
			error:function(result){
			}
		});
	}

	//처음 로딩할때 한번만 실행됨
	var beforeFlag = true;
	var nextFlag = true;
	
	function getBranchList_before(factCode){
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>",
			data:{factCode:factCode},
			dataType:"json",
			success:function(result) {
				//branch_name = result['branch'][0].CAPTION;
				//$("#fact_branch_cnt").text(result['branch'].length);
				$("#branch_no_before").loadSelect(result['branch']);
				beforeFlag = false;
			},
			error:function(result){
			}
		});
	}

	function getBranchList_next(factCode){
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>",
			data:{factCode:factCode},
			dataType:"json",
			success:function(result) {
				//branch_name = result['branch'][0].CAPTION;
				//$("#fact_branch_cnt").text(result['branch'].length);
				$("#branch_no_next").loadSelect(result['branch']);
				nextFlag = false;
			},
			error:function(result){
			}
		});
	}
	/***********************************************************/
	//									이전 공구
	/***********************************************************/
	function refresh_before(){

		fact_code = $("#factCode").val();
		sys_kind = $("#sys").val();

		
		$("#valueDataList_before").html("<tr><td colspan='"+(itemCnt + 1)+"'>데이터를 불러옵니다...</td></tr>");
		var branch_no = $("#branch_no_before").val();

		if(branch_no == null || branch_no == "")
			branch_no = "1";

		//IP-USN같은 경우에는 검색조건에 설정된 측정소 번호로 조회함
		if(sys_kind == "U")
			branch_no = $("#branchNo").val();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/situationctl/getWatersysMntMainDetail_next.do'/>",
			data:{fact_code:fact_code,
					branch_no:branch_no,
					 sys_kind:sys_kind,
					 isNext:"N"},
			dataType:"json",
			success:before_dataload_success,
			error:function(result){
				$("#valueDataList_before").html("");
				$("#valueDataList_before").html("<tr><td colspan='"+(itemCnt + 1)+"'>서버 접속에 실패하였습니다!</td></tr>");
			}
		});
	}


	function before_dataload_success(result)
	{
		//if(beforeFlag && result != null && result['factCode'] != null)
		//{
		var sys_kind = $("#sys").val();

		if(sys_kind != "U")
		{
			getBranchList_before(result['factCode']);

			var factName = result['factName'];
			
			if(factName != null && factName != undefined && factName != "")
				$("#factName_before").text(factName);
			else
				$("#factName_before").text("없음");
		}
		else
		{
			var factName = result['branchName'];

			if(factName != null && factName != undefined && factName != "")
				$("#factName_before").text(factName);
			else
				$("#factName_before").text("없음");
		}
			
		//}

			$("#overBox_before").html("");

			
			//데이터 테이블 형식 생성(측정망, 다른 망과 형식이 다르기 때문)
			if(sys_kind != "A")	
			{
				var dataTable_before = "<table class='dataTable' id='dataTable_before' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>";
				dataTable_before += "<colgroup><col width='50px' /><col width='50px' /><col width='50px' /><col width='50px' /><col width='50px' /><col width=''/></colgroup>";
				dataTable_before += "<tbody id='valueDataList_before'></tbody>";
				dataTable_before += "</table>";
				$("#overBox_before").html(dataTable_before);
			}
			else
			{				
				var dataTable_before = "<table class='dataTable_broad' id='dataTable_before' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>";
				dataTable_before += "<colgroup><col width='50px' /><col width='50px' /><col width='50px' /><col width='50px' /><col width='50px' />";

				for(var idx = 0 ; idx < 40 ; idx ++)
				{
					dataTable_before += "<col width=''/>";
				 }
				dataTable_before += "<col width=''/></colgroup>";
				dataTable_before += "<tbody id='valueDataList_before'></tbody>";
				dataTable_before += "</table>";
				$("#overBox_before").html(dataTable_before);
			}
			

			
		if(result == null || result['refreshData'] == null || result['refreshData'].length == 0)
		{
			$("#valueDataList_before").html("");
			$("#valueDataList_before").html("<tr><td colspan='"+(itemCnt + 1)+"'>조회 결과가 없습니다</td></tr>");
			return;
		}

		
	
		var tot = result['refreshData'].length;
		var trClass;

	
		branch_name = result['refreshData'][0].branch_name;
			
		 $("#valueDataList_before").html("");
		
		
		if( tot <= "0" ){
			$("#factName_before").text("-");
			$("#valueDataList_before").html("<tr><td colspan='"+(itemCnt + 1)+"'>조회 결과가 없습니다</td></tr>");
	
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

				//$("#factName_before").text(obj.fact_name);
				
				branch_name = obj.min_time;

				item = "<tr code='"+obj.fact_code+"' branchNo='"+obj.branch_no+ "'>"
						+"<td>"+obj.min_time.substring(10,16)+"</td>";
						
				if(sys_kind != "A")
				{
					item += "<td class='num'><span id='tur_before"+i+"'>" + ((obj.tur == "") ? "-" : obj.tur)+ "</span></td>"
					+"<td class='num'><span id='tmp_before"+i+"'>" + ((obj.tmp == "") ? "-" : obj.tmp)+ "</span></td>"
					+"<td class='num'><span id='phy_before"+i+"'>" + ((obj.phy == "") ? "-" : obj.phy)+ "</span></td>"
					+"<td class='num'><span id='dow_before"+i+"'>" + ((obj.dow == "") ? "-" : obj.dow)+ "</span></td>"
					+"<td class='num'><span id='con_before"+i+"'>" + ((obj.con == "") ? "-" : obj.con)+ "</span></td>";
				}

				if(sys_kind == "A")
				{
					item += getRows(obj, i, "_before");
				}

				item += "</tr>";
	
				$("#valueDataList_before").append(item);

				if(sys_kind != "A")
				{
					setMinOr_Color(obj.tur_or, $("#tur_before" + i));
					setMinOr_Color(obj.tmp_or, $("#tmp_before" + i));
					setMinOr_Color(obj.phy_or, $("#phy_before" + i));
					setMinOr_Color(obj.dow_or, $("#dow_before" + i));
					setMinOr_Color(obj.con_or, $("#con_before" + i));
				}

				if(sys_kind == "A")
				{
					setMinor_list(obj, i, "_before");
				}
				
				idx++;
			}
	
			$("#valueDataList_before tr:odd").addClass("add");	
		}

		//chart();
	}

	/*******************************************************************/
	
	/***********************************************************/
	//									다음 공구
	/***********************************************************/
	function refresh_next(){

		fact_code = $("#factCode").val();
		sys_kind = $("#sys").val();
		
		$("#valueDataList_next").html("<tr><td colspan='"+(itemCnt + 1)+"'>데이터를 불러옵니다...</td></tr>");
		var branch_no = $("#branch_no_before").val();

		if(branch_no == null || branch_no == "")
			branch_no = "1";

		//IP-USN같은 경우에는 검색조건에 설정된 측정소 번호로 조회함
		if(sys_kind == "U")
			branch_no = $("#branchNo").val();

		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/situationctl/getWatersysMntMainDetail_next.do'/>",
			data:{fact_code:fact_code,
					 branch_no:branch_no,
					 sys_kind:sys_kind,
					 isNext:"Y"},
			dataType:"json",
			success:next_dataload_success,
			error:function(result){
				$("#valueDataList_next").html("");
				$("#valueDataList_next").html("<tr><td colspan='"+(itemCnt + 1)+"'>서버 접속에 실패하였습니다!</td></tr>");
			}
		});
	}


	function next_dataload_success(result)
	{

		var sys_kind = $("#sys").val();

		if(sys_kind != "U")
		{
			getBranchList_next(result['factCode']);
			
			var factName = result['factName'];

			if(factName != null && factName != undefined && factName != "")
				$("#factName_next").text(factName);
			else
				$("#factName_next").text("없음");
		}
		else
		{
			var factName = result['branchName'];

			if(factName != null && factName != undefined && factName != "")
				$("#factName_next").text(factName);
			else
				$("#factName_next").text("없음");
		}

		
		//if(nextFlag && result != null && result['factCode'] != null)
		//{
			


		
		$("#overBox_next").html("");

		
		//데이터 테이블 형식 생성(측정망, 다른 망의 형식이 다르기 때문)
		if(sys_kind != "A")	
		{
			var dataTable_next = "<table class='dataTable' id='dataTable_next' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>";
			dataTable_next += "<colgroup><col width='50px' /><col width='50px' /><col width='50px' /><col width='50px' /><col width='50px' /><col width=''/></colgroup>";
			dataTable_next += "<tbody id='valueDataList_next'></tbody>";
			dataTable_next += "</table>";
			$("#overBox_next").html(dataTable_next);
		}
		else
		{				
			var dataTable_next = "<table class='dataTable_broad' id='dataTable_next' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>";
			dataTable_next += "<colgroup><col width='50px' /><col width='50px' /><col width='50px' /><col width='50px' /><col width='50px' />";

			for(var idx = 0 ; idx < 40 ; idx ++)
			{
				dataTable_next += "<col width=''/>";
			 }
			dataTable_next += "<col width=''/></colgroup>";
			dataTable_next += "<tbody id='valueDataList_next'></tbody>";
			dataTable_next += "</table>";

			$("#overBox_next").html(dataTable_next);
		}

		
			
		if(result == null || result['refreshData'] == null || result['refreshData'].length == 0)
		{
			$("#valueDataList_next").html("");
			$("#valueDataList_next").html("<tr><td colspan='"+(itemCnt + 1)+"'>조회 결과가 없습니다</td></tr>");
			return;
		}

		var tot = result['refreshData'].length;
		var trClass;


		branch_name = result['refreshData'][0].branch_name;
			
		 $("#valueDataList_next").html("");
		
		
		if( tot <= "0" ){
			$("#valueDataList_next").html("<tr><td colspan='"+(itemCnt + 1)+"'>조회 결과가 없습니다</td></tr>");
	
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

				//$("#factName_next").text(obj.fact_name);
				
				branch_name = obj.min_time;

				item = "<tr code='"+obj.fact_code+"' branchNo='"+obj.branch_no+ "'>"
						+"<td>"+obj.min_time.substring(10,16)+"</td>";

				if(sys_kind != "A")
				{
					item += "<td class='num'><span id='tur_next"+i+"'>" + ((obj.tur == "") ? "-" : obj.tur)+ "</span></td>"
					+"<td class='num'><span id='tmp_next"+i+"'>" + ((obj.tmp == "") ? "-" : obj.tmp)+ "</span></td>"
					+"<td class='num'><span id='phy_next"+i+"'>" + ((obj.phy == "") ? "-" : obj.phy)+ "</span></td>"
					+"<td class='num'><span id='dow_next"+i+"'>" + ((obj.dow == "") ? "-" : obj.dow)+ "</span></td>"
					+"<td class='num'><span id='con_next"+i+"'>" + ((obj.con == "") ? "-" : obj.con)+ "</span></td>";
				}

				if(sys_kind == "A")
				{
					item += getRows(obj, i, "_next");
				}

				item += "</tr>";
	
				$("#valueDataList_next").append(item);

				if(sys_kind != "A")
				{
					setMinOr_Color(obj.tur_or, $("#tur_next" + i));
					setMinOr_Color(obj.tmp_or, $("#tmp_next" + i));
					setMinOr_Color(obj.phy_or, $("#phy_next" + i));
					setMinOr_Color(obj.dow_or, $("#dow_next" + i));
					setMinOr_Color(obj.con_or, $("#con_next" + i));
				}
				
				if(sys_kind == "A")
				{
					setMinor_list(obj, i, "_next");
				}
				
				idx++;
			}
	
			$("#valueDataList_next tr:odd").addClass("add");	
		}

		//chart();
	}

	/*******************************************************************/
	
	
	function refresh(){

		if(branch_no == null || branch_no == "")
			branch_no = "1";

		//IP-USN같은 경우에는 검색조건에 설정된 측정소 번호로 조회함
		if(sys_kind == "U")
			branch_no = $("#branchNo").val();

		
		$("#valueDataList").html("<tr><td colspan='"+(itemCnt + 1)+"'>데이터를 불러옵니다...</td></tr>");
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/situationctl/getWatersysMntMainDetail.do'/>",
			data:{fact_code:fact_code,
					 branch_no:branch_no},
			dataType:"json",
			success:dataload_success,
			error:function(result){
				$("#valueDataList").html("");
				$("#valueDataList").html("<tr><td colspan='"+(itemCnt + 1)+"'>서버 접속에 실패하였습니다!</td></tr>");
				chartLoaded();
			}
		});
	}


	function dataload_success(result)
	{
		
		var tot = result['refreshData'].length;
		var trClass;


		$("#overBox").html("");

		
		//데이터 테이블 형식 생성(측정망, 다른 망의 형식이 다르기 때문)
		if(sys_kind != "A")	
		{
			var dataTable = "<table class='dataTable' id='dataTable' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>";
			dataTable += "<colgroup><col width='50px' /><col width='50px' /><col width='50px' /><col width='50px' /><col width='50px' /><col width=''/></colgroup>";
			dataTable += "<tbody id='valueDataList'></tbody>";
			dataTable += "</table>";
			$("#overBox").html(dataTable);
		}
		else
		{				
			var dataTable = "<table class='dataTable_broad' id='dataTable' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>";
			dataTable += "<colgroup><col width='50px' /><col width='50px' /><col width='50px' /><col width='50px' /><col width='50px' />";

			for(var idx = 0 ; idx < 40 ; idx ++)
			{
				dataTable += "<col width=''/>";
			 }
			dataTable += "<col width=''/></colgroup>";
			dataTable += "<tbody id='valueDataList'></tbody>";
			dataTable += "</table>";

			$("#overBox").html(dataTable);
		}


		if(sys_kind != "U")
		{
			var factName = $("#factCode > option[selected=selected]").text();
			$("#factName").text(factName);
		}
		else
		{
			var factName = $("#branchNo > option[selected=selected]").text();

			try{
			factName = factName.split("-")[0];
			}catch(Exception)
			{}
					
			$("#factName").text(factName);
		}

		if(result == null || result['refreshData'] == null || result['refreshData'].length == 0)
		{
			$("#valueDataList").html("");
			$("#valueDataList").html("<tr><td colspan='"+(itemCnt + 1)+"'>조회 결과가 없습니다</td></tr>");

			chartLoaded();
			return;
		}

		branch_name = result['refreshData'][0].branch_name;
			
		 $("#valueDataList").html("");
	
			
		if( tot <= "0" ){
			$("#valueDataList").html("<tr><td colspan='"+(itemCnt + 1)+"'>조회 결과가 없습니다</td></tr>");
	
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
				
				branch_name = obj.min_time;

				item = "<tr code='"+obj.fact_code+"' branchNo='"+obj.branch_no+ "'>"
						+"<td>"+obj.min_time.substring(10,16)+"</td>";

				if(sys_kind != "A")
				{
					item += "<td class='num'><span id='tur"+i+"'>" + ((obj.tur == "") ? "-" : obj.tur)+ "</span></td>"
					+"<td class='num'><span id='tmp_"+i+"'>" + ((obj.tmp == "") ? "-" : obj.tmp)+ "</span></td>"
					+"<td class='num'><span id='phy"+i+"'>" + ((obj.phy == "") ? "-" : obj.phy)+ "</span></td>"
					+"<td class='num><span id='dow"+i+"'>" + ((obj.dow == "") ? "-" : obj.dow)+ "</span></td>"
					+"<td class='num'><span id='con"+i+"'>" + ((obj.con == "") ? "-" : obj.con)+ "</span></td>";
				}

				if(sys_kind == "A")
				{
					item += getRows(obj, i , "");
				}
						
				/*
				for(var rowIdx = 0; rowIdx < itemCnt ; rowIdx++)
					{
					var value;
	
					switch(itemCode[rowIdx])
					{
					case "CON" :
						value = obj.con;
						break;
					case "TUR" :
						value = obj.tur;
						break;
					case "DOW" :
						value = obj.dow;
						break;
					case "TMP" :
						value = obj.tmp;
						break;
					case "PHY" :
						value = obj.phy;
						break;
					}
	
					if(value == null || value == "") value = "-";
					item += "<td id='"+itemCode[rowIdx]+idx+"' class ='num'><span>"+ value + "</span></td>";
				}
				*/
				
				item += "</tr>";
	
				$("#valueDataList").append(item);

				if(sys_kind != "A")
				{
					setMinOr_Color(obj.tur_or, $("#tur" + i));
					setMinOr_Color(obj.tmp_or, $("#tmp" + i));
					setMinOr_Color(obj.phy_or, $("#phy" + i));
					setMinOr_Color(obj.dow_or, $("#dow" + i));
					setMinOr_Color(obj.con_or, $("#con" + i));
				}

				if(sys_kind == "A")
				{
					setMinor_list(obj, i, "");
				}
				
				idx++;
			}
	
			$("#valueDataList tr:odd").addClass("add");	
		}

		$("#branch_no>option[value=" + branch_no+ "]").attr("selected", "selected");
		
		chart();
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

	function chart(){

		
		var width = "1180";
		var height = "210";


		if(sys_kind == "A")
			width = "1170";
		else
			width = "1190";
		
		var item = $("#graphItem").val();

		var fact_code = $("#factCode").val();
		var sys_kind = $("#sys").val();
		var fact_name = '';
		var branch_no= $("#branch_no").val();
		
		var branch_no_before = $("#branch_no_before").val();
		var branch_no_next = $("#branch_no_next").val();

		if(sys_kind == "U")
			branch_no = $("#branchNo").val();
		
		document.chartForm.target = "chart";
		
		document.chartForm.factCode.value = fact_code;
		document.chartForm.branchNo.value = branch_no;
		document.chartForm.branchNo_before.value = branch_no_before;
		document.chartForm.branchNo_next.value = branch_no_next;
		document.chartForm.branchName.value = branch_name;
		document.chartForm.sys_kind.value = sys_kind;
		document.chartForm.item.value = item;
		document.chartForm.width.value = width;
		document.chartForm.height.value = height;
		
		document.chartForm.action = "<c:url value='/waterpolmnt/situationctl/getWatersysMntDetailGraph.do?'/>";
		
		document.chartForm.submit();
	}


	function getRows(obj, i, div)
	{
		var item = "";
		
		item += "<td class='num'><span id='phy" + div + i +"'>" + ((obj.phy == "") ? "-" : obj.phy)+ "</span></td>"
		+"<td class='num'><span id='dow"+ div+i+"'>" + ((obj.dow == "") ? "-" : obj.dow)+ "</span></td>"
		+"<td class='num'><span id='con"+ div+i+"'>" + ((obj.con == "") ? "-" : obj.con)+ "</span></td>"
		+"<td class='num'><span id='tmp"+ div+i+"'>" + ((obj.tmp == "") ? "-" : obj.tmp)+ "</span></td>"
		+"<td class='num'><span id='phy2_"+ div+i+"'>" + ((obj.phy2 == "") ? "-" : obj.phy2)+ "</span></td>"
		+"<td class='num'><span id='dow2_"+ div+i+"'>" + ((obj.dow2 == "") ? "-" : obj.dow2)+ "</span></td>"
		+"<td class='num'><span id='con2_"+ div+i+"'>" + ((obj.con2 == "") ? "-" : obj.con2)+ "</span></td>"
		+"<td class='num'><span id='tmp2_"+ div+i+"'>" + ((obj.tmp2 == "") ? "-" : obj.tmp2)+ "</span></td>"
		+"<td class='num'><span id='tur"+ div+i+"'>" + ((obj.tur == "") ? "-" : obj.tur)+ "</span></td>"
		+"<td class='num'><span id='imp"+ div+i+"'>" + ((obj.imp == "") ? "-" : obj.imp)+ "</span></td>"
		+"<td class='num'><span id='lim"+ div+i+"'>" + ((obj.lim == "") ? "-" : obj.lim)+ "</span></td>"
		+"<td class='num'><span id='rim"+ div+i+"'>" + ((obj.rim == "") ? "-" : obj.rim)+ "</span></td>"
		+"<td class='num'><span id='ltx"+ div+i+"'>" + ((obj.ltx == "") ? "-" : obj.ltx)+ "</span></td>"
		+"<td class='num'><span id='rtx"+ div+i+"'>" + ((obj.rtx == "") ? "-" : obj.rtx)+ "</span></td>"
		+"<td class='num'><span id='tox"+ div+i+"'>" + ((obj.tox == "") ? "-" : obj.tox)+ "</span></td>"
		+"<td class='num'><span id='evn"+ div+i+"'>" + ((obj.evn == "") ? "-" : obj.evn)+ "</span></td>"
		+"<td class='num'><span id='tof"+ div+i+"'>" + ((obj.tof == "") ? "-" : obj.tof)+ "</span></td>"
		+"<td class='num'><span id='voc1_"+ div+i+"'>" + ((obj.voc1 == "") ? "-" : obj.voc1)+ "</span></td>"
		+"<td class='num'><span id='voc2_"+ div+i+"'>" + ((obj.voc2 == "") ? "-" : obj.voc2)+ "</span></td>"
		+"<td class='num'><span id='voc3_"+ div+i+"'>" + ((obj.voc3 == "") ? "-" : obj.voc3)+ "</span></td>"
		+"<td class='num'><span id='voc4_"+ div+i+"'>" + ((obj.voc4 == "") ? "-" : obj.voc4)+ "</span></td>"
		+"<td class='num'><span id='voc5_"+ div+i+"'>" + ((obj.voc5 == "") ? "-" : obj.voc5)+ "</span></td>"
		+"<td class='num'><span id='voc6_"+ div+i+"'>" + ((obj.voc6 == "") ? "-" : obj.voc6)+ "</span></td>"
		+"<td class='num'><span id='voc7_"+ div+i+"'>" + ((obj.voc7 == "") ? "-" : obj.voc7)+ "</span></td>"
		+"<td class='num'><span id='voc8_"+ div+i+"'>" + ((obj.voc8 == "") ? "-" : obj.voc8)+ "</span></td>"
		+"<td class='num'><span id='voc9_"+ div+i+"'>" + ((obj.voc9 == "") ? "-" : obj.voc9)+ "</span></td>"
		+"<td class='num'><span id='voc10_"+ div+i+"'>" + ((obj.voc10 == "") ? "-" : obj.voc10)+ "</span></td>"
		+"<td class='num'><span id='voc11_"+ div+i+"'>" + ((obj.voc11 == "") ? "-" : obj.voc11)+ "</span></td>"
		+"<td class='num'><span id='voc12_"+ div+i+"'>" + ((obj.voc12 == "") ? "-" : obj.voc12)+ "</span></td>"
		+"<td class='num'><span id='voc13_"+ div+i+"'>" + ((obj.voc13 == "") ? "-" : obj.voc13)+ "</span></td>"
		+"<td class='num'><span id='voc14_"+ div+i+"'>" + ((obj.voc14 == "") ? "-" : obj.voc14)+ "</span></td>"
		+"<td class='num'><span id='voc15_"+ div+i+"'>" + ((obj.voc15 == "") ? "-" : obj.voc15)+ "</span></td>"
		+"<td class='num'><span id='cad"+ div+i+"'>" + ((obj.cad == "") ? "-" : obj.cad)+ "</span></td>"
		+"<td class='num'><span id='plu"+ div+i+"'>" + ((obj.plu == "") ? "-" : obj.plu)+ "</span></td>"
		+"<td class='num'><span id='cop"+ div+i+"'>" + ((obj.cop == "") ? "-" : obj.cop)+ "</span></td>"
		+"<td class='num'><span id='zin"+ div+i+"'>" + ((obj.zin == "") ? "-" : obj.zin)+ "</span></td>"
		+"<td class='num'><span id='phe"+ div+i+"'>" + ((obj.phe == "") ? "-" : obj.phe)+ "</span></td>"
		+"<td class='num'><span id='phl"+ div+i+"'>" + ((obj.phl == "") ? "-" : obj.phl)+ "</span></td>"
		+"<td class='num'><span id='toc"+ div+i+"'>" + ((obj.toc == "") ? "-" : obj.toc)+ "</span></td>"
		+"<td class='num'><span id='ton"+ div+i+"'>" + ((obj.ton == "") ? "-" : obj.ton)+ "</span></td>"
		+"<td class='num'><span id='top"+ div+i+"'>" + ((obj.top == "") ? "-" : obj.top)+ "</span></td>"
		+"<td class='num'><span id='nh4"+ div+i+"'>" + ((obj.nh4 == "") ? "-" : obj.nh4)+ "</span></td>"
		+"<td class='num'><span id='no3"+ div+i+"'>" + ((obj.no3 == "") ? "-" : obj.no3)+ "</span></td>"
		+"<td class='num'><span id='po4"+ div+i+"'>" + ((obj.po4 == "") ? "-" : obj.po4)+ "</span></td>"
		+"<td class='num'><span id='rin"+ div+i+"'>" + ((obj.rin == "") ? "-" : obj.rin)+ "</span></td>";

		return item;
	}

	function setMinor_list(obj, i, div)
	{
		setMinOr_Color(obj.tur_or, $("#tur" + div + i));
		setMinOr_Color(obj.tmp_or, $("#tmp" + div + i));
		setMinOr_Color(obj.phy_or, $("#phy"+ div + i));
		setMinOr_Color(obj.dow_or, $("#dow"+ div + i));
		setMinOr_Color(obj.con_or, $("#con"+ div + i));

		setMinOr_Color(obj.phy2_or, $("#phy2_"+ div + i));
		setMinOr_Color(obj.dow2_or, $("#dow2_"+ div + i));
		setMinOr_Color(obj.con2_or, $("#con2_"+ div + i));
		setMinOr_Color(obj.tmp2_or, $("#tmp2_"+ div + i));
		
		setMinOr_Color(obj.imp_or, $("#imp"+ div + i));
		setMinOr_Color(obj.lim_or, $("#lim"+ div + i));
		setMinOr_Color(obj.rim_or, $("#rim"+ div + i));
		setMinOr_Color(obj.ltx_or, $("#ltx"+ div + i));
		setMinOr_Color(obj.rtx_or, $("#rtx"+ div + i));
		setMinOr_Color(obj.tox_or, $("#tox"+ div + i));
		setMinOr_Color(obj.evn_or, $("#evn"+ div + i));
		setMinOr_Color(obj.tof_or, $("#tof"+ div+ i));
		
		setMinOr_Color(obj.voc1_or, $("#voc1_" + div+ i));
		setMinOr_Color(obj.voc2_or, $("#voc2_" + div+ i));
		setMinOr_Color(obj.voc3_or, $("#voc3_" + div+ i));
		setMinOr_Color(obj.voc4_or, $("#voc4_" + div+ i));
		setMinOr_Color(obj.voc5_or, $("#voc5_" + div+ i));
		setMinOr_Color(obj.voc6_or, $("#voc6_" + div+ i));
		setMinOr_Color(obj.voc7_or, $("#voc7_" + div+ i));
		setMinOr_Color(obj.voc8_or, $("#voc8_" + div+ i));
		setMinOr_Color(obj.voc9_or, $("#voc9_" + div+ i));
		setMinOr_Color(obj.voc10_or, $("#voc10_" + div+ i));
		setMinOr_Color(obj.voc11_or, $("#voc11_" + div+ i));
		setMinOr_Color(obj.voc12_or, $("#voc12_" + div+ i));
		setMinOr_Color(obj.voc13_or, $("#voc13_" + div+ i));
		setMinOr_Color(obj.voc14_or, $("#voc14_" + div+ i));
		setMinOr_Color(obj.voc15_or, $("#voc15_" + div+ i));

		setMinOr_Color(obj.cad_or, $("#cad" + div+ i));
		setMinOr_Color(obj.plu_or, $("#plu" + div+ i));
		setMinOr_Color(obj.cop_or, $("#cop" + div+ i));
		setMinOr_Color(obj.zin_or, $("#zin" + div+ i));

		setMinOr_Color(obj.phe_or, $("#phe" + div+ i));
		setMinOr_Color(obj.phl_or, $("#phl" + div+ i));

		setMinOr_Color(obj.toc_or, $("#toc" + div+ i));
		
		setMinOr_Color(obj.ton_or, $("#ton" + div+ i));
		setMinOr_Color(obj.top_or, $("#top" + div+ i));
		setMinOr_Color(obj.nh4_or, $("#nh4" + div+ i));
		setMinOr_Color(obj.no3_or, $("#no3" + div+ i));
		setMinOr_Color(obj.po4_or, $("#po4" + div+ i));

		setMinOr_Color(obj.rin_or, $("#rin" + div+ i));
	}
</script>

</head>
<body>
<div id='loadingDiv'>
	<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />	
</div>
	<form id="chartForm" name="chartForm" method="post">
		<input type="hidden" name="factCode" />
		<input type="hidden" name="branchNo" />
		<input type="hidden" name="branchNo_before"/>
		<input type="hidden" name="branchNo_next"/>
		<input type="hidden" name="branchName" />
		<input type="hidden" name="sys_kind" />
		<input type="hidden" name="width"/>
		<input type="hidden" name="height"/>
		<input type="hidden" name="item"/>
	</form>
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
		<div id="content" class="sub_waterpolmnt">
			<div class="content_wrap page_waterinfo">
				<div class="inner_riverwater">
					<!-- 하천 수질 조회 -->
					<div class="search_all_wrap">
						<form:form commandName="searchTaksuVO" name="listFrm"  id="listFrm" method="post">		
						<input type="hidden" name="pageIndex" id="pageIndex" value="${searchTaksuVO.pageIndex}"/>	
						<input type="hidden" name="chukjeongso" id="chukjeongso"/>
						<input type="hidden" name="gongku" id="gongku"/>
						<input type="hidden" name="sugye" id="river_div"/>
						<input type="hidden" name="frDate" id="frDate"/>
						<input type="hidden" name="toDate" id="toDate"/>
						<input type="hidden" name="item01" id="item01"/>
						<input type="hidden" name="item02" id="item02"/>
						<input type="hidden" name="item03" id="item03"/>
						<input type="hidden" name="item04" id="item04"/>
						<input type="hidden" name="item05" id="item05"/>
						<dl>
							<dt><img src="<c:url value='/images/content/tit_search_system.gif'/>" alt="시스템" /></dt>
							<dd>
								<select class="fixWidth13" id="sys" name="sys">
										<option value="U">이동형측정기기</option>
<!-- 										<option value="T" selected="selected">탁수모니터링</option> -->
										<option value="A">국가수질자동측정망</option>
								</select>
							</dd>
							<dt><img src="<c:url value='/images/content/tit_search_branch.gif'/>" alt="측정소" /></dt>
							<dd>
								<select class="fixWidth7"  id="sugye">
										<option value="R01">한강</option>
										<option value="R02">낙동강</option>
										<option value="R03">금강</option>
										<option value="R04">영산강</option>
								</select>
								<span>&gt;</span>
									<select class="fixWidth11"  id="factCode">
										<option value="all">전체</option>
									</select>
								<span id="spanBranch" style="display:none">
								<span>&gt;</span>
								<select class="fixWidth11" id="branchNo" name="branchNo" disabled="disabled">
									<option value="all">전체</option>
								</select>
								</span>
							</dd>
						</dl>
						<div class="btnInBox">
							<p class="btn_search"><a href="javascript:reloadData()"><img src="<c:url value='/images/common/btn_search.gif'/>" alt="조회" /></a></p>
						</div>
							<!-- //수질 조회 현황 -->
						</form:form>
					</div>
					<br/>
					<br/>
					<!-- //하천 수질 조회 -->
					<div class="watersysmnt_factdetail">
						<div class="listBox">
							<div class="roundBox roundBox1">
								<div class="top_l"><div class="top_r"><div class="top"></div></div></div>
								<div class="con">
									<div class="wrap">
										<h2 id='factName_before' class="buRect_tit"></h2>
										<div class="data">
											<form action="">
												<p class="form_select">
													<select id="branch_no_before">
														<option value="1"></option>
													</select>
												</p>
												<div class="overBox_header" id="overBoxHeader_before" style="overflow:hidden;">
													<table class="dataTable"  id="dataTableHeader_before" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
														<colgroup>
															<col width="50px" />
															<col width="60px" />
															<col width="60px" />
															<col width="60px" />
															<col width="60px" />
															<c:if test="${param.sys_kind == 'A'}">
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
															</c:if>
															<col width="" />
														</colgroup>
														<thead id="valueDataHeader1_before">
																<tr>
																	<th scope="col" rowspan="2">시간</th>
																	<th scope="col" colspan="5">수질정보</th>
																</tr>
																<tr>
																	<th scope="col">탁도<br/>(NTU)</th>
																	<th scope="col">수온<br/>(℃)</th>
																	<th scope="col">pH</th>
																	<th scope="col">DO<br/>(mg/L)</th>
																	<th scope="col">EC<br/>(mS/cm)</th>
																</tr>
														</thead>
													</table>
												</div>
												<div class="overBox" id="overBox_before" onscroll="scrollX_before()" style="border-bottom:solid 1px #CCC">
													<table class="dataTable" id="dataTable_before" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
														<colgroup>
															<col width="50px" />
															<col width="60px" />
															<col width="60px" />
															<col width="60px" />
															<col width="60px" />
															<c:if test="${param.sys_kind == 'A'}">
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
															</c:if>
															<col width="" />
														</colgroup>
														<tbody id="valueDataList_before">
															<tr>
																<td colspan="6"><span>데이터를 불러오는 중 입니다...</span></td>
															</tr>
														</tbody>
													</table>
												</div>
												<script type="text/javascript">
												function scrollX_before()
												{		
															document.getElementById("overBoxHeader_before").scrollLeft = document.getElementById("overBox_before").scrollLeft;
												}
												</script>
											</form>
										</div>
									</div>
								</div>
								<div class="bot_l"><div class="bot_r"><div class="bot"></div></div></div>
							</div>
						</div>
						<div class="listBox listBox_point">
							<div class="roundBox roundBox1">
								<div class="top_l"><div class="top_r"><div class="top"></div></div></div>
								<div class="con">
									<div class="wrap">
										<h2 id='factName' class="buRect_tit">-</h2>
										<div class="data">
											<form action="">
												<p class="form_select">
													<select id="branch_no">
													</select>
												</p>
												<div class="overBox_header" id="overBoxHeader" style="overflow:hidden;">
													<table class="dataTable"  id="dataTableHeader" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
														<colgroup>
															<col width="50px" />
															<col width="60px" />
															<col width="60px" />
															<col width="60px" />
															<col width="60px" />
															<c:if test="${param.sys_kind == 'A'}">
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
															</c:if>
															<col width="" />
														</colgroup>
														<thead id="valueDataHeader">
														</thead>
													</table>
												</div>
												<div class="overBox" id="overBox" onscroll="scrollX()" style="border-bottom:solid 1px #CCC">
													<table class="dataTable" id="dataTable" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
														<colgroup>
															<col width="50px" />
															<col width="60px" />
															<col width="60px" />
															<col width="60px" />
															<col width="60px" />
															<c:if test="${param.sys_kind == 'A'}">
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
															</c:if>
															<col width="" />
														</colgroup>
														<tbody id="valueDataList">
															<tr>
																<td colspan="6"><span>데이터를 불러오는 중 입니다...</span></td>
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
											</form>
										</div>
									</div>
								</div>
								<div class="bot_l"><div class="bot_r"><div class="bot"></div></div></div>
							</div>
						</div>
						<div class="listBox">
							<div class="roundBox roundBox1">
								<div class="top_l"><div class="top_r"><div class="top"></div></div></div>
								<div class="con">
									<div class="wrap">
										<h2 id='factName_next' class="buRect_tit">-</h2>
										<div class="data">
											<form action="">
												<p class="form_select">
													<select id="branch_no_next">
															<option value="1"></option>
													</select>
												</p>
												<div class="overBox_header" id="overBoxHeader_next" style="overflow:hidden;">
													<table class="dataTable" id="dataTableHeader_next" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
														<colgroup>
															<col width="50px" />
															<col width="60px" />
															<col width="60px" />
															<col width="60px" />
															<col width="60px" />
															<c:if test="${param.sys_kind == 'A'}">
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
															</c:if>
															<col width="" />
														</colgroup>
														<thead id="valueDataHeader1_next">
																<tr>
																	<th scope="col" rowspan="2">시간</th>
																	<th scope="col" colspan="5">수질정보</th>
																</tr>
																<tr>
																	<th scope="col">탁도<br/>(NTU)</th>
																	<th scope="col">수온<br/>(℃)</th>
																	<th scope="col">pH</th>
																	<th scope="col">DO<br/>(mg/L)</th>
																	<th scope="col">EC<br/>(mS/cm)</th>
																</tr>
															</thead>
													</table>
												</div>
												<div class="overBox" onscroll="scrollX_next()" id="overBox_next" style="border-bottom:solid 1px #CCC">
													<table class="dataTable" id="dataTable_next" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
														<colgroup>
															<col width="50px" />
															<col width="60px" />
															<col width="60px" />
															<col width="60px" />
															<col width="60px" />
															<c:if test="${param.sys_kind == 'A'}">
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
																<col width="" />
															</c:if>
															<col width="" />
														</colgroup>
														<tbody id="valueDataList_next">
															<tr>
																<td colspan="6"><span>데이터를 불러오는 중 입니다...</span></td>
															</tr>
														</tbody>
													</table>
												</div>
												<script type="text/javascript">
												function scrollX_next()
												{		
															document.getElementById("overBoxHeader_next").scrollLeft = document.getElementById("overBox_next").scrollLeft;
												}
												</script>
											</form>
										</div>
									</div>
								</div>
								<div class="bot_l"><div class="bot_r"><div class="bot"></div></div></div>
							</div>
						</div>
						<!-- 20100721 추가 -->
						<div class="graph_box">
							<div class="roundBox roundBox1"> 
								<div class="top_l"><div class="top_r"><div class="top"></div></div></div> 
								<div class="con"> 
									<p class="select_box">
										<select id="graphItem" style="width:104px">
											<option value="TUR00">탁도</option>
											<option value="TMP00">수온</option>
											<option value="PHY00">pH</option>
											<option value="DOW00">용존산소</option>
											<option value="CON00">전기전도도</option>
										</select>
									</p>
									<div class="map">
										<iframe id="chart" name="chart"  src="" onload="chartLoaded()" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" width="100%" height="100%"></iframe>
									</div>
								</div> 
								<div class="bot_l"><div class="bot_r"><div class="bot"></div></div></div> 
							</div>
						</div>
						<!-- //20100721 추가 -->
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