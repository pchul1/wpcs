<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : spotManage.jsp
	 * Description : 측정소(지점)관리 화면
	 * Modification Information
	 * 
	 * 수정일			 수정자		수정내용
	 * ----------	--------	---------------------------
	 * 2010.05.17	khany		최초생성
	 * 2013.10.20	lkh			리뉴얼
	 * 
	 * author khany
	 * since 2010.05.17
	 * 
	 * Copyright (C) 2010 by khany All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />
<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="initial-scale=1, maximum-scale=1,user-scalable=no" />

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />

<script type="text/javascript" src="<c:url value='/gis/js/new_editMap.js'/>"></script>
<script type="text/javascript">
	//<![CDATA[
	var EventDivobj = null;
	var memFactCode = "${member.factCode}";
	var memRiverDiv = "${member.riverId}";

	var options = {
		enableColumnReorder : false,
		enableCellNavigation : true,
		multiColumnSort : true
	};

	$(function() {
		var tab = $('.tabs');

		function onSelectTab() {
			var t = $(this);
			var myClass = t.parent('li').attr('class');

			t.parents('.tabs:first').attr('class', 'tabs ' + myClass);
			t.parent().parent().find("li").removeClass("on");
			t.parent('li').addClass("on");
		}
		tab.find('>li>a').click(onSelectTab).focus(onSelectTab);
		//지점등록 레이어
		$("#layerBranchReg").draggable({
			containment : 'body',
			scroll : false
		});

		LayerDiv(1);
		reloadData();

		//지점등록 레이어
		$("#layerBranchReg").draggable({
			containment : 'body',
			scroll : false
		});
		//측정소 등록/수정 레이어
		$("#layerBranchModify").draggable({
			containment : 'body',
			scroll : false
		});
		//탭1 관리자 등록/변경 레이어
		$("#layerMember").draggable({
			containment : 'body',
			scroll : false
		});
		//측정소 조회 레이어
		$("#factinfoLayer").draggable({
			containment : 'body',
			scroll : false
		});
		//측정소등록 관리자등록 조회 레이어
		$("#memberLayer").draggable({
			containment : 'body',
			scroll : false
		});

		setDept(); //부서셋팅
		$("#dept").change(function() {
			setPerson(); //직원셋팅
		});
	});

	//저장된 항목 가져오기
	var itemList;

	//측정소 리스트 상태를 저장
	function updateLoadData(obj, val) {
		showLoading();

		var date = new Date();
		date = date.getFullYear() + addzero(date.getMonth() + 1)
				+ addzero(date.getDate());
		var pageNo = $("#rpage").val(); //측정소 수정을 위한 페이지 확인
		var objs = JSON.parse(StringtoJson(obj));
		var fact_code = objs.factCode;
		var branch_no = objs.branchNo;
		var branchName = objs.branchName;
		var riverDiv = objs.riverDiv;
		var riverName = objs.riverName;
		var sysKind = objs.sysKind;
		var longitude = objs.longitude;
		var latitude = objs.latitude;
		var factAddr = objs.factAddr;
		var branchUseFlag = val;
		var useStr = (branchUseFlag == "Y") ? "사용" : "미사용";

		var obj = {};
		obj.BRANCH_NO = branch_no; //지점번호
		obj.DATE = date; //일력일자
		obj.FACI_ADDR = factAddr; //주소
		obj.FACI_NM = riverName + sysKindName(sysKind) + "(" + branchName + "-"
				+ branch_no + ")"; //예) 한강IP_USN(양평-3)
		obj.FACT_CODE = fact_code; //측정소코드
		obj.RV_CD = riverDiv; //수계	예)R01
		obj.Y = latitude; //위도
		obj.X = longitude; //경도
		obj.USE_FLAG = branchUseFlag //사용여부

		if (branchUseFlag == "Y" && (sysKind == "A" || sysKind == "U")) {

			$editMap.model
					.addMemtPoint(
							sysKind,
							obj,
							function(result) {
								// 				console.log('[저장]editMap.result', result);

								if (result.callbacktype == 'S'
										|| result.callbacktype == 'R') {
									// 					console.log('[저장]', result.callbacktype);

									$
											.ajax({
												type : "post",
												url : "<c:url value='/spotmanage/saveLoadData.do'/>",
												data : {
													fact_code : fact_code,
													branch_no : branch_no,
													branchUseFlag : branchUseFlag
												},
												dataType : "json",
												success : function(result) {
													reloadData(pageNo);
													alert(branchName + "-"
															+ branch_no
															+ "지점을 " + useStr
															+ "으로 변경 등록했습니다.");
												},
												error : function(result) {
													var oraErrorCode = "";
													if (result.responseText != null) {
														var matchedValue = result.responseText
																.match(/ORA-[0-9]{5}/);
														if (matchedValue != null
																&& matchedValue.length > 0) {
															oraErrorCode = matchedValue[0]
																	.replace(
																			'ORA-',
																			'');
														}
													}
													alert("서버 접속에 실패하였습니다! [CODE:"
															+ oraErrorCode
															+ "]");
													closeLoading();
												}
											});
								} else {
									alert("서버접속에 실패하였습니다.\n다시 확인해주세요.");
									closeLoading();
									return;
								}
							});
		} else if (branchUseFlag == "N" && (sysKind == "A" || sysKind == "U")) {
			$editMap.model
					.removeMemtPoint(
							sysKind,
							obj,
							function(result) {
								// 				console.log('[삭제]editMap.result', result);
								if (result.callbacktype == 'S') {
									// 					console.log('[삭제]', result.callbacktype);
									$
											.ajax({
												type : "post",
												url : "<c:url value='/spotmanage/saveLoadData.do'/>",
												data : {
													fact_code : fact_code,
													branch_no : branch_no,
													branchUseFlag : branchUseFlag
												},
												dataType : "json",
												success : function(result) {
													reloadData(pageNo);
													alert(branchName + "-"
															+ branch_no
															+ "지점을 " + useStr
															+ "으로 변경 등록했습니다.");
												},
												error : function(result) {
													var oraErrorCode = "";
													if (result.responseText != null) {
														var matchedValue = result.responseText
																.match(/ORA-[0-9]{5}/);
														if (matchedValue != null
																&& matchedValue.length > 0) {
															oraErrorCode = matchedValue[0]
																	.replace(
																			'ORA-',
																			'');
														}
													}
													alert("서버 접속에 실패하였습니다! [CODE:"
															+ oraErrorCode
															+ "]");
													closeLoading();
												}
											});
								} else {
									alert("서버접속에 실패하였습니다.\n다시 확인해주세요.");
									closeLoading();
									return;
								}
							});
		} else {

			$.ajax({
				type : "post",
				url : "<c:url value='/spotmanage/saveLoadData.do'/>",
				data : {
					fact_code : fact_code,
					branch_no : branch_no,
					branchUseFlag : branchUseFlag
				},
				dataType : "json",
				success : function(result) {
					reloadData(pageNo);
					alert(branchName + "-" + branch_no + "지점을 " + useStr
							+ "으로 변경 등록했습니다.");
				},
				error : function(result) {
					var oraErrorCode = "";
					if (result.responseText != null) {
						var matchedValue = result.responseText
								.match(/ORA-[0-9]{5}/);
						if (matchedValue != null && matchedValue.length > 0) {
							oraErrorCode = matchedValue[0].replace('ORA-', '');
						}
					}
					alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
					closeLoading();
				}
			});

		}
		// 		reloadData();
		closeLoading();
	}

	function reloadData(pageNo) {
		var selectFormatter = function(row, cell, value, columnDef, dataContext) {
			var strSelect = "<select id='branchUseFlag' name='branchUseFlag' onchange='javascript:updateLoadData("
					+ row + ", this.value);'>";

			if (value == "Y") {
				strSelect += "<option value='Y' selected='true'>사용</option>"
						+ "<option value='N'>미사용</option>";
			} else {
				strSelect += "<option value='Y'>사용</option>"
						+ "<option value='N' selected='true'>미사용</option>";
			}
			strSelect += "</select>";
			return strSelect;
		}
		//측정소(지점)정보
		dataView = new Slick.Data.DataView();

		showLoading();
		var riverDiv = $("select[name=c_river_div]").val();
		var sysKind = $("select[name=c_sys_kind]").val();
		var branchName = $("#c_branch_name").val();
		var searchUseFlag = $("select[name=c_branch_use_flag]").val();
		var searchText;
		if ($("#c_branch_name").val() != "") {
			searchText = branchName;
		} else {
			searchText = "";
		}
		if (pageNo == null)
			pageNo = 1;
		$
				.ajax({
					type : "post",
					url : "<c:url value='/spotmanage/getSpotmgrList.do'/>",
					data : {
						pageIndex : pageNo,
						sysKind : sysKind,
						riverDiv : riverDiv,
						searchText : searchText,
						searchUseFlag : searchUseFlag
					},
					dataType : "json",
					success : function(result) {
						// 				console.log("reload getSpotmgrList : ",result);
						var tot = result['detailViewList'].length;
						var html = "";

						if (tot <= 0) {
							html += "<tr><td colspan='8'>조회 결과가 없습니다.</td></tr>";
						} else {
							for (var i = 0; i < tot; i++) {
								var obj = result['detailViewList'][i];
								var pageInfo = result['paginationInfo'];

								obj.no = i
										+ ((pageInfo.currentPageNo - 1) * pageInfo.recordCountPerPage)
										+ 1;
								obj.sysName = sysKindName(obj.sysKind);
								obj.branchNameNo = obj.branchName + " - "
										+ obj.branchNo;

								trclass = "";
								if (i % 2 == 1)
									trclass = "class=\"even\"";
								var trNo = i + 1;

								html += "<tr "
										+ trclass
										+ " id='tr"
										+ trNo
										+ "' class='tr"
										+ i
										+ "' onclick=\"javascript:clickTrEvent(this);EventDiv('"
										+ JSONtoString(obj)
										+ "');\" style='cursor:pointer;'>";
								html += "<td>" + obj.no + "</td>";
								html += "<td>" + obj.riverName + "</td>";
								html += "<td>" + obj.equipCode + "</td>";
								html += "<td>" + obj.sysName + "</td>";
								html += "<td>" + obj.factCode + "</td>";
								html += "<td>" + obj.factName + "</td>";
								html += "<td>" + obj.branchNameNo + "</td>";

								if (obj.branchUseFlag == "Y") {
									select = "사용";
								} else {
									select = "미사용";
								}

								html += "<td>" + select + "</td>";

								html += "<td><a onclick=\"javascript:popupMapOpen('"
										+ obj.longitude
										+ "', '"
										+ obj.latitude
										+ "');\"; style=\"cursor:pointer\">[보기]</a></td>";

								html += "</tr>";

							}
							// 페이징 정보
							var pageStr = makePaginationInfo(result['paginationInfo']);
							$("#pagination").empty();
							$("#pagination").append(pageStr);
							$("#rpage").val(pageNo);
						}
						$("#dataList").html(html);
						closeLoading();
					},
					error : function(result) {
						var html = "";
						html += "<tr><td colspan='8'>서버 접속에 실패하였습니다.</td></tr>";
						$("#dataList").html(html);
						closeLoading();
					}
				});
	}

	function clickTrEvent(trObj) {
		var tr = eval("document.getElementById(\"" + trObj.id + "\")");
		$(tr).parent().find("tr td").removeClass("tr_on");
		$(tr).find("td").addClass("tr_on");
	}

	//지점 상세보기
	function getSpotView(obj) {
		objs = JSON.parse(StringtoJson(obj));
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;
		var sysKind = objs.sysKind;
		var riverNo = objs.riverNo;
		//alert(factCode.substring(0,1));
		//if(factCode.substring(0,1))
		var url = "";

		if (sysKind == "U") {
			url = "<c:url value='/spotmanage/getSpotView.do'/>";
		} else if (sysKind == "A") {
			url = "<c:url value='/spotmanage/getSpotView.do'/>";
		} else if (sysKind == "W") {
			url = "<c:url value='/spotmanage/getSpotView.do'/>";
		}

		showLoading();
		$
				.ajax({
					type : "post",
					url : url,
					data : {
						riverNo : riverNo,
						sysKind : sysKind,
						factCode : factCode,
						branchNo : branchNo
					},
					dataType : "json",
					success : function(result) {
						// 				console.log("getSpotView : ",result);
						var obj = result['getSpotView'];

						$("#factCode").html(obj.factCode);
						$("#branchNo").val(obj.branchNo);
						$("#mgrOrg").html(obj.mgrOrg);
						$("#operOrg").html(obj.operOrg);
						$("#riverName").html(obj.riverName);
						$("#areaName").html(obj.areaName);
						$("#sido").html(obj.sido);
						$("#gugun").html(obj.gugun);
						$("#longitude").html(obj.longitude);
						$("#latitude").html(obj.latitude);
						$("#rlongitude").val(obj.longitude);
						$("#rlatitude").val(obj.latitude);
						$("#dong").html(obj.dong);
						$("#factAddr").html(obj.factAddr);

						obj.sysName = sysKindName(obj.sysKind);

						$("#riverDivName").html(obj.sysKind);
						$("#sysName").html(obj.sysName);
						$("#factName").html(obj.factName);
						$("#equipCode").html(obj.equipCode);
						$("#branchMgr").html(obj.branchMgr);
						$("#branchMgrTel").html(obj.branchMgrTel);
						$("#branchUseName").html(obj.branchUseName);

						var tot = result['memList'].length;
						var tot1 = result['sysItemList'].length;

						$("#memList").html("");
						var item;

						if (tot <= 0) {
							item = "<li>등록된 관리자가 없습니다.</li>";
							$("#memList").append(item);
						} else {
							for (var i = 0; i < tot; i++) {
								obj = result['memList'][i];
								item = "<li>"
										+ obj.memberName
										+ "<a href=javascript:memDel('"
										+ i
										+ "')><img src='/images/popup/btn_close.gif' /></a>";
								item += "<input type='hidden' id='Dfc"+i+"' name='factCode' value='"+obj.factCode+"' />";
								item += "<input type='hidden' id='Dbn"+i+"' name='branchNo' value='"+obj.branchNo+"' />";
								item += "<input type='hidden' id='Dms"+i+"' name='memberSeq' value='"+obj.memberSeq+"' />";
								item += "</li>";
								$("#memList").append(item);
							}
						}
						$("#sysList").html("");
						if (tot1 <= 0) {
							item = "<li>등록된 그룹이 없습니다.</li>";
							$("#sysList").append(item);
						} else {
							for (var i = 0; i < tot1; i++) {
								obj = result['sysItemList'][i];
								item = "<li>" + obj.groupName + "</li>";
								$("#sysList").append(item);
							}
						}
						$("#riverDivName").html(obj.sysKind);

						closeLoading();
					},
					error : function(result) {
						// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
						var oraErrorCode = "";
						if (result.responseText != null) {
							var matchedValue = result.responseText
									.match(/ORA-[0-9]{5}/);
							if (matchedValue != null && matchedValue.length > 0) {
								oraErrorCode = matchedValue[0].replace('ORA-',
										'');
							}
						}
						$("#memList").html(
								"<tr><td colspan='12'>서버 접속에 실패하였습니다! [CODE:"
										+ oraErrorCode + "]</td></td>");
						closeLoading();
					}
				});
	}

	//Usn 관리 리스트
	function getUsnList(obj) {
		var objs = JSON.parse(StringtoJson(obj));
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;
		var sysKind = objs.sysKind;
		$("#fc").val(factCode);
		$("#bc").val(branchNo);
		// 		var usnBranchNameTxt = "["+objs.branchName+"-"+branchNo+"]"+"_USN이력관리";

		// 		$("#usnBranchNameTxt").html(usnBranchNameTxt);

		$("#usnBranchName").html(objs.branchName + "-" + branchNo);
		showLoading();
		$("#usnDataList").html("");

		var indate = "";
		var outdate = "";

		layerPopCloseAll();

		if (sysKind == "U") {
			$("#usnAdd").attr("style", "display: block");
			$
					.ajax({
						type : "post",
						url : "<c:url value='/spotmanage/getUsnList.do'/>",
						data : {
							factCode : factCode,
							branchNo : branchNo
						},
						dataType : "json",
						success : function(result) {
							var tot = result['getUsnList'].length;
							if (tot <= 0) {

							} else {
								for (var i = 0; i < tot; i++) {
									var obj = result['getUsnList'][i];
									var pageInfo = result['paginationInfo'];
									var no = i
											+ ((pageInfo.currentPageNo - 1) * pageInfo.recordCountPerPage)
											+ 1;
									var item;

									trclass = "";
									if (i % 2 == 1)
										trclass = "class=\"even\"";

									var trNo = i + 1;
									item = "<tr "
											+ trclass
											+ " id='usntr"
											+ trNo
											+ "' class='tr"
											+ i
											+ "' onclick=\"javascript:clickTrEventUSN(this,'"
											+ obj.frdate + "','" + obj.itemseq
											+ "');\" style='cursor:pointer;'>";

									item += "<td>"
											+ no
											+ "<input type='hidden' id='is"+i+"' value="+obj.itemseq+" /></td>"
											+ "<td>" + obj.frdate + "</td>" ///  시작일
											+ "<td>" + obj.longitude + "</td>" /// X좌표
											+ "<td>" + obj.latitude + "</td>" /// Y좌표
											+ "<td>" + obj.branchName + "</td>"
											+ "<td>";

									if (obj.userFlag == "Y") {
										item += "사용";
										// 1번 
										if (trNo == 1) {
											startdate = obj.frdate; // 시작 : 지금
											enddate = obj.frdate; // 끝 : 지금
										} else { // 2번부터 시작 그대로 
											if (startdate == "") {
												startdate = obj.frdate;
											}
											enddate = obj.frdate; // 끝은 지금
										}

									} else {
										item += "미사용";
										enddate = obj.frdate; // 시작 : 이전 , 끝 : 지금
									}

									item += "</td><td>"
											+ obj.memo
											+ "</td>" // 내용
											+ "<input type='hidden' id='str"+obj.itemseq+"' name='indate' value='"+startdate+"' />"
											+ "<input type='hidden' id='end"+obj.itemseq+"' name='outdate' value='"+enddate+"' />"

											+ "<input type='hidden' id='fc"+obj.itemseq+"' name='factCode' value='"+obj.factCode+"' />"
											+ "<input type='hidden' id='bn"+obj.itemseq+"' name='branchNo' value='"+obj.branchNo+"' />";

									if (obj.userFlag == "N") {
										startdate = "";
										enddate = "";
									}
									item += "</tr>";
									$("#usnDataList").append(item);
									$("#usnDataList tr:odd").attr("class",
											"add");
								}
								indate = "";
								outdate = "";
							}
							closeLoading();
						},
						error : function(result) {
							// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
							var oraErrorCode = "";
							if (result.responseText != null) {
								var matchedValue = result.responseText
										.match(/ORA-[0-9]{5}/);
								if (matchedValue != null
										&& matchedValue.length > 0) {
									oraErrorCode = matchedValue[0].replace(
											'ORA-', '');
								}
							}
							;
							$("#usnDataList").html(
									"<tr><td colspan='12'>서버 접속에 실패하였습니다! [CODE:"
											+ oraErrorCode + "]</td></td>");
							closeLoading();
						}
					});
		} else {
			$("#usnDataList").html(
					"<tr><td colspan='9'> IP_USN만 사용이 가능합니다. </td></td>");
			$("#usnAdd").attr("style", "display: none");
		}

	}

	//설치 장비 리스트
	function getEqList(obj) {
		showLoading();
		var objs = JSON.parse(StringtoJson(obj));
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;
		var sysKind = objs.sysKind;
		$("#efc").val(factCode);
		$("#ebc").val(branchNo);
		$("#est").val(sysKind);

		$("#UsnfactCode").val(factCode);
		$("#UsnBranchNo").val(branchNo);

		$("#eqItemName").html(objs.branchName);
		$("#eqDataList").html("");
		$
				.ajax({
					type : "post",
					url : "<c:url value='/spotmanage/getEqList.do'/>",
					data : {
						factCode : factCode,
						branchNo : branchNo
					},
					dataType : "json",
					success : function(result) {
						var tot = result['getEqList'].length;
						if (tot <= 0) {

						} else {
							for (var i = 0; i < tot; i++) {
								var obj = result['getEqList'][i];
								var pageInfo = result['paginationInfo'];
								var no = i
										+ ((pageInfo.currentPageNo - 1) * pageInfo.recordCountPerPage)
										+ 1;
								var item;
								item = "<tr>";
								item += "<td>"
										+ no
										+ "<input type='hidden' id=es"+obj.eqSeq+" value="+obj.eqSeq+" /></td>"
										+ "<td>"
										+ obj.eqCode
										+ "</td>"
										+ "<td>"
										+ obj.itemName
										+ "</td>"
										+ "<td>"
										+ obj.introDate
										+ "</td>"
										+ "<td>"
										+ obj.outDate
										+ "</td>"
										+ "<td>"
										+ obj.conpanySeq
										+ "</td>"
										+ "<td>"
										+ obj.modelSeq
										+ "</td>"
										+ "<td><input type='button' id='btnAdminHistoryInfo' name='btnAdminHistoryInfo' value='관리이력' class='btn btn_basic' onclick='javascript:goAdminHistoryInfo("
										+ obj.eqSeq
										+ ");' alt='관리이력'/>"
										+ "<td>"
										+ obj.memo
										+ "</td>"
										+ "<td><input type='button' id='btnEqUpdate' name='btnEqUpdate' value='수정' class='btn btn_basic' onclick='javascript:eqUpdatePopup("
										+ obj.eqSeq
										+ ");' alt='수정'/>"
										+ "<input type='button' id='btnEqDelete' name='btnEqDelete' value='삭제' class='btn btn_basic' onclick='javascript:eqDel("
										+ obj.eqSeq + ");' alt='삭제'/>"
										+ "</td>";
								item += "<input type='hidden' id=efc"+obj.eqSeq+" value="+obj.factCode+" />";
								item += "<input type='hidden' id=ebc"+obj.eqSeq+" value="+obj.branchNo+" />";
								item += "</tr>";
								$("#eqDataList").append(item);
								$("#eqDataList tr:odd").attr("class", "add");
							}
						}
						closeLoading();
					},
					error : function(result) {
						// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
						var oraErrorCode = "";
						if (result.responseText != null) {
							var matchedValue = result.responseText
									.match(/ORA-[0-9]{5}/);
							if (matchedValue != null && matchedValue.length > 0) {
								oraErrorCode = matchedValue[0].replace('ORA-',
										'');
							}
						}
						$("#eqDataList").html(
								"<tr><td colspan='9'>서버 접속에 실패하였습니다! [CODE:"
										+ oraErrorCode + "]</td></td>");
						closeLoading();
					}
				});
	}

	//항목리스트
	function getItemList(obj) {
		var objs = JSON.parse(StringtoJson(obj));
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;
		var sysKind = objs.sysKind;
		if (sysKind == "A") {
			$("#btnMultiSave").hide();
		} else {
			$("#btnMultiSave").show();
		}
		//var sysType;
		// A=국가수질자동측정망
		// T=탁수모니터링
		// U=IP_USN
		// W=방류수질정보

		showLoading();

		$("#itemDataList").html("");
		$
				.ajax({
					type : "post",
					url : "<c:url value='/spotmanage/getItemList.do'/>",
					data : {
						factCode : factCode,
						branchNo : branchNo,
						sysType : sysKind
					},
					dataType : "json",
					success : function(result) {
						var tot = result['branchItemList'].length;
						var tot1 = result['getItemList'].length;

						itemList = result['getItemList'];
						$("#itemCnt").val(tot);
						if (tot <= 0) {
							$("#itemDataList")
									.html(
											"<tr><td colspan='9'> 조회 데이터가 없습니다. </td></tr>");
						} else {
							var noi = 0;
							for (var i = 0; i < tot; i++) {

								var obj = result['branchItemList'][i];
								if (obj.itemCode != "LTX00"
										&& obj.itemCode != "RTX00") {
									noi++;

									var pageInfo = result['paginationInfo'];
									var no = i
											+ ((pageInfo.currentPageNo - 1) * pageInfo.recordCountPerPage)
											+ 1;
									var item;
									var itemFlag = false;
									for (var j = 0; j < tot1; j++) {
										var obj1 = result['getItemList'][j];

										if (obj.itemCode != null
												&& obj1.itemCode != null) {
											if (obj.itemCode == obj1.itemCode) {
												itemFlag = true;
												var selected = "selected";
												var nullText = null;
												item = "<tr>"
														+ "<td>"
														+ noi
														+ "<input type='hidden' id='itemCode"+i+"' name='itemCode"+i+"' value='"+obj.itemCode+"' /><input type='hidden' id='insertCheck"+i+"' name='insertCheck"+i+"' value='update' /></td>"
														+ "<td>"
														+ obj.itemName
														+ "</td>"
														+ "<td><input type='text' id='itemValueHi"+i+"' name='itemValueHi"+i+"' value='"+obj.itemValueHi+"' style='width:60px;' /></td>"
														+ "<td><input type='text' id='itemValueLo"+i+"' name='itemValueLo"+i+"' value='"+obj.itemValueLo+"' style='width:60px;' /></td>";
												/*
												+ "<td>";
												item += obj.legYn == 'Y' ? "<input type='checkbox' id=legYn"+i+" name='legYn' value='"+i+"' checked='checked'/>"
												: "<input type='checkbox' id=legYn"+i+" name='legYn' value='"+i+"' />";
												item += "</td>";
												 */
												item += "<td><input type='text' id='drySeasonFromMm"+i+"' name='drySeasonFromMm"+i+"' value='"+obj.drySeasonFromMm+"' style='width:60px;' /></td>"
														+ "<td><input type='text' id='drySeasonToMm"+i+"' name='drySeasonToMm"+i+"' value='"+obj.drySeasonToMm+"' style='width:60px;' /></td>"
														+ "<td><input type='text' id='itemDryValueHi"+i+"' name='itemDryValueHi"+i+"' value='"+obj.itemDryValueHi+"' style='width:60px;' /></td>"
														+ "<td><input type='text' id='itemDryValueLo"+i+"' name='itemDryValueLo"+i+"' value='"+obj.itemDryValueLo+"' style='width:60px;' /></td>";
												item += "<td>";
												item += obj.drySeasonYn == 'Y' ? "<input type='checkbox' id=drySeasonYn"+i+" name='drySeasonYn' value='"+i+"' checked='checked'/>"
														: "<input type='checkbox' id=drySeasonYn"+i+" name='drySeasonYn' value='"+i+"' />";
												item += "</td>";

												item += "<td>";
												item += "<input type='text' id='timeDurVal"+i+"' name='timeDurVal"+i+"' value='"+obj.timeDurVal+"' style='width:60px;' />";
												item += "</td>";
												item += "<td>";
												item += obj.standYn == 'Y' ? "<input type='checkbox' id=standYn"+i+" name='standYn' value='"+i+"' checked='checked'/>"
														: "<input type='checkbox' id=standYn"+i+" name='standYn' value='"+i+"' />";
												item += "</td>";
												/*
													item+="<td><input type='text' style='width:60px;' /></td>";
													item+="<td><input type='checkbox' /></td>";
												 */
												item += "</tr>";
												item += obj.userFlag == 'Y' ? "<input type='hidden' id=AllSave"+i+" name='AllSave' value='"+i+"' />"
														: "<input type='hidden' id='AllSave"+i+"' name='AllSave' value='"+i+"' />";
											}
										}

									}
									if (!itemFlag) {
										item = "<tr>"
												+ "<td>"
												+ noi
												+ "<input type='hidden' id='itemCode"+i+"' name='itemCode"+i+"' value='"+obj.itemCode+"' /><input type='hidden' id='insertCheck"+i+"' name='insertCheck"+i+"' value='insert' /></td>"
												+ "<td>"
												+ obj.itemName
												+ "</td>"
												+ "<td><input type='text' id='itemValueHi"+i+"' name='itemValueHi"+i+"' value='"+obj.itemValueHi+"' style='width:60px;' /></td>"
												+ "<td><input type='text' id='itemValueLo"+i+"' name='itemValueLo"+i+"' value='"+obj.itemValueLo+"' style='width:60px;' /></td>";
										/*
										+ "<td>";
										item += obj.legYn == 'Y' ? "<input type='checkbox' id=legYn"+i+" name='legYn' value='"+i+"' checked='checked'/>"
										: "<input type='checkbox' id=legYn"+i+" name='legYn' value='"+i+"' />";
										item += "</td>";
										 */
										item += "<td><input type='text' id='drySeasonFromMm"+i+"' name='drySeasonFromMm"+i+"' value='"+obj.drySeasonFromMm+"' style='width:60px;' /></td>"
												+ "<td><input type='text' id='drySeasonToMm"+i+"' name='drySeasonToMm"+i+"' value='"+obj.drySeasonToMm+"' style='width:60px;' /></td>"
												+ "<td><input type='text' id='itemDryValueHi"+i+"' name='itemDryValueHi"+i+"' value='"+obj.itemDryValueHi+"' style='width:60px;' /></td>"
												+ "<td><input type='text' id='itemDryValueLo"+i+"' name='itemDryValueLo"+i+"' value='"+obj.itemDryValueLo+"' style='width:60px;' /></td>"
										item += "<td>";
										item += obj.legYn == 'Y' ? "<input type='checkbox' id=drySeasonYn"+i+" name='drySeasonYn' value='"+i+"' checked='checked'/>"
												: "<input type='checkbox' id=drySeasonYn"+i+" name='drySeasonYn' value='"+i+"' />";
										item += "</td>";

										item += "<td>";
										item += "<input type='text' id='timeDurVal"+i+"' name='timeDurVal"+i+"' value='"+obj.timeDurVal+"' style='width:60px;' />";
										item += "</td>";
										item += "<td>";
										item += obj.standYn == 'Y' ? "<input type='checkbox' id=standYn"+i+" name='standYn' value='"+i+"' checked='checked'/>"
												: "<input type='checkbox' id=standYn"+i+" name='standYn' value='"+i+"' />";
										item += "</td>";
										/*
										item+="<td><input type='text' style='width:60px;' /></td>";
										item+="<td><input type='checkbox' /></td>";
										 */
										item += "</tr>";

										item += obj.userFlag == 'Y' ? "<input type='hidden' id=AllSave"+i+" name='AllSave' value='"+i+"' />"
												: "<input type='hidden' id='AllSave"+i+"' name='AllSave' value='"+i+"' />";
									}
									$("#itemDataList").append(item);
									$("#itemDataList tr:odd").attr("class",
											"add");

								}

							}
						}
						closeLoading();
					},
					error : function(result) {
						// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
						var oraErrorCode = "";
						if (result.responseText != null) {
							var matchedValue = result.responseText
									.match(/ORA-[0-9]{5}/);
							if (matchedValue != null && matchedValue.length > 0) {
								oraErrorCode = matchedValue[0].replace('ORA-',
										'');
							}
						}
						$("#dataList").html(
								"<tr><td colspan='9'>서버 접속에 실패하였습니다! [CODE:"
										+ oraErrorCode + "]</td></td>");
						closeLoading();
					}
				});
	}

	function EventDiv(obj) {
		if (obj != undefined) {
			EventDivobj = obj;
		}
		getSpotView(EventDivobj);
		getUsnList(EventDivobj);
		getEqList(EventDivobj);
		getItemList(EventDivobj);
		getSmsList(EventDivobj);
	}

	function LayerDiv(div) {
		for (var j = 1; j <= 4; j++) {
			var pop = document.getElementById("tpl_tab_" + j);
			if (div == j) {
				pop.style.display = "block";
			} else {
				pop.style.display = "none";
			}
		}
		layerPopCloseAll();//DIV 전환시 레이어 닫기
	}

	// 페이지 번호 클릭
	function linkPage(pageNo) {
		reloadData(pageNo);
	}

	//담당자 불러오기
	function memberDiv() {
		if ($("#factCode").html() == "") {
			alert("지점을 선택하여주세요.");
			return;
		}
		layerPopOpen("layerMember");
		var branchName = $("#memIdSearchTxt").val();
		$("#MemberList").html("");
		var searchText;
		if ($("#memIdSearchTxt").val() != "") {
			searchText = branchName;
		} else {
			searchText = "";
		}
		showLoading();

		var factCode = $("#factCode").html();
		var branchNo = $("#branchNo").val();

		$
				.ajax({
					type : "post",
					url : "<c:url value='/spotmanage/getMemberList.do'/>",
					data : {
						factCode : factCode,
						branchNo : branchNo,
						searchText : searchText
					},
					dataType : "json",
					success : function(result) {
						var tot = result['getMemberList'].length;
						var item;
						if (tot <= 0) {
							item = "<tr><td colspan='3'>조회 결과가 없습니다.</td></tr>"
							$("#MemberList").html(item);
						} else {
							for (var i = 0; i < tot; i++) {
								obj = result['getMemberList'][i];
								item = "<tr>"
										+ "<td id=mi"+i+">"
										+ obj.memberId
										+ "</td><td>"
										+ obj.memberName
										+ "</td>"
										// 						+ "<td><a href='javascript:memberInsert("+i+")' style='selector-dummy:expression(this.hideFocus=false);' class='btn_mng'><span><em>추가</em></span></a>&nbsp;</td>"
										+ "<td><input type='button' id='btnMemberInsert' name='btnMemberInsert' value='추가' class='btn btn_basic' onclick='javascript:memberInsert("
										+ i + ")' alt='추가'/></td>" + "</tr>";

								$("#MemberList").append(item);
								$("#MemberList tr:odd").attr("class", "add");
							}
						}
						closeLoading();
					},
					error : function(result) {
						// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
						var oraErrorCode = "";
						if (result.responseText != null) {
							var matchedValue = result.responseText
									.match(/ORA-[0-9]{5}/);
							if (matchedValue != null && matchedValue.length > 0) {
								oraErrorCode = matchedValue[0].replace('ORA-',
										'');
							}
						}
						$("#MemberList").html(
								"<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:"
										+ oraErrorCode + "]</td></td>");
						closeLoading();
					}
				});
	}
	// 페이지 네비게이션 만들기
	function makePaginationInfo_(result) {
		var str = "";

		if (result.currentPageNo > result.pageSize) {
			str += "<li><a style='cursor:pointer' onclick=\"linkPage_('"
					+ result.firstPageNo + "')\">[처음]</a></li>";
			str += "<li><a style='cursor:pointer' onclick=\"linkPage_('"
					+ (result.firstPageNoOnPageList - 1) + "')\">[이전]</a></li>";
		}

		var idx = 0;
		for (var i = result.firstPageNoOnPageList; i <= result.lastPageNoOnPageList; i++) {
			if (result.currentPageNo == i) {
				str += "<li><em>" + i + "</em></li>";
			} else {
				str += "<li><a style='cursor:pointer' onclick=\"linkPage_('"
						+ i + "')\">" + i + "</a></li>";
			}
			idx++;
		}

		if (result.currentPageNo < result.lastPageNo && idx == result.pageSize
				&& result.pageSize < result.lastPageNo) {
			str += "<li><a style='cursor:pointer' onclick=\"linkPage_('"
					+ (result.lastPageNoOnPageList + 1) + "')\">[다음]</a></li>";
			str += "<li><a style='cursor:pointer' onclick=\"linkPage_('"
					+ result.lastPageNo + "')\">[마지막]</a></li>";
		}

		return str;
	}
	// divPopUp 페이지 번호 클릭
	function linkPage_(pageNo) {
		getSpotInfoA(pageNo);
	}
	//체크박스 전체선택
	function fncCheckAll() {
		var checkField = document.listForm.delYn;
		if (document.listForm.checkAll.checked) {
			if (checkField) {
				if (checkField.length > 1) {
					for (var i = 0; i < checkField.length; i++) {
						checkField[i].checked = true;
					}
				} else {
					checkField.checked = true;
				}
			}
		} else {
			if (checkField) {
				if (checkField.length > 1) {
					for (var j = 0; j < checkField.length; j++) {
						checkField[j].checked = false;
					}
				} else {
					checkField.checked = false;
				}
			}
		}
	}
	//체크박스 선택된 항목
	function fncManageChecked() {

		var resultCheck = false;

		var checkField = document.listForm.delYn;
		var checkId = document.listForm.checkId;

		var returnId = "";

		var checkedCount = 0;
		if (checkField) {
			if (checkField.length > 1) {
				for (var i = 0; i < checkField.length; i++) {
					if (checkField[i].checked) {

						checkedCount++;
						checkField[i].value = checkId[i].value;
						if (returnId == "") {
							returnId = checkField[i].value;

						} else {
							returnId = returnId + ":" + checkField[i].value;

						}
					}
				}

				if (checkedCount > 0)
					resultCheck = true;
				else {
					alert("선택된  항목이 없습니다.");
					resultCheck = false;
				}

			} else {
				if (document.listForm.delYn.checked == false) {
					alert("선택 항목이 없습니다.");
					resultCheck = false;
				} else {
					returnId = checkId.value;

					resultCheck = true;
				}
			}
		} else {
			alert("조회된 결과가 없습니다.");
		}

		document.listForm.factCode.value = returnId;

		return resultCheck;
	}

	function fnSoptInfoAUpdate() {
		if (fncManageChecked()) {
			if (confirm("변경사항을 저장하시겠습니까?")) {
				document.listForm.action = "<c:url value='/spotmanage/saveSpotInfoA.do'/>";
				document.listForm.submit();
			}
		} else
			return;
	}

	//국가수질 - 측정소변경내용 조회
	function getSpotInfoA(pageNo) {

		layerPopOpen("layerSpotInfoUpdate");

		$("#spotInfoUpdate").html("");

		showLoading();

		if (pageNo == null)
			pageNo = 1;
		$
				.ajax({
					type : "post",
					url : "<c:url value='/spotmanage/getSpotInfoA.do'/>",
					data : {
						pageIndex : pageNo
					},
					dataType : "json",
					success : function(result) {
						var tot = result['spotInfoList'].length;

						var item;
						if (tot <= 0) {
							item = "<tr><td colspan='14' style='height:316px;'>조회 결과가 없습니다.</td></tr>"
							$("#spotInfoUpdate").html(item);
						} else {
							for (var i = 0; i < tot; i++) {
								var obj = result['spotInfoList'][i];
								var pageInfo = result['paginationInfo'];
								//obj.no = no;
								var no = i
										+ ((pageInfo.currentPageNo - 1) * pageInfo.recordCountPerPage)
										+ 1;
								item += "<tr>"
										+ "<td class='noOption'><input type='checkbox' name='delYn' class='check2'><input type='hidden' name='checkId' value="+obj.factCode+" />"

										+ "</td>" + "<td><span>"
										+ no
										+ "</span></td>"
										+ "<td>"
										+ obj.factCode
										+ "</td>"
										+ "<td>"
										+ obj.factCode1
										+ "</td>"
										+ "<td>"
										+ obj.factName
										+ "</td>"
										+ "<td>"
										+ obj.factName1
										+ "</td>"
										+ "<td>"
										+ obj.riverDiv
										+ "</td>"
										+ "<td>"
										+ obj.riverDiv1
										+ "</td>"
										+ "<td>"
										+ obj.latitude
										+ "</td>"
										+ "<td>"
										+ obj.latitude1
										+ "</td>"
										+ "<td>"
										+ obj.longitude
										+ "</td>"
										+ "<td>"
										+ obj.longitude1
										+ "</td>"
										+ "<td>"
										+ obj.factAddr
										+ "</td>"
										+ "<td>"
										+ obj.factAddr1 + "</td>" + "</tr>";

							}
							// 페이징 정보
							var pageStr = makePaginationInfo_(result['paginationInfo']);
							$("#pagination2").empty();
							$("#pagination2").append(pageStr);
							$("#pPageNo").val(pageNo);

							$("#spotInfoUpdate").append(item);
							$("#spotInfoUpdate tr:odd").attr("class", "add");
						}
						closeLoading();
					},
					error : function(result) {
						// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
						var oraErrorCode = "";
						if (result.responseText != null) {
							var matchedValue = result.responseText
									.match(/ORA-[0-9]{5}/);
							if (matchedValue != null && matchedValue.length > 0) {
								oraErrorCode = matchedValue[0].replace('ORA-',
										'');
							}
						}
						$("#spotInfoUpdate").html(
								"<tr><td colspan='14' style='height:316px;'>서버 접속에 실패하였습니다! [CODE:"
										+ oraErrorCode + "]</td></td>");
						closeLoading();
					}
				});
	}

	//담당자 등록하기
	function memberInsert(index) {
		showLoading();

		var factCode = $("#factCode").html();
		var branchNo = $("#branchNo").val();
		var memberId = $("#mi" + index).html();

		$.ajax({
			type : "post",
			url : "<c:url value='/spotmanage/branchmemberInsert.do'/>",
			data : {
				factCode : factCode,
				branchNo : branchNo,
				memberId : memberId
			},
			dataType : "json",
			success : function(result) {
				$("#memList").html("");
				EventDiv();
				memberDiv();
				closeLoading();
			},
			error : function(result) {
				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
				var oraErrorCode = "";
				if (result.responseText != null) {
					var matchedValue = result.responseText
							.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				$("#MemberList").html(
						"<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:"
								+ oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}

	//담당자 삭제 쿼리
	function memDel(index) {
		if (confirm("담당자를 삭제 하시겠습니까?")) {
			showLoading();
			var factCode = $("#Dfc" + index).val();
			var branchNo = $("#Dbn" + index).val();
			var memberSeq = $("#Dms" + index).val();
			$.ajax({
				type : "post",
				url : "<c:url value='/spotmanage/branchmemberdel.do'/>",
				data : {
					factCode : factCode,
					branchNo : branchNo,
					memberSeq : memberSeq
				},
				dataType : "json",
				success : function(result) {
					$("#memList").html("");
					EventDiv();
					memberDiv();
					closeLoading();
				},
				error : function(result) {
					// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
					var oraErrorCode = "";
					if (result.responseText != null) {
						var matchedValue = result.responseText
								.match(/ORA-[0-9]{5}/);
						if (matchedValue != null && matchedValue.length > 0) {
							oraErrorCode = matchedValue[0].replace('ORA-', '');
						}
					}
					$("#MemberList").html(
							"<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:"
									+ oraErrorCode + "]</td></td>");
					closeLoading();
				}
			});
		}
	}

	// 측정일정추가 팝업
	function usnInsertPopup() {
		window
				.open(
						"<c:url value='/spotmanage/usninsertform.do'/>",
						'usnInsertPopup',
						'width=600,height=390,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,left=100,top=50');
	}

	// 측정장비추가 팝업
	function eqInsertPopup() {
		window
				.open(
						"<c:url value='/spotmanage/eqinsertform.do'/>",
						'eqInsertPopup',
						'width=600,height=450,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,left=100,top=50');
	}

	//수정 화면 팝업 요청
	function usnUpdatePopup(index) {
		window
				.open(
						"<c:url value='/spotmanage/usnupdateform.do'/>?index="
								+ index,
						'usnUpdatePopup',
						'width=600,height=390,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,left=100,top=50');
	}

	//측정장비 수정 화면 팝업 요청
	function eqUpdatePopup(index) {
		$("#UpdateSeq").val($("#es" + index).val());

		window
				.open(
						"<c:url value='/spotmanage/equpdateform.do'/>",
						'usnUpdatePopup',
						'width=600,height=450,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,left=100,top=50');
	}

	//usn 데이터 삭제 처리 (Update-User_flag='N')
	function usnDel(index) {
		var objs = JSON.parse(StringtoJson(EventDivobj));
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;
		var itemseq = index;

		showLoading();
		$.ajax({
			type : "post",
			url : "<c:url value='/spotmanage/usndel.do'/>",
			data : {
				factCode : factCode,
				branchNo : branchNo,
				itemseq : itemseq
			},
			dataType : "json",
			success : function(result) {
				var obj = result['result'];
				if (obj == "1") {
					$("#memList").html("");
					EventDiv();
				}
				closeLoading();
			},
			error : function(result) {
				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
				var oraErrorCode = "";
				if (result.responseText != null) {
					var matchedValue = result.responseText
							.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				$("#MemberList").html(
						"<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:"
								+ oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}

	//설치장비 데이터 삭제 처리 (Update-User_flag='N')
	function eqDel(index) {
		var objs = JSON.parse(StringtoJson(EventDivobj));
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;

		var eqSeq = $("#es" + index).val();

		showLoading();

		$.ajax({
			type : "post",
			url : "<c:url value='/spotmanage/eqDel.do'/>",
			data : {
				factCode : factCode,
				branchNo : branchNo,
				eqSeq : eqSeq
			},
			dataType : "json",
			success : function(result) {
				var obj = result['result'];
				if (obj == "1") {
					$("#memList").html("");
					EventDiv();
				}

				closeLoading();
			},
			error : function(result) {
				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
				var oraErrorCode = "";
				if (result.responseText != null) {
					var matchedValue = result.responseText
							.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				$("#MemberList").html(
						"<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:"
								+ oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}

	function fileDown(index) {
		var objs = JSON.parse(StringtoJson(EventDivobj));
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;

		// 		var itemseq = $("#is"+index).val();

		$("#UpdateSeq").val($("#is" + index).val());
		document.all.downFrame.src = "<c:url value='/spotmanage/fileDownform.do'/>";
	}

	function golayerUsnHistoryInfo() {
		var pop = document.getElementById("layerUsnHistory");
		pop.style.display = "block";
		pop.style.top = "50%";
		pop.style.left = "50%";

		var objs = JSON.parse(StringtoJson(EventDivobj));
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;

		var UsnHsInfoDate = $("#UsnHistoryInfoDate").val();
		showLoading();

		var item;
		$("#UsnHistoryInfo").html("");

		$
				.ajax({
					type : "post",
					url : "<c:url value='/spotmanage/getEqHsList.do'/>",
					data : {
						factCode : factCode,
						branchNo : branchNo,
						eqSeqHsNo : eqSeqHsNo
					},
					dataType : "json",
					success : function(result) {
						var tot = result['getEqHsList'].length;

						if (tot <= 0) {
							item = "<tr><td colspan='8'  align='center'>조회 결과가 없습니다.</td></tr>"
							$("#UsnHistoryInfo").html(item);
						} else {
							for (var i = 0; i < tot; i++) {
								obj = result['getEqHsList'][i];
								item = "<tr><a href='javascript:goAHView(" + i
										+ "," + obj.hsSeq + ")'>";
								item += "<td>" + obj.crtDate + "</td>";
								if (obj.content.length > 10) {
									item += "<td>"
											+ obj.content.substring(0, 10)
											+ "....</td>";
								} else {
									item += "<td>" + obj.content + "</td>";
								}
								item += "<td><div style='position:absolute;display:none;border:1px solid #ccc;padding:10px;background:White;'><textarea id=AHistory"+i+">"
										+ obj.content
										+ " </textarea></div></td>";
								item += "</a></tr>";
								$("#UsnHistoryInfo").append(item);
								$("#UsnHistoryInfo tr:odd")
										.attr("class", "add");
							}
						}
						closeLoading();
					},
					error : function(result) {
						// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
						var oraErrorCode = "";
						if (result.responseText != null) {
							var matchedValue = result.responseText
									.match(/ORA-[0-9]{5}/);
							if (matchedValue != null && matchedValue.length > 0) {
								oraErrorCode = matchedValue[0].replace('ORA-',
										'');
							}
						}
						$("#AdminHistoryInfo").html(
								"<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:"
										+ oraErrorCode + "]</td></td>");
						closeLoading();
					}
				});
	}

	function adminHistoryInsert() {
		var objs = JSON.parse(StringtoJson(EventDivobj));
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;

		var eqSeq = $("#UpdateSeq").val();
		var content = $("#ahCoutent").val();

		if (content != "") {
			$.ajax({
				type : "post",
				url : "<c:url value='/spotmanage/adminHistoryInsert.do'/>",
				data : {
					factCode : factCode,
					branchNo : branchNo,
					eqSeq : eqSeq,
					content : content
				},
				dataType : "json",
				success : function(result) {
					$("#AdminHistoryInfo").html("");
					$("#ahCoutent").val("");
					goAdminHistoryInfo(eqSeq);
					closeLoading();
				},
				error : function(result) {
					// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
					var oraErrorCode = "";
					if (result.responseText != null) {
						var matchedValue = result.responseText
								.match(/ORA-[0-9]{5}/);
						if (matchedValue != null && matchedValue.length > 0) {
							oraErrorCode = matchedValue[0].replace('ORA-', '');
						}
					}
					$("#MemberList").html(
							"<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:"
									+ oraErrorCode + "]</td></td>");
					closeLoading();
				}
			});
		} else {
			alert("관리이력을 입력해주세요.");
			$("#ahCoutent").foucs();
		}
	}

	function goAHView(index, hsSeq) {
		$("#hsSeq").val(hsSeq);
		$("#hsView").val($("#AHistory" + index).val());
		var pop = document.getElementById("layerUpdateDel");
		pop.style.display = "block";
		pop.style.top = "50%";
		pop.style.left = "50%";
	}

	function adminHistoryUpdate() {
		var objs = JSON.parse(StringtoJson(EventDivobj));
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;

		var eqSeq = $("#UpdateSeq").val();
		var hsSeq = $("#hsSeq").val();
		var content = $("#hsView").val();

		if (content != "") {
			$.ajax({
				type : "post",
				url : "<c:url value='/spotmanage/adminHistoryUpdate.do'/>",
				data : {
					factCode : factCode,
					branchNo : branchNo,
					eqSeq : eqSeq,
					hsSeq : hsSeq,
					content : content
				},
				dataType : "json",
				success : function(result) {
					goAdminHistoryInfo(eqSeq);
					layerPopClose('layerUpdateDel');
					closeLoading();
				},
				error : function(result) {
					// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
					var oraErrorCode = "";
					if (result.responseText != null) {
						var matchedValue = result.responseText
								.match(/ORA-[0-9]{5}/);
						if (matchedValue != null && matchedValue.length > 0) {
							oraErrorCode = matchedValue[0].replace('ORA-', '');
						}
					}
					$("#MemberList").html(
							"<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:"
									+ oraErrorCode + "]</td></td>");
					closeLoading();
				}
			});
		} else {
			alert("관리이력을 입력해주세요.");
			$("#hsView").foucs();
		}
	}
	function adminHistoryDel() {
		var objs = JSON.parse(StringtoJson(EventDivobj));
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;

		var eqSeq = $("#UpdateSeq").val();
		var hsSeq = $("#hsSeq").val();

		$.ajax({
			type : "post",
			url : "<c:url value='/spotmanage/adminHistorydel.do'/>",
			data : {
				factCode : factCode,
				branchNo : branchNo,
				eqSeq : eqSeq,
				hsSeq : hsSeq
			},
			dataType : "json",
			success : function(result) {
				layerPopClose('layerUpdateDel');
				goAdminHistoryInfo(eqSeq);
				closeLoading();
			},
			error : function(result) {
				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
				var oraErrorCode = "";
				if (result.responseText != null) {
					var matchedValue = result.responseText
							.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				$("#MemberList").html(
						"<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:"
								+ oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}

	//측정소신규등록 팝업창
	function spotManageInsertPop() {
		window
				.open(
						"<c:url value='/spotmanage/spotManageInsertPop.do'/>",
						'spotManageInsertPop',
						'width=550,height=410,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,left=100,top=50');
	}

	//측정소수정 팝업창
	function spotManageUpdatePop() {
		window
				.open(
						"<c:url value='/spotmanage/spotManageUpdatePop.do'/>",
						'spotManageUpdatePop',
						'width=550,height=410,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,left=100,top=50');
	}

	// 	function SingleSave(index){
	// 		var vRow = $("#indexNum").val();
	// 		var objs = dataView.getItem(vRow);
	// 		var factCode = objs.factCode;
	// 		var branchNo = objs.branchNo;

	// 		var itemCode = $("#itemCode"+index).val();
	// 		var itemValueHi = $("#itemValueHi"+index).val();
	// 		var itemValueLo = $("#itemValueLo"+index).val();
	// 		var legYn = $("#legYn"+index).attr("checked")?"Y":"N";
	// 		var AllSave;

	// 		if($("#AllSave"+index).attr("checked")){
	// 			AllSave = 'Y';
	// 		}else{
	// 			AllSave = 'N';
	// 		}
	// 		$.ajax({
	// 			type:"post",
	// 			url:"<c:url value='/spotmanage/SingleSave.do'/>",
	// 			data:{
	// 				factCode:factCode
	// 				,branchNo:branchNo
	// 				,itemCode:itemCode
	// 				,itemValueHi:itemValueHi
	// 				,itemValueLo:itemValueLo
	// 				,legYn:legYn
	// 				,allSave:AllSave
	// 			},
	// 			dataType:"json",
	// 			success:function(result){
	// 				EventDiv($("#indexNum").val());
	// 				closeLoading();
	// 			},
	// 			error:function(result){
	// 				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
	// 				var oraErrorCode = "";
	// 				if (result.responseText != null ) {
	// 					var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);
	// 					if (matchedValue != null && matchedValue.length > 0) { 
	// 						oraErrorCode = matchedValue[0].replace('ORA-', '');	
	// 					}
	// 				}
	// 				$("#MemberList").html("<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
	// 				closeLoading();
	// 			}
	// 		});
	// 	}

	//4탭 항목관리의 저장
	function MultiSave() {
		var objs = JSON.parse(StringtoJson(EventDivobj));
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;
		if ($("input[name=AllSave]").length > 0) {
			for (var i = 0; i < $("input[name=AllSave]").length; i++) {
				var data = $("input[name=AllSave]")[i];
				var itemCode = $("#itemCode" + data.value).val();
				var legYn = $("#legYn" + i).attr("checked") ? "Y" : "N";
				var itemValueHi = $("#itemValueHi" + i).val();
				var itemValueLo = $("#itemValueLo" + i).val();
				var drySeasonYn = $("#drySeasonYn" + i).attr("checked") ? "Y"
						: "N";
				var drySeasonFromMm = $("#drySeasonFromMm" + i).val();
				var drySeasonToMm = $("#drySeasonToMm" + i).val();
				var itemDryValueHi = $("#itemDryValueHi" + i).val();
				var itemDryValueLo = $("#itemDryValueLo" + i).val();

				var timeDurVal = $("#timeDurVal" + i).val();
				var standYn = $("#standYn" + i).attr("checked") ? "Y" : "N";

				var AllSave;
				var insertCheck = $("#insertCheck" + i).val();

				if (data.checked) {
					AllSave = "Y";
				} else {
					AllSave = "N";
				}

				var Multi;
				Multi = insertCheck;

				$
						.ajax({
							type : "post",
							url : "<c:url value='/spotmanage/goMultiSave.do'/>",
							data : {
								factCode : factCode,
								branchNo : branchNo,
								itemCode : itemCode,
								itemValueHi : itemValueHi,
								itemValueLo : itemValueLo,
								legYn : legYn,
								drySeasonFromMm : drySeasonFromMm,
								drySeasonToMm : drySeasonToMm,
								itemDryValueHi : itemDryValueHi,
								itemDryValueLo : itemDryValueLo,
								drySeasonYn : drySeasonYn,

								timeDurVal : timeDurVal,
								standYn : standYn,

								allSave : AllSave,
								userFlag : Multi
							},
							dataType : "json",
							success : function(result) {
								closeLoading();
							},
							error : function(result) {
								// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
								var oraErrorCode = "";
								if (result.responseText != null) {
									var matchedValue = result.responseText
											.match(/ORA-[0-9]{5}/);
									if (matchedValue != null
											&& matchedValue.length > 0) {
										oraErrorCode = matchedValue[0].replace(
												'ORA-', '');
									}
								}
								$("#MemberList").html(
										"<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:"
												+ oraErrorCode + "]</td></td>");
								closeLoading();
							}
						});
			}
			EventDiv();
		}
	}

	//지점 등록 기능
	function saveBranchReg() {
		var factCode = $("#branchRegForm [name=fact_code]").val();
		var factName = $("#branchRegForm [name=fact_name]").val();
		var riverDiv = $("#branchRegForm [name=river_div]").val();
		var sysKind = $("#branchRegForm [name=sys_kind]").val();
		var factIp = $("#branchRegForm [name=fact_ip]").val();

		if (factCode == null || factCode == "") {
			alert("지점 코드를 넣어주세요.");
			return;
		}
		//alert("branchRegForm");
		if (factName == null || factName == "") {
			alert("지점이름을 넣어주세요.");
			return;
		}

		if (riverDiv == null || riverDiv == "") {
			alert("수계를 선택해주세요.");
			return;
		}

		if (sysKind == null || sysKind == "") {
			alert("시스템을선택해주세요.");
			return;
		}

		if (factIp == null || factIp == "") {
			alert("아이피를 넣어주세요.");
			return;
		}

		$('#branchRegForm').ajaxForm({
			success : function(result) {
				alert("저장했습니다");
				//getSystemList();
				layerPopCloseAll();
			}
		}).submit();
	}

	function excelDown() {
		var riverDiv = $("select[name=c_river_div]").val();
		var sysKind = $("select[name=c_sys_kind]").val();
		var branchName = $("#c_branch_name").val();
		var searchText;

		if ($("#c_branch_name").val() != "") {
			searchText = branchName;
		} else {
			searchText = "";
		}
		var param = "sysKind=" + sysKind + "&riverDiv=" + riverDiv
				+ "& searchText=" + searchText;
		location.href = "<c:url value='/spotmanage/getExcelSpotmgrList.do'/>?"
				+ param;
	}

	function popupMapOpen(longitude, latitude) {
		// 		var longitude = $("#rlongitude").val();
		// 		var latitude = $("#rlatitude").val();

		if (longitude == "" || latitude == "") {
			alert("지점을 선택하신 후  지도보기를 해주세요.");
			return;
		}

		window
				.open(
						"/psupport/WPCS_POP.html?riverid=" + user_riverid
								+ "&menuid=spot&longitude=" + longitude
								+ "&latitude=" + latitude,
						'wpcsView',
						'width='
								+ window.screen.width
								+ ',height='
								+ window.screen.height
								+ ',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left=0,top=0');
	}

	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("layerMember");
		layerPopClose("layerUpdateDel");
		layerPopClose("layerBranchReg");
		layerPopClose("layerUsnHistory");
		layerPopClose("layerBranchModify");
		layerPopClose("factinfoLayer");
		layerPopClose("memberLayer");
		layerPopClose("layerEquipInfoReg")
	}

	function LayerPopEditOpen(flag) {

		if (flag == "reg") {
			// 등록을 위한 레이어에 초기화
			$("#sys_kind").val("");
			$("#fact_code").val("");
			$("#river_div").val("");
			$("#river_no").val("");
			$("#fact_name").val("");
			$("#branch_no").val("");
			$("#branch_name").val("");
			$("#fact_addr").val("");
			$("#longitude1").val("")
			$("#latitude1").val("");
			$("#branch_mgr").val("");
			$("#branch_mgr_name").val("");
			$("#branch_mgr_tel_no").val("");

			$("#btnBranchRegMod").attr({
				value : "등록",
				alt : "등록"
			});
			$("#branch_use_flag > option:first").attr("selected", "true");
			$("#fact_name").attr("disabled", false);
			$("#btnFactSearch").attr("disabled", false);
		} else {
			if (EventDivobj == null) {
				alert("지점을 선택 하신 후 수정하여 주십시오.");
				return;
			} else {
				var obj = JSON.parse(StringtoJson(EventDivobj));

				getFactbranchInfoAdd(obj.factCode, obj.branchNo);
			}
			$("#btnBranchRegMod").attr({
				value : "수정",
				alt : "수정"
			});
			$("#fact_name").attr("disabled", true);
			$("#btnFactSearch").attr("disabled", true);
		}
		$("#mode").val(flag);
		layerPopOpen("layerBranchModify");
	}

	//지점코드로 측정소에 대한 정보 가져오기
	function getFactbranchInfoAdd(factCode, branchNo) {
		showLoading();

		$.ajax({
			type : "post",
			url : "<c:url value='/spotmanage/getFactbranchInfoAdd.do'/>",
			data : {
				fact_code : factCode,
				branch_no : branchNo
			},
			dataType : "json",
			success : function(result) {
				// 				console.log("getFactbranchInfoAdd result : ",result);
				var tot = result['getFactbranchInfoAdd'].length;

				if (tot <= 0) {
					alert("조회 결과가 없습니다.");
				} else {
					var obj = result['getFactbranchInfoAdd'][0];

					$("#sys_kind").val(obj.sys_kind);
					$("#fact_code").val(obj.fact_code);
					$("#fact_name").val(obj.fact_name);
					$("#river_div").val(obj.river_div);
					$("#river_no").val(obj.river_no);
					$("#branch_no").val(obj.branch_no);
					$("#branch_name").val(obj.branch_name);
					$("#fact_addr").val(obj.fact_addr);
					$("#latitude1").val(obj.latitude);
					$("#longitude1").val(obj.longitude);
					$("#branch_mgr").val(obj.branch_mgr);
					$("#branch_mgr_name").val(obj.branch_mgr_name);
					$("#branch_mgr_tel_no").val(obj.branch_mgr_tel_no);

					$("#branch_use_flag_ord").val(obj.branch_use_flag);

					if (obj.branch_use_flag == "Y")
						$("#branch_use_flag > option:first").attr("selected",
								"true");
					else
						$("#branch_use_flag > option:last").attr("selected",
								"true");
				}
				closeLoading();
			},
			error : function(result) {
				var oraErrorCode = "";
				if (result.responseText != null) {
					var matchedValue = result.responseText
							.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				closeLoading();
			}
		});
	}

	function validateItem() {

		if ($('#fact_name').val().length == 0) {
			alert("사업장을 선택해 주세요");
			return false;
		}

		if ($('#branch_name').val().length < 2) {
			alert("측정소명을 넣어주세요(2자리이상)");
			return false;
		}

		if ($("#latitude1").val().length == 0) {
			alert('좌표를 선택해 주세요');
			return false;
		}

		if ($("#branch_mgr_name").val().length == 0
				|| $("#branch_mgr_tel_no").val().length == 0) {
			alert("관리자를 선택해주세요");
			return false;
		}

		//		if($("#leave_distance").val().length == 0){
		//			if (!confirm("유효거리를 설정하지 않았습니다.\n계속하시려면'예' 아니시면 아니오를 누르세요.")){
		//				return false;
		//			}
		//		}
		return true;
	}

	function addzero(n) {
		return n < 10 ? "0" + n : n + "";
	}

	//등록,수정
	function updateFactBranch() {
		var factCode = $("#fact_code").val();
		var sysKind = $("#sys_kind").val();
		var mode = $("#mode").val();
		var pageNo = $("#rpage").val(); //측정소 수정을 위한 페이지 확인
		var branchUseFlag = $("#branch_use_flag").val();
		var modeName = "수정";

		var updateFlag = null;

		if (validateItem() == true) {

			if (sysKind == "A" || sysKind == "U") {

				var date = new Date();
				date = date.getFullYear() + addzero(date.getMonth() + 1)
						+ addzero(date.getDate());

				var obj = {};

				obj.BRANCH_NO = $("#branch_no").val();
				obj.DATE_ = date;
				obj.FACI_ADDR = $("#fact_addr").val();
				obj.FACI_NM = $("#fact_name").val() + "("
						+ $("#branch_name").val() + ")";
				obj.FACT_CODE = $("#fact_code").val();
				obj.RV_CD = $("#river_div").val();
				if (branchUseFlag == 'N') {
					obj.Y = '0';
					obj.X = '0';
				} else {
					obj.Y = $("#latitude1").val();
					obj.X = $("#longitude1").val();
				}
				obj.USE_FLAG = $("#branch_use_flag").val();
				// 				console.log("esri 등록정보 : ",obj);

// 				$editMap.model.addMemtPoint(sysKind, obj, function(result) {

// 				});
				$editMap.model
						.updateMemtPoint(
								sysKind,
								obj,
								function(result) {
									//	 				console.log('[저장]editMap.result', result);

									if (result.callbacktype == 'S'
											|| result.callbacktype == 'R') {
										console
												.log('[저장]',
														result.callbacktype);

										$('#factBranchForm')
												.ajaxForm(
														{
															success : function(
																	result) {
																alert(modeName
																		+ " 하였습니다.");
																layerPopClose("layerBranchModify");
																reloadData(pageNo);
															},
															error : function(
																	result) {
																// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
																var oraErrorCode = "";
																if (result.responseText != null) {
																	updateFlag = "error";
																	var matchedValue = result.responseText
																			.match(/ORA-[0-9]{5}/);
																	if (matchedValue != null
																			&& matchedValue.length > 0) {
																		oraErrorCode = matchedValue[0]
																				.replace(
																						'ORA-',
																						'');
																	}
																}
																alert("서버 접속에 실패하였습니다! [CODE:"
																		+ oraErrorCode
																		+ "]");
															}
														}).submit();
									} else {
										alert("서버 접속에 실패하였습니다.");
									}
								});
			} else {
				$('#factBranchForm').ajaxForm(
						{
							success : function(result) {
								alert(modeName + " 111하였습니다.");
								layerPopClose("layerBranchModify");
								reloadData(pageNo);
							},
							error : function(result) {
								// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
								var oraErrorCode = "";
								if (result.responseText != null) {
									updateFlag = "error";
									var matchedValue = result.responseText
											.match(/ORA-[0-9]{5}/);
									if (matchedValue != null
											&& matchedValue.length > 0) {
										oraErrorCode = matchedValue[0].replace(
												'ORA-', '');
									}
								}
								alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode
										+ "]");
							}
						}).submit();
			}
		}

		if (updateFlag == null) {
			if (branchUseFlag == 'Y') {
				usnHsInsert();
			} else if (branchUseFlag == 'N') {
				if ($("#branch_use_flag_ord").val() != branchUseFlag) {
					usnHsInsert();
				}
			}
		}

	}

	//사업장 정보를 가져오기
	function getFactinfoList(pageNo) {
		//사업장정보
		if (pageNo == null)
			pageNo = 1;
		var searchKeyword = $("#searchKeyword").val();

		showLoading();
		$
				.ajax({
					type : "post",
					url : "<c:url value='/spotmanage/getFactinfoList.do'/>",
					data : {
						pageIndex : pageNo,
						searchKeyword : searchKeyword
					},
					dataType : "json",
					success : function(result) {
						var html = "";
						var tot = result['factinfoList'].length;
						layerPopOpen("factinfoLayer");

						if (tot <= 0) {
							html += "<tr><td colspan='3'>조회 결과가 없습니다.</td></tr>";
						} else {
							for (var i = 0; i < tot; i++) {
								var obj = result['factinfoList'][i];
								var pageInfo = result['paginationInfo'];
								var no = i
										+ ((pageInfo.currentPageNo - 1) * pageInfo.recordCountPerPage)
										+ 1;

								obj.no = no;

								link = "setFactinfoCode('" + JSONtoString(obj)
										+ "');";
								trclass = "";
								if (i % 2 == 1)
									trclass = "class=\"even\"";

								html += "<tr "+trclass+">";
								html += "<td><a onclick=\""+link+"; return false;\" href=\"#\">"
										+ obj.no + "</a></td>";
								html += "<td><a onclick=\""+link+"; return false;\" href=\"#\">"
										+ obj.fact_code + "</a></td>";
								html += "<td><a onclick=\""+link+"; return false;\" href=\"#\">"
										+ obj.fact_name + "</a></td>";
								html += "</tr>";
							}
						}
						$("#dataList1").html(html);

						closeLoading();
					},
					error : function(result) {
						// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21

						var html = "";
						html += "<tr><td colspan='3'>서버 접속에 실패하였습니다.</td></tr>";
						$("#dataList1").html(html);

						closeLoading();
					}
				});
	}

	// 	// 페이지 번호 클릭
	// 	function linkPage(pageNo){
	// 		getFactinfoList(pageNo);
	// 	}
	//사업장정보에서 선택한 코드를 텍스트박스에 입력
	function setFactinfoCode(objs) {
		obj = JSON.parse(StringtoJson(objs));
		$("#fact_code").val(obj.fact_code);
		$("#fact_name").val(obj.fact_name);
		$("#river_div").val(obj.river_div);
		$("#river_no").val(obj.river_no);
		$("#sys_kind").val(obj.sys_kind);
		// 		$("#branch_no").val(obj.branch_cnt);

		layerPopOpen("layerBranchModify");
	}

	//좌표 지정 팝업
	function lon_lat() {
		window.open("<c:url value='/addrMap.jsp?X=" + $("#longitude1").val()
				+ "&Y=" + $("#latitude1").val() + "'/>", 'popupMap',
				'resizable=yes,scrollbars=yes,width=960,height=800');
	}

	// 좌표 및 주소 반영
	function applyLonLat(lon, lat, addr) {
		$('#latitude1').val(lat);
		$('#longitude1').val(lon);
		$("#fact_addr").val(addr.replace('대한민국 ', ''));
	}

	//관리자 검색  (정)
	function onSearch_member() {
		var searchKey = $('#branch_mgr_name').val();

		if (searchKey.length < 2)
			alert("2자리 이상 검색 가능합니다.");
		else {
			$
					.ajax({
						type : "POST",
						url : "<c:url value='/warehouse/getSearchMember.do'/>",
						data : {
							searchKeyword : searchKey,
							searchCondition : 'name'
						},
						dataType : "json",
						success : function(result) {
							var tot = result['list'].length;
							var html = "";
							layerPopOpen("memberLayer");

							if (tot <= 0) {
								html += "<tr><td colspan='4'>조회 결과가 없습니다.</td></tr>";
							} else {
								for (var i = 0; i < tot; i++) {
									var obj = result['list'][i];
									obj.no = i + 1;

									link = "onSelMember('" + JSONtoString(obj)
											+ "');";
									trclass = "";
									if (i % 2 == 1)
										trclass = "class=\"even\"";

									html += "<tr "+trclass+">";
									html += "<td><a onclick=\""+link+"; return false;\" href=\"#\">"
											+ obj.no + "</a></td>";
									html += "<td><a onclick=\""+link+"; return false;\" href=\"#\">"
											+ obj.deptName + "</a></td>";
									html += "<td><a onclick=\""+link+"; return false;\" href=\"#\">"
											+ obj.gradeName + "</a></td>";
									html += "<td><a onclick=\""+link+"; return false;\" href=\"#\">"
											+ obj.memberName + "</a></td>";
									html += "</tr>";

								}
							}
							$("#dataList2").html(html);
							closeLoading();
						},
						error : function(result) {
							var html = "";
							html += "<tr><td colspan='4'>서버 접속에 실패하였습니다.</td></tr>";
							$("#dataList2").html(html);

							closeLoading();
						}
					});
		}
	}

	function onSelMember(objs) {

		obj = JSON.parse(StringtoJson(objs));
		$('#branch_mgr_name').val(obj.memberName);
		$('#branch_mgr_tel_no').val(obj.mobileNo);
		$('#branch_mgr').val(obj.memberId);

		layerPopOpen("layerBranchModify");
	}

	function JSONtoString(object) {
		var results = [];
		for ( var property in object) {
			var value = object[property];
			if (value)
				results.push(property.toString() + ': ' + value);
		}

		return '{' + results.join(', ') + '}';
	}

	function StringtoJson(object) {
		object = object.replace(/\s/g, "");
		object = object.replace(/\{/g, "{\"");
		object = object.replace(/\}/g, "\"}");
		object = object.replace(/\:/g, "\":\"");
		object = object.replace(/\,/g, "\",\"");
		return object;
	}

	function fnSpotManageRegist() {
		document.frm.action = "<c:url value='/spotmanage/spotManageRegist.do'/>";
		document.frm.submit();
	}

	function fnSpotManageEdit() {
		document.frm.action = "<c:url value='/spotmanage/fnSpotManageEdit.do'/>";
		document.frm.submit();
	}

	function saveEquipInfoReg() {
		var equipCode = $("#equipInfoRegForm [name=equip_code]").val();
		var equipMaker = $("#equipInfoRegForm [name=equip_maker]").val();
		var equipName = $("#equipInfoRegForm [name=equip_name]").val();

		if (equipCode == null || equipCode == "") {
			alert("장비코드를 넣어주세요.");
			return;
		}

		if (equipMaker == null || equipMaker == "") {
			alert("제조사를 넣어주세요.");
			return;
		}

		if (equipName == null || equipName == "") {
			alert("모델명을 넣어주세요.");
			return;
		}

		$('#equipInfoRegForm').ajaxForm({
			success : function(result) {
				alert("저장되었습니다.");
				//getSystemList();
				layerPopCloseAll();

				getSysinfoList();

			}
		}).submit();
	}

	function getSmsList(obj) {
		//초기화

		$("#smsBranchList_1").css("display", "");
		$("#smsBranchList_2").css("display", "none");
		$("#smsBranchListButton").css("display", "none");
		$("#smsTargetButton").css("display", "none");
		$('#registlayerid').css('display', 'none');
		$("#sPerson option").remove();
		$("#person option").remove();

		$("#smsTargetdataList").html("");
		$("#smsTargetdataList")
				.html(
						"<tr><td colspan='5' style='text-align:center;'>검출내역목록을  선택해 주세요.</td></td>");

		//초기화 끝
		var objs = JSON.parse(StringtoJson(EventDivobj));
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;

		$
				.ajax({
					type : "post",
					url : "<c:url value='/spotmanage/ListDetailSmsFact.do'/>",
					data : {
						fact_code : factCode,
						branch_no : branchNo
					},
					dataType : "json",
					success : function(result) {
						var html = "";
						var onclickLink = "";
						if (result.List.length == 0) {
							html += "<tr><td colspan='6'>조회 결과가 없습니다.</td></tr>";
						} else {
							for (i = 0; i < result.List.length; i++) {
								var trNo = i + 1;
								onclickLink = "<a href='#' onclick=\" return false;\">";
								html += "<tr id='tras"
										+ trNo
										+ "' onclick=\"javascript:clickTrEvent(this);SmsConfigDetail('"
										+ result.List[i].det_code + "', '"
										+ result.List[i].sys_kind + "');\">";
								html += "<td>" + (i + 1) + "</td>";
								html += "<td>" + onclickLink
										+ result.List[i].det_code + "</a></td>";
								html += "<td>"
										+ onclickLink
										+ ((result.List[i].sys_kind == "A") ? "국가수질 자동 측정망 "
												: "IP-USN ")
										+ result.List[i].det_code_name
										+ "</a></td>";
								html += "<td>" + onclickLink
										+ result.List[i].det_content
										+ "</a></td>";
								html += "<td>" + onclickLink
										+ result.List[i].det_cycle
										+ "</a></td>";
								html += "<td>" + onclickLink
										+ result.List[i].user_yn + "</a></td>";
								html += "</tr>";
							}
						}
						$("#SmsdataList").html(html);
						$("#SmsdataList tr:odd").addClass("even");
					},
					error : function(result) {
						// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
						var oraErrorCode = "";
						if (result.responseText != null) {
							var matchedValue = result.responseText
									.match(/ORA-[0-9]{5}/);
							if (matchedValue != null && matchedValue.length > 0) {
								oraErrorCode = matchedValue[0].replace('ORA-',
										'');
							}
						}

						$("#SmsdataList").html("");
						$("#SmsdataList").html(
								"<tr><td colspan='6' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:"
										+ oraErrorCode + "]</td></td>");
					}
				});
	}

	function SmsConfigDetail(det_code, sys_kind) {
		$("#d_det_code").val(det_code);
		$("#d_sys_kind").val(sys_kind);
		SmsTargetList(det_code);
		SmsBranchConfigDetail(det_code, sys_kind);
		$("#smsTargetButton").css("display", "");
		$('#registlayerid').css('display', 'none');
		$("#sPerson option").remove();
		$("#person option").remove();
	}

	function SmsTargetList(det_code) {
		var fact_code = $("#factCode").html();
		var branch_no = $("#branchNo").val();

		$.ajax({
			type : "post",
			url : "<c:url value='/spotmanage/FactSmsTargetList.do'/>",
			data : {
				det_code : det_code,
				fact_code : fact_code,
				branch_no : branch_no
			},
			dataType : "json",
			success : function(result) {
				var html = "";
				var onclickLink = "";
				if (result.List.length == 0) {
					html += "<tr><td colspan='5'>조회 결과가 없습니다.</td></tr>";
				} else {
					for (i = 0; i < result.List.length; i++) {
						onclickLink = "<a href='#' onclick=\"SmsTargetDelete('"
								+ result.List[i].member_id
								+ "'); return false;\">";
						html += "<tr>";
						html += "<td>" + (i + 1) + "</td>";
						html += "<td>" + result.List[i].memberName + "</td>";
						html += "<td>" + result.List[i].deptNoName + "</td>";
						html += "<td>" + result.List[i].mobileNo + "</td>";
						html += "<td>" + onclickLink + "X" + "</a></td>";
						html += "</tr>";
					}
				}
				$("#smsTargetdataList").html(html);
				$("#smsTargetdataList tr:odd").addClass("even");
				closeLoading();
			},
			error : function(result) {
				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
				var oraErrorCode = "";
				if (result.responseText != null) {
					var matchedValue = result.responseText
							.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}

				$("#smsTargetdataList").html("");
				$("#smsTargetdataList").html(
						"<tr><td colspan='5' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:"
								+ oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}

	function clickTrEvent(trObj) {
		var tr = eval("document.getElementById(\"" + trObj.id + "\")");
		$(tr).parent().find("tr td").removeClass("tr_on");
		$(tr).find("td").addClass("tr_on");
	}
	function clickTrEventUSN(trObj, frdate, seq) {
		var tr = eval("document.getElementById(\"" + trObj.id + "\")");

		$(tr).parent().find("tr td").removeClass("tr_on");
		$(tr).find("td").addClass("tr_on");
		$("#UsnHistoryInfoDate").val(frdate);

		$("#introDate").val($("#str" + seq).val());
		$("#outDate").val($("#end" + seq).val());
	}

	//부서별 직원생성
	function setPerson() {
		var value = $("#dept > option:selected").val();
		var dropDownSet = $("#person");

		if (value == undefined)
			return;

		$.getJSON("<c:url value='/alert/getGroupAndMember.do'/>", {
			orderType : "2",
			value : value
		},
		//, system:sys_kind},
		function(data, status) {
			if (status == 'success') {
				//locId 객체에 SELECT 옵션내용 추가.

				dropDownSet.loadSelect(data.groupList);
				//adjustBranchList();

			} else {
				return;
			}
		});
	}

	function setDept() {
		var dropDownSet = $("#dept");

		$("#sPerson").emptySelect();

		$.getJSON("<c:url value='/alert/getGroupAndMember.do'/>", {
			orderType : "1"
		},
		//, system:sys_kind},
		function(data, status) {
			if (status == 'success') {
				//locId 객체에 SELECT 옵션내용 추가.

				dropDownSet.loadSelect(data.groupList);

				setPerson();
				//adjustBranchList();

			} else {
				return;
			}
		});
	}

	//SMS 보낼 직원 추가
	function add() {
		$("#person option:selected").each(function(i) {
			var addOpt = document.createElement('option'); // 옵션을 설정한다..
			addOpt.value = $(this).val();
			addOpt.appendChild(document.createTextNode($(this).text())); // 셀렉트 박스의 text 를 설정한다.

			var flag = false;
			$("#sPerson option").each(function(i) {
				if ($(this).val() == addOpt.value) {
					flag = true;
					return false;//break;
				}
			});

			if (!flag) {
				$("#sPerson").append(addOpt);
			}
		});
	}

	//SMS 보낼 직원 삭제
	function del() {
		$("#sPerson option:selected").each(function(i) {
			//$(this).appendTo('#person');
			$(this).remove();
		});
	}

	function goSave() {
		var fact_code = $("#factCode").html();
		var branch_no = $("#branchNo").val();

		var member = new Array;
		var cnt = 0;

		$("#sPerson option").each(function() {
			member.push($(this).val());
			cnt++;
		});

		$("#member_id").val(member);
		if (cnt == 0) {
			alert("대상자를 선택하여 주십시요.");
			return false;
		}

		if (confirm("등록하시겠습니까?")) {
			showLoading();
			$.ajax({
				type : "post",
				url : "<c:url value='/smsmanage/InsertSmsTarget.do'/>",
				data : {
					member_id : $("#member_id").val(),
					recv_type : "B",
					det_code : $("#d_det_code").val(),
					fact_code : fact_code,
					branch_no : branch_no
				},
				dataType : "json",
				success : function(result) {
					alert("등록하였습니다.")
					SmsConfigDetail($("#d_det_code").val(), $("#d_sys_kind")
							.val());
					closeLoading();
				},
				error : function(result) {
					closeLoading();
				}
			});
		}
	}

	function SmsTargetDelete(memid) {
		$("#member_id").val(memid);
		var fact_code = $("#factCode").html();
		var branch_no = $("#branchNo").val();

		if (confirm("삭제하시겠습니까?")) {
			showLoading();
			$.ajax({
				type : "post",
				url : "<c:url value='/smsmanage/DeleteSmsTarget.do'/>",
				data : {
					member_id : $("#member_id").val(),
					recv_type : "B",
					det_code : $("#d_det_code").val(),
					fact_code : fact_code,
					branch_no : branch_no
				},
				dataType : "json",
				success : function(result) {
					alert("삭제하였습니다.")
					SmsConfigDetail($("#d_det_code").val(), $("#d_sys_kind")
							.val());
					closeLoading();
				},
				error : function(result) {
					closeLoading();
				}
			});
		}
	}

	function SmsBranchConfigDetail(det_code, sys_kind) {
		var fact_code = $("#factCode").html();
		var branch_no = $("#branchNo").val();
		var rowspan = "3"
		$("#smsBranchListButton").css("display", "");
		$("#smsBranchList_1").css("display", "none");
		$("#smsBranchList_2").css("display", "");
		$("#smsBranchListTr0").css("display", "none");
		$("#smsBranchListTr1").css("display", "none");
		$("#smsBranchListTr2").css("display", "none");

		if (det_code == "SMSCD001") {
			rowspan = "4";
			$("#smsBranchListTr0").css("display", "");
			$("#smsBranchListTr1").css("display", "");
		}
		if (det_code == "SMSCD004") {
			rowspan = "4";
			$("#smsBranchListTr0").css("display", "none");
			$("#smsBranchListTr2").css("display", "");
		}
		if (det_code == "SMSCD002") {
			rowspan = "4";
			$("#smsBranchListTr0").css("display", "");
		}

		$("#smsBranchListTd1").attr("rowspan", rowspan);
		$("#smsBranchListSpan").html(det_code);

		$.ajax({
			type : "post",
			url : "<c:url value='/spotmanage/DetailFactSmsBranch.do'/>",
			data : {
				sys_kind : sys_kind,
				det_code : det_code,
				fact_code : fact_code,
				branch_no : branch_no
			},
			dataType : "json",
			success : function(result) {
				result = result.Detail;

				$("#not_send_from").val("");
				$("#not_send_to").val("");
				$("#send_detail_explan").val("");
				$("#chk_delay").val("");
				$("#delay_detail_explan").val("");
				$("#not_rcv").val("");
				$("#time_detail_explan").val("");
				$("#chk_loc").val("");
				$("#not_rcv_detail_explan").val("");
				$("#chk_time").val("");
				$("#time_detail_explan").val("");

				$("#send_use_flag").attr('checked', false);
				$("#delay_use_flag").attr('checked', false);
				$("#time_use_flag").attr('checked', false);
				$("#loc_use_flag").attr('checked', false);
				$("#not_rcv_use_flag").attr('checked', false);

				if (result != null) {
					$("#not_send_from").val(result.not_send_from);
					$("#not_send_to").val(result.not_send_to);
					$("#send_detail_explan").val(result.send_detail_explan);
					$("#chk_delay").val(result.chk_delay);
					$("#delay_detail_explan").val(result.delay_detail_explan);
					$("#not_rcv").val(result.not_rcv);
					$("#time_detail_explan").val(result.time_detail_explan);
					$("#chk_loc").val(result.chk_loc);
					$("#not_rcv_detail_explan").val(
							result.not_rcv_detail_explan);
					$("#chk_time").val(result.chk_time);
					$("#time_detail_explan").val(result.time_detail_explan);

					$("#send_use_flag").attr('checked', false);
					$("#delay_use_flag").attr('checked', false);
					$("#time_use_flag").attr('checked', false);
					$("#loc_use_flag").attr('checked', false);
					$("#not_rcv_use_flag").attr('checked', false);

					if (result.send_use_flag == "Y")
						$("#send_use_flag").attr('checked', true);
					if (result.delay_use_flag == "Y")
						$("#delay_use_flag").attr('checked', true);
					if (result.time_use_flag == "Y")
						$("#time_use_flag").attr('checked', true);
					if (result.loc_use_flag == "Y")
						$("#loc_use_flag").attr('checked', true);
					if (result.not_rcv_use_flag == "Y")
						$("#not_rcv_use_flag").attr('checked', true);
				}
				closeLoading();
			},
			error : function(result) {
				var oraErrorCode = "";
				if (result.responseText != null) {
					var matchedValue = result.responseText
							.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				closeLoading();
			}
		});
	}

	function goConfigSave() {
		var fact_code = $("#factCode").html();
		var branch_no = $("#branchNo").val();
		/*
		if ($("#d_det_code").val() == "SMSCD001" && $("#not_rcv").val() == "") {
			alert("수신율을 입력해 주세요");
			$("#not_rcv").focus();
		} else 
		 */
		if ($("#d_det_code").val() == "SMSCD001" && $("#not_rcv").val() > 100) {
			alert("수신율은 100미만으로 입력해 주세요");
			$("#not_rcv").focus();
		} else if ($("#d_det_code").val() == "SMSCD004"
				&& $("#chk_loc").val() == "") {
			alert("위치이탈을 입력해 주세요");
			$("#chk_loc").focus();
		} else {
			if (confirm("등록하시겠습니까?")) {
				showLoading();
				$
						.ajax({
							type : "post",
							url : "<c:url value='/spotmanage/InsertFactSmsBranch.do'/>",
							data : {
								det_code : $("#d_det_code").val(),
								sys_kind : $("#d_sys_kind").val(),
								not_send_from : $("#not_send_from").val(),
								not_send_to : $("#not_send_to").val(),
								chk_delay : $("#chk_delay").val(),
								not_rcv : $("#not_rcv").val(),
								chk_loc : $("#chk_loc").val(),
								chk_time : $("#chk_time").val(),
								send_detail_explan : $("#send_detail_explan")
										.val(),
								delay_detail_explan : $("#delay_detail_explan")
										.val(),
								not_rcv_detail_explan : $(
										"#not_rcv_detail_explan").val(),
								loc_detail_explan : $("#loc_detail_explan")
										.val(),
								time_detail_explan : $("#time_detail_explan")
										.val(),
								send_use_flag : ($("#send_use_flag").attr(
										"checked") ? "Y" : "N"),
								delay_use_flag : ($("#delay_use_flag").attr(
										"checked") ? "Y" : "N"),
								not_rcv_use_flag : ($("#not_rcv_use_flag")
										.attr("checked") ? "Y" : "N"),
								loc_use_flag : ($("#loc_use_flag").attr(
										"checked") ? "Y" : "N"),
								time_use_flag : ($("#time_use_flag").attr(
										"checked") ? "Y" : "N"),
								fact_code : fact_code,
								branch_no : branch_no
							},
							dataType : "json",
							success : function(result) {
								alert("등록하였습니다.")
								SmsConfigDetail($("#d_det_code").val(), $(
										"#d_sys_kind").val());
								closeLoading();
							},
							error : function(result) {
								closeLoading();
							}
						});
			}
		}
	}

	function numberCheck(n) {
		var temp = n.value
		if (isNaN(temp) == true) {
			n.value = "";
			alert("숫자만 입력해 주세요");
		}
	};

	function usnHsInsert() {
		showLoading();
		$
				.ajax({
					type : "post",
					url : "<c:url value='/spotmanage/usnHsInsert.do'/>",
					data : {
						factCode : $("#fact_code").val(),
						branchNo : $("#branch_no").val(),
						// 연번 - 자동  // itemseq
						// 시작일 - 입력일 ( 현재 )
						longitude : $("#longitude1").val(), // X,
						latitude : $("#latitude1").val(), // Y,
						branchName : "<sec:authentication property='principal.userVO.name'/>", // 지정자 (관리자)
						userFlag : $("#branch_use_flag").val(), // 사용/미사용
						memo : $("#branch_mgr_update").val()
					// 내용
					},
					dataType : "json",
					success : function(result) {
						closeLoading();
					},
					error : function(result) {
						closeLoading();
					}
				});
	};

	function goUsnEqHistoryTerm() {

		var pop = document.getElementById("layerUsnHistory");
		pop.style.display = "block";
		pop.style.top = "50%";
		pop.style.left = "50%";

		var objs = JSON.parse(StringtoJson(EventDivobj));
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;
		var introDate = "";
		var outDate = "";
		if ($("#UsnHistoryInfoDate").val() != '') {
			introDate = $("#UsnHistoryInfoDate").val();
		}
		if ($("#introDate").val() != '') {
			introDate = $("#introDate").val();
			$("#usnsearchDate1").val(introDate);
		}
		if ($("#outDate").val() != '') {
			outDate = $("#outDate").val();
			$("#usnsearchDate2").val(outDate);
		}

		if ($("#usnsearchDate1").val() != '') {
			introDate = $("#usnsearchDate1").val();
		}
		if ($("#usnsearchDate2").val() != '') {
			outDate = $("#usnsearchDate2").val();
		}

		showLoading();
		var item;
		$("#UsnHistoryInfo").html("");

		$
				.ajax({
					type : "post",
					url : "<c:url value='/spotmanage/getEqHsList.do'/>",
					data : {
						factCode : factCode,
						branchNo : branchNo,
						introDate : introDate,
						outDate : outDate
					},
					dataType : "json",
					success : function(result) {
						var tot = result['getEqHsList'].length;

						if (tot <= 0) {
							item = "<tr><td colspan='8'  align='center'>조회 결과가 없습니다.</td></tr>"
							$("#UsnHistoryInfo").html(item);
						} else {
							for (var i = 0; i < tot; i++) {
								obj = result['getEqHsList'][i];
								//onClick='javascript:goAHView("+i+","+obj.eqSeq+")'
								item = "<tr align='center' >";
								item += "<td>" + (i + 1) + "</td>";
								item += "<td>" + obj.introDate + "</td>";
								item += "<td>" + obj.itemName + "</td>";
								item += "<td>" + obj.conpanySeq + "</td>";
								item += "<td>" + obj.modelSeq + "</td>";
								item += "<td>" + obj.eqName + "</td>";
								item += "<td>" + obj.memo + "</td>";
								item += "</tr></a>";
								$("#UsnHistoryInfo").append(item);
								$("#UsnHistoryInfo tr:odd")
										.attr("class", "add");
							}
						}
						$("#UsnHistoryInfoDate").val('');
						$("#introDate").val('');
						$("#outDate").val('');

						closeLoading();
					},
					error : function(result) {
						// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
						var oraErrorCode = "";
						if (result.responseText != null) {
							var matchedValue = result.responseText
									.match(/ORA-[0-9]{5}/);
							if (matchedValue != null && matchedValue.length > 0) {
								oraErrorCode = matchedValue[0].replace('ORA-',
										'');
							}
						}
						$("#AdminHistoryInfo").html(
								"<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:"
										+ oraErrorCode + "]</td></td>");
						closeLoading();
					}
				});
	}
	/*
	var 날짜 = null;
	for obj.usnSeq
		if (날짜 != null)
			
	 */

	function usnHistoryDateListGroup() {
		var objs = JSON.parse(StringtoJson(EventDivobj));
		var factCode = objs.factCode;
		var branchNo = objs.branchNo;

		var usnHistoryInfoDate = $("#UsnHistoryInfoDate").val();
		showLoading();

		var item;
		$("#usnHistoryDate").html("");

		$
				.ajax({
					type : "post",
					url : "<c:url value='/spotmanage/getUsnList.do'/>",
					data : {
						factCode : factCode,
						branchNo : branchNo
					},
					dataType : "json",
					success : function(result) {
						var tot = result['getUsnList'].length;
						if (tot <= 0) {

						} else {
							var startDate = "";
							var endDate = "";

							var userFlag;

							var dateFlag;

							var item = "";

							for (var i = 0; i < tot; i++) {
								var obj = result['getUsnList'][i];
								var pageInfo = result['paginationInfo'];
								var no = i
										+ ((pageInfo.currentPageNo - 1) * pageInfo.recordCountPerPage)
										+ 1;
								trclass = "";
								if (i % 2 == 1)
									trclass = "class=\"even\"";
								var trNo = i + 1;
								if (obj.userFlag == 'Y') {
									startDate = obj.frdate;
								} else {
									endDate = obj.frdate;
									item += makeTr(i, startDate, endDate);
									startDate = "";
									endDate = "";
								}
							}
							if (startDate != "") {
								item += "<tr style='cursor:pointer;' "
										+ trclass
										+ " id='treq"
										+ trNo
										+ "' class='tr"
										+ i
										+ "'  onclick='javascript:clickTrEvent(this);javascript:usnDateSet(\""
										+ startDate + "\")'><td>" + startDate
										+ "~현재</td></tr>";
							}

							$("#usnHistoryDate").append(item);
							$("#usnHistoryDate tr:odd").attr("class", "add");
						}
						closeLoading();
					},
					error : function(result) {
						// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
						var oraErrorCode = "";
						if (result.responseText != null) {
							var matchedValue = result.responseText
									.match(/ORA-[0-9]{5}/);
							if (matchedValue != null && matchedValue.length > 0) {
								oraErrorCode = matchedValue[0].replace('ORA-',
										'');
							}
						}
						;
						$("#usnHistoryDate").html(
								"<tr><td colspan='12'>서버 접속에 실패하였습니다! [CODE:"
										+ oraErrorCode + "]</td></td>");
						closeLoading();
					}
				});
	}

	function makeTr(i, s, e) {
		var trclass = "class=\"even\"";
		var trNo = i + 1;

		if (s == "") {
			return "<tr style='cursor:pointer;' " + trclass + " id='treq"
					+ trNo + "' class='tr" + i
					+ "'  onclick='javascript:clickTrEvent(this);usnDateSet("
					+ "\"" + s + "\",\"" + e + "\");'><td>최초설치~" + e
					+ "</td></tr>";
		} else {
			return "<tr style='cursor:pointer;' " + trclass + " id='treq"
					+ trNo + "' class='tr" + i
					+ "'  onclick='javascript:clickTrEvent(this);usnDateSet("
					+ "\"" + s + "\",\"" + e + "\");'><td>" + s + "~" + e
					+ "</td></tr>";
		}
	}
	function usnDateSet(s, e) {
		$("#introDate").val(s);
		$("#outDate").val(e);
		goUsnEqHistoryTerm();
	}

	$(function() {
		$.datepicker.setDefaults({
			monthNames : [ '년 1월', '년 2월', '년 3월', '년 4월', '년 5월', '년 6월',
					'년 7월', '년 8월', '년 9월', '년 10월', '년 11월', '년 12월' ],
			dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
			showMonthAfterYear : true,
			dateFormat : 'yy/mm/dd',
			showOn : 'both',
			buttonImage : "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly : true
		});
		$("#usnsearchDate1").datepicker({
			buttonText : '시작일'
		});
		$("#usnsearchDate2").datepicker({
			buttonText : '종료일'
		});

	});

	//]]>
</script>
</head>

<body>
	<iframe id="downFrame" id="downFrame" width="0" height="0"
		frameborder="0"></iframe>
	<input type="hidden" id="d_det_code" name="d_det_code" />
	<input type="hidden" id="d_sys_kind" name="d_sys_kind" />
	<input type="hidden" id="member_id" name="member_id" />
	<input type="hidden" id="indexNum" name="indexNum" />
	<input type="hidden" id="index" name="index" />
	<input type="hidden" id="UpdateSeq" name="UpdateSeq" />
	<input type="hidden" id="itemCnt" name="itemCnt" />

	<input type="hidden" id="UsnfactCode" name="UsnfactCode"></input>
	<input type="hidden" id="UsnBranchNo" name="UsnBranchNo"></input>
	<input type="hidden" id="introDate" name="introDate"></input>
	<input type="hidden" id="outDate" name="outDate"></input>

	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>"
			alt="로딩중.." />
	</div>
	<div id="layerFullBgDiv"></div>
	<div id="wrap">

		<!-- Head Start-->
		<div id="header">
			<c:import url="/common/menu/header.do" />
		</div>
		<!-- Head End-->

		<!-- Body Start-->
		<div id="container">
			<div id="content_wrapper">

				<!--left menu Start-->
				<c:import url="/common/menu/left.do" />
				<!--left menu End-->

				<!-- Content Start-->
				<div id="content">

					<!-- navi, tab menu Start-->
					<c:import url="/common/menu/navi.do" />
					<!-- navi, tab menu End-->

					<div class="searchBox dataSearch">
						<ul>
							<li><span class="fieldName">수계</span> <select
								name="c_river_div">
									<option value="ALL">전체</option>
									<option value="R01">한강</option>
									<option value="R02">낙동강</option>
									<option value="R03">금강</option>
									<option value="R04">영산강</option>
							</select></li>
							<li><span class="fieldName">시스템</span> <select
								name="c_sys_kind">
									<option value="U">IP_USN</option>
									<!-- 									<option value="T">탁수모니터링</option> -->
									<option value="A">국가수질자동측정망</option>
									<option value="W">방류수질정보</option>
							</select></li>
							<li><span class="fieldName">사용여부</span> <select
								name="c_branch_use_flag">
									<option value="ALL">전체</option>
									<option value="Y">사용</option>
									<option value="N">미사용</option>
							</select></li>
							<li><span class="fieldName">명칭</span> <input type="text"
								id="c_branch_name" name="c_branch_name" style="width: 130px;"
								onkeydown="javascript:if(event.keyCode == 13)reloadData();" /></li>
						</ul>
					</div>
					<div class="btnSearchDiv">
						<input type="button" id="btnSearch" name="btnSearch" value="조회하기"
							class="btn btn_search" onclick="javascript:reloadData();"
							alt="조회하기" style="float: right;" />
					</div>

					<!--top Search Start-->
					<div id="btArea">
						<input type="button" id="btnExcel" name="btnExcel"
							class="btn btn_excel" onclick="javascript:excelDown();" alt="엑셀" />
						<input type="button" id="btnRegist" name="btnRegist" value="지점관리"
							class="btn btn_basic"
							onclick="javascript:layerPopOpen('layerBranchReg');" alt="지점관리" />
						<input type="button" id="btnEquip" name="btnEquip" value="장비관리"
							class="btn btn_basic"
							onclick="javascript:layerPopOpen('layerEquipInfoReg');"
							alt="장비관리" />
						<!-- 
						<input type="button" id="btnGetSpotInfo" name="btnGetSpotInfo" value="변경지점"
							class="btn btn_basic"
							onclick="javascript:getSpotInfoA();"
							alt="변경지점" />
						-->
						<!-- 						<input type="button" id="btnSave" name="btnSave" value="저장" class="btn btn_basic" onclick="javascript:updateLoadData();" alt="저장"/> -->
						<!-- 						<input type="button" id="btnRegist" name="btnRegist" value="지점등록" class="btn btn_basic" onclick="javascript:layerPopOpen('layerBranchReg');" alt="지점등록"/> -->
						<!-- 						<input type="button" id="btnSpotManageInsert" name="btnSpotManageInsert" value="측정소등록" class="btn btn_basic" onclick="javascript:LayerPopEditOpen('reg');" alt="측정소등록"/> -->
						<!-- 						<input type="button" id="btnSpotManageInsert" name="btnSpotManageInsert" value="측정소등록" class="btn btn_basicM" onclick="javascript:spotManageInsertPop();" alt="측정소등록"/> -->
						<!-- 						<input type="button" id="btnSpotManageUpdate" name="btnSpotManageUpdate" value="측정소수정" class="btn btn_basic" onclick="javascript:LayerPopEditOpen('mod');" alt="측정소수정"/> -->
						<!-- 						<input type="button" id="btnMap" name="btnMap" value="지도보기" class="btn btn_basic" onclick="javascript:popupMapOpen()" alt="지도보기" /> -->
					</div>
					<!--top Search End-->

					<input type="hidden" id="rlongitude" name="rlongitude" /> <input
						type="hidden" id="rlatitude" name="rlatitude" /> <input
						type="hidden" id="rpage" name="rpage" />
					<form name="frm" action="" method="post">
						<!--tab Contnet Start-->
						<div class="table_wrapper">
							<table>
								<col width='45' />
								<col width='100' />
								<col width='100' />
								<col width='120' />
								<col width='100' />
								<col />
								<col width='150' />
								<col width='100' />
								<col width='100' />
								<thead>
									<tr>
										<th scope='col'>NO</th>
										<th scope='col'>수계</th>
										<th scope='col'>장비코드</th>
										<th scope='col'>시스템</th>
										<th scope='col'>지점코드</th>
										<th scope='col'>사업장명</th>
										<th scope='col'>측정소명</th>
										<th scope='col'>사용여부</th>
										<th scope='col'>위치</th>
									</tr>
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
					</form>
					<div>
						<input type="button" id="btnSpotManageInsert"
							name="btnSpotManageInsert" value="측정소등록" style="float: right"
							class="btn btn_basic" onclick="javascript:fnSpotManageRegist();"
							alt="측정소등록" />
					</div>
					<!--tab menu Start-->
					<ul class="tabs m1">
						<li class="m1 on"><a href="javascript:LayerDiv(1);"><span>기본정보</span></a></li>
						<li class="li_space"></li>
						<li class="m2"><a href="javascript:LayerDiv(2);"><span>측정소이력</span></a></li>
						<li class="li_space"></li>
						<li class="m3"><a href="javascript:LayerDiv(3);"><span>항목관리</span></a></li>
						<li class="li_space"></li>
						<li class="m4"><a href="javascript:LayerDiv(4);"><span>측정소SMS관리</span></a></li>
					</ul>
					<!--tab menu End-->

					<!-- tab1 -->
					<div id="tpl_tab_1">

						<fieldset class="second">
							<legend class="hidden_phrase">지점관리 상세 정보(기본정보, USN관리,
								설치장비, 항목관리)</legend>

							<div class="divisionBx">
								<div class="table_wrapper">

									<table id="tab_1_1" summary="기본정보">
										<colgroup>
											<col width="10%" />
											<col width="15%" />
											<col width="10%" />
											<col width="15%" />
											<col width="10%" />
											<col width="15%" />
											<col width="10%" />
											<col width="15%" />
										</colgroup>
										<tr>
											<th scope="col">시스템(*)</th>
											<td><span id="sysName"></span></td>
											<th scope="col">장비코드(*)</th>
											<td><span id="equipCode"></span></td>
											<th scope="col">사업장명(*)</th>
											<td><span id="factName"></span></td>
											<th scope="col">지점코드(*)</th>
											<td><span id="factCode"></span><input type="hidden"
												id="branchNo" /></td>
										</tr>
										<tr>
											<th scope="col">관리주체</th>
											<td><span id="mgrOrg"></span></td>
											<th scope="col">운영기관</th>
											<td><span id="operOrg"></span></td>
											<th>수계</th>
											<td><span id="riverName"></span></td>
											<th scope="col">사용여부(*)</th>
											<td><span id="branchUseName"></span></td>
										</tr>
										<tr>
											<th scope="col" rowspan="2">측정소위치</th>
											<td colspan="7" style="text-align: left; padding-left: 5px;"><span
												id="factAddr"></span></td>
										</tr>
										<tr>
											<td colspan="7" style="text-align: left; padding-left: 5px;">
												위도(Y)좌표:<span id="latitude" style="padding-right: 30px;"></span>
												경도(X)좌표:<span id="longitude"></span>
											</td>
										</tr>
										<tr>
											<th scope="col">관리자명</th>
											<td><span id="branchMgr"></span></td>
											<th scope="col">관리자번호</th>
											<td colspan="3"><span id="branchMgrTel"></span></td>
											<th scope="col">담당자</th>
											<td><input type="button" id="btnMemberDive"
												name="btnMemberDive" value="등록/변경" class="btn btn_basic"
												onclick="javascript:memberDiv();" alt="등록/변경" /></td>
										</tr>
										<tr>
											<th scope="col">담당자 명단</th>
											<td colspan="7" style="text-align: left; padding-left: 5px;">
												<ul>
													<li id="memList"></li>
												</ul>
											</td>
										</tr>
										<tr>
											<th scope="col">측정항목</th>
											<td colspan="7" style="text-align: left; padding-left: 5px;">
												<ul>
													<li id="sysList"></li>
												</ul>
											</td>
										</tr>
									</table>
								</div>
								<div style="text-align: right;">
									<input type="button" id="btnSpotManageUpdate"
										name="btnSpotManageUpdate" value="수정" class="btn btn_basic"
										onclick="javascript:LayerPopEditOpen('mod');" alt="측정소수정" />
								</div>
							</div>
						</fieldset>
					</div>
					<!-- //tab1 -->

					<!-- tab2 -->
					<!--top Search Start-->
					<div id="tpl_tab_2">
						<div style="text-align: left;">
							<span id="usnBranchName"></span> <input type="hidden" id="fc" />
							<input type="hidden" id="bc" />
						</div>
						<!--top Search End-->

						<div class="table_wrapper">

							<table id="tab_1_1" summary="usn정보">
								<colgroup>
									<col width="7%" />
									<col width="8%" />
									<col width="8%" />
									<col width="8%" />
									<col width="8%" />
									<col width="8%" />
									<col width="20%" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">연번</th>
										<th scope="col">일자</th>
										<th scope="col">X좌표</th>
										<th scope="col">Y좌표</th>
										<th scope="col">지정자</th>
										<th scope="col">사용/미사용</th>
										<th scope="col">내용</th>
									</tr>
								</thead>
								<tbody id="usnDataList">
									<tr>
										<td>&nbsp;</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
									<tr class="add">
										<td>&nbsp;</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</tbody>
							</table>
						</div>
						<div style="text-align: right;">
							<input type='button' id='btnAdminHistoryInfo'
								name='btnAdminHistoryInfo' value='장비이력' class='btn btn_basic'
								onclick='javascript:goUsnEqHistoryTerm();' alt='관리이력' /> <input
								type="hidden" id='UsnHistoryInfoDate' name='UsnHistoryInfoDate'
								value='' />
							<!-- 
								<input type="button" id="btnUsnInsert" name="btnUsnInsert" value="추가" class="btn btn_basic" onclick="javascript:usnInsertPopup();" alt="측정일정추가"/>
								<input type='button' id='btnUpdate' name='btnUpdate' value='수정' class='btn btn_basic' onclick='javascript:usnUpdatePopup("+obj.itemseq+");' alt='수정'/>
								<input type='button' id='btnDelete' name='btnDelete' value='삭제' class='btn btn_basic' onclick='javascript:usnDel("+obj.itemseq+");' alt='삭제'/>
							 -->
						</div>
					</div>
					<!-- //tab2 -->

					<!-- tab3-->
					<div id="tpl_tab_3">
						<div class="topBx">
							<span>측정항목관리</span> <span id="itemName"></span>
						</div>
						<!--top Search End-->

						<div class="table_wrapper">

							<form id="itemForm" name="itemForm">
								<table id="tab_1_1" summary="측정장비정보">
									<colgroup>
										<col width="45px" />
										<col />
										<col width="70px" />
										<col width="70px" />
										<col width="60px" />
										<col width="60px" />
										<!-- 
										<col width="60px" />
										 -->
										<col width="70px" />
										<col width="70px" />
										<col width="70px" />
										<col width="70px" />
										<col width="60px" />
										<col width="70px" />
										<col width="70px" />
										<!-- 
									<col width="70px" />
									<col width="60px" />
									 -->
									</colgroup>
									<thead>
										<tr>
											<th scope="col">연번</th>
											<th scope="col">항목명</th>
											<th scope="col">경보기준<br />상한값
											</th>
											<th scope="col">경보기준<br />하한값
											</th>
											<!-- 
											<th scope="col">경보<br />적용여부
											</th>
											 -->
											<th scope="col">갈수기<br />시작월
											</th>
											<th scope="col">갈수기<br />종료월
											</th>
											<th scope="col">갈수기<br />상한값
											</th>
											<th scope="col">갈수기<br />하한값
											</th>
											<th scope="col">갈수기<br />적용여부
											</th>
											<th scope="col">기준값</th>
											<th scope="col">기준값<br />적용여부
											</th>
											<!-- 
										<th scope="col">동일값<br/>지속시간(분)</th>
										<th scope="col">동일값<br/>적용여부</th>
										 -->
										</tr>
									</thead>
									<tbody id="itemDataList">
										<tr>
											<td>&nbsp;</td>
											<td></td>
											<td></td>
											<td></td>
											<!-- 
											<td></td>
											 -->

											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<!-- 
										<td></td>
										<td></td>
										 -->
										</tr>
										<tr class="add">
											<td>&nbsp;</td>
											<td></td>
											<td></td>
											<td></td>
											<!-- 
											<td></td>
											 -->
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<!-- 
										<td></td>
										<td></td>
										 -->
										</tr>
									</tbody>
								</table>
							</form>
						</div>
						<div style="text-align: right;">
							<input type="button" id="btnMultiSave" name="btnMultiSave"
								value="저장" class="btn btn_basic"
								onclick="javascript:MultiSave();" alt="저장" />
						</div>
					</div>
					<!-- tab4-->
					<div id="tpl_tab_4">
						<div class="topBx">
							<span>측정소SMS관리</span>
						</div>
						<!--top Search End-->

						<div class="table_wrapper">
							<table summary="게시판 목록. 번호, 검출코드, 검출내용, 검출세부내용, 검출주기, 사용여부가 담김">
								<colgroup>
									<col width="45" />
									<col width="125" />
									<col width="290" />
									<col width="290" />
									<col width="130" />
									<col width="110" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">No</th>
										<th scope="col">검출코드</th>
										<th scope="col">검출내용</th>
										<th scope="col">검출세부내용</th>
										<th scope="col">검출주기</th>
										<th scope="col">사용여부</th>
									</tr>
								</thead>
								<tbody id="SmsdataList">
								</tbody>
							</table>


							<!--SMS 공통 수신자 설정 -->
							<div class="topBx">
								<span>SMS 수신자 대상</span>
							</div>
							<div class="table_wrapper">
								<table summary="게시판 목록. 번호, 검출코드, 검출내용, 검출세부내용, 검출주기, 사용여부가 담김">
									<colgroup>
										<col width="45" />
										<col width="125" />
										<col width="290" />
										<col width="290" />
										<col width="130" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">No</th>
											<th scope="col">이름</th>
											<th scope="col">소속</th>
											<th scope="col">전화번호</th>
											<th scope="col">삭제</th>
										</tr>
									</thead>
									<tbody id="smsTargetdataList">
										<tr>
											<td colspan="5">검출내역목록을 선택해 주세요.</td>
										</tr>
									</tbody>
								</table>

								<div style="float: right; margin: 5px 0; display: none;"
									id="smsTargetButton">
									<input type="button" id="btnEgovRegistMember" value="등록"
										class="btn btn_basic"
										onclick="$('#registlayerid').css('display','');return false;"
										alt="등록" />
								</div>
							</div>

							<div id="registlayerid"
								style="margin-top: 20px; display: none; clear: both;">
								<div>
									<div class="gBox" style="width: 340px">
										<span class="ptit"> 대상기관 </span> <select multiple="multiple"
											id="dept" style="padding: 7px; width: 330px; height: 190px"></select>
									</div>

									<div style="padding-top: 25px; float: left">
										<img src="/images/renewal/parrow.gif" alt="다음단계" />
									</div>

									<div class="gBox" style="width: 285px">
										<span class="ptit"> 담당자 </span> <select multiple="multiple"
											id="person" style="padding: 7px; width: 280px; height: 190px"></select>
									</div>

									<ul class="arrbx">
										<li style="padding-top: 70px;"><a href="javascript:add()"><img
												src="<c:url value='/images/renewal/bt_arradd.gif'/>"
												alt="추가" /></a></li>
										<br />
										<li><a href="javascript:del()"><img
												src="<c:url value='/images/renewal/bt_arrdel.gif'/>"
												alt="삭제" /></a></li>
									</ul>

									<div class="gBox" style="width: 285px">
										<span class="ptit"> 전파대상자 </span> <select multiple="multiple"
											id="sPerson"
											style="padding: 7px; width: 280px; height: 190px"></select>
									</div>
								</div>

								<div class="btnSearchDiv"
									style="clear: both; padding-top: 10px;">
									<div style="padding-right: 10px; float: right;">
										<input type="button" value="취소" class="btn btn_search"
											onclick="$('#registlayerid').css('display','none');return false;"
											alt="취소" /> <input type="button" id="btnEgovRegistMember"
											name="btnEgovRegistMember" value="저장" class="btn btn_search"
											onclick="return goSave();" alt="저장" />
									</div>
								</div>
							</div>

							<div class="topBx">
								<span>측정소 수신기준 설정</span>
							</div>

							<div class="table_wrapper">
								<table summary="게시판 목록. 번호, 검출코드, 검출내용, 검출세부내용, 검출주기, 사용여부가 담김">
									<colgroup>
										<col width="45" />
										<col width="125" />
										<col width="190" />
										<col width="390" />
										<col width="130" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">검출코드</th>
											<th scope="col">조건내용</th>
											<th scope="col">조건값</th>
											<th scope="col">세부설명</th>
											<th scope="col">사용여부</th>
										</tr>
									</thead>
									<tbody id="smsBranchList_1">
										<tr>
											<td colspan="5">검출내역목록을 선택해 주세요.</td>
										</tr>
									</tbody>

									<tbody id="smsBranchList_2" style="display: none;">
										<tr>
											<td id="smsBranchListTd1"><span id="smsBranchListSpan"></span></td>
											<td>보내지 않는 시간</td>
											<td><select id="not_send_from" name="not_send_from"
												style="width: 40%">
													<c:set var="min" value="0" />
													<c:forEach begin="0" end="24" step="1" var="i">
														<c:set var="min" value="${i}" />
														<c:if test="${i < 10}">
															<c:set var="min" value="0${i}" />
														</c:if>
														<option value="<c:out value='${min}'/>"><c:out
																value="${min}" /></option>
													</c:forEach>
											</select>&nbsp;&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;&nbsp; <select
												id="not_send_to" name="not_send_to" style="width: 40%">
													<c:set var="min" value="0" />
													<c:forEach begin="0" end="24" step="1" var="i">
														<c:set var="min" value="${i}" />
														<c:if test="${i < 10}">
															<c:set var="min" value="0${i}" />
														</c:if>
														<option value="<c:out value='${min}'/>"><c:out
																value="${min}" /></option>
													</c:forEach>
											</select></td>
											<td><input type="text" id="send_detail_explan"
												name="send_detail_explan" style="width: 96%" /></td>
											<td><input type="checkbox" id="send_use_flag"
												name="send_use_flag" value="Y" /></td>
										</tr>

										<tr id="smsBranchListTr0" style="display: none;">
											<td>검출지연시간(분)</td>
											<td><select id="chk_delay" name="chk_delay"
												style="width: 97%">
													<c:forEach begin="10" end="60" step="10" var="i">
														<option value="<c:out value='${i}'/>"><c:out
																value="${i}" /></option>
													</c:forEach>
											</select></td>
											<td><input type="text" id="delay_detail_explan"
												name="delay_detail_explan" style="width: 96%" /></td>
											<td><input type="checkbox" id="delay_use_flag"
												name="delay_use_flag" value="Y" /></td>
										</tr>

										<tr id="smsBranchListTr1" style="display: none;">
											<td>수신율 몇(%) 미만</td>
											<td><input type="text" id="not_rcv" name="not_rcv"
												style="width: 96%" onkeyup="numberCheck(this)" /></td>
											<td><input type="text" id="not_rcv_detail_explan"
												name="not_rcv_detail_explan" style="width: 96%" /></td>
											<td><input type="checkbox" id="not_rcv_use_flag"
												name="not_rcv_use_flag" value="Y" /></td>
										</tr>

										<tr id="smsBranchListTr2" style="display: none;">
											<td>위치이탈 범위지정(M)</td>
											<td><input type="text" id="chk_loc" name="chk_loc"
												style="width: 96%" onkeyup="numberCheck(this)" /></td>
											<td><input type="text" id="loc_detail_explan"
												name="loc_detail_explan" style="width: 96%" /></td>
											<td><input type="checkbox" id="loc_use_flag"
												name="loc_use_flag" value="Y" /></td>
										</tr>

										<tr>
											<td>SMS 송신 주기(시)</td>
											<td><select id="chk_time" name="chk_time"
												style="width: 97%">
													<c:set var="min" value="0" />
													<c:forEach begin="1" end="24" step="1" var="i">
														<c:set var="min" value="${i}" />
														<c:if test="${i < 10}">
															<c:set var="min" value="0${i}" />
														</c:if>
														<option value="<c:out value='${min}'/>"><c:out
																value="${min}" /></option>
													</c:forEach>
											</select></td>
											<td><input type="text" id="time_detail_explan"
												name="time_detail_explan" style="width: 96%" /></td>
											<td><input type="checkbox" id="time_use_flag"
												name="time_use_flag" value="Y" /></td>
										</tr>
									</tbody>
								</table>

								<div style="float: right; margin: 5px 0; display: none;"
									id="smsBranchListButton">
									<input type="button" id="btnRegist" value="저장"
										class="btn btn_basic" onclick="javascript:goConfigSave();"
										alt="저장" />
								</div>
							</div>
						</div>
					</div>
					<!-- //tab5 -->

				</div>
				<!--tab Contnet End-->
			</div>
		</div>
		<!-- Body End-->

		<!-- Footer Start-->
		<div id="footer">
			<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
		<!-- Footer End-->

	</div>

	<!-- 레이어 팝업(layerMember) div start -->
	<div id="layerMember" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" /> <input
				type="button" id="btnMemXbox" name="btnMemXbox" value="X"
				class="btn btn_white" style="width: 18px"
				onclick="javascript:layerPopClose('layerMember');" alt="닫기" />
		</div>
		<div class="fixed-table-container-inner" style="height: 200px">
			<table summary="사용자정보">
				<caption>사용자정보</caption>
				<colgroup>
					<col width="100px" />
					<col width="100px" />
					<col width="100px" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">아이디</th>
						<th scope="col">이름</th>
						<th scope="col">선택</th>
					</tr>
				</thead>
				<tbody id="MemberList"></tbody>
			</table>
		</div>
		<div id="btCarea">
			<input type="text" id="memIdSearchTxt" name="memIdSearchTxt"
				style="width: 100px;"
				onkeydown="javascript: if(event.keyCode == 13) {memberDiv();}"
				title="검색" /> <input type="button" id="btnMemberSearch"
				name="btnMemberSearch" value="검색" class="btn btn_search"
				onclick="javascript:memberDiv();" alt="검색" />
		</div>
	</div>
	<!-- 레이어 팝업(layerMember) div end -->
	<!-- 레이어 팝업(layerAddr) div start -->
	<div id='layerAddr' class="divPopup"></div>
	<!-- 레이어 팝업(layerAddr) div end -->

	<div id="layerBranchReg" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" /> <input
				type="button" id="btnBranRegXbox" name="btnBranRegXbox" value="X"
				class="btn btn_white" style="width: 18px"
				onclick="javascript:layerPopClose('layerBranchReg');" alt="닫기" />
		</div>
		<form id="branchRegForm" name="branchRegForm"
			action="/spotmanage/saveBranchReg.do" method="post">

			<table summary="지점정보">
				<caption>지점정보</caption>
				<colgroup>
					<col width="120px" />
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th>지점 코드 <br>fact_code</br></th>
						<td><input type="text" name="fact_code" maxlength="7" /></td>
					</tr>
					<tr>
						<th>지점이름</th>
						<td><input type="text" name="fact_name" maxlength="10" /></td>
					</tr>
					<tr>
						<th>수계</th>
						<td><select name="river_div">
								<option value="ALL">전체</option>
								<option value="R01">한강</option>
								<option value="R02">낙동강</option>
								<option value="R03">금강</option>
								<option value="R04">영산강</option>
						</select></td>
					</tr>
					<tr>
						<th>시스템</th>
						<td><select name="sys_kind">
								<option value="ALL">전체</option>
								<option value="U">IP_USN</option>
								<option value="A">국가수질자동측정망</option>
								<option value="W">방류수질정보</option>
						</select></td>
					</tr>
					<tr>
						<th>아이피</th>
						<td><input type="text" name="fact_ip" maxlength="16" /></td>
					</tr>
					<tr>
						<th>사용여부</th>
						<td><select name="fact_use_flag">
								<option value="Y">사용</option>
								<option value="N">미사용</option>
						</select></td>
					</tr>
				</tbody>
			</table>
		</form>
		<div id="btCarea">
			<input type="button" id="btnSaveBranchReg" name="btnSaveBranchReg"
				value="저장" class="btn btn_white"
				onclick="javascript:saveBranchReg();" alt="저장" />
		</div>
	</div>

	<!-- tab2 에서 사용 하는 관리 이력 레이어 팝업 start -->
	<div id="layerUsnHistory" class="divPopup"
		style="left: 23% !important; top: 50% !important; width: 900px; height: 400px; vertical-align: top;">
		<table style="height: 380px;">
			<colgroup>
				<col width="*" />
			</colgroup>
			<tr valign="top">
				<td>
					<table summary="측정소 설치 장비 이력" align="center">
						<colgroup>
							<col width="90px" />
							<col width="100px" />
							<col width="100px" />
							<col width="100px" />
							<col width="100px" />
							<col width="100px" />
							<col width="*" />
						</colgroup>
						<tr>
							<td>
								<div class="searchBox dataSearch"
									style="width: 860px; margin-left: auto; margin-right: auto; padding: 0; margin: 0; border: 0;"
									align="center">
									<ul style="margin-left: auto; margin-right: auto;">
										<li><span class="fieldName">시작일자</span> <input
											type="text" id="usnsearchDate1" readonly="readonly"
											style="width: 130px;" /></li>
										<li><span class="fieldName">종료일자</span> <input
											type="text" id="usnsearchDate2" readonly="readonly"
											style="width: 130px;" /></li>
										<li><input type="button" id="" name="" value="검색"
											class="btn btn_basic"
											onclick='javascript:goUsnEqHistoryTerm()' alt="검색" /></li>
									</ul>
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>

			<tr style="height: 20px;" valign="top">
				<td>
					<table summary="측정소 설치 장비 이력" align="center">
						<colgroup>
							<col width="90px" />
							<col width="100px" />
							<col width="100px" />
							<col width="100px" />
							<col width="100px" />
							<col width="100px" />
							<col width="*" />
						</colgroup>
						<thead>
							<tr style="height: 20px;">
								<th scope="col">연번</th>
								<th scope="col">일자</th>
								<th scope="col">항목명</th>
								<th scope="col">제조사</th>
								<th scope="col">모델명</th>
								<th scope="col">수행자</th>
								<th scope="col">비고</th>
							</tr>
						</thead>
					</table>
				</td>
			</tr>
			<tr style="height: 300px;">
				<td valign="top">
					<div
						style="max-height: 300px !important; overflow-y: auto; vertical-align: top;">
						<table summary="측정소 설치 장비 이력" align="center">
							<colgroup>
								<col width="90px" />
								<col width="100px" />
								<col width="100px" />
								<col width="100px" />
								<col width="100px" />
								<col width="100px" />
								<col width="*" />
							</colgroup>
							<tbody id="UsnHistoryInfo">
							</tbody>
						</table>
					</div>
				</td>
			</tr>
		</table>
		<div align="right">
			<input type="button" id="btnAdminHistoryInsert"
				name="btnAdminHistoryInsert" value="장비이력추가" class="btn btn_basic"
				onclick="javascript:eqInsertPopup();" alt="추가" /> <input
				type="button" id="btnCloseCommonLayer" name="btnCloseCommonLayer"
				value="닫기" class="btn btn_basic"
				onclick="javascript:layerPopClose('layerUsnHistory');" alt="닫기" />
		</div>
	</div>

	<div id="layerUpdateDel" class="divPopup">
		<input type="hidden" id="hsSeq" name="hsSeq" />
		<textarea id="hsView" name="hsView" rows="19" cols="35"></textarea>
		<input type="button" id="btnAdminHistoryUpdate"
			name="btnAdminHistoryUpdate" value="수정" class="btn btn_basic"
			onclick="javascript:adminHistoryUpdate();" alt="수정" /> <input
			type="button" id="btnAdminHistoryDel" name="btnAdminHistoryDel"
			value="삭제" class="btn btn_basic"
			onclick="javascript:adminHistoryDel();" alt="삭제" /> <input
			type="button" id="btnCloseUpdateDel" name="btnCloseUpdateDel"
			value="닫기" class="btn btn_basic"
			onclick="javascript:layerPopClose('layerUpdateDel');" alt="닫기" />
	</div>
	<!-- tab3 에서 사용 하는 관리 이력 레이어 팝업 end-->

	<!-- 측정소 등록 수정 레이어 -->
	<div id="layerBranchModify" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" /> <input
				type="button" id="btnBranModXbox" name="btnBranModXbox" value="X"
				class="btn btn_white" style="width: 18px"
				onclick="javascript:layerPopClose('layerBranchModify');" alt="닫기" />
		</div>
		<form id="factBranchForm" name="factBranchForm"
			action="/spotmanage/updateFactbranchInfoAdd.do" method="post">
			<input type="hidden" id="fact_code" name="fact_code" /> <input
				type="hidden" id="river_div" name="river_div" /> <input
				type="hidden" id="river_no" name="river_no" /> <input type="hidden"
				id="sys_kind" name="sys_kind" /> <input type="hidden"
				id="branch_mgr" name="branch_mgr" /> <input type="hidden"
				id="branch_no" name="branch_no" /> <input type="hidden" id="mode"
				name="mode" />

			<table summary="지점정보">
				<caption>지점정보</caption>
				<colgroup>
					<col width="120px" />
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">사업장이름</th>
						<td><input type="text" id="fact_name" name="fact_name"
							readonly="readonly" onclick="javascript:getFactinfoList()"
							style="width: 300px; background-color: #f2f2f2;" /> <input
							type="button" id="btnFactSearch" name="btnFactSearch"
							value="지점선택" class="btn btn_search"
							onclick="javascript:getFactinfoList();" alt="지점선택" /></td>
					</tr>
					<tr>
						<th scope="row">측정소명</th>
						<td><input type="text" id="branch_name" name="branch_name"
							style="width: 380px" /></td>
					</tr>
					<tr>
						<th scope="row">주소</th>
						<td><input type="text" id='fact_addr' name="fact_addr"
							style="width: 380px; background-color: #f2f2f2;"
							readonly="readonly" /></td>
					</tr>
					<tr>
						<th scope="row">좌표</th>
						<td><input type="text" id="latitude1" name="latitude"
							style="width: 142px; background-color: #f2f2f2;"
							readonly="readonly" />&nbsp;&nbsp; <input type="text"
							id="longitude1" name="longitude"
							style="width: 142px; background-color: #f2f2f2;"
							readonly="readonly" /> <input type="button" id="btnlonlat"
							name="btnlonlat" value="좌표선택" class="btn btn_search"
							onclick="javascript:lon_lat();" alt="좌표선택" /></td>
					</tr>
					<tr>
						<th scope="row">관리자명</th>
						<td><input type="text" id="branch_mgr_name"
							name="branch_mgr_name" value="" style="width: 220px" /> (두글자 이상
							입력) <input type="button" id="btnMemberSearch"
							name="btnMemberSearch" value="조회" class="btn btn_search"
							onclick="javascript:onSearch_member()" alt="조회" /></td>
					</tr>
					<tr>
						<th scope="row">관리자전화번호</th>
						<td><input type="text" id="branch_mgr_tel_no"
							name="branch_mgr_tel_no" value=""
							style="width: 380px; background-color: #f2f2f2;"
							readonly="readonly" /></td>
					</tr>
					<!-- 										<tr> -->
					<!-- 											<th scope="row">이탈유효거리(M)</th> -->
					<!-- 											<td><input type="text" id="leave_distance" name="leave_distance" style="width:380px" /></td> -->
					<!-- 										</tr> -->
					<tr>
						<th scope="row">사용여부</th>
						<td><select name="branch_use_flag" id="branch_use_flag"
							style="width: 380px;">
								<option value="Y">사용</option>
								<option value="N">미사용</option>
						</select></td>
					</tr>
					<tr>
						<th>수정내용</th>
						<td><input type="text" id="branch_mgr_update"
							name="branch_mgr_update" style="width: 380px"></input></td>
					</tr>
				</tbody>
			</table>
		</form>
		<input type="hidden" id="branch_use_flag_ord"></input>
		<div id="btCarea">
			<input type="button" id="btnBranchRegMod" name="btnBranchRegMod"
				value="등록/수정" class="btn btn_white"
				onclick="javascript:updateFactBranch();" alt="등록/수정" />
		</div>
	</div>
	<!-- 측정소 등록 수정 레이어 -->
	<!--측정소 검색 레이어-->
	<div id="factinfoLayer" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" /> <input
				type="button" id="btnFactInfoXbox" name="btnFactInfoXbox" value="X"
				class="btn btn_white" style="width: 18px"
				onclick="javascript:layerPopClose('factinfoLayer');" alt="닫기" />
		</div>
		<div
			style="width: 500px; height: 300px; overflow-x: hidden; overflow-y: scroll;">
			<table>
				<col width='45' />
				<col width='200' />
				<col width='255' />
				<thead>
					<tr>
						<th scope='col'>NO</th>
						<th scope='col'>사업장코드</th>
						<th scope='col'>사업장명</th>
					</tr>
				</thead>
				<tbody id="dataList1">
				</tbody>
			</table>
		</div>
		<br />
		<center>
			<span style="color: #fff;">사업장코드 : </span> <input type="text"
				id="searchKeyword" name="searchKeyword" style="width: 100px;" /> <input
				type="button" id="btnPopFactSearch" name="btnPopFactSearch"
				value="검색" class="btn btn_search"
				onclick="javascript:getFactinfoList();" alt="검색" />
			<!-- 			<input type="button" id="btnPopFactClose" name="btnPopFactClose" value="닫기" class="btn btn_basic" onclick="javascript:layerPopClose('factinfoLayer');" alt="닫기"/> -->
		</center>
	</div>
	<!--//측정소 검색 레이어-->
	<!--관리자 검색 레이어-->
	<div id="memberLayer" class="divPopup" style="margin-top: 50px;">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" /> <input
				type="button" id="btnMemberXbox" name="btnMemberXbox" value="X"
				class="btn btn_white" style="width: 18px"
				onclick="javascript:layerPopClose('memberLayer');" alt="닫기" />
		</div>
		<table style="width: 500px; text-align: center;">
			<col width='45' />
			<col width='185' />
			<col width='150' />
			<col width='120' />
			<thead>
				<tr>
					<th scope='col'>NO</th>
					<th scope='col'>부서</th>
					<th scope='col'>직급</th>
					<th scope='col'>성명</th>
				</tr>
			</thead>
			<tbody id="dataList2">
			</tbody>
		</table>
	</div>
	<!--//관리자 검색 레이어-->
	<!--장비등록 레이어-->
	<div id="layerEquipInfoReg" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" /> <input
				type="button" id="btnEquipInfoRegXbox" name="btnEquipInfoRegXbox"
				value="X" class="btn btn_white" style="width: 18px"
				onclick="javascript:layerPopClose('layerEquipInfoReg');" alt="닫기" />
		</div>
		<form id="equipInfoRegForm" name="equipInfoRegForm"
			action="/spotmanage/saveEquipInfoReg.do" method="post">

			<table summary="장비등록">
				<caption>장비등록</caption>
				<colgroup>
					<col width="120px" />
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th>시스템</th>
						<td><select name="e_sys_kind">
								<option value="U">IP_USN</option>
								<option value="A">국가수질자동측정망</option>
								<option value="W">방류수질정보</option>
						</select></td>
					</tr>
					<tr>
						<th>장비코드</th>
						<td><input type="text" name="equip_code" maxlength="10" /></td>
					</tr>
					<tr>
						<th>제조사</th>
						<td><input type="text" name="equip_maker" maxlength="10" />
						</td>
					</tr>
					<tr>
						<th>모델명</th>
						<td><input type="text" name="equip_name" maxlength="10" /></td>
					</tr>
				</tbody>
			</table>
		</form>
		<div id="btCarea">
			<input type="button" id="btnSaveEquipInfoReg"
				name="btnSaveEquipInfoReg" value="저장" class="btn btn_white"
				onclick="javascript:saveEquipInfoReg();" alt="저장" />
		</div>
	</div>
	<!--//변경지점 레이어-->
	<div id="layerSpotInfoUpdate" class="divPopup"
		style="left: 13% !important; top: 22% !important; width: 1400px; height: 488px;">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" /> <input
				type="button" id="btnGroRegXbox" name="btnGroRegXbox" value="X"
				class="btn btn_white" style="width: 18px"
				onclick="javascript:layerPopClose('layerSpotInfoUpdate');" alt="닫기" />
		</div>
		<form name="listForm" method="post">
			<input type="hidden" name="factCode" id="factCode" />
			<!--  <input type="hidden" name="pPageNo" id="pPageNo"/> -->
			<div style="width: *; background-color: white; text-align: left;">
				<span>[측정지점변경조회]</span>
			</div>
			<table style="text-align: center; height: 380px;">
				<colgroup>
					<col width="20px" />
					<col width="70px" />
					<col width="70px" />
					<col width="70px" />
					<col width="70px" />
					<col width="50px" />
					<col width="50px" />
					<col width="100px" />
					<col width="100px" />
					<col width="100px" />
					<col width="100px" />
					<col width="200px" />
					<col width="200px" />
				</colgroup>
				<thead>
					<tr style="height: 30px;">
						<th scope="col" rowspan="2" class="noOption"><input
							type="checkbox" name="checkAll" class="check2"
							onclick="javascript:fncCheckAll()"></th>
						<th scope="col" rowspan="2">번호</th>
						<th scope="col" colspan="2">지점코드</th>
						<th scope="col" colspan="2">사업장명</th>
						<th scope="col" colspan="2">수계</th>
						<th scope="col" colspan="2">경도(X)좌표</th>
						<th scope="col" colspan="2">위도(Y)좌표</th>
						<th scope="col" colspan="2">측정소위치</th>
					</tr>
					<tr>
						<th scope="col">신규</th>
						<th scope="col">기존</th>
						<th scope="col">신규</th>
						<th scope="col">기존</th>
						<th scope="col">신규</th>
						<th scope="col">기존</th>
						<th scope="col">신규</th>
						<th scope="col">기존</th>
						<th scope="col">신규</th>
						<th scope="col">기존</th>
						<th scope="col">신규</th>
						<th scope="col">기존</th>
					</tr>
				</thead>
				<tbody id="spotInfoUpdate">

				</tbody>
			</table>
			<table>
				<tr>
					<td>
						<div class="paging">
							<div id="page_number">
								<ul class="paginate" id="pagination2"></ul>
							</div>
						</div>
					</td>
				</tr>
			</table>

		</form>

		<div align="right">
			<input type="button" id="btnSpotInfoUpdate" name="btnSpotInfoUpdate"
				value="저장" class="btn btn_basic"
				onclick="javascript:fnSoptInfoAUpdate();" alt="저장" /> <input
				type="button" id="btnCloseCommonLayer" name="btnCloseCommonLayer"
				value="닫기" class="btn btn_basic"
				onclick="javascript:layerPopClose('layerSpotInfoUpdate');" alt="닫기" />
		</div>

	</div>
</body>
</html>