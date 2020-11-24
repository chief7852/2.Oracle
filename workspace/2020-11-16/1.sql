2020-11-16-01 사용자 생성
- CREATE 명령으로 사용자 생성
- GRANT 명령으로 권한 부여
- Developer 에 등록

**기호
    '[]' :생략 가능
    '|' :선택 사용           // 파이프 기호
    ',...' :반복될 수 있음
    

1.CREATE USER 명령
- 오라클 개체(TABLE, USER, INDEX, etc) 중 사용자를 생성 시킴
 (사용형식)
 CREATE USER 계정명 IDENTIFIED BY 암호;
 
 
 예)CREATE USER JYS02 IDENTIFIED BY JAVA;
 
 
 2.권한부여
 GRANT 권한명,... TO 계정명;
 
 예)
 GRANT CONNECT,RESOURCE,DBA TO JYS02