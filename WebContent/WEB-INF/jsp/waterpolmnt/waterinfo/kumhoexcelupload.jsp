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


<sec:authorize ifAnyGranted="ROLE_USER">
	<script  type='text/javascript'>
		var user_dept_no = '<sec:authentication property="principal.userVO.deptNo"/>';
	</script> 
</sec:authorize>

<%-- <sec:authorize ifNotGranted="ROLE_USER"> --%>
<!-- 	<script  type='text/javascript'> -->
<!-- 		alert('로그인이 필요한 페이지 입니다'); -->
<%-- 		window.location = "<c:url value='/'/>";  --%>
<!-- 	</script>  -->
<%-- </sec:authorize> --%>


<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
<script src="<c:url value='/js/JQuery/jquery-1.3.2.min.js" type="text/javascript'/>"></script>
<script src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js" type="text/javascript'/>"></script>
<script src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js" type="text/javascript'/>"></script>
<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>

<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.datepicker.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/JQuery/jquery.form.js'/>"></script>
 

<script type='text/javascript'>
//<![CDATA[

           var sFactCode;
           
           function save()
           {
        	    showLoading();
            	document.upload.action = '/waterpolmnt/waterinfo/uploadExcelData.do';
            	document.upload.submit();
           }

           var isSuccess = "${result}";
           var errorMsg = "${errorMsg}";

           $(function(){

        	   if(isSuccess != null && isSuccess != "")
        	   {
            	   if(isSuccess == 'true')
            	   {
                	   alert("업로드 성공");
					   
                	   reloadData();
            	   }  
            	   else if(isSuccess == 'false')
            	   {
                	   alert("업로드 실패! [" + errorMsg + "]");  
            	   }	   

   		       	   $("#river_div > option[value=${param.river_div}]").attr("selected","selected");
   		           sFactCode = '${param.fact_code}';
        	   }


        		$('#river_div')
        	  	.change(function(){
        	  		adjustGongku();
        	  	});

        		adjustGongku();

        		itemSetting();
        		makeHeader();
           });


           var itemCnt;

       	//itemArray 셋팅 
       	function itemSetting()
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
       	
       	//테이블 헤더 생성
       	function makeHeader()
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
       	

       			$("#dataTable").attr("class", "dataTable");
       			$("#dataTable").css("width", "5200px");
       			
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


        
       	function adjustGongku()
    	{
    		//var sugyeCd = $('#sugye').val();
    		//var sys_kind = $("#sys").val();
    		
    		var sugyeCd = $('#river_div').val();
    		
    		
    		var dropDownSet = $('#factCode');    		
    		
    		if( sugyeCd == 'all'){
    			dropDownSet.attr("disabled", true);
    			$("#factCode>option:first").attr("selected", "true");
    		}else{
    			dropDownSet.attr("disabled", false);
    			$.getJSON("<c:url value='/waterpolmnt/waterinfo/getGongkuList.do'/>", 
    					{sugye:sugyeCd, system:'A'}, function (data, status){
    			     if(status == 'success'){     
    			        //locId 객체에 SELECT 옵션내용 추가.
    			       
    			        dropDownSet.loadSelect(data.gongku);

    			        if(sFactCode != null && sFactCode != '')    	
	    		       		$("#factCode > option[value="+sFactCode+"]").attr("selected","selected");

    		       		
    			     } else { 
    			    	 alert("공구 목록 가져오기 실패");
    			        return;
    			     }
    			});
    		}		
    	}
    	
           function showLoading2()
           {
	           	$("#loadingDiv2").dialog({
	           		modal:true,
	           		open:function() 
	           		{
	           		$("#loadingDiv2").css("visibility","visible");
	    			$(this).parents(".ui-dialog:first").find(".ui-dialog-titlebar-close").hide();
	    			$(this).parents(".ui-dialog:first").find(".ui-dialog-titlebar").hide();
	    			$(this).parents(".ui-dialog:first").find(".ui-dialog-resizing").hide();
	    			$(this).parents(".ui-dialog:first").find(".ui-dialog-buttonpane").hide();
	    			$(this).parents(".ui-dialog:first").find(".ui-dialog-dragging").hide();
	    			$(this).parents(".ui-dialog:first").css("width", "85px");
	    			$(this).parents(".ui-dialog:first").css("height", "75px");
	    			$(this).parents(".ui-dialog:first").css("overflow", "hidden");
	    			$("#loadingDiv2").css("float", "left");
	           		},
	           		width:0,
	           		height:0,
	           	    showCaption:false,
	           	    resizable:false
	           	});
           	
           		$("#loadingDiv2").dialog("open");
           }

           function closeLoading2()
           {
           	$("#loadingDiv2").dialog("close");
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
	           			$(this).parents(".ui-dialog:first").css("width", "120px");
	           			$(this).parents(".ui-dialog:first").css("height", "40px");
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


          function reloadData(pageNo){

        	showLoading2();
        	  
        	date = '${insertTime}';

       		var river_div = '${param.river_div}';
       		var fact_code = '${param.fact_code}';
       		
       		var frDate = date;
       		var toDate = date;
       		
       	    var frTime = "00";
       		var toTime = "23";

       		var minor = 'all';
       		var valid = 'Y';
       		var sys='A';
       		
       		var rType = '2';
           		
       		if (pageNo == null) pageNo = 1;
       	
       		$.ajax({
       			type:"post",
       			url:"<c:url value='/waterpolmnt/waterinfo/getDetailViewRIVER.do'/>",
       			data:{sugye:river_div, 
       			      chukjeongso:'all',
       				  gongku:fact_code,
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
       	                    
       	                    if(river_div == 'R01')
       	                    	factNumber = obj.factname.replace('한강', '');
       	                    else if(river_div == 'R02')
       	                    	factNumber = obj.factname.replace('낙동강', '');
       	                    else if(river_div == 'R03')
       	                    	factNumber = obj.factname.replace('금강', '');
       	                    else if(river_div == 'R04')
       	                    	factNumber = obj.factname.replace('영산강','');

                           	
       	                    var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
       	                    
       	                   	item = "<tr class='"+trClass+"'><td class='num'><span>" + no + "</span></td>"
       	                   		 +"<td>"+obj.river_name+"</td>" 
       							 +"<td id='tur"+i+"'>"+factNumber+"</td>"
       	    	                 +"<td id='dow"+i+"'>"+obj.branch_name+"</td>"
       	    	                 +"<td id='rem"+i+"'>"+obj.strdate+"</td>"
       	    	                 +"<td id='rem"+i+"'>"+obj.strtime+"</td>";

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

       								
       	                 	item += "</tr>";
       	                 		 
       	           			$("#dataList").append(item);

       	           			$("#dataList tr:odd").attr("class","add"); 
       	                }
                       }

                       // 페이징 정보
       	            var pageStr = makePaginationInfo(result['paginationInfo']);
       	            $("#pagination").empty();
       	            $("#pagination").append(pageStr);	       

       	            $("#p_total_cnt").html("총 " + result['totCnt'] + "건");

       	            tmpSys = sys;

       	            closeLoading2();
       			},
                   error:function(result){  
       				$("#dataList").html("");
       	            $("#dataList").html("<tr><td colspan='11'>서버 접속에 실패하였습니다!</td></td>");
       	            closeLoading2();
       	        }
       		});

			
       		$("#river_div > option[value=${param.river_div}]").attr("selected","selected");
       		$("#factCode > option[value=${param.fact_code}]").attr("selected","selected");
       		
       		//setTimeout(reloadData, 60000);
       	}    

      	// 페이지 번호 클릭	
      	function linkPage(pageNo){
      		reloadData(pageNo);				    
      	} 
//]]>
</script>

</head>
<body>
<div id='loadingDiv2' style="visibility:hidden;position:absolute;">
	<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />	
</div>
<div id='loadingDiv' style="visibility:hidden;position:absolute;font-size:9pt;padding-top:10px">
	업로드 중입니다... <br/>
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
		<div id="content" class="sub_waterpolmnt">
			<div class="content_wrap page_waterinfo">
				<div class="inner_riverwater">
					<!-- 하천 수질 조회 -->
					<div class="search_all_wrap">
						<form:form commandName="excelUpload" name="upload"  id="upload" method="post" enctype="multipart/form-data">		
							<div class="btnInBox">		
								<dt><img src="<c:url value='/images/content/tit_search_river.gif'/>" alt="수계" /></dt>
								<dd>
									<select class="fixWidth7"  id="river_div" name="river_div">
										   <option value="R01">한강</option>
										   <option value="R02">낙동강</option>
										   <option value="R03">금강</option>
										   <option value="R04">영산강</option>
									</select>
									<span>&gt;</span>
									<select class="fixWidth11"  id="factCode" name="fact_code">
										<option value="all">로딩중</option>
									</select>
								</dd>
								<dt></dt>
								<dd>
									<input type="file" size="45" id="excelFile" name="excelFile"/>
								</dd>
								<p class="btn_search"><a href="javascript:save()"><img src="<c:url value='/images/common/btn_confirm.gif'/>" alt="엑셀저장" /></a></p>
							</div>
						<!-- //수질 조회 현황 -->
			   	 	</form:form>
				    </div>
					<!-- //하천 수질 조회 -->

					<ul class="dataBtn">
						<li style='visibility:hidden'><a id="a_chartPopup"><img style='display:none' id="img_chartPopup" src="<c:url value='/images/common/btn_graph.gif'/>" alt="그래프" /></a></li>
					</ul>
					<p class="p_total_cnt" id="p_total_cnt">총 ${totCnt}건</p>
					<div class="data_wrap">
						<div id="overBox" class="overBox" style="width:1026px">
							<table id="dataTable" class="dataTable" oncontextmenu="return false" ondragstart="return false" onselectstart="return false"><!-- 컬럼 개수가 늘어날수록 width값도 증가해야합니다. -->
								<thead id="dataHeader">
								</thead>

								<tbody id="dataList">
								</tbody>								
							</table>
						</div>
					</div>
					<ul class="paginate" id="pagination">
					</ul>
					
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