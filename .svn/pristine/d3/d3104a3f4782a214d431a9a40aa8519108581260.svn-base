<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<c:set var="river_div" scope="request" value="${param.param}"/>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템-수계별통합감시</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />
	<script src="<c:url value='/js/JQuery/jquery-1.3.2.min.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js" type="text/javascript'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>
	
	<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.datepicker.js'/>"></script>
	
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
		val = new Number(val).toFixed(1) + "";

		return val;
	}
	
	//탁도 그래프 표시
	function setTurChart(val, sq, or_val, factCode, branchNo)
	{
		if(val == null || val == "-" || val == "")
		{
			$('#turGauge' + sq).hide();
			$("#tur_val" + sq).text("");
		}
		else
		{ 
			val = valRound(val);

			var src = "<c:url value='/waterpolmnt/situationctl/getTurGauge.do'/>?fact_code="+factCode+"&branch_no="+branchNo+"&width=160&height=25&minVl=" + val + "&lawVl=50&minOr=" + or_val;
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
	function setEcChart(val, sq, or_val, factCode, branchNo)
	{
		if(val == null || val == "-" || val == "")
		{
			$("#ecGauge" + sq).hide();
			$("#ec_val" + sq).text("");
		}
		else
		{
			val = valRound(val);
			
			var src = "<c:url value='/waterpolmnt/situationctl/getEcGauge.do'/>?fact_code="+factCode+"&branch_no="+branchNo+"&width=160&height=25&minVl=" + val + "&lawVl=0.4&minOr=" + or_val;
			$("#ecGauge" + sq).show();
			$("#ecGauge" + sq).attr("src", src);
			$("#ec_val" + sq).text(val);
		}

		setOrImg(or_val, 'ec', sq);
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

	
	//상단에 표시할 데이터 셋팅
	function setTopData(idx, factCode, branchNo){	

		if(resultObj != null)
		{
			var sys = $("#sys").val();

			var rowData = resultObj[idx];

			if(rowData != null)
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
						setTurChart(rowData.tur, getIdx, rowData.tur_or, factCode, branchNo);
						setTmpChart(rowData.tmp, getIdx, rowData.tmp_or, factCode, branchNo);
						setPhChart(rowData.phy, getIdx, rowData.phy_or, factCode, branchNo);
						setDoChart(rowData.dow,getIdx, rowData.dow_or, factCode, branchNo);
						setEcChart(rowData.con, getIdx, rowData.con_or, factCode, branchNo);

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
						setTurChart(rowData.tur, incIdx, rowData.tur_or, factCode, branchNo);
						setTmpChart(rowData.tmp, incIdx, rowData.tmp_or, factCode, branchNo);
						setPhChart(rowData.phy, incIdx, rowData.phy_or, factCode, branchNo);
						setDoChart(rowData.dow, incIdx, rowData.dow_or, factCode, branchNo);
						setEcChart(rowData.con, incIdx, rowData.con_or, factCode, branchNo);

						getWeatherInfo(rowData.fact_code, branchNo, incIdx);
						
						incIdx++;
					}
				}

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

	function setTopFactName(fact_name)
	{
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
		refresh();	//데이터 부러오기
		riverMapReload();	//수계맵 초기화
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
	
	var riverMapDataOr = new Object();
	var riverMapDataOr_con = new Object();
	var riverMapDataOr_tmp = new Object();
	var riverMapDataOr_dow = new Object();
	var riverMapDataOr_phy = new Object();

	var riverMapBranch = new Object();
	
	function refresh(){
		
		var river = $('#river').val();
		var sys = $('#sys').val();

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
			url:"<c:url value='/waterpolmnt/situationctl/getWATERSYSMNT.do'/>",
			data:{sys:sys,
				river:river},
			dataType:"json",
			success:function(result){

				resultObj = result['refreshData'];
				
	            var tot = result['refreshData'].length;
				var trClass;

				
	            $("#dataList").html("");
	
	            if( tot <= "0" ){
	            	$("#dataList").html("<tr><td colspan='"+(itemCnt + 5)+"'>조회 결과가 없습니다</td></tr>");		
	            	setWeatherData("no");	 
					resultObj=null;
					 //for(var i=0; i<50; i++){
					//$("#dataList").append("<tr code=1234 branchNo='1'><td colspan='"+(itemCnt + 5)+"'>"+i+"조회 결과가 없습니다</td></tr>");
				    // }	
					 $("#loadingDiv").dialog("close");
	            }else{
					
	            	var idx = 0;
	    			for(var i=0; i < tot; i++){
	    				
	    				var obj = result['refreshData'][i];
	                    var item;
	                    var subItem;

	                    //var branchName = obj.fact_name;
	                    var maxor = obj.tur_or;
	                    ChangePoint(obj.fact_code + "_" + obj.branch_no, 0);
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
						}
						

						riverMapData[obj.fact_code + "_" + obj.branch_no] = obj.tur;
						riverMapData_tmp[obj.fact_code + "_" + obj.branch_no] = obj.tmp;
						riverMapData_phy[obj.fact_code + "_" + obj.branch_no] = obj.phy;
						riverMapData_dow[obj.fact_code + "_" + obj.branch_no] = obj.dow;
						riverMapData_con[obj.fact_code + "_" + obj.branch_no] = obj.con;
						
						riverMapDataOr_tmp[obj.fact_code + "_" + obj.branch_no] = obj.tmp_or;
						riverMapDataOr_phy[obj.fact_code + "_" + obj.branch_no] = obj.phy_or;
						riverMapDataOr_dow[obj.fact_code + "_" + obj.branch_no] = obj.dow_or;
						riverMapDataOr_con[obj.fact_code + "_" + obj.branch_no] = obj.con_or;
						riverMapDataOr[obj.fact_code + "_" + obj.branch_no] = obj.tur_or;
						riverMapBranch[obj.fact_code + "_" + obj.branch_no] = obj.branch_name;
						
						
	                    var factNumber = "";
	                    
	                    if(river == 'R01')
	                    	factNumber = obj.fact_name.replace('한강', '');
	                    else if(river == 'R02')
	                    	factNumber = obj.fact_name.replace('낙동강', '');
	                    else if(river == 'R03')
	                    	factNumber = obj.fact_name.replace('금강', '');
	                    else if(river == 'R04')
	                    	factNumber = obj.fact_name.replace('영산강','');


	                    var onclick = "onclick=\"javascript:chart('"+obj.fact_code+"', '" + obj.branch_no + "', this.id);detailPopup('"+obj.fact_code+"', '" + obj.sys_kind + "', '" + obj.fact_name + "', '" +obj.branch_no+ "')\" style='cursor:pointer'";
	                    
						if(sys == 'A'){
							subItem = "<td class='num' "+onclick+"><span id='phy"+i+"'>" + ((obj.phy == "") ? "-" : obj.phy)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='dow"+i+"'>" + ((obj.dow == "") ? "-" : obj.dow)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='con"+i+"'>" + ((obj.con == "") ? "-" : obj.con)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='tmp"+i+"'>" + ((obj.tmp == "") ? "-" : obj.tmp)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='phy2_"+i+"'>" + ((obj.phy2 == "") ? "-" : obj.phy2)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='dow2_"+i+"'>" + ((obj.dow2 == "") ? "-" : obj.dow2)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='con2_"+i+"'>" + ((obj.con2 == "") ? "-" : obj.con2)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='tmp2_"+i+"'>" + ((obj.tmp2 == "") ? "-" : obj.tmp2)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='tur"+i+"'>" + ((obj.tur == "") ? "-" : obj.tur)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='imp"+i+"'>" + ((obj.imp == "") ? "-" : obj.imp)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='lim"+i+"'>" + ((obj.lim == "") ? "-" : obj.lim)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='rim"+i+"'>" + ((obj.rim == "") ? "-" : obj.rim)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='ltx"+i+"'>" + ((obj.ltx == "") ? "-" : obj.ltx)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='rtx"+i+"'>" + ((obj.rtx == "") ? "-" : obj.rtx)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='tox"+i+"'>" + ((obj.tox == "") ? "-" : obj.tox)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='evn"+i+"'>" + ((obj.evn == "") ? "-" : obj.evn)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='tof"+i+"'>" + ((obj.tof == "") ? "-" : obj.tof)+ "</span></td>"
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
									+"<td class='num' "+onclick+"><span id='cad"+i+"'>" + ((obj.cad == "") ? "-" : obj.cad)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='pul"+i+"'>" + ((obj.pul == "") ? "-" : obj.pul)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='cop"+i+"'>" + ((obj.cop == "") ? "-" : obj.cop)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='zin"+i+"'>" + ((obj.zin == "") ? "-" : obj.zin)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='phe"+i+"'>" + ((obj.phe == "") ? "-" : obj.phe)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='phl"+i+"'>" + ((obj.phl == "") ? "-" : obj.phl)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='toc"+i+"'>" + ((obj.toc == "") ? "-" : obj.toc)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='ton"+i+"'>" + ((obj.ton == "") ? "-" : obj.ton)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='top"+i+"'>" + ((obj.top == "") ? "-" : obj.top)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='nh4"+i+"'>" + ((obj.nh4 == "") ? "-" : obj.nh4)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='no3"+i+"'>" + ((obj.no3 == "") ? "-" : obj.no3)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='po4"+i+"'>" + ((obj.po4 == "") ? "-" : obj.po4)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='rin"+i+"'>" + ((obj.rin == "") ? "-" : obj.rin)+ "</span></td>";
						}else{
							subItem = "<td class='num' "+onclick+"><span id='tur"+i+"'>" + ((obj.tur == "") ? "-" : obj.tur)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='tmp"+i+"'>" + ((obj.tmp == "") ? "-" : obj.tmp)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='phy"+i+"'>" + ((obj.phy == "") ? "-" : obj.phy)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='dow"+i+"'>" + ((obj.dow == "") ? "-" : obj.dow)+ "</span></td>"
									+"<td class='num' "+onclick+"><span id='con"+i+"'>" + ((obj.con == "") ? "-" : obj.con)+ "</span></td>";
						}
	                    
	    				item = "<tr id='"+(i+1)+"' code='"+obj.fact_code+"' branchNo='"+obj.branch_no+ "'>"
				    			+"<td "+onclick+">"+factNumber+"</td>"
								+"<td "+onclick+">"+obj.branch_name+"</td>"+subItem;
	    				
	    				item += "<td>"+obj.min_date +  "  " + obj.min_time+"</td>";
	    				item += "<td><img src=\"<c:url value='/images/common/btn_progress.gif'/>\"  style='cursor:pointer' onclick=\"transitionPopup('" + obj.fact_code + "', '" + obj.branch_no + "')\" alt='추이' /></td>";
	    				item += "<td><img src=\"<c:url value='/images/common/btn_map.gif'/>\" style='cursor:pointer' onclick=\"mapPopup('" + obj.fact_code + "', '" + obj.branch_no + "')\" alt='지도' /></a></td></tr>";


	    				$("#dataList").append(item);
	    				$('#dataList').hover(stopScroll, startScroll);

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
	            }

	            AutoScroll();

	            $("#loadingDiv").dialog("close");
	          //TR색 변경
	          //  $("#dataList tr:nth-child(even)").addClass("add");
			},
	        error:function(result){
				$("#dataList").html("<tr><td colspan='"+(itemCnt + 5)+"'>서버 접속에 실패하였습니다!</td></tr>");	
				$("#loadingDiv").dialog("close");
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
		var sw=screen.width;var sh=screen.height;
		var winHeight = 890;
		var winWidth = 1260;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;


		var src = "<c:url value='/waterpolmnt/situationctl/goWatersysMntMainDetail.do'/>?fact_code="+fact_code+"&branch_no=" +branch_no + "&sys_kind=" + sys_kind + "&fact_name=" + encodeURI(fact_name);

		window.open(src,   
				'WatersysMntMainDetail','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
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




function chart(factCode, branchNo, tr_id){
	//차트변경시 Top Data변경
	
	if(factCode == null || factCode == "undefined") { factCode = ""; return;}
	if(branchNo==null ||  branchNo == "undefined") { branchNo = "1"; return; }
	var cnt;											
	var itemCode;
	var width=200;
	var height=25;
	var sysKind = $('#sys').val();
	var riverDiv = $('#river').val();

	 var src = "<c:url value='/waterpolmnt/situationctl/getRiverGaugeChart.do'/>?riverDiv="+riverDiv+"&sysKind="+sysKind+"&itemCode="
	  +itemCode+"&itemName="+'TUR'+"&width="+width+"&height="+height+"&factCode="+factCode+"&branchNo="
	  +branchNo;		

	  $("#testGauge").attr("src", src);
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


function getWeatherInfo(factCode, branchNo,  sq)
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
			case "약진눈개비":
			case "강진눈개비":
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

/********************************************************/
// 왼쪽 수계표 관련 
/********************************************************/

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
<c:forEach items="${a_coordData}"  var="a_coordData"  varStatus="status">
	a_arrPointX[${status.index}] = ${a_coordData.coord_x};  
	a_arrPointY[${status.index}] = ${a_coordData.coord_y};  
	a_arrPointSt[${status.index}] = 5;   
	a_arrPointId[${status.index}] = '${a_coordData.fact_code}_${a_coordData.branch_no}';   
	a_arrPointNm[${status.index}] = '${a_coordData.branch_name}-${a_coordData.branch_no}'   ;	
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
	arrPointNm[${status.index}] = '${t_coordData.branch_name}-${t_coordData.branch_no}'   ;	
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
	u_arrPointNm[${status.index}] = '${u_coordData.branch_name}-${u_coordData.branch_no}'   ;	
	u_arrPointRiverDiv[${status.index}] = '${u_coordData.river_div}'
	u_arrPointMap['${u_coordData.fact_code}_${u_coordData.branch_no}'] = ${status.index};
</c:forEach>


function SetWichi(nLeft, nTop, sNm, sId, nSt){

	var result = "<c:url value='/images/popup/bu_circle_'/>";
	
   //testImg = new Image();
   var src;
   
    if (nSt == 0)
        src        = result += "green.gif";
    else if (nSt == 1)
    	src        =  result += "blue.gif";
    else if (nSt == 2)
    	src        = result += "yellow.gif";
    else if (nSt == 3)
    	src        = result += "orange.gif";
    else if (nSt == 4)
        src			= result += "red.gif";
    else src        = result += "black.gif";

    objArea = document.getElementById('objectBox');
    //objArea = $("#objectBox");
    //testImg.style.left = nLeft+objArea.offsetLeft-15;
    //testImg.style.top  = nTop+objArea.offsetTop-10;
    //testImg.alt        = sNm;
    //testImg.id         = sId;
    var left = nLeft+objArea.offsetLeft-5;
    var top  = nTop+objArea.offsetTop-5;

    var alt        = sNm;
    var id         = sId;

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
	    
    var left = objArea.offsetLeft;

	$("#alphaDiv").css("left", left);
	$("#btnNext").css("left", left+225);
	$("#btnPrev").css("left", left);
}

//투명창 이동
var moveAlphaDiv;

function alphaDivMove(topCoord)
{
	//현재 페이지에 해당하는 측정소일때만 투명창  표시
	if(topCoord >= (page*1000) && topCoord <= ((page+1) * 1000))
	{
		objArea = document.getElementById('objectBox');
	    var top  = topCoord+objArea.offsetTop-25;

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
			        	objImg.src        =  result += "green.gif";
			        }else if (nSt == 1){
			        	objImg.src        = result += "blue.gif";
		 	    	}else if (nSt == 2){
			        	objImg.src        = result += "yellow.gif";
		 	    	}else if (nSt == 3){
			        	objImg.src        = result += "orange.gif";
		 	    	}
		 	    	else if (nSt == 4){
			        	objImg.src        = result += "red.gif";
		 	    	}
		 	    	else
		 	    		objImg.src 		  = result += "black.gif";
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
			        	objImg.src        =  result += "green.gif";
			        }else if (nSt == 1){
			        	objImg.src        = result += "blue.gif";
		 	    	}else if (nSt == 2){
			        	objImg.src        = result += "yellow.gif";
		 	    	}else if (nSt == 3){
			        	objImg.src        = result += "orange.gif";
		 	    	}
		 	    	else if (nSt == 4){
			        	objImg.src        = result += "red.gif";
		 	    	}
		 	    	else
		 	    		objImg.src 		  = result += "black.gif";
	 	    		
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
			        	objImg.src        =  result += "green.gif";
			        }else if (nSt == 1){
			        	objImg.src        = result += "blue.gif";
		 	    	}else if (nSt == 2){
			        	objImg.src        = result += "yellow.gif";
		 	    	}else if (nSt == 3){
			        	objImg.src        = result += "orange.gif";
		 	    	}
		 	    	else if (nSt == 4){
			        	objImg.src        = result += "red.gif";
		 	    	}
		 	    	else
		 	    		objImg.src 		  = result += "black.gif";
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
	

	var l = eval(left.replace("px", "")) + 20;
	var t = eval(top.replace("px", "")) + 10;

	$("#divBranch").text(branch);
	$("#divData").text(data);
	$("#divData_tmp").text(tmp);
	$("#divData_dow").text(dow);
	$("#divData_con").text(con);
	$("#divData_phy").text(phy);
	
	$("#infoDiv").css("top", t);
	$("#infoDiv").css("left", l);
	$("#infoDiv").fadeIn('normal');
	$("#infoDiv").css("z-index", '99');
	
	setMinOr_Color(or, $("#divData"));
	setMinOr_Color(tmpor, $("#divData_tmp"));
	setMinOr_Color(dowor, $("#divData_dow"));
	setMinOr_Color(conor, $("#divData_con"));
	setMinOr_Color(phyor, $("#divData_phy"));
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
	
	var sw=screen.width;var sh=screen.height;
	var winHeight = 850;
	var winWidth = 500;
	var winLeftPost = (sw - winWidth) / 2;
	var winTopPost = (sh - winHeight) / 2;


	var src = "<c:url value='/waterpolmnt/situationctl/goWatersysMntCoordMng.do'/>?river_div="+river;

	window.open(src,   
			'WatersysMntMainDetail','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
</sec:authorize>
}

function riverPageBtnInit()
{
	var river = $("#river").val();
	
	if(river == "R02")
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

	if(river == "R02")
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

	if(river == "R02")
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
	var sw=screen.width;var sh=screen.height;
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
function mapPopup(factCode, branchNo)
{
	var sw=screen.width;var sh=screen.height;
	var winHeight = 825;
	var winWidth = 1000;
	var winLeftPost = (sw - winWidth) / 2;
	var winTopPost = (sh - winHeight) / 2;

	var param = "fact_code=" + factCode + "&branch_no=" +  branchNo;
	
	var src = "<c:url value='/waterpolmnt/situationctl/goWatersysMntMapPopup.do'/>?" + param;

	window.open(src,   
			'watersysMntMap','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
}


</script>		
</head>

<body class="popup">
<div id='loadingDiv'>
	<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />	
</div>
<div id="infoDiv" style="z-index;10;font-size:9pt;background-color:white;width:395px;height:60px;border:solid 1px #aaaaaa;display:none;position:absolute">
	<table id="divDataTable" class="dataTable" style="height:60px">
		<colgroup>
			<col width="90px" />
			<col width="" />
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
<div id="wrap" class="mainPop"> 
	<div class="pop_header">
		<div class="bg_header_r">
			<div class="bg_header">
				<h1 class="pop_tit"><img src="<c:url value='/images/popup/h1_watersysmnt.gif'/>" alt="수계별통합감시" /></h1>
				<p class="dateTime" id="currDate">[ 최종수신일자: 2010.07.05 ]</p> 
			</div>
		</div>
	</div>
	<div class="pop_container">
		<div class="pop_container_r">
	<div id="container">
		<!-- content -->
		<div id="content" class="sub_waterpolmnt">
			<div class="content_wrap page_situationctl">
				<div class="inner_watersysmnt">
					<div class="watersysmnt_wrap">
						<div class="data_graph">
							<div class="data">
								<p>
									<select id="river" style="width:85px">
										<option value="R01">한강</option>
										<option value="R02">낙동강</option>
										<option value="R03">금강</option>
										<option value="R04">영산강</option>
									</select>
									<select id="sys" style="width:153px">
										<option value="T">탁수 모니터링</option>
										<option value="U">이동형측정기기</option>
										<option value="A">국가수질자동측정망</option>
									</select>
								</p>
								<!-- 
								<ul class="radio_area">
										<li class="first">
											<input type="radio" class="inputRadio" checked="checked" name="radio_item"/>
											<label for="">탁도</label>
										</li>
										<li>
											<input type="radio" class="inputRadio" name="radio_item"/>
											<label for="">수온</label>
										</li>
										<li>
											<input type="radio" class="inputRadio" name="radio_item"/>
											<label for="">pH</label>
										</li>
										<li>
											<input type="radio" class="inputRadio" name="radio_item"/>
											<label for="">DO</label>
										</li>
										<li>
											<input type="radio" class="inputRadio" name="radio_item"/>
											<label for="">EC</label>
										</li>
									</ul>
									-->
									<ul class="radio_area">
										<li class="first">
											&nbsp;
										</li>
									</ul>
							</div>
							<div id="alphaDiv" style="background-color:gray;width:242px;height:50px;position:absolute;top:220;opacity:0.35;filter:alpha(style=0, opacity=35, finishopacity=0)">&nbsp;</div>
							
							<img id='btnNext' onclick='riverMapNext()' src="<c:url value='/images/waterpolmnt/btn_next.gif'/>" style='z-index:11;position:absolute;top:460px;float:right;cursor:pointer;display:block''/>
							<img id='btnPrev' onclick='riverMapPrev()' src="<c:url value='/images/waterpolmnt/btn_prev.gif'/>" style='z-index:11;position:absolute;top:460px;float:left;cursor:pointer;display:block'/>
							
							<div class="objectBox" id="objectBox" style="padding-top:0px;border:solid 1px #ccc;height:698px;width:240px" onclick='riverMapClick(event)'>
									<img id='riverMapImg' src="<c:url value='/images/content/R01.jpg'/>"/>
									<!--
									<object type="application/x-shockwave-flash" data="<c:url value='/images/flash/river_object.swf'/>"  width="242" height="731">
										<param name="movie" value="<c:url value='/images/flash/river_object.swf'/>" />
										<param name="wmode" value="transparent" />
									</object>
									  -->
							</div>
						</div>
						<div class="watersysmnt_con">
							<!--
							<div class="roundBox roundBox1 firstBox">
								<div class="top_l"><div class="top_r"><div class="top"></div></div></div>
								<div class="con">
									<div class="con_r">
										<div class="lastList">
											<dl>
												<dt>항목</dt>
												<dd>
													<ul class="checkList">
														<li id="liTUR" >
															<input id="chkTUR" type="checkbox" class="inputCheck" checked/> <label for="">탁도</label>
														</li>
														<li id="liDOW">
															<input id="chkDOW" type="checkbox" class="inputCheck" checked/> <label for="">DO</label>
														</li>
														<li id="liTMP">
															<input id="chkTMP" type="checkbox" class="inputCheck" checked/> <label for="">수온</label>
														</li>
														<li id="liPHY">
															<input id="chkPHY" type="checkbox" class="inputCheck" checked/> <label for="">pH</label>
														</li>
														<li id="liCON">
															<input id="chkCON" type="checkbox" class="inputCheck"  checked/> <label for="">전기전도도</label>
														</li>
														<li id="A1">
															<input id="chkA1" type="checkbox" class="inputCheck"  checked/> <label for="">일반항목</label>
														</li>
														<li id="A2">
															<input id="chkA2" type="checkbox" class="inputCheck"  checked/> <label for="">생물감시</label>
														</li>
														<li id="A3">
															<input id="chkA3" type="checkbox" class="inputCheck"  checked/> <label for="">VOCs</label>
														</li>
														<li id="A4">
															<input id="chkA4" type="checkbox" class="inputCheck"  checked/> <label for="">중금속</label>
														</li>
													</ul>
												</dd>
											</dl>
											<p class="btn"><input id="btnOK" type="image" src="<c:url value='/images/common/btn_search.gif'/>" alt="조회" /></p>
										</div>
									</div>
								</div>
								<div class="bot_l"><div class="bot_r"><div class="bot"></div></div></div>
							</div>
							<div class="roundBox roundBox1">
								<div class="top_l"><div class="top_r"><div class="top"></div></div></div>
								<div class="con">
									<div class="con_r">
											<h2>[<span id="fact"></span>] [기상 : <img style="width:16px;height:16px;vertical-align:middle;" id='weatherImg' src="<c:url value='/images/common/ajax-loader.gif'/>"/><span id="weatherForecast"></span>]</h2>
											<div class="overBox_data">
												<table class="dataTable">
										<colgroup>
											<col width="45px" />
											<col width="px" />
											<col width="40px" />
										</colgroup>
										<thead>
											<tr>
												<th scope="col">항목</th>
												<th scope="col">측정값</th>
												<th scope="col">상태</th>
											</tr>
										</thead>
										<tbody id="topDataList">
											<tr>
												<td><span style="background-color:#;">&nbsp;</span></td>
												<td></td>
												<td></td>
											</tr>
										</tbody>
									</table>
											</div>									
										<div class="graph" id="gauge">
											<img src="<c:url value='/images/common/ajax-loader.gif'/>" id="gauge1" style="display:none"/>
											<img src="<c:url value='/images/common/ajax-loader.gif'/>" id="gauge2" style="display:none"/>
											<img src="<c:url value='/images/common/ajax-loader.gif'/>" id="gauge3" style="display:none"/>
											<img src="<c:url value='/images/common/ajax-loader.gif'/>" id="gauge4" style="display:none"/>
											<img src="<c:url value='/images/common/ajax-loader.gif'/>" id="gauge5" style="display:none"/>
										</div>
									</div>
								</div>
								<div class="bot_l"><div class="bot_r"><div class="bot"></div></div></div>
							</div>
							-->
							<div class="roundBox roundBox1">
									<div class="top_l"><div class="top_r"><div class="top"></div></div></div>
									<div class="con">
										<div class="con_r">
											<ul class="notes"> 
												<li><span><img style="vertical-align:middle;" src="<c:url value='/images/content/txt_notes.gif'/>" alt="범례" /></span></li>
												<li id="li_normal"><span class="alr_normal"><img src="<c:url value='/images/popup/bu_circle_green.gif'/>"></span> 정상</li>
												<li id="li_interest"><span class="alr_interest"><img src="<c:url value='/images/popup/bu_circle_blue.gif'/>"></span> 관심</li>
												<li id="li_caution"><span class="alr_caution"><img src="<c:url value='/images/popup/bu_circle_yellow.gif'/>"></span> 주의</li>
												<li id="li_alert"><span class="alr_alert"><img src="<c:url value='/images/popup/bu_circle_orange.gif'/>"></span> 경계</li>
												<li id="li_over"><span class="alr_over"><img src="<c:url value='/images/popup/bu_circle_red.gif'/>"></span> 심각</li>
											</ul>
											<div class="list_data">
												<div class="tit_weather">
													<h2><span id="fact1"></span></h2>
													<p class="weather">
														<!-- 이미지 -->
														<img style="width:16px;height:16px;vertical-align:middle;" id='weatherImg1' src="<c:url value='/images/content/NB01.png'/>"/>
														<span id="weatherSpan1"></span>
													</p>
												</div>
												<table class="dataTable">
													<colgroup>
														<col width="50px" />
														<col width="30px" />
														<col />
													</colgroup>
													<tr>
														<th scope="row">탁도</th>
														<td><span class="alr_noRcv"><img id="tur_or1" src="<c:url value='/images/popup/bu_circle_black.gif'/>"></span></td>
														<td style='border-right:0px'><img id="turGauge1" style="display:none"/></td>
														<td class='num' style='width:50px;border-left:0px'><span id='tur_val1' style="color:gray"></span></td>
													</tr>
													<tr>
														<th scope="row">수온</th>
														<td><span class="alr_normal"><img id="tmp_or1" src="<c:url value='/images/popup/bu_circle_black.gif'/>"></span></td>
														<td style='border-right:0px'><img id="tmpGauge1" style="display:none"/></td>
														<td class='num' style='width:50px;border-left:0px'><span id="tmp_val1" style="color:gray"></span></td>
													</tr>
													<tr>
														<th scope="row">pH</th>
														<td><span class="alr_interest"><img id="ph_or1" src="<c:url value='/images/popup/bu_circle_black.gif'/>"></span></td>
														<td style='border-right:0px'><img id="phGauge1" style="display:none"/></td>
														<td class='num' style='width:50px;border-left:0px'><span id="ph_val1" style="color:gray"></span></td>
													</tr>
													<tr>
														<th scope="row">DO</th>
														<td><span class="alr_caution"><img id="do_or1" src="<c:url value='/images/popup/bu_circle_black.gif'/>"></span></td>
														<td style='border-right:0px'><img id="doGauge1" style="display:none"/></td>
														<td class='num' style='width:50px;border-left:0px'><span id="do_val1" style="color:gray"></span></td>
													</tr>
													<tr>
														<th scope="row">EC</th>
														<td><span class="alr_alert"><img id="ec_or1" src="<c:url value='/images/popup/bu_circle_black.gif'/>"></span></td>
														<td style='border-right:0px'><img id="ecGauge1" style="display:none"/></td>
														<td class='num' style='width:50px;border-left:0px'><span id="ec_val1" style="color:gray"></span></td>
													</tr>
												</table>
											</div>
											<div class="list_data">
												<div class="tit_weather">
													<h2><span id="fact2">-</span></h2>
													<p class="weather">
														<img style="width:16px;height:16px;vertical-align:middle;" id="weatherImg2" src="<c:url value='/images/content/NB01.png'/>"/>
														<span id="weatherSpan2"></span>
													</p>
												</div>
												<table class="dataTable">
													<colgroup>
														<col width="50px" />
														<col width="30px" />
														<col />
													</colgroup>
													<tr>
														<th scope="row">탁도</th>
														<td><span class="alr_noRcv"><img id="tur_or2" src="<c:url value='/images/popup/bu_circle_black.gif'/>"></span></td>
														<td style='border-right:0px'><img id="turGauge2" style="display:none"/></td>
														<td class='num' style='width:50px;border-left:0px'><span id='tur_val2' style="color:gray"></span></td>
													</tr>
													<tr>
														<th scope="row">수온</th>
														<td><span class="alr_normal"><img id="tmp_or2" src="<c:url value='/images/popup/bu_circle_black.gif'/>"></span></td>
														<td style='border-right:0px'><img id="tmpGauge2" style="display:none"/></td>
														<td class='num' style='width:50px;border-left:0px'><span id='tmp_val2' style="color:gray"></span></td>
													</tr>
													<tr>
														<th scope="row">pH</th>
														<td><span class="alr_interest"><img id="ph_or2" src="<c:url value='/images/popup/bu_circle_black.gif'/>"></span></td>
														<td style='border-right:0px'><img id="phGauge2" style="display:none"/></td>
														<td class='num' style='width:50px;border-left:0px'><span id='ph_val2' style="color:gray"></span></td>
													</tr>
													<tr>
														<th scope="row">DO</th>
														<td><span class="alr_caution"><img id="do_or2" src="<c:url value='/images/popup/bu_circle_black.gif'/>"></span></td>
														<td style='border-right:0px'><img id="doGauge2" style="display:none"/></td>
														<td class='num' style='width:50px;border-left:0px'><span id='do_val2' style="color:gray"></span></td>
													</tr>
													<tr>
														<th scope="row">EC</th>
														<td><span class="alr_alert"><img id="ec_or2" src="<c:url value='/images/popup/bu_circle_black.gif'/>"></span></td>
														<td style='border-right:0px'><img id="ecGauge2" style="display:none"/></td>
														<td class='num' style='width:50px;border-left:0px'><span id='ec_val2' style="color:gray"></span></td>
													</tr>
												</table>
											</div>
											<div class="list_data">
												<div class="tit_weather">
													<h2><span id="fact3">-</span></h2>
													<p class="weather">
														<img style="width:16px;height:16px;vertical-align:middle;" id='weatherImg3' src="<c:url value='/images/content/NB01.png'/>"/>
														<span id="weatherSpan3"></span>
													</p>
												</div>
												<table class="dataTable">
													<colgroup>
														<col width="50px" />
														<col width="30px" />
														<col />
													</colgroup>
													<tr>
														<th scope="row">탁도</th>
														<td><span class="alr_noRcv"><img id="tur_or3" src="<c:url value='/images/popup/bu_circle_black.gif'/>"></span></td>
														<td style='border-right:0px'><img id="turGauge3" style="display:none"/></td>
														<td class='num' style='width:50px;border-left:0px'><span id='tur_val3' style="color:gray"></span></td>
													</tr>
													<tr>
														<th scope="row">수온</th>
														<td><span class="alr_normal"><img id="tmp_or3" src="<c:url value='/images/popup/bu_circle_black.gif'/>"></span></td>
														<td style='border-right:0px'><img id="tmpGauge3" style="display:none"/></td>
														<td class='num' style='width:50px;border-left:0px'><span id='tmp_val3' style="color:gray"></span></td>
													</tr>
													<tr>
														<th scope="row">pH</th>
														<td><span class="alr_interest"><img id="ph_or3" src="<c:url value='/images/popup/bu_circle_black.gif'/>"></span></td>
														<td style='border-right:0px'><img id="phGauge3" style="display:none"/></td>
														<td class='num' style='width:50px;border-left:0px'><span id='ph_val3' style="color:gray"></span></td>
													</tr>
													<tr>
														<th scope="row">DO</th>
														<td><span class="alr_caution"><img id="do_or3" src="<c:url value='/images/popup/bu_circle_black.gif'/>"></span></td>
														<td style='border-right:0px'><img id="doGauge3" style="display:none"/></td>
														<td class='num' style='width:50px;border-left:0px'><span id='do_val3' style="color:gray"></span></td>
													</tr>
													<tr>
														<th scope="row">EC</th>
														<td><span class="alr_alert"><img id="ec_or3" src="<c:url value='/images/popup/bu_circle_black.gif'/>"></span></td>
														<td style='border-right:0px'><img id="ecGauge3" style="display:none"/></td>
														<td class='num' style='width:50px;border-left:0px'><span id='ec_val3' style="color:gray"></span></td>
													</tr>
												</table>
											</div><!-- //20100625 수정 -->
										</div>
									</div>
									<div class="bot_l"><div class="bot_r"><div class="bot"></div></div></div>
								</div>
							<div class="dataBox" id="dataBox" style="border:0;">
						<!--// areaTOver -->
						<div id="areaTOver_watersysmnt_R03" class="areaTOver">
						<!-- areaTHeader_intercptn -->
						<div id="areaTHeader_intercptn">
							<table id="tableHeader_intercptn" class="dataTable" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
						   	<colgroup>						    	
						        <col width="50" />
						        <col width="100" />
						        <col width="100" />
						        <col width="90" />						        
						        <col width="100" />
						        <col width="100" />						        
						    </colgroup>
							<thead>						    
						    <tr>						    	
						        <th scope="col">지역</th>
						        <th scope="col">측정소</th>
						        <th scope="col">수신일자</th>
						        <th scope="col">수신시간</th>						        
						        <th scope="col">추이보기</th>
						        <th scope="col">지도보기</th>
						    </tr>						    
						    </thead>
						    </table>
						</div>
						<!--// areaTHeader_intercptn -->

						<!-- areaTHeader_top -->
						<div id="areaTHeader_top" >
							<table id="tableHeader_top" class="dataTable" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
						    <colgroup>
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
							</colgroup>
							 <colgroup>
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
							</colgroup>
							 <colgroup>
								<col width="90" />
								<col width="90" />
							</colgroup>
							 <colgroup>
								<col width="90" />
								<col width="90" />
							 <colgroup>							
								<col width="90" />	
								<col width="90" />
								<col width="90" />
							 <colgroup>
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
							</colgroup>
							 <colgroup>
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
							</colgroup>
							 <colgroup>
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
							</colgroup>
							 <colgroup>
								<col width="90" />
								<col width="90" />
							</colgroup>
								<col width="90" />
							</colgroup>
							 <colgroup>
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
							</colgroup>
								<col class="lastth" />
							<thead>
						    <tr>
						    	<th scope="colgroup" colspan="4">일반항목<br />내부</th>
						        <th scope="colgroup" colspan="5">일반항목<br />외부</th>
						        <th scope="colgroup" colspan="2">생물독성<br />(물벼룩1)</th>
						        <th scope="colgroup" colspan="2">생물독성<br />(물벼룩2)</th>
						        <th scope="col">생물독성<br />(미생물)</th>
						        <th scope="col">생물독성<br />(조류)</th>
						        <th scope="col">클로로필-a</th>
						        <th scope="colgroup" colspan="15">휘발성<br />유기화합물</th>
						        <th scope="colgroup" colspan="4">중금속</th>
						        <th scope="colgroup" colspan="2">페놀</th>
						        <th scope="col">유기물질</th>
						        <th scope="colgroup" colspan="5">영양염류</th>
						        <th scope="col">강수량계</th>
						    </tr>
						    <tr>
						        <th scope="col">pH1</th>
						        <th scope="col">DO1<br />(mg/L)</th>
						        <th scope="col">EC1<br />(mS/cm)</th>
						        <th scope="col">수온1(℃)</th>						        
						        <th scope="col">pH2</th>
						        <th scope="col">DO2<br />(mg/L)</th>
						        <th scope="col">EC2<br />(mS/cm)</th>
						        <th scope="col">수온2(C)</th>
						        <th scope="col">탁도</th>						        
						        <th scope="col">임펄스<br />(좌)</th>
						        <th scope="col">임펄스<br />(우)</th>						        
						        <th scope="col">독성지수<br />(좌)</th>
						        <th scope="col">독성지수<br />(우)</th>						        
						        <th scope="col">미생물<br />독성지수(%)</th>
						        <th scope="col">조류<br />독성지수(%)</th>
						        <th scope="col">클로로필-a</th>						        
						        <th scope="col">염화메틸렌</th>
						        <th scope="col">1.1.1-트리클로로에테인</th>
						        <th scope="col">사염화탄소</th>
						        <th scope="col">벤젠</th>
						        <th scope="col">트리클로로에틸렌</th>
						        <th scope="col">톨루엔</th>
						        <th scope="col">테트라클로로에틸렌</th>
						        <th scope="col">에틸벤젠</th>
						        <th scope="col">m,p-자일렌</th>
						        <th scope="col">o-자일렌</th>
						        <th scope="col">[ECD]염화메틸렌</th>
						        <th scope="col">[ECD]1.1.1-트리클로로에테인</th>
						        <th scope="col">[ECD]사염화탄소</th>
						        <th scope="col">[ECD]트리클로로에틸렌</th>
						        <th scope="col">[ECD]테트라클로로에틸렌</th>						        
						        <th scope="col">카드뮴</th>
						        <th scope="col">납</th>
						        <th scope="col">구리</th>
						        <th scope="col">아연</th>						        
						        <th scope="col">페놀1</th>
						        <th scope="col">페놀2</th>
						        <th scope="col">총유기탄소</th>						        
						        <th scope="col">총질소</th>
						        <th scope="col">총인</th>
						        <th scope="col">암모니아성<br />질소</th>
						        <th scope="col">질산성질소</th>
						        <th scope="col">인산염인</th>
						        <th scope="col">강수량</th>
						    </tr>
						    </thead>
						    </table>
						</div>
						<!--// areaTHeader_top -->

						<!-- areaTHeader_left -->
						<div id="areaTHeader_left" style="overflow:hidden;float:left;clear:left;">
							<table id="tableHeader_left" class="dataTable" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">							
							<colgroup>						    	
						        <col width="50" />
						        <col width="100" />
						        <col width="100" />
						        <col width="90" />
						        <col width="100" />
						        <col width="100" />
						    </colgroup>
							<tbody>
							<%for(int i = 0 ; i < 20 ; i++) {%>
							<tr class="undefined">						    	
						        <td><span id="tur0">tur0</span></td>
						        <td><span id="dow0">dow0</span></td>
						        <td><span id="rem0">rem0</span></td>
						        <td><span id="ret0">ret0</span></td><!-- 기존 id="rem0", 중복아이디 rename -->
						        <td class="btn"><img src="/images/common/btn_progress.gif" alt="추이" /></td>
						        <td class="btn"><img src="/images/common/btn_map.gif" alt="지도" /></td>
						    </tr>
						    <tr class="add">						    	
						        <td><span id="tur1">tur1</span></td>
						        <td><span id="dow1">dow1</span></td>
						        <td><span id="rem1">rem1</span></td>
						        <td><span id="ret1">ret1</span></td>
						        <td class="btn"><img src="/images/common/btn_progress.gif" alt="추이" /></td>
						        <td class="btn"><img src="/images/common/btn_map.gif" alt="지도" /></td>
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
							       	<%for(int i = 0 ; i < 43 ; i++) {%>
							        <col width="90" />							        
							        <%}%>
							        <col class="lasttd" />
							</colgroup>
					    <tbody>
					    	<%for(int i = 0 ; i < 20 ; i++) {%>					    	
							<tr class="undefined">
						        <!--bItem == "COM1" -->
						        <td class="num"><span id="phy0">phy0</span></td>  
						        <td class="num"><span id="dow0">dow0</span></td>
						        <td class="num"><span id="con0">con0</span></td>
						        <td class="num"><span id="tmp0">tmp0</span></td>
								<!--bItem == "COM2" -->
						        <td class="num"><span id="phy2_0">phy2_0</span></td>
						        <td class="num"><span id="dow2_0">dow2_0</span></td>
						        <td class="num"><span id="tmp2_0">tmp2_0</span></td>
						        <td class="num"><span id="tur0">tur0</span></td>
								<!--bItem == "BIO1" -->
						        <td class="num"><span id="imp0">imp0</span></td>
								<!--bItem == "BIO2" -->
						        <td class="num"><span id="lim0">lim0</span></td>
						        <td class="num"><span id="rim0">rim0</span></td> 
								<!--bItem == "BIO3" -->
						        <td class="num"><span id="ltx0">ltx0</span></td>
						        <td class="num"><span id="rtx0">rtx0</span></td>
								<!--bItem == "BIO4" -->
						        <td class="num"><span id="tox0">tox0</span></td>
								<!--bItem == "BIO5" -->
						        <td class="num"><span id="evn0">evn0</span></td>
								<!--bItem == "CHLA" -->
						        <td class="num"><span id="tof0">tof0</span></td>
								<!--bItem == "VOCS" -->
						        <td class="num"><span id="voc1_0">voc1_0</span></td>
						        <td class="num"><span id="voc2_0">voc2_0</span></td>
						        <td class="num"><span id="voc3_0">voc3_0</span></td>
						        <td class="num"><span id="voc4_0">voc4_0</span></td>
						        <td class="num"><span id="voc5_0">voc5_0</span></td>  
						        <td class="num"><span id="voc6_0">voc6_0</span></td>
						        <td class="num"><span id="voc7_0">voc7_0</span></td>
						        <td class="num"><span id="voc8_0">voc8_0</span></td>
						        <td class="num"><span id="voc9_0">voc9_0</span></td>
						        <td class="num"><span id="voc10_0">voc10_0</span></td>
						        <td class="num"><span id="voc11_0">voc11_0</span></td>
						        <td class="num"><span id="voc12_0">voc12_0</span></td>
						        <td class="num"><span id="voc13_0">voc13_0</span></td>
						        <td class="num"><span id="voc14_0">voc14_0</span></td>
						        <td class="num"><span id="voc15_0">voc15_0</span></td>
								<!--bItem == "METL" -->
						        <td class="num"><span id="cad0">cad0</span></td>
						        <td class="num"><span id="pul0">pul0</span></td>
						        <td class="num"><span id="cop0">cop0</span></td>
						        <td class="num"><span id="zin0">zin0</span></td>
								<!--bItem == "PHEN" -->
								<td class="num"><span id="phe0">phe0</span></td>  
						        <td class="num"><span id="phl0">phl0</span></td>
								<!--bItem == "ORGA" -->
						        <td class="num"><span id="toc0">toc0</span></td>
								<!--bItem == "NUTR" -->
						        <td class="num"><span id="ton0">ton0</span></td>
						        <td class="num"><span id="top0">top0</span></td> 
								<td class="num"><span id="nh40">nh40</span></td>  
						        <td class="num"><span id="no30">no30</span></td>
						        <td class="num"><span id="po40">po40</span></td>
								<!--bItem == "RAIN" -->
						        <td class="num"><span id="rin0">rin0</span></td>
						    </tr>
						    <tr class="add">	
						        <!--bItem == "COM1" -->
						        <td class="num"><span id="phy1">phy1</span></td>  
						        <td class="num"><span id="dow1">dow1</span></td>
						        <td class="num"><span id="con1">con1</span></td>
						        <td class="num"><span id="tmp1">tmp1</span></td>
								<!--bItem == "COM2" -->
						        <td class="num"><span id="phy2_1">phy2_1</span></td>
						        <td class="num"><span id="dow2_1">dow2_1</span></td>
						        <td class="num"><span id="tmp2_1">tmp2_1</span></td>
						        <td class="num"><span id="tur1">tur1</span></td>
								<!--bItem == "BIO1" -->
						        <td class="num"><span id="imp1">imp1</span></td>
								<!--bItem == "BIO2" -->
						        <td class="num"><span id="lim1">lim1</span></td>
						        <td class="num"><span id="rim1">rim1</span></td> 
								<!--bItem == "BIO3" -->
						        <td class="num"><span id="ltx1">ltx1</span></td>
						        <td class="num"><span id="rtx1">rtx1</span></td>
								<!--bItem == "BIO4" -->
						        <td class="num"><span id="tox1">tox1</span></td>
								<!--bItem == "BIO5" -->
						        <td class="num"><span id="evn1">evn1</span></td>
								<!--bItem == "CHLA" -->
						        <td class="num"><span id="tof1">tof1</span></td>
								<!--bItem == "VOCS" -->
						        <td class="num"><span id="voc1_1">voc1_1</span></td>
						        <td class="num"><span id="voc2_1">voc2_1</span></td>
						        <td class="num"><span id="voc3_1">voc3_1</span></td>
						        <td class="num"><span id="voc4_1">voc4_1</span></td>
						        <td class="num"><span id="voc5_1">voc5_1</span></td>  
						        <td class="num"><span id="voc6_1">voc6_1</span></td>
						        <td class="num"><span id="voc7_1">voc7_1</span></td>
						        <td class="num"><span id="voc8_1">voc8_1</span></td>
						        <td class="num"><span id="voc9_1">voc9_1</span></td>
						        <td class="num"><span id="voc10_1">voc10_1</span></td>
						        <td class="num"><span id="voc11_1">voc11_1</span></td>
						        <td class="num"><span id="voc12_1">voc12_1</span></td>
						        <td class="num"><span id="voc13_1">voc13_1</span></td>
						        <td class="num"><span id="voc14_1">voc14_1</span></td>
						        <td class="num"><span id="voc15_1">voc15_1</span></td>
								<!--bItem == "METL" -->
						        <td class="num"><span id="cad1">cad1</span></td>
						        <td class="num"><span id="pul1">pul1</span></td>
						        <td class="num"><span id="cop1">cop1</span></td>
						        <td class="num"><span id="zin1">zin1</span></td>
								<!--bItem == "PHEN" -->
								<td class="num"><span id="phe1">phe1</span></td>  
						        <td class="num"><span id="phl1">phl1</span></td>
								<!--bItem == "ORGA" -->
						        <td class="num"><span id="toc1">toc1</span></td>
								<!--bItem == "NUTR" -->
						        <td class="num"><span id="ton1">ton1</span></td>
						        <td class="num"><span id="top1">top1</span></td> 
								<td class="num"><span id="nh41">nh41</span></td>  
						        <td class="num"><span id="no31">no31</span></td>
						        <td class="num"><span id="po41">po41</span></td>
								<!--bItem == "RAIN" -->
						        <td class="num"><span id="rin1">rin1</span></td>
						    </tr>
							<%}%>   
							</tr>
							</tbody>
						    </table>
						</div>
						<!--// areaTData -->

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
						<!--// areaTOver -->
							</div>
						</div>
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