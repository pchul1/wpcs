	var ROOT_PATH = '<c:url value="/"/>';
	
	// 메뉴이동 함수
	function goTitleMenu(menuNo){
		var url = '';
		var subMenuNo = '';
			
		if(menuNo == '10000'){
			//url = 'javascript:admin_popup();';
			url = '/waterpolmnt/waterinfo/goFactDetail.do';
			subMenuNo = '11000';
			
			goMenu(url,subMenuNo);
		}else if(menuNo == '20000'){
			url = '/psupport/psupport.do?param=psupport/list&menuID=4100';
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
		}
	}
	
	function goMenu(url,menuNo) {
		
		if (url.lastIndexOf("javascript") > -1) {
			eval(url.substr(11,url.length));
		} else {
			document.menuForm.action = ROOT_PATH+url.substring(1, url.length);
			document.menuForm.clickMenu.value = menuNo;
			document.menuForm.submit();
		}
	}
	
	function InfoPopup() {
		window.open("/common/member/InfoModify.do", "InfoModify", "width=750,height=350");
	}
	
	function admin_popup() {
		
		var sw=screen.width;var sh=screen.height;
		var winHeight = 795;var winWidth = 1260;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = 0;
		var width = winWidth-20;
		var height = winHeight-20;
		
		window.open("<c:url value='/waterpolmnt/situationctl/goTotalMntMainTS.do'/>?",
				'DetailView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	function manager_popup() {
		
		var sw=screen.width;var sh=screen.height;
		var winHeight = 890;var winWidth = 1260;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = 0;
		var width = winWidth-20;
		var height = winHeight-20;
		
		window.open("<c:url value='/waterpolmnt/situationctl/goWATERSYSMNT.do?'/>",
				'DetailView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	function ps_accident_popup(){
		var sw=screen.width;var sh=screen.height;
		var winHeight = 890;var winWidth = 1260;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = 0;
		var width = winWidth-20;
		var height = winHeight-20;
		
		window.open("/psupport/TMS_POP.jsp?menuID=5110",
				'psView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	function ps_ipusn_popup(){
		var sw=screen.width;var sh=screen.height;
		var winHeight = 890;var winWidth = 1260;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = 0;
		var width = winWidth-20;
		var height = winHeight-20;
		
// 		window.open("/ipusn/getipusnMaplist.do",
//			'psView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	window.open("/psupport/TMS_POP.jsp?menuID=5120",
			'psView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	function ps_sphone_popup(){
		var sw=screen.width;var sh=screen.height;
		var winHeight = 890;var winWidth = 1260;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = 0;
		var width = winWidth-20;
		var height = winHeight-20;
		
		window.open("/psupport/TMS_POP.jsp?menuID=5130",
				'psView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	function fn_popup(url){
		var retVal;
		var openParam = "width=650,height=550,resizable=yes,scrollbars=yes";
		retVal = window.open(url,"bbsListPopup", openParam);
	}
	
