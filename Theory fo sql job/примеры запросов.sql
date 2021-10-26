--2. Как, используя CTE , найти пятый по величине оклад в
--таблице?


Declare @N int
set @N = 5;
WITH CTE AS
(
 SELECT Name, Salary, EmpID, RN = ROW_NUMBER()
OVER (ORDER BY Salary DESC)
 FROM Employee
)
SELECT Name, Salary, EmpID
FROM CTE
WHERE RN = @N

--Напишите один запрос для вычисления суммы всех положительных и отрицательных
--значений x.
select sum(case when x>0 then x else 0 end)
 sum_pos,sum(case when x<0 then x else 0 end)
 sum_neg from a;


Выбор четных записей:
Select * from table where id % 2 = 0


 Select employeeID from employee. INTERSECT Select EmployeeID from WorkShift
 EXCEPT и INTERSECT
 
 ---------------
 --Пришёл я как-то на собеседование в Райффайзен банк лет 7 назад, и там встречает меня мужик лет 50.

--Вот говорит, у вас два поля, там номера счетов счета, и третье поле битовое, которое говорит, какой из двух надо выбрать. Как написать запрос, чтобы он возвращал нужный счёт.

--Да нефиг делать, я говорю. На Oracle

DECODE(switch, 1, Account1, Account2)

Не... не... это сложно, неправильно, некашерно, так не делают ...

Чего ему надо думаю? Хорошо.
На MS SQL CASE switch WHEN 1 THEN Account1 ELSE Account2 END

Не... не... CASE нельзя, неправильно это

Я завис на 5 секунд, говорю, вы случайно не вот это от меня хотите услышать?

switch * Account1 + (1 - switch) * Account2

ДА!! Вот это правильно! Вот именно так надо делать!
------

удалить дубли без ID

DELETE FROM data_parent a USING (
      SELECT MIN(ctid) as ctid, payload
        FROM data_parent
        GROUP BY payload HAVING COUNT(*) > 1
      ) b
      WHERE a.payload = b.payload
      AND a.ctid <> b.ctid;