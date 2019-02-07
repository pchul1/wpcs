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
	
<%-- 	<sec:authorize ifNotGranted="ROLE_ADMIN"> --%>
<!-- 		<script  type='text/javascript'> -->
<!-- 			alert('잘못된 접근입니다'); -->
<%-- 			window.location = "<c:url value='/'/>";  --%>
<!-- 		</script>  -->
<%-- 	</sec:authorize> --%>

<script type='text/javascript'>
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
	
	var river_div = '${param.river_div}';
	var sys = '${param.sys}';
	
	$("#river > option[value="+river_div+"]").attr("selected", "true");
	$("#sys > option[value=" + sys + "]").attr("selected", "true");
	
	$('#sys')
	.change(function(){
		showLoading();
		resultObj = null;
		riverMapReload();
	})
	
	$('#river')
	.change(function(){
		showLoading();
		resultObj = null;
		riverMapReload();
		nextBtnLeftSet();
	})
	
	riverMapReload();

	nextBtnLeftSet();
});
	
	function showLoading()
	{
		$("#loadingDiv").dialog("open");
	}
	
	var page = 0; //낙동강 페이징 관련
	
	function riverMapReload()
	{
		page = 0;
		riverPageBtnInit();
		InitPoint();
	}
	
	//탁수
	var arrPointX = new Array();
	var arrPointY = new Array();
	var arrPointId = new Array();
	var arrPointNm = new Array();
	var arrPointSt = new Array();
	var arrPointRiverDiv = new Array();
	var arrPointIdx = new Object();
	
	//IP_USN
	var u_arrPointX = new Array();
	var u_arrPointY = new Array();
	var u_arrPointId = new Array();
	var u_arrPointNm = new Array();
	var u_arrPointSt = new Array();
	var u_arrPointRiverDiv = new Array();
	var u_arrPointIdx = new Object();
	
	//수질자동측정
	var a_arrPointX = new Array();
	var a_arrPointY = new Array();
	var a_arrPointId = new Array();
	var a_arrPointNm = new Array();
	var a_arrPointSt = new Array();
	var a_arrPointRiverDiv = new Array();
	var a_arrPointIdx = new Object();
	
	//변경기록
	var pointX = new Array();
	var pointY = new Array();
	var pointId = new Array();
	var pointCnt = 0;
	/*
	국가수질자동측정망 좌표 
	*/
	<c:forEach items="${a_coordData}" var="a_coordData"  varStatus="status">
		a_arrPointX[${status.index}] = ${a_coordData.coord_x};
		a_arrPointY[${status.index}] = ${a_coordData.coord_y};
		a_arrPointSt[${status.index}] = 0;
		a_arrPointId[${status.index}] = '${a_coordData.fact_code}_${a_coordData.branch_no}';
		a_arrPointNm[${status.index}] = '${a_coordData.branch_name}-${a_coordData.branch_no}';
		a_arrPointRiverDiv[${status.index}] = '${a_coordData.river_div}';
		a_arrPointIdx['${a_coordData.fact_code}_${a_coordData.branch_no}'] = ${status.index};
	</c:forEach>
	
	/*
	탁수 모니터링 좌표 
	*/
	<c:forEach items="${t_coordData}" var="t_coordData"  varStatus="status">
		arrPointX[${status.index}] = ${t_coordData.coord_x};
		arrPointY[${status.index}] = ${t_coordData.coord_y};
		arrPointSt[${status.index}] = 0;
		arrPointId[${status.index}] = '${t_coordData.fact_code}_${t_coordData.branch_no}';
		arrPointNm[${status.index}] = '${t_coordData.branch_name}-${t_coordData.branch_no}';
		arrPointRiverDiv[${status.index}] = '${t_coordData.river_div}';
		arrPointIdx['${t_coordData.fact_code}_${t_coordData.branch_no}'] = ${status.index};
	</c:forEach>
	
		
	/*
	  IP- USN 좌표
	 */
	<c:forEach items="${u_coordData}" var="u_coordData"  varStatus="status">
		u_arrPointX[${status.index}] = ${u_coordData.coord_x};
		u_arrPointY[${status.index}] = ${u_coordData.coord_y};
		u_arrPointSt[${status.index}] = 0;
		u_arrPointId[${status.index}] = '${u_coordData.fact_code}_${u_coordData.branch_no}';
		u_arrPointNm[${status.index}] = '${u_coordData.branch_name}-${u_coordData.branch_no}';
		u_arrPointRiverDiv[${status.index}] = '${u_coordData.river_div}';
		u_arrPointIdx['${u_coordData.fact_code}_${u_coordData.branch_no}'] = ${status.index};
	</c:forEach>


	var isSelected = false;

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
		var left = nLeft+objArea.offsetLeft-5;
		var top  = nTop+objArea.offsetTop-5;
		
		var alt = sNm;
		var id  = sId;
		
		//var tgStrImg = "<img src='"+testImg.src+"' id='img_"+testImg.id+"' onClick='' onMouseOver='' style='cursor:hand; position:absolute; top:"+testImg.style.top+"; left:"+testImg.style.left+"; dispaly:; z-index:2;' alt='"+testImg.alt+"["+testImg.id+"]'></img>";
		//var tgStrImg = "<img src='"+testImg.src+"' id='img_"+testImg.id+"' onClick='alert(\""+testImg.alt+"["+testImg.id+"]\")' onMouseOver='showData(\""+testImg.style.top+"\",\"" +testImg.style.left+ "\",\"" + sId + "\",\"" + sNm + "\")' onMouseOut='hideData()'  style='cursor:hand; position:absolute; top:"+testImg.style.top+"; left:"+testImg.style.left+"; dispaly:; z-index:2;' alt='"+testImg.alt+"["+testImg.id+"]'></img>";
		var tgStrImg = "<img src='"+src+"' id='img_"+id+"' onClick='selectIcon(\""+nTop+"\",\"" +nLeft+ "\",\""+id+"\",\"" + sNm+  "\")' onMouseOver='showData(\""+nTop+"\",\"" +nLeft+ "\",\"" + sId + "\",\"" + sNm + "\")' onMouseOut='hideData()' style='cursor:hand; position:absolute; top:"+top+"px; left:"+left+"px; dispaly:; z-index:2;' alt='"+alt+"["+id+"]'></img>";
		//var tgStrImg = "<img src='"+testImg.src+"' id='img_"+testImg.id+"' onClick='' onMouseOver='' style='cursor:hand; position:absolute; top:"+(document.getElementById('baseMap').style.top.value+testImg.style.top)+"; left:"+(document.getElementById('baseMap').style.left.value+testImg.style.left)+"; dispaly:; z-index:2;' alt='"+testImg.alt+"["+testImg.id+"]'></img>";
		
		
		//var tgStrImg = "<img src='"+testImg.src+"' id='img_"+testImg.id+"' onClick='' onMouseOver='' style='cursor:hand; position:absolute; top:"+(objArea.style.top+testImg.style.top.value)+"; left:"+(objArea.style.left.value+testImg.style.left)+"; dispaly:; z-index:2;' alt='"+testImg.alt+"["+testImg.id+"]'></img>";
		//objArea.insertAdjacentHTML('beforeEnd', tgStrImg);
		$("#objectBox").append(tgStrImg);
	}
	
	//next, prev 버튼도 위치 맞춰줌
	function nextBtnLeftSet()
	{
		objArea = document.getElementById('objectBox');
		var river = $("#river").val();
		var left = objArea.offsetLeft;
		var top = objArea.offsetTop;
		
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
	
	// 아이콘 초기화
	function InitPoint(pageMove)
	{
		if(pageMove == null) 
		{
			pointX = new Array();
			pointY = new Array();
			pointId = new Array();
			pointCnt = 0;
			
			selectedIconId = "";
			selectedIconNm = "";
			isSelectChange = false;
			
			unSelectIcon();
		}
		
		var river = $('#river').val();
		var sys = $('#sys').val();
		
		$("#objectBox").html("");
		
		var imgFile = river;
		
		if(page == 1)
			imgFile = river + "_2";
		
		$("#objectBox").html("<img src='<c:url value='/images/content/"+ imgFile +".jpg'/>' width='100%' height='100%' style='cursor:crosshair'/>");
		
		if(sys == "T")
			{
				for (i = 0  ; i < arrPointId.length ; i++){
					
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
				for (i = 0 ; i < a_arrPointId.length ; i++){
					
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
			
		$("#loadingDiv").dialog("close");
	}
		// 윈도우 리사이즈시 호출됨.
	jQuery(window).resize(function(){
		//showData(viewType);
		//InitPoint();
	});
	
	function riverMapOver(e)
	{
		var event = e||window.event;
		
		objArea = document.getElementById('objectBox');
		
		var scroll = getNowScroll();
		
		var left = event.clientX - objArea.offsetLeft + scroll.X;// + 10;//event.offsetX+objArea.offsetLeft-10;
		var top = event.clientY - objArea.offsetTop + scroll.Y;// + 10;//event.offsetY+objArea.offsetTop-10;
		
		$("#overCoord").text("X: " + left + ", Y: " + top);
	}
	
	function riverMapClick(e)
	{
		var event = e||window.event;
		
		objArea = document.getElementById('objectBox'); 
		
		//alert("offsetLeft : " + objArea.offsetLeft);
		//alert("offsetTop : " + objArea.offsetTop);
		
		//alert("offsetX : " + event.offsetX);
		//alert("offsetY : " + event.offsetY);
		
		var scroll = getNowScroll();
		
		var left = event.clientX - objArea.offsetLeft + scroll.X;// + 10;//event.offsetX+objArea.offsetLeft-10;
		var top = event.clientY - objArea.offsetTop + scroll.Y;// + 10;//event.offsetY+objArea.offsetTop-10;
		
		SetAddIcon(left, top, "", "", "");
	}
	
	function getNowScroll(){
		
		var de = document.documentElement;
		var b = document.body;
		var now = {};
		
		now.X = document.all ? (!de.scrollLeft ? b.scrollLeft : de.scrollLeft) : (window.pageXOffset ? window.pageXOffset : window.scrollX);
		now.Y = document.all ? (!de.scrollTop ? b.scrollTop : de.scrollTop) : (window.pageYOffset ? window.pageYOffset : window.scrollY);
		
		return now;
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
						//alert(objImg);
						
						var result = "<c:url value='/images/popup/bu_circle_'/>";
						
						if (nSt == 0){
							objImg.src =  result += "green.gif";
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
					else
					{
						a_arrPointSt[i] = nSt;
					}
				}
			}
		}
	}
	
	var selectedIconId = "";
	var selectedIconNm = "";
	var isSelectChange = false;
	
	//아이콘 선택 관련
	function selectIcon(top, left, id, nm)
	{
		if(selectedIconId == id)
		{
			ChangePoint(id, 0);
			selectedIconId = "";
			selectedIconNm = "";
			isSelected = false;
			unSelectIcon();
		}
		else
		{
			ChangePoint(id, 4);
			
			if(selectedIconId != "")
				ChangePoint(selectedIconId, 0);
			
			selectedIconId = id;
			selectedIconNm = nm;
			
			isSelected = true;
			isSelectChange = true;
			
			selectedIcon(top, left, id, nm);
		}
	}
	
	function keyControl(e)
	{
		if(isSelected == true)
		{
			var event = e||window.event;
			
			if(event.keyCode != null && event != undefined)
			{
				var keycode = event.keyCode;
				
				var left = $("#img_" + selectedIconId).css("left");
				var top = $("#img_" + selectedIconId).css("top");
				
				var nLeft = eval(left.replace("px",""));
				var nTop = eval(top.replace("px",""));	
				
				nLeft = nLeft-objArea.offsetLeft+5;
				nTop = nTop-objArea.offsetTop+5;
				
				if(keycode == "38")//UP
				{
					nTop -= 1;
				}
				else if(keycode == "40") //DOWN
				{
					nTop += 1;
				}
				else if(keycode == "37") //LEFT
				{
					nLeft -= 1;
				}
				else if(keycode == "39") //RIGHT
				{
					nLeft += 1;
				}
				
				SetAddIcon(nLeft, nTop, "", "", "", true);
			}
		}
	}
	
	//이동할 곳에 아이콘 표시
	function SetAddIcon(nLeft, nTop, sNm, sId, nSt, moveKey){
		
		//선택된 아이콘이 있을 때
		if(isSelected == true && isSelectChange == false)
		{
			if(selectedIconId != "")
			{
				sId = selectedIconId;
				
				if(moveKey == true)
					ChangePoint(selectedIconId, 4);
				else 
					ChangePoint(selectedIconId, 0);
				
				//위치변경
				objArea = document.getElementById('objectBox');
				
				var left = nLeft+objArea.offsetLeft-5;
				var top  = nTop+objArea.offsetTop-5;
				
				
				$("#img_" + selectedIconId).css("left", left + "px");
				$("#img_" + selectedIconId).css("top", top + "px");
				
				
				//리사이즈시 위치 적용
				var sys = $("#sys").val();
				
				nTop = (page * 1000) + nTop;
				
				if(sys == "A")
				{
					var idIdx = a_arrPointIdx[sId];
					a_arrPointX[idIdx] = nLeft;
					a_arrPointY[idIdx] = nTop;
				}
				else if(sys == "T")
				{
					var idIdx = arrPointIdx[sId];
					arrPointX[idIdx] = nLeft;
					arrPointY[idIdx] = nTop;
				}
				else if(sys == "U")
				{
					var idIdx = u_arrPointIdx[sId];
					u_arrPointX[idIdx] = nLeft;
					u_arrPointY[idIdx] = nTop;
				}
				
				var icon = document.getElementById("img_" + selectedIconId);
				
				if(icon == null)
				{
					var tmpTop = nTop - (page * 1000);
					//SetWichi(nLeft, tmpTop, selectedIconNm, selectedIconId, 4)
					SetWichi(nLeft, tmpTop, selectedIconNm, selectedIconId, 0);
				}
				
				//이벤트 수정
				var tmpId = selectedIconId;
				var tmpNm = selectedIconNm;
				
				$("#img_" + selectedIconId).attr("onMouseOver", "");
				$("#img_" + selectedIconId).unbind("mouseover");
				
				$("#img_" + selectedIconId).bind('mouseover',  function() {
					showData(nTop, nLeft, tmpId, tmpNm);
				});
				
				$("#img_" + selectedIconId).attr("onClick", "");
				$("#img_" + selectedIconId).unbind("click");
				
				$("#img_" + selectedIconId).bind('click', function() {
					selectIcon(nTop, nLeft, tmpId, tmpNm);
				});
				
				$("#selectedCoord").text("X: " + nLeft + ", Y: " + nTop);
				
				//변경된  리스트
				saveDataList(nLeft, nTop, tmpId);
				
				if(moveKey != true)
				{
					selectIcon(nTop, nLeft, tmpId, tmpNm);
//					unselectIcon();
					isSelected = false;
				}
			}
			/*
			$("#addIcon").show();
			var result = "<c:url value='/images/common/btn_enlarge.gif'/>";
			
			var left = nLeft+objArea.offsetLeft-8;
			var top = nTop+objArea.offsetTop-8;
			var alt = sNm;
			var id = sId;
			
			var addIcon = $("#addIcon");
			
			if(addIcon.attr("src") == undefined)
			{
				tgStrImg = "<img src='"+result+"' id='addIcon'  style='cursor:hand; position:absolute; top:"+top+"px; left:"+left+"px; dispaly:; z-index:99;' alt='"+alt+"["+id+"]'></img>";
				$("#objectBox").append(tgStrImg);
			}
			else
			{
				addIcon.css("top", top+"px");
				addIcon.css("left", left+"px");
			}
			*/
		}
		
		isSelectChange = false;
	}
	
	function showData(top, left, sId, sNm)
	{
		$("#overBranch").text(sNm);
		$("#overCoord").text("X: " + left + ", Y: " + top);
	}
	
	function hideData()
	{
		$("#overBranch").text("-");
		$("#overCoord").text("-");
	}
	
	function selectedIcon(top, left, sId, sNm)
	{
		$("#selectedBranch").text(sNm);
		$("#selectedCoord").text("X: " + left + ", Y: " + top);
	}
	
	function unSelectIcon()
	{
		$("#selectedBranch").text("-");
		$("#selectedCoord").text("-");
	}
	
	function saveDataList(left, top, id)
	{
		for(var idx = 0 ; idx < pointCnt ; idx++)
		{
			if(id == pointId[idx])
			{
				pointX[idx] = left;
				pointY[idx] = top;
				return;
			}
		}
		
		pointX[pointCnt] = left;
		pointY[pointCnt] = top;
		pointId[pointCnt] = id;
		
		pointCnt++;
	}
	
	function cancel()
	{
		var sys = $("#sys").val();
		var river = $("#river").val();
		
		window.location = "<c:url value='/waterpolmnt/situationctl/goWatersysMntCoordMng.do'/>?sys=" + sys + "&river_div=" + river;
	}
	
	function save()
	{
		if(pointCnt == 0)
		{
			alert('변경내용이 없습니다!');
			return;
		}
		
		showLoading();
		
		for(var idx = 0;idx<pointCnt;idx++)
		{
			var tmpId = pointId[idx];
			var x = pointX[idx];
			var y = pointY[idx];
			
			var fact_code = tmpId.split('_')[0];
			var branch_no = tmpId.split('_')[1];
			
			$.getJSON("<c:url value='/waterpolmnt/situationctl/updateWaterSysMnt_coord.do'/>",
					{coord_x: x, coord_y:y, fact_code:fact_code, branch_no:branch_no},
					function (data, status){
						if(status == 'success'){
							saveSuccess();
						} else {
							alert(status);
							return;
						}
					}
				);
		}
	}
	
	var saveCnt = 0;
	function saveSuccess()
	{
		saveCnt++;
		
		if(saveCnt == pointCnt)
		{
			var sys = $("#sys").val();
			var river = $("#river").val();
			var param = "sys=" + sys + "&river_div=" + river;
			
			opener.window.location = "<c:url value='/waterpolmnt/situationctl/goWATERSYSMNT.do'/>?" + param;
			window.location = "<c:url value='/waterpolmnt/situationctl/goWatersysMntCoordMng.do'/>?" + param;
		}
	}
	
	//수계 맵 다음 페이지로
	function riverMapNext()
	{
		page = 1;
		
		var river = $("#river").val();
		
		if(river == "R02" || river == "R01")
		{
			$("#btnNext").hide();
			$("#btnPrev").show();
		}
		
		$("#alphaDiv").fadeOut('fast');
		
		InitPoint(true);
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
		
		InitPoint(true);
	}
</script>
</head>

<body class="subPop" onkeydown="keyControl(event)"><!-- 추가 및 수정 -->
	<div id='loadingDiv'>
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div id="infoDiv" style="font-size:9pt;background-color:white;width:165px;height:60px;border:solid 1px #aaaaaa;display:none;position:absolute">
		<table id="divDataTable" class="dataTable" style="height:60px">
			<thead id="divDataHeader">
				<tr>
					<th scope="col">측정소</th>
				</tr>
			</thead>
		<tbody id="divDataList">
			<tr>
				<td><span id="divBranch"></span></td>
			</tr>
		</tbody>
		</table>
	</div>
	<div class="headerWrap">
		<div class="headerBg_r">
			<div class="header">
				<h1 style='font-size:large;font-weight:bold;color:white'>모식도</h1>
			</div>
		</div>
	</div>
	<div class="contentWrap">
		<div class="contentBg_r">
			<div class="contentBox">
				<div class="contentPad" style="height:780px"><!-- //추가 및 수정 -->
					<div class="totalmntPop1" style="padding-top:20px;height:100%;width:100%;">
						<div>
							<ul class="selectList">
								<li><span class="buArrow_tit">시스템</span> 
									<select id="sys">
										<!-- <option value="T">탁수모니터링</option> -->
										<option value="U">이동형측정기기</option>
										<option value="A">국가수질자동측정망</option>
									</select>
								</li>
								<li>&nbsp;&nbsp;<span class="buArrow_tit">수계</span> 
									<select id="river">
										<option value="R01">한강</option>
										<option value="R02">낙동강</option>
										<option value="R03">금강</option>
										<option value="R04">영산강</option>
									</select>
								</li>
							</ul>
							
							<img id='btnNext' onclick='riverMapNext()' src="<c:url value='/images/waterpolmnt/arrow_down.png'/>" style='z-index:11;position:absolute;top:460px;float:right;cursor:pointer;display:block''/>
							<img id='btnPrev' onclick='riverMapPrev()' src="<c:url value='/images/waterpolmnt/arrow_up.png'/>" style='z-index:11;position:absolute;top:460px;float:left;cursor:pointer;display:block'/>
							
							<div id="objectBox" style="padding-top:0px;border:solid 1px #ccc;height:698px;width:240px;float:left" onmousemove='riverMapOver(event)' onclick='riverMapClick(event)'>
								<img id='riverMapImg' src="<c:url value='/images/content/R01.jpg'/>" width="100%" height="100%"/>
							</div>
							<div style="border:solid 0px white;float:right;width:193px">
								▷ Selected 
								<table id="divDataTable" class="dataTable" style="height:60px">
									<thead id="divDataHeader">
										<tr>
											<th scope="col">측정소</th>
											<th scope="col">좌표</th>
										</tr>
									</thead>
									<tbody id="divDataList">
										<tr>
											<td><span id="selectedBranch">-</span></td>
											<td><span id="selectedCoord">-</span></td>
										</tr>
									</tbody>
								</table>
								<br/>
								▷ Mouse Over 
								<table id="divDataTable" class="dataTable" style="height:60px">
									<thead id="divDataHeader">
										<tr>
											<th scope="col">측정소</th>
											<th scope="col">좌표</th>
										</tr>
									</thead>
									<tbody id="divDataList">
										<tr>
											<td><span id="overBranch">-</span></td>
											<td><span id="overCoord">-</span></td>
										</tr>
									</tbody>
								</table>
								<br/>
								<ul class="selectList">
									<li><a href="javascript:save()"><img src="<c:url value='/images/common/btn_save2.gif'/>" alt="저장" align="top"/></a></li>
									<li><a href="javascript:cancel()"><img src="<c:url value='/images/common/btn_cancel2.gif'/>" alt="취소" /></a></li>
								</ul>
							</div>
						</div>
					</div>
				</div><!-- 추가 및 수정 -->
			</div>
		</div>
	</div>
	<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div><!-- //추가 및 수정 -->
	<form name="smsPopupForm" method="post" action="/cmmn/alertSmsSend.do">
		<input type="hidden" name="sugye"/>
		<input type="hidden" name="factCode"/>
		<input type="hidden" name="factName"/>
		<input type="hidden" name="weatherName"/>
	</form>
</body>
</html>