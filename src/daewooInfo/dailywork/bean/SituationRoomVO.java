package daewooInfo.dailywork.bean;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 상황실 근무일지
 * @author yrkim
 *
 */
public class SituationRoomVO  implements Serializable {
    private String sId;

    private String dailyWorkId;

    private String weather;
    
    private String mTime;
    
    private String mId;

    private String mRegDate;
    
    private String mContent;

    private String aId;
    
    private String aTime;

    private String aRegDate;

    private String aContent;

    private String nId;
    
    private String nTime;

    private String nRegDate;

    private String nContent;

    private String accidentContent;

    private String etcContent;
    
    private String spreadId;

    private int spreadSeq;

    private String spreadGubun;

    private String time;
    
    private String hour;
    
    private String min;

    private String targetMe;

    private String targetGov;

    private String targetKeco;

    private String targetArea;

    private String targetAreaDetail;

    private String targetSigongsa;

    private String targetEtc;

    private String content;
    
    public String getsId() {
        return sId;
    }

    public void setsId(String sId) {
        this.sId = sId;
    }

    public String getDailyWorkId() {
        return dailyWorkId;
    }

    public void setDailyWorkId(String dailyWorkId) {
        this.dailyWorkId = dailyWorkId;
    }

	public int getSpreadSeq() {
		return spreadSeq;
	}

	public void setSpreadSeq(int spreadSeq) {
		this.spreadSeq = spreadSeq;
	}

	public String getWeather() {
        return weather;
    }

    public void setWeather(String weather) {
        this.weather = weather;
    }

    public String getmId() {
        return mId;
    }

    public void setmId(String mId) {
        this.mId = mId;
    }

    public String getmContent() {
        return mContent;
    }

    public void setmContent(String mContent) {
        this.mContent = mContent;
    }

    public String getaId() {
        return aId;
    }

    public void setaId(String aId) {
        this.aId = aId;
    }

    public String getaContent() {
        return aContent;
    }

    public void setaContent(String aContent) {
        this.aContent = aContent;
    }

    public String getnId() {
        return nId;
    }

    public void setnId(String nId) {
        this.nId = nId;
    }

    public String getnContent() {
        return nContent;
    }

    public void setnContent(String nContent) {
        this.nContent = nContent;
    }

    public String getAccidentContent() {
        return accidentContent;
    }

    public void setAccidentContent(String accidentContent) {
        this.accidentContent = accidentContent;
    }

    public String getEtcContent() {
        return etcContent;
    }

    public void setEtcContent(String etcContent) {
        this.etcContent = etcContent;
    }

	public String getSpreadId() {
		return spreadId;
	}

	public void setSpreadId(String spreadId) {
		this.spreadId = spreadId;
	}

	
	public String getSpreadGubun() {
		return spreadGubun;
	}

	public void setSpreadGubun(String spreadGubun) {
		this.spreadGubun = spreadGubun;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getTargetMe() {
		return targetMe;
	}

	public void setTargetMe(String targetMe) {
		this.targetMe = targetMe;
	}

	public String getTargetGov() {
		return targetGov;
	}

	public void setTargetGov(String targetGov) {
		this.targetGov = targetGov;
	}

	public String getTargetKeco() {
		return targetKeco;
	}

	public void setTargetKeco(String targetKeco) {
		this.targetKeco = targetKeco;
	}

	public String getTargetArea() {
		return targetArea;
	}

	public void setTargetArea(String targetArea) {
		this.targetArea = targetArea;
	}

	public String getTargetAreaDetail() {
		return targetAreaDetail;
	}

	public void setTargetAreaDetail(String targetAreaDetail) {
		this.targetAreaDetail = targetAreaDetail;
	}

	public String getTargetSigongsa() {
		return targetSigongsa;
	}

	public void setTargetSigongsa(String targetSigongsa) {
		this.targetSigongsa = targetSigongsa;
	}

	public String getTargetEtc() {
		return targetEtc;
	}

	public void setTargetEtc(String targetEtc) {
		this.targetEtc = targetEtc;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getHour() {
		return hour;
	}

	public void setHour(String hour) {
		this.hour = hour;
	}

	public String getMin() {
		return min;
	}

	public void setMin(String min) {
		this.min = min;
	}

	public String getmTime() {
		return mTime;
	}

	public void setmTime(String mTime) {
		this.mTime = mTime;
	}

	public String getaTime() {
		return aTime;
	}

	public void setaTime(String aTime) {
		this.aTime = aTime;
	}

	public String getnTime() {
		return nTime;
	}

	public void setnTime(String nTime) {
		this.nTime = nTime;
	}

	public String getmRegDate() {
		return mRegDate;
	}

	public void setmRegDate(String mRegDate) {
		this.mRegDate = mRegDate;
	}

	public String getaRegDate() {
		return aRegDate;
	}

	public void setaRegDate(String aRegDate) {
		this.aRegDate = aRegDate;
	}

	public String getnRegDate() {
		return nRegDate;
	}

	public void setnRegDate(String nRegDate) {
		this.nRegDate = nRegDate;
	}

	
}
