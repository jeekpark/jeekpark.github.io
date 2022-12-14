---
layout: archive
type: years
---
***

## 1. 가상머신

가상머신 : 컴퓨터에서 소프트웨어적으로 구현한 가상의 컴퓨터를 이야기함. 작동 방식은 크게 두가지로 구분이 되는데 CPU, RAM, DISK등을 모두 소프트웨어적으로 구현하는 에뮬레이션과, 실제 하드웨어에 접근하여 실제 하드웨어의 지원을 받는 버츄얼라이션(가상화)가 있음.
- Virtural Box : 오라클에서 제작한 가상머신 소프트웨어. 대표적으로 VDI포맷을 지원하며, 에뮬레이터 방식이 아니라 가상화 방식이다.  
  
가상머신을 사용하는 이유 : 
* * *

## 2. 운영체제

운영체제는 크게 두가지로 분류할 수 있다.
- 개인용 컴퓨터, PC(Personal Computer)에 특화된 운영체제. 윈도우즈 계열
- 멀티유저(서버용) 컴퓨터. 리눅스 계열

리눅스는 멀티유저에 특화된 운영체제이기 떄문에 리눅스의 **'권한'(유저와 그룹)** 이라는 개념은 윈도우즈보다 더욱 민감하고 매우 중요한 개념이다.  
리눅스는 멀티유저에 특화되었고, /home/ 디렉토리에는 유저들을 위한 공간 디렉토리들이 있다.  
  
*(클러스트 맥은 /Users/ 디렉토리로 유저들을 위한 공간 디렉토리들을 확인 할 수 있다. pwd를 치면 자신의 유저네임이 해당 /Users/ 디렉토리에 있음을 확인할 수 있음. 클러스터의 맥은 PC가 아닌 서버를 이용하는 것.)*  
  
**리눅스를 사용하는 가장 큰 이유는 ‘권한’ 기능의 특화로 멀티유저의 컨트롤이 용이하기 때문.**  

운영체제도 결국에 C언어로 만들어진 응용프로그램이다.  
운영체제 = 응용프로그램을 작동시키는 응용프로그램  

* * *

## 3. 리눅스를 사용하는 이유(윈도우즈 왜 안씀?)

리눅스는 크게 데비안 계열과 레드헷 계열로 나뉜다. 
- Rocky : 레드헷 엔터프라이즈 리눅스(유료)의 무료배포판인 CentOS의 공식지원이 종료되고 후속으로 Rocky가 출시되었다. 레드헷 상표가 삭제된 버전으로 레드헷 엔터프라이즈 리눅스와 1대1 대응이 가능하다.
- Debian : 데비안의 철학은 자유 운영체제이다. 누구나 자유롭게 사용할 수 있는 무료 운영체제를 목표로 하고 있어 GNU의 철학을 영향 받음. 

데비안 고른 이유는 리눅스 점유율이 훨씬 높기 때문에 리눅스를 공부하는 입장으로서 검색했을 때 정보를 얻기 용이함.  
둘 사이에 학습에 있어 기능이나 용도 차이가 유의미하게 크지 않은 것 같고 결국 서버용으로서 동일 유즈인 것 같다.  
  

* * *

## 4. 부팅 순서. - 중요도 낮음, 과제에 요구하지 않은 내용. 근데 알아두면 리눅스 설치에서 덜 헷갈릴듯
1. 메인보드에 전력이 공급되면 부착된 장치들이 작동된다.
2. CPU가 ROM(Read-Only Memory)에 저장된 펌웨어인 BIOS를 실행시킨다.
	* ROM은 메인보드에 개별적으로 독립적으로 부착되어 있다. ![ROM_ON_MAINBOARD](https://4.bp.blogspot.com/-g-2Cf-fMT0A/XqbKR0TMl7I/AAAAAAAAEaY/ocRro_lGymwdvZmJh2mBjysK2u00_7QlQCK4BGAYYCw/s1600/30.png)
	* ROM에는 부팅에 필요한 프로그램들을 저장되어있다. (BIOS)
	* BIOS는 ‘소프트웨어’가 아니라 **‘펌웨어’** 라고 한다. 유저가 자유롭게 수정할 수 있다면 소프트웨어고 바꿀 수 없게 고정된 것은 펌웨어라고 한다. 대표적으로 BIOS. 프로그램을 수정하고 바꿀 필요가 없기 때문에 Read-Only Memory, ROM에 저장한다.
3. 실행된 BIOS는 주변 하드웨어 체크를 한다.
	* 아래는 체크 프로세스인 POST(Power On Self Test)화면이다. 익숙하죠? 삡-! 소리 나는거 ![POST](https://saungakang.files.wordpress.com/2013/02/post.gif)
4. 부팅매체를 선택하고 부팅매체에 저장된 부팅정보를 읽어오는 부트스트랩(ROM에 있는 코드)을 실행시킨다.
5. 부트스트랩과정에서 RAM에 부트로더가 올라가고 부트로더는 디스크에 있는 OS코드를 복사해 메모리에 붙여서 OS를 실행시키고 제어권을 OS에게 넘긴다. 이후 제어권을 상실한 부트로더는 종료된다. **GRUB**
6. OS부팅 성공
7. 커널(드라이버)
	* 커널을 드라이버 집합체라고 이해하면 쉬움. 사운드 드라이버, 그래픽드라이버 등등.
8. 응용 프로그램 작동
  
 * * *
 
## 5. 데비안 설치
-  Hostname : 해당 컴퓨터의 이름으로 활용된다
-  Root password : 대문자, 소문자, 숫자 포함하여 10글자 이상. 반복 글자 3이상 X. 유저네임 비포함. 
-  Full name for the new user : 기본으로 생성할 유저의 이름
-  Guided - use entire disk and set up encrypted LVM : LVM을 이용하여 암호화된 파티션 생성
-  Separate /home partition : 홈 디렉토리 생성. (보너스)과제의 요구에 따라 다시 파티셔닝해주어야 함

	* 디렉토리의 이해
		* / : 최상위 디렉토리. 
		* /var : 시스템 운영 중에 발생하는 가변 데이터 파일, 로그 데이터들이 저장된다.
		* /var/log : 로그 데이터들이 저장된다.
		* /boot : 부트로더의 정적 파일들이 저장된다. 커널도 저장되어 있다. 
		* /usr : 시스템이 아닌 사용자가 실행할 프로그램들이 저장된다. 반드시 read-olny 데이터만 존재햐애한다. 
		* /usr/bin : 대부분의 사용자 명령어가 위치한다. ls, cd, vi와 같은 명령어들이 존재하고 python같은 스크립트 언어의 실행파일도 있다. 
		* /sbin : bin과 유사하지만 오직 루트권한으로만 실행할 수 있는 프로그램들이 있다.
		* /tmp : 임시 파일들을 위한 디렉토리이다. 부팅시 초기화 된다.
		* /home : 유저의 홈 디렉토리들이 만들어진다.
		* [swap]
	
	* LVM과 파티셔닝의 이홰
		* Logical(논리적인) Volume(공간을) Manager(만들어주는 프로그램)
		* 파티셔닝은 하나의 볼륨을 여러개로 나누는 개념이고 LVM은 여러개의 공간들을 하나의 볼륨으로 만드는 개념이다.
		* LVM을 사용하는 이유는 여러개의 디스크 공간을 합쳐서 하나처럼 사용하기 위해서. 결정적으로 기존에 사용중인 디스크 공간을 확장할 수 있기 때문에. LVM을 사용하지 않는 윈도우즈의 경우에는 C드라이브의 용량이 부족할 경우 새로운 드라이브를 마운트하여 개별적인 공간으로만 사용이 가능하지만, LVM을 사용하면 포맷 없이 드라이브의 크기를 확장할 수 있다.
  
  
* * *

## 6. apt와 aptidue 차이점
둘다 패키지 관리 도구.  
패키지 설치, 제거, 검색 가능함  
  
apt는 초기 툴로, 로우 레벨.  
aptitude는 인터페이스가 있어 대화형으로 하이 레벨.  
  
aptitude가 더 방대하고 apt-get, apt-cache를 포함한 기능들을 가지고 있다.  

  
* * *

## 7. SELinux와 AppArmor 차이점

SELinux와 AppArmor 모두 리눅스 커널에서 실행되는 프로그램의 접근을 제어하는 보안 솔루션.  
  
- SELinux는 기본적으로 대부분의 리눅스 배포판에 포함되어 있으며, AppArmor는 몇몇 배포판에만 포함되어 있다.
- SELinux가 더 강력하고 유연한 보안 정책을 가지고 있고 AppArmor는 사용하기 쉽고 간단하다.
- AppArmor는 프로그램의 역량을 제한 할 수 있게 해주는 리눅스 보안 모듈이다. 정책 파일을 통해 어떤 어플리케이션이 어떤 파일/경로에 접근 가능한지 허용해준다.

  
- aa-enabled : 활성화 여부 확인

  
* * *

## 8. sudo

sudo를 설치하기 위해서 루트 권한이 필요하다.
1. root user로 로그인
2. apt-get update
3. apt-get install sudo
4. visudo : sudoer파일 접근하여 secure_path에 /snap/bin 추가하기
6. adduser [username] sudo : sudo 그룹에 유저 포함시키기
7. logout
8. sudo ls /root : 유저가 sudo 그룹에 포함됐는지 확인

sudo 명령 시 백그라운드에서 새로운 쉘을 실행하고 명령을 실행한다. 이때 명령을 찾을 경로를 나열한 환경변수가 secure_path

* * *

## 9. UFW

방화벽 관리 프로그램.
- 보안이 필요한 네트워크의 통로를 단일화하여 외부의 침입을 방어하기 쉽게 만든다.
- 필요한 포트만 열어둔다.
- 사용법
	* sudo apt install ufw : 설치
	* sudo ufw status verbose : 상태 확인
	* sudo ufw enable : 부팅시 자동실행
	* sudo ufw allow 4242 : 4242 포트만 허용

* * *

## 10. SSH
Secure Shell Protocol  
서버와 컴퓨터가 퍼블릭 네트워크를 통해 통신할 때 안전하게 통신하기 위한 프로토콜  
- systemctl status ssh : ssh 상태 확인, 포트 확인
- vim /etc/ssh/sshd_config : ssh설정 변경. sshd는 서버 설정.
	* port 4242
	* PermitRootLogin no
- systemctl restart ssh : ssh 재시작하여 config설정 적용

* * *
## 11. 유저 관리
- useradd [option] [username] - 유저 생성
	* useradd jeekpark  
- usermod [(-option) (option value)] [username] - 유저 정보 수정  
- userdel [option] [username] - 유저 삭제, -r옵션 넣으면 모든 관련 디렉토리 삭제  
	* userdel -r jeekpark  
- groupadd [option] [groupname]  
	* groupadd user42  
- gpasswd [option] [option value] [group]  
	* gpasswd -a jeekpark user42 (그룹에 추가하기 add)  
	* gpasswd -a jeekpark sudo
	* gpasswd -d jeekpark user42 (그룹에서 삭제하기 del)
- id jeekpark - 속한 그룹 확인하기

