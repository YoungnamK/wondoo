package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import bean.Cart;
import bean.Customer;

@Component("cdao")
public class CustomerDao {
	//mapcustomer.xml
	private final String namespace = "MapperCustomer.";
	
	@Autowired
	SqlSessionTemplate abcd;
	
	// 총 회원 수 조회 : 파라미터 mode와 keyword를 이용
	public int SelectTotalCount(String mode, String keyword) {
		Map<String, String> map = new HashMap<String, String>() ;
		map.put("mode", mode);
		map.put("keyword", "%" + keyword + "%"); // keyword를 포함하는...
		return this.abcd.selectOne(namespace + "SelectTotalCount", map);
	}

	public List<Customer> SelectDataList(int offset, int limit, String mode, String keyword) {
		// 랭킹을 이용하여 해당 페이지의 데이터를 컬렉션으로 반환해 줍니다.
		RowBounds rowBounds = new RowBounds(offset, limit) ;
		
		Map<String, String> map = new HashMap<String, String>() ;
		map.put("mode", mode);
		map.put("keyword", "%" + keyword + "%"); // keyword를 포함하는...
		
		return this.abcd.selectList(namespace + "SelectDataList", map, rowBounds);
	}

	public List<Customer> SelectDataList(int beginRow, int endRow) {
		return null ;
	}

	// 회원가입 시 DB에 데이터를 저장합니다.
	public int InsertData(Customer bean) {
		return this.abcd.insert(namespace + "InsertData", bean);
	}

	// email 조회
	public Customer SelectDataByPk(String cust_Email) {
		return this.abcd.selectOne(namespace + "SelectDataByPk", cust_Email);	
	}

	public Customer SelectData(String cust_Email, String cust_PW) {
		System.out.println( "dao의 selectData 출력 : " + "(1)이메일 : " + cust_Email + "\t" + "(2)비밀번호 : " + cust_PW );
		Map<String, String> map = new HashMap<String, String>();
		map.put("cust_Email", cust_Email);
		map.put("cust_PW", cust_PW);
		return this.abcd.selectOne(namespace + "SelectData", map);
	}

	public CustomerDao() {
		// TODO Auto-generated constructor stub
	}
	
	// 회원 정보 수정
	// customers 테이블에 수정된 회원 정보를 업데이트합니다.
	public int UpdateData(Customer bean) {
		return this.abcd.update(namespace + "UpdateData", bean);
	}
	
	// email 찾기
	public Customer SelectEmail(String cust_Name, String cust_Contact, int cust_Birth) {
		System.out.println( "dao의 SelectEmail 출력 : " + "(1)이름 : " + cust_Name + "\t" + "(2)연락처 : " + cust_Contact +  "\t" +"(3)생년월일 : " + cust_Birth);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cust_Name", cust_Name);
		map.put("cust_Contact", cust_Contact);
		map.put("cust_Birth", cust_Birth);
		return this.abcd.selectOne(namespace + "SelectEmail", map);
	}

	// PW 찾기
	public Customer SelectPW(String cust_Email, String cust_Name, String cust_Contact, int cust_Birth) {
		System.out.println( "dao의 SelectPW 출력 : " + "(1)이메일 : " + cust_Email + "\t" + "(2)이름 : " + cust_Name + "\t" + "(3)연락처 : " + cust_Contact + "\t" + "(4)생년월일 : " + cust_Birth );
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cust_Email", cust_Email);
		map.put("cust_Name", cust_Name);
		map.put("cust_Contact", cust_Contact);
		map.put("cust_Birth", cust_Birth);
		return this.abcd.selectOne(namespace + "SelectPW", map);
	}
	
	// 회원데이터 삭제
	public int DeleteData(Customer bean) {
		return this.abcd.delete(namespace + "DeleteData", bean.getCust_Email());
	}

	public int Count(String cust_Email) {
		return this.abcd.selectOne(namespace + "CountData", cust_Email);	
	}

	public int findUser(Object email) {
		return this.abcd.selectOne(namespace+"findUser", email);
	}

	// 카카오 로그인
	public Customer kakaoLogin(Object email) {
		System.out.println(email);
		return this.abcd.selectOne(namespace+"kakaoLogin", email);
	}

	public List<Cart> GetCartInfo(String cust_Email) {
		// 로그인 하면서 이전에 keep했던 나의 장바구니 정보를 다시 읽어 옵니다. 
		return this.abcd.selectList(namespace + "GetCartInfo", cust_Email);
	}

	public void InsertCartData(Customer cust, List<Cart> lists) {
		// 1. 장바구니 테이블에 혹시 남아 있을 수 있는 회원의 행을 모두 삭제합니다. 
		this.abcd.delete(namespace + "DeleteCartData", cust.getCust_Email());
		
		// 2.반복문을 사용하여 테이블에 인서트 합니다.
		for(Cart cart : lists){
			this.abcd.insert(namespace + "InsertCartData", cart);
		}
	}

}
