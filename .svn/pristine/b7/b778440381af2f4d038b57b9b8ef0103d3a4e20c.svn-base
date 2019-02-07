<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : itemDefine.jsp
	 * Description : 측정항목정의 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2010.05.17	khany		최초 생성
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

<script type="text/javascript">
	//<![CDATA[
	//등록시리셋확인
	var insertDiv = false;

	$(function() {

		//goItem();
		//측정항목 등록 레이어
		$("#layerGroupIns").draggable({
			containment : 'body',
			scroll : false
		});
		//측정항목 삭제 레이어
		$("#layerGroupDel").draggable({
			containment : 'body',
			scroll : false
		});
		$("#saveConfirm").draggable({
			containment: 'body',
			scroll: false
		});
		$("#btnGetSpotInfo2").hide();
	});

	function setGroupCode(groupCode) {
		$("#modGroupCode").val(groupCode);
	}

	function groupInsert() {
		var mod = $("#modInsert").val();

		showLoading();
		var dpYn = $("select[name=dpYnInsert]").val();
		var groupName = $("#groupNameInsert").val();
		var memo = $("#memoInsert").val();
		var groupCode = $("#groupCode").val();
		if (mod == "reg") {
			$.ajax({
				type : "post",
				url : "<c:url value='/itemmanage/groupinsert.do'/>",
				data : {
					dpYn : dpYn,
					groupName : groupName,
					memo : memo
				},
				dataType : "json",
				success : function(result) {
					layerPopClose('layerGroupIns');
					GroupList();
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
					$("#dataList").html(
							"<tr><td colspan='6'>서버 접속에 실패하였습니다! [CODE:"
									+ oraErrorCode + "]</td></td>");
					closeLoading();
				}
			});
		} else {
			$.ajax({
				type : "post",
				url : "<c:url value='/itemmanage/groupupdate.do'/>",
				data : {
					dpYn : dpYn,
					groupName : groupName,
					memo : memo,
					groupCode : groupCode
				},
				dataType : "json",
				success : function(result) {
					layerPopClose('layerGroupIns');
					GroupList();
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
					$("#dataList").html(
							"<tr><td colspan='6'>서버 접속에 실패하였습니다! [CODE:"
									+ oraErrorCode + "]</td></td>");
					closeLoading();
				}
			});
		}
	}

	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("layerItemInfoUpdate");
	}

	function goDelGroupLayer() {
		showLoading();
		$.ajax({
			type : "post",
			url : "<c:url value='/itemmanage/getGroupList.do'/>",
			data : {},
			dataType : "json",
			success : function(result) {
				var tot = result['detailViewList'].length;
				if (tot <= 0) {

				} else {
					$("#delGroupCode").html("");
					for (var i = 0; i < tot; i++) {
						layerPopOpen('layerGroupDel');
						var obj = result['detailViewList'][i];
						var dropDownSet = $('select#delGroupCode').append(
								"<option value="+obj.groupCode+" >"
										+ obj.groupCode + "</option>");
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
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				$("#dataList").html(
						"<tr><td colspan='6'>서버 접속에 실패하였습니다! [CODE:"
								+ oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}

	function goGroupDel() {
		showLoading();
		var groupCode = $("#delGroupCode").val();
		$.ajax({
			type : "post",
			url : "<c:url value='/itemmanage/goGroupDel.do'/>",
			data : {
				groupCode : groupCode
			},
			dataType : "json",
			success : function(result) {
				layerPopClose('layerGroupDel');
				GroupList();
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
				$("#dataList").html(
						"<tr><td colspan='6'>서버 접속에 실패하였습니다! [CODE:"
								+ oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}

	function setRow(no, groupCode, groupName, itemCnt, itemList, dpYn) {
		no = nullToString(no);
		groupCode = nullToString(groupCode);
		groupName = nullToString(groupName);
		itemCnt = nullToString(itemCnt);
		itemList = nullToString(itemList);
		dpYn = nullToString(dpYn);
		var str = "";
		var str = "<select name='dpYn'>";
		if (dpYn == 'Y') {
			str += " <option value='Y' selected>사용</option>";
			str += " <option value='N'>미사용</option>";
		} else {
			str += " <option value='N' selected>미사용</option>";
			str += " <option value='Y'>사용</option>";
		}
		//$('<tr></tr>').attr('style','cursor:pointer')
		$('<tr></tr>').append($('<td></td>').append(no)).append(
				$('<td onclick=goItem("' + groupCode + '") ></td>').append(
						groupCode).attr('style', 'cursor:pointer').append(
						$('<input />').attr('name', 'groupCode').attr('value',
								groupCode).attr('type', 'hidden'))).append(
				$('<td onclick=goItem("' + groupCode + '") ></td>').append(
						groupName).attr('style', 'cursor:pointer').append(
						$('<input />').attr('name', 'groupName').attr('value',
								groupName).attr('type', 'hidden'))).append(
				$('<td></td>').append(itemCnt).append(
						$('<input />').attr('name', 'itemCnt').attr('value',
								itemCnt).attr('type', 'hidden'))).append(
				$('<td></td>').append(itemList).append(
						$('<input />').attr('name', 'itemList').attr('value',
								itemList).attr('type', 'hidden'))).append(
				$('<td></td>').append(str)).appendTo("#dataList");

		var trIdx = $('#dataList tr').size() - 1;
		$('#dataList tr:odd').addClass('add');
	}

	function setSave(tablename) {
		$('#' + tablename).ajaxForm().submit();
	}

	function saveItem() {
		var valArr = new Array();
		var groupCode = $("#groupCode").val();

		if ($("input[name=itemCheck]:checked").length > 0) {
			$("input[name=itemCheck]").each(function() {
				if (this.checked) {
					valArr.push(this.value);
				}
			});
		} else {
			alert("체크된 항목이 없습니다.");
			return;
		}
		showLoading();

		$.ajax({
			type : "post",
			url : "<c:url value='/itemmanage/saveItem.do'/>?groupCode="
					+ groupCode + "&valArr=" + valArr,
			dataType : "json",
			success : function(result) {
				goItem($('#groupCode').val());
				GroupList();
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
				$("#dataList").html(
						"<tr><td colspan='6'>서버 접속에 실패하였습니다! [CODE:"
								+ oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}

	function reset() {
		insertDiv = true;
		document.itemForm.reset();
		$("#itemCode").removeAttr("readonly");
		$.ajax({
			type : "post",
			url : "<c:url value='/itemmanage/getItemUnitList.do'/>",
			data : {},
			dataType : "json",
			success : function(result) {
				var tot = result['getUnitList'].length;
				if (tot <= 0) {

				} else {
					for (var i = 0; i < tot; i++) {
						var obj = result['getUnitList'][i];
						$("#itemUnit").append(
								"<option value="+obj.unitSeq+" >"
										+ obj.unitName + "(" + obj.unit + ")"
										+ "</option>");
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
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				$("#dataList").html(
						"<tr><td colspan='6'>서버 접속에 실패하였습니다! [CODE:"
								+ oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}

	function handlerNum(obj) {
		e = window.event;
		if ((e.keyCode >= 48 && e.keyCode <= 57) //숫자열 0~9 : 48~57
				|| e.keyCode == 8 //BackSpace
				|| e.keyCode == 46 //Delete
				|| e.keyCode == 110 //소수점(.) : 문자열 배열
				|| e.keyCode == 190 //소수점(.) : 키패드
				|| e.keyCode == 37 //좌 화살표
				|| e.keyCode == 39 //우 화살표
				|| e.keyCode == 35 //End 키
				|| e.keyCode == 36 //Home 키
				|| e.keyCode == 9 //Tab 키
		) {
			if (e.keyCode == 48 || e.keyCode == 96) {
				return;
			} else {
				return;
			}
		} else {
			e.returnValue = false;
		}
	}

	function goItemInsert() {
		if (insertDiv) {
			if (validateItem()) {
				showLoading();

				var itemCode = $("#itemCode").val();
				var valueFormat = $("#valueFormat").val();
				var itemName = $("#itemName").val();
				var timedurVal = $("#timedurVal").val();
				var itemFname = $("#itemFname").val();
				var itemValueHi = $("#itemValueHi").val();
				var itemValueLo = $("#itemValueLo").val();
				var legYn = $('#legYn').attr("checked") ? "Y" : "N";
				var standYn = $('#standYn').attr("checked") ? "Y" : "N";
				var sameYn = $('#sameYn').attr("checked") ? "Y" : "N";
				var sameValDurTime = $("#sameValDurTime").val();
				var itemUnit = $("select[name=itemUnit]").val();
				$
						.ajax({
							type : "post",
							url : "<c:url value='/itemmanage/goItemInsert.do'/>",
							data : {
								itemCode : itemCode,
								valueFormat : valueFormat,
								itemName : itemName,
								timedurVal : timedurVal,
								itemFname : itemFname,
								itemValueHi : itemValueHi,
								itemValueLo : itemValueLo,
								legYn : legYn,
								standYn : standYn,
								sameYn : sameYn,
								sameValDurTime : sameValDurTime,
								itemUnit : itemUnit
							},
							dataType : "json",
							success : function(result) {
								insertDiv = false;
								alert("등록 하였습니다.");
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
								$("#dataList").html(
										"<tr><td colspan='6'>서버 접속에 실패하였습니다! [CODE:"
												+ oraErrorCode + "]</td></td>");
								closeLoading();
							}
						});
			}
		} else {
			alert("리셋을 하셔야 등록이 가능합니다.");
			return;
		}
	}

	function goItemUpdate(str) {
		var urlv = "";
		
		if(str == "A"){
		urlv = "<c:url value='/itemmanage/goItemAllUpdate.do'/>";
		}else{
		urlv = "<c:url value='/itemmanage/goItemUpdate.do'/>";
		}
		showLoading();

		if (validateItem()) {
			var itemCode = $("#itemCode").val();
			var valueFormat = $("#valueFormat").val();
			var itemName = $("#itemName").val();
			var timedurVal = $("#timedurVal").val();
			var itemFname = $("#itemFname").val();
			var itemValueHi = $("#itemValueHi").val();
			var itemValueLo = $("#itemValueLo").val();
			var legYn = $('#legYn').attr("checked") ? "Y" : "N";
			var standYn = $('#standYn').attr("checked") ? "Y" : "N";
			var sameYn = $('#sameYn').attr("checked") ? "Y" : "N";
			var sameValDurTime = $("#sameValDurTime").val();
			var itemUnit = $("select[name=itemUnit]").val();

			$.ajax({
				type : "post",
				url : urlv,
				data : {
					itemCode : itemCode,
					valueFormat : valueFormat,
					itemName : itemName,
					timedurVal : timedurVal,
					itemFname : itemFname,
					itemValueHi : itemValueHi,
					itemValueLo : itemValueLo,
					legYn : legYn,
					standYn : standYn,
					sameYn : sameYn,
					sameValDurTime : sameValDurTime,
					itemUnit : itemUnit
				},
				dataType : "json",
				success : function(result) {
					alert("저장 하였습니다.");
					closeLoading();
					layerPopClose('saveConfirm'); 
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
					$("#dataList").html(
							"<tr><td colspan='6'>서버 접속에 실패하였습니다! [CODE:"
									+ oraErrorCode + "]</td></td>");
					closeLoading();
				}
			});
		}
	}

	function goItemDelete() {
		var itemCode = $("#itemCode").val();

		if (confirm("항목을 삭제 하시겠습니까?")) {
			showLoading();

			$.ajax({
				type : "post",
				url : "<c:url value='/itemmanage/goItemDelete.do'/>",
				data : {
					itemCode : itemCode
				},
				dataType : "json",
				success : function(result) {
					reset();
					goItem($('#groupCode').val());
					alert("삭제 하였습니다.");
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
					$("#dataList").html(
							"<tr><td colspan='6'>서버 접속에 실패하였습니다! [CODE:"
									+ oraErrorCode + "]</td></td>");
					closeLoading();
				}
			});
		}
	}

	function valueFormatInfo(number) {
		var viewnumber = "###";
		if (number <= 0) {

		} else {
			viewnumber += ".";
			for (var i = 0; i < number; i++) {
				viewnumber += "#";
			}
		}
		$("#valueFormatInfo").html(viewnumber);
	}

	//항목관리 폼 체크
	function validateItem() {
		if ($('#itemCode').val().length == 0) {
			alert("항목코드을 입력해 주세요");
			return false;
		}

		if ($('#itemName').val().length < 2) {
			alert("항목명을 입력해 주세요.");
			return false;
		}

		if ($("#itemFname").val().length == 0) {
			alert('표기명을 입력해 주세요');
			return false;
		}

		if ($("#valueFormat").val().length == 0) {
			alert('유효자리수를 입력해 주세요');
			return false;
		}

		if ($("#itemUnit").val().length == 0) {
			alert('단위를 선택해 주세요');
			return false;
		}
		return true;
	}

	function clickTrEvent(trObj) {
		var tr = eval("document.getElementById(\"" + trObj.id + "\")");
		$(tr).parent().find("tr td").removeClass("tr_on");
		$(tr).find("td").addClass("tr_on");
	}

	function LayerPopEditOpen(flag) {
		$("#modInsert").val(flag);

		if (flag == "reg") {
			// 등록을 위한 레이어에 초기화
			$("#groupNameInsert").val("");
			$("#memoInsert").val("");
			$("#dpYnInsert > option:first").attr("selected", "true");
		} else {
			var groupCode = $("#groupCode").val();

			if (groupCode == "") {
				alert("그룹을 선택해 주세요.");
				return;
			} else {
				$
						.ajax({
							type : "post",
							url : "<c:url value='/itemmanage/getItemInfo.do'/>",
							data : {
								groupCode : groupCode
							},
							dataType : "json",
							success : function(result) {
								var groupMemo = result['groupMemo'];

								$("#groupNameInsert").val(groupMemo.groupName);
								$("#memoInsert").val(groupMemo.memo);
								$("#dpYnInsert > option:first").attr(
										"selected", "true");

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
								closeLoading();
							}
						});
			}
		}

		layerPopOpen("layerGroupIns");
	}

	function delGroupInfo() {
		var groupCode = $("#modGroupCode").val();

		if (groupCode == '') {
			alert("그룹을 선택해주세요.");
			return;
		}

		if (confirm("삭제하시겠습니까?")) {
			$.ajax({
				type : "post",
				url : "<c:url value='/itemmanage/goGroupDel.do'/>",
				data : {
					groupCode : groupCode
				},
				dataType : "json",
				success : function(result) {
					$("#modInsert").val();
					$("#modGroupCode").val();

					alert("정상적으로 삭제되었습니다.");

					GroupList();
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
					closeLoading();
				}
			});
		}
	}

	//항목그룹 목록  - 신규
	function GroupList() {
		showLoading();
		$
				.ajax({
					type : "post",
					url : "<c:url value='/itemmanage/getGroupList.do'/>",
					data : {},
					dataType : "json",
					success : function(result) {
						var tot = result['detailViewList'].length;
						$("#dataList").html("");
						if (tot <= 0) {
							$("#dataList")
									.html(
											"<tr><td colspan='2' style='text-align:center;'>조회 결과가 없습니다</td></td>");
						} else {
							var html = "";
							var main_html = "";

							for (var i = 0; i < tot; i++) {
								var obj = result['detailViewList'][i];
								var pageInfo = result['paginationInfo'];
								var no = i
										+ ((pageInfo.currentPageNo - 1) * pageInfo.recordCountPerPage)
										+ 1;
								var trNo = i + 1;
								var dpYnName = "";
								var even = "";
								if (i % 2 == 1) {
									even = "even"
								}
								main_html += "	<tr id='tr"
										+ trNo
										+ "' class='tr"
										+ i
										+ "' onclick=\"javascript:clickTrEvent(this); setGroupCode('"
										+ obj.groupCode + "'); goItem('"
										+ obj.groupCode
										+ "');\" style='cursor:pointer;'></>";
								main_html += "		<td colspan='2' >"
										+ obj.itemList + "</td>";
								main_html += "	</tr>";
							}
							$("#dataList").html(main_html);
							$("#div_result tbody tr:odd").addClass("even");

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
								"<tr><td colspan='6'>서버 접속에 실패하였습니다! [CODE:"
										+ oraErrorCode + "]</td></td>");
						closeLoading();
					}
				});
	}
	//var groupCode = $("#modGroupCode").val();
	
	function goItemList(groupCode) {
		insertDiv = true;
		showLoading();

		$
				.ajax({
					type : "post",
					url : "<c:url value='/itemmanage/getTakItemList.do'/>",
					data : {
						groupCode : groupCode
					},
					dataType : "json",
					success : function(result) {
						var tot = result['getGroupItemList'].length;
						var tot1 = result['getItemList'].length;
						$("#dataList").html("");

						var item;
						if (tot1 <= 0) {

						} else {
							for (var i = 0; i < tot1; i++) {
								var obj = result['getItemList'][i];
								if (tot <= 0) {
									item = "<tr>";
									item += "<td colspan='2'><a href=javascript:goItemView('"+ obj.itemCode	+","+groupCode+"'); >"
											+ obj.itemFname + "</a></td>";
									item += "</tr>";
									$("#dataList").append(item);
									;
								} else {
									var flag = false;

									for (var j = 0; j < tot; j++) {
										var obj1 = result['getGroupItemList'][j];
										if (obj.itemCode == obj1.itemCode) {
											item = "<tr>";
											item += "<td colspan='2'><a href=javascript:goItemView('"
													+ obj.itemCode
													+ "','"
													+ groupCode
													+ "'); >"
													+ obj.itemFname
													+ "</a></td>";
											item += "</tr>";
											$("#dataList").append(item);
										}
									}
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
								"<tr><td colspan='5'>서버 접속에 실패하였습니다! [CODE:"
										+ oraErrorCode + "]</td></td>");
						closeLoading();
					}
				});
	}
	
	function goItemList2() {
		insertDiv = true;
		showLoading();
		var groupCode = $("#itemGroupSelect").val();
		//alert(groupCode);
		$
				.ajax({
					type : "post",
					url : "<c:url value='/itemmanage/getTakItemList.do'/>",
					data : {
						groupCode : groupCode
					},
					dataType : "json",
					success : function(result) {
						var tot = result['getGroupItemList'].length;
						var tot1 = result['getItemList'].length;
						$("#dataList").html("");

						var item;
						if (tot1 <= 0) {

						} else {
							for (var i = 0; i < tot1; i++) {
								var obj = result['getItemList'][i];
								if (tot <= 0) {
									item = "<tr>";
									item += "<td colspan='2'><a href=javascript:goItemView('"+ obj.itemCode	+","+groupCode+"'); >"
											+ obj.itemFname + "</a></td>";
									item += "</tr>";
									$("#dataList").append(item);
									;
								} else {
									var flag = false;

									for (var j = 0; j < tot; j++) {
										var obj1 = result['getGroupItemList'][j];
										if (obj.itemCode == obj1.itemCode) {
											item = "<tr>";
											item += "<td colspan='2'><a href=javascript:goItemView('"
													+ obj.itemCode
													+ "','"
													+ groupCode
													+ "'); >"
													+ obj.itemFname
													+ "</a></td>";
											item += "</tr>";
											$("#dataList").append(item);
										}
									}
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
								"<tr><td colspan='5'>서버 접속에 실패하였습니다! [CODE:"
										+ oraErrorCode + "]</td></td>");
						closeLoading();
					}
				});
	}
	
	function goItemView(itemCode,groupCode) {
		insertDiv = false;
		showLoading();
		
				
				
		$.ajax({
			type : "post",
			url : "<c:url value='/itemmanage/goItemView.do'/>",
			data : {
				itemCode : itemCode,
				groupCode: groupCode
			},
			dataType : "json",
			success : function(result) {
				var obj = result['itemVO'];
				if (obj != "null") {
					$("#itemCode").val(obj.itemCode).attr('readonly',
							'readonly');
					$("#valueFormat").val(obj.valueFormat);
					$("#itemName").val(obj.itemName);
					$("#timedurVal").val(obj.timedurVal);
					$("#sameValDurTime").val(obj.sameValDurTime);
					$("#itemFname").val(obj.itemFname);
					$("#itemValueHi").val(obj.itemValueHi);
					$("#itemValueLo").val(obj.itemValueLo);
					obj.legYn == 'Y' ? $("#legYn").attr("checked", "checked")
							: $("#legYn").removeAttr("checked");
					obj.standYn == 'Y' ? $("#standYn").attr("checked",
							"checked") : $("#standYn").removeAttr("checked");
					obj.sameYn == 'Y' ? $("#sameYn").attr("checked", "checked")
							: $("#sameYn").removeAttr("checked");
				}
				var tot = result['getUnitList'].length;
				valueFormatInfo(obj.valueFormat);

				if (tot <= 0) {
					alert(tot);
				} else {
					$("#itemUnit").find("option").remove();
					for (var i = 0; i < tot; i++) {
						var obj1 = result['getUnitList'][i];
						if (obj.itemUnit == obj1.unitSeq) {
							$("#itemUnit").append(
									"<option value="+obj1.unitSeq+" selected='selected'>"
											+ obj1.unitName + "(" + obj1.unit
											+ ")" + "</option>");
						} else {
							$("#itemUnit").append(
									"<option value="+obj1.unitSeq+" >"
											+ obj1.unitName + "(" + obj1.unit
											+ ")" + "</option>");
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
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				$("#dataList").html(
						"<tr><td colspan='6'>서버 접속에 실패하였습니다! [CODE:"
								+ oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}

	function systemSelect(funtion) {
		//itemGroupSelect
		//alert("!!!");
		showLoading();
		$
				.ajax({
					type : "post",
					url : "<c:url value='/itemmanage/getGroupList.do'/>",
					data : {},
					dataType : "json",
					success : function(result) {
						var systemSelect = "";
						var tot = result['detailViewList'].length;
						$("#dataList").html("");
						if (tot <= 0) {
							$("#dataList")
									.html(
											"<tr><td colspan='2' style='text-align:center;'>조회 결과가 없습니다</td></td>");
						} else {
							var html = "";
							var main_html = "";
							$("#itemGroupSelect").find("option").remove();
							$("#itemGroupSelect")
									.append(
											"<option value='' selected='selected'>그룹선택</option>");
							if ($('#systemSelect').val() == 'ipusn') {
								for (var i = 0; i < tot; i++) {
									var obj = result['detailViewList'][i];
									if (obj.groupCode == 'IG1084') {
										$("#itemGroupSelect")
												.append(
														"<option value="
																+ obj.groupCode
																+ " onclick=goItemList('"
																+ obj.groupCode
																+ "'); >"
																+ obj.groupName
																+ "</option>");
									}
								}
							} else {
								for (var i = 0; i < tot; i++) {
									var obj = result['detailViewList'][i];
									if (obj.groupCode != 'IG1084') {
										$("#itemGroupSelect")
												.append(
														"<option value="
																+ obj.groupCode
																+ " onclick=goItemList('"
																+ obj.groupCode
																+ "'); >"
																+ obj.groupName
																+ "</option>");
									}
								}
							}
						}
						if($('#systemSelect').val() == 'ipusn'){
							$("#itemDefineButton").show();
							$("#btnGetSpotInfo2").hide();
						}else{
							$("#itemDefineButton").hide();
							$("#btnGetSpotInfo2").show();
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
								"<tr><td colspan='2'>서버 접속에 실패하였습니다! [CODE:"
										+ oraErrorCode + "]</td></td>");
						closeLoading();
					}
				});

	}
	
	function systemSelect2(funtion) {
		//itemGroupSelect
		//alert("!!!");		
		showLoading();
		$
				.ajax({
					type : "post",
					url : "<c:url value='/itemmanage/getGroupList.do'/>",
					data : {},
					dataType : "json",
					success : function(result) {
						var systemSelect = "";
						var tot = result['detailViewList'].length;
						$("#dataList").html("");
						if (tot <= 0) {
							$("#dataList")
									.html(
											"<tr><td colspan='2' style='text-align:center;'>조회 결과가 없습니다</td></td>");
						} else {
							var html = "";
							var main_html = "";
							
							$("#itemGroupSelect").find("option").remove();							
							$("#itemGroupSelect")
									.append(
											"<option value='' selected='selected'>그룹선택</option>");
							if ($('#systemSelect').val() == 'ipusn') {
								for (var i = 0; i < tot; i++) {
									var obj = result['detailViewList'][i];
									if (obj.groupCode == 'IG1084') {
										$("#itemGroupSelect")
												.append(
														"<option value="
																+ obj.groupCode
																+ " onclick=goItemList2(); >"
																+ obj.groupName
																+ "</option>");
									}
								}
							} else {
								for (var i = 0; i < tot; i++) {
									var obj = result['detailViewList'][i];
									if (obj.groupCode != 'IG1084') {
										$("#itemGroupSelect")
												.append(
														"<option value="
																+ obj.groupCode
																+ " onclick=goItemList2(); >"																
																+ obj.groupName
																+ "</option>");
									}
								}
							}
						}
						if($('#systemSelect').val() == 'ipusn'){
							$("#itemDefineButton").show();
							$("#btnGetSpotInfo2").hide();
						}else{
							$("#itemDefineButton").hide();
							$("#btnGetSpotInfo2").show();
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
								"<tr><td colspan='2'>서버 접속에 실패하였습니다! [CODE:"
										+ oraErrorCode + "]</td></td>");
						closeLoading();
					}
				});

	}

	function goSaveConfirm(){
		$("#layerFullBgDiv").show();
		var name = "saveConfirm";
		var win = $(window);
		var winH = win.scrollTop() + ((win.height() - $('#'+ name).height()) / 2);
		var winW = win.scrollLeft() + ((win.width() - $('#'+ name).width()) / 2);
		$('#'+ name).css('top', winH);
		$('#'+ name).css('left', winW);
		$('#'+ name).show();
		$('#'+ name).focus();
	}
	// 페이지 번호 클릭
	function linkPage(pageNo) {
		getItemInfoA(pageNo);
	}
	//체크박스 선택된 항목
	function fncManageChecked() {
		
		var resultCheck = false;
		
		var checkField = document.listForm.delYn;
		var checkId = document.listForm.checkId;
		
		var returnId = "";
		
		var checkedCount = 0;
		if(checkField) {
			if(checkField.length > 1) {
				for(var i=0; i<checkField.length; i++) {
					if(checkField[i].checked) {
						
						checkedCount++;
						checkField[i].value = checkId[i].value;
						if(returnId == "") {
							returnId = checkField[i].value;
						
						}
						else {
							returnId        = returnId + ":" + checkField[i].value;
							
						}
					}
				}
				
				if(checkedCount > 0) 
					resultCheck = true;
				else {
					alert("선택된  항목이 없습니다.");
					resultCheck = false;
				}
				
			} else {
				 if(document.listForm.delYn.checked == false) {
					alert("선택 항목이 없습니다.");
					resultCheck = false;
				}
				else {
					returnId = checkId.value;
					
					resultCheck = true;
				}
			} 
		} else {
			alert("조회된 결과가 없습니다.");
		}
		
		document.listForm.itemCode.value = returnId;
		
		return resultCheck;
	}
	
	function fnItemInfoAUpdate() {
		if(fncManageChecked()) {
			if(confirm("변경사항을 저장하시겠습니까?")) {
				document.listForm.action = "<c:url value='/itemmanage/saveItemInfoA.do'/>";
				document.listForm.submit();
			}
		} else return;
	}
	//국가수질 - 측정항목변경내용 조회
	function getItemInfoA(pageNo) {

		layerPopOpen("layerItemInfoUpdate");
		
		$("#itemInfoUpdate").html("");
		
		showLoading();
		
		if (pageNo == null)
			pageNo = 1;
		$
				.ajax({
					type : "post",
					url : "<c:url value='/itemmanage/getItemInfoA.do'/>",
					data : {
						pageIndex : pageNo
					},
					dataType : "json",
					success : function(result) {
						var tot = result['itemInfoList'].length;
						
						var item;
						if (tot <= 0) {
							item = "<tr><td colspan='8' style='height:316px;'>조회 결과가 없습니다.</td></tr>"
							$("#itemInfoUpdate").html(item);
						} else {
							for (var i = 0; i < tot; i++) {
								var obj = result['itemInfoList'][i];
								var pageInfo = result['paginationInfo'];							
								//obj.no = no;
								var no = i
										+ ((pageInfo.currentPageNo - 1) * pageInfo.recordCountPerPage)
										+ 1;
			 					item += "<tr>"
			 					      //+   "<td><input type='checkbox' name='delYn' class='check2'></td>"
			 					      +   "<td class='noOption'><input type='checkbox' name='delYn' class='check2'><input type='hidden' name='checkId' value="+obj.itemCode+" />"    
			 					      +   "</td>"
			 					      +   "<td><span>"+no+"</span></td>"
			 					      +   "<td>"+obj.itemCode+  "</td>"
			 					      +   "<td>"+obj.itemCode1+ "</td>"
			 					      +   "<td>"+obj.itemName+  "</td>"
			 					      +   "<td>"+obj.itemName1+ "</td>"
			 					      +   "<td>"+obj.valueFormat+  "</td>"
			 					      +   "<td>"+obj.valueFormat1+ "</td>"
			 					 	  +  "</tr>";	
							}
			 				// 페이징 정보
							 var pageStr = makePaginationInfo(result['paginationInfo']);
							$("#pagination2").empty();
							$("#pagination2").append(pageStr);
							$("#rpage").val(pageNo); 
							
							$("#itemInfoUpdate").append(item);
							$("#itemInfoUpdate tr:odd").attr("class", "add");
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
						$("#itemInfoUpdate").html(
								"<tr><td colspan='8' style='height:316px;'>서버 접속에 실패하였습니다! [CODE:"
										+ oraErrorCode + "]</td></td>");
						closeLoading();
					}
				});
	}
	
	
	
	
	
	//]]>
</script>
</head>

<body>
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

					<!--tab Contnet Start-->
					<div class="tab_container">

						<input type="hidden" id="groupCode" name="groupCode" />
						<fieldset class="first">
							<legend class="hidden_phrase">지점관리 검색조건 폼 및 엑셀, 신규등록(수계,
								시스템, 명칭 및 )</legend>

							<form id="listFrm" name="listFrm"
								action="/itemmanage/setSaveGroup.do" onsubmit="return false">
								<div>



									<div id="div_result">
										<div class="table_wrapper">
											<div class="overBox" style="height: 400px">
												<table summary="IPUSN 측정항목정의">
													<colgroup>
														<col width="300px" />
														<col width="" />
													</colgroup>
													<tr>
														<td style="padding: 5px; vertical-align: top;">
															<div style="height: 380px; overflow-y: auto;">
																<table summary="IPUSN 시스템">
																	<colgroup>
																		<col width="100px" />
																		<col width="" />
																	</colgroup>
																	<thead>
																		<tr>
																			<th>시스템</th>
																			<th><select id="systemSelect"
																				name="systemSelect" style="width: 90%;" onchange="systemSelect2('system');" >
																					<option value="" selected="selected">시스템선택</option>
																					<option value="ipusn"
																						onclick="systemSelect('system');">이동형측정기기</option>
																					<option value="watertake"
																						onclick="systemSelect('system');">수질자동측정망</option>
																			</select></th>
																		</tr>
																		<tr>
																			<th>항목그룹</th>
																			<th><select id="itemGroupSelect"
																				name="itemGroupSelect" style="width: 90%;" onchange="goItemList2();">
																					<option value="">그룹선택</option>
																			</select></th>
																		</tr>
																	</thead>
																	<tbody id="dataList">
																		<tr>
																			<td colspan="2">&nbsp;</td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</td>

														<td style="padding: 5px; vertical-align: top;">
															<form id="itemForm" name="itemForm">
																<table summary="IPUSN 측정항목정의">
																	<colgroup>
																		<col width="25%" />
																		<col width="25%" />
																		<col width="25%" />
																		<col width="25%" />
																		<!-- <col width="10%" /> -->
																	</colgroup>

																	<tbody id="">
																		<tr>
																			<th>항목코드</th>
																			<td colspan="3"><input type="text" id="itemCode"
																				name="itemCode"
																				style="width: 85%; ime-mode: disabled;"
																				onkeyup="this.value=this.value.toUpperCase();"
																				maxlength="5" /></td>
																		</tr>
																		<tr>
																			<th>항목명</th>
																			<td colspan="3"><input type="text" id="itemName"
																				name="itemName" style="width: 85%" /></td>
																		</tr>
																		<tr>
																			<th>표기명</th>
																			<td colspan="3"><input type="text"
																				id="itemFname" name="itemFname" style="width: 85%" /></td>
																		</tr>
																		<tr>
																			<th>단위</th>
																			<td colspan="3"><select id="itemUnit"
																				name="itemUnit" style="width: 97%;">
																					<option value="">단위선택</option>
																			</select></td>
																		</tr>
																		<tr>
																			<th>유효자리수</th>
																			<td colspan="3"><input type="text"
																				id="valueFormat" name="valueFormat"
																				style="width: 10%" maxlength="1"
																				onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"
																				onchange="valueFormatInfo(this.value);" /> &nbsp;<span
																				id="valueFormatInfo" /></td>
																			<td></td>
																		</tr>
																		<tr>
																			<th>기준값</th>
																			<td colspan="3"><input type="text"
																				id="timedurVal" name="timedurVal"
																				style="width: 85%; ime-mode: disabled;"
																				onKeyPress="handlerNum(this);" /></td>
																		</tr>
																		<!-- 
																		<tr>
																			<th>동일값지속시간(분)</th>
																			<td colspan="3"><input type="text"
																				id="sameValDurTime" name="sameValDurTime"
																				style="width: 85%; ime-mode: disabled;"
																				onKeyPress="handlerNum(this);" /></td>
																			<td>적용<input type="checkbox" id="sameYn"
																				name="sameYn" /></td>
																		</tr>
																		 -->
																		<tr>
																			<th>경보기준상한값</th>
																			<td><input type="text" id="itemValueHi"
																				name="itemValueHi"
																				style="width: 85%; ime-mode: disabled;"
																				onKeyPress="handlerNum(this)" /></td>
																			<th>경보기준하한값</th>
																			<td><input type="text" id="itemValueLo"
																				name="itemValueLo"
																				style="width: 85%; ime-mode: disabled;"
																				onKeyPress="handlerNum(this)" /></td>
																		</tr>
																		<tr>
																			<th>기준값사용</th>
																			<td>적용<input type="checkbox" id="standYn"
																				name="standYn" /></td>
																			<th>검출대상</th>
																			<td>적용<input type="checkbox" id="legYn"
																				name="legYn" /></td>
																		</tr>

																	</tbody>
																</table>
															</form>
														</td>
													</tr>
												</table>
											</div>
										</div>
									</div>
								</div>
							</form>
							<!-- 							<div class="paging"> -->
							<!-- 								<div id="page_number"> -->
							<!-- 									<ul class="paginate" id="pagination"></ul> -->
							<!-- 								</div> -->
							<!-- 							</div> -->
							<!--top Search Start-->
							<!-- 
							<div style="text-align: right;" id="btnGetSpotInfo2">
							<input type="button" id="btnGetSpotInfo" name="btnGetSpotInfo" value="변경항목"
							class="btn btn_basic"
							onclick="javascript:getItemInfoA();"
							alt="변경항목"/>
							</div>
							 -->
							<div style="text-align: right;" id="itemDefineButton">
								<input type="button" id="btnResetGoItem" name="btnResetGoItem"
									value="리셋" class="btn btn_basic" onclick="javascript:reset();"
									alt="리셋" /> <input type="button" id="btnSaveGoItem"
									name="btnSaveGoItem" value="저장" class="btn btn_basic"
									onclick="javascript:goSaveConfirm();" alt="저장" />
							</div>
							<!--top Search End-->
						</fieldset>

					</div>
					<!--tab Contnet End-->
				</div>
			</div>
			
		<div id="saveConfirm" class="divPopup" style="margin-top:50px;">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnMemberXbox" name="btnMemberXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('saveConfirm');" alt="닫기"/>
		</div>
		<div style="width: 400px;height: 80px;">
			<div>
				<span style="color: white; font-size: large;">측정항목정의를 저장하시겠습니까?</span>
				<br></br>
			</div>
			<div>
			<input type="button" id="btnMemberXbox" name="btnMemberXbox" value="측정항목(지점+공통)적용" class="btn btn_white" style="width:180px;font-size: medium; color: red !important ;" onclick="javascript:goItemUpdate('A');" alt="닫기"/>
			<input type="button" id="btnMemberXbox" name="btnMemberXbox" value="측정항목(공통)적용" class="btn btn_white" style="width:180px;font-size: medium;" onclick="javascript:goItemUpdate('N');" alt="닫기"/>
			</div>
		</div>
		</div>	
			
		<div id="layerItemInfoUpdate" class="divPopup" style="left: 30% !important; top: 25% !important; height: 500px;">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnGroRegXbox" name="btnGroRegXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerItemInfoUpdate');" alt="닫기"/>
		</div>
		<form name="listForm" method="post">
		<input type="hidden" name="itemCode" id="itemCode"/>
		<div style="width: *; background-color: white; text-align: left;">
			<span>
			[측정항목변경조회]
			</span>
		</div>
		<table style="text-align:center;height:380px;">
			<colgroup>
				<col width="40px" />
				<col width="40px" />
				<col width="70px" />
				<col width="70px" />
				<col width="70px" />
				<col width="70px" />
				<col width="70px" />
				<col width="70px" />
			</colgroup>
			<thead>
				<tr style="height: 30px;">
					<th scope="col" rowspan="2" class="noOption"><input type="checkbox" name="checkAll" class="check2" onclick="javascript:fncCheckAll()"></th>
					<th scope="col" rowspan="2">번호</th>
					<th scope="col" colspan="2">항목코드</th>
					<th scope="col" colspan="2">항목명</th>
					<th scope="col" colspan="2">유효자리수</th>
				</tr>
				<tr>
					<th scope="col">신규</th>
					<th scope="col">기존</th>
					<th scope="col">신규</th>
					<th scope="col">기존</th>
					<th scope="col">신규</th>
					<th scope="col">기존</th>
				</tr>
			</thead>

			<tbody id="itemInfoUpdate">
			
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
			<input type="button" id="btnItemInfoUpdate"
				name="btnItemInfoUpdate" value="저장" class="btn btn_basic"
				onclick="javascript:fnItemInfoAUpdate();" alt="저장" /> <input
				type="button" id="btnCloseCommonLayer" name="btnCloseCommonLayer"
				value="닫기" class="btn btn_basic"
				onclick="javascript:layerPopClose('layerItemInfoUpdate');" alt="닫기" />
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