package daewooInfo.stats.bean;

import daewooInfo.cmmn.bean.ComDefaultVO;

/**
 * 통계 기본 VO 클래스
 * @author 김태훈
 * @since 2010.06.28
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2010.6.28  김태훈          최초 생성
 *
 * </pre>
 */
public class StatsVO extends ComDefaultVO{
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	//수계번호
	/**
	 * @uml.property  name="riverId"
	 */
	private String riverId;
	
	//수계명
	/**
	 * @uml.property  name="riverName"
	 */
	private String riverName;
	
	//공구번호
	/**
	 * @uml.property  name="factCode"
	 */
	private String factCode;
	
	//공구명
	/**
	 * @uml.property  name="factName"
	 */
	private String factName;
	
	//측정소번호
	/**
	 * @uml.property  name="branchNo"
	 */
	private String branchNo;	
	
	//시간
	/**
	 * @uml.property  name="timeFrm"
	 */
	private String timeFrm;
	
	//시간
	/**
	 * @uml.property  name="time"
	 */
	private String time;
	
	//측정코드
	/**
	 * @uml.property  name="itemCode"
	 */
	private String itemCode;
	
	//측정기준명
	/**
	 * @uml.property  name="itemName"
	 */
	private String itemName;
	
	//평균값
	/**
	 * @uml.property  name="vlAvg"
	 */
	private String vlAvg;
	
	//평균값 출력
	/**
	 * @uml.property  name="vlStrAvg"
	 */
	private String vlStrAvg;
	
	//최대값
	/**
	 * @uml.property  name="vlMax"
	 */
	private String vlMax;
	
	//최대값 출력
	/**
	 * @uml.property  name="vlStrMax"
	 */
	private String vlStrMax;
	
	//최소값
	/**
	 * @uml.property  name="vlMin"
	 */
	private String vlMin;
	
	//최소값 출력
	/**
	 * @uml.property  name="vlStrMin"
	 */
	private String vlStrMin;
	
	//값1
	/**
	 * @uml.property  name="val1"
	 */
	private String val1;
	
	//값2
	/**
	 * @uml.property  name="val2"
	 */
	private String val2;
	
	//값3
	/**
	 * @uml.property  name="val3"
	 */
	private String val3;

	//값4
	/**
	 * @uml.property  name="val4"
	 */
	private String val4;
	
	//값5
	/**
	 * @uml.property  name="val5"
	 */
	private String val5;
	
	/**
	 * @uml.property  name="orderBy"
	 */
	private String orderBy;
	
	private String roleCode;
	
	private String userId;
	
	/**
	 * @return
	 * @uml.property  name="orderBy"
	 */
	public String getOrderBy() {
		return orderBy;
	}
	/**
	 * @param orderBy
	 * @uml.property  name="orderBy"
	 */
	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}
	//시스템종류
	/**
	 * @uml.property  name="system"
	 */
	private String system;
	
	/**
	 * @uml.property  name="bItemX"
	 */
	private String bItemX;
	/**
	 * @uml.property  name="bItemY"
	 */
	private String bItemY;
	
	/**
	 * @uml.property  name="statKind"
	 */
	private String statKind;
	
	/**
	 * @uml.property  name="statsDate"
	 */
	private String statsDate;
	
	/**
	 * @uml.property  name="searchMonth"
	 */
	private String searchMonth;
	/**
	 * @uml.property  name="searchYear"
	 */
	private String searchYear;
	/**
	 * @uml.property  name="searchDay"
	 */
	private String searchDay;
	/**
	 * @uml.property  name="searchQuarter"
	 */
	private String searchQuarter;
	
	/**
	 * @uml.property  name="month"
	 */
	private String month;
	/**
	 * @uml.property  name="quarter"
	 */
	private String quarter;
	/**
	 * @uml.property  name="isCompare"
	 */
	private String isCompare;
	/**
	 * @uml.property  name="startMonth"
	 */
	private String startMonth;
	/**
	 * @uml.property  name="isCRow"
	 */
	private String isCRow;
	/**
	 * @uml.property  name="riverDiv"
	 */
	private String riverDiv;
	//private String riverName;
	
	/**
	 * @uml.property  name="statsDiv"
	 */
	private String statsDiv;
	/**
	 * @uml.property  name="factNo"
	 */
	private String factNo;
	/**
	 * @uml.property  name="regName"
	 */
	private String regName;
	/**
	 * @uml.property  name="sysKind"
	 */
	private String sysKind;
	/**
	 * @uml.property  name="sysName"
	 */
	private String sysName;
	/**
	 * @uml.property  name="factCode2"
	 */
	private String factCode2;
	/**
	 * @uml.property  name="branchNo2"
	 */
	private String branchNo2;
	/**
	 * @uml.property  name="branchName"
	 */
	private String branchName;
	/**
	 * @uml.property  name="recvRt"
	 */
	private String recvRt;
	/**
	 * @uml.property  name="conMax"
	 */
	private String conMax;
    /**
	 * @uml.property  name="conMin"
	 */
    private String conMin;
    /**
	 * @uml.property  name="conAvg"
	 */
    private String conAvg;
    /**
	 * @uml.property  name="dowMax"
	 */
    private String dowMax;
    /**
	 * @uml.property  name="dowMin"
	 */
    private String dowMin;
    /**
	 * @uml.property  name="dowAvg"
	 */
    private String dowAvg;
    /**
	 * @uml.property  name="tmpMax"
	 */
    private String tmpMax;
	/**
	 * @uml.property  name="tmpMin"
	 */
	private String tmpMin;
	/**
	 * @uml.property  name="tmpAvg"
	 */
	private String tmpAvg;
	/**
	 * @uml.property  name="phyMax"
	 */
	private String phyMax;
	/**
	 * @uml.property  name="phyMin"
	 */
	private String phyMin;
	/**
	 * @uml.property  name="phyAvg"
	 */
	private String phyAvg;
	/**
	 * @uml.property  name="tmp1Max"
	 */
	private String tmp1Max;
	/**
	 * @uml.property  name="tmp1Min"
	 */
	private String tmp1Min;
	/**
	 * @uml.property  name="tmp1Avg"
	 */
	private String tmp1Avg;
	/**
	 * @uml.property  name="tmp2Max"
	 */
	private String tmp2Max;
	/**
	 * @uml.property  name="tmp2Min"
	 */
	private String tmp2Min;
	/**
	 * @uml.property  name="tmp2Avg"
	 */
	private String tmp2Avg;
	/**
	 * @uml.property  name="phy1Max"
	 */
	private String phy1Max;
	/**
	 * @uml.property  name="phy1Min"
	 */
	private String phy1Min;
	/**
	 * @uml.property  name="phy1Avg"
	 */
	private String phy1Avg;
	/**
	 * @uml.property  name="phy2Max"
	 */
	private String phy2Max;
	/**
	 * @uml.property  name="phy2Min"
	 */
	private String phy2Min;
	/**
	 * @uml.property  name="phy2Avg"
	 */
	private String phy2Avg;
	/**
	 * @uml.property  name="dow1Max"
	 */
	private String dow1Max;
	/**
	 * @uml.property  name="dow1Min"
	 */
	private String dow1Min;
	/**
	 * @uml.property  name="dow1Avg"
	 */
	private String dow1Avg;
	/**
	 * @uml.property  name="dow2Max"
	 */
	private String dow2Max;
	/**
	 * @uml.property  name="dow2Min"
	 */
	private String dow2Min;
	/**
	 * @uml.property  name="dow2Avg"
	 */
	private String dow2Avg;
	/**
	 * @uml.property  name="con1Max"
	 */
	private String con1Max;
	/**
	 * @uml.property  name="con1Min"
	 */
	private String con1Min;
	/**
	 * @uml.property  name="con1Avg"
	 */
	private String con1Avg;
	/**
	 * @uml.property  name="con2Max"
	 */
	private String con2Max;
	/**
	 * @uml.property  name="con2Min"
	 */
	private String con2Min;
	/**
	 * @uml.property  name="con2Avg"
	 */
	private String con2Avg;
	/**
	 * @uml.property  name="turMax"
	 */
	private String turMax;
	/**
	 * @uml.property  name="turMin"
	 */
	private String turMin;
	/**
	 * @uml.property  name="turAvg"
	 */
	private String turAvg;
      /**
	 * @uml.property  name="impMax"
	 */
    private String impMax;
      /**
	 * @uml.property  name="impMin"
	 */
    private String impMin;
      /**
	 * @uml.property  name="impAvg"
	 */
    private String impAvg;
      /**
	 * @uml.property  name="limMax"
	 */
    private String limMax;
      /**
	 * @uml.property  name="limMin"
	 */
    private String limMin;
      /**
	 * @uml.property  name="limAvg"
	 */
    private String limAvg;
      /**
	 * @uml.property  name="rimMax"
	 */
    private String rimMax;
      /**
	 * @uml.property  name="rimMin"
	 */
    private String rimMin;
      /**
	 * @uml.property  name="rimAvg"
	 */
    private String rimAvg;
      /**
	 * @uml.property  name="ltxMax"
	 */
    private String ltxMax;
      /**
	 * @uml.property  name="ltxMin"
	 */
    private String ltxMin;
      /**
	 * @uml.property  name="ltxAvg"
	 */
    private String ltxAvg;
      /**
	 * @uml.property  name="rtxMax"
	 */
    private String rtxMax;
      /**
	 * @uml.property  name="rtxMin"
	 */
    private String rtxMin;
      /**
	 * @uml.property  name="rtxAvg"
	 */
    private String rtxAvg;
      /**
	 * @uml.property  name="toxMax"
	 */
    private String toxMax;
      /**
	 * @uml.property  name="toxMin"
	 */
    private String toxMin;
      /**
	 * @uml.property  name="toxAvg"
	 */
    private String toxAvg;
      /**
	 * @uml.property  name="evnMax"
	 */
    private String evnMax;
      /**
	 * @uml.property  name="evnMin"
	 */
    private String evnMin;
      /**
	 * @uml.property  name="evnAvg"
	 */
    private String evnAvg;
      /**
	 * @uml.property  name="tofMax"
	 */
    private String tofMax;
      /**
	 * @uml.property  name="tofMin"
	 */
    private String tofMin;
      /**
	 * @uml.property  name="tofAvg"
	 */
    private String tofAvg;
      /**
	 * @uml.property  name="voc1Max"
	 */
    private String voc1Max;
      /**
	 * @uml.property  name="voc1Min"
	 */
    private String voc1Min;
      /**
	 * @uml.property  name="voc1Avg"
	 */
    private String voc1Avg;
      /**
	 * @uml.property  name="voc2Max"
	 */
    private String voc2Max;
      /**
	 * @uml.property  name="voc2Min"
	 */
    private String voc2Min;
      /**
	 * @uml.property  name="voc2Avg"
	 */
    private String voc2Avg;
      /**
	 * @uml.property  name="voc3Max"
	 */
    private String voc3Max;
      /**
	 * @uml.property  name="voc3Min"
	 */
    private String voc3Min;
      /**
	 * @uml.property  name="voc3Avg"
	 */
    private String voc3Avg;
      /**
	 * @uml.property  name="voc4Max"
	 */
    private String voc4Max;
      /**
	 * @uml.property  name="voc4Min"
	 */
    private String voc4Min;
      /**
	 * @uml.property  name="voc4Avg"
	 */
    private String voc4Avg;
      /**
	 * @uml.property  name="voc5Max"
	 */
    private String voc5Max;
      /**
	 * @uml.property  name="voc5Min"
	 */
    private String voc5Min;
      /**
	 * @uml.property  name="voc5Avg"
	 */
    private String voc5Avg;
      /**
	 * @uml.property  name="voc6Max"
	 */
    private String voc6Max;
      /**
	 * @uml.property  name="voc6Min"
	 */
    private String voc6Min;
      /**
	 * @uml.property  name="voc6Avg"
	 */
    private String voc6Avg;
      /**
	 * @uml.property  name="voc7Max"
	 */
    private String voc7Max;
      /**
	 * @uml.property  name="voc7Min"
	 */
    private String voc7Min;
      /**
	 * @uml.property  name="voc7Avg"
	 */
    private String voc7Avg;
      /**
	 * @uml.property  name="voc8Max"
	 */
    private String voc8Max;
      /**
	 * @uml.property  name="voc8Min"
	 */
    private String voc8Min;
      /**
	 * @uml.property  name="voc8Avg"
	 */
    private String voc8Avg;
      /**
	 * @uml.property  name="voc9Max"
	 */
    private String voc9Max;
      /**
	 * @uml.property  name="voc9Min"
	 */
    private String voc9Min;
      /**
	 * @uml.property  name="voc9Avg"
	 */
    private String voc9Avg;
      /**
	 * @uml.property  name="voc10Max"
	 */
    private String voc10Max;
      /**
	 * @uml.property  name="voc10Min"
	 */
    private String voc10Min;
      /**
	 * @uml.property  name="voc10Avg"
	 */
    private String voc10Avg;
      /**
	 * @uml.property  name="voc11Max"
	 */
    private String voc11Max;
      /**
	 * @uml.property  name="voc11Min"
	 */
    private String voc11Min;
      /**
	 * @uml.property  name="voc11Avg"
	 */
    private String voc11Avg;
      /**
	 * @uml.property  name="voc12Max"
	 */
    private String voc12Max;
      /**
	 * @uml.property  name="voc12Min"
	 */
    private String voc12Min;
      /**
	 * @uml.property  name="voc12Avg"
	 */
    private String voc12Avg;
      /**
	 * @uml.property  name="voc13Max"
	 */
    private String voc13Max;
      /**
	 * @uml.property  name="voc13Min"
	 */
    private String voc13Min;
      /**
	 * @uml.property  name="voc13Avg"
	 */
    private String voc13Avg;
      /**
	 * @uml.property  name="voc14Max"
	 */
    private String voc14Max;
      /**
	 * @uml.property  name="voc14Min"
	 */
    private String voc14Min;
      /**
	 * @uml.property  name="voc14Avg"
	 */
    private String voc14Avg;
      /**
	 * @uml.property  name="voc15Max"
	 */
    private String voc15Max;
      /**
	 * @uml.property  name="voc15Min"
	 */
    private String voc15Min;
      /**
	 * @uml.property  name="voc15Avg"
	 */
    private String voc15Avg;
      /**
	 * @uml.property  name="copMax"
	 */
    private String copMax;
      /**
	 * @uml.property  name="copMin"
	 */
    private String copMin;
      /**
	 * @uml.property  name="copAvg"
	 */
    private String copAvg;
      /**
	 * @uml.property  name="pluMax"
	 */
    private String pluMax;
      /**
	 * @uml.property  name="pluMin"
	 */
    private String pluMin;
      /**
	 * @uml.property  name="pluAvg"
	 */
    private String pluAvg;
      /**
	 * @uml.property  name="zinMax"
	 */
    private String zinMax;
      /**
	 * @uml.property  name="zinMin"
	 */
    private String zinMin;
      /**
	 * @uml.property  name="zinAvg"
	 */
    private String zinAvg;
      /**
	 * @uml.property  name="cadMax"
	 */
    private String cadMax;
      /**
	 * @uml.property  name="cadMin"
	 */
    private String cadMin;
      /**
	 * @uml.property  name="cadAvg"
	 */
    private String cadAvg;
      /**
	 * @uml.property  name="pheMax"
	 */
    private String pheMax;
      /**
	 * @uml.property  name="pheMin"
	 */
    private String pheMin;
      /**
	 * @uml.property  name="pheAvg"
	 */
    private String pheAvg;
      /**
	 * @uml.property  name="phlMax"
	 */
    private String phlMax;
      /**
	 * @uml.property  name="phlMin"
	 */
    private String phlMin;
      /**
	 * @uml.property  name="phlAvg"
	 */
    private String phlAvg;
      /**
	 * @uml.property  name="tocMax"
	 */
    private String tocMax;
      /**
	 * @uml.property  name="tocMin"
	 */
    private String tocMin;
      /**
	 * @uml.property  name="tocAvg"
	 */
    private String tocAvg;
      /**
	 * @uml.property  name="tonMax"
	 */
    private String tonMax;
      /**
	 * @uml.property  name="tonMin"
	 */
    private String tonMin;
      /**
	 * @uml.property  name="tonAvg"
	 */
    private String tonAvg;
       /**
	 * @uml.property  name="topMax"
	 */
    private String topMax;
      /**
	 * @uml.property  name="topMin"
	 */
    private String topMin;
      /**
	 * @uml.property  name="topAvg"
	 */
    private String topAvg;
       /**
	 * @uml.property  name="nh4Max"
	 */
    private String nh4Max;
      /**
	 * @uml.property  name="nh4Min"
	 */
    private String nh4Min;
      /**
	 * @uml.property  name="nh4Avg"
	 */
    private String nh4Avg;
      /**
	 * @uml.property  name="no3Max"
	 */
    private String no3Max;
      /**
	 * @uml.property  name="no3Min"
	 */
    private String no3Min;
      /**
	 * @uml.property  name="no3Avg"
	 */
    private String no3Avg;
      /**
	 * @uml.property  name="po4Max"
	 */
    private String po4Max;
      /**
	 * @uml.property  name="po4Min"
	 */
    private String po4Min;
      /**
	 * @uml.property  name="po4Avg"
	 */
    private String po4Avg;
      /**
	 * @uml.property  name="rinMax"
	 */
    private String rinMax;
      /**
	 * @uml.property  name="rinMin"
	 */
    private String rinMin;
      /**
	 * @uml.property  name="rinAvg"
	 */
    private String rinAvg;
      
      /**
	 * @uml.property  name="minVl"
	 */
    private String minVl;
      /**
	 * @uml.property  name="maxVl"
	 */
    private String maxVl;
      /**
	 * @uml.property  name="avgVl"
	 */
    private String avgVl;
      
      
      /**
	 * @uml.property  name="ocDiv"
	 */
    private String ocDiv;
      /**
	 * @uml.property  name="ocPointDiv"
	 */
    private String ocPointDiv;
      
      
      /**
	 * @uml.property  name="actWeather"
	 */
    private String actWeather;
      /**
	 * @uml.property  name="actTraning"
	 */
    private String actTraning;
      /**
	 * @uml.property  name="actEmc"
	 */
    private String actEmc;
      /**
	 * @uml.property  name="actChk"
	 */
    private String actChk;
      /**
	 * @uml.property  name="actOther"
	 */
    private String actOther;
      /**
	 * @uml.property  name="day"
	 */
    private String day;
      /**
	 * @uml.property  name="year"
	 */
    private String year;
      
      
      /**
	 * @uml.property  name="acsCnt"
	 */
    private String acsCnt;
      /**
	 * @uml.property  name="smsCnt"
	 */
    private String smsCnt;
      
      
      /**
	 * @uml.property  name="firstCnt"
	 */
    private String firstCnt;
      /**
	 * @uml.property  name="time3Cnt"
	 */
    private String time3Cnt;
      /**
	 * @uml.property  name="time6Cnt"
	 */
    private String time6Cnt;
      /**
	 * @uml.property  name="time12Cnt"
	 */
    private String time12Cnt;
      
      
      /**
	 * @uml.property  name="atnCnt"
	 */
    private String atnCnt;
      /**
	 * @uml.property  name="catCnt"
	 */
    private String catCnt;
      /**
	 * @uml.property  name="alertCnt"
	 */
    private String alertCnt;
      /**
	 * @uml.property  name="srsCnt"
	 */
    private String srsCnt;
      
      
      /**
	 * @uml.property  name="statsArea"
	 */
    private String statsArea;
      /**
	 * @uml.property  name="dmwtrCnt"
	 */
    private String dmwtrCnt;
      /**
	 * @uml.property  name="equRollCnt"
	 */
    private String equRollCnt;
      /**
	 * @uml.property  name="shipCnt"
	 */
    private String shipCnt;
      /**
	 * @uml.property  name="shipPntCnt"
	 */
    private String shipPntCnt;
      /**
	 * @uml.property  name="fldssnCnt"
	 */
    private String fldssnCnt;
      /**
	 * @uml.property  name="tanktrCnt"
	 */
    private String tanktrCnt;
      /**
	 * @uml.property  name="equEltnCnt"
	 */
    private String equEltnCnt;
      /**
	 * @uml.property  name="ifplntCnt"
	 */
    private String ifplntCnt;
      /**
	 * @uml.property  name="oilCnt"
	 */
    private String oilCnt;
      /**
	 * @uml.property  name="phenolCnt"
	 */
    private String phenolCnt;
      /**
	 * @uml.property  name="toxicCnt"
	 */
    private String toxicCnt;
      /**
	 * @uml.property  name="fshdieCnt"
	 */
    private String fshdieCnt;
      /**
	 * @uml.property  name="etcCnt"
	 */
    private String etcCnt;
      
      
      /**
	 * @uml.property  name="warningCnt"
	 */
    private String warningCnt;
      /**
	 * @uml.property  name="fldCnt"
	 */
    private String fldCnt;
      /**
	 * @uml.property  name="smplCnt"
	 */
    private String smplCnt;
      /**
	 * @uml.property  name="issCnt"
	 */
    private String issCnt;
      /**
	 * @uml.property  name="spreadCnt"
	 */
    private String spreadCnt;
      /**
	 * @uml.property  name="endCnt"
	 */
    private String endCnt;
      
      /**
	 * @uml.property  name="prevType"
	 */
    private String prevType;
      
      /**
	 * @uml.property  name="statsTitle"
	 */
    private String statsTitle;
      
      /**
	 * @uml.property  name="gubun"
	 */
    private String gubun;
      
      
      /**
	 * @uml.property  name="baseTime"
	 */
    private String baseTime;
//      private String time;
      /**
	 * @uml.property  name="bodValue"
	 */
    private String bodValue;
      /**
	 * @uml.property  name="bodFlow"
	 */
    private String bodFlow;
      /**
	 * @uml.property  name="bodAvg"
	 */
    private String bodAvg;
      /**
	 * @uml.property  name="susValue"
	 */
    private String susValue;
      /**
	 * @uml.property  name="susFlow"
	 */
    private String susFlow;
      /**
	 * @uml.property  name="susAvg"
	 */
    private String susAvg;
      /**
	 * @uml.property  name="codValue"
	 */
    private String codValue;
      /**
	 * @uml.property  name="codFlow"
	 */
    private String codFlow;
      /**
	 * @uml.property  name="codAvg"
	 */
    private String codAvg;
      /**
	 * @uml.property  name="tonValue"
	 */
    private String tonValue;
      /**
	 * @uml.property  name="tonFlow"
	 */
    private String tonFlow;
//      private String tonAvg;
      /**
	 * @uml.property  name="topValue"
	 */
    private String topValue;
      /**
	 * @uml.property  name="topFlow"
	 */
    private String topFlow;
//      private String topAvg;
      /**
	 * @uml.property  name="riverCode"
	 */
    private String riverCode;
      /**
	 * @uml.property  name="frDate"
	 */
    private String frDate;
      /**
	 * @uml.property  name="toDate"
	 */
    private String toDate;
      
      
      /**
	 * @uml.property  name="factCodeX"
	 */
    private String factCodeX;
      /**
	 * @uml.property  name="branchNoX"
	 */
    private String branchNoX;
      /**
	 * @uml.property  name="factCodeY"
	 */
    private String factCodeY;
      /**
	 * @uml.property  name="branchNoY"
	 */
    private String branchNoY;
      
      /**
	 * @uml.property  name="turXVl"
	 */
    private String turXVl;
      /**
	 * @uml.property  name="turYVl"
	 */
    private String turYVl;
      /**
	 * @uml.property  name="tmpXVl"
	 */
    private String tmpXVl;
      /**
	 * @uml.property  name="tmpYVl"
	 */
    private String tmpYVl;
      /**
	 * @uml.property  name="phyXVl"
	 */
    private String phyXVl;
      /**
	 * @uml.property  name="phyYVl"
	 */
    private String phyYVl;
      /**
	 * @uml.property  name="dowXVl"
	 */
    private String dowXVl;
      /**
	 * @uml.property  name="dowYVl"
	 */
    private String dowYVl;
      /**
	 * @uml.property  name="conXVl"
	 */
    private String conXVl;
      /**
	 * @uml.property  name="conYVl"
	 */
    private String conYVl;
      /**
	 * @uml.property  name="tocXVl"
	 */
    private String tocXVl;
      /**
	 * @uml.property  name="tocYVl"
	 */
    private String tocYVl;
      /**
	 * @uml.property  name="impXVl"
	 */
    private String impXVl;  
      /**
	 * @uml.property  name="impYVl"
	 */
    private String impYVl; 
      /**
	 * @uml.property  name="limXVl"
	 */
    private String limXVl;  
      /**
	 * @uml.property  name="limYVl"
	 */
    private String limYVl; 
      /**
	 * @uml.property  name="rimXVl"
	 */
    private String rimXVl;  
      /**
	 * @uml.property  name="rimYVl"
	 */
    private String rimYVl; 
      /**
	 * @uml.property  name="ltxXVl"
	 */
    private String ltxXVl;  
      /**
	 * @uml.property  name="ltxYVl"
	 */
    private String ltxYVl; 
      /**
	 * @uml.property  name="rtxXVl"
	 */
    private String rtxXVl;  
      /**
	 * @uml.property  name="rtxYVl"
	 */
    private String rtxYVl; 
      /**
	 * @uml.property  name="toxXVl"
	 */
    private String toxXVl;  
      /**
	 * @uml.property  name="toxYVl"
	 */
    private String toxYVl; 
      /**
	 * @uml.property  name="evnXVl"
	 */
    private String evnXVl;  
      /**
	 * @uml.property  name="evnYVl"
	 */
    private String evnYVl; 
      /**
	 * @uml.property  name="voc1XVl"
	 */
    private String voc1XVl;  
      /**
	 * @uml.property  name="voc1YVl"
	 */
    private String voc1YVl; 
      /**
	 * @uml.property  name="voc2XVl"
	 */
    private String voc2XVl;  
      /**
	 * @uml.property  name="voc2YVl"
	 */
    private String voc2YVl; 
      /**
	 * @uml.property  name="voc3XVl"
	 */
    private String voc3XVl;  
      /**
	 * @uml.property  name="voc3YVl"
	 */
    private String voc3YVl; 
      /**
	 * @uml.property  name="voc4XVl"
	 */
    private String voc4XVl;  
      /**
	 * @uml.property  name="voc4YVl"
	 */
    private String voc4YVl; 
      /**
	 * @uml.property  name="voc5XVl"
	 */
    private String voc5XVl;  
      /**
	 * @uml.property  name="voc5YVl"
	 */
    private String voc5YVl; 
      /**
	 * @uml.property  name="voc6XVl"
	 */
    private String voc6XVl;  
      /**
	 * @uml.property  name="voc6YVl"
	 */
    private String voc6YVl; 
      /**
	 * @uml.property  name="voc7XVl"
	 */
    private String voc7XVl;  
      /**
	 * @uml.property  name="voc7YVl"
	 */
    private String voc7YVl; 
      /**
	 * @uml.property  name="voc8XVl"
	 */
    private String voc8XVl;  
      /**
	 * @uml.property  name="voc8YVl"
	 */
    private String voc8YVl; 
      /**
	 * @uml.property  name="voc9XVl"
	 */
    private String voc9XVl;  
      /**
	 * @uml.property  name="voc9YVl"
	 */
    private String voc9YVl; 
      /**
	 * @uml.property  name="voc10XVl"
	 */
    private String voc10XVl;  
      /**
	 * @uml.property  name="voc10YVl"
	 */
    private String voc10YVl; 
      /**
	 * @uml.property  name="voc11XVl"
	 */
    private String voc11XVl;  
      /**
	 * @uml.property  name="voc11YVl"
	 */
    private String voc11YVl; 
      /**
	 * @uml.property  name="voc12XVl"
	 */
    private String voc12XVl;  
      /**
	 * @uml.property  name="voc12YVl"
	 */
    private String voc12YVl; 
      /**
	 * @uml.property  name="voc13XVl"
	 */
    private String voc13XVl;  
      /**
	 * @uml.property  name="voc13YVl"
	 */
    private String voc13YVl; 
      /**
	 * @uml.property  name="voc14XVl"
	 */
    private String voc14XVl; 
      /**
	 * @uml.property  name="voc14YVl"
	 */
    private String voc14YVl; 
      /**
	 * @uml.property  name="voc15XVl"
	 */
    private String voc15XVl;  
      /**
	 * @uml.property  name="voc15YVl"
	 */
    private String voc15YVl; 
      /**
	 * @uml.property  name="tonXVl"
	 */
    private String tonXVl;  
      /**
	 * @uml.property  name="tonYVl"
	 */
    private String tonYVl; 
      /**
	 * @uml.property  name="topXVl"
	 */
    private String topXVl;  
      /**
	 * @uml.property  name="topYVl"
	 */
    private String topYVl; 
      /**
	 * @uml.property  name="nh4XVl"
	 */
    private String nh4XVl;  
      /**
	 * @uml.property  name="nh4YVl"
	 */
    private String nh4YVl; 
      /**
	 * @uml.property  name="no3XVl"
	 */
    private String no3XVl;  
      /**
	 * @uml.property  name="no3YVl"
	 */
    private String no3YVl; 
      /**
	 * @uml.property  name="po4XVl"
	 */
    private String po4XVl;  
      /**
	 * @uml.property  name="po4YVl"
	 */
    private String po4YVl; 
      /**
	 * @uml.property  name="tofXVl"
	 */
    private String tofXVl;  
      /**
	 * @uml.property  name="tofYVl"
	 */
    private String tofYVl; 
      /**
	 * @uml.property  name="cadXVl"
	 */
    private String cadXVl;  
      /**
	 * @uml.property  name="cadYVl"
	 */
    private String cadYVl; 
      /**
	 * @uml.property  name="pluXVl"
	 */
    private String pluXVl;  
      /**
	 * @uml.property  name="pluYVl"
	 */
    private String pluYVl; 
      /**
	 * @uml.property  name="copXVl"
	 */
    private String copXVl;  
      /**
	 * @uml.property  name="copYVl"
	 */
    private String copYVl; 
      /**
	 * @uml.property  name="zinXVl"
	 */
    private String zinXVl;  
      /**
	 * @uml.property  name="zinYVl"
	 */
    private String zinYVl; 
      /**
	 * @uml.property  name="pheXVl"
	 */
    private String pheXVl;  
      /**
	 * @uml.property  name="pheYVl"
	 */
    private String pheYVl; 
      /**
	 * @uml.property  name="phlXVl"
	 */
    private String phlXVl;  
      /**
	 * @uml.property  name="phlYVl"
	 */
    private String phlYVl; 
      /**
	 * @uml.property  name="rinXVl"
	 */
    private String rinXVl;  
      /**
	 * @uml.property  name="rinYVl"
	 */
    private String rinYVl;       
      
      /**
	 * @uml.property  name="wlvYVl"
	 */
    private String wlvYVl;
      /**
	 * @uml.property  name="flwYVl"
	 */
    private String flwYVl;
      
      /**
	 * @uml.property  name="sort"
	 */
    private String sort;
      
      
      /**
	 * @uml.property  name="startDate"
	 */
    private String startDate;
      /**
	 * @uml.property  name="endDate"
	 */
    private String endDate;
      
      /**
	 * @uml.property  name="searchDate"
	 */
    private String searchDate;
      
      /**
	 * @uml.property  name="valueX"
	 */
    private String valueX;
      /**
	 * @uml.property  name="valueY"
	 */
    private String valueY;
      
      /**
	 * @uml.property  name="itemCodeX"
	 */
    private String itemCodeX;
      /**
	 * @uml.property  name="itemCodeY"
	 */
    private String itemCodeY;
      
      
      
	/**
	 * @return
	 * @uml.property  name="valueX"
	 */
	public String getValueX() {
		return valueX;
	}
	/**
	 * @param valueX
	 * @uml.property  name="valueX"
	 */
	public void setValueX(String valueX) {
		this.valueX = valueX;
	}
	/**
	 * @return
	 * @uml.property  name="valueY"
	 */
	public String getValueY() {
		return valueY;
	}
	/**
	 * @param valueY
	 * @uml.property  name="valueY"
	 */
	public void setValueY(String valueY) {
		this.valueY = valueY;
	}
	/**
	 * @return
	 * @uml.property  name="itemCodeX"
	 */
	public String getItemCodeX() {
		return itemCodeX;
	}
	/**
	 * @param itemCodeX
	 * @uml.property  name="itemCodeX"
	 */
	public void setItemCodeX(String itemCodeX) {
		this.itemCodeX = itemCodeX;
	}
	/**
	 * @return
	 * @uml.property  name="itemCodeY"
	 */
	public String getItemCodeY() {
		return itemCodeY;
	}
	/**
	 * @param itemCodeY
	 * @uml.property  name="itemCodeY"
	 */
	public void setItemCodeY(String itemCodeY) {
		this.itemCodeY = itemCodeY;
	}
	/**
	 * @return
	 * @uml.property  name="tocXVl"
	 */
	public String getTocXVl() {
		return tocXVl;
	}
	/**
	 * @param tocXVl
	 * @uml.property  name="tocXVl"
	 */
	public void setTocXVl(String tocXVl) {
		this.tocXVl = tocXVl;
	}
	/**
	 * @return
	 * @uml.property  name="tocYVl"
	 */
	public String getTocYVl() {
		return tocYVl;
	}
	/**
	 * @param tocYVl
	 * @uml.property  name="tocYVl"
	 */
	public void setTocYVl(String tocYVl) {
		this.tocYVl = tocYVl;
	}
	/**
	 * @return
	 * @uml.property  name="impXVl"
	 */
	public String getImpXVl() {
		return impXVl;
	}
	/**
	 * @param impXVl
	 * @uml.property  name="impXVl"
	 */
	public void setImpXVl(String impXVl) {
		this.impXVl = impXVl;
	}
	/**
	 * @return
	 * @uml.property  name="impYVl"
	 */
	public String getImpYVl() {
		return impYVl;
	}
	/**
	 * @param impYVl
	 * @uml.property  name="impYVl"
	 */
	public void setImpYVl(String impYVl) {
		this.impYVl = impYVl;
	}
	/**
	 * @return
	 * @uml.property  name="limXVl"
	 */
	public String getLimXVl() {
		return limXVl;
	}
	/**
	 * @param limXVl
	 * @uml.property  name="limXVl"
	 */
	public void setLimXVl(String limXVl) {
		this.limXVl = limXVl;
	}
	/**
	 * @return
	 * @uml.property  name="limYVl"
	 */
	public String getLimYVl() {
		return limYVl;
	}
	/**
	 * @param limYVl
	 * @uml.property  name="limYVl"
	 */
	public void setLimYVl(String limYVl) {
		this.limYVl = limYVl;
	}
	/**
	 * @return
	 * @uml.property  name="rimXVl"
	 */
	public String getRimXVl() {
		return rimXVl;
	}
	/**
	 * @param rimXVl
	 * @uml.property  name="rimXVl"
	 */
	public void setRimXVl(String rimXVl) {
		this.rimXVl = rimXVl;
	}
	/**
	 * @return
	 * @uml.property  name="rimYVl"
	 */
	public String getRimYVl() {
		return rimYVl;
	}
	/**
	 * @param rimYVl
	 * @uml.property  name="rimYVl"
	 */
	public void setRimYVl(String rimYVl) {
		this.rimYVl = rimYVl;
	}
	/**
	 * @return
	 * @uml.property  name="ltxXVl"
	 */
	public String getLtxXVl() {
		return ltxXVl;
	}
	/**
	 * @param ltxXVl
	 * @uml.property  name="ltxXVl"
	 */
	public void setLtxXVl(String ltxXVl) {
		this.ltxXVl = ltxXVl;
	}
	/**
	 * @return
	 * @uml.property  name="ltxYVl"
	 */
	public String getLtxYVl() {
		return ltxYVl;
	}
	/**
	 * @param ltxYVl
	 * @uml.property  name="ltxYVl"
	 */
	public void setLtxYVl(String ltxYVl) {
		this.ltxYVl = ltxYVl;
	}
	/**
	 * @return
	 * @uml.property  name="rtxXVl"
	 */
	public String getRtxXVl() {
		return rtxXVl;
	}
	/**
	 * @param rtxXVl
	 * @uml.property  name="rtxXVl"
	 */
	public void setRtxXVl(String rtxXVl) {
		this.rtxXVl = rtxXVl;
	}
	/**
	 * @return
	 * @uml.property  name="rtxYVl"
	 */
	public String getRtxYVl() {
		return rtxYVl;
	}
	/**
	 * @param rtxYVl
	 * @uml.property  name="rtxYVl"
	 */
	public void setRtxYVl(String rtxYVl) {
		this.rtxYVl = rtxYVl;
	}
	/**
	 * @return
	 * @uml.property  name="toxXVl"
	 */
	public String getToxXVl() {
		return toxXVl;
	}
	/**
	 * @param toxXVl
	 * @uml.property  name="toxXVl"
	 */
	public void setToxXVl(String toxXVl) {
		this.toxXVl = toxXVl;
	}
	/**
	 * @return
	 * @uml.property  name="toxYVl"
	 */
	public String getToxYVl() {
		return toxYVl;
	}
	/**
	 * @param toxYVl
	 * @uml.property  name="toxYVl"
	 */
	public void setToxYVl(String toxYVl) {
		this.toxYVl = toxYVl;
	}
	/**
	 * @return
	 * @uml.property  name="evnXVl"
	 */
	public String getEvnXVl() {
		return evnXVl;
	}
	/**
	 * @param evnXVl
	 * @uml.property  name="evnXVl"
	 */
	public void setEvnXVl(String evnXVl) {
		this.evnXVl = evnXVl;
	}
	/**
	 * @return
	 * @uml.property  name="evnYVl"
	 */
	public String getEvnYVl() {
		return evnYVl;
	}
	/**
	 * @param evnYVl
	 * @uml.property  name="evnYVl"
	 */
	public void setEvnYVl(String evnYVl) {
		this.evnYVl = evnYVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc1XVl"
	 */
	public String getVoc1XVl() {
		return voc1XVl;
	}
	/**
	 * @param voc1XVl
	 * @uml.property  name="voc1XVl"
	 */
	public void setVoc1XVl(String voc1XVl) {
		this.voc1XVl = voc1XVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc1YVl"
	 */
	public String getVoc1YVl() {
		return voc1YVl;
	}
	/**
	 * @param voc1YVl
	 * @uml.property  name="voc1YVl"
	 */
	public void setVoc1YVl(String voc1YVl) {
		this.voc1YVl = voc1YVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc2XVl"
	 */
	public String getVoc2XVl() {
		return voc2XVl;
	}
	/**
	 * @param voc2XVl
	 * @uml.property  name="voc2XVl"
	 */
	public void setVoc2XVl(String voc2XVl) {
		this.voc2XVl = voc2XVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc2YVl"
	 */
	public String getVoc2YVl() {
		return voc2YVl;
	}
	/**
	 * @param voc2YVl
	 * @uml.property  name="voc2YVl"
	 */
	public void setVoc2YVl(String voc2YVl) {
		this.voc2YVl = voc2YVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc3XVl"
	 */
	public String getVoc3XVl() {
		return voc3XVl;
	}
	/**
	 * @param voc3XVl
	 * @uml.property  name="voc3XVl"
	 */
	public void setVoc3XVl(String voc3XVl) {
		this.voc3XVl = voc3XVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc3YVl"
	 */
	public String getVoc3YVl() {
		return voc3YVl;
	}
	/**
	 * @param voc3YVl
	 * @uml.property  name="voc3YVl"
	 */
	public void setVoc3YVl(String voc3YVl) {
		this.voc3YVl = voc3YVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc4XVl"
	 */
	public String getVoc4XVl() {
		return voc4XVl;
	}
	/**
	 * @param voc4XVl
	 * @uml.property  name="voc4XVl"
	 */
	public void setVoc4XVl(String voc4XVl) {
		this.voc4XVl = voc4XVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc4YVl"
	 */
	public String getVoc4YVl() {
		return voc4YVl;
	}
	/**
	 * @param voc4YVl
	 * @uml.property  name="voc4YVl"
	 */
	public void setVoc4YVl(String voc4YVl) {
		this.voc4YVl = voc4YVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc5XVl"
	 */
	public String getVoc5XVl() {
		return voc5XVl;
	}
	/**
	 * @param voc5XVl
	 * @uml.property  name="voc5XVl"
	 */
	public void setVoc5XVl(String voc5XVl) {
		this.voc5XVl = voc5XVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc5YVl"
	 */
	public String getVoc5YVl() {
		return voc5YVl;
	}
	/**
	 * @param voc5YVl
	 * @uml.property  name="voc5YVl"
	 */
	public void setVoc5YVl(String voc5YVl) {
		this.voc5YVl = voc5YVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc6XVl"
	 */
	public String getVoc6XVl() {
		return voc6XVl;
	}
	/**
	 * @param voc6XVl
	 * @uml.property  name="voc6XVl"
	 */
	public void setVoc6XVl(String voc6XVl) {
		this.voc6XVl = voc6XVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc6YVl"
	 */
	public String getVoc6YVl() {
		return voc6YVl;
	}
	/**
	 * @param voc6YVl
	 * @uml.property  name="voc6YVl"
	 */
	public void setVoc6YVl(String voc6YVl) {
		this.voc6YVl = voc6YVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc7XVl"
	 */
	public String getVoc7XVl() {
		return voc7XVl;
	}
	/**
	 * @param voc7XVl
	 * @uml.property  name="voc7XVl"
	 */
	public void setVoc7XVl(String voc7XVl) {
		this.voc7XVl = voc7XVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc7YVl"
	 */
	public String getVoc7YVl() {
		return voc7YVl;
	}
	/**
	 * @param voc7YVl
	 * @uml.property  name="voc7YVl"
	 */
	public void setVoc7YVl(String voc7YVl) {
		this.voc7YVl = voc7YVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc8XVl"
	 */
	public String getVoc8XVl() {
		return voc8XVl;
	}
	/**
	 * @param voc8XVl
	 * @uml.property  name="voc8XVl"
	 */
	public void setVoc8XVl(String voc8XVl) {
		this.voc8XVl = voc8XVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc8YVl"
	 */
	public String getVoc8YVl() {
		return voc8YVl;
	}
	/**
	 * @param voc8YVl
	 * @uml.property  name="voc8YVl"
	 */
	public void setVoc8YVl(String voc8YVl) {
		this.voc8YVl = voc8YVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc9XVl"
	 */
	public String getVoc9XVl() {
		return voc9XVl;
	}
	/**
	 * @param voc9XVl
	 * @uml.property  name="voc9XVl"
	 */
	public void setVoc9XVl(String voc9XVl) {
		this.voc9XVl = voc9XVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc9YVl"
	 */
	public String getVoc9YVl() {
		return voc9YVl;
	}
	/**
	 * @param voc9YVl
	 * @uml.property  name="voc9YVl"
	 */
	public void setVoc9YVl(String voc9YVl) {
		this.voc9YVl = voc9YVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc10XVl"
	 */
	public String getVoc10XVl() {
		return voc10XVl;
	}
	/**
	 * @param voc10XVl
	 * @uml.property  name="voc10XVl"
	 */
	public void setVoc10XVl(String voc10XVl) {
		this.voc10XVl = voc10XVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc10YVl"
	 */
	public String getVoc10YVl() {
		return voc10YVl;
	}
	/**
	 * @param voc10YVl
	 * @uml.property  name="voc10YVl"
	 */
	public void setVoc10YVl(String voc10YVl) {
		this.voc10YVl = voc10YVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc11XVl"
	 */
	public String getVoc11XVl() {
		return voc11XVl;
	}
	/**
	 * @param voc11XVl
	 * @uml.property  name="voc11XVl"
	 */
	public void setVoc11XVl(String voc11XVl) {
		this.voc11XVl = voc11XVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc11YVl"
	 */
	public String getVoc11YVl() {
		return voc11YVl;
	}
	/**
	 * @param voc11YVl
	 * @uml.property  name="voc11YVl"
	 */
	public void setVoc11YVl(String voc11YVl) {
		this.voc11YVl = voc11YVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc12XVl"
	 */
	public String getVoc12XVl() {
		return voc12XVl;
	}
	/**
	 * @param voc12XVl
	 * @uml.property  name="voc12XVl"
	 */
	public void setVoc12XVl(String voc12XVl) {
		this.voc12XVl = voc12XVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc12YVl"
	 */
	public String getVoc12YVl() {
		return voc12YVl;
	}
	/**
	 * @param voc12YVl
	 * @uml.property  name="voc12YVl"
	 */
	public void setVoc12YVl(String voc12YVl) {
		this.voc12YVl = voc12YVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc13XVl"
	 */
	public String getVoc13XVl() {
		return voc13XVl;
	}
	/**
	 * @param voc13XVl
	 * @uml.property  name="voc13XVl"
	 */
	public void setVoc13XVl(String voc13XVl) {
		this.voc13XVl = voc13XVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc13YVl"
	 */
	public String getVoc13YVl() {
		return voc13YVl;
	}
	/**
	 * @param voc13YVl
	 * @uml.property  name="voc13YVl"
	 */
	public void setVoc13YVl(String voc13YVl) {
		this.voc13YVl = voc13YVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc14XVl"
	 */
	public String getVoc14XVl() {
		return voc14XVl;
	}
	/**
	 * @param voc14XVl
	 * @uml.property  name="voc14XVl"
	 */
	public void setVoc14XVl(String voc14XVl) {
		this.voc14XVl = voc14XVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc14YVl"
	 */
	public String getVoc14YVl() {
		return voc14YVl;
	}
	/**
	 * @param voc14YVl
	 * @uml.property  name="voc14YVl"
	 */
	public void setVoc14YVl(String voc14YVl) {
		this.voc14YVl = voc14YVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc15XVl"
	 */
	public String getVoc15XVl() {
		return voc15XVl;
	}
	/**
	 * @param voc15XVl
	 * @uml.property  name="voc15XVl"
	 */
	public void setVoc15XVl(String voc15XVl) {
		this.voc15XVl = voc15XVl;
	}
	/**
	 * @return
	 * @uml.property  name="voc15YVl"
	 */
	public String getVoc15YVl() {
		return voc15YVl;
	}
	/**
	 * @param voc15YVl
	 * @uml.property  name="voc15YVl"
	 */
	public void setVoc15YVl(String voc15YVl) {
		this.voc15YVl = voc15YVl;
	}
	/**
	 * @return
	 * @uml.property  name="tonXVl"
	 */
	public String getTonXVl() {
		return tonXVl;
	}
	/**
	 * @param tonXVl
	 * @uml.property  name="tonXVl"
	 */
	public void setTonXVl(String tonXVl) {
		this.tonXVl = tonXVl;
	}
	/**
	 * @return
	 * @uml.property  name="tonYVl"
	 */
	public String getTonYVl() {
		return tonYVl;
	}
	/**
	 * @param tonYVl
	 * @uml.property  name="tonYVl"
	 */
	public void setTonYVl(String tonYVl) {
		this.tonYVl = tonYVl;
	}
	/**
	 * @return
	 * @uml.property  name="topXVl"
	 */
	public String getTopXVl() {
		return topXVl;
	}
	/**
	 * @param topXVl
	 * @uml.property  name="topXVl"
	 */
	public void setTopXVl(String topXVl) {
		this.topXVl = topXVl;
	}
	/**
	 * @return
	 * @uml.property  name="topYVl"
	 */
	public String getTopYVl() {
		return topYVl;
	}
	/**
	 * @param topYVl
	 * @uml.property  name="topYVl"
	 */
	public void setTopYVl(String topYVl) {
		this.topYVl = topYVl;
	}
	/**
	 * @return
	 * @uml.property  name="nh4XVl"
	 */
	public String getNh4XVl() {
		return nh4XVl;
	}
	/**
	 * @param nh4XVl
	 * @uml.property  name="nh4XVl"
	 */
	public void setNh4XVl(String nh4XVl) {
		this.nh4XVl = nh4XVl;
	}
	/**
	 * @return
	 * @uml.property  name="nh4YVl"
	 */
	public String getNh4YVl() {
		return nh4YVl;
	}
	/**
	 * @param nh4YVl
	 * @uml.property  name="nh4YVl"
	 */
	public void setNh4YVl(String nh4YVl) {
		this.nh4YVl = nh4YVl;
	}
	/**
	 * @return
	 * @uml.property  name="no3XVl"
	 */
	public String getNo3XVl() {
		return no3XVl;
	}
	/**
	 * @param no3XVl
	 * @uml.property  name="no3XVl"
	 */
	public void setNo3XVl(String no3XVl) {
		this.no3XVl = no3XVl;
	}
	/**
	 * @return
	 * @uml.property  name="no3YVl"
	 */
	public String getNo3YVl() {
		return no3YVl;
	}
	/**
	 * @param no3YVl
	 * @uml.property  name="no3YVl"
	 */
	public void setNo3YVl(String no3YVl) {
		this.no3YVl = no3YVl;
	}
	/**
	 * @return
	 * @uml.property  name="po4XVl"
	 */
	public String getPo4XVl() {
		return po4XVl;
	}
	/**
	 * @param po4XVl
	 * @uml.property  name="po4XVl"
	 */
	public void setPo4XVl(String po4XVl) {
		this.po4XVl = po4XVl;
	}
	/**
	 * @return
	 * @uml.property  name="po4YVl"
	 */
	public String getPo4YVl() {
		return po4YVl;
	}
	/**
	 * @param po4YVl
	 * @uml.property  name="po4YVl"
	 */
	public void setPo4YVl(String po4YVl) {
		this.po4YVl = po4YVl;
	}
	/**
	 * @return
	 * @uml.property  name="tofXVl"
	 */
	public String getTofXVl() {
		return tofXVl;
	}
	/**
	 * @param tofXVl
	 * @uml.property  name="tofXVl"
	 */
	public void setTofXVl(String tofXVl) {
		this.tofXVl = tofXVl;
	}
	/**
	 * @return
	 * @uml.property  name="tofYVl"
	 */
	public String getTofYVl() {
		return tofYVl;
	}
	/**
	 * @param tofYVl
	 * @uml.property  name="tofYVl"
	 */
	public void setTofYVl(String tofYVl) {
		this.tofYVl = tofYVl;
	}
	/**
	 * @return
	 * @uml.property  name="cadXVl"
	 */
	public String getCadXVl() {
		return cadXVl;
	}
	/**
	 * @param cadXVl
	 * @uml.property  name="cadXVl"
	 */
	public void setCadXVl(String cadXVl) {
		this.cadXVl = cadXVl;
	}
	/**
	 * @return
	 * @uml.property  name="cadYVl"
	 */
	public String getCadYVl() {
		return cadYVl;
	}
	/**
	 * @param cadYVl
	 * @uml.property  name="cadYVl"
	 */
	public void setCadYVl(String cadYVl) {
		this.cadYVl = cadYVl;
	}
	/**
	 * @return
	 * @uml.property  name="pluXVl"
	 */
	public String getPluXVl() {
		return pluXVl;
	}
	/**
	 * @param pluXVl
	 * @uml.property  name="pluXVl"
	 */
	public void setPluXVl(String pluXVl) {
		this.pluXVl = pluXVl;
	}
	/**
	 * @return
	 * @uml.property  name="pluYVl"
	 */
	public String getPluYVl() {
		return pluYVl;
	}
	/**
	 * @param pluYVl
	 * @uml.property  name="pluYVl"
	 */
	public void setPluYVl(String pluYVl) {
		this.pluYVl = pluYVl;
	}
	/**
	 * @return
	 * @uml.property  name="copXVl"
	 */
	public String getCopXVl() {
		return copXVl;
	}
	/**
	 * @param copXVl
	 * @uml.property  name="copXVl"
	 */
	public void setCopXVl(String copXVl) {
		this.copXVl = copXVl;
	}
	/**
	 * @return
	 * @uml.property  name="copYVl"
	 */
	public String getCopYVl() {
		return copYVl;
	}
	/**
	 * @param copYVl
	 * @uml.property  name="copYVl"
	 */
	public void setCopYVl(String copYVl) {
		this.copYVl = copYVl;
	}
	/**
	 * @return
	 * @uml.property  name="zinXVl"
	 */
	public String getZinXVl() {
		return zinXVl;
	}
	/**
	 * @param zinXVl
	 * @uml.property  name="zinXVl"
	 */
	public void setZinXVl(String zinXVl) {
		this.zinXVl = zinXVl;
	}
	/**
	 * @return
	 * @uml.property  name="zinYVl"
	 */
	public String getZinYVl() {
		return zinYVl;
	}
	/**
	 * @param zinYVl
	 * @uml.property  name="zinYVl"
	 */
	public void setZinYVl(String zinYVl) {
		this.zinYVl = zinYVl;
	}
	/**
	 * @return
	 * @uml.property  name="pheXVl"
	 */
	public String getPheXVl() {
		return pheXVl;
	}
	/**
	 * @param pheXVl
	 * @uml.property  name="pheXVl"
	 */
	public void setPheXVl(String pheXVl) {
		this.pheXVl = pheXVl;
	}
	/**
	 * @return
	 * @uml.property  name="pheYVl"
	 */
	public String getPheYVl() {
		return pheYVl;
	}
	/**
	 * @param pheYVl
	 * @uml.property  name="pheYVl"
	 */
	public void setPheYVl(String pheYVl) {
		this.pheYVl = pheYVl;
	}
	/**
	 * @return
	 * @uml.property  name="phlXVl"
	 */
	public String getPhlXVl() {
		return phlXVl;
	}
	/**
	 * @param phlXVl
	 * @uml.property  name="phlXVl"
	 */
	public void setPhlXVl(String phlXVl) {
		this.phlXVl = phlXVl;
	}
	/**
	 * @return
	 * @uml.property  name="phlYVl"
	 */
	public String getPhlYVl() {
		return phlYVl;
	}
	/**
	 * @param phlYVl
	 * @uml.property  name="phlYVl"
	 */
	public void setPhlYVl(String phlYVl) {
		this.phlYVl = phlYVl;
	}
	/**
	 * @return
	 * @uml.property  name="rinXVl"
	 */
	public String getRinXVl() {
		return rinXVl;
	}
	/**
	 * @param rinXVl
	 * @uml.property  name="rinXVl"
	 */
	public void setRinXVl(String rinXVl) {
		this.rinXVl = rinXVl;
	}
	/**
	 * @return
	 * @uml.property  name="rinYVl"
	 */
	public String getRinYVl() {
		return rinYVl;
	}
	/**
	 * @param rinYVl
	 * @uml.property  name="rinYVl"
	 */
	public void setRinYVl(String rinYVl) {
		this.rinYVl = rinYVl;
	}
	public String getBItemX() {
		return bItemX;
	}
	public void setBItemX(String itemX) {
		bItemX = itemX;
	}
	public String getBItemY() {
		return bItemY;
	}
	public void setBItemY(String itemY) {
		bItemY = itemY;
	}
	/**
	 * @return
	 * @uml.property  name="minVl"
	 */
	public String getMinVl() {
		return minVl;
	}
	/**
	 * @param minVl
	 * @uml.property  name="minVl"
	 */
	public void setMinVl(String minVl) {
		this.minVl = minVl;
	}
	/**
	 * @return
	 * @uml.property  name="maxVl"
	 */
	public String getMaxVl() {
		return maxVl;
	}
	/**
	 * @param maxVl
	 * @uml.property  name="maxVl"
	 */
	public void setMaxVl(String maxVl) {
		this.maxVl = maxVl;
	}
	/**
	 * @return
	 * @uml.property  name="avgVl"
	 */
	public String getAvgVl() {
		return avgVl;
	}
	/**
	 * @param avgVl
	 * @uml.property  name="avgVl"
	 */
	public void setAvgVl(String avgVl) {
		this.avgVl = avgVl;
	}
	/**
	 * @return
	 * @uml.property  name="wlvYVl"
	 */
	public String getWlvYVl() {
		return wlvYVl;
	}
	/**
	 * @param wlvYVl
	 * @uml.property  name="wlvYVl"
	 */
	public void setWlvYVl(String wlvYVl) {
		this.wlvYVl = wlvYVl;
	}
	/**
	 * @return
	 * @uml.property  name="flwYVl"
	 */
	public String getFlwYVl() {
		return flwYVl;
	}
	/**
	 * @param flwYVl
	 * @uml.property  name="flwYVl"
	 */
	public void setFlwYVl(String flwYVl) {
		this.flwYVl = flwYVl;
	}
	/**
	 * @return
	 * @uml.property  name="turXVl"
	 */
	public String getTurXVl() {
		return turXVl;
	}
	/**
	 * @param turXVl
	 * @uml.property  name="turXVl"
	 */
	public void setTurXVl(String turXVl) {
		this.turXVl = turXVl;
	}
	/**
	 * @return
	 * @uml.property  name="turYVl"
	 */
	public String getTurYVl() {
		return turYVl;
	}
	/**
	 * @param turYVl
	 * @uml.property  name="turYVl"
	 */
	public void setTurYVl(String turYVl) {
		this.turYVl = turYVl;
	}
	/**
	 * @return
	 * @uml.property  name="tmpXVl"
	 */
	public String getTmpXVl() {
		return tmpXVl;
	}
	/**
	 * @param tmpXVl
	 * @uml.property  name="tmpXVl"
	 */
	public void setTmpXVl(String tmpXVl) {
		this.tmpXVl = tmpXVl;
	}
	/**
	 * @return
	 * @uml.property  name="tmpYVl"
	 */
	public String getTmpYVl() {
		return tmpYVl;
	}
	/**
	 * @param tmpYVl
	 * @uml.property  name="tmpYVl"
	 */
	public void setTmpYVl(String tmpYVl) {
		this.tmpYVl = tmpYVl;
	}
	/**
	 * @return
	 * @uml.property  name="phyXVl"
	 */
	public String getPhyXVl() {
		return phyXVl;
	}
	/**
	 * @param phyXVl
	 * @uml.property  name="phyXVl"
	 */
	public void setPhyXVl(String phyXVl) {
		this.phyXVl = phyXVl;
	}
	/**
	 * @return
	 * @uml.property  name="phyYVl"
	 */
	public String getPhyYVl() {
		return phyYVl;
	}
	/**
	 * @param phyYVl
	 * @uml.property  name="phyYVl"
	 */
	public void setPhyYVl(String phyYVl) {
		this.phyYVl = phyYVl;
	}
	/**
	 * @return
	 * @uml.property  name="dowXVl"
	 */
	public String getDowXVl() {
		return dowXVl;
	}
	/**
	 * @param dowXVl
	 * @uml.property  name="dowXVl"
	 */
	public void setDowXVl(String dowXVl) {
		this.dowXVl = dowXVl;
	}
	/**
	 * @return
	 * @uml.property  name="dowYVl"
	 */
	public String getDowYVl() {
		return dowYVl;
	}
	/**
	 * @param dowYVl
	 * @uml.property  name="dowYVl"
	 */
	public void setDowYVl(String dowYVl) {
		this.dowYVl = dowYVl;
	}
	/**
	 * @return
	 * @uml.property  name="conXVl"
	 */
	public String getConXVl() {
		return conXVl;
	}
	/**
	 * @param conXVl
	 * @uml.property  name="conXVl"
	 */
	public void setConXVl(String conXVl) {
		this.conXVl = conXVl;
	}
	/**
	 * @return
	 * @uml.property  name="conYVl"
	 */
	public String getConYVl() {
		return conYVl;
	}
	/**
	 * @param conYVl
	 * @uml.property  name="conYVl"
	 */
	public void setConYVl(String conYVl) {
		this.conYVl = conYVl;
	}
	/**
	 * @return
	 * @uml.property  name="endDate"
	 */
	public String getEndDate() {
		return endDate;
	}
	/**
	 * @param endDate
	 * @uml.property  name="endDate"
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	/**
	 * @return
	 * @uml.property  name="sort"
	 */
	public String getSort() {
		return sort;
	}
	/**
	 * @param sort
	 * @uml.property  name="sort"
	 */
	public void setSort(String sort) {
		this.sort = sort;
	}
	/**
	 * @return
	 * @uml.property  name="factCodeX"
	 */
	public String getFactCodeX() {
		return factCodeX;
	}
	/**
	 * @param factCodeX
	 * @uml.property  name="factCodeX"
	 */
	public void setFactCodeX(String factCodeX) {
		this.factCodeX = factCodeX;
	}
	/**
	 * @return
	 * @uml.property  name="branchNoX"
	 */
	public String getBranchNoX() {
		return branchNoX;
	}
	/**
	 * @param branchNoX
	 * @uml.property  name="branchNoX"
	 */
	public void setBranchNoX(String branchNoX) {
		this.branchNoX = branchNoX;
	}
	/**
	 * @return
	 * @uml.property  name="factCodeY"
	 */
	public String getFactCodeY() {
		return factCodeY;
	}
	/**
	 * @param factCodeY
	 * @uml.property  name="factCodeY"
	 */
	public void setFactCodeY(String factCodeY) {
		this.factCodeY = factCodeY;
	}
	/**
	 * @return
	 * @uml.property  name="branchNoY"
	 */
	public String getBranchNoY() {
		return branchNoY;
	}
	/**
	 * @param branchNoY
	 * @uml.property  name="branchNoY"
	 */
	public void setBranchNoY(String branchNoY) {
		this.branchNoY = branchNoY;
	}
	/**
	 * @return
	 * @uml.property  name="riverCode"
	 */
	public String getRiverCode() {
		return riverCode;
	}
	/**
	 * @param riverCode
	 * @uml.property  name="riverCode"
	 */
	public void setRiverCode(String riverCode) {
		this.riverCode = riverCode;
	}
	/**
	 * @return
	 * @uml.property  name="frDate"
	 */
	public String getFrDate() {
		return frDate;
	}
	/**
	 * @param frDate
	 * @uml.property  name="frDate"
	 */
	public void setFrDate(String frDate) {
		this.frDate = frDate;
	}
	/**
	 * @return
	 * @uml.property  name="toDate"
	 */
	public String getToDate() {
		return toDate;
	}
	/**
	 * @param toDate
	 * @uml.property  name="toDate"
	 */
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	/**
	 * @return
	 * @uml.property  name="searchQuarter"
	 */
	public String getSearchQuarter() {
		return searchQuarter;
	}
	/**
	 * @return
	 * @uml.property  name="baseTime"
	 */
	public String getBaseTime() {
		return baseTime;
	}
	/**
	 * @param baseTime
	 * @uml.property  name="baseTime"
	 */
	public void setBaseTime(String baseTime) {
		this.baseTime = baseTime;
	}
	/**
	 * @return
	 * @uml.property  name="bodValue"
	 */
	public String getBodValue() {
		return bodValue;
	}
	/**
	 * @param bodValue
	 * @uml.property  name="bodValue"
	 */
	public void setBodValue(String bodValue) {
		this.bodValue = bodValue;
	}
	/**
	 * @return
	 * @uml.property  name="bodFlow"
	 */
	public String getBodFlow() {
		return bodFlow;
	}
	/**
	 * @param bodFlow
	 * @uml.property  name="bodFlow"
	 */
	public void setBodFlow(String bodFlow) {
		this.bodFlow = bodFlow;
	}
	/**
	 * @return
	 * @uml.property  name="bodAvg"
	 */
	public String getBodAvg() {
		return bodAvg;
	}
	/**
	 * @param bodAvg
	 * @uml.property  name="bodAvg"
	 */
	public void setBodAvg(String bodAvg) {
		this.bodAvg = bodAvg;
	}
	/**
	 * @return
	 * @uml.property  name="susValue"
	 */
	public String getSusValue() {
		return susValue;
	}
	/**
	 * @param susValue
	 * @uml.property  name="susValue"
	 */
	public void setSusValue(String susValue) {
		this.susValue = susValue;
	}
	/**
	 * @return
	 * @uml.property  name="susFlow"
	 */
	public String getSusFlow() {
		return susFlow;
	}
	/**
	 * @param susFlow
	 * @uml.property  name="susFlow"
	 */
	public void setSusFlow(String susFlow) {
		this.susFlow = susFlow;
	}
	/**
	 * @return
	 * @uml.property  name="susAvg"
	 */
	public String getSusAvg() {
		return susAvg;
	}
	/**
	 * @param susAvg
	 * @uml.property  name="susAvg"
	 */
	public void setSusAvg(String susAvg) {
		this.susAvg = susAvg;
	}
	/**
	 * @return
	 * @uml.property  name="codValue"
	 */
	public String getCodValue() {
		return codValue;
	}
	/**
	 * @param codValue
	 * @uml.property  name="codValue"
	 */
	public void setCodValue(String codValue) {
		this.codValue = codValue;
	}
	/**
	 * @return
	 * @uml.property  name="codFlow"
	 */
	public String getCodFlow() {
		return codFlow;
	}
	/**
	 * @param codFlow
	 * @uml.property  name="codFlow"
	 */
	public void setCodFlow(String codFlow) {
		this.codFlow = codFlow;
	}
	/**
	 * @return
	 * @uml.property  name="codAvg"
	 */
	public String getCodAvg() {
		return codAvg;
	}
	/**
	 * @param codAvg
	 * @uml.property  name="codAvg"
	 */
	public void setCodAvg(String codAvg) {
		this.codAvg = codAvg;
	}
	/**
	 * @return
	 * @uml.property  name="tonValue"
	 */
	public String getTonValue() {
		return tonValue;
	}
	/**
	 * @param tonValue
	 * @uml.property  name="tonValue"
	 */
	public void setTonValue(String tonValue) {
		this.tonValue = tonValue;
	}
	/**
	 * @return
	 * @uml.property  name="tonFlow"
	 */
	public String getTonFlow() {
		return tonFlow;
	}
	/**
	 * @param tonFlow
	 * @uml.property  name="tonFlow"
	 */
	public void setTonFlow(String tonFlow) {
		this.tonFlow = tonFlow;
	}
	/**
	 * @return
	 * @uml.property  name="topValue"
	 */
	public String getTopValue() {
		return topValue;
	}
	/**
	 * @param topValue
	 * @uml.property  name="topValue"
	 */
	public void setTopValue(String topValue) {
		this.topValue = topValue;
	}
	/**
	 * @return
	 * @uml.property  name="topFlow"
	 */
	public String getTopFlow() {
		return topFlow;
	}
	/**
	 * @param topFlow
	 * @uml.property  name="topFlow"
	 */
	public void setTopFlow(String topFlow) {
		this.topFlow = topFlow;
	}
	/**
	 * @param searchQuarter
	 * @uml.property  name="searchQuarter"
	 */
	public void setSearchQuarter(String searchQuarter) {
		this.searchQuarter = searchQuarter;
	}
	/**
	 * @return
	 * @uml.property  name="searchMonth"
	 */
	public String getSearchMonth() {
		return searchMonth;
	}
	/**
	 * @param searchMonth
	 * @uml.property  name="searchMonth"
	 */
	public void setSearchMonth(String searchMonth) {
		this.searchMonth = searchMonth;
	}
	/**
	 * @return
	 * @uml.property  name="searchYear"
	 */
	public String getSearchYear() {
		return searchYear;
	}
	/**
	 * @param searchYear
	 * @uml.property  name="searchYear"
	 */
	public void setSearchYear(String searchYear) {
		this.searchYear = searchYear;
	}
	/**
	 * @return
	 * @uml.property  name="searchDay"
	 */
	public String getSearchDay() {
		return searchDay;
	}
	/**
	 * @param searchDay
	 * @uml.property  name="searchDay"
	 */
	public void setSearchDay(String searchDay) {
		this.searchDay = searchDay;
	}
	/**
	 * @return
	 * @uml.property  name="statsDate"
	 */
	public String getStatsDate() {
		return statsDate;
	}
	/**
	 * @param statsDate
	 * @uml.property  name="statsDate"
	 */
	public void setStatsDate(String statsDate) {
		this.statsDate = statsDate;
	}
	/**
	 * @return
	 * @uml.property  name="statKind"
	 */
	public String getStatKind() {
		return statKind;
	}
	/**
	 * @param statKind
	 * @uml.property  name="statKind"
	 */
	public void setStatKind(String statKind) {
		this.statKind = statKind;
	}
	/**
	 * @return
	 * @uml.property  name="gubun"
	 */
	public String getGubun() {
		return gubun;
	}
	/**
	 * @param gubun
	 * @uml.property  name="gubun"
	 */
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	/**
	 * @return
	 * @uml.property  name="statsTitle"
	 */
	public String getStatsTitle() {
		return statsTitle;
	}
	/**
	 * @param statsTitle
	 * @uml.property  name="statsTitle"
	 */
	public void setStatsTitle(String statsTitle) {
		this.statsTitle = statsTitle;
	}
	/**
	 * @return
	 * @uml.property  name="prevType"
	 */
	public String getPrevType() {
		return prevType;
	}
	/**
	 * @param prevType
	 * @uml.property  name="prevType"
	 */
	public void setPrevType(String prevType) {
		this.prevType = prevType;
	}
	/**
	 * @return
	 * @uml.property  name="warningCnt"
	 */
	public String getWarningCnt() {
		return warningCnt;
	}
	/**
	 * @param warningCnt
	 * @uml.property  name="warningCnt"
	 */
	public void setWarningCnt(String warningCnt) {
		this.warningCnt = warningCnt;
	}
	/**
	 * @return
	 * @uml.property  name="fldCnt"
	 */
	public String getFldCnt() {
		return fldCnt;
	}
	/**
	 * @param fldCnt
	 * @uml.property  name="fldCnt"
	 */
	public void setFldCnt(String fldCnt) {
		this.fldCnt = fldCnt;
	}
	/**
	 * @return
	 * @uml.property  name="smplCnt"
	 */
	public String getSmplCnt() {
		return smplCnt;
	}
	/**
	 * @param smplCnt
	 * @uml.property  name="smplCnt"
	 */
	public void setSmplCnt(String smplCnt) {
		this.smplCnt = smplCnt;
	}
	/**
	 * @return
	 * @uml.property  name="issCnt"
	 */
	public String getIssCnt() {
		return issCnt;
	}
	/**
	 * @param issCnt
	 * @uml.property  name="issCnt"
	 */
	public void setIssCnt(String issCnt) {
		this.issCnt = issCnt;
	}
	/**
	 * @return
	 * @uml.property  name="spreadCnt"
	 */
	public String getSpreadCnt() {
		return spreadCnt;
	}
	/**
	 * @param spreadCnt
	 * @uml.property  name="spreadCnt"
	 */
	public void setSpreadCnt(String spreadCnt) {
		this.spreadCnt = spreadCnt;
	}
	/**
	 * @return
	 * @uml.property  name="endCnt"
	 */
	public String getEndCnt() {
		return endCnt;
	}
	/**
	 * @param endCnt
	 * @uml.property  name="endCnt"
	 */
	public void setEndCnt(String endCnt) {
		this.endCnt = endCnt;
	}
	/**
	 * @return
	 * @uml.property  name="statsArea"
	 */
	public String getStatsArea() {
		return statsArea;
	}
	/**
	 * @param statsArea
	 * @uml.property  name="statsArea"
	 */
	public void setStatsArea(String statsArea) {
		this.statsArea = statsArea;
	}
	/**
	 * @return
	 * @uml.property  name="dmwtrCnt"
	 */
	public String getDmwtrCnt() {
		return dmwtrCnt;
	}
	/**
	 * @param dmwtrCnt
	 * @uml.property  name="dmwtrCnt"
	 */
	public void setDmwtrCnt(String dmwtrCnt) {
		this.dmwtrCnt = dmwtrCnt;
	}
	/**
	 * @return
	 * @uml.property  name="equRollCnt"
	 */
	public String getEquRollCnt() {
		return equRollCnt;
	}
	/**
	 * @param equRollCnt
	 * @uml.property  name="equRollCnt"
	 */
	public void setEquRollCnt(String equRollCnt) {
		this.equRollCnt = equRollCnt;
	}
	/**
	 * @return
	 * @uml.property  name="shipCnt"
	 */
	public String getShipCnt() {
		return shipCnt;
	}
	/**
	 * @param shipCnt
	 * @uml.property  name="shipCnt"
	 */
	public void setShipCnt(String shipCnt) {
		this.shipCnt = shipCnt;
	}
	/**
	 * @return
	 * @uml.property  name="shipPntCnt"
	 */
	public String getShipPntCnt() {
		return shipPntCnt;
	}
	/**
	 * @param shipPntCnt
	 * @uml.property  name="shipPntCnt"
	 */
	public void setShipPntCnt(String shipPntCnt) {
		this.shipPntCnt = shipPntCnt;
	}
	/**
	 * @return
	 * @uml.property  name="fldssnCnt"
	 */
	public String getFldssnCnt() {
		return fldssnCnt;
	}
	/**
	 * @param fldssnCnt
	 * @uml.property  name="fldssnCnt"
	 */
	public void setFldssnCnt(String fldssnCnt) {
		this.fldssnCnt = fldssnCnt;
	}
	/**
	 * @return
	 * @uml.property  name="tanktrCnt"
	 */
	public String getTanktrCnt() {
		return tanktrCnt;
	}
	/**
	 * @param tanktrCnt
	 * @uml.property  name="tanktrCnt"
	 */
	public void setTanktrCnt(String tanktrCnt) {
		this.tanktrCnt = tanktrCnt;
	}
	/**
	 * @return
	 * @uml.property  name="equEltnCnt"
	 */
	public String getEquEltnCnt() {
		return equEltnCnt;
	}
	/**
	 * @param equEltnCnt
	 * @uml.property  name="equEltnCnt"
	 */
	public void setEquEltnCnt(String equEltnCnt) {
		this.equEltnCnt = equEltnCnt;
	}
	/**
	 * @return
	 * @uml.property  name="ifplntCnt"
	 */
	public String getIfplntCnt() {
		return ifplntCnt;
	}
	/**
	 * @param ifplntCnt
	 * @uml.property  name="ifplntCnt"
	 */
	public void setIfplntCnt(String ifplntCnt) {
		this.ifplntCnt = ifplntCnt;
	}
	/**
	 * @return
	 * @uml.property  name="oilCnt"
	 */
	public String getOilCnt() {
		return oilCnt;
	}
	/**
	 * @param oilCnt
	 * @uml.property  name="oilCnt"
	 */
	public void setOilCnt(String oilCnt) {
		this.oilCnt = oilCnt;
	}
	/**
	 * @return
	 * @uml.property  name="phenolCnt"
	 */
	public String getPhenolCnt() {
		return phenolCnt;
	}
	/**
	 * @param phenolCnt
	 * @uml.property  name="phenolCnt"
	 */
	public void setPhenolCnt(String phenolCnt) {
		this.phenolCnt = phenolCnt;
	}
	/**
	 * @return
	 * @uml.property  name="toxicCnt"
	 */
	public String getToxicCnt() {
		return toxicCnt;
	}
	/**
	 * @param toxicCnt
	 * @uml.property  name="toxicCnt"
	 */
	public void setToxicCnt(String toxicCnt) {
		this.toxicCnt = toxicCnt;
	}
	/**
	 * @return
	 * @uml.property  name="fshdieCnt"
	 */
	public String getFshdieCnt() {
		return fshdieCnt;
	}
	/**
	 * @param fshdieCnt
	 * @uml.property  name="fshdieCnt"
	 */
	public void setFshdieCnt(String fshdieCnt) {
		this.fshdieCnt = fshdieCnt;
	}
	/**
	 * @return
	 * @uml.property  name="etcCnt"
	 */
	public String getEtcCnt() {
		return etcCnt;
	}
	/**
	 * @param etcCnt
	 * @uml.property  name="etcCnt"
	 */
	public void setEtcCnt(String etcCnt) {
		this.etcCnt = etcCnt;
	}
	/**
	 * @return
	 * @uml.property  name="ocDiv"
	 */
	public String getOcDiv() {
		return ocDiv;
	}
	/**
	 * @param ocDiv
	 * @uml.property  name="ocDiv"
	 */
	public void setOcDiv(String ocDiv) {
		this.ocDiv = ocDiv;
	}
	/**
	 * @return
	 * @uml.property  name="ocPointDiv"
	 */
	public String getOcPointDiv() {
		return ocPointDiv;
	}
	/**
	 * @param ocPointDiv
	 * @uml.property  name="ocPointDiv"
	 */
	public void setOcPointDiv(String ocPointDiv) {
		this.ocPointDiv = ocPointDiv;
	}
	/**
	 * @return
	 * @uml.property  name="atnCnt"
	 */
	public String getAtnCnt() {
		return atnCnt;
	}
	/**
	 * @param atnCnt
	 * @uml.property  name="atnCnt"
	 */
	public void setAtnCnt(String atnCnt) {
		this.atnCnt = atnCnt;
	}
	/**
	 * @return
	 * @uml.property  name="catCnt"
	 */
	public String getCatCnt() {
		return catCnt;
	}
	/**
	 * @param catCnt
	 * @uml.property  name="catCnt"
	 */
	public void setCatCnt(String catCnt) {
		this.catCnt = catCnt;
	}
	/**
	 * @return
	 * @uml.property  name="alertCnt"
	 */
	public String getAlertCnt() {
		return alertCnt;
	}
	/**
	 * @param alertCnt
	 * @uml.property  name="alertCnt"
	 */
	public void setAlertCnt(String alertCnt) {
		this.alertCnt = alertCnt;
	}
	/**
	 * @return
	 * @uml.property  name="srsCnt"
	 */
	public String getSrsCnt() {
		return srsCnt;
	}
	/**
	 * @param srsCnt
	 * @uml.property  name="srsCnt"
	 */
	public void setSrsCnt(String srsCnt) {
		this.srsCnt = srsCnt;
	}
	/**
	 * @return
	 * @uml.property  name="firstCnt"
	 */
	public String getFirstCnt() {
		return firstCnt;
	}
	/**
	 * @param firstCnt
	 * @uml.property  name="firstCnt"
	 */
	public void setFirstCnt(String firstCnt) {
		this.firstCnt = firstCnt;
	}
	/**
	 * @return
	 * @uml.property  name="time3Cnt"
	 */
	public String getTime3Cnt() {
		return time3Cnt;
	}
	/**
	 * @param time3Cnt
	 * @uml.property  name="time3Cnt"
	 */
	public void setTime3Cnt(String time3Cnt) {
		this.time3Cnt = time3Cnt;
	}
	/**
	 * @return
	 * @uml.property  name="time6Cnt"
	 */
	public String getTime6Cnt() {
		return time6Cnt;
	}
	/**
	 * @param time6Cnt
	 * @uml.property  name="time6Cnt"
	 */
	public void setTime6Cnt(String time6Cnt) {
		this.time6Cnt = time6Cnt;
	}
	/**
	 * @return
	 * @uml.property  name="time12Cnt"
	 */
	public String getTime12Cnt() {
		return time12Cnt;
	}
	/**
	 * @param time12Cnt
	 * @uml.property  name="time12Cnt"
	 */
	public void setTime12Cnt(String time12Cnt) {
		this.time12Cnt = time12Cnt;
	}
	/**
	 * @return
	 * @uml.property  name="acsCnt"
	 */
	public String getAcsCnt() {
		return acsCnt;
	}
	/**
	 * @param acsCnt
	 * @uml.property  name="acsCnt"
	 */
	public void setAcsCnt(String acsCnt) {
		this.acsCnt = acsCnt;
	}
	/**
	 * @return
	 * @uml.property  name="smsCnt"
	 */
	public String getSmsCnt() {
		return smsCnt;
	}
	/**
	 * @param smsCnt
	 * @uml.property  name="smsCnt"
	 */
	public void setSmsCnt(String smsCnt) {
		this.smsCnt = smsCnt;
	}
	/**
	 * @return
	 * @uml.property  name="year"
	 */
	public String getYear() {
		return year;
	}
	/**
	 * @param year
	 * @uml.property  name="year"
	 */
	public void setYear(String year) {
		this.year = year;
	}
	/**
	 * @return
	 * @uml.property  name="day"
	 */
	public String getDay() {
		return day;
	}
	/**
	 * @param day
	 * @uml.property  name="day"
	 */
	public void setDay(String day) {
		this.day = day;
	}
	/**
	 * @return
	 * @uml.property  name="actWeather"
	 */
	public String getActWeather() {
		return actWeather;
	}
	/**
	 * @param actWeather
	 * @uml.property  name="actWeather"
	 */
	public void setActWeather(String actWeather) {
		this.actWeather = actWeather;
	}
	/**
	 * @return
	 * @uml.property  name="actTraning"
	 */
	public String getActTraning() {
		return actTraning;
	}
	/**
	 * @param actTraning
	 * @uml.property  name="actTraning"
	 */
	public void setActTraning(String actTraning) {
		this.actTraning = actTraning;
	}
	/**
	 * @return
	 * @uml.property  name="actEmc"
	 */
	public String getActEmc() {
		return actEmc;
	}
	/**
	 * @param actEmc
	 * @uml.property  name="actEmc"
	 */
	public void setActEmc(String actEmc) {
		this.actEmc = actEmc;
	}
	/**
	 * @return
	 * @uml.property  name="actChk"
	 */
	public String getActChk() {
		return actChk;
	}
	/**
	 * @param actChk
	 * @uml.property  name="actChk"
	 */
	public void setActChk(String actChk) {
		this.actChk = actChk;
	}
	/**
	 * @return
	 * @uml.property  name="actOther"
	 */
	public String getActOther() {
		return actOther;
	}
	/**
	 * @param actOther
	 * @uml.property  name="actOther"
	 */
	public void setActOther(String actOther) {
		this.actOther = actOther;
	}
	/**
	 * @return
	 * @uml.property  name="riverId"
	 */
	public String getRiverId() {
		return riverId;
	}
	/**
	 * @param riverId
	 * @uml.property  name="riverId"
	 */
	public void setRiverId(String riverId) {
		this.riverId = riverId;
	}
	/**
	 * @return
	 * @uml.property  name="riverName"
	 */
	public String getRiverName() {
		return riverName;
	}
	/**
	 * @param riverName
	 * @uml.property  name="riverName"
	 */
	public void setRiverName(String riverName) {
		this.riverName = riverName;
	}
	/**
	 * @return
	 * @uml.property  name="factCode"
	 */
	public String getFactCode() {
		return factCode;
	}
	/**
	 * @param factCode
	 * @uml.property  name="factCode"
	 */
	public void setFactCode(String factCode) {
		this.factCode = factCode;
	}
	/**
	 * @return
	 * @uml.property  name="factName"
	 */
	public String getFactName() {
		return factName;
	}
	/**
	 * @param factName
	 * @uml.property  name="factName"
	 */
	public void setFactName(String factName) {
		this.factName = factName;
	}
	/**
	 * @return
	 * @uml.property  name="branchNo"
	 */
	public String getBranchNo() {
		return branchNo;
	}
	/**
	 * @param branchNo
	 * @uml.property  name="branchNo"
	 */
	public void setBranchNo(String branchNo) {
		this.branchNo = branchNo;
	}
	/**
	 * @return
	 * @uml.property  name="timeFrm"
	 */
	public String getTimeFrm() {
		return timeFrm;
	}
	/**
	 * @param timeFrm
	 * @uml.property  name="timeFrm"
	 */
	public void setTimeFrm(String timeFrm) {
		this.timeFrm = timeFrm;
	}
	/**
	 * @return
	 * @uml.property  name="time"
	 */
	public String getTime() {
		return time;
	}
	/**
	 * @param time
	 * @uml.property  name="time"
	 */
	public void setTime(String time) {
		this.time = time;
	}
	/**
	 * @return
	 * @uml.property  name="itemCode"
	 */
	public String getItemCode() {
		return itemCode;
	}
	/**
	 * @param itemCode
	 * @uml.property  name="itemCode"
	 */
	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}
	/**
	 * @return
	 * @uml.property  name="itemName"
	 */
	public String getItemName() {
		return itemName;
	}
	/**
	 * @param itemName
	 * @uml.property  name="itemName"
	 */
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	/**
	 * @return
	 * @uml.property  name="vlAvg"
	 */
	public String getVlAvg() {
		return vlAvg;
	}
	/**
	 * @param vlAvg
	 * @uml.property  name="vlAvg"
	 */
	public void setVlAvg(String vlAvg) {
		this.vlAvg = vlAvg;
	}
	/**
	 * @return
	 * @uml.property  name="vlStrAvg"
	 */
	public String getVlStrAvg() {
		return vlStrAvg;
	}
	/**
	 * @param vlStrAvg
	 * @uml.property  name="vlStrAvg"
	 */
	public void setVlStrAvg(String vlStrAvg) {
		this.vlStrAvg = vlStrAvg;
	}
	/**
	 * @return
	 * @uml.property  name="vlMax"
	 */
	public String getVlMax() {
		return vlMax;
	}
	/**
	 * @param vlMax
	 * @uml.property  name="vlMax"
	 */
	public void setVlMax(String vlMax) {
		this.vlMax = vlMax;
	}
	/**
	 * @return
	 * @uml.property  name="vlStrMax"
	 */
	public String getVlStrMax() {
		return vlStrMax;
	}
	/**
	 * @param vlStrMax
	 * @uml.property  name="vlStrMax"
	 */
	public void setVlStrMax(String vlStrMax) {
		this.vlStrMax = vlStrMax;
	}
	/**
	 * @return
	 * @uml.property  name="vlMin"
	 */
	public String getVlMin() {
		return vlMin;
	}
	/**
	 * @param vlMin
	 * @uml.property  name="vlMin"
	 */
	public void setVlMin(String vlMin) {
		this.vlMin = vlMin;
	}
	/**
	 * @return
	 * @uml.property  name="vlStrMin"
	 */
	public String getVlStrMin() {
		return vlStrMin;
	}
	/**
	 * @param vlStrMin
	 * @uml.property  name="vlStrMin"
	 */
	public void setVlStrMin(String vlStrMin) {
		this.vlStrMin = vlStrMin;
	}
	/**
	 * @return
	 * @uml.property  name="val1"
	 */
	public String getVal1() {
		return val1;
	}
	/**
	 * @param val1
	 * @uml.property  name="val1"
	 */
	public void setVal1(String val1) {
		this.val1 = val1;
	}
	/**
	 * @return
	 * @uml.property  name="val2"
	 */
	public String getVal2() {
		return val2;
	}
	/**
	 * @param val2
	 * @uml.property  name="val2"
	 */
	public void setVal2(String val2) {
		this.val2 = val2;
	}
	/**
	 * @return
	 * @uml.property  name="val3"
	 */
	public String getVal3() {
		return val3;
	}
	/**
	 * @param val3
	 * @uml.property  name="val3"
	 */
	public void setVal3(String val3) {
		this.val3 = val3;
	}
	/**
	 * @return
	 * @uml.property  name="val4"
	 */
	public String getVal4() {
		return val4;
	}
	/**
	 * @param val4
	 * @uml.property  name="val4"
	 */
	public void setVal4(String val4) {
		this.val4 = val4;
	}
	/**
	 * @return
	 * @uml.property  name="val5"
	 */
	public String getVal5() {
		return val5;
	}
	/**
	 * @param val5
	 * @uml.property  name="val5"
	 */
	public void setVal5(String val5) {
		this.val5 = val5;
	}
	/**
	 * @return
	 * @uml.property  name="system"
	 */
	public String getSystem() {
		return system;
	}
	/**
	 * @param system
	 * @uml.property  name="system"
	 */
	public void setSystem(String system) {
		this.system = system;
	}
	/**
	 * @return
	 * @uml.property  name="month"
	 */
	public String getMonth() {
		return month;
	}
	/**
	 * @param month
	 * @uml.property  name="month"
	 */
	public void setMonth(String month) {
		this.month = month;
	}
	/**
	 * @return
	 * @uml.property  name="quarter"
	 */
	public String getQuarter() {
		return quarter;
	}
	/**
	 * @param quarter
	 * @uml.property  name="quarter"
	 */
	public void setQuarter(String quarter) {
		this.quarter = quarter;
	}
	/**
	 * @return
	 * @uml.property  name="isCompare"
	 */
	public String getIsCompare() {
		return isCompare;
	}
	/**
	 * @param isCompare
	 * @uml.property  name="isCompare"
	 */
	public void setIsCompare(String isCompare) {
		this.isCompare = isCompare;
	}
	/**
	 * @return
	 * @uml.property  name="startMonth"
	 */
	public String getStartMonth() {
		return startMonth;
	}
	/**
	 * @param startMonth
	 * @uml.property  name="startMonth"
	 */
	public void setStartMonth(String startMonth) {
		this.startMonth = startMonth;
	}
	/**
	 * @return
	 * @uml.property  name="isCRow"
	 */
	public String getIsCRow() {
		return isCRow;
	}
	/**
	 * @param isCRow
	 * @uml.property  name="isCRow"
	 */
	public void setIsCRow(String isCRow) {
		this.isCRow = isCRow;
	}
	/**
	 * @return
	 * @uml.property  name="riverDiv"
	 */
	public String getRiverDiv() {
		return riverDiv;
	}
	/**
	 * @param riverDiv
	 * @uml.property  name="riverDiv"
	 */
	public void setRiverDiv(String riverDiv) {
		this.riverDiv = riverDiv;
	}
	/**
	 * @return
	 * @uml.property  name="startDate"
	 */
	public String getStartDate() {
		return startDate;
	}
	/**
	 * @param startDate
	 * @uml.property  name="startDate"
	 */
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	/**
	 * @return
	 * @uml.property  name="statsDiv"
	 */
	public String getStatsDiv() {
		return statsDiv;
	}
	/**
	 * @param statsDiv
	 * @uml.property  name="statsDiv"
	 */
	public void setStatsDiv(String statsDiv) {
		this.statsDiv = statsDiv;
	}
	/**
	 * @return
	 * @uml.property  name="factNo"
	 */
	public String getFactNo() {
		return factNo;
	}
	/**
	 * @param factNo
	 * @uml.property  name="factNo"
	 */
	public void setFactNo(String factNo) {
		this.factNo = factNo;
	}
	/**
	 * @return
	 * @uml.property  name="regName"
	 */
	public String getRegName() {
		return regName;
	}
	/**
	 * @param regName
	 * @uml.property  name="regName"
	 */
	public void setRegName(String regName) {
		this.regName = regName;
	}
	/**
	 * @return
	 * @uml.property  name="sysKind"
	 */
	public String getSysKind() {
		return sysKind;
	}
	/**
	 * @param sysKind
	 * @uml.property  name="sysKind"
	 */
	public void setSysKind(String sysKind) {
		this.sysKind = sysKind;
	}
	/**
	 * @return
	 * @uml.property  name="sysName"
	 */
	public String getSysName() {
		return sysName;
	}
	/**
	 * @param sysName
	 * @uml.property  name="sysName"
	 */
	public void setSysName(String sysName) {
		this.sysName = sysName;
	}
	/**
	 * @return
	 * @uml.property  name="factCode2"
	 */
	public String getFactCode2() {
		return factCode2;
	}
	/**
	 * @param factCode2
	 * @uml.property  name="factCode2"
	 */
	public void setFactCode2(String factCode2) {
		this.factCode2 = factCode2;
	}
	/**
	 * @return
	 * @uml.property  name="branchNo2"
	 */
	public String getBranchNo2() {
		return branchNo2;
	}
	/**
	 * @param branchNo2
	 * @uml.property  name="branchNo2"
	 */
	public void setBranchNo2(String branchNo2) {
		this.branchNo2 = branchNo2;
	}
	/**
	 * @return
	 * @uml.property  name="branchName"
	 */
	public String getBranchName() {
		return branchName;
	}
	/**
	 * @param branchName
	 * @uml.property  name="branchName"
	 */
	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}
	/**
	 * @return
	 * @uml.property  name="recvRt"
	 */
	public String getRecvRt() {
		return recvRt;
	}
	/**
	 * @param recvRt
	 * @uml.property  name="recvRt"
	 */
	public void setRecvRt(String recvRt) {
		this.recvRt = recvRt;
	}
	/**
	 * @return
	 * @uml.property  name="conMax"
	 */
	public String getConMax() {
		return conMax;
	}
	/**
	 * @param conMax
	 * @uml.property  name="conMax"
	 */
	public void setConMax(String conMax) {
		this.conMax = conMax;
	}
	/**
	 * @return
	 * @uml.property  name="conMin"
	 */
	public String getConMin() {
		return conMin;
	}
	/**
	 * @param conMin
	 * @uml.property  name="conMin"
	 */
	public void setConMin(String conMin) {
		this.conMin = conMin;
	}
	/**
	 * @return
	 * @uml.property  name="conAvg"
	 */
	public String getConAvg() {
		return conAvg;
	}
	/**
	 * @param conAvg
	 * @uml.property  name="conAvg"
	 */
	public void setConAvg(String conAvg) {
		this.conAvg = conAvg;
	}
	/**
	 * @return
	 * @uml.property  name="dowMax"
	 */
	public String getDowMax() {
		return dowMax;
	}
	/**
	 * @param dowMax
	 * @uml.property  name="dowMax"
	 */
	public void setDowMax(String dowMax) {
		this.dowMax = dowMax;
	}
	/**
	 * @return
	 * @uml.property  name="dowMin"
	 */
	public String getDowMin() {
		return dowMin;
	}
	/**
	 * @param dowMin
	 * @uml.property  name="dowMin"
	 */
	public void setDowMin(String dowMin) {
		this.dowMin = dowMin;
	}
	/**
	 * @return
	 * @uml.property  name="dowAvg"
	 */
	public String getDowAvg() {
		return dowAvg;
	}
	/**
	 * @param dowAvg
	 * @uml.property  name="dowAvg"
	 */
	public void setDowAvg(String dowAvg) {
		this.dowAvg = dowAvg;
	}
	/**
	 * @return
	 * @uml.property  name="tmpMax"
	 */
	public String getTmpMax() {
		return tmpMax;
	}
	/**
	 * @param tmpMax
	 * @uml.property  name="tmpMax"
	 */
	public void setTmpMax(String tmpMax) {
		this.tmpMax = tmpMax;
	}
	/**
	 * @return
	 * @uml.property  name="tmpMin"
	 */
	public String getTmpMin() {
		return tmpMin;
	}
	/**
	 * @param tmpMin
	 * @uml.property  name="tmpMin"
	 */
	public void setTmpMin(String tmpMin) {
		this.tmpMin = tmpMin;
	}
	/**
	 * @return
	 * @uml.property  name="tmpAvg"
	 */
	public String getTmpAvg() {
		return tmpAvg;
	}
	/**
	 * @param tmpAvg
	 * @uml.property  name="tmpAvg"
	 */
	public void setTmpAvg(String tmpAvg) {
		this.tmpAvg = tmpAvg;
	}
	/**
	 * @return
	 * @uml.property  name="phyMax"
	 */
	public String getPhyMax() {
		return phyMax;
	}
	/**
	 * @param phyMax
	 * @uml.property  name="phyMax"
	 */
	public void setPhyMax(String phyMax) {
		this.phyMax = phyMax;
	}
	/**
	 * @return
	 * @uml.property  name="phyMin"
	 */
	public String getPhyMin() {
		return phyMin;
	}
	/**
	 * @param phyMin
	 * @uml.property  name="phyMin"
	 */
	public void setPhyMin(String phyMin) {
		this.phyMin = phyMin;
	}
	/**
	 * @return
	 * @uml.property  name="phyAvg"
	 */
	public String getPhyAvg() {
		return phyAvg;
	}
	/**
	 * @param phyAvg
	 * @uml.property  name="phyAvg"
	 */
	public void setPhyAvg(String phyAvg) {
		this.phyAvg = phyAvg;
	}
	/**
	 * @return
	 * @uml.property  name="tmp1Max"
	 */
	public String getTmp1Max() {
		return tmp1Max;
	}
	/**
	 * @param tmp1Max
	 * @uml.property  name="tmp1Max"
	 */
	public void setTmp1Max(String tmp1Max) {
		this.tmp1Max = tmp1Max;
	}
	/**
	 * @return
	 * @uml.property  name="tmp1Min"
	 */
	public String getTmp1Min() {
		return tmp1Min;
	}
	/**
	 * @param tmp1Min
	 * @uml.property  name="tmp1Min"
	 */
	public void setTmp1Min(String tmp1Min) {
		this.tmp1Min = tmp1Min;
	}
	/**
	 * @return
	 * @uml.property  name="tmp1Avg"
	 */
	public String getTmp1Avg() {
		return tmp1Avg;
	}
	/**
	 * @param tmp1Avg
	 * @uml.property  name="tmp1Avg"
	 */
	public void setTmp1Avg(String tmp1Avg) {
		this.tmp1Avg = tmp1Avg;
	}
	/**
	 * @return
	 * @uml.property  name="tmp2Max"
	 */
	public String getTmp2Max() {
		return tmp2Max;
	}
	/**
	 * @param tmp2Max
	 * @uml.property  name="tmp2Max"
	 */
	public void setTmp2Max(String tmp2Max) {
		this.tmp2Max = tmp2Max;
	}
	/**
	 * @return
	 * @uml.property  name="tmp2Min"
	 */
	public String getTmp2Min() {
		return tmp2Min;
	}
	/**
	 * @param tmp2Min
	 * @uml.property  name="tmp2Min"
	 */
	public void setTmp2Min(String tmp2Min) {
		this.tmp2Min = tmp2Min;
	}
	/**
	 * @return
	 * @uml.property  name="tmp2Avg"
	 */
	public String getTmp2Avg() {
		return tmp2Avg;
	}
	/**
	 * @param tmp2Avg
	 * @uml.property  name="tmp2Avg"
	 */
	public void setTmp2Avg(String tmp2Avg) {
		this.tmp2Avg = tmp2Avg;
	}
	/**
	 * @return
	 * @uml.property  name="phy1Max"
	 */
	public String getPhy1Max() {
		return phy1Max;
	}
	/**
	 * @param phy1Max
	 * @uml.property  name="phy1Max"
	 */
	public void setPhy1Max(String phy1Max) {
		this.phy1Max = phy1Max;
	}
	/**
	 * @return
	 * @uml.property  name="phy1Min"
	 */
	public String getPhy1Min() {
		return phy1Min;
	}
	/**
	 * @param phy1Min
	 * @uml.property  name="phy1Min"
	 */
	public void setPhy1Min(String phy1Min) {
		this.phy1Min = phy1Min;
	}
	/**
	 * @return
	 * @uml.property  name="phy1Avg"
	 */
	public String getPhy1Avg() {
		return phy1Avg;
	}
	/**
	 * @param phy1Avg
	 * @uml.property  name="phy1Avg"
	 */
	public void setPhy1Avg(String phy1Avg) {
		this.phy1Avg = phy1Avg;
	}
	/**
	 * @return
	 * @uml.property  name="phy2Max"
	 */
	public String getPhy2Max() {
		return phy2Max;
	}
	/**
	 * @param phy2Max
	 * @uml.property  name="phy2Max"
	 */
	public void setPhy2Max(String phy2Max) {
		this.phy2Max = phy2Max;
	}
	/**
	 * @return
	 * @uml.property  name="phy2Min"
	 */
	public String getPhy2Min() {
		return phy2Min;
	}
	/**
	 * @param phy2Min
	 * @uml.property  name="phy2Min"
	 */
	public void setPhy2Min(String phy2Min) {
		this.phy2Min = phy2Min;
	}
	/**
	 * @return
	 * @uml.property  name="phy2Avg"
	 */
	public String getPhy2Avg() {
		return phy2Avg;
	}
	/**
	 * @param phy2Avg
	 * @uml.property  name="phy2Avg"
	 */
	public void setPhy2Avg(String phy2Avg) {
		this.phy2Avg = phy2Avg;
	}
	/**
	 * @return
	 * @uml.property  name="dow1Max"
	 */
	public String getDow1Max() {
		return dow1Max;
	}
	/**
	 * @param dow1Max
	 * @uml.property  name="dow1Max"
	 */
	public void setDow1Max(String dow1Max) {
		this.dow1Max = dow1Max;
	}
	/**
	 * @return
	 * @uml.property  name="dow1Min"
	 */
	public String getDow1Min() {
		return dow1Min;
	}
	/**
	 * @param dow1Min
	 * @uml.property  name="dow1Min"
	 */
	public void setDow1Min(String dow1Min) {
		this.dow1Min = dow1Min;
	}
	/**
	 * @return
	 * @uml.property  name="dow1Avg"
	 */
	public String getDow1Avg() {
		return dow1Avg;
	}
	/**
	 * @param dow1Avg
	 * @uml.property  name="dow1Avg"
	 */
	public void setDow1Avg(String dow1Avg) {
		this.dow1Avg = dow1Avg;
	}
	/**
	 * @return
	 * @uml.property  name="dow2Max"
	 */
	public String getDow2Max() {
		return dow2Max;
	}
	/**
	 * @param dow2Max
	 * @uml.property  name="dow2Max"
	 */
	public void setDow2Max(String dow2Max) {
		this.dow2Max = dow2Max;
	}
	/**
	 * @return
	 * @uml.property  name="dow2Min"
	 */
	public String getDow2Min() {
		return dow2Min;
	}
	/**
	 * @param dow2Min
	 * @uml.property  name="dow2Min"
	 */
	public void setDow2Min(String dow2Min) {
		this.dow2Min = dow2Min;
	}
	/**
	 * @return
	 * @uml.property  name="dow2Avg"
	 */
	public String getDow2Avg() {
		return dow2Avg;
	}
	/**
	 * @param dow2Avg
	 * @uml.property  name="dow2Avg"
	 */
	public void setDow2Avg(String dow2Avg) {
		this.dow2Avg = dow2Avg;
	}
	/**
	 * @return
	 * @uml.property  name="con1Max"
	 */
	public String getCon1Max() {
		return con1Max;
	}
	/**
	 * @param con1Max
	 * @uml.property  name="con1Max"
	 */
	public void setCon1Max(String con1Max) {
		this.con1Max = con1Max;
	}
	/**
	 * @return
	 * @uml.property  name="con1Min"
	 */
	public String getCon1Min() {
		return con1Min;
	}
	/**
	 * @param con1Min
	 * @uml.property  name="con1Min"
	 */
	public void setCon1Min(String con1Min) {
		this.con1Min = con1Min;
	}
	/**
	 * @return
	 * @uml.property  name="con1Avg"
	 */
	public String getCon1Avg() {
		return con1Avg;
	}
	/**
	 * @param con1Avg
	 * @uml.property  name="con1Avg"
	 */
	public void setCon1Avg(String con1Avg) {
		this.con1Avg = con1Avg;
	}
	/**
	 * @return
	 * @uml.property  name="con2Max"
	 */
	public String getCon2Max() {
		return con2Max;
	}
	/**
	 * @param con2Max
	 * @uml.property  name="con2Max"
	 */
	public void setCon2Max(String con2Max) {
		this.con2Max = con2Max;
	}
	/**
	 * @return
	 * @uml.property  name="con2Min"
	 */
	public String getCon2Min() {
		return con2Min;
	}
	/**
	 * @param con2Min
	 * @uml.property  name="con2Min"
	 */
	public void setCon2Min(String con2Min) {
		this.con2Min = con2Min;
	}
	/**
	 * @return
	 * @uml.property  name="con2Avg"
	 */
	public String getCon2Avg() {
		return con2Avg;
	}
	/**
	 * @param con2Avg
	 * @uml.property  name="con2Avg"
	 */
	public void setCon2Avg(String con2Avg) {
		this.con2Avg = con2Avg;
	}
	/**
	 * @return
	 * @uml.property  name="turMax"
	 */
	public String getTurMax() {
		return turMax;
	}
	/**
	 * @param turMax
	 * @uml.property  name="turMax"
	 */
	public void setTurMax(String turMax) {
		this.turMax = turMax;
	}
	/**
	 * @return
	 * @uml.property  name="turMin"
	 */
	public String getTurMin() {
		return turMin;
	}
	/**
	 * @param turMin
	 * @uml.property  name="turMin"
	 */
	public void setTurMin(String turMin) {
		this.turMin = turMin;
	}
	/**
	 * @return
	 * @uml.property  name="turAvg"
	 */
	public String getTurAvg() {
		return turAvg;
	}
	/**
	 * @param turAvg
	 * @uml.property  name="turAvg"
	 */
	public void setTurAvg(String turAvg) {
		this.turAvg = turAvg;
	}
	/**
	 * @return
	 * @uml.property  name="impMax"
	 */
	public String getImpMax() {
		return impMax;
	}
	/**
	 * @param impMax
	 * @uml.property  name="impMax"
	 */
	public void setImpMax(String impMax) {
		this.impMax = impMax;
	}
	/**
	 * @return
	 * @uml.property  name="impMin"
	 */
	public String getImpMin() {
		return impMin;
	}
	/**
	 * @param impMin
	 * @uml.property  name="impMin"
	 */
	public void setImpMin(String impMin) {
		this.impMin = impMin;
	}
	/**
	 * @return
	 * @uml.property  name="impAvg"
	 */
	public String getImpAvg() {
		return impAvg;
	}
	/**
	 * @param impAvg
	 * @uml.property  name="impAvg"
	 */
	public void setImpAvg(String impAvg) {
		this.impAvg = impAvg;
	}
	/**
	 * @return
	 * @uml.property  name="limMax"
	 */
	public String getLimMax() {
		return limMax;
	}
	/**
	 * @param limMax
	 * @uml.property  name="limMax"
	 */
	public void setLimMax(String limMax) {
		this.limMax = limMax;
	}
	/**
	 * @return
	 * @uml.property  name="limMin"
	 */
	public String getLimMin() {
		return limMin;
	}
	/**
	 * @param limMin
	 * @uml.property  name="limMin"
	 */
	public void setLimMin(String limMin) {
		this.limMin = limMin;
	}
	/**
	 * @return
	 * @uml.property  name="limAvg"
	 */
	public String getLimAvg() {
		return limAvg;
	}
	/**
	 * @param limAvg
	 * @uml.property  name="limAvg"
	 */
	public void setLimAvg(String limAvg) {
		this.limAvg = limAvg;
	}
	/**
	 * @return
	 * @uml.property  name="rimMax"
	 */
	public String getRimMax() {
		return rimMax;
	}
	/**
	 * @param rimMax
	 * @uml.property  name="rimMax"
	 */
	public void setRimMax(String rimMax) {
		this.rimMax = rimMax;
	}
	/**
	 * @return
	 * @uml.property  name="rimMin"
	 */
	public String getRimMin() {
		return rimMin;
	}
	/**
	 * @param rimMin
	 * @uml.property  name="rimMin"
	 */
	public void setRimMin(String rimMin) {
		this.rimMin = rimMin;
	}
	/**
	 * @return
	 * @uml.property  name="rimAvg"
	 */
	public String getRimAvg() {
		return rimAvg;
	}
	/**
	 * @param rimAvg
	 * @uml.property  name="rimAvg"
	 */
	public void setRimAvg(String rimAvg) {
		this.rimAvg = rimAvg;
	}
	/**
	 * @return
	 * @uml.property  name="ltxMax"
	 */
	public String getLtxMax() {
		return ltxMax;
	}
	/**
	 * @param ltxMax
	 * @uml.property  name="ltxMax"
	 */
	public void setLtxMax(String ltxMax) {
		this.ltxMax = ltxMax;
	}
	/**
	 * @return
	 * @uml.property  name="ltxMin"
	 */
	public String getLtxMin() {
		return ltxMin;
	}
	/**
	 * @param ltxMin
	 * @uml.property  name="ltxMin"
	 */
	public void setLtxMin(String ltxMin) {
		this.ltxMin = ltxMin;
	}
	/**
	 * @return
	 * @uml.property  name="ltxAvg"
	 */
	public String getLtxAvg() {
		return ltxAvg;
	}
	/**
	 * @param ltxAvg
	 * @uml.property  name="ltxAvg"
	 */
	public void setLtxAvg(String ltxAvg) {
		this.ltxAvg = ltxAvg;
	}
	/**
	 * @return
	 * @uml.property  name="rtxMax"
	 */
	public String getRtxMax() {
		return rtxMax;
	}
	/**
	 * @param rtxMax
	 * @uml.property  name="rtxMax"
	 */
	public void setRtxMax(String rtxMax) {
		this.rtxMax = rtxMax;
	}
	/**
	 * @return
	 * @uml.property  name="rtxMin"
	 */
	public String getRtxMin() {
		return rtxMin;
	}
	/**
	 * @param rtxMin
	 * @uml.property  name="rtxMin"
	 */
	public void setRtxMin(String rtxMin) {
		this.rtxMin = rtxMin;
	}
	/**
	 * @return
	 * @uml.property  name="rtxAvg"
	 */
	public String getRtxAvg() {
		return rtxAvg;
	}
	/**
	 * @param rtxAvg
	 * @uml.property  name="rtxAvg"
	 */
	public void setRtxAvg(String rtxAvg) {
		this.rtxAvg = rtxAvg;
	}
	/**
	 * @return
	 * @uml.property  name="toxMax"
	 */
	public String getToxMax() {
		return toxMax;
	}
	/**
	 * @param toxMax
	 * @uml.property  name="toxMax"
	 */
	public void setToxMax(String toxMax) {
		this.toxMax = toxMax;
	}
	/**
	 * @return
	 * @uml.property  name="toxMin"
	 */
	public String getToxMin() {
		return toxMin;
	}
	/**
	 * @param toxMin
	 * @uml.property  name="toxMin"
	 */
	public void setToxMin(String toxMin) {
		this.toxMin = toxMin;
	}
	/**
	 * @return
	 * @uml.property  name="toxAvg"
	 */
	public String getToxAvg() {
		return toxAvg;
	}
	/**
	 * @param toxAvg
	 * @uml.property  name="toxAvg"
	 */
	public void setToxAvg(String toxAvg) {
		this.toxAvg = toxAvg;
	}
	/**
	 * @return
	 * @uml.property  name="evnMax"
	 */
	public String getEvnMax() {
		return evnMax;
	}
	/**
	 * @param evnMax
	 * @uml.property  name="evnMax"
	 */
	public void setEvnMax(String evnMax) {
		this.evnMax = evnMax;
	}
	/**
	 * @return
	 * @uml.property  name="evnMin"
	 */
	public String getEvnMin() {
		return evnMin;
	}
	/**
	 * @param evnMin
	 * @uml.property  name="evnMin"
	 */
	public void setEvnMin(String evnMin) {
		this.evnMin = evnMin;
	}
	/**
	 * @return
	 * @uml.property  name="evnAvg"
	 */
	public String getEvnAvg() {
		return evnAvg;
	}
	/**
	 * @param evnAvg
	 * @uml.property  name="evnAvg"
	 */
	public void setEvnAvg(String evnAvg) {
		this.evnAvg = evnAvg;
	}
	/**
	 * @return
	 * @uml.property  name="tofMax"
	 */
	public String getTofMax() {
		return tofMax;
	}
	/**
	 * @param tofMax
	 * @uml.property  name="tofMax"
	 */
	public void setTofMax(String tofMax) {
		this.tofMax = tofMax;
	}
	/**
	 * @return
	 * @uml.property  name="tofMin"
	 */
	public String getTofMin() {
		return tofMin;
	}
	/**
	 * @param tofMin
	 * @uml.property  name="tofMin"
	 */
	public void setTofMin(String tofMin) {
		this.tofMin = tofMin;
	}
	/**
	 * @return
	 * @uml.property  name="tofAvg"
	 */
	public String getTofAvg() {
		return tofAvg;
	}
	/**
	 * @param tofAvg
	 * @uml.property  name="tofAvg"
	 */
	public void setTofAvg(String tofAvg) {
		this.tofAvg = tofAvg;
	}
	/**
	 * @return
	 * @uml.property  name="voc1Max"
	 */
	public String getVoc1Max() {
		return voc1Max;
	}
	/**
	 * @param voc1Max
	 * @uml.property  name="voc1Max"
	 */
	public void setVoc1Max(String voc1Max) {
		this.voc1Max = voc1Max;
	}
	/**
	 * @return
	 * @uml.property  name="voc1Min"
	 */
	public String getVoc1Min() {
		return voc1Min;
	}
	/**
	 * @param voc1Min
	 * @uml.property  name="voc1Min"
	 */
	public void setVoc1Min(String voc1Min) {
		this.voc1Min = voc1Min;
	}
	/**
	 * @return
	 * @uml.property  name="voc1Avg"
	 */
	public String getVoc1Avg() {
		return voc1Avg;
	}
	/**
	 * @param voc1Avg
	 * @uml.property  name="voc1Avg"
	 */
	public void setVoc1Avg(String voc1Avg) {
		this.voc1Avg = voc1Avg;
	}
	/**
	 * @return
	 * @uml.property  name="voc2Max"
	 */
	public String getVoc2Max() {
		return voc2Max;
	}
	/**
	 * @param voc2Max
	 * @uml.property  name="voc2Max"
	 */
	public void setVoc2Max(String voc2Max) {
		this.voc2Max = voc2Max;
	}
	/**
	 * @return
	 * @uml.property  name="voc2Min"
	 */
	public String getVoc2Min() {
		return voc2Min;
	}
	/**
	 * @param voc2Min
	 * @uml.property  name="voc2Min"
	 */
	public void setVoc2Min(String voc2Min) {
		this.voc2Min = voc2Min;
	}
	/**
	 * @return
	 * @uml.property  name="voc2Avg"
	 */
	public String getVoc2Avg() {
		return voc2Avg;
	}
	/**
	 * @param voc2Avg
	 * @uml.property  name="voc2Avg"
	 */
	public void setVoc2Avg(String voc2Avg) {
		this.voc2Avg = voc2Avg;
	}
	/**
	 * @return
	 * @uml.property  name="voc3Max"
	 */
	public String getVoc3Max() {
		return voc3Max;
	}
	/**
	 * @param voc3Max
	 * @uml.property  name="voc3Max"
	 */
	public void setVoc3Max(String voc3Max) {
		this.voc3Max = voc3Max;
	}
	/**
	 * @return
	 * @uml.property  name="voc3Min"
	 */
	public String getVoc3Min() {
		return voc3Min;
	}
	/**
	 * @param voc3Min
	 * @uml.property  name="voc3Min"
	 */
	public void setVoc3Min(String voc3Min) {
		this.voc3Min = voc3Min;
	}
	/**
	 * @return
	 * @uml.property  name="voc3Avg"
	 */
	public String getVoc3Avg() {
		return voc3Avg;
	}
	/**
	 * @param voc3Avg
	 * @uml.property  name="voc3Avg"
	 */
	public void setVoc3Avg(String voc3Avg) {
		this.voc3Avg = voc3Avg;
	}
	/**
	 * @return
	 * @uml.property  name="voc4Max"
	 */
	public String getVoc4Max() {
		return voc4Max;
	}
	/**
	 * @param voc4Max
	 * @uml.property  name="voc4Max"
	 */
	public void setVoc4Max(String voc4Max) {
		this.voc4Max = voc4Max;
	}
	/**
	 * @return
	 * @uml.property  name="voc4Min"
	 */
	public String getVoc4Min() {
		return voc4Min;
	}
	/**
	 * @param voc4Min
	 * @uml.property  name="voc4Min"
	 */
	public void setVoc4Min(String voc4Min) {
		this.voc4Min = voc4Min;
	}
	/**
	 * @return
	 * @uml.property  name="voc4Avg"
	 */
	public String getVoc4Avg() {
		return voc4Avg;
	}
	/**
	 * @param voc4Avg
	 * @uml.property  name="voc4Avg"
	 */
	public void setVoc4Avg(String voc4Avg) {
		this.voc4Avg = voc4Avg;
	}
	/**
	 * @return
	 * @uml.property  name="voc5Max"
	 */
	public String getVoc5Max() {
		return voc5Max;
	}
	/**
	 * @param voc5Max
	 * @uml.property  name="voc5Max"
	 */
	public void setVoc5Max(String voc5Max) {
		this.voc5Max = voc5Max;
	}
	/**
	 * @return
	 * @uml.property  name="voc5Min"
	 */
	public String getVoc5Min() {
		return voc5Min;
	}
	/**
	 * @param voc5Min
	 * @uml.property  name="voc5Min"
	 */
	public void setVoc5Min(String voc5Min) {
		this.voc5Min = voc5Min;
	}
	/**
	 * @return
	 * @uml.property  name="voc5Avg"
	 */
	public String getVoc5Avg() {
		return voc5Avg;
	}
	/**
	 * @param voc5Avg
	 * @uml.property  name="voc5Avg"
	 */
	public void setVoc5Avg(String voc5Avg) {
		this.voc5Avg = voc5Avg;
	}
	/**
	 * @return
	 * @uml.property  name="voc6Max"
	 */
	public String getVoc6Max() {
		return voc6Max;
	}
	/**
	 * @param voc6Max
	 * @uml.property  name="voc6Max"
	 */
	public void setVoc6Max(String voc6Max) {
		this.voc6Max = voc6Max;
	}
	/**
	 * @return
	 * @uml.property  name="voc6Min"
	 */
	public String getVoc6Min() {
		return voc6Min;
	}
	/**
	 * @param voc6Min
	 * @uml.property  name="voc6Min"
	 */
	public void setVoc6Min(String voc6Min) {
		this.voc6Min = voc6Min;
	}
	/**
	 * @return
	 * @uml.property  name="voc6Avg"
	 */
	public String getVoc6Avg() {
		return voc6Avg;
	}
	/**
	 * @param voc6Avg
	 * @uml.property  name="voc6Avg"
	 */
	public void setVoc6Avg(String voc6Avg) {
		this.voc6Avg = voc6Avg;
	}
	/**
	 * @return
	 * @uml.property  name="voc7Max"
	 */
	public String getVoc7Max() {
		return voc7Max;
	}
	/**
	 * @param voc7Max
	 * @uml.property  name="voc7Max"
	 */
	public void setVoc7Max(String voc7Max) {
		this.voc7Max = voc7Max;
	}
	/**
	 * @return
	 * @uml.property  name="voc7Min"
	 */
	public String getVoc7Min() {
		return voc7Min;
	}
	/**
	 * @param voc7Min
	 * @uml.property  name="voc7Min"
	 */
	public void setVoc7Min(String voc7Min) {
		this.voc7Min = voc7Min;
	}
	/**
	 * @return
	 * @uml.property  name="voc7Avg"
	 */
	public String getVoc7Avg() {
		return voc7Avg;
	}
	/**
	 * @param voc7Avg
	 * @uml.property  name="voc7Avg"
	 */
	public void setVoc7Avg(String voc7Avg) {
		this.voc7Avg = voc7Avg;
	}
	/**
	 * @return
	 * @uml.property  name="voc8Max"
	 */
	public String getVoc8Max() {
		return voc8Max;
	}
	/**
	 * @param voc8Max
	 * @uml.property  name="voc8Max"
	 */
	public void setVoc8Max(String voc8Max) {
		this.voc8Max = voc8Max;
	}
	/**
	 * @return
	 * @uml.property  name="voc8Min"
	 */
	public String getVoc8Min() {
		return voc8Min;
	}
	/**
	 * @param voc8Min
	 * @uml.property  name="voc8Min"
	 */
	public void setVoc8Min(String voc8Min) {
		this.voc8Min = voc8Min;
	}
	/**
	 * @return
	 * @uml.property  name="voc8Avg"
	 */
	public String getVoc8Avg() {
		return voc8Avg;
	}
	/**
	 * @param voc8Avg
	 * @uml.property  name="voc8Avg"
	 */
	public void setVoc8Avg(String voc8Avg) {
		this.voc8Avg = voc8Avg;
	}
	/**
	 * @return
	 * @uml.property  name="voc9Max"
	 */
	public String getVoc9Max() {
		return voc9Max;
	}
	/**
	 * @param voc9Max
	 * @uml.property  name="voc9Max"
	 */
	public void setVoc9Max(String voc9Max) {
		this.voc9Max = voc9Max;
	}
	/**
	 * @return
	 * @uml.property  name="voc9Min"
	 */
	public String getVoc9Min() {
		return voc9Min;
	}
	/**
	 * @param voc9Min
	 * @uml.property  name="voc9Min"
	 */
	public void setVoc9Min(String voc9Min) {
		this.voc9Min = voc9Min;
	}
	/**
	 * @return
	 * @uml.property  name="voc9Avg"
	 */
	public String getVoc9Avg() {
		return voc9Avg;
	}
	/**
	 * @param voc9Avg
	 * @uml.property  name="voc9Avg"
	 */
	public void setVoc9Avg(String voc9Avg) {
		this.voc9Avg = voc9Avg;
	}
	/**
	 * @return
	 * @uml.property  name="voc10Max"
	 */
	public String getVoc10Max() {
		return voc10Max;
	}
	/**
	 * @param voc10Max
	 * @uml.property  name="voc10Max"
	 */
	public void setVoc10Max(String voc10Max) {
		this.voc10Max = voc10Max;
	}
	/**
	 * @return
	 * @uml.property  name="voc10Min"
	 */
	public String getVoc10Min() {
		return voc10Min;
	}
	/**
	 * @param voc10Min
	 * @uml.property  name="voc10Min"
	 */
	public void setVoc10Min(String voc10Min) {
		this.voc10Min = voc10Min;
	}
	/**
	 * @return
	 * @uml.property  name="voc10Avg"
	 */
	public String getVoc10Avg() {
		return voc10Avg;
	}
	/**
	 * @param voc10Avg
	 * @uml.property  name="voc10Avg"
	 */
	public void setVoc10Avg(String voc10Avg) {
		this.voc10Avg = voc10Avg;
	}
	/**
	 * @return
	 * @uml.property  name="voc11Max"
	 */
	public String getVoc11Max() {
		return voc11Max;
	}
	/**
	 * @param voc11Max
	 * @uml.property  name="voc11Max"
	 */
	public void setVoc11Max(String voc11Max) {
		this.voc11Max = voc11Max;
	}
	/**
	 * @return
	 * @uml.property  name="voc11Min"
	 */
	public String getVoc11Min() {
		return voc11Min;
	}
	/**
	 * @param voc11Min
	 * @uml.property  name="voc11Min"
	 */
	public void setVoc11Min(String voc11Min) {
		this.voc11Min = voc11Min;
	}
	/**
	 * @return
	 * @uml.property  name="voc11Avg"
	 */
	public String getVoc11Avg() {
		return voc11Avg;
	}
	/**
	 * @param voc11Avg
	 * @uml.property  name="voc11Avg"
	 */
	public void setVoc11Avg(String voc11Avg) {
		this.voc11Avg = voc11Avg;
	}
	/**
	 * @return
	 * @uml.property  name="voc12Max"
	 */
	public String getVoc12Max() {
		return voc12Max;
	}
	/**
	 * @param voc12Max
	 * @uml.property  name="voc12Max"
	 */
	public void setVoc12Max(String voc12Max) {
		this.voc12Max = voc12Max;
	}
	/**
	 * @return
	 * @uml.property  name="voc12Min"
	 */
	public String getVoc12Min() {
		return voc12Min;
	}
	/**
	 * @param voc12Min
	 * @uml.property  name="voc12Min"
	 */
	public void setVoc12Min(String voc12Min) {
		this.voc12Min = voc12Min;
	}
	/**
	 * @return
	 * @uml.property  name="voc12Avg"
	 */
	public String getVoc12Avg() {
		return voc12Avg;
	}
	/**
	 * @param voc12Avg
	 * @uml.property  name="voc12Avg"
	 */
	public void setVoc12Avg(String voc12Avg) {
		this.voc12Avg = voc12Avg;
	}
	/**
	 * @return
	 * @uml.property  name="voc13Max"
	 */
	public String getVoc13Max() {
		return voc13Max;
	}
	/**
	 * @param voc13Max
	 * @uml.property  name="voc13Max"
	 */
	public void setVoc13Max(String voc13Max) {
		this.voc13Max = voc13Max;
	}
	/**
	 * @return
	 * @uml.property  name="voc13Min"
	 */
	public String getVoc13Min() {
		return voc13Min;
	}
	/**
	 * @param voc13Min
	 * @uml.property  name="voc13Min"
	 */
	public void setVoc13Min(String voc13Min) {
		this.voc13Min = voc13Min;
	}
	/**
	 * @return
	 * @uml.property  name="voc13Avg"
	 */
	public String getVoc13Avg() {
		return voc13Avg;
	}
	/**
	 * @param voc13Avg
	 * @uml.property  name="voc13Avg"
	 */
	public void setVoc13Avg(String voc13Avg) {
		this.voc13Avg = voc13Avg;
	}
	/**
	 * @return
	 * @uml.property  name="voc14Max"
	 */
	public String getVoc14Max() {
		return voc14Max;
	}
	/**
	 * @param voc14Max
	 * @uml.property  name="voc14Max"
	 */
	public void setVoc14Max(String voc14Max) {
		this.voc14Max = voc14Max;
	}
	/**
	 * @return
	 * @uml.property  name="voc14Min"
	 */
	public String getVoc14Min() {
		return voc14Min;
	}
	/**
	 * @param voc14Min
	 * @uml.property  name="voc14Min"
	 */
	public void setVoc14Min(String voc14Min) {
		this.voc14Min = voc14Min;
	}
	/**
	 * @return
	 * @uml.property  name="voc14Avg"
	 */
	public String getVoc14Avg() {
		return voc14Avg;
	}
	/**
	 * @param voc14Avg
	 * @uml.property  name="voc14Avg"
	 */
	public void setVoc14Avg(String voc14Avg) {
		this.voc14Avg = voc14Avg;
	}
	/**
	 * @return
	 * @uml.property  name="voc15Max"
	 */
	public String getVoc15Max() {
		return voc15Max;
	}
	/**
	 * @param voc15Max
	 * @uml.property  name="voc15Max"
	 */
	public void setVoc15Max(String voc15Max) {
		this.voc15Max = voc15Max;
	}
	/**
	 * @return
	 * @uml.property  name="voc15Min"
	 */
	public String getVoc15Min() {
		return voc15Min;
	}
	/**
	 * @param voc15Min
	 * @uml.property  name="voc15Min"
	 */
	public void setVoc15Min(String voc15Min) {
		this.voc15Min = voc15Min;
	}
	/**
	 * @return
	 * @uml.property  name="voc15Avg"
	 */
	public String getVoc15Avg() {
		return voc15Avg;
	}
	/**
	 * @param voc15Avg
	 * @uml.property  name="voc15Avg"
	 */
	public void setVoc15Avg(String voc15Avg) {
		this.voc15Avg = voc15Avg;
	}
	/**
	 * @return
	 * @uml.property  name="copMax"
	 */
	public String getCopMax() {
		return copMax;
	}
	/**
	 * @param copMax
	 * @uml.property  name="copMax"
	 */
	public void setCopMax(String copMax) {
		this.copMax = copMax;
	}
	/**
	 * @return
	 * @uml.property  name="copMin"
	 */
	public String getCopMin() {
		return copMin;
	}
	/**
	 * @param copMin
	 * @uml.property  name="copMin"
	 */
	public void setCopMin(String copMin) {
		this.copMin = copMin;
	}
	/**
	 * @return
	 * @uml.property  name="copAvg"
	 */
	public String getCopAvg() {
		return copAvg;
	}
	/**
	 * @param copAvg
	 * @uml.property  name="copAvg"
	 */
	public void setCopAvg(String copAvg) {
		this.copAvg = copAvg;
	}
	/**
	 * @return
	 * @uml.property  name="pluMax"
	 */
	public String getPluMax() {
		return pluMax;
	}
	/**
	 * @param pluMax
	 * @uml.property  name="pluMax"
	 */
	public void setPluMax(String pluMax) {
		this.pluMax = pluMax;
	}
	/**
	 * @return
	 * @uml.property  name="pluMin"
	 */
	public String getPluMin() {
		return pluMin;
	}
	/**
	 * @param pluMin
	 * @uml.property  name="pluMin"
	 */
	public void setPluMin(String pluMin) {
		this.pluMin = pluMin;
	}
	/**
	 * @return
	 * @uml.property  name="pluAvg"
	 */
	public String getPluAvg() {
		return pluAvg;
	}
	/**
	 * @param pluAvg
	 * @uml.property  name="pluAvg"
	 */
	public void setPluAvg(String pluAvg) {
		this.pluAvg = pluAvg;
	}
	/**
	 * @return
	 * @uml.property  name="zinMax"
	 */
	public String getZinMax() {
		return zinMax;
	}
	/**
	 * @param zinMax
	 * @uml.property  name="zinMax"
	 */
	public void setZinMax(String zinMax) {
		this.zinMax = zinMax;
	}
	/**
	 * @return
	 * @uml.property  name="zinMin"
	 */
	public String getZinMin() {
		return zinMin;
	}
	/**
	 * @param zinMin
	 * @uml.property  name="zinMin"
	 */
	public void setZinMin(String zinMin) {
		this.zinMin = zinMin;
	}
	/**
	 * @return
	 * @uml.property  name="zinAvg"
	 */
	public String getZinAvg() {
		return zinAvg;
	}
	/**
	 * @param zinAvg
	 * @uml.property  name="zinAvg"
	 */
	public void setZinAvg(String zinAvg) {
		this.zinAvg = zinAvg;
	}
	/**
	 * @return
	 * @uml.property  name="cadMax"
	 */
	public String getCadMax() {
		return cadMax;
	}
	/**
	 * @param cadMax
	 * @uml.property  name="cadMax"
	 */
	public void setCadMax(String cadMax) {
		this.cadMax = cadMax;
	}
	/**
	 * @return
	 * @uml.property  name="cadMin"
	 */
	public String getCadMin() {
		return cadMin;
	}
	/**
	 * @param cadMin
	 * @uml.property  name="cadMin"
	 */
	public void setCadMin(String cadMin) {
		this.cadMin = cadMin;
	}
	/**
	 * @return
	 * @uml.property  name="cadAvg"
	 */
	public String getCadAvg() {
		return cadAvg;
	}
	/**
	 * @param cadAvg
	 * @uml.property  name="cadAvg"
	 */
	public void setCadAvg(String cadAvg) {
		this.cadAvg = cadAvg;
	}
	/**
	 * @return
	 * @uml.property  name="pheMax"
	 */
	public String getPheMax() {
		return pheMax;
	}
	/**
	 * @param pheMax
	 * @uml.property  name="pheMax"
	 */
	public void setPheMax(String pheMax) {
		this.pheMax = pheMax;
	}
	/**
	 * @return
	 * @uml.property  name="pheMin"
	 */
	public String getPheMin() {
		return pheMin;
	}
	/**
	 * @param pheMin
	 * @uml.property  name="pheMin"
	 */
	public void setPheMin(String pheMin) {
		this.pheMin = pheMin;
	}
	/**
	 * @return
	 * @uml.property  name="pheAvg"
	 */
	public String getPheAvg() {
		return pheAvg;
	}
	/**
	 * @param pheAvg
	 * @uml.property  name="pheAvg"
	 */
	public void setPheAvg(String pheAvg) {
		this.pheAvg = pheAvg;
	}
	/**
	 * @return
	 * @uml.property  name="phlMax"
	 */
	public String getPhlMax() {
		return phlMax;
	}
	/**
	 * @param phlMax
	 * @uml.property  name="phlMax"
	 */
	public void setPhlMax(String phlMax) {
		this.phlMax = phlMax;
	}
	/**
	 * @return
	 * @uml.property  name="phlMin"
	 */
	public String getPhlMin() {
		return phlMin;
	}
	/**
	 * @param phlMin
	 * @uml.property  name="phlMin"
	 */
	public void setPhlMin(String phlMin) {
		this.phlMin = phlMin;
	}
	/**
	 * @return
	 * @uml.property  name="phlAvg"
	 */
	public String getPhlAvg() {
		return phlAvg;
	}
	/**
	 * @param phlAvg
	 * @uml.property  name="phlAvg"
	 */
	public void setPhlAvg(String phlAvg) {
		this.phlAvg = phlAvg;
	}
	/**
	 * @return
	 * @uml.property  name="tocMax"
	 */
	public String getTocMax() {
		return tocMax;
	}
	/**
	 * @param tocMax
	 * @uml.property  name="tocMax"
	 */
	public void setTocMax(String tocMax) {
		this.tocMax = tocMax;
	}
	/**
	 * @return
	 * @uml.property  name="tocMin"
	 */
	public String getTocMin() {
		return tocMin;
	}
	/**
	 * @param tocMin
	 * @uml.property  name="tocMin"
	 */
	public void setTocMin(String tocMin) {
		this.tocMin = tocMin;
	}
	/**
	 * @return
	 * @uml.property  name="tocAvg"
	 */
	public String getTocAvg() {
		return tocAvg;
	}
	/**
	 * @param tocAvg
	 * @uml.property  name="tocAvg"
	 */
	public void setTocAvg(String tocAvg) {
		this.tocAvg = tocAvg;
	}
	/**
	 * @return
	 * @uml.property  name="tonMax"
	 */
	public String getTonMax() {
		return tonMax;
	}
	/**
	 * @param tonMax
	 * @uml.property  name="tonMax"
	 */
	public void setTonMax(String tonMax) {
		this.tonMax = tonMax;
	}
	/**
	 * @return
	 * @uml.property  name="tonMin"
	 */
	public String getTonMin() {
		return tonMin;
	}
	/**
	 * @param tonMin
	 * @uml.property  name="tonMin"
	 */
	public void setTonMin(String tonMin) {
		this.tonMin = tonMin;
	}
	/**
	 * @return
	 * @uml.property  name="tonAvg"
	 */
	public String getTonAvg() {
		return tonAvg;
	}
	/**
	 * @param tonAvg
	 * @uml.property  name="tonAvg"
	 */
	public void setTonAvg(String tonAvg) {
		this.tonAvg = tonAvg;
	}
	/**
	 * @return
	 * @uml.property  name="topMax"
	 */
	public String getTopMax() {
		return topMax;
	}
	/**
	 * @param topMax
	 * @uml.property  name="topMax"
	 */
	public void setTopMax(String topMax) {
		this.topMax = topMax;
	}
	/**
	 * @return
	 * @uml.property  name="topMin"
	 */
	public String getTopMin() {
		return topMin;
	}
	/**
	 * @param topMin
	 * @uml.property  name="topMin"
	 */
	public void setTopMin(String topMin) {
		this.topMin = topMin;
	}
	/**
	 * @return
	 * @uml.property  name="topAvg"
	 */
	public String getTopAvg() {
		return topAvg;
	}
	/**
	 * @param topAvg
	 * @uml.property  name="topAvg"
	 */
	public void setTopAvg(String topAvg) {
		this.topAvg = topAvg;
	}
	/**
	 * @return
	 * @uml.property  name="nh4Max"
	 */
	public String getNh4Max() {
		return nh4Max;
	}
	/**
	 * @param nh4Max
	 * @uml.property  name="nh4Max"
	 */
	public void setNh4Max(String nh4Max) {
		this.nh4Max = nh4Max;
	}
	/**
	 * @return
	 * @uml.property  name="nh4Min"
	 */
	public String getNh4Min() {
		return nh4Min;
	}
	/**
	 * @param nh4Min
	 * @uml.property  name="nh4Min"
	 */
	public void setNh4Min(String nh4Min) {
		this.nh4Min = nh4Min;
	}
	/**
	 * @return
	 * @uml.property  name="nh4Avg"
	 */
	public String getNh4Avg() {
		return nh4Avg;
	}
	/**
	 * @param nh4Avg
	 * @uml.property  name="nh4Avg"
	 */
	public void setNh4Avg(String nh4Avg) {
		this.nh4Avg = nh4Avg;
	}
	/**
	 * @return
	 * @uml.property  name="no3Max"
	 */
	public String getNo3Max() {
		return no3Max;
	}
	/**
	 * @param no3Max
	 * @uml.property  name="no3Max"
	 */
	public void setNo3Max(String no3Max) {
		this.no3Max = no3Max;
	}
	/**
	 * @return
	 * @uml.property  name="no3Min"
	 */
	public String getNo3Min() {
		return no3Min;
	}
	/**
	 * @param no3Min
	 * @uml.property  name="no3Min"
	 */
	public void setNo3Min(String no3Min) {
		this.no3Min = no3Min;
	}
	/**
	 * @return
	 * @uml.property  name="no3Avg"
	 */
	public String getNo3Avg() {
		return no3Avg;
	}
	/**
	 * @param no3Avg
	 * @uml.property  name="no3Avg"
	 */
	public void setNo3Avg(String no3Avg) {
		this.no3Avg = no3Avg;
	}
	/**
	 * @return
	 * @uml.property  name="po4Max"
	 */
	public String getPo4Max() {
		return po4Max;
	}
	/**
	 * @param po4Max
	 * @uml.property  name="po4Max"
	 */
	public void setPo4Max(String po4Max) {
		this.po4Max = po4Max;
	}
	/**
	 * @return
	 * @uml.property  name="po4Min"
	 */
	public String getPo4Min() {
		return po4Min;
	}
	/**
	 * @param po4Min
	 * @uml.property  name="po4Min"
	 */
	public void setPo4Min(String po4Min) {
		this.po4Min = po4Min;
	}
	/**
	 * @return
	 * @uml.property  name="po4Avg"
	 */
	public String getPo4Avg() {
		return po4Avg;
	}
	/**
	 * @param po4Avg
	 * @uml.property  name="po4Avg"
	 */
	public void setPo4Avg(String po4Avg) {
		this.po4Avg = po4Avg;
	}
	/**
	 * @return
	 * @uml.property  name="rinMax"
	 */
	public String getRinMax() {
		return rinMax;
	}
	/**
	 * @param rinMax
	 * @uml.property  name="rinMax"
	 */
	public void setRinMax(String rinMax) {
		this.rinMax = rinMax;
	}
	/**
	 * @return
	 * @uml.property  name="rinMin"
	 */
	public String getRinMin() {
		return rinMin;
	}
	/**
	 * @param rinMin
	 * @uml.property  name="rinMin"
	 */
	public void setRinMin(String rinMin) {
		this.rinMin = rinMin;
	}
	/**
	 * @return
	 * @uml.property  name="rinAvg"
	 */
	public String getRinAvg() {
		return rinAvg;
	}
	/**
	 * @param rinAvg
	 * @uml.property  name="rinAvg"
	 */
	public void setRinAvg(String rinAvg) {
		this.rinAvg = rinAvg;
	}
	/**
	 * @return
	 * @uml.property  name="searchDate"
	 */
	public String getSearchDate() {
		return searchDate;
	}
	/**
	 * @param searchDate
	 * @uml.property  name="searchDate"
	 */
	public void setSearchDate(String searchDate) {
		this.searchDate = searchDate;
	}
	public String getRoleCode() {
		return roleCode;
	}
	public void setRoleCode(String roleCode) {
		this.roleCode = roleCode;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	
}
