DROP VIEW empvu111;
DROP VIEW empvu112;
DROP VIEW empvu113;
DROP TABLE emp_sale CASCADE CONSTRAINTS;
DROP TABLE sale CASCADE CONSTRAINTS;
DROP TABLE purchase CASCADE CONSTRAINTS;
DROP TABLE mngr CASCADE CONSTRAINTS;
DROP TABLE job CASCADE CONSTRAINTS;
DROP TABLE loc CASCADE CONSTRAINTS;
DROP TABLE dept CASCADE CONSTRAINTS;
DROP TABLE emp CASCADE CONSTRAINTS;
DROP TABLE employee_drop CASCADE CONSTRAINTS;
DROP sequence emp_id;
DROP sequence dept_id ;
DROP sequence loc_id;
DROP sequence job_id;
DROP sequence mngr_id;
DROP sequence sale_id;
DROP sequence purchase_id;
/*******************************************************************************
Этап 1. Создание представлений (VIEW) c произвольными названиями ( старая БД )
Загрузить структуру старой БД с учетом созданного пользователя под именем old_db
(файлы"скрипты hr_create.sql и hr_popul.sql)
*******************************************************************************/
/*
1.1 В старой БД создать представления с произвольными названиями
и названиями столбцов
1.1.1 Создать представление, которое:
- получает фамилию сотрудников и количество месяцев, прошедшее с момента найма на
работу;
- фамилию сотрудников представить как: первая буква в верхнем регистре, остальные - в
нижнем;
- количество месяцев округлить до ближайшего целого;
- отсортировать сотрудников по убыванию периода работы.
Выполните запрос к созданному представлению.
*/
CREATE VIEW empvu111 AS
SELECT INITCAP(last_name) lastname,
  ROUND(MONTHS_BETWEEN(sysdate, hire_date)) months
FROM employees e
ORDER BY months DESC;
SELECT * FROM empvu111;
/*
LASTNAME                      MONTHS
------------------------- ----------
King                             345
Whalen                           337
Kochhar                          313
Hunold                           310
Ernst                            293
De Haan                          273
Mavris                           262
Baer                             262
Higgins                          262
Gietz                            262
Faviet                           254
*/
/*
1.1.2. Создать представление, которое:
- получает фамилии, имена сотрудников;
- получает для сотрудников надбавку к зарплате "Tax", которая определяется как
4% за каждый год работы для Programmer, 3% за каждый год работы для Accountant,
2% за каждый год работы для Sales Manager
и 0.1% за каждый год работы для Administration Assistant.
*/
CREATE VIEW empvu112 AS
SELECT last_name,
  first_name,
  DECODE (job_title, 'Programmer', (0.04*salary)*ROUND((MONTHS_BETWEEN(sysdate, hire_date))/12), 'Accountant',(0.03*salary)*ROUND((MONTHS_BETWEEN(sysdate, hire_date))/12), 'Sales Manager',(0.02*salary)*ROUND((MONTHS_BETWEEN(sysdate, hire_date))/12), 'Administration Assistant',(0.0001*salary)*ROUND((MONTHS_BETWEEN(sysdate, hire_date))/12), 0) "Tax"
FROM employees
JOIN jobs USING(job_id);
SELECT * FROM empvu112;
/*
LAST_NAME                 FIRST_NAME                  Tax
------------------------- -------------------- ----------
King                      Steven                        0
Kochhar                   Neena                         0
De Haan                   Lex                           0
Hunold                    Alexander                  9360
Ernst                     Bruce                      5760
Austin                    David                      3648
Pataballa                 Valli                      3456
Lorentz                   Diana                      2856
Greenberg                 Nancy                         0
Faviet                    Daniel                     5670
Chen                      John                       4428
*/
/*
1.1.3. Создать представление, которое:
- получает фамилии сотрудников
- получает  количество  выходных  дней (суббота,  воскресенье)
с  момента  их  зачисления  на работу, например, если сотрудник был зачислен в
прошлую пятницу, а сегодня понедельник, то у него уже было 2 выходных дня, хотя
всего прошло 3 дня с момента его зачисления.
- сотрудники зачислены в июле 1998 года;
- отсортировать сотрудников в порядке убывания количества выходных дней.
*/
CREATE VIEW empvu113 AS
SELECT last_name,
  2*ROUND((sysdate-hire_date)/7) weekends
FROM employees
WHERE hire_date BETWEEN '01-JUL-1998' AND '31-JUL-1998'
ORDER BY weekends DESC;
SELECT * FROM empvu113;
/*
McCain 1806
Vargas 1804
Gates  1804
*/
/*******************************************************************************
Этап 2. Первичное заполнение таблиц БД ( новая БД )
*******************************************************************************/
/*
2.0. Загрузить структуру новой БД с учетом созданного пользователя под именем new_db
*/
CREATE TABLE emp
  (
    emp_id NUMBER(10),
    emp_surname NVARCHAR2(20),
    emp_name NVARCHAR2(20),
    job_id       NUMBER(4),
    emp_hiredate DATE,
    emp_sal      NUMBER(7,2),
    emp_comm     NUMBER(7,2),
    dept_id      NUMBER(6)
  );
CREATE TABLE dept
  (
    dept_id NUMBER(6),
    dept_name NVARCHAR2(20),
    loc_id  NUMBER(6),
    mngr_id NUMBER(6)
  );
CREATE TABLE loc
  ( loc_id NUMBER(6), loc_name NVARCHAR2(20)
  );
CREATE TABLE job
  ( job_id NUMBER(4), job_name NVARCHAR2(20)
  );
CREATE TABLE mngr
  ( mngr_id NUMBER(6), emp_id NUMBER(6), dept_id NUMBER(6)
  );
CREATE TABLE purchase
  (
    purchase_id NUMBER(6),
    purchase_name NVARCHAR2(20),
    purchase_price NUMBER(7,2),
    mngr_id        NUMBER(6)
  );
CREATE TABLE sale
  (
    sale_id NUMBER(6),
    sale_name NVARCHAR2(20),
    sale_price NUMBER(7,2)
  );
CREATE TABLE emp_sale
  ( emp_id NUMBER(6), sale_id NUMBER(6)
  );
ALTER TABLE emp ADD CONSTRAINT emp_pk PRIMARY KEY (emp_id);
ALTER TABLE dept ADD CONSTRAINT dept_pk PRIMARY KEY (dept_id);
ALTER TABLE loc ADD CONSTRAINT loc_pk PRIMARY KEY (loc_id);
ALTER TABLE job ADD CONSTRAINT job_pk PRIMARY KEY (job_id);
ALTER TABLE mngr ADD CONSTRAINT mngr_pk PRIMARY KEY (mngr_id);
ALTER TABLE purchase ADD CONSTRAINT purchase_pk PRIMARY KEY (purchase_id);
ALTER TABLE sale ADD CONSTRAINT sale_pk PRIMARY KEY (sale_id);
ALTER TABLE emp_sale ADD CONSTRAINT emp_sale_pk PRIMARY KEY (emp_id,sale_id);
ALTER TABLE dept ADD CONSTRAINT dept_loc_FK FOREIGN KEY (loc_id) REFERENCES loc(loc_id);
ALTER TABLE emp ADD CONSTRAINT emp_dept_FK FOREIGN KEY (dept_id) REFERENCES dept(dept_id);
ALTER TABLE emp_sale ADD CONSTRAINT emp_sale_pk PRIMARY KEY (emp_id,sale_id);
/*
2.1.  Для  всех  таблиц  новой  БД  создать  генераторы  последовательности,
обеспечивающие автоматическое создание новых значений колонок,
входящих в первичный ключ
*/
CREATE sequence emp_id START WITH 1000 INCREMENT BY 1 NOCACHE;
CREATE sequence dept_id START WITH 10 INCREMENT BY 10 NOCACHE;
CREATE sequence loc_id START WITH 100 INCREMENT BY 100 NOCACHE;
CREATE sequence job_id START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE sequence mngr_id START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE sequence sale_id START WITH 10000 INCREMENT BY 1 NOCACHE;
CREATE sequence purchase_id START WITH 10000 INCREMENT BY 1 NOCACHE;
  /*
  2.2. Для каждой таблицы новой БД создать 2 команды на внесение данных (внести две строки).
  */
  INSERT
  INTO loc VALUES
    (
      loc_id.NEXTVAL,
      'Roma'
    );
  INSERT INTO loc VALUES
    (loc_id.NEXTVAL, 'Odessa'
    );
  INSERT INTO dept VALUES
    (dept_id.NEXTVAL, 'Administration', 200, 1
    );
  INSERT INTO dept VALUES
    (dept_id.NEXTVAL, 'IT', 100, 2
    );
  INSERT
  INTO emp VALUES
    (
      emp_id.NEXTVAL,
      'Skazzi',
      'Radmila',
      10,
      sysdate,
      24000,
      0,10
    );
  INSERT
  INTO emp VALUES
    (
      emp_id.NEXTVAL,
      'Joz',
      'Alex',
      20,
      sysdate,
      24000,
      0,20
    );
  INSERT INTO job VALUES
    (job_id.NEXTVAL, 'Human Resources'
    );
  INSERT INTO job VALUES
    (job_id.NEXTVAL, 'Programmer'
    );
  INSERT INTO mngr VALUES
    (mngr_id.NEXTVAL, 1000,10
    );
  INSERT INTO mngr VALUES
    (mngr_id.NEXTVAL, 1001,20
    );
  INSERT INTO purchase VALUES
    (purchase_id.NEXTVAL, 'Katana',60,1
    );
  INSERT INTO purchase VALUES
    (purchase_id.NEXTVAL, 'Rasengan',50,2
    );
  INSERT INTO sale VALUES
    (sale_id.NEXTVAL, 'Shuriken',30
    );
  INSERT INTO sale VALUES
    (sale_id.NEXTVAL, 'Origami',40
    );
  /*
  2.3. Выполнить команду по фиксации всех изменений в БД.
  */
  COMMIT;
  /*
  2.4. Для одной из таблиц, содержащей ограничение целостности внешнего ключа,
  выполнить команду по изменению значения колонки внешнего ключа на значение,
  отсутствующее в колонке первичного ключа соответствующей таблицы.
  Проверить реакцию СУБД на подобное изменение.
  */
  /*UPDATE emp SET dept_id = 100 WHERE dept_id = 10;
  /*
  SQL Error: ORA-02291: integrity constraint (SKAZZI.DEPT_LOC_FK) violated - parent key not found
  */
  /*
  2.5. Для одной из таблиц, содержащей ограничение целостности первичного ключа,
  выполнить команду по изменению значения колонки первичного ключа на значение,
  отсутствующее в колонке внешнего ключа соответствующей таблицы.
  Проверить реакцию СУБД на подобное изменение.
  */
  /*UPDATE  dept  SET dept_id = 1000 WHERE dept_id = 10;
  /*
  SQL Error: ORA-02292: integrity constraint (SKAZZI.EMP_DEPT_FK) violated - child record found
  /*
  2.6. Для одной из таблиц, содержащей ограничение целостности первичного ключа,
  выполнить одну  команду  по  удалению  строки  со  значением  колонки
  первичного  ключа,  присутствующее  в колонке внешнего ключа соответствующей таблицы.
  Проверить реакцию СУБД на изменение.
  */
  /*DELETE FROM dept WHERE dept_id=20;
  /*
  SQL Error: ORA-02292: integrity constraint (SKAZZI.EMP_DEPT_FK) violated - child record found
  */
  /*
  2.7.  Для  одной  из  таблиц  изменить  ограничение  целостности  внешнего  ключа,
  обеспечивающее каскадное удаление
  */
  ALTER TABLE dept
  DROP CONSTRAINT dept_loc_FK;
  ALTER TABLE dept ADD CONSTRAINT dept_loc_FK FOREIGN KEY(loc_id) REFERENCES loc(loc_id) ON
  DELETE CASCADE;
  ALTER TABLE emp
  DROP CONSTRAINT emp_dept_FK;
  ALTER TABLE emp ADD CONSTRAINT emp_dept_FK FOREIGN KEY (dept_id) REFERENCES dept(dept_id)ON
  DELETE CASCADE;
  DELETE FROM loc WHERE loc_id=200;
  /*1 row deleted.*/
  /*
  2.8. Выполнить команду по отмене (откату) операции удаления из пункта 2.6
  */
  ROLLBACK;
  /*******************************************************************************
  Этап 3. Ведение операций изменения БД ( старая БД )В старой БД выполнить следующие
  операции.
  *******************************************************************************/
  /*
  3.1.  Увеличить  комиссионные  на  n%  всем  сотрудникам,  которые
  находятся  на  должности «Administration Assistant», где n – количество лет,
  которые проработали сотрудники.
  */
  UPDATE employees
  SET commission_pct = 0.01*ROUND((MONTHS_BETWEEN(sysdate, hire_date))/12)*commission_pct+commission_pct
  WHERE job_id            IN
    (SELECT job_id
    FROM employees
    JOIN jobs USING (job_id)
    WHERE jobs.job_title LIKE 'Administration Assistant'
    );
  /*1 row updated.*/
  /*
  3.2. Уволить всех сотрудников (удалить из таблицы), которые проработали более 20 лет на должности Shipping Clerk.
  Перед удалением сохранить информацию об увольняемых  сотрудниках в отдельную таблицу employee_drop,
  которая содержит такую же структуру, как и таблица employee.  При создании таблицы
  использовать конструкцию типа CREATE TABLE ... AS SELECT ...
  Указанная операция автоматически создаст таблицу и заполнит ее значениями из ответа на запрос.
  Команды увольнения и сохранения в истории оформить в виде отдельной транзакции.
  */
  COMMIT;
  SET TRANSACTION NAME 'EMPLOYEE_DROP';
  CREATE TABLE employee_drop AS
    (SELECT *
      FROM employees
      JOIN jobs USING(job_id)
      WHERE jobs.job_title LIKE 'Shipping Clerk'
      AND ROUND((MONTHS_BETWEEN(sysdate, hire_date))/12)>=20
    );
  DELETE
  FROM
    (SELECT *
    FROM employees
    JOIN jobs USING(job_id)
    WHERE jobs.job_title LIKE 'Shipping Clerk'
    AND ROUND((MONTHS_BETWEEN(sysdate, hire_date))/12)>=20
    );
  COMMIT;
  /*
  Transaction set.
  Table created.
  2 rows deleted.
  Commit complete.
  */
  /*******************************************************************************
  Этап 4. Перенос данных о подразделениях и сотрудниках из старой БД в новую БД
  *******************************************************************************/
  /*
  Для того, чтобы сохранить данные, накопленные в cтарой БД, необходимо выполнить
  перенос данных из таблиц старой БД в таблицы новой БД.  Если при переносе в столбах
  новых таблиц окажутся неопределенные значения, то необходимо заменить эти значения
  на значения"константы с учетом семантики столбцов. Использовать следующий вариант
  запросов по переносу: INSERT INTO NEW_DB.таблица_новой_бд (колонки новой БД)
  SELECT .... FROM OLD_DB.таблица_старой_бд ...; Необходимо учесть установку прав
  доступа к таблицам старой БД, используя команду:
  GRANT SELECT ON OLD_DB.таблица_старой_бдTONEW_DB;
  Все операции оформить в виде одной транзакции.
  */
  GRANT
  SELECT ON OLD_DB.employees TO NEW_DB;
  
  COMMIT;
  SET TRANSACTION NAME 'COPY FROM OLD_DB';
  
  INSERT
  INTO new_db.emp
    (
      emp_id,
      emp_surname,
      emp_name,
      job_id,
      emp_hiredate,
      emp_sal,
      emp_comm,
      dept_id
    )
  SELECT EMPLOYEE_ID,
    LAST_NAME,
    FIRST_NAME,
    JOB_ID,
    HIRE_DATE,
    SALARY,
    COMMISSION_PCT,
    DEPARTMENT_ID
  FROM old_db.employees;
COMMIT;