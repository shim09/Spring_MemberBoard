# MemberBoard Project

## Controller

#### HomeController

	- �⺻������ ó��(���)�� �Ǵ� �ּҿ�û�� ó����(index)
	- return index
	
#### MemberController
	- member���� �ȿ� �ִ� JSP���� ���� �� �޼��带 ��������
	
	- @Controller ������̼��� import���ְ�
	- @Autowired�� ����� MemberService�� MemverRepository���� ȣ���ؼ� ����� �� ����.
		1. ȸ���������� ��ũ ��û�� ���ִ� insertForm�� ������ְ�, insert���� ���ϰ��� �ֱ�
			- ���� �̸��� ����ϸ� �����߻����ɼ��� �־� insertForm�̶�� �̸��� �ο�����
			
			
- insert ó��
		
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
		- @ModelAttribute ���� ��ü ȣ���� ���ְ� MemberDTO���� ȸ�������� member(��ü)���� ��������ν� �����Ҷ� �ش� ���� ��ܼ� ���ϵ�,
		
		
- login,logout�� ó��

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

		- ���� �����ϰ�  ModelAttribute ���� ��ü�� ȣ�����ְ� MemberDTO�� ���� member�̶�� ��ü�� �����,
		idDuplicate = id �ߺ�Ȯ��, �α׾ƿ� = HttpSession session(���ǰ� - ���̵� ����), 
- findAll ó��

				@RequestMapping(value="findAll", method= RequestMethod.GET)
			public String findAll(Model model) {
			List<MemberDTO> mList = ms.findAll();
			model.addAttribute("mList",mList);
			return"member/findAll";
			}

			- List������ MemberDTO���� ����� mList ��ü�� model.addAttribute ���� ȭ�� ��ü ���.
- delete ó��

				@RequestMapping(value="delete", method=RequestMethod.GET)
		public String delete(@RequestParam("m_number") long m_number) {
			ms.delete(m_number);
			return "redirect:/member/findAll";
		}

			- RequestParam ���� �Ѱ��� ��(m_number)�� ��û�ϰ� 
			ms.delete���� ���񽺷� ���� �����ش�.
- update ó��

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

			-  ��ũ���� ó���ϴ� �޼���(updateForm)
			RequestParam ���� m_number�� ��û
			member��ü�� �ش�Ǵ� �޼��� ���� ����ְ�
			model.addAttribute�� member�� ����־� ȭ�鿡 ��Ÿ��
			-  �����Ͱ��� ó���ϴ� �޼���(update)
			POST������� ���� ���� �����ش�,
			RequestParam�� �ƴ� ModelAttribute ���� ��ü ȣ���� ���ְ�
			MemberDTO members ���� ��ü�� ���� ����ش�,
			ms.update(members) ���� MemberService�� �����ְ�
			���ϰ��� String result ="redirect:/member/mypage?m_number=" + 
			���� ȸ�� ������ ������ ��ȸ�� �� �ְ� ��θ� ���ϰ����� �ش�.
- ����������

				@RequestMapping(value="mypage", method= RequestMethod.GET)
		public String mypage(@RequestParam("m_number") long m_number, Model model ) {
			System.out.println(m_number);
			MemberDTO member = ms.mypage(m_number);
			model.addAttribute("m",member);
			return "member/mypage";
		}

			- RequestParam ���� m_number�� ��û�ϰ� �𵨰��� ��û���ش�,.
			MemberDTO member ��ü���� ms.mypage(m_number) �� ����ְ�
			model.addAttribute("m",member); ���� ȭ�����
			���ϰ��� mypage�� �������ش�.
#### BoardController
	- board ���� �ȿ� �ִ� JSP���� ���� �� �޼��带 ��������
	- @Controller ������̼��� import���ְ�
	- @Autowired�� ����� BoardService�� BoardRepository���� ȣ���ؼ� ����� �� ����.
- �۾���� ȸ�������� ����� ���� ������ �۸�� ���� �����Ѵ�
		(��, �۾����� �۸������ �������� �� ����¡ ó���� �۸������ �����ؾ��ϱ� ������
		���ϰ��� "redirect:/board/paging")
		
 �ڵ带 ��ü �����ϸ� �ʹ� ����� ���ϸ� �����ϴ°ɷ� ����,,,,
- findAll�� ó���ϴ� �޼���

		findAll(Model model) ���� �𵨰��� ����ش�.
		��ü ����� �ؼ� ȭ�鿡 ����ؾ��ϱ� ������ bs.findAll����
		���񽺿� �Ѱ��ְ� addAttribute ���� ȭ�����,
		���ϰ��� findAll����,
		
- ����ȸ(detail) �޼���

		- RequestParam ���� b_number �� ��û���ְ� �𵨰� ��û
		- @RequestParam(value="page", required=false, defaultValue="1")
		- value : �Ķ���� �̸�, required : �ʼ� ���θ� ���´�. defaultValue : �⺻���� �䱸
		- addAttribute �� board,page�� ������ DTO�� ����ش�.
		- ��۱��� �߰����ֱ�
		- List<CommentDTO> commentList = cs.findAll(b_number);
		- cs.findAll(��ü���)�� b_number�� �ް� CommentDTO�� ����Ʈ�� commentList ��������
		- model.addAttribute���� commentList ��Ÿ���ֱ�.
		
	- ������ ������ Member�� �����ϳ�, ����¡�� �߰��� �������� pageDTO ���� ������ �� �ʿ伺�� �ִ�.
	
- pagingó��
	
		- page model���� ��û�ϰ� BoardDTO�� List�� paging�� ���,
		- model.addAttribute���� boardList , pageing ���
		
- search ó��

		- RequestParam���� ���� searchtype keyword  �� model���� ��û�Ѵ�.
		- List<BoardDTO> bList = bs.search(searchtype, keyword)
		- ���� �� ���� ����Ʈ�� ����� ��
		- model.addAttribute ���� �˻������ bList���� ȭ�鿡 ��Ÿ���ش�.
		
- CommentController

	- Comment ���� �ȿ� �ִ� JSP���� ���� �� �޼��带 ��������
	- @Controller ������̼��� import���ְ�
	- @Autowired�� ����� CommentService�� CommentRepository���� ȣ���ؼ� ����� �� ����.
	- ��� �ۼ�(save) �޼���
	- ����Ʈ Ÿ���� List<CommentDTO> Ÿ���� commentList�� ������ ��� �ϱ� ������
	- ResponseBody ������̼��� import���ش�.
	- commentList �� ��� �Խñ� ���� DTO�� ����� �� �������ش�.
	
#### DTO

- MemberDTO

	- �� DTO �� Data ������̼��� import���ش�.
	- �� DB�� �� �÷���� �ش� �ʵ���� ���� ���ش�.(�̸��� �ٸ��� ���� �Ѿ���� �ʰų� ���� �߻� ���)
	- �̹��� ������ ����,��Ÿ���� �ϱ� ������ 
	- private MultipartFile m_file; private String m_filename; �� ���� ����
	
- BoardDTO

	- �ش� DTO���� Data ������̼� import �ʼ�
	- ���� ���� ������ ��Ÿ���� b_file, b_filename ����� �Բ�
	- �ð��� ��Ÿ���� b_date �� Timestamp Ÿ������ ���� �� import
	
- CommentDTO
	
	- �� DTO�� ũ�� �ٸ��� ����. Data������̼� import
	- date�� Timestamp �� ���� �� import
	
- PageDTO

	- �翬�� Data������̼� import!
	- ù������~�������� ���� �ʵ弱��.
	
#### Service

	- Service�� ���ܰ� �ƴϴ�.... @Service ������̼� import
	- @Autowired ������̼��� ����Ͽ� MemberRepository�� HttpSession �� import�Ͽ� ȣ�����ش�.(���� ���پ��� ����!)
	
-MemberService

	- ���� �߿��� ������� �Ⱦ�ڸ�
	- insert(����) �� throws IllegalStateException, IOException �� ����Ͽ� ����÷��
	- upload ���Ͽ� �ִ� ���� �ּҸ� ������ �ش� ������ ��Ÿ�� �� �ְ� ���ش�.
	- login �� id�� pw���� �´��� Ȯ�� �� Ʋ����� �ʱ��������� ����, ������� �α�����������
	- ������ �̿��ؼ� �α��������� ���ǿ� �������ش�.(���������� � ��Ÿ�� �� ���� ����� �� �ִ�....)
	- if���� Ȱ���� ������ �α��� �� ������ �������� �̵��� �� �ִ� ��ɱ��� �߰�!
	- ID �ߺ�üũ �� �Ű������� ���̵�� �������ְ� 
	- ajax�� �̿��� idDuplicate �� id �ߺ�üũ �ǽ�
	
- BoardService
	
	- ���⼭ ���� �߿��Ѱ� ����¡�̶�� ����...(�׸�ŭ ���� �غ����� �ϳ� ��Ӹ����� ���� �� �ϳ�..)
	- pagingList(List<BoardDTO>), paging(PageDTO) ���� �ΰ��� �޼��带 ������ش�.
	- pagingList���� ��� ������ �ľ��غ��ڸ�
	private static final int PAGE_LIMIT = 5; -> �ϳ��� �������� 5���� ���� ��Ÿ����.
	private static final int BLOCK_LIMIT = 3; -> �ϳ��� ȭ�鿡 3���� ������(����Ʈ)�� ��Ÿ����.
	pagingParam.put("start", pagingStart) ,pagingParam.put
	("limit", PAGE_LIMIT) ���� �������� limit ���ѵǴ� �������� �������ִ°� �ƴұ�...
	List<BoardDTO> pagingList = br.pagingList1(pagingParam)
	pagingList ��� ����Ʈ�� ��ü���� ����༭ �������ִ� �����ΰ�?
	
	- int boardCount = br.boardCount();
	�̰� ��ü �� ������ �����ִ� ������ ����..
	- int maxPage = (int) (Math.ceil((double) boardCount / PAGE_LIMIT))
	�̰� maxPage��� �����ִ°ź��� ��ü �������� ������ִ� �����ΰŰ���?
	- Math.ceil((double) boardCount / PAGE_LIMIT
	�� ������ ����? �ϰ� ������ ã�ƺ��� ceil �ø������� �Ҽ����� 0.1�̶� ������ ���ڰ��� �÷��ش�.. ��� �����ִ�.
	�翬�� ������������ ���������� ������ְ�...
		PageDTO paging = new PageDTO();
		paging.setPage(page);
		paging.setStartPage(startPage);
		paging.setEndPage(endPage);
		paging.setMaxPage(maxPage);
		�̷��� �ش� ������ ��ü�� ����ְ� �������ָ� ��!!
		
- CommentService

	- �̰�...�� isnert �Ǵ� save�� �ʹ� ���� �ι��̳� �����ؼ�
	�׸� �˾ƺ���...
	
#### Repository

	Repository���� 
	- @Repository �� import���ִ°� ��������
	@Autowired �� import�� SqlSessionTemplate sql �� ȣ�����ش�.
	selectOne(�Ѱ����� ���) �� selectList(��ü���) ���� ����Ͽ� ����Ͽ� 
	���� ��Ÿ�����Ҷ� ��Ÿ���ָ鼭 ������ ���� ���� �� �� delete �Ǵ� update, insert ���� ����ϸ� �Ǵ°Ͱ���...
	
#### mapper

	�� �Խ��� ������Ʈ�� �����ϸ鼭 ������ 404�� ���� ���� �Ȱ��� ģ���� �ƴұ� �ʹ�...
	��ǻ� ó�� ����,��� ��� insert into�� ����ϰ� �������� �������� �־
	����� �Ǵ� ���⸸�Ҷ� ������(?) ģ��������, id, parameterType, resultType , value�� mapper�ߺ� ���
	��ü������ ����� �����ؼ� 404�� �������� �ϳ��ϳ� ¤��鼭 ������ �����ؾ��ϴ� �����簡 �Ͼ�������Ƿ�
	�Ѱ��� ����� �����غ��� �ϸ鼭 ���Űǰ��� �����ִ°� �ְ��� �޸�� �����ΰͰ���.
	
	

	
	
	
	
	
	