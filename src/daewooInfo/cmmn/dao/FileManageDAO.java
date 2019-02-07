package daewooInfo.cmmn.dao;

import java.util.Iterator;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import daewooInfo.cmmn.bean.FileVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * @Class Name : EgovFileMngDAO.java
 * @Description : 파일정보 관리를 위한 데이터 처리 클래스
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 3. 25.     이삼섭    최초생성
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 25.
 * @version
 * @see
 *
 */
@Repository("FileManageDAO")
public class FileManageDAO extends EgovAbstractDAO {

    /**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
    Logger log = Logger.getLogger(this.getClass());

    /**
     * 여러 개의 파일에 대한 정보(속성 및 상세)를 등록한다.
     * 
     * @param fileList
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public String insertFileInfs(List fileList) throws Exception {
	FileVO vo = (FileVO)fileList.get(0);
	String atchFileId = vo.getAtchFileId();
	
	insert("FileManageDAO.insertFileMaster", vo);

	Iterator iter = fileList.iterator();
	while (iter.hasNext()) {
	    vo = (FileVO)iter.next();
	    
	    insert("FileManageDAO.insertFileDetail", vo);
	}
	
	return atchFileId;
    }

    /**
     * 하나의 파일에 대한 정보(속성 및 상세)를 등록한다.
     * 
     * @param vo
     * @throws Exception
     */
    public void insertFileInf(FileVO vo) throws Exception {
	insert("FileManageDAO.insertFileMaster", vo);
	insert("FileManageDAO.insertFileDetail", vo);
    }

    /**
     * 여러 개의 파일에 대한 정보(속성 및 상세)를 수정한다.
     * 
     * @param fileList
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public void updateFileInfs(List fileList) throws Exception {
	FileVO vo;
	Iterator iter = fileList.iterator();
	while (iter.hasNext()) {
	    vo = (FileVO)iter.next();
	    
	    insert("FileManageDAO.insertFileDetail", vo);
	}
    }

    /**
     * 여러 개의 파일을 삭제한다.
     * 
     * @param fileList
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public void deleteFileInfs(List fileList) throws Exception {
	Iterator iter = fileList.iterator();
	FileVO vo;
	while (iter.hasNext()) {
	    vo = (FileVO)iter.next();
	    
	    delete("FileManageDAO.deleteFileDetail", vo);
	}
    }

    /**
     * 하나의 파일을 삭제한다.
     * 
     * @param fvo
     * @throws Exception
     */
    public void deleteFileInf(FileVO fvo) throws Exception {
	delete("FileManageDAO.deleteFileDetail", fvo);
    }

    /**
     * 파일에 대한 목록을 조회한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<FileVO> selectFileInfs(FileVO vo) throws Exception {
	return list("FileManageDAO.selectFileList", vo);
    }

    /**
     * 파일 구분자에 대한 최대값을 구한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public int getMaxFileSN(FileVO fvo) throws Exception {
	return (Integer)getSqlMapClientTemplate().queryForObject("FileManageDAO.getMaxFileSN", fvo);
    }

    /**
     * 파일에 대한 상세정보를 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public FileVO selectFileInf(FileVO fvo) throws Exception {
	return (FileVO)selectByPk("FileManageDAO.selectFileInf", fvo);
    }

    /**
     * 전체 파일을 삭제한다.
     * 
     * @param fvo
     * @throws Exception
     */
    public void deleteAllFileInf(FileVO fvo) throws Exception {
	update("FileManageDAO.deleteT_FILE", fvo);
    }

    /**
     * 파일명 검색에 대한 목록을 조회한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<FileVO> selectFileListByFileNm(FileVO fvo) throws Exception {
	return list("FileManageDAO.selectFileListByFileNm", fvo);
    }

    /**
     * 파일명 검색에 대한 목록 전체 건수를 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public int selectFileListCntByFileNm(FileVO fvo) throws Exception {
	return (Integer)getSqlMapClientTemplate().queryForObject("FileManageDAO.selectFileListCntByFileNm", fvo);
    }

    /**
     * 이미지 파일에 대한 목록을 조회한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<FileVO> selectImageFileList(FileVO vo) throws Exception {
	return list("FileManageDAO.selectImageFileList", vo);
    }
 
    /**
     * 동영상 파일에 대한 목록을 조회한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<FileVO> selectVideoFileList(FileVO vo) throws Exception {
	return list("FileManageDAO.selectVideoFileList", vo);
    }
    
    public int getFileCnt(FileVO fvo) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("FileManageDAO.getFileCnt", fvo);
    }
    
    public String selectUploadFileName(String atchFileId) throws Exception {
    	return (String)getSqlMapClientTemplate().queryForObject("FileManageDAO.selectUploadFileName", atchFileId);
    }
    
    /**
     * 전체 파일을 삭제한다.
     * 
     * @param atchFileId
     * @throws Exception
     */
    public void deleteAllFileInfs(String atchFileId) throws Exception {
    	update("FileManageDAO.deleteFileMaster", atchFileId);
    	FileVO fvo = new FileVO();
    	fvo.setAtchFileId(atchFileId);
    	delete("FileManageDAO.deleteFileDetail", fvo);
    }
}
