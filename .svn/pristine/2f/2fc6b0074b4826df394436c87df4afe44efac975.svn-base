var currentMenuOn = 0;
var currentxAdd =0;
var currentyAdd =0;
var currentRightClick = "";
var currentRightMenuHover ="";
var currentRightClickOn = 0;
var currentRightClickY = 0;
var currentRightClickX = 0;

bV  = parseInt(navigator.appVersion)
bNS = navigator.appName=="Netscape"
bIE = navigator.appName=="Microsoft Internet Explorer"
function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}


function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function MM_showHideLayers() { //v6.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3)
  	if ((obj=MM_findObj(args[i]))!=null) {
  		 v=args[i+2];
    		if (obj.style) {
				obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v;
			}
    		obj.visibility=v;
		}
}

function SFX_changeObjPosition(menuName,xAdd,yAdd) {
	var IEYIncrement = 2;
	var NEYIncrement = 7;
	
	var xPos = SFX_calculatePosition(chartName,'x') + parseInt(xAdd);
	if(document.all){
		var yPos = SFX_calculatePosition(chartName,'y') + parseInt(yAdd) + parseInt(IEYIncrement);
	}else{
		var yPos = SFX_calculatePosition(chartName,'y') + parseInt(yAdd) + parseInt(NEYIncrement);
	}
	SFX_moveLayer("SFXdiv-" + menuName, xPos, yPos);
}


function SFX_setRightClickHover(menuName){
	currentRightMenuHover = menuName;
}

function SFX_hideRightClickMenu(){
	if(currentRightClick !=""){
		MM_showHideLayers('SFXdiv-menu'+currentRightClick,'','hide');
		currentRightClickOn = 0;
	}
}

function SFX_clearLayers(){
	if(!DisableHide)
		SFX_hideRightClickMenu();
	
}

function SFX_resizeAction(){
	SFX_hideRightClickMenu();
//	
}

function SFX_moveLayer(objName, xPos, yPos) {
// Given object name, x & y position, adjust object to new top left
	var obj1 = MM_findObj(objName);
	obj1.style.top = parseInt(yPos) + 'px';
	obj1.style.left = parseInt(xPos) + 'px';
}

function SFX_calculatePosition(objName,cType) {
// Given object name & coordinate type (x or y) obtains coordinates of given object
	var obj1 = MM_findObj(objName);
	if(cType=='x'){
		var xPos = parseInt(obj1.offsetLeft);
		return xPos;
	}
	if(cType == 'y') {
		var yPos = parseInt(obj1.offsetTop)
		return yPos;
	}
}



function SFX_rightClickCheck(e) {

	SFX_clearLayers();
   if (bNS && e.which > 1){
		currentRightClickX=e.pageX;
		currentRightClickY=e.pageY;
     	SFX_showRightClickMenu(e.pageX, e.pageY);
     	return false;
   } else if (bIE && (event.button >1)) {
		currentRightClickX=event.pageX;
		currentRightClickY=event.pageY;
		SFX_showRightClickMenu(event.clientX,event.clientY);
    	return false;
   }
}

document.onmousedown = SFX_rightClickCheck;
if (document.layers) window.captureEvents(Event.MOUSEDOWN);
if (bNS && bV<5) window.onmousedown = SFX_rightClickCheck;

var chartName ='gauge1';
var DisableHide = 0;
function ToggleHideRightClick(value) {
	DisableHide = value;
}

function SFX_showRightClickMenu(xClick,yClick) {
//obtain right click menu from hdn field
//ask it's height...do calculation of div placement, show appropriate div
	//SFX_clearLayers();
	//Asks global variable for current right click menu name
	currentRightClick = currentRightMenuHover;
	currentRightClickOn = 1;
	//creates access to chart object
	var obj1 = document.getElementById(chartName);
	//asks x coordinate of click event


	//requests height of chart 
	var chartheight = parseInt(obj1.offsetHeight);
	var chartwidth = parseInt(obj1.offsetWidth);
	//alert(chartwidth);
	//asks y coordinate of click event
	if(bIE){
		var xPos = parseInt(xClick) + parseInt(document.body.scrollLeft);
		var currentclickY = parseInt(yClick) + parseInt(document.body.scrollTop);
		
	}else{
		var xPos = parseInt(xClick);
		var currentclickY = parseInt(yClick);
		
	}
	//requests y position of chart
	var chartYposition = parseInt(SFX_calculatePosition(chartName,'y'));
	var chartXposition = parseInt(SFX_calculatePosition(chartName,'x'));
	//creates access to current right click menu
	var objCurrentRightClick = MM_findObj('SFXdiv-menu'+ currentRightClick);
	//requests height of current right click menu
	var currentDivHeight = parseInt(objCurrentRightClick.offsetHeight);
	var currentDivWidth= parseInt(objCurrentRightClick.offsetWidth);
	//If right click menu will appear outside the chart, then move up
	if ((currentclickY - chartYposition + currentDivHeight)> chartheight) {
		var yPos = currentclickY - currentDivHeight;
	}else{
		var yPos = currentclickY;
	}

	if(xPos> chartXposition && xPos < (chartXposition + chartwidth ) && currentclickY > chartYposition && currentclickY < (chartYposition + chartheight))
	{
		currentRightClickY = parseInt(yPos);
		currentRightClickX = parseInt(xPos);
		SFX_moveLayer('SFXdiv-menu' + currentRightClick, xPos, yPos);
		MM_showHideLayers('SFXdiv-menu' +currentRightClick,'','show');
	}
}

