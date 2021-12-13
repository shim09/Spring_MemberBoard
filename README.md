# MemberBoard Project

## Controller

#### HomeController

	- 기본적으로 처음(기반)이 되는 주소요청을 처리함(index)
	- return index
	
#### MemberController
	- member폴더 안에 있는 JSP파일 관리 및 메서드를 생성해줌
	
	- @Controller 어노테이션을 import해주고
	- @Autowired를 사용해 MemberService와 MemverRepository등을 호출해서 사용할 수 있음.
		1. 회원가입으로 링크 요청을 해주는 insertForm을 만들어주고, insert으로 리턴값을 주기
			- 같은 이름을 사용하면 오류발생가능성이 있어 insertForm이라는 이름을 부여해줌
			
			
- insert 처리
		
			@RequestMapping(value = "insert", method = RequestMethod.POST)
		public String insert(@ModelAttribute MemberDTO member) throws IllegalStateException, IOException {
			System.out.println(member);
			int save = ms.insert(member);
			if(save >0) {
				return "index";
			}else {
				return "member/insert";
			}
		}
		- @ModelAttribute 으로 전체 호출을 해주고 MemberDTO으로 회원정보를 member(객체)값에 담아줌으로써 리턴할때 해당 값이 담겨서 리턴됨,
		
		
- login,logout를 처리

				@RequestMapping(value ="login", method = RequestMethod.GET)
		public String loginForm() {
			return "member/login";
		}
		@RequestMapping(value ="login", method = RequestMethod.POST)
		public String login(@ModelAttribute MemberDTO member) {
			String resultPage = ms.login(member);
			return resultPage;
		}
		@RequestMapping(value="idDuplicate", method=RequestMethod.POST)
		public @ResponseBody String idDuplicate(@RequestParam("m_id") String m_id) {
			String result = ms.idDuplicate(m_id);
			return result;
		}
		@RequestMapping(value="logout", method= RequestMethod.GET)
		public String logout(HttpSession session) {
			session.invalidate();
			return"index";
		}

		- 위와 동일하게  ModelAttribute 으로 전체를 호출해주고 MemberDTO의 값을 member이라는 객체에 담아줌,
		idDuplicate = id 중복확인, 로그아웃 = HttpSession session(세션값 - 아이디를 지움), 
- findAll 처리

				@RequestMapping(value="findAll", method= RequestMethod.GET)
			public String findAll(Model model) {
			List<MemberDTO> mList = ms.findAll();
			model.addAttribute("mList",mList);
			return"member/findAll";
			}

			- List값으로 MemberDTO값을 담아준 mList 객체를 model.addAttribute 으로 화면 전체 출력.
- delete 처리

				@RequestMapping(value="delete", method=RequestMethod.GET)
		public String delete(@RequestParam("m_number") long m_number) {
			ms.delete(m_number);
			return "redirect:/member/findAll";
		}

			- RequestParam 으로 한가지 값(m_number)을 요청하고 
			ms.delete으로 서비스로 값을 보내준다.
- update 처리

			@RequestMapping(value="update", method=RequestMethod.GET)
		public String updateForm(@RequestParam("m_number") long m_number, Model model) {
			System.out.println(m_number);
			MemberDTO member = ms.findById(m_number);
			model.addAttribute("member",member);
			System.out.println(member);
			return "member/update";
		}
		@RequestMapping(value = "update", method = RequestMethod.POST)
		public String update(@ModelAttribute MemberDTO members,Model model) throws IllegalStateException, IOException {
			ms.update(members);
			String result ="redirect:/member/mypage?m_number=" + members.getM_number();
			model.addAttribute("members", members);
			return result;
		}

			-  링크값을 처리하는 메서드(updateForm)
			RequestParam 으로 m_number만 요청
			member객체에 해당되는 메서드 값을 담아주고
			model.addAttribute에 member을 담아주어 화면에 나타냄
			-  데이터값을 처리하는 메서드(update)
			POST방식으로 받은 값을 보내준다,
			RequestParam이 아닌 ModelAttribute 으로 전체 호출을 해주고
			MemberDTO members 으로 객체에 값을 담아준다,
			ms.update(members) 으로 MemberService에 보내주고
			리턴값은 String result ="redirect:/member/mypage?m_number=" + 
			으로 회원 각각의 정보를 조회할 수 있게 경로를 리턴값으로 준다.
- 마이페이지

				@RequestMapping(value="mypage", method= RequestMethod.GET)
		public String mypage(@RequestParam("m_number") long m_number, Model model ) {
			System.out.println(m_number);
			MemberDTO member = ms.mypage(m_number);
			model.addAttribute("m",member);
			return "member/mypage";
		}

			- RequestParam 으로 m_number만 요청하고 모델값을 요청해준다,.
			MemberDTO member 객체값에 ms.mypage(m_number) 을 담아주고
			model.addAttribute("m",member); 으로 화면출력
			리턴값을 mypage로 리턴해준다.
#### BoardController
	- board 폴더 안에 있는 JSP파일 관리 및 메서드를 생성해줌
	- @Controller 어노테이션을 import해주고
	- @Autowired를 사용해 BoardService와 BoardRepository등을 호출해서 사용할 수 있음.
- 글쓰기와 회원가입의 방식이 같기 때문에 글목록 부터 시작한다
		(단, 글쓰기후 글목록으로 리턴해줄 때 페이징 처리된 글목록으로 리턴해야하기 때문에
		리턴값은 "redirect:/board/paging")
		
 코드를 전체 복붙하면 너무 길어져 비교하며 설명하는걸로 변경,,,,
- findAll을 처리하는 메서드

		findAll(Model model) 으로 모델값을 담아준다.
		전체 출력을 해서 화면에 출력해야하기 때문에 bs.findAll으로
		서비스에 넘겨주고 addAttribute 으로 화면출력,
		리턴값은 findAll으로,
		
- 상세조회(detail) 메서드

		- RequestParam 으로 b_number 만 요청해주고 모델값 요청
		- @RequestParam(value="page", required=false, defaultValue="1")
		- value : 파라미터 이름, required : 필수 여부를 묻는다. defaultValue : 기본값을 요구
		- addAttribute 에 board,page로 각각의 DTO를 담아준다.
		- 댓글까지 추가해주기
		- List<CommentDTO> commentList = cs.findAll(b_number);
		- cs.findAll(전체목록)을 b_number로 받고 CommentDTO를 리스트로 commentList 변수지정
		- model.addAttribute으로 commentList 나타내주기.
		
	- 삭제와 수정은 Member과 동일하나, 페이징이 추가된 시점에서 pageDTO 까지 담아줘야 할 필요성이 있다.
	
- paging처리
	
		- page model값을 요청하고 BoardDTO를 List로 paging를 담기,
		- model.addAttribute으로 boardList , pageing 출력
		
- search 처리

		- RequestParam으로 각각 searchtype keyword  의 model값을 요청한다.
		- List<BoardDTO> bList = bs.search(searchtype, keyword)
		- 으로 두 값을 리스트에 담아준 후
		- model.addAttribute 으로 검색결과인 bList값을 화면에 나타내준다.
		
- CommentController

	- Comment 폴더 안에 있는 JSP파일 관리 및 메서드를 생성해줌
	- @Controller 어노테이션을 import해주고
	- @Autowired를 사용해 CommentService와 CommentRepository등을 호출해서 사용할 수 있음.
	- 댓글 작성(save) 메서드
	- 리스트 타입인 List<CommentDTO> 타입의 commentList를 리턴해 줘야 하기 때문에
	- ResponseBody 어노테이션을 import해준다.
	- commentList 증 헤당 게시글 값을 DTO에 담아준 후 리턴해준다.
	
#### DTO

- MemberDTO

	- 각 DTO 에 Data 어노테이션을 import해준다.
	- 각 DB에 들어갈 컬럼명과 해당 필드명을 같게 해준다.(이름이 다르면 값이 넘어오지 않거나 오류 발생 우려)
	- 이미지 파일을 저장,나타내야 하기 때문에 
	- private MultipartFile m_file; private String m_filename; 을 각각 선언
	
- BoardDTO

	- 해당 DTO에도 Data 어노테이션 import 필수
	- 위와 같이 파일을 나타내줄 b_file, b_filename 선언과 함께
	- 시간을 나타내줄 b_date 는 Timestamp 타입으로 선언 및 import
	
- CommentDTO
	
	- 위 DTO와 크게 다를것 없다. Data어노테이션 import
	- date는 Timestamp 로 선언 및 import
	
- PageDTO

	- 당연히 Data어노테이션 import!
	- 첫페이지~끝페이지 까지 필드선언.
	
#### Service

	- Service도 예외가 아니다.... @Service 어노테이션 import
	- @Autowired 어노테이션을 사용하여 MemberRepository와 HttpSession 을 import하여 호출해준다.(각각 한줄씩만 가능!)
	
-MemberService

	- 각각 중요한 내용들을 훑어보자면
	- insert(가입) 시 throws IllegalStateException, IOException 를 사용하여 사진첨부
	- upload 파일에 있는 사진 주소를 가져와 해당 사진을 나타낼 수 있게 해준다.
	- login 시 id와 pw값이 맞는지 확인 후 틀릴경우 초기페이지로 리턴, 맞을경우 로그인페이지로
	- 세션을 이용해서 로그인정보를 세션에 저장해준다.(마이페이지 등에 나타내 줄 때도 써먹을 수 있다....)
	- if문을 활용해 관리자 로그인 시 관리자 페이지로 이동할 수 있는 기능까지 추가!
	- ID 중복체크 시 매개변수를 아이디로 지정해주고 
	- ajax를 이용한 idDuplicate 로 id 중복체크 실시
	
- BoardService
	
	- 여기서 가장 중요한건 페이징이라고 본다...(그만큼 직접 해보려니 꽤나 골머리썩은 내용 중 하나..)
	- pagingList(List<BoardDTO>), paging(PageDTO) 각각 두개의 메서드를 만들어준다.
	- pagingList에서 몇몇 사항을 파악해보자면
	private static final int PAGE_LIMIT = 5; -> 하나의 페이지에 5개의 글을 나타낸다.
	private static final int BLOCK_LIMIT = 3; -> 하나의 화면에 3개의 페이지(리스트)를 나타낸다.
	pagingParam.put("start", pagingStart) ,pagingParam.put
	("limit", PAGE_LIMIT) 시작 페이지와 limit 제한되는 페이지를 설정해주는게 아닐까...
	List<BoardDTO> pagingList = br.pagingList1(pagingParam)
	pagingList 헤당 리스트에 객체값을 담아줘서 리턴해주는 역할인가?
	
	- int boardCount = br.boardCount();
	이건 전체 글 갯수를 보여주는 변수를 선언..
	- int maxPage = (int) (Math.ceil((double) boardCount / PAGE_LIMIT))
	이건 maxPage라고 적혀있는거보니 전체 페이지를 계산해주는 변수인거같다?
	- Math.ceil((double) boardCount / PAGE_LIMIT
	이 수식은 뭘까? 하고 곰곰히 찾아보니 ceil 올림식으로 소숫점이 0.1이라도 있으면 숫자값을 올려준다.. 라고 볼수있다.
	당연히 시작페이지와 끝페이지도 만들어주고...
		PageDTO paging = new PageDTO();
		paging.setPage(page);
		paging.setStartPage(startPage);
		paging.setEndPage(endPage);
		paging.setMaxPage(maxPage);
		이렇게 해당 값들을 객체에 담아주고 리턴해주면 끝!!
		
- CommentService

	- 이건...위 isnert 또는 save와 너무 같고 두번이나 설명해서
	그만 알아보자...
	
#### Repository

	Repository들은 
	- @Repository 을 import해주는거 잊지말고
	@Autowired 를 import해 SqlSessionTemplate sql 을 호출해준다.
	selectOne(한가지만 출력) 과 selectList(전체출력) 등을 사용하여 사용하여 
	값을 나타내야할땐 나타내주면서 삭제와 수정 가입 등 만 delete 또는 update, insert 등을 사용하면 되는것같다...
	
#### mapper

	이 게시판 프로젝트를 진행하면서 나에게 404를 가장 많이 안겨준 친구가 아닐까 싶다...
	사실상 처음 가입,등록 등에만 insert into를 사용하고 나머지는 쿼리문을 넣어서
	만들면 되는 보기만할땐 간단한(?) 친구이지만, id, parameterType, resultType , value값 mapper중복 등등
	전체적으로 만들고 실행해서 404가 나왔을때 하나하나 짚어가면서 오류를 수정해야하는 대참사가 일어날수있으므로
	한가지 만들면 실행해보고 하면서 정신건강을 지켜주는게 최고의 메모와 공부인것같다.
	
	

	
	
	
	
	
	