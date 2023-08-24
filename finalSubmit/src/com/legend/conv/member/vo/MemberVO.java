package com.legend.conv.member.vo;

import java.time.LocalDate;
import java.time.Period;
import java.util.List;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import com.legend.conv.attach.vo.AttachVO;
import com.legend.conv.common.vaild.Regist;

public class MemberVO {

//	  @Pattern(regexp = "^\\w{4,10}$", message = "아이디는 영문,숫자 조합 4~10자로 입력해주세요.",
	@Pattern(regexp = "^[a-zA-Z0-9]{4,10}$", message = "아이디는 영문,숫자 조합 4~10자로 입력해주세요.", groups = Regist.class)

	private String id; /* 회원 아이디 */

	@Pattern(regexp = "^\\w{4,10}$", message = "패스워드는 영문,숫자 조합 4~10자로 입력해주세요.", groups = Regist.class)
	private String pw; /* 회원 비밀번호 */

	@Size(min = 1, max = 40, message = "이름은 40자 이내로 입력해주세요.", groups = Regist.class)
	private String name; /* 회원 이름 */

	private String address1; /* 회원 주소 */

	private String address2; /* 회원 상세주소 */

	@Pattern(regexp = "^[0-9]{10,11}$", message = "휴대폰 번호는 10 또는 11자리 숫자로 입력해주세요.", groups = Regist.class)
	private String hp; /* 회원 전화번호 */

	@Email(message = "이메일 형식에 맞춰주세요.", groups = Regist.class)
	private String mail; /* 회원 메일 */

	private String memDelyn; /* 회원 삭제유무 */

	private int memMileage; /* 회원 마일리지 */

	private String role; /* 회원 권한 */

	private String zip; /* 회원 우편번호 */
	@NotEmpty(message = "생년월일을 입력해주세요.")
	private String bir; /* 회원 생년월일 */

	private String rnum;
	private List<AttachVO> attachList;
	private Integer atchNo;
	
	private String age; // 나이를 계산하여 저장할 변수
	
	public MemberVO() {}

	public MemberVO(
			@Pattern(regexp = "^[a-zA-Z0-9]{4,10}$", message = "아이디는 영문,숫자 조합 4~10자로 입력해주세요.", groups = Regist.class) String id,
			@Pattern(regexp = "^\\w{4,10}$", message = "패스워드는 영문,숫자 조합 4~10자로 입력해주세요.", groups = Regist.class) String pw,
			@Size(min = 1, max = 40, message = "이름은 40자 이내로 입력해주세요.", groups = Regist.class) String name,
			String address1, String address2,
			@Pattern(regexp = "^[0-9]{10,11}$", message = "휴대폰 번호는 10 또는 11자리 숫자로 입력해주세요.", groups = Regist.class) String hp,
			@Email(message = "이메일 형식에 맞춰주세요.", groups = Regist.class) String mail, String memDelyn, int memMileage,
			String role, String zip, @NotEmpty(message = "생년월일을 입력해주세요.") String bir, String rnum,
			List<AttachVO> attachList, Integer atchNo, String age) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.address1 = address1;
		this.address2 = address2;
		this.hp = hp;
		this.mail = mail;
		this.memDelyn = memDelyn;
		this.memMileage = memMileage;
		this.role = role;
		this.zip = zip;
		this.bir = bir;
		this.rnum = rnum;
		this.attachList = attachList;
		this.atchNo = atchNo;
		this.age = age;
	}

	@Override
	public String toString() {
		return "MemberVO [id=" + id + ", pw=" + pw + ", name=" + name + ", address1=" + address1 + ", address2="
				+ address2 + ", hp=" + hp + ", mail=" + mail + ", memDelyn=" + memDelyn + ", memMileage=" + memMileage
				+ ", role=" + role + ", zip=" + zip + ", bir=" + bir + ", rnum=" + rnum + ", attachList=" + attachList
				+ ", atchNo=" + atchNo + ", age=" + age + "]";
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getHp() {
		return hp;
	}

	public void setHp(String hp) {
		this.hp = hp;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public String getMemDelyn() {
		return memDelyn;
	}

	public void setMemDelyn(String memDelyn) {
		this.memDelyn = memDelyn;
	}

	public int getMemMileage() {
		return memMileage;
	}

	public void setMemMileage(int memMileage) {
		this.memMileage = memMileage;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getZip() {
		return zip;
	}

	public void setZip(String zip) {
		this.zip = zip;
	}

	public String getBir() {
		return bir;
	}

	public void setBir(String bir) {
		this.bir = bir;
	}

	public String getRnum() {
		return rnum;
	}

	public void setRnum(String rnum) {
		this.rnum = rnum;
	}

	public List<AttachVO> getAttachList() {
		return attachList;
	}

	public void setAttachList(List<AttachVO> attachList) {
		this.attachList = attachList;
	}

	public Integer getAtchNo() {
		return atchNo;
	}

	public void setAtchNo(Integer atchNo) {
		this.atchNo = atchNo;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	// 생년월일 정보를 기반으로 나이를 계산하여 age 필드에 설정하는 메서드
    public void calculateAge() {
        LocalDate birthDate = LocalDate.parse(this.bir);
        LocalDate currentDate = LocalDate.now();
        int age = Period.between(birthDate, currentDate).getYears();
        this.age = String.valueOf(age);
    }

	
// 배고파 
	
}
