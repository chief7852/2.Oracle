2020-12-21-01)�Լ� (user defined function : FUNCTION)
 - ���ν����� ����� ����(��, ��ȯ���� �����ؾ���)
 - �Ϲ� �����Լ�ó�� ��밡��
 (�������)
 create [or replace] function �Լ���(
  �Ű�����   [in|out|inout] Ÿ�Ը� [:=default ��],
                    :
  �Ű�����   [in|out|inout] Ÿ�Ը� [:=default ��]
  
     return Ÿ�Ը�         --1)
  is|as
     �����
  begin
     �����
--     return ��;            --2)  1),2)�� ������Ÿ���� ������ ���ƾ��Ѵ�.
  end;
    . ����ο� �ݵ�� �ϳ��̻��� return���� �����ؾ� ��
    
��) ��ǰ���̺��� ��ǰ�ڵ带 �Է¹޾� �ش� ��ǰ�� 2005�� ���Լ����� ��ȸ�ϴ� �Լ���
    �ۼ��Ͻÿ�
  create or replace function
(�Լ�ó������ : �Է� ���� ��ǰ�ڵ忡 �ش��ϴ� ��ǰ�� 2005�� ���Լ�����ȸ)  ;
  create or replace function fn_buyqty(
   p_code in prod.prod_id%type)
   
 return varchar2
 
 is 
    v_amt number(5):=0;   --2005�� ��ǰ�� ���Լ��� ����
    v_sum number:=0;      --2005�� ��ǰ�� ���Ծ�����
    v_res varchar2(50);    --���
    
 begin
    select sum(buy_qty) ,sum(buy_qty*buy_cost) into v_amt ,v_sum 
    from buyprod
   where buy_prod=p_code
     and buy_date between '20050101' and '20051231';
     v_res:='���Լ��� : '||to_char(v_amt)||','||'���Աݾ� : '||to_char(v_sum);
 return v_res;
end;
  
  
  
select prod_id as ��ǰ�ڵ�,
       prod_name as ��ǰ��,
       fn_buyqty(prod_id) as �����հ�
   from prod;
   
   
  where fn_buyqty(prod_id) >= 100;
  
  
  ��) �������� �泲�� ȸ������ 2005�� ��ݱ� ������� ��ȸ�Ͻÿ�
    (�Լ�����: �Էµ� ȸ������ 2005�� ��ݱ� ������� ��ȸ)
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
  
  
  (���� : �������� �泲�� ȸ����ȣ �˻�)
select mem_name as ȸ����,
       nvl(fn_cart01(mem_id),0) as ���Ծ��հ�
  from member
  where mem_add1 like '�泲%';
  
  
  
��) ���� ������ �����ϴ� ������̸��� ����ϴ� �Լ��� �ۼ��Ͻÿ�  
create or replace function fn_get_user
  return varchar2
 is
    v_name varchar2(50);
begin
    select user into v_name
      from dual;
    return v_name;
    end;
    
    
    
(����)
select fn_get_user, fn_get_user() from dual;
  
  
  
  
  
  
  
  
  
  
  