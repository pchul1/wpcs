<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%@ page import="daewooInfo.common.security.util.TmsUserDetailsHelper" %>
<%@ page import="daewooInfo.common.login.bean.LoginVO" %>
<!-- <script src="/js/session.js"></script> -->
<script type="text/javascript">
	$(document).ready(function(){
		$("#gnbArea > ul > li").on("mouseenter focusin", function(){
			$(this).parent().find(".gnb1depth").removeClass("on");
			$(this).addClass("on");
			$(this).find(".gnb2depth li").on("mouseenter focusin", function(){
				$(this).addClass("on");
			}).on('mouseleave focusout',function(){
				$(this).removeClass("on");
			});
		});
		
		$('#header').siblings().on('mouseenter focusin',function(){
			$("#gnbArea > ul > li").removeClass("on");
		 });
	});


	var ROOT_PATH = '<c:url value="/"/>';
	// 메뉴이동 함수
	function goTitleMenu(menuNo){
		var url = '';
		var subMenuNo = '';
		
		if(menuNo == '10000'){
			url = '/waterpolmnt/waterinfo/goFactDetail.do';
			subMenuNo = '11000';
			
			goMenu(url,subMenuNo);
		}else if(menuNo == '20000'){
			url = '/waterpolmnt/waterinfo/ecompanyList.do';
			subMenuNo = '21000';
			
			goMenu(url,subMenuNo);
		}else if(menuNo == '30000'){
			url = '/psupport/psupport.do?param=psupport/list&menuID=5110';
			subMenuNo = '31000';
			
			goMenu(url,subMenuNo);
		}else if(menuNo == '40000'){
			url = '/admin/member/MemberList.do';
			subMenuNo = '41000';
			
			goMenu(url,subMenuNo);
		}else if(menuNo == '50000'){
			url = '/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000030';
			subMenuNo = '51000';
			
			goMenu(url,subMenuNo);
		}else if(menuNo == '60000'){
			url = '/common/member/InfoModify.do';
			subMenuNo = '61000';
			
			goMenu(url,subMenuNo);
		}
	}
	
	function goMenu(url,menuNo) {
		//2014-09-15 mypark 알림 창 닫기
		$('#alrimArea').hide();
		if (url.lastIndexOf("javascript") > -1) {
			eval(url.substr(11,url.length));
		} else {
			document.menuForm.action = ROOT_PATH+url.substring(1, url.length);
			document.menuForm.clickMenu.value = menuNo;
			document.menuForm.submit();
		}
	}
	
	function OpenMyMenu() {
		AlrimPopClose();
		CloseMyMenu();
		$("#myMenuLayer").css("display","");
	}
	
	function CloseMyMenu() {
		$("#myMenuLayer").css("display","none");
	}
	
	function admin_popup() {
	
		var sw=screen.width;var sh=screen.height;var winHeight = 795;var winWidth = 1260;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = 0;
		var width = winWidth-20;
		var height = winHeight-20;
		
		window.open("<c:url value='/waterpolmnt/situationctl/goTotalMntMainTS.do'/>?",
				'DetailView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	function manager_popup() {
	
		var sw=screen.width;var sh=screen.height;var winHeight = 890;var winWidth = 1260;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = 0;
		var width = winWidth-20;
		var height = winHeight-20;
		
		window.open("<c:url value='/waterpolmnt/situationctl/goWATERSYSMNT.do?'/>",
				'DetailView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	function ps_accident_popup(){
		var sw=screen.width;var sh=screen.height;var winHeight = 890;var winWidth = 1260;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = 0;
		var width = winWidth-20;
		var height = winHeight-20;
		
		window.open("/psupport/TMS_POP.jsp?menuID=5110",
				'psView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	function ps_ipusn_popup(){
		var sw=screen.width;var sh=screen.height;var winHeight = 890;var winWidth = 1260;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = 0;
		var width = winWidth-20;
		var height = winHeight-20;
		
// 		window.open("/ipusn/getipusnMaplist.do",
// 			'psView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,left='+winLeftPost+',top='+winTopPost);
		window.open("/psupport/TMS_POP.jsp?menuID=5120",
				'psView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	function ps_sphone_popup(){
		var sw=screen.width;var sh=screen.height;var winHeight = 890;var winWidth = 1260;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = 0;
		var width = winWidth-20;
		var height = winHeight-20;
		
		window.open("/psupport/TMS_POP.jsp?menuID=5130",
				'psView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	function fn_Menual_downFile(){
		window.open("/cmmn/FileDown.do?atchFileId=FILE_000000000000671&fileSn=0");
	}
	
	function fn_egov_inqire_notice1() {
		//location.href = "/bbs/selectBoardArticle.do?menu_id=51110&nttId=67&bbsId=BBSMSTR_000000000030";
		location.href = "/file/e-book.zip";
	}
	
	function fn_solution_download() {
		location.href = "/pds/EMIS-setup-20180914_V1.0.0.0.exe";
	}
	
	//2014-09-12 mypark 알림 기능 팝업 오픈
	function AlrimPopup() {
		AlrimPopClose();
		CloseMyMenu();
		$('#alrimArea').show();
	}
	
	//2014-09-12 mypark 알림 기능 팝업 닫기
	function AlrimPopClose() {
		$('#alrimArea').hide();
	}
	
	//2014-09-12 mypark 알림 기능 확인
	function goAlrimLink(link, alrimId, menuId) {
		if (link.indexOf("#") < 0) {
			$.ajax({
				type: "GET",
				url: "<c:url value='/common/alrim/AlrimUnCofirmUpdate.do'/>",
				data: {link:link, alrimId:alrimId, menuId:menuId},	
				dataType:"text",
				success : function(result){
					if(result != null) {
						goMenu(link,menuId);
						$('#alrimArea').hide();
					}
				}
			});
		}
	}
	
	function goAlrimClear(link, alrimId, menuId) {
		if (link.indexOf("#") < 0) {
			$.ajax({
				type: "GET",
				url: "<c:url value='/common/alrim/AlrimUnCofirmUpdate.do'/>",
				data: {link:link, alrimId:alrimId, menuId:menuId},	
				dataType:"text",
				success : function(result){
					if(result != null) {
						//goMenu(link,menuId);
						alert("정상적으로 처리되었습니다.")
						location.reload();
						//$('#alrimArea').hide();
					}
				}
			});
		}
	}
	
	function me_popup() {
		
		var sw=screen.width;var sh=screen.height;
		var winHeight = 1080;var winWidth = 1920;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = 0;
		var width = winWidth-20;
		var height = winHeight-20;
		
		window.open("<c:url value='/main2.do'/>?",
				'main2View','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	//2016-09-08 Naturetech 세션타이머
	<%-- var sessionTime = "<%=session.getMaxInactiveInterval()%>";
	$(function() {
		setTime(sessionTime);
		globalTimer = setInterval("timeclock()", 1000);
	}); --%>
	
	
</script>
	<div id="header_content">
		<input type="hidden" id="userId" value="<sec:authentication property="principal.userVO.id"/>"/>
		<h1>
			<a href="<c:url value='/main.do'/>"><img src="<c:url value='/images/renewal2/top_logo.png'/>"  alt="한국환경공단 수질오염 방제정보 시스템" /></a>
			<!-- <span id="spanSession">세션 만료 시간</span> -->
		</h1>
		<div class="topSubNavi">
			<div class="naviDiv">	
				<ul class="navi_ul1" style="top:3px;">
					<li class="user_name_li" style="position:relative;">
						<img src="/images/renewal2/top_info_icon_1.png" alt="접속자" />&nbsp;<span class="top_info_point"><sec:authentication property="principal.userVO.name"/></span>님 환영합니다
					</li>
					<li><a href="<c:url value='/common/login/actionLogout.do'/>">로그아웃</a></li>
					<li><a href="<c:url value='/main.do'/>">HOME</a></li>
				</ul>
				<div style="color:white;top:29px;left:42px;font-size:11px; position: absolute;">
					
					<c:if test="${!empty accessRegdate}">최종접속시간:&nbsp;${accessRegdate}&nbsp;</c:if>
					<c:if test="${!empty uip}">IP:&nbsp;${uip}</c:if>
				</div>
				<ul class="navi_ul2">
					<!-- 2014-09-11 mypark 알림 기능 추가 S-->
					<li><a href="javascript:AlrimPopup()">알림&nbsp;<span>(${unConfirmCnt})</span></a>
					<div id="alrimArea" class="alrim" style="border:3px solid #07AFFA;display:none;">
						<div class="alrimTitle">
							<div style="float:left;margin-top:2px;height:15px;" ><a style="font-weight:bold;font-size:15px;">알림</a></div>
							<div style="float:right;margin-right:15px;margin-top:2px;height:15px;">
							<c:if test="${fn:length(alrimList) > 0}">
							<a href="javascript:goAlrimClear('','','');" style="font-size:15px;font-weight:bold;">Clear</a>
							</c:if>
							<a href="javascript:AlrimPopClose();" style="font-size:15px;font-weight:bold;">X</a></div>
						</div>  
						<div class="alrimList">
							<div class="alrimListContent">
								<table summary="알림 목록. 구분, 알림날짜, 알림내용, 확인이 담김">
									<colgroup>
										<col width="70" />
										<col width="130" />
										<col />
										<col width="70" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">구분</th>
											<th scope="col">알림날짜</th>
											<th scope="col">알림내용</th>
											<th scope="col">확인</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="result" items="${alrimList}" varStatus="status">
										<tr>
											<td style="text-align:center;"><c:out value="${result.alrimGubun}"/></td>
											<td style="text-align:center;"><c:out value="${result.alrimDate}"/></td>
											<td><a href="javascript:goAlrimLink('${empty result.alrimLink ? '#': result.alrimLink}','${result.alrimId}','${result.alrimMenuId}')"><c:out value="${result.alrimTitle}" escapeXml="false"/></a></td>
											<td style="text-align:center;"><c:out value="${result.alrimCheck}"/></td>
										</tr>
										</c:forEach>
										<c:if test="${fn:length(alrimList) == 0}">
										<tr>
											<td colspan='4' style="text-align:center;">알림이 없습니다.</td>
										</tr>
										</c:if>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<c:set value="300" var="mymenu_height"/>
					<c:if test="${empty MyMenuList}"><c:set value="110" var="mymenu_height"/></c:if>
					<div id="myMenuLayer" class="myMenu" style="border:3px solid #07AFFA;display:none;height:<c:out value="${mymenu_height}"/>px;">
						<div class="myMenuTitle">
							<div style="float:left;margin-top:2px;height:15px;" ><a style="font-weight:bold;font-size:15px;">마이메뉴</a></div>
							<div style="float:right;margin-right:15px;margin-top:2px;height:15px;"><a href="javascript:CloseMyMenu();" style="font-size:15px;font-weight:bold;">X</a></div>
						</div>  
						<div class="myMenuList">
							<div class="myMenuListContent" style="height:<c:out value="${mymenu_height - 65}"/>px;">
								<div style="margin:10px 0;">
									<c:forEach var="item" varStatus="count" items="${MyMenuList}">
										<c:if test='${item.lvl eq "1"}'>
											<div style="margin-left:${item.lvl * 15}px;font-weight:bold;">
												<a>-</a>
												<a href="javascript:goMenu('${item.url}','${item.menuNo}')">${item.menuName}</a>
												<img src="/images/util/menu_empty.gif"/>
											</div>
										</c:if>
										<c:if test='${item.lvl ne "1"}'>
											<div style="margin-left:${item.lvl * 15}px;">
												<img src="/images/util/menu_joinbottom.gif"/>
												<a href="javascript:goMenu('${item.url}','${item.menuNo}')">${item.menuName}</a>		
											</div>
										</c:if>
									</c:forEach>
									<c:if test="${empty MyMenuList}">
										<div style="color:#333333;line-height:16px;padding:0 10px;">즐겨찾는 메뉴를 등록해 주세요.&nbsp;&nbsp;<a onclick="javascript:goMenu('/common/member/MyMenu.do','61410');return false;" href="#" style='font-family: NanumGothic,"나눔고딕","Nanum Gothic","돋움",dotum,sans-serif;padding:0;text-decoration: underline;color:#3B36CF'>바로가기</a></div>
									</c:if>
								</div>
							</div>
						</div>
					</div>
					</li>
					<!-- 2014-09-11 mypark 알림 기능 추가 E-->
					<li><a href="javascript:goTitleMenu('60000');">My Page</a></li>
					<li><a href="javascript:OpenMyMenu();">My Menu</a></li>
<%-- 					<li class="last"><a href="http://210.99.81.159:8780/analysis/desktop/login.html?userid=<sec:authentication property="principal.userVO.id"/>" target="olapsystem">분석통계시스템</a></li> --%>
					
				</ul>
			</div>
		</div>
		<div id="gnbArea">
			<a class="mainLogo" href="<c:url value='/main.do'/>"><img src="<c:url value='/images/renewal2/top_logo2.png'/>"  alt="한국환경공단 수질오염 방제정보 시스템" /></a>
			<ul>
				<c:if test="${ not empty menuList}">
				<c:forEach var="result" items="${menuList}" varStatus="status">
				<li  class="gnb1depth <c:if test="${status.last}">last</c:if>">
					<c:set var="num" value="${fn:substring(result.menuNo, 0, 1)}" />
					<a href="#" id="gnb0${num}" onclick="javascript:goMenu('${empty result.url ? '#': result.url}','${result.subMenuNo}'); return false;">${result.menuName}</a>
					<ul id="gm${num}" class="gnb2depth">
					<li class="gm_title">${result.menuName}</li>
					<c:forEach var="result2" items="${result.subMenuList}" varStatus="status2">
						<li><a href="javascript:goMenu('${empty result2.url ? '#': result2.url}','${empty result2.subMenuNo ? result2.menuNo: result2.subMenuNo}')">${result2.menuName}</a></li>
					</c:forEach>
					</ul>
				</li>
				</c:forEach>
				</c:if>
			</ul>
		</div>
	</div>
	<form name="menuForm" method="post">
		<input type="hidden" name="clickMenu" value="${clickMenu}"/>
	</form>