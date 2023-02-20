---
layout: archive
type: years
---
***

## 1. 함수정리

pthread.h

- 새로운 쓰레드 생성. 함수 실행 성공시 tread 인자에 식별번호를 저장하고 0을 리턴하며 실패했을 경우 0이 아닌 에러코드를 리턴한다. 스레드 생성을 위한 자원이 부족하거나 PTHREADS_MAX를 초과하여 스레드 생성을 요청할 경우 에러가 발생한다.
```c
int pthread_creat(pthread_t *thread, const pthread_attr_t *attr, void *(*start_routine)(void *), void *arg);
```

- 쓰레드 종료 대기. thread 함수가 pthread_exit(3)으로 종료되거나 리턴되기까지 대기하다가 종료된다.
```c
int pthread_join(pthread_t *thread, void **tread_return);
```

- 쓰레드를 분리 상태로 만든다. 해당 쓰레드가 종료되면 모든 자원을 free해줄 것을 보증한다. 만약 pthread_join을 사용할 경우 해당 함수는 free가 되기떄문에 해당함수를 사용하지 않아도 된다.
```c
int pthread_detach(pthread_t thread);
```

- 뮤텍스 객체를 초기화. 성공할 경우 0 실패할 경우 -1
```c
int pthread_mutex_init(ptread_mutex_t *mutex, const pthread_mutex_attr *attr);
```



  
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
