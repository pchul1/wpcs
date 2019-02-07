package daewooInfo.stats.dao;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

import daewooInfo.stats.bean.StatsSearchVO;
import daewooInfo.stats.bean.StatsSpreadVO;

/**
 * 상황전파 통계를 내기 위한 데이터 접근 클래스
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
 *   2010.06.28  김태훈          최초 생성
 *
 * </pre>
 */
@Repository("statsSpreadDAO")
public class StatsSpreadDAO{
	
	/**
	 * @uml.property  name="sqlMapClientMySql"
	 * @uml.associationEnd  
	 */
	@Resource(name = "sqlMapClientMySql")
	private SqlMapClient sqlMapClientMySql;

    /**
	 * MySQL 접속 서비스를 가져온다.
	 * @param  StatsSearchVO
	 * @uml.property  name="sqlMapClientMySql"
	 */		
	public void setSqlMapClientMySql(SqlMapClient sqlMapClientMySql) {
		this.sqlMapClientMySql = sqlMapClientMySql;
	}	
    
    /**
     * 상황전파 통계 정보를 가져온다.
     * 
     * @param StatsSearchVO
     */		
    @SuppressWarnings("unchecked")
	public List<StatsSpreadVO> getSpreadStatsList(StatsSearchVO vo) throws Exception {
    	return sqlMapClientMySql.queryForList("statsSpreadDAO.getSpreadStatsList", vo);
    }     
}
