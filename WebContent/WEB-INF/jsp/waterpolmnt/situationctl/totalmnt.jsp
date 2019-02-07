<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=9">
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css"
		href="<c:url value='/css/content.css'/>" />
	<link rel="stylesheet" type="text/css"
		href="<c:url value='/css/popup.css'/>" />
	<script
		src="<c:url value='/js/JQuery/jquery-1.3.2.min.js" type="text/javascript'/>"></script>
	<script
		src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js" type="text/javascript'/>"></script>
	<script
		src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js" type="text/javascript'/>"></script>
	<script type="text/javascript"
		src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>

	<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>"
		rel="stylesheet" />
	<script type="text/javascript"
		src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
	<script type="text/javascript"
		src="<c:url value='/js/JQuery/ui/ui.datepicker.js'/>"></script>

	<script type='text/javascript'>
		var TITLE = "";
		var first = true;

		$(function() {
			showAlga();
			//setInterval('flowText()', 25000); 

			reloadData();
			TotalMntMainTopTS();
			chart();
			AutoScroll();

			getItemDropDownAll();
			getItemDropDownR01();
			getItemDropDownR03();
			getItemDropDownR02();
			getItemDropDownR04();
			loadAlertStepList();

			$("#river_div")
					.change(
							function() {
								$("#dataList")
										.html(
												"<tr><td colspan='6'><span>데이터를 불러옵니다...</span></td></tr>");
								refresh();
								mapMove();
							});

			$("#sys")
					.change(
							function() {
								$("#dataList")
										.html(
												"<tr><td colspan='6'><span>데이터를 불러옵니다...</span></td></tr>");
								getItemDropDownAll();
								refresh();
								mapMoveSys();
							});

			$("#item")
					.change(
							function() {
								$("#dataList")
										.html(
												"<tr><td colspan='6'><span>데이터를 불러옵니다...</span></td></tr>");
								refresh();
							});

			$('#sysR01')
					.change(
							function() {
								$("#dataListR01")
										.html(
												"<tr><td colspan='4'><span>데이터를 불러옵니다...</span></td></tr>");
								getItemDropDownR01();
								//chartChange(1); item change가 끝나면 실행
							});

			$('#sysR03')
					.change(
							function() {
								$("#dataListR03")
										.html(
												"<tr><td colspan='4'><span>데이터를 불러옵니다...</span></td></tr>");
								getItemDropDownR03();
								//chartChange(3);
							});

			$('#sysR02')
					.change(
							function() {
								$("#dataListR02")
										.html(
												"<tr><td colspan='4'><span>데이터를 불러옵니다...</span></td></tr>");
								getItemDropDownR02();
								//chartChange(2);
							});

			$('#sysR04')
					.change(
							function() {
								$("#dataListR04")
										.html(
												"<tr><td colspan='4'><span>데이터를 불러옵니다...</span></td></tr>");
								getItemDropDownR04();
								//chartChange(4);
							});

			$('#itemR01')
					.change(
							function() {
								$("#dataListR01")
										.html(
												"<tr><td colspan='4'><span>데이터를 불러옵니다...</span></td></tr>");
								refreshR01();
								chartChange(1);
							});

			$('#itemR03')
					.change(
							function() {
								$("#dataListR03")
										.html(
												"<tr><td colspan='4'><span>데이터를 불러옵니다...</span></td></tr>");
								refreshR03();
								chartChange(3);
							});

			$('#itemR02')
					.change(
							function() {
								$("#dataListR02")
										.html(
												"<tr><td colspan='4'><span>데이터를 불러옵니다...</span></td></tr>");
								refreshR02();
								chartChange(2);
							});

			$('#itemR04')
					.change(
							function() {
								$("#dataListR04")
										.html(
												"<tr><td colspan='4'><span>데이터를 불러옵니다...</span></td></tr>");
								refreshR04();
								chartChange(4);
							});

			setChartPopup();

			refreshWeather();

			dataLoad_weatherWarn();

			$("#chart1").load(function() {
				onImgLoad();
				$("#chartLoading1").hide();
			});
			$("#chart2").load(function() {
				onImgLoad();
				$("#chartLoading2").hide();
			});
			$("#chart3").load(function() {
				onImgLoad();
				$("#chartLoading3").hide();
			});
			$("#chart4").load(function() {
				onImgLoad();
				$("#chartLoading4").hide();
			});
		});

		var imgLoadCnt = 0;

		function onImgLoad() {
			imgLoadCnt++;

			if (imgLoadCnt == 4) {
				$("#loadingDiv").dialog("close");

				$("#layerBtn1con").hide();
				$("#layerBtn2con").hide();

				$("#layer_data_box1").css("visibility", "visible");
				$("#layer_data_box2").css("visibility", "visible");
			}
		}

		function setChartPopup() {
			//$("#chart1").click(function() { openChartPopup('T', 'R01'); });
			//$("#chart2").click(function() { openChartPopup('T', 'R03'); });
			//$("#chart3").click(function() { openChartPopup('T', 'R02'); });
			//$("#chart4").click(function() { openChartPopup('T', 'R04'); });

			$("#chartImg1").click(function() {
				openChartPopup('T', 'R01');
			});
			$("#chartImg1").css("cursor", "pointer");
			$("#chartImg2").click(function() {
				openChartPopup('T', 'R02');
			});
			$("#chartImg2").css("cursor", "pointer");
			$("#chartImg3").click(function() {
				openChartPopup('T', 'R03');
			});
			$("#chartImg3").css("cursor", "pointer");
			$("#chartImg4").click(function() {
				openChartPopup('T', 'R04');
			});
			$("#chartImg4").css("cursor", "pointer");
		}

		function openChartPopup(sys, river) {

			var system = $('#sys' + river).val();

			var sw = screen.width;
			var sh = screen.height;
			// 	var winWidth = 627;
			// 	var winHeight = 538;
			var winWidth = 627;
			var winHeight = 558;
			var winLeftPost = (sw - winWidth) / 2;
			var winTopPost = (sh - winHeight) / 2;

			window
					.open(
							"<c:url value='/waterpolmnt/situationctl/goTotalMntGraph.do?'/>sys="
									+ system + "&river=" + river,
							'TotamMntChartSummary',
							'width='
									+ winWidth
									+ ',height='
									+ winHeight
									+ ',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='
									+ winLeftPost + ',top=' + winTopPost);
		}

		function mapMove() {
			var river_div = $("#river_div").val();

			if (river_div == "R01")
				mov2level('37.5258497, 127.3081805, 9');
			else if (river_div == "R02")
				mov2level('35.8759486, 128.5950195, 8');
			else if (river_div == "R03")
				mov2level('36.1888999, 127.0926905, 9');
			else if (river_div == "R04")
				mov2level('35.0817827, 126.8315419, 10');
			else if (river_div == "all")
				mov2level('36.635412,128.287354, 7');
		}

		function mapMoveSys() {
			var sys = $("#sys").val();

			layerControlByVal(sys);
		}

		function mapMoveBranch(lat, lng) {
			mov2(lat, lng);
		}

		function getItemDropDownAll() {
			var sys = $('#sys').val();
			var itemCode = "";

			if (sys == 'U') {
				itemCode = "22";
			} else if (sys == 'T') {
				itemCode = "52";
			} else if (sys == 'A') {
				itemCode = "37";
			} else {
				itemCode = "22";
			}

			var dropDownSet = $('#item');

			$.getJSON("<c:url value='/common/code/getCode.do'/>", {
				codeGbn : itemCode
			}, function(data, status) {
				if (status == 'success') {
					//item 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelectDepth3(data.codes, sys);
					refresh();
				} else {
					//alert("ERROR!");
					return;
				}
			});
		}

		function getItemDropDownR01() {
			TITLE = "항목(전체)";

			var sys = $('#sysR01').val();
			var itemCode = "";

			if (sys == 'U') {
				itemCode = "22";
			} else if (sys == 'T') {
				itemCode = "52";
			} else if (sys == 'A') {
				itemCode = "37";
			}

			var dropDownSet = $('#itemR01');
			if (sys == 'all') {
				dropDownSet.attr("disabled", true);
				dropDownSet.emptySelect();
				refreshR01();
			} else {
				dropDownSet.attr("disabled", false);
				$.getJSON("<c:url value='/cmmn/getCode.do'/>", {
					code_id : itemCode
				}, function(data, status) {
					// 			console.log("data",data);
					if (status == 'success') {
						//item 객체에 SELECT 옵션내용 추가.
						dropDownSet.loadSelectDepth3(data.codes, sys);
						refreshR01();

						chartChange(1);
					} else {
						//alert("ERROR!");
						return;
					}
				});
			}
		}

		function getItemDropDownR03() {
			TITLE = "항목(전체)";

			var sys = $('#sysR03').val();
			var itemCode = "";

			if (sys == 'U') {
				itemCode = "22";
			} else if (sys == 'T') {
				itemCode = "52";
			} else if (sys == 'A') {
				itemCode = "37";
			}

			var dropDownSet = $('#itemR03');
			if (sys == 'all') {
				dropDownSet.attr("disabled", true);
				dropDownSet.emptySelect();
				refreshR03();
			} else {
				dropDownSet.attr("disabled", false);
				$.getJSON("<c:url value='/cmmn/getCode.do'/>", {
					code_id : itemCode
				}, function(data, status) {
					if (status == 'success') {
						//item 객체에 SELECT 옵션내용 추가.
						dropDownSet.loadSelectDepth3(data.codes, sys);
						refreshR03();

						chartChange(3);
					} else {
						//alert("ERROR!");
						return;
					}
				});
			}
		}

		function getItemDropDownR02() {
			TITLE = "항목(전체)";

			var sys = $('#sysR02').val();
			var itemCode = "";

			if (sys == 'U') {
				itemCode = "22";
			} else if (sys == 'T') {
				itemCode = "52";
			} else if (sys == 'A') {
				itemCode = "37";
			}

			var dropDownSet = $('#itemR02');
			if (sys == 'all') {
				dropDownSet.attr("disabled", true);
				dropDownSet.emptySelect();
				refreshR02();
			} else {
				dropDownSet.attr("disabled", false);
				$.getJSON("<c:url value='/cmmn/getCode.do'/>", {
					code_id : itemCode
				}, function(data, status) {
					if (status == 'success') {
						//item 객체에 SELECT 옵션내용 추가.
						dropDownSet.loadSelectDepth3(data.codes, sys);
						refreshR02();

						chartChange(2);
					} else {
						//alert("ERROR!");
						return;
					}
				});
			}
		}

		function getItemDropDownR04() {
			TITLE = "항목(전체)";

			var sys = $('#sysR04').val();
			var itemCode = "";

			if (sys == 'U') {
				itemCode = "22";
			} else if (sys == 'T') {
				itemCode = "52";
			} else if (sys == 'A') {
				itemCode = "37";
			}

			var dropDownSet = $('#itemR04');
			if (sys == 'all') {
				dropDownSet.attr("disabled", true);
				dropDownSet.emptySelect();
				refreshR04();
			} else {
				dropDownSet.attr("disabled", false);

				$.getJSON("<c:url value='/cmmn/getCode.do'/>", {
					code_id : itemCode
				}, function(data, status) {
					if (status == 'success') {
						//item 객체에 SELECT 옵션내용 추가.
						dropDownSet.loadSelectDepth3(data.codes, sys);
						refreshR04();

						chartChange(4);
					} else {
						//alert("ERROR!");
						return;
					}
				});
			}
		}

		//동적 SELECTBOX 구현을 위한 사용자 함수
		(function($) {

			//SELECT OPTION 삭제
			$.fn.emptySelect = function() {
				return this.each(function() {
					if (this.tagName == 'SELECT')
						this.options.length = 0;
				});
			};

			//SELECT OPTION 등록
			$.fn.loadSelectDepth3 = function(optionsDataArray, sys) {
				return this.emptySelect().each(
						function() {
							if (this.tagName == 'SELECT') {
								var selectElement = this;
								$.each(optionsDataArray, function(idx,
										optionData) {

									if (sys != "A")
										optionData.VALUE = optionData.VALUE
												+ "00";

									var option = new Option(optionData.CAPTION,
											optionData.VALUE);
									//var first = new Option(TITLE, 'all');
									if ($.browser.msie) {
										//if(idx == 0){selectElement.add(first);}

										selectElement.add(option);
									} else {
										//if(idx == 0){selectElement.add(first);}
										selectElement.add(option, null);
									}
								});

							}
						});
			};
		})(jQuery);

		function setFirst(id) {
			$("#" + id).text("0");
			$("#" + id).css("color", "black");
			$("#" + id).css("font-weight", "normal");
			$("#" + id).css("cursor", "default");
			$("#" + id).click(function() {
			});
		}

		function TotalMntMainTopTS() {

			$
					.ajax({
						type : "post",
						url : "<c:url value='/waterpolmnt/situationctl/getTotalMntMainTopTS.do'/>",
						dataType : "json",
						success : function(result) {
							var tot = result['totalData'].length;
							var date;
							var factCnt;
							var summaryitem;

							setFirst("normal1u");
							setFirst("interest1u");
							setFirst("caution1u");
							setFirst("alert1u");
							setFirst("over1u");
							setFirst("norecv1u");
							setFirst("normal1t");
							setFirst("interest1t");
							setFirst("caution1t");
							setFirst("alert1t");
							setFirst("norecv1t");
							setFirst("normal1a");
							setFirst("interest1a");
							setFirst("caution1a");
							setFirst("alert1a");
							setFirst("over1a");
							setFirst("norecv1a");

							setFirst("normal2u");
							setFirst("interest2u");
							setFirst("caution2u");
							setFirst("alert2u");
							setFirst("over2u");
							setFirst("norecv2u");
							setFirst("normal2t");
							setFirst("interest2t");
							setFirst("caution2t");
							setFirst("alert2t");
							setFirst("norecv2t");
							setFirst("normal2a");
							setFirst("interest2a");
							setFirst("caution2a");
							setFirst("alert2a");
							setFirst("over2a");
							setFirst("norecv2a");

							setFirst("normal3u");
							setFirst("interest3u");
							setFirst("caution3u");
							setFirst("alert3u");
							setFirst("over3u");
							setFirst("norecv3u");
							setFirst("normal3t");
							setFirst("interest3t");
							setFirst("caution3t");
							setFirst("alert3t");
							setFirst("norecv3t");
							setFirst("normal3a");
							setFirst("interest3a");
							setFirst("caution3a");
							setFirst("alert3a");
							setFirst("over3a");
							setFirst("norecv3a");

							setFirst("normal4u");
							setFirst("interest4u");
							setFirst("caution4u");
							setFirst("alert4u");
							setFirst("over4u");
							setFirst("norecv4u");
							setFirst("normal4t");
							setFirst("interest4t");
							setFirst("caution4t");
							setFirst("alert4t");
							setFirst("norecv4t");
							setFirst("normal4a");
							setFirst("interest4a");
							setFirst("caution4a");
							setFirst("alert4a");
							setFirst("over4a");
							setFirst("norecv4a");

							for (var i = 0; i < tot; i++) {

								var obj = result['totalData'][i];

								if (obj.min_time != '') {
									date = obj.min_time;
								}

								// 한강				
								if (obj.river_div == "R01") {
									if (obj.sys_kind == "U") {
										$("#normal1u").text(obj.normal);
										$("#interest1u").text(obj.interest);
										$("#caution1u").text(obj.caution);
										//						$("#alert1u").text(obj.alert);
										//						$("#over1u").text(obj.over);
										$("#alert1u").text("-");
										$("#over1u").text("-");
										$("#norecv1u").text(obj.norecv);
										if (obj.normal != '0') {
											$("#normal1u")
													.css("color", "GREEN");
											$("#normal1u").css("font-weight",
													"bold");
											$("#normal1u").css("cursor",
													"pointer");
											$("#normal1u").click(function() {
												summaryPopup('U', 'R01', '0');
											});
										}
										if (obj.interest != '0') {
											$("#interest1u").css("color",
													"BLUE");
											$("#interest1u").css("font-weight",
													"bold");
											$("#interest1u").css("cursor",
													"pointer");
											$("#interest1u").click(function() {
												summaryPopup('U', 'R01', '1');
											});
										}
										if (obj.caution != '0') {
											$("#caution1u").css("color",
													"#F0D010");
											$("#caution1u").css("font-weight",
													"bold");
											$("#caution1u").css("cursor",
													"pointer");
											$("#caution1u").click(function() {
												summaryPopup('U', 'R01', '2');
											});
										}
										if (obj.alert != '0') {
											$("#alert1u")
													.css("color", "ORANGE");
											$("#alert1u").css("font-weight",
													"bold");
											$("#alert1u").css("cursor",
													"pointer");
											$("#alert1u").click(function() {
												summaryPopup('U', 'R01', '3');
											});
										}
										if (obj.over != '0') {
											$("#over1u").css("color", "RED");
											$("#over1u").css("font-weight",
													"bold");
											$("#over1u").css("cursor",
													"pointer");
											$("#over1u").click(function() {
												summaryPopup('U', 'R01', '4');
											});
										}
										if (obj.norecv != '0') {
											$("#norecv1u").css("font-weight",
													"bold");
											$("#norecv1u").css("cursor",
													"pointer");
											$("#norecv1u").click(function() {
												norecvPopup('U', 'R01');
											});
										}
									} else if (obj.sys_kind == "T") {
										$("#normal1t").text(obj.normal);
										$("#interest1t").text(obj.interest);
										$("#caution1t").text(obj.caution);
										$("#alert1t").text(obj.alert);
										$("#norecv1t").text(obj.norecv);
										if (obj.normal != '0') {
											$("#normal1t")
													.css("color", "GREEN");
											$("#normal1t").css("font-weight",
													"bold");
											$("#normal1t").css("cursor",
													"pointer");
											$("#normal1t").click(function() {
												summaryPopup('T', 'R01', '0');
											});
										}
										if (obj.interest != '0') {
											$("#interest1t").css("color",
													"BLUE");
											$("#interest1t").css("font-weight",
													"bold");
											$("#interest1t").css("cursor",
													"pointer");
											$("#interest1t").click(function() {
												summaryPopup('T', 'R01', '1');
											});
										}
										if (obj.caution != '0') {
											$("#caution1t").css("color",
													"#F0D010");
											$("#caution1t").css("font-weight",
													"bold");
											$("#caution1t").css("cursor",
													"pointer");
											$("#caution1t").click(function() {
												summaryPopup('T', 'R01', '2');
											});
										}
										if (obj.alert != '0') {
											$("#alert1t")
													.css("color", "ORANGE");
											$("#alert1t").css("font-weight",
													"bold");
											$("#alert1t").css("cursor",
													"pointer");
											$("#alert1t").click(function() {
												summaryPopup('T', 'R01', '3');
											});
										}
										if (obj.norecv != '0') {
											$("#norecv1t").css("font-weight",
													"bold");
											$("#norecv1t").css("cursor",
													"pointer");
											$("#norecv1t").click(function() {
												norecvPopup('T', '01');
											});
										}
									} else if (obj.sys_kind == "A") {
										$("#normal1a").text(obj.normal);
										$("#interest1a").text(obj.interest);
										$("#caution1a").text(obj.caution);
										$("#alert1a").text(obj.alert);
										$("#over1a").text(obj.over);
										$("#norecv1a").text(obj.norecv);
										if (obj.normal != '0') {
											$("#normal1a")
													.css("color", "GREEN");
											$("#normal1a").css("font-weight",
													"bold");
											$("#normal1a").css("cursor",
													"pointer");
											$("#normal1a").click(function() {
												summaryPopup('A', 'R01', '0');
											});
										}
										if (obj.interest != '0') {
											$("#interest1a").css("color",
													"BLUE");
											$("#interest1a").css("font-weight",
													"bold");
											$("#interest1a").css("cursor",
													"pointer");
											$("#interest1a").click(function() {
												summaryPopup('A', 'R01', '1');
											});
										}
										if (obj.caution != '0') {
											$("#caution1a").css("color",
													"#F0D010");
											$("#caution1a").css("font-weight",
													"bold");
											$("#caution1a").css("cursor",
													"pointer");
											$("#caution1a").click(function() {
												summaryPopup('A', 'R01', '2');
											});
										}
										if (obj.alert != '0') {
											$("#alert1a")
													.css("color", "ORANGE");
											$("#alert1a").css("font-weight",
													"bold");
											$("#alert1a").css("cursor",
													"pointer");
											$("#alert1a").click(function() {
												summaryPopup('A', 'R01', '3');
											});
										}
										if (obj.over != '0') {
											$("#over1a").css("color", "RED");
											$("#over1a").css("font-weight",
													"bold");
											$("#over1a").css("cursor",
													"pointer");
											$("#over1a").click(function() {
												summaryPopup('A', 'R01', '4');
											});
										}
										if (obj.norecv != '0') {
											$("#norecv1a").css("font-weight",
													"bold");
											$("#norecv1a").css("cursor",
													"pointer");
											$("#norecv1a").click(function() {
												norecvPopup('A', 'R01');
											});
										}
									}
									//금강
								} else if (obj.river_div == "R03") {
									if (obj.sys_kind == "U") {
										$("#normal2u").text(obj.normal);
										$("#interest2u").text(obj.interest);
										$("#caution2u").text(obj.caution);
										//						$("#alert2u").text(obj.alert);
										//						$("#over2u").text(obj.over);
										$("#alert2u").text("-");
										$("#over2u").text("-");
										$("#norecv2u").text(obj.norecv);
										if (obj.normal != '0') {
											$("#normal2u")
													.css("color", "GREEN");
											$("#normal2u").css("font-weight",
													"bold");
											$("#normal2u").css("cursor",
													"pointer");
											$("#normal2u").click(function() {
												summaryPopup('U', 'R03', '0');
											});
										}
										if (obj.interest != '0') {
											$("#interest2u").css("color",
													"BLUE");
											$("#interest2u").css("font-weight",
													"bold");
											$("#interest2u").css("cursor",
													"pointer");
											$("#interest2u").click(function() {
												summaryPopup('U', 'R03', '1');
											});
										}
										if (obj.caution != '0') {
											$("#caution2u").css("color",
													"#F0D010");
											$("#caution2u").css("font-weight",
													"bold");
											$("#caution2u").css("cursor",
													"pointer");
											$("#caution2u").click(function() {
												summaryPopup('U', 'R03', '2');
											});
										}
										if (obj.alert != '0') {
											$("#alert2u")
													.css("color", "ORANGE");
											$("#alert2u").css("font-weight",
													"bold");
											$("#alert2u").css("cursor",
													"pointer");
											$("#alert2u").click(function() {
												summaryPopup('U', 'R03', '3');
											});
										}
										if (obj.over != '0') {
											$("#over2u").css("color", "RED");
											$("#over2u").css("font-weight",
													"bold");
											$("#over2u").css("cursor",
													"pointer");
											$("#over2u").click(function() {
												summaryPopup('U', 'R03', '4');
											});
										}
										if (obj.norecv != '0') {
											$("#norecv2u").css("font-weight",
													"bold");
											$("#norecv2u").css("cursor",
													"pointer");
											$("#norecv2u").click(function() {
												norecvPopup('U', 'R03');
											});
										}
									} else if (obj.sys_kind == "T") {
										$("#normal2t").text(obj.normal);
										$("#interest2t").text(obj.interest);
										$("#caution2t").text(obj.caution);
										$("#alert2t").text(obj.alert);
										$("#norecv2t").text(obj.norecv);
										if (obj.normal != '0') {
											$("#normal2t")
													.css("color", "GREEN");
											$("#normal2t").css("font-weight",
													"bold");
											$("#normal2t").css("cursor",
													"pointer");
											$("#normal2t").click(function() {
												summaryPopup('T', 'R03', '0');
											});
										}
										if (obj.interest != '0') {
											$("#interest2t").css("color",
													"BLUE");
											$("#interest2t").css("font-weight",
													"bold");
											$("#interest2t").css("cursor",
													"pointer");
											$("#interest2t").click(function() {
												summaryPopup('T', 'R03', '1');
											});
										}
										if (obj.caution != '0') {
											$("#caution2t").css("color",
													"#F0D010");
											$("#caution2t").css("font-weight",
													"bold");
											$("#caution2t").css("cursor",
													"pointer");
											$("#caution2t").click(function() {
												summaryPopup('T', 'R03', '2');
											});
										}
										if (obj.alert != '0') {
											$("#alert2t")
													.css("color", "ORANGE");
											$("#alert2t").css("font-weight",
													"bold");
											$("#alert2t").css("cursor",
													"pointer");
											$("#alert2t").click(function() {
												summaryPopup('T', 'R03', '3');
											});
										}
										if (obj.norecv != '0') {
											$("#norecv2t").css("font-weight",
													"bold");
											$("#norecv2t").css("cursor",
													"pointer");
											$("#norecv2t").click(function() {
												norecvPopup('T', 'R02');
											});
										}
									} else if (obj.sys_kind == "A") {
										$("#normal2a").text(obj.normal);
										$("#interest2a").text(obj.interest);
										$("#caution2a").text(obj.caution);
										$("#alert2a").text(obj.alert);
										$("#over2a").text(obj.over);
										$("#norecv2a").text(obj.norecv);
										if (obj.normal != '0') {
											$("#normal2a")
													.css("color", "GREEN");
											$("#normal2a").css("font-weight",
													"bold");
											$("#normal2a").css("cursor",
													"pointer");
											$("#normal2a").click(function() {
												summaryPopup('A', 'R03', '0');
											});
										}
										if (obj.interest != '0') {
											$("#interest2a").css("color",
													"BLUE");
											$("#interest2a").css("font-weight",
													"bold");
											$("#interest2a").css("cursor",
													"pointer");
											$("#interest2a").click(function() {
												summaryPopup('A', 'R03', '1');
											});
										}
										if (obj.caution != '0') {
											$("#caution2a").css("color",
													"#F0D010");
											$("#caution2a").css("font-weight",
													"bold");
											$("#caution2a").css("cursor",
													"pointer");
											$("#caution2a").click(function() {
												summaryPopup('A', 'R03', '2');
											});
										}
										if (obj.alert != '0') {
											$("#alert2a")
													.css("color", "ORANGE");
											$("#alert2a").css("font-weight",
													"bold");
											$("#alert2a").css("cursor",
													"pointer");
											$("#alert2a").click(function() {
												summaryPopup('A', 'R03', '3');
											});
										}
										if (obj.over != '0') {
											$("#over2a").css("color", "RED");
											$("#over2a").css("font-weight",
													"bold");
											$("#over2a").css("cursor",
													"pointer");
											$("#over2a").click(function() {
												summaryPopup('A', 'R03', '4');
											});
										}
										if (obj.norecv != '0') {
											$("#norecv2a").css("font-weight",
													"bold");
											$("#norecv2a").css("cursor",
													"pointer");
											$("#norecv2a").click(function() {
												norecvPopup('A', 'R03');
											});
										}
									}
									//낙동강
								} else if (obj.river_div == "R02") {
									if (obj.sys_kind == "U") {
										$("#normal3u").text(obj.normal);
										$("#interest3u").text(obj.interest);
										$("#caution3u").text(obj.caution);
										//						$("#alert3u").text(obj.alert);
										//						$("#over3u").text(obj.over);
										$("#alert3u").text("-");
										$("#over3u").text("-");
										$("#norecv3u").text(obj.norecv);
										if (obj.normal != '0') {
											$("#normal3u")
													.css("color", "GREEN");
											$("#normal3u").css("font-weight",
													"bold");
											$("#normal3u").css("cursor",
													"pointer");
											$("#normal3u").click(function() {
												summaryPopup('U', 'R02', '0');
											});
										}
										if (obj.interest != '0') {
											$("#interest3u").css("color",
													"BLUE");
											$("#interest3u").css("font-weight",
													"bold");
											$("#interest3u").css("cursor",
													"pointer");
											$("#interest3u").click(function() {
												summaryPopup('U', 'R02', '1');
											});
										}
										if (obj.caution != '0') {
											$("#caution3u").css("color",
													"#F0D010");
											$("#caution3u").css("font-weight",
													"bold");
											$("#caution3u").css("cursor",
													"pointer");
											$("#caution3u").click(function() {
												summaryPopup('U', 'R02', '2');
											});
										}
										if (obj.alert != '0') {
											$("#alert3u")
													.css("color", "ORANGE");
											$("#alert3u").css("font-weight",
													"bold");
											$("#alert3u").css("cursor",
													"pointer");
											$("#alert3u").click(function() {
												summaryPopup('U', 'R02', '3');
											});
										}
										if (obj.over != '0') {
											$("#over3u").css("color", "RED");
											$("#over3u").css("font-weight",
													"bold");
											$("#over3u").css("cursor",
													"pointer");
											$("#over3u").click(function() {
												summaryPopup('U', 'R02', '4');
											});
										}
										if (obj.norecv != '0') {
											$("#norecv3u").css("font-weight",
													"bold");
											$("#norecv3u").css("cursor",
													"pointer");
											$("#norecv3u").click(function() {
												norecvPopup('U', 'R02');
											});
										}
									} else if (obj.sys_kind == "T") {
										$("#normal3t").text(obj.normal);
										$("#alert3t").text(obj.alert);
										$("#interest3t").text(obj.interest);
										$("#caution3t").text(obj.caution);
										$("#norecv3t").text(obj.norecv);
										if (obj.normal != '0') {
											$("#normal3t")
													.css("color", "GREEN");
											$("#normal3t").css("font-weight",
													"bold");
											$("#normal3t").css("cursor",
													"pointer");
											$("#normal3t").click(function() {
												summaryPopup('T', 'R03', '0');
											});
										}
										if (obj.interest != '0') {
											$("#interest3t").css("color",
													"BLUE");
											$("#interest3t").css("font-weight",
													"bold");
											$("#interest3t").css("cursor",
													"pointer");
											$("#interest3t").click(function() {
												summaryPopup('T', 'R02', '1');
											});
										}
										if (obj.caution != '0') {
											$("#caution3t").css("color",
													"#F0D010");
											$("#caution3t").css("font-weight",
													"bold");
											$("#caution3t").css("cursor",
													"pointer");
											$("#caution3t").click(function() {
												summaryPopup('T', 'R02', '2');
											});
										}
										if (obj.alert != '0') {
											$("#alert3t")
													.css("color", "ORANGE");
											$("#alert3t").css("font-weight",
													"bold");
											$("#alert3t").css("cursor",
													"pointer");
											$("#alert3t").click(function() {
												summaryPopup('T', 'R02', '3');
											});
										}
										if (obj.norecv != '0') {
											$("#norecv3t").css("font-weight",
													"bold");
											$("#norecv3t").css("cursor",
													"pointer");
											$("#norecv3t").click(function() {
												norecvPopup('T', 'R03');
											});
										}
									} else if (obj.sys_kind == "A") {
										$("#normal3a").text(obj.normal);
										$("#interest3a").text(obj.interest);
										$("#caution3a").text(obj.caution);
										$("#alert3a").text(obj.alert);
										$("#over3a").text(obj.over);
										$("#norecv3a").text(obj.norecv);
										if (obj.normal != '0') {
											$("#normal3a")
													.css("color", "GREEN");
											$("#normal3a").css("font-weight",
													"bold");
											$("#normal3a").css("cursor",
													"pointer");
											$("#normal3a").click(function() {
												summaryPopup('A', 'R02', '0');
											});
										}
										if (obj.interest != '0') {
											$("#interest3a").css("color",
													"BLUE");
											$("#interest3a").css("font-weight",
													"bold");
											$("#interest3a").css("cursor",
													"pointer");
											$("#interest3a").click(function() {
												summaryPopup('A', 'R02', '1');
											});
										}
										if (obj.caution != '0') {
											$("#caution3a").css("color",
													"#F0D010");
											$("#caution3a").css("font-weight",
													"bold");
											$("#caution3a").css("cursor",
													"pointer");
											$("#caution3a").click(function() {
												summaryPopup('A', 'R02', '2');
											});
										}
										if (obj.alert != '0') {
											$("#alert3a")
													.css("color", "ORANGE");
											$("#alert3a").css("font-weight",
													"bold");
											$("#alert3a").css("cursor",
													"pointer");
											$("#alert3a").click(function() {
												summaryPopup('A', 'R02', '3');
											});
										}
										if (obj.over != '0') {
											$("#over3a").css("color", "RED");
											$("#over3a").css("font-weight",
													"bold");
											$("#over3a").css("cursor",
													"pointer");
											$("#over3a").click(function() {
												summaryPopup('A', 'R02', '4');
											});
										}
										if (obj.norecv != '0') {
											$("#norecv3a").css("font-weight",
													"bold");
											$("#norecv3a").css("cursor",
													"pointer");
											$("#norecv3a").click(function() {
												norecvPopup('A', 'R02');
											});
										}
									}
									//영산강
								} else if (obj.river_div == "R04") {
									if (obj.sys_kind == "U") {
										$("#normal4u").text(obj.normal);
										$("#interest4u").text(obj.interest);
										$("#caution4u").text(obj.caution);
										//						$("#alert4u").text(obj.alert);
										//						$("#over4u").text(obj.over);
										$("#alert4u").text("-");
										$("#over4u").text("-");
										$("#norecv4u").text(obj.norecv);
										if (obj.normal != '0') {
											$("#normal4u")
													.css("color", "GREEN");
											$("#normal4u").css("font-weight",
													"bold");
											$("#normal4u").css("cursor",
													"pointer");
											$("#normal4u").click(function() {
												summaryPopup('U', 'R04', '0');
											});
										}
										if (obj.interest != '0') {
											$("#interest4u").css("color",
													"BLUE");
											$("#interest4u").css("font-weight",
													"bold");
											$("#interest4u").css("cursor",
													"pointer");
											$("#interest4u").click(function() {
												summaryPopup('U', 'R04', '1');
											});
										}
										if (obj.caution != '0') {
											$("#caution4u").css("color",
													"#F0D010");
											$("#caution4u").css("font-weight",
													"bold");
											$("#caution4u").css("cursor",
													"pointer");
											$("#caution4u").click(function() {
												summaryPopup('U', 'R04', '2');
											});
										}
										if (obj.alert != '0') {
											$("#alert4u")
													.css("color", "ORANGE");
											$("#alert4u").css("font-weight",
													"bold");
											$("#alert4u").css("cursor",
													"pointer");
											$("#alert4u").click(function() {
												summaryPopup('U', 'R04', '3');
											});
										}
										if (obj.over != '0') {
											$("#over4u").css("color", "RED");
											$("#over4u").css("font-weight",
													"bold");
											$("#over4u").css("cursor",
													"pointer");
											$("#over4u").click(function() {
												summaryPopup('U', 'R04', '4');
											});
										}
										if (obj.norecv != '0') {
											$("#norecv4u").css("font-weight",
													"bold");
											$("#norecv4u").css("cursor",
													"pointer");
											$("#norecv4u").click(function() {
												norecvPopup('U', 'R04');
											});
										}
									} else if (obj.sys_kind == "T") {
										$("#normal4t").text(obj.normal);
										$("#interest4t").text(obj.interest);
										$("#caution4t").text(obj.caution);
										$("#alert4t").text(obj.alert);
										$("#norecv4t").text(obj.norecv);
										if (obj.normal != '0') {
											$("#normal4t")
													.css("color", "GREEN");
											$("#normal4t").css("font-weight",
													"bold");
											$("#normal4t").css("cursor",
													"pointer");
											$("#normal4t").click(function() {
												summaryPopup('T', 'R04', '0');
											});
										}
										if (obj.interest != '0') {
											$("#interest4t").css("color",
													"BLUE");
											$("#interest4t").css("font-weight",
													"bold");
											$("#interest4t").css("cursor",
													"pointer");
											$("#interest4t").click(function() {
												summaryPopup('T', 'R04', '1');
											});
										}
										if (obj.caution != '0') {
											$("#caution4t").css("color",
													"#F0D010");
											$("#caution4t").css("font-weight",
													"bold");
											$("#caution4t").css("cursor",
													"pointer");
											$("#caution4t").click(function() {
												summaryPopup('T', 'R04', '2');
											});
										}
										if (obj.alert != '0') {
											$("#alert4t")
													.css("color", "ORANGE");
											$("#alert4t").css("font-weight",
													"bold");
											$("#alert4t").css("cursor",
													"pointer");
											$("#alert4t").click(function() {
												summaryPopup('T', 'R04', '3');
											});
										}
										if (obj.norecv != '0') {
											$("#norecv4t").css("font-weight",
													"bold");
											$("#norecv4t").css("cursor",
													"pointer");
											$("#norecv4t").click(function() {
												norecvPopup('T', '04');
											});
										}
									} else if (obj.sys_kind == "A") {
										$("#normal4a").text(obj.normal);
										$("#interest4a").text(obj.interest);
										$("#caution4a").text(obj.caution);
										$("#alert4a").text(obj.alert);
										$("#over4a").text(obj.over);
										$("#norecv4a").text(obj.norecv);
										if (obj.normal != '0') {
											$("#normal4a")
													.css("color", "GREEN");
											$("#normal4a").css("font-weight",
													"bold");
											$("#normal4a").css("cursor",
													"pointer");
											$("#normal4a").click(function() {
												summaryPopup('A', 'R04', '0');
											});
										}
										if (obj.interest != '0') {
											$("#interest4a").css("color",
													"BLUE");
											$("#interest4a").css("font-weight",
													"bold");
											$("#interest4a").css("cursor",
													"pointer");
											$("#interest4a").click(function() {
												summaryPopup('A', 'R04', '1');
											});
										}
										if (obj.caution != '0') {
											$("#caution4a").css("color",
													"#F0D010");
											$("#caution4a").css("font-weight",
													"bold");
											$("#caution4a").css("cursor",
													"pointer");
											$("#caution4a").click(function() {
												summaryPopup('A', 'R04', '2');
											});
										}
										if (obj.alert != '0') {
											$("#alert4a")
													.css("color", "ORANGE");
											$("#alert4a").css("font-weight",
													"bold");
											$("#alert4a").css("cursor",
													"pointer");
											$("#alert4a").click(function() {
												summaryPopup('A', 'R04', '3');
											});
										}
										if (obj.over != '0') {
											$("#over4a").css("color", "RED");
											$("#over4a").css("font-weight",
													"bold");
											$("#over4a").css("cursor",
													"pointer");
											$("#over4a").click(function() {
												summaryPopup('A', 'R04', '4');
											});
										}
										if (obj.norecv != '0') {
											$("#norecv4a").css("font-weight",
													"bold");
											$("#norecv4a").css("cursor",
													"pointer");
											$("#norecv4a").click(function() {
												norecvPopup('A', 'R04');
											});
										}
									}
								}
							}

							$("#sum1u").text(
									parseInt($("#normal1u").text())
											+ parseInt($("#interest1u").text())
											+ parseInt($("#caution1u").text())
											//+parseInt($("#alert1u").text())
											//+parseInt($("#over1u").text())
											+ parseInt($("#norecv1u").text()));
							$("#sum1t").text(
									parseInt($("#normal1t").text())
											+ parseInt($("#interest1t").text())
											+ parseInt($("#caution1t").text())
											+ parseInt($("#alert1t").text())
											+ parseInt($("#norecv1t").text()));
							$("#sum1a").text(
									parseInt($("#normal1a").text())
											+ parseInt($("#interest1a").text())
											+ parseInt($("#caution1a").text())
											+ parseInt($("#alert1a").text())
											+ parseInt($("#over1a").text())
											+ parseInt($("#norecv1a").text()));
							$("#sum2u").text(
									parseInt($("#normal2u").text())
											+ parseInt($("#interest2u").text())
											+ parseInt($("#caution2u").text())
											//+parseInt($("#alert2u").text())
											//+parseInt($("#over2u").text())
											+ parseInt($("#norecv2u").text()));
							$("#sum2t").text(
									parseInt($("#normal2t").text())
											+ parseInt($("#interest2t").text())
											+ parseInt($("#caution2t").text())
											+ parseInt($("#alert2t").text())
											+ parseInt($("#norecv2t").text()));
							$("#sum2a").text(
									parseInt($("#normal2a").text())
											+ parseInt($("#interest2a").text())
											+ parseInt($("#caution2a").text())
											+ parseInt($("#alert2a").text())
											+ parseInt($("#over2a").text())
											+ parseInt($("#norecv2a").text()));
							$("#sum3u").text(
									parseInt($("#normal3u").text())
											+ parseInt($("#interest3u").text())
											+ parseInt($("#caution3u").text())
											//+parseInt($("#alert3u").text())
											//+parseInt($("#over3u").text())
											+ parseInt($("#norecv3u").text()));
							$("#sum3t").text(
									parseInt($("#normal3t").text())
											+ parseInt($("#interest3t").text())
											+ parseInt($("#caution3t").text())
											+ parseInt($("#alert3t").text())
											+ parseInt($("#norecv3t").text()));
							$("#sum3a").text(
									parseInt($("#normal3a").text())
											+ parseInt($("#interest3a").text())
											+ parseInt($("#caution3a").text())
											+ parseInt($("#alert3a").text())
											+ parseInt($("#over3a").text())
											+ parseInt($("#norecv3a").text()));
							$("#sum4u").text(
									parseInt($("#normal4u").text())
											+ parseInt($("#interest4u").text())
											+ parseInt($("#caution4u").text())
											//+parseInt($("#alert4u").text())
											//+parseInt($("#over4u").text())
											+ parseInt($("#norecv4u").text()));
							$("#sum4t").text(
									parseInt($("#normal4t").text())
											+ parseInt($("#interest4t").text())
											+ parseInt($("#caution4t").text())
											+ parseInt($("#alert4t").text())
											+ parseInt($("#norecv4t").text()));
							$("#sum4a").text(
									parseInt($("#normal4a").text())
											+ parseInt($("#interest4a").text())
											+ parseInt($("#caution4a").text())
											+ parseInt($("#alert4a").text())
											+ parseInt($("#over4a").text())
											+ parseInt($("#norecv4a").text()));

							if ($("#sum1u").text() != "0") {
								$("#sum1u").css("cursor", "pointer");
								$("#sum1u").click(function() {
									summaryPopup('U', 'R01', 'all');
								});
							}
							if ($("#sum1t").text() != "0") {
								$("#sum1t").css("cursor", "pointer");
								$("#sum1t").click(function() {
									summaryPopup('T', 'R01', 'all');
								});
							}
							if ($("#sum1a").text() != "0") {
								$("#sum1a").css("cursor", "pointer");
								$("#sum1a").click(function() {
									summaryPopup('A', 'R01', 'all');
								});
							}

							if ($("#sum2u").text() != "0") {
								$("#sum2u").css("cursor", "pointer");
								$("#sum2u").click(function() {
									summaryPopup('U', 'R03', 'all');
								});
							}
							if ($("#sum2t").text() != "0") {
								$("#sum2t").css("cursor", "pointer");
								$("#sum2t").click(function() {
									summaryPopup('T', 'R03', 'all');
								});
							}
							if ($("#sum2a").text() != "0") {
								$("#sum2a").css("cursor", "pointer");
								$("#sum2a").click(function() {
									summaryPopup('A', 'R03', 'all');
								});
							}

							if ($("#sum3u").text() != "0") {
								$("#sum3u").css("cursor", "pointer");
								$("#sum3u").click(function() {
									summaryPopup('U', 'R02', 'all');
								});
							}
							if ($("#sum3t").text() != "0") {
								$("#sum3t").css("cursor", "pointer");
								$("#sum3t").click(function() {
									summaryPopup('T', 'R02', 'all');
								});
							}
							if ($("#sum3a").text() != "0") {
								$("#sum3a").css("cursor", "pointer");
								$("#sum3a").click(function() {
									summaryPopup('A', 'R02', 'all');
								});
							}

							if ($("#sum4u").text() != "0") {
								$("#sum4u").css("cursor", "pointer");
								$("#sum4u").click(function() {
									summaryPopup('U', 'R04', 'all');
								});
							}
							if ($("#sum4t").text() != "0") {
								$("#sum4t").css("cursor", "pointer");
								$("#sum4t").click(function() {
									summaryPopup('T', 'R04', 'all');
								});
							}
							if ($("#sum4a").text() != "0") {
								$("#sum4a").css("cursor", "pointer");
								$("#sum4a").click(function() {
									summaryPopup('A', 'R04', 'all');
								});
							}

						},
						error : function(result) {
							var today = new Date();

							var item = "<strong>[ 서버 접속 실패 : "
									+ today.getFullYear() + "-"
									+ today.getMonth() + "-" + today.getDate()
									+ " " + today.getHours() + ":"
									+ today.getMinutes() + " ]</strong>";
							$("#currDate").html(item);
						}
					});
			setTimeout(TotalMntMainTopTS, (1000 * 60 * 10));
		}

		function summaryPopup(sys, river, step) {
			var sw = screen.width;
			var sh = screen.height;
			var winHeight = 510;
			var winWidth = 800;

			if (sys == "A")
				winHeight = 480;

			var winLeftPost = (sw - winWidth) / 2;
			var winTopPost = (sh - winHeight) / 2;

			window
					.open(
							"<c:url value='/waterpolmnt/situationctl/goTotalMntSummary.do?'/>sys="
									+ sys + "&river=" + river + "&step=" + step,
							'TotamMntSummary',
							'width='
									+ winWidth
									+ ',height='
									+ winHeight
									+ ',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='
									+ winLeftPost + ',top=' + winTopPost);
		}

		function norecvPopup(sys, river) {
			var sw = screen.width;
			var sh = screen.height;
			var winHeight = 500;
			var winWidth = 800;
			var winLeftPost = (sw - winWidth) / 2;
			var winTopPost = (sh - winHeight) / 2;

			window
					.open(
							"<c:url value='/waterpolmnt/situationctl/goTotalMntNorecv.do?'/>sys="
									+ sys + "&river=" + river,
							'TotamMntNorecv',
							'width='
									+ winWidth
									+ ',height='
									+ winHeight
									+ ',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='
									+ winLeftPost + ',top=' + winTopPost);
		}

		function reloadData() {

			if (!first) {
				refreshR01();
				refreshR03();
				refreshR02();
				refreshR04();
				chartChange(1);
				chartChange(2);
				chartChange(3);
				chartChange(4);
			}

			first = false;

			setTimeout(reloadData, (1000 * 60 * 10));
		}
		//지도오른쪽에 표
		function refresh() {
			var sys = $('#sys').val();
			var item = $('#item').val();
			var river_div = $("#river_div").val();

			if (item == "TUR") {
				$("#itemUnit").html("(NTU)");
			} else if (item == "CON") {
				$("#itemUnit").html("(mS/cm)");
			} else if (item == "DOW") {
				$("#itemUnit").html("(mg/L)");
			} else if (item == "TMP") {
				$("#itemUnit").html("(℃)");
			} else if (item == "PHY") {
				$("#itemUnit").html("(pH)");
			}

			$
					.ajax({
						type : "post",
						url : "<c:url value='/waterpolmnt/situationctl/getTotalMntMain.do'/>",
						data : {
							sys : sys,
							item : item,
							river_div : river_div
						},
						dataType : "json",
						success : function(result) {
							var tot = result['refreshData'].length;
							var trClass;

							$("#dataList").html("");
							if (tot <= 0) {
								$("#dataList")
										.html(
												"<tr><td colspan='6'><span>조회 결과가 없습니다</span></td></tr>");

								// for(var i=0; i<1000; i++){
								//		$("#dataList").append("<tr code=1234 branchNo='1'><td colspan='4'>"+i+"조회 결과가 없습니다</td></tr>");
								// }	
							} else {
								for (var i = 0; i < tot; i++) {
									var obj = result['refreshData'][i];
									var item;

									if (i == 0) {
										item = "<strong>[ 최종수신일자: "
												+ obj.min_date + " ]</strong>";
										$("#currDate").html(item);
									}

									//TR 색 변경
									if (i % 2 != 0) {
										trClass = "add";
									} else {
										trClass = "";
									}
									var branchName = obj.branch_name;

									item = "<tr class='"
											+ trClass
											+ "' code='"
											+ obj.fact_code
											+ "' branchNo='"
											+ obj.branch_no
											+ "' style='cursor:pointer;'"
											+ "onclick=\"javascript:mapMoveBranch('"
											+ obj.latitude
											+ "', '"
											+ obj.longitude
											+ "')\">"
											+ "<td>"
											+ obj.river_name
											+ "</td>"
											+ "<td>"
											+ obj.fact_name
											+ "</td>"
											+ "<td>"
											+ branchName
											+ "</td>"
											+ "<td id='or"+i+"' class='num'><span>"
											+ ((obj.min_vl == "") ? "-"
													: obj.min_vl)
											+ "</span></td>" + "<td>"
											+ obj.sys_kind + "</td>"
											+ "<td id='rem"+i+"'>"
											+ obj.min_time + "</td>" + "</tr>";

									$("#dataList").append(item);

									setMinOr_Color(obj.min_or, $("#or" + i));
								}
							}
						},
						error : function(result) {
							$("#dataList").html(
									"<tr><td colspan='6'>서버 접속 실패!</td></tr>");
						}
					});
		}

		//한강
		function refreshR01() {
			var sys = $('#sysR01').val();
			var item = $('#itemR01').val();

			setUnit(item, $("#itemUnitR01"));

			$
					.ajax({
						type : "post",
						url : "<c:url value='/waterpolmnt/situationctl/getTotalMntMainR01.do'/>",
						data : {
							sys : sys,
							item : item
						},
						dataType : "json",
						success : function(result) {
							// 			console.log("getTotalMntMainR01",result);
							var tot = result['refreshData'].length;
							var trClass;

							$("#dataListR01").html("");
							if (tot <= 0) {
								$("#dataListR01")
										.html(
												"<tr><td colspan='4'><span>조회 결과가 없습니다</span></td></tr>");

								// for(var i=0; i<1000; i++){
								//		$("#dataList").append("<tr code=1234 branchNo='1'><td colspan='4'>"+i+"조회 결과가 없습니다</td></tr>");
								// }	
							} else {
								
								if (sys != "T")
								{
									var colw = 
										"<col width='50px' />"
										+ "<col width='70px' />"
										+ "<col width='60px' />"
										+ "<col />";
									
									$("#col1R01").html(colw);
									$("#col2R01").html(colw);
								}
								else
								{
									var colw = 
									"<col width='100px' />"
									+ "<col width='40px' />"
									+ "<col width='40px' />"
									+ "<col />";
									
									$("#col1R01").html(colw);
									$("#col2R01").html(colw);
								}
								for (var i = 0; i < tot; i++) {
									var obj = result['refreshData'][i];
									var item;

									if (i == 0) {
										item = "<strong>[ 최종수신일자: "
												+ obj.min_date + " ]</strong>";
										$("#currDate").html(item);
									}

									//TR 색 변경
									if (i % 2 != 0) {
										trClass = "add";
									} else {
										trClass = "";
									}
									var branchName = obj.branch_name;
									var factName = "";

									if (sys != "T")
										factName = obj.reg_name;
									else
										factName = obj.fact_name;

									item = "<tr class='"
											+ trClass
											+ "' code='"
											+ obj.fact_code
											+ "' branchNo='"
											+ obj.branch_no
											+ "' style='cursor:pointer;'"
											+ "onclick=\"javascript:detailPopup('"
											+ obj.fact_code
											+ "', '"
											+ obj.branch_no
											+ "', '"
											+ obj.sys_kind
											+ "', '"
											+ branchName
											+ "', 'R01')\">"
											+ "<td>"
											+ factName
											+ "</td>"
											+ "<td>"
											+ branchName
											+ "</td>"
											+ "<td id='orR01"+i+"' class='num'><span>"
											+ ((obj.min_vl == "") ? "-"
													: obj.min_vl)
											+ "</span></td>"
											+ "<td id='rem"+i+"'>"
											+ obj.min_time + "</td>" + "</tr>";

									$("#dataListR01").append(item);

									setMinOr_Color(obj.min_or, $("#orR01" + i));
								}
							}
						},
						error : function(result) {
							$("#dataListR01").html(
									"<tr><td colspan='4'>서버 접속 실패!</td></tr>");
						}
					});
		}

		// 금강
		function refreshR03() {
			var sys = $('#sysR03').val();
			var item = $('#itemR03').val();

			setUnit(item, $("#itemUnitR03"));

			$
					.ajax({
						type : "post",
						url : "<c:url value='/waterpolmnt/situationctl/getTotalMntMainR03.do'/>",
						data : {
							sys : sys,
							item : item
						},
						dataType : "json",
						success : function(result) {
							var tot = result['refreshData'].length;
							var trClass;

							$("#dataListR03").html("");

							if (tot <= 0) {
								$("#dataListR03")
										.html(
												"<tr><td colspan='4'><span>조회 결과가 없습니다</span></td></tr>");

								// for(var i=0; i<1000; i++){
								//		$("#dataList").append("<tr code=1234 branchNo='1'><td colspan='4'>"+i+"조회 결과가 없습니다</td></tr>");
								// }	
							} else {
								if (sys != "T")
								{
									var colw = 
										"<col width='50px' />"
										+ "<col width='70px' />"
										+ "<col width='60px' />"
										+ "<col />";
									
									$("#col1R03").html(colw);
									$("#col2R03").html(colw);
								}
								else
								{
									var colw = 
									"<col width='100px' />"
									+ "<col width='40px' />"
									+ "<col width='40px' />"
									+ "<col />";
									
									$("#col1R03").html(colw);
									$("#col2R03").html(colw);
								}
								for (var i = 0; i < tot; i++) {
									var obj = result['refreshData'][i];
									var item;

									if (i == 0) {
										item = "<strong>[ 최종수신일자: "
												+ obj.min_date + " ]</strong>";
										$("#currDate").html(item);
									}

									//TR 색 변경
									if (i % 2 != 0) {
										trClass = "add";
									} else {
										trClass = "";
									}
									var branchName = obj.branch_name;

									var factName = "";

									if (sys != "T")
										factName = obj.reg_name;
									else
										factName = obj.fact_name;

									item = "<tr class='"
											+ trClass
											+ "' code='"
											+ obj.fact_code
											+ "' branchNo='"
											+ obj.branch_no
											+ "' style='cursor:pointer;'"
											+ "onclick=\"javascript:detailPopup('"
											+ obj.fact_code
											+ "', '"
											+ obj.branch_no
											+ "', '"
											+ obj.sys_kind
											+ "', '"
											+ branchName
											+ "', 'R03')\">"
											+ "<td>"
											+ factName
											+ "</td>"
											+ "<td>"
											+ branchName
											+ "</td>"
											+ "<td id='orR03"+i+"' class='num'><span>"
											+ ((obj.min_vl == "") ? "-"
													: obj.min_vl)
											+ "</span></td>"
											+ "<td id='rem"+i+"'>"
											+ obj.min_time + "</td>" + "</tr>";

									$("#dataListR03").append(item);

									setMinOr_Color(obj.min_or, $("#orR03" + i));
								}
							}
						},
						error : function(result) {
							$("#dataListR03").html(
									"<tr><td colspan='4'>서버 접속 실패!</td></tr>");
						}
					});
		}

		// 낙동강
		function refreshR02() {
			var sys = $('#sysR02').val();
			var item = $('#itemR02').val();

			setUnit(item, $("#itemUnitR02"));

			$
					.ajax({
						type : "post",
						url : "<c:url value='/waterpolmnt/situationctl/getTotalMntMainR02.do'/>",
						data : {
							sys : sys,
							item : item
						},
						dataType : "json",
						success : function(result) {
							var tot = result['refreshData'].length;
							var trClass;

							$("#dataListR02").html("");

							if (tot <= 0) {
								$("#dataListR02")
										.html(
												"<tr><td colspan='4'><span>조회 결과가 없습니다</span></td></tr>");

								//for(var i=0; i<1000; i++){
								//		$("#dataList").append("<tr code=1234 branchNo='1'><td colspan='4'>"+i+"조회 결과가 없습니다</td></tr>");
								//}	
							} else {
								if (sys != "T")
								{
									var colw = 
										"<col width='50px' />"
										+ "<col width='70px' />"
										+ "<col width='60px' />"
										+ "<col />";
									
									$("#col1R02").html(colw);
									$("#col2R02").html(colw);
								}
								else
								{
									var colw = 
									"<col width='100px' />"
									+ "<col width='40px' />"
									+ "<col width='40px' />"
									+ "<col />";
									
									$("#col1R02").html(colw);
									$("#col2R02").html(colw);
								}
								for (var i = 0; i < tot; i++) {
									var obj = result['refreshData'][i];
									var item;

									if (i == 0) {
										item = "<strong>[ 최종수신일자: "
												+ obj.min_date + " ]</strong>";
										$("#currDate").html(item);
									}

									//TR 색 변경				
									if (i % 2 != 0) {
										trClass = "add";
									} else {
										trClass = "";
									}
									var branchName = obj.branch_name;

									var factName = "";

									if (sys != "T")
										factName = obj.reg_name;
									else
										factName = obj.fact_name;

									item = "<tr class='"
											+ trClass
											+ "' code='"
											+ obj.fact_code
											+ "' branchNo='"
											+ obj.branch_no
											+ "' style='cursor:pointer;'"
											+ "onclick=\"javascript:detailPopup('"
											+ obj.fact_code
											+ "', '"
											+ obj.branch_no
											+ "', '"
											+ obj.sys_kind
											+ "', '"
											+ branchName
											+ "', 'R02')\">"
											+ "<td>"
											+ factName
											+ "</td>"
											+ "<td>"
											+ branchName
											+ "</td>"
											+ "<td id='orR02"+i+"' class='num'><span>"
											+ ((obj.min_vl == "") ? "-"
													: obj.min_vl)
											+ "</span></td>"
											+ "<td id='rem"+i+"'>"
											+ obj.min_time + "</td>" + "</tr>";

									$("#dataListR02").append(item);

									setMinOr_Color(obj.min_or, $("#orR02" + i));
								}
							}
						},
						error : function(result) {
							$("#dataListR02").html(
									"<tr><td colspan='4'>서버 접속 실패!</td></tr>");
						}
					});
		}

		// 영산강
		function refreshR04() {
			var sys = $('#sysR04').val();
			var item = $('#itemR04').val();

			setUnit(item, $("#itemUnitR04"));

			$
					.ajax({
						type : "post",
						url : "<c:url value='/waterpolmnt/situationctl/getTotalMntMainR04.do'/>",
						data : {
							sys : sys,
							item : item
						},
						dataType : "json",
						success : function(result) {
							var tot = result['refreshData'].length;
							var trClass;

							$("#dataListR04").html("");

							if (tot <= 0) {
								$("#dataListR04")
										.html(
												"<tr><td colspan='4'><span>조회 결과가 없습니다</span></td></tr>");

								//for(var i=0; i<100; i++){
								//		$("#dataListR04").append("<tr code=1234 branchNo='1'><td colspan='4'>"+i+"조회 결과가 없습니다</td></tr>");
								//}	

							} else {
								
								if (sys != "T")
								{
									var colw = 
										"<col width='50px' />"
										+ "<col width='70px' />"
										+ "<col width='60px' />"
										+ "<col />";
									
									$("#col1R04").html(colw);
									$("#col2R04").html(colw);
								}
								else
								{
									var colw = 
									"<col width='100px' />"
									+ "<col width='40px' />"
									+ "<col width='40px' />"
									+ "<col />";
									
									$("#col1R04").html(colw);
									$("#col2R04").html(colw);
								}
								
								for (var i = 0; i < tot; i++) {
									var obj = result['refreshData'][i];
									var item;

									if (i == 0) {
										item = "<strong>[ 최종수신일자: "
												+ obj.min_date + " ]</strong>";
										$("#currDate").html(item);
									}

									var branchName = obj.branch_name;

									var factName = "";

									if (sys != "T")
									{
									
										factName = obj.reg_name;
										
									}
									else
									{
										
										
										factName = obj.fact_name;
										
										
									}
										

									item = "<tr code='"
											+ obj.fact_code
											+ "' branchNo='"
											+ obj.branch_no
											+ "' style='cursor:pointer;'"
											+ "onclick=\"javascript:detailPopup('"
											+ obj.fact_code
											+ "', '"
											+ obj.branch_no
											+ "', '"
											+ obj.sys_kind
											+ "', '"
											+ branchName
											+ "', 'R04')\">"
											+ "<td>"
											+ factName
											+ "</td>"
											+ "<td>"
											+ branchName
											+ "</td>"
											+ "<td id='orR04"+i+"' class='num'><span>"
											+ ((obj.min_vl == "") ? "-"
													: obj.min_vl)
											+ "</span></td>"
											+ "<td id='rem"+i+"'>"
											+ obj.min_time + "</td>" + "</tr>";

									$("#dataListR04").append(item);

									$("#dataListR04 tr:odd").addClass("add");

									setMinOr_Color(obj.min_or, $("#orR04" + i));
								}
							}
						},
						error : function(result) {
							$("#dataListR04").html(
									"<tr><td colspan='4'>서버 접속 실패!</td></tr>");
						}
					});
		}

		function setUnit(item, obj) {
			switch (item) {
			case "TUR00":
				obj.html("(NTU)");
				break;
			case "DOW00":
			case "DOW01":
				obj.html("(mg/L)");
				break;
			case "CON00":
			case "CON01":
				obj.html("(mS/cm)");
				break;
			case "TMP00":
			case "TMP01":
				obj.html("(℃)");
				break;
			case "PHY00":
			case "PHY01":
				obj.html("");
				break;
			case "IMP00":
			case "LIM00":
			case "RIM00":
				obj.html("(pulse)");
				break;
			case "LTX00":
			case "RTX00":
			case "EVN00":
				obj.html("(TOX)");
				break;
			case "TOX00":
				obj.html("(%)");
				break;
			case "TOF00":
			case "VOC01":
			case "VOC02":
			case "VOC03":
			case "VOC04":
			case "VOC05":
			case "VOC06":
			case "VOC07":
			case "VOC08":
			case "VOC09":
			case "VOC10":
			case "VOC11":
			case "VOC12":
			case "VOC13":
			case "VOC14":
			case "VOC15":
				obj.html("(㎍/L)");
				break;
			case "CAD00":
			case "PLU00":
			case "COP00":
			case "ZIN00":
			case "PHE00":
			case "PHL00":
			case "TOC00":
			case "TON00":
			case "TOP00":
			case "NH400":
			case "NO300":
			case "SUS00":
			case "PO400":
				obj.html("(mg/L)");
				break;
			case "RIN00":
				obj.html("(mm/L)");
				break;
			case "BOD00":
			case "COD00":
				obj.html("(ppm)");
				break;
			}
		}

		function setMinOr_Color(minorVal, tdObj) {
			tdObj.css("font-weight", "bold");

			switch (minorVal) {
			case "0":
				tdObj.css("color", "green");
				break;
			case "1":
				tdObj.css("color", "blue");
				break;
			case "2":
				tdObj.css("color", "#F0D010");
				break;
			case "3":
				tdObj.css("color", "orange");
				break;
			case "4":
				tdObj.css("color", "red");
				break;
			default:
				//tdObj.css("color", "black");
				tdObj.css("color", "green");
				break;
			}
		}

		function detailPopup(fact_code, branch_no, sys_kind, branchName, sugye) {
			var sw = screen.width;
			var sh = screen.height;
			var winHeight = 890;
			var winWidth = 1260;
			var winLeftPost = (sw - winWidth) / 2;
			var winTopPost = (sh - winHeight) / 2;

			var src = "<c:url value='/waterpolmnt/situationctl/goTotalMntMainDetailTS.do'/>?sugye="
					+ sugye
					+ "&fact_code="
					+ fact_code
					+ "&branch_no="
					+ branch_no
					+ "&sys_kind="
					+ sys_kind
					+ "&branchName="
					+ encodeURI(branchName);

			window
					.open(
							src,
							'TotalMntMainDetail',
							'width='
									+ winWidth
									+ ',height='
									+ winHeight
									+ ',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='
									+ winLeftPost + ',top=' + winTopPost);
		}

		function chartChange(idx) {
			var sysKind = $("#sysR0" + idx).val();
			var item = $("#itemR0" + idx).val();

			chart2(idx, sysKind, item);
		}

		function chart() {
			var width = "277";
			var height = "99";

			for (var i = 1; i < 5; i++) {
				var param = "riverDiv=R0" + i + "&sysKind=T" + "&itemCode=TUR"
						+ "&itemName=" + encodeURI("탁도") + "&width=" + width
						+ "&height=" + height;

				var src = "<c:url value='/waterpolmnt/situationctl/getRiverMainChart.do?'/>";
				$('#chart' + i).attr("src", src + param);
			}
		}

		function chart2(rid, sysKind, item) {
			$("#chartLoading" + rid).show();

			var width = "310";
			var height = "99";

			var param = "riverDiv=R0" + rid + "&sysKind=" + sysKind
					+ "&itemCode=" + item + "&width=" + width + "&height="
					+ height;

			var src = "<c:url value='/waterpolmnt/situationctl/getRiverMainChart.do?'/>";
			$("#chart" + rid).attr("src", src + encodeURI(param));
		}

		function manager_popup(rid) {
			var sw = screen.width;
			var sh = screen.height;
			var winHeight = 890;
			var winWidth = 1260;
			var winLeftPost = (sw - winWidth) / 2;
			var winTopPost = 0;
			var width = winWidth - 20;
			var height = winHeight - 20;

			window
					.open(
							"<c:url value='/waterpolmnt/situationctl/goWATERSYSMNT.do?'/>river_div="
									+ rid,// 
							'ManagerDetailView',
							'width='
									+ winWidth
									+ ',height='
									+ winHeight
									+ ',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='
									+ winLeftPost + ',top=' + winTopPost);
		}

		var runScroll;

		function AutoScroll() {
			var bigHeight = 502;
			var smallHeight = 262;
			var height1 = 262; //502
			var height2 = 262; //502
			var height3 = 262; //502
			var height4 = 262; //502
			var sHeight_R01 = $("#dataListR01").attr("scrollHeight");
			var sHeight_R02 = $("#dataListR02").attr("scrollHeight");
			var sHeight_R03 = $("#dataListR03").attr("scrollHeight");
			var sHeight_R04 = $("#dataListR04").attr("scrollHeight");
			var sHeight = $("#dataList").attr("scrollHeight");

			var btn_content = document.getElementById("btn_content1");
			if (btn_content.className == "open")
				height1 = smallHeight;
			else
				height1 = bigHeight;

			btn_content = document.getElementById("btn_content2");
			if (btn_content.className == "open")
				height2 = smallHeight;
			else
				height2 = bigHeight;

			btn_content = document.getElementById("btn_content3");
			if (btn_content.className == "open")
				height3 = smallHeight;
			else
				height3 = bigHeight;

			btn_content = document.getElementById("btn_content4");
			if (btn_content.className == "open")
				height4 = smallHeight;
			else
				height4 = bigHeight;

			//320
			if (sHeight_R01 >= height1) {
				$('tbody#dataListR01 tr:first').appendTo('#dataListR01');

				$("#dataListR01 tr:odd").addClass("add");
				$("#dataListR01 tr:even").attr("class", "");
			}

			//320
			if (sHeight_R02 >= height2) {
				$('tbody#dataListR02 tr:first').appendTo('#dataListR02');

				$("#dataListR02 tr:odd").addClass("add");
				$("#dataListR02 tr:even").attr("class", "");
			}

			//320
			if (sHeight_R03 >= height3) {
				$('tbody#dataListR03 tr:first').appendTo('#dataListR03');

				$("#dataListR03 tr:odd").addClass("add");
				$("#dataListR03 tr:even").attr("class", "");
			}

			//320
			if (sHeight_R04 >= height4) {
				$('tbody#dataListR04 tr:first').appendTo('#dataListR04');

				$("#dataListR04 tr:odd").addClass("add");
				$("#dataListR04 tr:even").attr("class", "");
			}

			runScroll = setTimeout('AutoScroll()', (1000 * 3));
		}

		function stopScroll() {
			clearTimeout(runScroll);
		}

		function weatherWarnPopup() {
			var sw = screen.width;
			var sh = screen.height;
			var winHeight = 427;
			var winWidth = 687;
			var winLeftPost = (sw - winWidth) / 2;
			var winTopPost = (sh - winHeight) / 2;

			window
					.open(
							"<c:url value='/waterpolmnt/situationctl/goWeatherWarn.do?'/>",//
							'WeatherWarn',
							'width='
									+ winWidth
									+ ',height='
									+ winHeight
									+ ',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='
									+ winLeftPost + ',top=' + winTopPost);
		}

		function weather_popup(rid) {

			var sw = screen.width;
			var sh = screen.height;
			var winHeight = 530;
			var winWidth = 800;
			var winLeftPost = (sw - winWidth) / 2;
			var winTopPost = (sh - winHeight) / 2;

			var param = rid;

			window
					.open(
							"<c:url value='/waterpolmnt/situationctl/goTotalMntWeather.do'/>?river_id="
									+ param,
							'WeatherInfo' + rid,
							'width='
									+ winWidth
									+ ',height='
									+ winHeight
									+ ',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='
									+ winLeftPost + ',top=' + winTopPost);
		}

		/*******************************************************
		 * 기상정보 로드
		 *******************************************************/

		//날씨정보를 불러올 river_sq (T_WEATHER_AREA 테이블에서)
		var riverSqR01 = 1;
		var riverSqR02 = 1;
		var riverSqR03 = 1;
		var riverSqR04 = 1;

		var maxSqR01 = ${riverSqCnt.R01};
		var maxSqR02 = ${riverSqCnt.R02};
		var maxSqR03 = ${riverSqCnt.R03};
		var maxSqR04 = ${riverSqCnt.R04};

		function refreshWeather() {
			if (riverSqR01 >= (maxSqR01 + 1))
				riverSqR01 = 1;

			if (riverSqR02 >= (maxSqR02 + 1))
				riverSqR02 = 1;

			if (riverSqR03 >= (maxSqR03 + 1))
				riverSqR03 = 1;

			if (riverSqR04 >= (maxSqR04 + 1))
				riverSqR04 = 1;

			refreshWeatherInfoR01(riverSqR01);
			refreshWeatherInfoR02(riverSqR02);
			refreshWeatherInfoR03(riverSqR03);
			refreshWeatherInfoR04(riverSqR04);

			setTimeout('refreshWeather()', (1000 * 15));

			riverSqR01++;
			riverSqR02++;
			riverSqR03++;
			riverSqR04++;
		}

		function refreshWeatherInfoR01(sq) {
			getWeatherInfo(sq, "R01");
		}

		function refreshWeatherInfoR02(sq) {
			getWeatherInfo(sq, "R02");
		}

		function refreshWeatherInfoR03(sq) {
			getWeatherInfo(sq, "R03");
		}

		function refreshWeatherInfoR04(sq) {
			getWeatherInfo(sq, "R04");
		}

		function getWeatherInfo(sq, river_id) {
			$.ajax({
				type : "post",
				url : "<c:url value='/weather/getWeatherInfo.do'/>",
				cache : false,
				data:{river_sq:sq, river_id:river_id},
				dataType : "json",
				success : function(result) {
					setWeatherData(result.weather, sq, river_id);
				},
				error : function() {
				}
			});
		}

		function setWeatherData(data, sq, river_id) {
			if (data != null) {
				var panel = $("#weather" + river_id);
				var riverSqSpan = $("#weatherSq" + river_id);
				var weatherImg = $("#weatherImg" + river_id);
				var weatherForecast = $("#weatherForecast" + river_id);

				if (data != null && data.factName != null
						&& data.factName != "") {
					//지역명(지역)
					riverSqSpan.text(data.branch_name);// + "(" + data[riverIdx].regionName + ")");

					if (data.current_weather == "")
						data.current_weather = data.weather_sky;

					//이미지
					var imgSrc = getWeatherImgSrc(data.current_weather);

					weatherImg.attr("src", imgSrc);

					//날씨
					weatherForecast.text(data.current_weather);

					panel.css("cursor", "pointer");

					weatherImg.css("visibility", "hidden");
					panel.fadeOut("fast", function() {
						panel.fadeIn("fast", function() {
							weatherImg.css("visibility", "visible");
						})
					});
				}
			} else {
				var panel = $("#weather" + river_id);
				var riverSqSpan = $("#weatherSq" + river_id);
				var weatherImg = $("#weatherImg" + river_id);
				var weatherForecast = $("#weatherForecast" + river_id);

				var imgSrc = getWeatherImgSrc("");
				weatherImg.attr("src", imgSrc);

				riverSqSpan.text("");
				weatherForecast.text("");
			}

		}

		function getWeatherImgSrc(code) {
			var src = "<c:url value='/images/content/'/>"
			switch (code) {
			case "맑음":
				src += "NB01.png";
				break;
			case "구름조금":
				src += "NB02.png";
				break;
			case "소나기 끝":
			case "구름많음":
				src += "NB03.png";
				break;
			case "소낙눈 끝":
			case "진눈개비끝":
			case "눈 끝남":
			case "비 끝남":
			case "흐림":
				src += "NB04.png";
				break;
			case "소나기":
				src += "NB05.png";
				break;
			case "뇌우끝,비":
			case "약한비단속":
			case "약한비계속":
			case "보통비계속":
			case "보통비단속":
			case "구름조금 비":
			case "구름많음 비":
			case "약한이슬비":
			case "보통이슬비":
			case "보통소나기":
			case "약한소나기":
			case "이슬비 끝":
			case "흐림 비":
			case "비":
				src += "NB08.png";
				break;
			case "약한눈단속":
			case "약한눈계속":
			case "보통눈계속":
			case "보통눈단속":
			case "구름조금 눈":
			case "구름많음 눈":
			case "흐림 눈":
			case "눈":
				src += "NB11.png";
				break;
			case "약진눈깨비":
			case "약진눈개비":
			case "강진눈깨비":
			case "강진눈개비":
			case "구름조금 비/눈":
			case "구름많음 비/눈":
			case "흐림 비/눈":
			case "비 또는 눈":
				src += "NB12.png";
				break;
			case "눈 또는 비":
				src += "NB13.png";
				break;
			case "뇌우":
			case "천둥번개":
				src += "NB14.png";
				break;
			case "안개강해짐":
			case "안개변화무":
			case "안개 끝":
			case "안개":
				src += "NB15.png";
				break;
			case "박무":
				src += "NB17.png";
				break;
			case "황사":
				src += "NB16.png";
				break;
			case "안개엷어짐":
			case "연무":
				src += "NB18.png";
				break;
			default:
				src += "NB01_N.png";
				break;
			}

			return src;
		}

		/*******************************************************
		 *  기상특보
		 *******************************************************/
		var warnIdx = 1;
		var weatherWarnList;
		var weatherWarnInfo;

		function dataLoad_weatherWarn() {
			$.ajax({
				type : "post",
				url : "<c:url value='/weather/getWeatherWarning.do'/>",
				dataType : "json",
				success : dataLoad_weatherWarn_success,
				error : function(result) {
					$("#weather_warn").html("기상청 접속 실패!");
				}
			});
		}

		function dataLoad_weatherWarn_success(result) {
			if (result != null) {
				var obj = result["warningData"];

				if (obj != null && obj.warning_content != 'o 없 음'
						&& obj.warning_content != '') {
					weatherWarnList = obj.warning_content.split('o ');

					var length = weatherWarnList.length;

					///*
					//idx 1부터 [ 0번째는 비어있음 ]
					for (var idx = 1; idx < length; idx++) {
						//1. xx주의보 : [경보지역]에서 경보지역 표시 안함
						if (weatherWarnList[idx] != "")
							weatherWarnList[idx] = weatherWarnList[idx]
									.split(':')[0];
					}
					//*/

					weatherWarn_roll();
				} else {
					$("#weather_warn").text("현재 발효중인 기상특보 없음");
					//$("#weather_warn").attr("onclick","");
				}
			}
		}

		function weatherWarn_roll() {
			if (weatherWarnList.length > 2) {
				//weatherWarn_show(warnIdx);

				warnIdx++;
				if (warnIdx > weatherWarnList.length - 1)
					warnIdx = 1;

				setTimeout("weatherWarn_roll()", (1000 * 10));
			} else {
				//weatherWarn_show(1);
			}
		}

		function weatherWarn_show(idx) {
			$("#weather_warn").fadeOut(
					"fast",
					function() {
						$("#weather_warn").text(
								(idx) + ". " + weatherWarnList[idx] + " ["
										+ idx + "/"
										+ (weatherWarnList.length - 1) + "]");
						$("#weather_warn").fadeIn("fast");
					});
		}

		/*******************************************************
		 *  문자 marquee
		 *******************************************************/
		function showAlga() {
			$.getJSON(
					"<c:url value='/waterpolmnt/waterinfo/getRecentAlga.do'/>",
					function(data, status) {
						if (status == 'success') {
							var algaData = data['algaData'];
							var date = algaData.survey_time;
							var river = algaData.river_div;
							var temp = algaData.temp;
							var ph = algaData.ph;
							var chla = algaData.chla;
							var cyan = algaData.cyan;

							var text = $('#flowData').html();

							// 			if(algaData == null || algaData.survey_time == undefined || algaData.survey_time == "")
							// 				text += "&nbsp;&nbsp;&nbsp;<b>[조류예보]</b> 이상없음 ";
							// 			else
							// 				text += "&nbsp;&nbsp;&nbsp;<a href='javascript:go(0)'><b>[조류예보]</b>&nbsp;수계: <font color='gray'>"+river+ 
							// 						"</font> &nbsp;일자: <font color='gray'>" + date + 
							// 						"</font> &nbsp;pH: <font color='gray'>" + ph + 
							// 						"</font> &nbsp;클로로필a: <font color='gray'>" + chla + 
							// 						"</font> &nbsp;남조류: <font color='gray'>" + cyan + "</font></a>";

							//text = "조류 발생:이상없음(연동예정), 항공감시:이상없음(연동예정)";

							// 			$('#flowData').html(text);

						} else {
							//alert('error'); 
							return;
						}
					});

			$.getJSON(
					"<c:url value='/waterpolmnt/waterinfo/getRecentAir.do'/>",
					function(data, status) {
						if (status == 'success') {
							var airData = data['airData'];
							var date = airData.flight_date;
							var plane = airData.plane;
							var river = airData.sugye;
							var note = airData.note;

							var text = $('#flowData').html();

							// 			if(airData == null || airData.flight_date == undefined || airData.flight_date == "")
							// 				text += "&nbsp;&nbsp;&nbsp;<b>[항공감시]</b> 이상없음 ";
							// 			else	
							// 				text += "&nbsp;&nbsp;&nbsp;<a href='javascript:go(1)'><b>[항공감시]</b> &nbsp;비행구간: <font color='gray'>"+river+ 
							// 							"</font> &nbsp;일자: <font color='gray'>" + date + 
							// 							"</font> &nbsp;호기: <font color='gray'>" + plane + 
							// 							"</font> &nbsp;환경 항공 감시 결과: <font color='gray'>" + note + "</font></a>";

							//text = "조류 발생:이상없음(연동예정), 항공감시:이상없음(연동예정)";

							$('#flowData').html(text);
						} else {
							//alert('error'); 
							return;
						}
					});

		}

		function go(div) {
			if (div == 0) {
				opener.location.href = "<c:url value='/waterpolmnt/waterinfo/goAlgaCast.do'/>?clickMenu=122";
			} else if (div == 1) {
				opener.location.href = "<c:url value='/waterpolmnt/waterinfo/goAirMnt.do'/>?clickMenu=121";
			}

			opener.focus();
		}

		function flowText() {
			var text = $('#rolling');
			text.animate({
				marginLeft : '-500px'
			}, 20000, null, function() {
				text.css('marginLeft', '0px');//.append(tested.find('> li:first')); 
			});
		}

		//측정망 팝업
		function aPopup(river_div) {
			var sw = screen.width;
			var sh = screen.height;
			var winHeight = 800;
			var winWidth = 1264;
			var winLeftPost = (sw - winWidth) / 2;
			var winTopPost = (sh - winHeight) / 2;

			var param = "river_div=" + river_div;

			var src = "<c:url value='/waterpolmnt/situationctl/goChuckjungmang.do'/>?"
					+ param;

			window
					.open(
							src,
							'chuckjungmang',
							'width='
									+ winWidth
									+ ',height='
									+ winHeight
									+ ',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,left='
									+ winLeftPost + ',top=' + winTopPost);
		}

		/*******************************************************
		 *  사고조치관리 표시
		 *******************************************************/
		function loadAlertStepList() {

			$("#alertDataList").html("");
			$("#alertDataList").html(
					"<tr><td colspan='5'>데이터를 불러오고 있습니다.</td></td>");

			$
					.ajax({
						type : "post",
						url : "<c:url value='/alert/alertStepListView.do'/>",
						data : {
							riverId : "All",
							minTime : "",
							system : "All"
						},
						dataType : "json",
						success : function(result) {
							var tot = result['dataList'].length;
							var item;

							$("#alertDataList").html("");

							if (tot <= 0) {
								$("#alertDataList")
										.html(
												"<tr><td colspan='5'>조회 결과가 없습니다</td></td>");
							} else {
								for (var i = 0; i < tot; i++) {
									var obj = result['dataList'][i];

									//TR 색 변경
									if (i % 2 != 0) {
										trClass = "add";
									} else {
										trClass = "";
									}

									if (obj.alertStep == "1") {
										item = "경보발생";
									} else if (obj.alertStep == "2") {
										item = "현장확인";
									} else if (obj.alertStep == "3") {
										item = "시료분석";
									} else if (obj.alertStep == "4") {
										item = "경보발령";
									} else if (obj.alertStep == "5") {
										item = "상황전파";
									} else if (obj.alertStep == "6") {
										item = "상황종료";
									} else if (obj.alertStep == "7") {
										item = "";
									} else if (obj.alertStep == "8") {
										item = "";
									} else {
										item = "";
									}

									item = "<tr class='"+trClass+"'>"
											+ "<td id='rem"+i+"'>"
											+ obj.factName
											+ "</td>"
											+ "<td id='rem"+i+"'>"
											+ obj.branchNo
											+ "측정소</td>"
											+ "<td id='rem"+i+"'>"
											+ obj.minOr
											+ "</td>"
											+ "<td id='rem"+i+"'>"
											+ item
											+ "</td>"
											+ "<td style='cursor:pointer;'"
											+ "onclick=\"alertList_popup('"
											+ obj.factCode
											+ "', '"
											+ obj.branchNo
											+ "')\"><img src=\"<c:url value='/images/popup/icon_view.gif'/>\" alt='측정소상황전파자정보' /></td>";
									item = item + "</tr>";

									$("#alertDataList").append(item);

								}
							}
						},
						error : function(result) {
						}
					});
		}

		function alertList_popup(factCode, branchNo) {

			var sw = screen.width;
			var sh = screen.height;
			var winHeight = 480;
			var winWidth = 800;
			var winLeftPost = (sw - winWidth) / 2;
			var winTopPost = (sh - winHeight) / 2;

			window
					.open(
							"<c:url value='/waterpolmnt/situationctl/goTotalmntpopAlertList.do'/>?factCode="
									+ factCode + "&branchNo=" + branchNo,
							'alertList',
							'width='
									+ winWidth
									+ ',height='
									+ winHeight
									+ ',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='
									+ winLeftPost + ',top=' + winTopPost);
		}

		//4대강 통합 감시 출력
		function fnPrint(btn) {
			/*
			btn.style.display = 'none'; 
			var wb = '<O' + 'BJECT ID="WebBrowser" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OB'+'JECT>'; 
			document.body.insertAdjacentHTML('beforeEnd', wb); 
			WebBrowser.ExecWB( 7, -1 ); 
			WebBrowser.outerHTML = ''; 
			btn.style.display = 'block';
			 */
			/*
			btn.style.display = 'none';
			factory.printing.header = ""
			factory.printing.footer = ""
			factory.printing.portrait = false
			factory.printing.topMargin = 0.0
			factory.printing.leftMargin = 0.0
			factory.printing.rightMargin = 0.0
			factory.printing.bottomMargin = 0.0
			factory.printing.Print(false, window)
			btn.style.display = 'block';
			 */
			//아래 것만 사용
			// 	factory.printing.header = "";
			// 	factory.printing.footer = "";
			// 	factory.printing.portrait = false; //가로(false) 세로(true)
			// 	factory.printing.topMargin = 0.0;
			// 	factory.printing.leftMargin = 0.0;
			// 	factory.printing.rightMargin = 0.0;
			// 	factory.printing.bottomMargin = 0.0;
			// 	factory.printing.Preview();
			window.print();
		}
	</script>
</head>
<body class="popup noBakground">
	<div id='loadingDiv'>
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>"
			alt="로딩중.." />
	</div>
	<script language="javascript">
		$("#loadingDiv").dialog(
				{
					modal : true,
					open : function() {
						$(this).parents(".ui-dialog:first").find(
								".ui-dialog-titlebar-close").hide();
						$(this).parents(".ui-dialog:first").find(
								".ui-dialog-titlebar").hide();
						$(this).parents(".ui-dialog:first").find(
								".ui-dialog-resizing").hide();
						$(this).parents(".ui-dialog:first").find(
								".ui-dialog-buttonpane").hide();
						$(this).parents(".ui-dialog:first").find(
								".ui-dialog-dragging").hide();
						$(this).parents(".ui-dialog:first")
								.css("width", "85px");
						$(this).parents(".ui-dialog:first").css("height",
								"75px");
						$(this).parents(".ui-dialog:first").css("overflow",
								"hidden");

						$("#loadingDiv").css("float", "left");

					},
					width : 85,
					height : 75,
					showCaption : false,
					resizable : false,
					overlay : {
						opacity : 1,
						background : "black"
					}
				});
	</script>
	<div id="wrap" class="mainPop">
		<!-- 	<div class="pop_header"> -->
		<!-- 		<div class="bg_header_r"> -->
		<!-- 			<div class="bg_header"> -->
		<!-- 				<h1 class="pop_tit">4대강 통합 감시</h1> -->
		<!-- 				<p class="dateTime" id="currDate">-</p>  -->
		<!-- 			</div> -->
		<!-- 		</div> -->
		<!-- 	</div>	 -->
		<!-- 	<div class="pop_container"> -->
		<!-- 		<div class="pop_container_r"> -->
		<div id="container" class="pop_total_other2">
			<!-- content -->
			<div id="content" class="sub_waterpolmnt">
				<div class="content_wrap page_situationctl">
					<div class="inner_totalmnt">
						<div class="notes_weather">
							<div class="weatherWrap">
								<ul>
									<li><span class="point_text">최종수신일자</span> <span
										class="dateTime" id="currDate">-</span></li>
									<!-- <li><span class="point_text">기상특보</span> <span
										id="weather_warn" style="cursor: pointer"
										onclick="weatherWarnPopup()"></span></li> -->
									<li class="last"><img id="printBtn"
										src="/images/renewal2/icon_print.png"
										onclick="javascript:fnPrint(this);" style="cursor: pointer;"
										alt="인쇄" /></li>
								</ul>
							</div>
							<div class="notesWrap">
								<p class="txt">
									<a href="javascript:aPopup('all')"><img
										src="<c:url value='/images/content/ico_a.gif'/>" alt="all" />
										<span>국가수질자동측정망</span></a> <img
										src="<c:url value='/images/renewal2/ico_u.png'/>" alt="U" />
									<span>이동형측정기기</span> <img
										src="<c:url value='/images/content/ico_t.gif'/>" alt="T" /> <span>수질TMS</span>


								</p>
							</div>
						</div>

						<div class="totalMnt_wrap">
							<!-- 한강 -->
							<div class="list_wrap">
								<div class="part_wrap">
									<div class="header_box">
										<p class="btn">
											<a href="#" onclick="showHideCon(1)" id="btn_content1"
												class="open"><img id="img1"
												src="<c:url value='/images/popup/btn_arrow_up.gif'/>"
												alt="close" /></a>
										</p>
										<h2>
											<a href="javascript:manager_popup('R01');" id="h2Tit">한강</a>
											<select id="river_div" style="display: none;">
												<option value="all" selected="selected">수계(전체)</option>
												<option value="R01">한강</option>
												<option value="R02">낙동강</option>
												<option value="R03">금강</option>
												<option value="R04">영산강</option>
											</select>
										</h2>
										<p class="weather" id='weatherR01'>
											<span id='weatherSqR01'></span><%-- <img id='weatherImgR01'
												src="<c:url value='/images/common/ajax-loader.gif'/>" alt="" /><span
												id="weatherForecastR01">-</span> --%>
										</p>
									</div>
									<div id="list_content1" class="data_box">
										<table class="dataTable" oncontextmenu="return false"
											ondragstart="return false" onselectstart="return false">
											<colgroup>
												<col width="30px" />
												<col width="32px" />
												<col width="32px" />
												<col width="32px" />
												<col width="32px" />
												<col width="32px" />
												<col width="32px" />
												<col />
											</colgroup>
											<thead>
												<tr>
													<th scope="col"><img
														src="<c:url value='/images/content/line.gif'/>" alt="line" /></th>
													<th scope="col">합계</th>
													<th scope="col">정상</th>
													<th scope="col">관심</th>
													<th scope="col">주의</th>
													<th scope="col">경계</th>
													<th scope="col">심각</th>
													<th scope="col">미수신</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<th class="ico"><a href="javascript:aPopup('R01')"><img
															src="<c:url value='/images/content/ico_a.gif'/>" alt="A" /></a></th>
													<%-- 												<th class="ico"><img src="<c:url value='/images/content/ico_a.gif'/>" alt="A" /></th> --%>
													<td id="sum1a"><div class="point">-</div></td>
													<td id="normal1a"><div class="">-</div></td>
													<td id="interest1a"><div class="">-</div></td>
													<td id="caution1a"><div class="">-</div></td>
													<td id="alert1a"><div class="">-</div></td>
													<td id="over1a"><div class="">-</div></td>
													<td id="norecv1a"><div class="">-</div></td>
												</tr>

												<tr>
													<th class="ico"><img
														src="<c:url value='/images/content/ico_u.gif'/>" alt="U" /></th>
													<td id="sum1u"><div class="point">-</div></td>
													<td id="normal1u"><div class="">-</div></td>
													<td id="interest1u"><div class="">-</div></td>
													<td id="caution1u"><div class="">-</div></td>
													<td id="alert1u"><div class="">-</div></td>
													<td id="over1u"><div class="">-</div></td>
													<td id="norecv1u"><div class="">-</div></td>
												</tr>

												<%-- <tr> 
											<th class="ico"><img src="<c:url value='/images/content/ico_t.gif'/>" alt="T" /></th> 
												<td id="sum1t"><div class="point">-</div></td> 
												<td id="normal1t"><div class="">-</div></td> 
												<td id="interest1t"><div class="">-</div></td> 
												<td id="caution1t"><div class="">-</div></td> 
												<td id="alert1t"><div class="">-</div></td> 
												<td>-</td> 
												<td id="norecv1t"><div class="">-</div></td> 
											</tr>  --%>
											</tbody>
										</table>
										<br />
										<table class="dataTable" oncontextmenu="return false"
											ondragstart="return false" onselectstart="return false">
											<colgroup>
												<col width="30px" />
												<col width="38px" />
												<col width="38px" />
												<col width="38px" />
												<col width="38px" />
												<col width="*" />
												<col />
											</colgroup>
											<thead>
												<tr>
													<th scope="col"><img
														src="<c:url value='/images/content/line.gif'/>" alt="line" /></th>
													<th scope="col">합계</th>
													<th scope="col">정상</th>
													<th scope="col">주의(70%)</th>
													<th scope="col">경보(90%)</th>
													<th scope="col">초과</th>
													<th scope="col">미수신</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<th class="ico"><img
														src="<c:url value='/images/content/ico_t.gif'/>" alt="T" /></th>
													<td id="sum1t"><div class="point">-</div></td>
													<td id="normal1t"><div class="">-</div></td>
													<td id="interest1t"><div class="">-</div></td>
													<td id="caution1t"><div class="">-</div></td>
													<td id="alert1t"><div class="">-</div></td>

													<td id="norecv1t"><div class="">-</div></td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="graph" id="graph1" style="margin-top: 10px">
										<div style="position: absolute;">
											<img id="chartImg1"
												src="<c:url value='/images/common/btn_enlarge.gif' />"
												alt="" /> <span id='chartLoading1' style="display: none">로딩중
												입니다...</span>
										</div>
										<iframe frameborder="0" marginheight="0" marginwidth="0"
											id="chart1" width="270px" height="99px" scrolling="no"></iframe>
									</div>
								</div>
								<div class="part_wrap">
									<div class="data_table_wrap" id="h3Tit1">
										<ul class="select_menu">
											<li class="first"><select id="sysR01"
												style="width: 140px">
													<option value="A" selected="selected">국가수질자동측정망</option>
													<option value="T">수질TMS</option>
													<option value="U">이동형측정기기</option>


											</select></li>
											<li><select id="itemR01">
													<option value="TUR" selected="selected">탁도</option>
													<option value="DOX">DO</option>
													<option value="TMP">수온</option>
													<option value="PHY">pH</option>
													<option value="CON">전기전도도</option>
											</select></li>
											<li class="align" id="itemUnitR01">-</li>
										</ul>
										<table class="dataTable title_table"
											oncontextmenu="return false" ondragstart="return false"
											onselectstart="return false">
											<colgroup id = "col1R01">
												<col width="50px" />
												<col width="70px" />
												<col width="60px" />
												<col />
											</colgroup>
											<tr>
												<th scope="col">지역</th>
												<th scope="col">측정소</th>
												<th scope="col">측정값</th>
												<th scope="col">수신시간</th>
											</tr>
										</table>
										<div class="overBox" id="overBox1">
											<table class="dataTable con_table"
												oncontextmenu="return false" ondragstart="return false"
												onselectstart="return false">
												<colgroup id = "col2R01">
													<col width="50px" />
													<col width="70px" />
													<col width="60px" />
													<col />
												</colgroup>
												<tbody id="dataListR01">
													<tr>
														<td colspan='4'><span>데이터를 불러옵니다.</span></td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
									<!-- ㅠ  -->
									<div class="data_table_wrap" id="h3Tit2" style="display: none;">
										<ul class="select_menu">
											<li class="first"><select id="sys" style="width: 140px">
													<option value="A" selected="selected">국가수질자동측정망</option>
													<option value="T">수질TMS</option>
													<option value="U">이동형측정기기</option>
											</select></li>
											<li><select id="item">
													<option value="TUR" selected="selected">탁도</option>
													<option value="DOX">DO</option>
													<option value="TMP">수온</option>
													<option value="PHY">pH</option>
													<option value="CON">전기전도도</option>
											</select></li>
											<li class="align" id="itemUnit">-</li>
										</ul>
										<table class="dataTable title_table"
											oncontextmenu="return false" ondragstart="return false"
											onselectstart="return false">
											<colgroup>
												<col width="40px" />
												<col width="30px" />
												<col width="60px" />
												<col width="50px" />
												<col width="40px" />
												<col />
											</colgroup>
											<tr>
												<th scope="col">수계</th>
												<th scope="col">지역</th>
												<th scope="col">측정소</th>
												<th scope="col">측정값</th>
												<th scope="col">시스템</th>
												<th scope="col">시간</th>
											</tr>
										</table>
										<div class="overBox" id="overBox1_1">
											<table class="dataTable conTable"
												oncontextmenu="return false" ondragstart="return false"
												onselectstart="return false">
												<colgroup>
													<col width="40px" />
													<col width="30px" />
													<col width="60px" />
													<col width="50px" />
													<col width="40px" />
													<col />
												</colgroup>
												<tbody id="dataList">
													<tr>
														<td colspan="6"><span>데이터를 불러오는 중 입니다...</span></td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
									<!-- ㅠ -->
								</div>
							</div>
							<!-- //한강 -->
							<!-- 낙동강 -->
							<div class="list_wrap">
								<div class="part_wrap">
									<div class="header_box">
										<p class="btn">
											<a href="#" onclick="showHideCon(2)" id="btn_content2"
												class="open"><img id="img2"
												src="<c:url value='/images/popup/btn_arrow_up.gif'/>"
												alt="close" /></a>
										</p>
										<h2>
											<a href="javascript:manager_popup('R02');">낙동강</a>
										</h2>
										<p class="weather" id='weatherR02'>
											<span id='weatherSqR02'></span><%-- <img id='weatherImgR02'
												src="<c:url value='/images/common/ajax-loader.gif'/>" alt="" /><span
												id="weatherForecastR02">-</span> --%>
										</p>
									</div>
									<div id="list_content2" class="data_box">
										<table class="dataTable" oncontextmenu="return false"
											ondragstart="return false" onselectstart="return false">
											<colgroup>
												<col width="30px" />
												<col width="32px" />
												<col width="32px" />
												<col width="32px" />
												<col width="32px" />
												<col width="32px" />
												<col width="32px" />
												<col />
											</colgroup>
											<thead>
												<tr>
													<th scope="col"><img
														src="<c:url value='/images/content/line.gif'/>" alt="line" /></th>
													<th scope="col">합계</th>
													<th scope="col">정상</th>
													<th scope="col">관심</th>
													<th scope="col">주의</th>
													<th scope="col">경계</th>
													<th scope="col">심각</th>
													<th scope="col">미수신</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<th class="ico"><a href="javascript:aPopup('R02')"><img
															src="<c:url value='/images/content/ico_a.gif'/>" alt="A" /></a></th>
													<%-- 												<th class="ico"><img src="<c:url value='/images/content/ico_a.gif'/>" alt="A" /></th> --%>
													<td id="sum3a"><div class="point">-</div></td>
													<td id="normal3a"><div class="">-</div></td>
													<td id="interest3a"><div class="">-</div></td>
													<td id="caution3a"><div class="">-</div></td>
													<td id="alert3a"><div class="">-</div></td>
													<td id="over3a"><div class="">-</div></td>
													<td id="norecv3a"><div class="">-</div></td>
												</tr>


												<tr>
													<th class="ico"><img
														src="<c:url value='/images/content/ico_u.gif'/>" alt="U" /></th>
													<td id="sum3u"><div class="point">-</div></td>
													<td id="normal3u"><div class="">-</div></td>
													<td id="interest3u"><div class="">-</div></td>
													<td id="caution3u"><div class="">-</div></td>
													<td id="alert3u"><div class="">-</div></td>
													<td id="over3u"><div class="">-</div></td>
													<td id="norecv3u"><div class="">-</div></td>
												</tr>
												<%-- <tr> 
											<th class="ico"><img src="<c:url value='/images/content/ico_t.gif'/>" alt="T" /></th> 
												<td id="sum3t"><div class="point">-</div></td> 
												<td id="normal3t"><div class="">-</div></td> 
												<td id="interest3t"><div class="">-</div></td> 
												<td id="caution3t"><div class="">-</div></td>  
												<td id="alert3t"><div class="">-</div></td> 
												<td>-</td> 
												<td id="norecv3t"><div class="">-</div></td> 
											</tr> 
											 --%>
											</tbody>
										</table>
										<br />
										<table class="dataTable" oncontextmenu="return false"
											ondragstart="return false" onselectstart="return false">
											<colgroup>
												<col width="30px" />
												<col width="38px" />
												<col width="38px" />
												<col width="38px" />
												<col width="38px" />
												<col width="*" />
												<col />
											</colgroup>
											<thead>
												<tr>
													<th scope="col"><img
														src="<c:url value='/images/content/line.gif'/>" alt="line" /></th>
													<th scope="col">합계</th>
													<th scope="col">정상</th>
													<th scope="col">주의(70%)</th>
													<th scope="col">경보(90%)</th>
													<th scope="col">초과</th>
													<th scope="col">미수신</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<th class="ico"><img
														src="<c:url value='/images/content/ico_t.gif'/>" alt="T" /></th>
													<td id="sum3t"><div class="point">-</div></td>
													<td id="normal3t"><div class="">-</div></td>
													<td id="interest3t"><div class="">-</div></td>
													<td id="caution3t"><div class="">-</div></td>
													<td id="alert3t"><div class="">-</div></td>

													<td id="norecv3t"><div class="">-</div></td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="graph" id="graph2" style="margin-top: 10px">
										<div style="position: absolute;">
											<img id="chartImg2"
												src="<c:url value='/images/common/btn_enlarge.gif' />"
												alt="" /> <span id='chartLoading2' style="display: none">로딩중
												입니다...</span>
										</div>
										<iframe frameborder="0" marginheight="0" marginwidth="0"
											id="chart2" width="270px" height="99px" scrolling="no"></iframe>
									</div>
								</div>
								<div class="part_wrap">
									<div class="data_table_wrap">
										<ul class="select_menu">
											<li class="first"><select id="sysR02"
												style="width: 140px">
													<option value="A" selected="selected">국가수질자동측정망</option>
													<option value="T">수질TMS</option>
													<option value="U">이동형측정기기</option>
											</select></li>
											<li><select id="itemR02">
													<option value="TUR" selected="selected">탁도</option>
													<option value="DOX">DO</option>
													<option value="TMP">수온</option>
													<option value="PHY">pH</option>
													<option value="CON">전기전도도</option>
											</select></li>
											<li class="align" id="itemUnitR02">-</li>
										</ul>
										<table class="dataTable title_table"
											oncontextmenu="return false" ondragstart="return false"
											onselectstart="return false">
											<colgroup id = "col1R02">
												<col width="50px" />
												<col width="70px" />
												<col width="60px" />
												<col />
											</colgroup>
											<tr>
												<th scope="col">지역</th>
												<th scope="col">측정소</th>
												<th scope="col">측정값</th>
												<th scope="col">수신시간</th>
											</tr>
										</table>
										<div class="overBox" id="overBox2">
											<table class="dataTable con_table"
												oncontextmenu="return false" ondragstart="return false"
												onselectstart="return false">
												<colgroup id = "col2R02">
													<col width="50px" />
													<col width="70px" />
													<col width="60px" />
													<col />
												</colgroup>
												<tbody id="dataListR02">
													<tr>
														<td colspan='4'><span>데이터를 불러옵니다.</span></td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
							<!-- //낙동강 -->
							<!-- 금강 -->
							<div class="list_wrap">
								<div class="part_wrap">
									<div class="header_box">
										<p class="btn">
											<a href="#" onclick="showHideCon(3)" id="btn_content3"
												class="open"><img id="img3"
												src="<c:url value='/images/popup/btn_arrow_up.gif'/>"
												alt="close" /></a>
										</p>
										<h2>
											<a href="javascript:manager_popup('R03');">금강</a>
										</h2>
										<p class="weather" id='weatherR03'>
											<span id='weatherSqR03'></span><%-- <img id='weatherImgR03'
												src="<c:url value='/images/common/ajax-loader.gif'/>" alt="" /><span
												id="weatherForecastR03">-</span> --%>
										</p>
									</div>
									<div id="list_content3" class="data_box">
										<table class="dataTable" oncontextmenu="return false"
											ondragstart="return false" onselectstart="return false">
											<colgroup>
												<col width="30px" />
												<col width="32px" />
												<col width="32px" />
												<col width="32px" />
												<col width="32px" />
												<col width="32px" />
												<col width="32px" />
												<col />
											</colgroup>
											<thead>
												<tr>
													<th scope="col"><img
														src="<c:url value='/images/content/line.gif'/>" alt="line" /></th>
													<th scope="col">합계</th>
													<th scope="col">정상</th>
													<th scope="col">관심</th>
													<th scope="col">주의</th>
													<th scope="col">경계</th>
													<th scope="col">심각</th>
													<th scope="col">미수신</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<th class="ico"><a href="javascript:aPopup('R03')"><img
															src="<c:url value='/images/content/ico_a.gif'/>" alt="A" /></a></th>
													<%-- 												<th class="ico"><img src="<c:url value='/images/content/ico_a.gif'/>" alt="A" /></th> --%>
													<td id="sum2a"><div class="point">-</div></td>
													<td id="normal2a"><div class="">-</div></td>
													<td id="interest2a"><div class="">-</div></td>
													<td id="caution2a"><div class="">-</div></td>
													<td id="alert2a"><div class="">-</div></td>
													<td id="over2a"><div class="">-</div></td>
													<td id="norecv2a"><div class="">-</div></td>
												</tr>




												<tr>
													<th class="ico"><img
														src="<c:url value='/images/content/ico_u.gif'/>" alt="U" /></th>
													<td id="sum2u"><div class="point">-</div></td>
													<td id="normal2u"><div class="">-</div></td>
													<td id="interest2u"><div class="">-</div></td>
													<td id="caution2u"><div class="">-</div></td>
													<td id="alert2u"><div class="">-</div></td>
													<td id="over2u"><div class="">-</div></td>
													<td id="norecv2u"><div class="">-</div></td>
												</tr>

												<%-- <tr> 
											<th class="ico"><img src="<c:url value='/images/content/ico_t.gif'/>" alt="T" /></th> 
												<td id="sum2t"><div class="point">-</div></td> 
												<td id="normal2t"><div class="">-</div></td> 
												<td id="interest2t"><div class="">-</div></td> 
												<td id="caution2t"><div class="">-</div></td>  
												<td id="alert2t"><div class="">-</div></td> 
												<td>-</td> 
												<td id="norecv2t"><div class="">-</div></td> 
											</tr> --%>
											</tbody>
										</table>

										<br />
										<table class="dataTable" oncontextmenu="return false"
											ondragstart="return false" onselectstart="return false">
											<colgroup>
												<col width="30px" />
												<col width="38px" />
												<col width="38px" />
												<col width="38px" />
												<col width="38px" />
												<col width="*" />
												<col />
											</colgroup>
											<thead>
												<tr>
													<th scope="col"><img
														src="<c:url value='/images/content/line.gif'/>" alt="line" /></th>
													<th scope="col">합계</th>
													<th scope="col">정상</th>
													<th scope="col">주의(70%)</th>
													<th scope="col">경보(90%)</th>
													<th scope="col">초과</th>
													<th scope="col">미수신</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<th class="ico"><img
														src="<c:url value='/images/content/ico_t.gif'/>" alt="T" /></th>
													<td id="sum2t"><div class="point">-</div></td>
													<td id="normal2t"><div class="">-</div></td>
													<td id="interest2t"><div class="">-</div></td>
													<td id="caution2t"><div class="">-</div></td>
													<td id="alert2t"><div class="">-</div></td>
													<td id="norecv2t"><div class="">-</div></td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="graph" id="graph3" style="margin-top: 10px">
										<div style="position: absolute;">
											<img id="chartImg3"
												src="<c:url value='/images/common/btn_enlarge.gif' />"
												alt="" /> <span id='chartLoading3' style="display: none">로딩중
												입니다...</span>
										</div>
										<iframe frameborder="0" marginheight="0" marginwidth="0"
											id="chart3" width="270px" height="99px" scrolling="no"></iframe>
									</div>
								</div>
								<div class="part_wrap">
									<div class="data_table_wrap">
										<ul class="select_menu">
											<li class="first"><select id="sysR03"
												style="width: 140px">

													<option value="A" selected="selected">국가수질자동측정망</option>
													<option value="T">수질TMS</option>
													<option value="U">이동형측정기기</option>

											</select></li>
											<li><select id="itemR03">
													<option value="TUR" selected="selected">탁도</option>
													<option value="DOX">DO</option>
													<option value="TMP">수온</option>
													<option value="PHY">pH</option>
													<option value="CON">전기전도도</option>
											</select></li>
											<li class="align" id="itemUnitR03">-</li>
										</ul>
										<table class="dataTable title_table"
											oncontextmenu="return false" ondragstart="return false"
											onselectstart="return false">
											<colgroup id = "col1R03">
												<col width="50px" />
												<col width="70px" />
												<col width="60px" />
												<col />
											</colgroup>
											<tr>
												<th scope="col">지역</th>
												<th scope="col">측정소</th>
												<th scope="col">측정값</th>
												<th scope="col">수신시간</th>
											</tr>
										</table>
										<div class="overBox" id="overBox3">
											<table class="dataTable con_table"
												oncontextmenu="return false" ondragstart="return false"
												onselectstart="return false">
												<colgroup id = "col2R03">
													<col width="50px" />
													<col width="70px" />
													<col width="60px" />
													<col />
												</colgroup>
												<tbody id="dataListR03">
													<tr>
														<td colspan='4'><span>데이터를 불러옵니다.</span></td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
							<!-- //금강 -->
							<!-- 영산강 -->
							<div class="list_wrap list_last">
								<div class="part_wrap">
									<div class="header_box">
										<p class="btn">
											<a href="#" onclick="showHideCon(4)" id="btn_content4"
												class="open"><img id="img4"
												src="<c:url value='/images/popup/btn_arrow_up.gif'/>"
												alt="close" /></a>
										</p>
										<h2>
											<a href="javascript:manager_popup('R04');">영산강</a>
										</h2>
										<p class="weather" id='weatherR04'>
											<span id='weatherSqR04'></span><%-- <img id='weatherImgR04'
												src="<c:url value='/images/common/ajax-loader.gif'/>" alt="" /><span
												id="weatherForecastR04">-</span> --%>
										</p>
									</div>
									<div id="list_content4" class="data_box">
										<table class="dataTable" oncontextmenu="return false"
											ondragstart="return false" onselectstart="return false">
											<colgroup>
												<col width="30px" />
												<col width="32px" />
												<col width="32px" />
												<col width="32px" />
												<col width="32px" />
												<col width="32px" />
												<col width="32px" />
												<col />
											</colgroup>
											<thead>
												<tr>
													<th scope="col"><img
														src="<c:url value='/images/content/line.gif'/>" alt="line" /></th>
													<th scope="col">합계</th>
													<th scope="col">정상</th>
													<th scope="col">관심</th>
													<th scope="col">주의</th>
													<th scope="col">경계</th>
													<th scope="col">심각</th>
													<th scope="col">미수신</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<th class="ico"><a href="javascript:aPopup('R01')"><img
															src="<c:url value='/images/content/ico_a.gif'/>" alt="A" /></a></th>
													<%-- 												<th class="ico"><img src="<c:url value='/images/content/ico_a.gif'/>" alt="A" /></th> --%>
													<td id="sum4a"><div class="point">-</div></td>
													<td id="normal4a"><div class="">-</div></td>
													<td id="interest4a"><div class="">-</div></td>
													<td id="caution4a"><div class="">-</div></td>
													<td id="alert4a"><div class="">-</div></td>
													<td id="over4a"><div class="">-</div></td>
													<td id="norecv4a"><div class="">-</div></td>
												</tr>
												<tr>
													<th class="ico"><img
														src="<c:url value='/images/content/ico_u.gif'/>" alt="U" /></th>
													<td id="sum4u"><div class="point">-</div></td>
													<td id="normal4u"><div class="">-</div></td>
													<td id="interest4u"><div class="">-</div></td>
													<td id="caution4u"><div class="">-</div></td>
													<td id="alert4u"><div class="">-</div></td>
													<td id="over4u"><div class="">-</div></td>
													<td id="norecv4u"><div class="">-</div></td>
												</tr>
												<%-- <tr> 
											<th class="ico"><img src="<c:url value='/images/content/ico_t.gif'/>" alt="T" /></th> 
												<td id="sum4t"><div class="point">-</div></td> 
												<td id="normal4t"><div class="">-</div></td> 
												<td id="interest4t"><div class="">-</div></td> 
												<td id="caution4t"><div class="">-</div></td> 
												<td id="alert4t"><div class="">-</div></td> 
												<td>-</td> 
												<td id="norecv4t"><div class="">-</div></td> 
											</tr> --%>
											</tbody>
										</table>
										<br />
										<table class="dataTable" oncontextmenu="return false"
											ondragstart="return false" onselectstart="return false">
											<colgroup>
												<col width="30px" />
												<col width="38px" />
												<col width="38px" />
												<col width="38px" />
												<col width="38px" />
												<col width="*" />
												<col />
											</colgroup>
											<thead>
												<tr>
													<th scope="col"><img
														src="<c:url value='/images/content/line.gif'/>" alt="line" /></th>
													<th scope="col">합계</th>
													<th scope="col">정상</th>
													<th scope="col">주의(70%)</th>
													<th scope="col">경보(90%)</th>
													<th scope="col">초과</th>
													<th scope="col">미수신</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<th class="ico"><img
														src="<c:url value='/images/content/ico_t.gif'/>" alt="T" /></th>
													<td id="sum4t"><div class="point">-</div></td>
													<td id="normal4t"><div class="">-</div></td>
													<td id="interest4t"><div class="">-</div></td>
													<td id="caution4t"><div class="">-</div></td>
													<td id="alert4t"><div class="">-</div></td>
													<td id="norecv4t"><div class="">-</div></td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="graph" id="graph4" style="margin-top: 10px">
										<div style="position: absolute;">
											<img id="chartImg4"
												src="<c:url value='/images/common/btn_enlarge.gif' />"
												alt="" /> <span id='chartLoading4' style="display: none">로딩중
												입니다...</span>
										</div>
										<iframe frameborder="0" marginheight="0" marginwidth="0"
											id="chart4" width="270px" height="99px" scrolling="no"></iframe>
									</div>
								</div>
								<div class="part_wrap">
									<div class="data_table_wrap">
										<ul class="select_menu">
											<li class="first"><select id="sysR04"
												style="width: 140px">
													<option value="A" selected="selected">국가수질자동측정망</option>
													<option value="T">수질TMS</option>
													<option value="U">이동형측정기기</option>
											</select></li>
											<li><select id="itemR04">
													<option value="TUR" selected="selected">탁도</option>
													<option value="DOX">DO</option>
													<option value="TMP">수온</option>
													<option value="PHY">pH</option>
													<option value="CON">전기전도도</option>
											</select></li>
											<li class="align" id="itemUnitR04">-</li>
										</ul>
										<table class="dataTable title_table"
											oncontextmenu="return false" ondragstart="return false"
											onselectstart="return false">
											<colgroup id = "col1R04">
												<col width="50px" />
												<col width="70px" />
												<col width="60px" />
												<col />
											</colgroup>
											<tr>
												<th scope="col">지역</th>
												<th scope="col">측정소</th>
												<th scope="col">측정값</th>
												<th scope="col">수신시간</th>
											</tr>
										</table>
										<div class="overBox" id="overBox4">
											<table class="dataTable con_table"
												oncontextmenu="return false" ondragstart="return false"
												onselectstart="return false">
												<colgroup id = "col2R04">
													<col width="50px" />
													<col width="70px" />
													<col width="60px" />
													<col />
												</colgroup>
												<tbody id="dataListR04">
													<tr>
														<td colspan='4'><span>데이터를 불러옵니다.</span></td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
							<!-- //영산강 -->
							<script type="text/javascript">
								//<![CDATA[
								function showHideCon(idx) {
									var btn_content = document
											.getElementById("btn_content" + idx);
									var contentArea = document
											.getElementById("list_content"
													+ idx);
									var btn_graph = document
											.getElementById("btn_graph" + idx);
									var graphArea = document
											.getElementById("graph" + idx);
									var overBox = document
											.getElementById("overBox" + idx).style;

									if (btn_content.className == "open") {
										btn_content.className = "close";

										$("#img" + idx).attr(
												"src",
												$("#img" + idx).attr("src")
														.replace("_up.gif",
																"_down.gif"));
										$("#img" + idx).attr("alt", "open");

										contentArea.style.display = "none";
										graphArea.style.display = "none";

										overBox.height = "502px";

									} else {
										btn_content.className = "open";

										$("#img" + idx).attr(
												"src",
												$("#img" + idx).attr("src")
														.replace("_down.gif",
																"_up.gif"));
										$("#img" + idx).attr("alt", "close");

										contentArea.style.display = "";
										graphArea.style.display = "";

										overBox.height = "262px";
									}

									/*
									var layerBtn2Img = document.getElementById("layerBtn2").getElementsByTagName("img")[0];

									if(idx == 1){
										if(layerBtn2Img.alt == "close"){
											btn_content.className = "close";
											btn_content.getElementsByTagName("img")[0].src = btn_content.getElementsByTagName("img")[0].src.replace("_up.gif","_down.gif");
											btn_content.getElementsByTagName("img")[0].alt = "open";
											contentArea.style.display = "none";
											overBox.height = "497px";
										}
									}
									 */
									return false;
								}
								//]]>
							</script>
						</div>
						<!-- 					<div id="auction_info" class="auction_info"> -->
						<!-- 						<ul id="rolling" class="auction">  -->
						<!-- 							<li><span id='flowData' target="_blank" title="새창" ></span></li>  -->
						<!-- 						</ul> -->
						<!-- 					</div> -->
					</div>
				</div>
				<!-- //content -->

			</div>
			<!-- //container -->
		</div>
	</div>
	<div class="pop_footer">
		<div class="bg_footer_r">
			<div class="bg_footer"></div>
		</div>
	</div>
	<!-- </div> -->
	<!-- </div> -->
</body>
</html>