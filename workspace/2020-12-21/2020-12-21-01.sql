2020-12-21-01)함수 (user defined function : FUNCTION)
 - 프로시져와 비슷한 구조(단, 반환값이 존재해야함)
 - 일반 내장함수처럼 사용가능
 (사용형식)
 create [or replace] function 함수명(
  매개변수   [in|out|inout] 타입명 [:=default 값],
                    :
  매개변수   [in|out|inout] 타입명 [:=default 값]
  
     return 타입명         --1)
  is|as
     선언부
  begin
     실행부
--     return 값;            --2)  1),2)의 데이터타입이 무조건 같아야한다.
  end;
    . 실행부에 반드시 하나이상의 return문이 존재해야 함
    
예) 상품테이블에서 상품코드를 입력받아 해당 상품의 2005년 매입수량을 조회하는 함수를
    작성하시오
  create or replace function
(함수처리영역 : 입력 받은 상품코드에 해당하는 상품의 2005년 매입수량조회)  ;
  create or replace function fn_buyqty(
   p_code in prod.prod_id%type)
   
 return varchar2
 
 is 
    v_amt number(5):=0;   --2005년 상품별 매입수량 집계
    v_sum number:=0;      --2005년 상품별 매입액집계
    v_res varchar2(50);    --결과
    
 begin
    select sum(buy_qty) ,sum(buy_qty*buy_cost) into v_amt ,v_sum 
    from buyprod
   where buy_prod=p_code
     and buy_date between '20050101' and '20051231';
     v_res:='매입수량 : '||to_char(v_amt)||','||'매입금액 : '||to_char(v_sum);
 return v_res;
end;
  
  
  
select prod_id as 상품코드,
       prod_name as 상품명,
       fn_buyqty(prod_id) as 매입합계
   from prod;
   
   
  where fn_buyqty(prod_id) >= 100;
  
  
  예) 거주지가 충남인 회원들의 2005년 상반기 매출액을 조회하시오
    (함수영역: 입력된 회원들의 2005년 상반기 매출액을 조회)
 create or replace function fn_cart01(
   p_memid in member.mem_id%type)
   
   return number
 is
   v_sum number:=0;
 begin
  select sum(cart_qty*prod_price) into v_sum
    from cart, prod
   where cart_prod = prod_id
     and cart_member = p_memid
     and substr(cart_no,1,6) between '200501' and '200506';
     
  return v_sum;
  end;
  
  
  (실행 : 거주지가 충남인 회원번호 검색)
select mem_name as 회원명,
       nvl(fn_cart01(mem_id),0) as 구입액합계
  from member
  where mem_add1 like '충남%';
  
  
  
예) 현재 계정에 존재하는 사용자이름을 출력하는 함수를 작성하시오  
create or replace function fn_get_user
  return varchar2
 is
    v_name varchar2(50);
begin
    select user into v_name
      from dual;
    return v_name;
    end;
    
    
    
(실행)
select fn_get_user, fn_get_user() from dual;
  
  
  
  
  
  
  
  
  
  
  