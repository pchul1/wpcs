package kr.or.waterkorea.batch;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
 
public class MariaTest {
    String driver        = "org.mariadb.jdbc.Driver";
    String url           = "jdbc:mariadb://10.101.164.197:3306/iseeusee?sessionVariables=wait_timeout=864000";
    String uId           = "iseeusee";
    String uPwd          = "mjsoft0804";
    
    Connection               con;
    PreparedStatement        pstmt;
    ResultSet                rs;
    
    public MariaTest() {
         try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, uId, uPwd);
            
            if( con != null ){ System.out.println("데이터 베이스 접속 성공"); }
            
        } catch (ClassNotFoundException e) { System.out.println("드라이버 로드 실패");    } 
          catch (SQLException e) { System.out.println("데이터 베이스 접속 실패"); }
    }
    
    public void select(){
//        String sql    = "select * from tb_room_record_master where f_groupcode='KECO' order by f_seq desc";
        String sql    = "select * from tb_room_record_dtl order by f_seq";
        
//        f_roomid       : 20180916135609771_KECO_TEST
//        f_roomname    : TEST
//        f_recordid     : JM4E1NAM_KECO_TEST
        try {
            pstmt                = con.prepareStatement(sql);
            rs                   = pstmt.executeQuery();
            while(rs.next()){
//                System.out.println("f_roomid       : " + rs.getString("f_roomid"));
//                System.out.println("f_roomname    : " + rs.getString("f_roomname"));
//                System.out.println("f_recordid     : " + rs.getString("f_recordid"));
//                System.out.println("f_req_nick   : " + rs.getString("f_req_nick"));
//                System.out.println("f_rec_start   : " + rs.getString("f_rec_start"));
//                System.out.println("f_rec_end   : " + rs.getString("f_rec_end"));
                System.out.println("f_vod_dir       : " + rs.getString("f_vod_dir"));
                System.out.println("f_vod_file    : " + rs.getString("f_vod_file"));
            }
        } catch (SQLException e) { System.out.println("쿼리 수행 실패"); e.printStackTrace(); }
    }
    
    public static void main(String[] args){
    	MariaTest dbm    = new MariaTest();
        dbm.select();
    }
}


