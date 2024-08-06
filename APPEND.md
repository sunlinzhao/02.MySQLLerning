### 1. GROUP BY & HAVING

- GROUP BY 写在 ORDER BY 之前，先分组再排序；
- 对分组后的数据进行筛选，用 HAVING，类似于 WHERE；
- HAVING 不能单独使用，需要和 GROUP BY 一起使用；
- WHERE 不能使用聚合函数，HAVING 可以使用聚合函数；

```sql
SELECT position, MAX(age)
FROM student
GROUP BY position HAVING MAX(age)>20;
```

### 2. SELECT 执行过程

```sql
-- 方式1：
SELECT ...,....,...
FROM ...,...,....
WHERE 多表的连接条件
AND 不包含组函数的过滤条件
GROUP BY ...,...
HAVING 包含组函数的过滤条件
ORDER BY ... ASC/DESC
LIMIT ...,...

-- 方式2：复杂查询
SELECT ...,....,...
FROM ... 表A
JOIN .表B. ON 多表的连接条件
JOIN .表c. ON 多表的连接条件
WHERE 不包含组函数的过滤条件
AND/OR 不包含组函数的过滤条件
GROUP BY ...,...
HAVING 包含组函数的过滤条件
ORDER BY ... ASC/DESC
LIMIT ...,...

#其中：
#（1）from：从哪些表中筛选
#（2）on：关联多表查询时，去除笛卡尔积
#（3）where：从表中筛选的条件
#（4）group by：分组依据
#（5）having：在统计结果中再次筛选
#（6）order by：排序
#（7）limit：分页
```

**你需要记住 SELECT 查询时的两个顺序：**

**1. 关键字的顺序是不能颠倒的：**

```sql
SELECT ... FROM ... WHERE ... GROUP BY ... HAVING ... ORDER BY ... LIMIT...
```

**2. SELECT 语句的执行顺序**

```sql
FROM -> WHERE -> GROUP BY -> HAVING -> SELECT 的字段 -> DISTINCT -> ORDER BY -> LIMIT
```

### 3. 子查询和约束

#### （1）子查询

> 子查询指一个查询语句嵌套在另一个查询语句内部的查询，这个特性从 MySQL4.1 开始引入。

SQL中子查询的使用大大增强了 SELECT 查询的能力，因为很多时候查询需要从结果集中获取数据，或者需要从同个表中先计算得出一个数据结果，然后与这个数据结果(可能是某个标量，也可能是某个集合)进行比较。

![image.png](assets/image10.png)

- 子查询在主查询之前一次完成；
- 子查询结果被主查询使用；
- 注意
  - 子查询要包含在括号内
  - 将子查询放在比较条件的右侧
  - 单行操作符对应单行子查询，多行操作符对应多行子查询
- 分类
  - 根据返回数据行数：单行子查询和多行子查询
  - 根据需要执行次数：相关子查询（多次）和非相关子查询（单次）

#### （2）约束

> 约束是表级的强制规定。可以在创建表时规定约束(通过 CREATE TABLE 语句)，或者在表创建之后通过 ALTER TABLE 语句规定约束；

- 为什么需要约束？

> 数据完整性(DataIntegrity)是指数据的精确性(Accuracy)和可靠性(Reliability)。它是防止数据库中存在不符合语义规定的数据和防止因错误信息的输入输出造成无效操作或错误信息而提出的。为了保证数据的完整性，SQL规范以约束的方式对表数据进行额外的条件限制。从以下四个方面考虑:
>
> - 实体完整性(Entity Integriy): 例如, 同一个表中，不能存在两条完全相同无法区分的记录;
> - 域完整性(Domain Integrity): 例如, 年龄范围 0-120，性别范围"男/女";
> - 引用完整性(Referential Integrity): 例如, 员工所在部门，在部门表中要能找到这个部门;
> - 用户自定义完整性(User-defined Integrity): 例如, 用户名唯一、密码不能为空等，本部门经理的工资不得高于本部门职工的平均工资的5倍。

- 约束分类
- > - 根据约束数据列：单列约束 & 多列约束
  > - 根据约束作用范围：列级约束 & 表级约束
  >

* **根据约束起的作用，可以分为：**
  * **NOT NULL 非空约束，规定某个字段不能为空**
  * **UNIQUE 唯一约束，规定某个字段在整个表中是唯一的**
  * **PRIMARY KEY 主键(非空且唯一)约束**
  * **FOREIGN KEY 外键约束**
  * **CHECK 检查约束**
  * **DEFAULT 默认值约束**

- 查看某个表已有的约束

  ```sql
  #information_schema数据库名（系统库）
  #table_constraints表名称（专门存储各个表的约束）
  SELECT * FROM information_schema.table_constraints
  WHERE table_name = '表名称';
  ```

> ## 常见面试题
>
> **面试1、为什么建表时，加 not null default '' 或 default 0**
>
> **答：不想让表中出现null值。**
>
> **面试2、为什么不想要 null 的值**
>
> **（1）不好比较。null是一种特殊值，比较时只能用专门的is null 和 is not null来比较。碰到运算符，通常返回null。**
>
> **（2）效率不高。影响提高索引效果。因此，我们往往在建表时 not null default '' 或 default 0**
>
> **面试3、带AUTO_INCREMENT约束的字段值是从1开始的吗？**
>
> **在MySQL中，默认AUTO\_INCREMENT的初始值是1，每新增一条记录，字段值自动加1。设置自增属性（AUTO\_INCREMENT）的时候，还可以指定第一条插入记录的自增字段的值，这样新插入的记录的自增字段值从初始值开始递增，如在表中插入第一条记录，同时指定id值为5，则以后插入的记录的id值就会从6开始往上增加。添加主键约束时，往往需要设置字段自动增加属性。**
>
> **面试4、并不是每个表都可以任意选择存储引擎？**
>
> **MySQL支持多种存储引擎，每一个表都可以指定一个不同的存储引擎，需要注意的是：外键约束是用来保证数据的参照完整性的，如果表之间需要关联外键，却指定了不同的存储引擎，那么这些表之间是不能创建外键约束的。所以说，存储引擎的选择也不完全是随意的。**

### 4. 视图与存储过程

#### （1）视图 ❤️

- 常见的数据库对象


| 对象         | 描述                                                                                                 |
| ------------ | ---------------------------------------------------------------------------------------------------- |
| 表(TABLE)    | 表是存储数据的逻辑单元，以行和列的形式存在，列就是字段，行就是记录                                   |
| 数据字典     | 就是系统表，存放数据库相关信息的表。系统表的数据通常由数据库系统维护，程序员通常不应该修改，只可查看 |
| 约束         |                                                                                                      |
| (CONSTRAINT) | 执行数据校验的规则，用于保证数据完整性的规则                                                         |
| 视图(VIEW)   | 一个或者多个数据表里的数据的逻辑显示，视图并不存储数据                                               |
| 索引(INDEX)  | 用于提高查询性能，相当于书的目录                                                                     |
| 存储过程     |                                                                                                      |
| (PROCEDURE)  | 用于完成一次完整的业务处理，没有返回值，但可通过传出参数将多个值传给调用环境                         |
| 存储函数     |                                                                                                      |
| (FUNCTION)   | 用于完成一次特定的计算，具有一个返回值                                                               |
| 触发器       |                                                                                                      |
| (TRIGGER)    | 相当于一个事件监听器，当数据库发生特定事件后，触发器被触发，完成相应的处理                           |

- 为什么使用视图？❤️

视图一方面可以帮我们使用表的一部分而不是所有的表，另一方面也可以针对不同的用户制定不同的查询视图。比如，针对一个公司的销售人员，我们只想给他看部分数据，而某些特殊的数据，比如采购的价格，则不会提供给他。再比如，人员薪酬是个敏感的字段，那么只给某个级别以上的人员开放，其他人的查询视图中则不提供这个字段。刚才讲的只是视图的一个使用场景，实际上视图还有很多作用。最后，我们总结视图的优点。

![image.png](assets/image11.png)

> - 视图是一种虚拟表，本身是不具有数据的，占用很少的内存空间，它是SQL中的一个重要概念。
> - 视图建立在已有表的基础上,视图赖以建立的这些表称为基表。
> - 视图的创建和删除只影响视图本身，不影响对应的基表。但是当对视图中的数据进行增加、删除和修改操作时，数据表中的数据会相应地发生变化，反之亦然。
> - 向视图提供数据内容的语句为 SELECT 语句, 可以将视图理解为存储起来的 SELECT 语句。在数据库中，视图不会保存数据，数据真正保存在数据表中。当对视图中的数据进行增加、删除和修改操作时，数据表中的数据会相应地发生变化; 反之亦然。
> - 视图，是向用户提供基表数据的另一种表现形式。通常情况下，小型项目的教据库可以不使用视图，但是在大型项目中，以及数据表比较复杂的情况下，视图的价值就凸显出来了，它可以帮助我们把经常查询的结果集放到虚拟表中，提升使用效率。理解和使用起来都非常方便。
> - 当我们创建好一张视图之后，还可以在它的基础上继续创建视图。

- 创建单表视图

[ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]
VIEW 视图名称 [(字段列表)]
AS 查询语句
[WITH [CASCADED|LOCAL] CHECK OPTION]
精简版

```sql
CREATE VIEW 视图名称
AS 查询语句
```

```sql
-- 视图创建
CREATE VIEW view01
AS
SELECT id, name, salary
FROM employees
WHERE dept_id = 9;
-- 视图查询
SELECT * FROM view01;
-- 视图 增 删 改
-- 视图删除
DELETE FROM view01 WHERE name='赵六';
UPDATE view01 SET salary=20000 WHERE name='Ben';
```

![image.png](assets/image12.png)

![image.png](assets/image13.png)

![image.png](assets/image14.png)

- 创建多表联合视图

```sql
-- 创建多表视图
CREATE VIEW view02
AS
SELECT e.id emp_id,e.name emp_name,d.name dept_name
FROM employees e,departments d
WHERE e.dept_id = d.id;
```

- 删除视图

```sql
-- 删除视图
DROP VIEW view02;
```

#### (2) 存储过程 ❤️

> **含义**：存储过程的英文是 Stored Procedure 。它的思想很简单，就是一组经过预先编译的 SQL 语句的封装。
>
> **执行过程**：存储过程预先存储在 MySQL 服务器上，需要执行的时候，客户端只需要向服务器端发出调用存储过程的命令，服务器端就可以把预先存储好的这一系列 SQL 语句全部执行。

- **好处**

**1、简化操作，提高了sql语句的重用性，减少了开发程序员的压力**

**2、减少操作过程中的失误，提高效率**

**3、减少网络传输量（客户端不需要把所有的 SQL 语句通过网络发给服务器)**

**4、减少了 SQL 语句暴露在网上的风险，也提高了数据查询的安全性**

> 它和视图有着同样的优点，清晰、安全，还可以减少网络传输量。不过它和视图不同，视图是虚拟表，通常不对底层数据表直接操作，而存储过程是程序化的 SQL，可以直接操作底层数据表，相比于面向集合的操作方式，能够实现一些更复杂的数据处理。
>
> 一旦存储过程被创建出来，使用它就像使用函数一样简单，我们直接通过调用存储过程名即可。相较于函数，存储过程是没有返回值的。

- 分类

存储过程的参数类型可以是IN、OUT和INOUT。（存储过程本身没有返回值，可以通过 OUT / INOUT 获取输出参数，相当于返回值）

```sql
CREATE PROCEDURE 存储过程名(IN|OUT|INOUT 参数名 参数类型,...)
[characteristics ...]
BEGIN
	存储过程体sql,不止一条;

END
```

characteristics **表示创建存储过程时指定的对存储过程的约束条件，其取值信息如下：**

```sql
LANGUAGE SQL
| [NOT] DETERMINISTIC
| { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
| SQL SECURITY { DEFINER | INVOKER }
| COMMENT 'string'
```

> - LANGUAGE SQL** ：说明存储过程执行体是由SQL语句组成的，当前系统支持的语言为SQL。**
>
> * [NOT] DETERMINISTIC **：指明存储过程执行的结果是否确定。DETERMINISTIC表示结果是确定的。每次执行存储过程时，相同的输入会得到相同的输出。NOT DETERMINISTIC表示结果是不确定的，相同的输入可能得到不同的输出。如果没有指定任意一个值，默认为NOT DETERMINISTIC。**
> * { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA } **：指明子程序使用SQL语句的限制。**
>   * **CONTAINS SQL表示当前存储过程的子程序包含SQL语句，但是并不包含读写数据的SQL语句；**
>   * **NO SQL表示当前存储过程的子程序中不包含任何SQL语句；**
>   * **READS SQL DATA表示当前存储过程的子程序中包含读数据的SQL语句；**
>   * **MODIFIES SQL DATA表示当前存储过程的子程序中包含写数据的SQL语句。** **默认情况下，系统会指定为CONTAINS SQL。**
> * SQL SECURITY { DEFINER | INVOKER } **：执行当前存储过程的权限，即指明哪些用户能够执行当前存储过程。**
>   * DEFINER** 表示只有当前存储过程的创建者或者定义者才能执行当前存储过程；**
>   * INVOKER **表示拥有当前存储过程的访问权限的用户能够执行当前存储过程。**
>   * **如果没有设置相关的值，则MySQL默认指定值为DEFINER。**
> * COMMENT 'string' **：注释信息，可以用来描述存储过程。**

- 调用

存储过程有多种调用方法。存储过程必须使用CALL语句调用，并且存储过程和数据库相关，如果要执行其他数据库中的存储过程，需要指定数据库名称，例如CALL dbname.procname。

```sql
CALL 存储过程名(实参列表)
```


|          | 关键字    | 调用语法        | 返回值        | 应用场景                         |
| -------- | --------- | --------------- | ------------- | -------------------------------- |
| 存储过程 | PROCEDURE | CALL 存储过程() | 为有0个或多个 | 一般用于更新                     |
| 存储函数 | FUNCTION  | SELECT 函数()   | 只能是一个    | 一般用于查询结果为一个值并返回时 |

```sql
SELECT 函数名(实参列表)
```

### 5. 变量 和 流程控制

> 在MySQL数据库的存储过程和函数中，可以使用变量来存储查询或计算的中间结果数据，或者输出最终的结果数据。**在 MySQL 数据库中，变量分为**系统变量**以及**用户自定义变量.

#### （1）系统变量

**变量由系统定义，不是用户定义，属于**服务器**层面。启动MySQL服务，生成MySQL服务实例期间，MySQL将为MySQL服务器内存中的系统变量赋值，这些系统变量定义了当前MySQL服务实例的属性、特征。这些系统变量的值要么是**编译MySQL时参数**的默认值，要么是**配置文件（例如my.ini等）中的参数值。

大家可以通过网址[https://dev.mysql.com/doc/refman/8.0/en/server-system-variable-reference.html](https://dev.mysql.com/doc/refman/8.0/en/server-system-variable-reference.html)查看MySQL文档的系统变量。

**系统变量分为全局系统变量（需要添加**global **关键字）以及会话系统变量（需要添加** session 关键字），有时也把全局系统变量简称为全局变量，有时也把会话系统变量称为local变量。如果不写，默认会话级别。静态变量（在 MySQL 服务实例运行期间它们的值不能使用 set 动态修改）属于特殊的全局系统变量。

> - **全局系统变量针对于所有会话（连接）有效，但**不能跨重启
> - **会话系统变量仅针对于当前会话（连接）有效。会话期间，当前会话对某个会话系统变量值的修改，不会影响其他会话同一个会话系统变量的值。**
> - **会话1对某个全局系统变量值的修改会导致会话2中同一个全局系统变量值的修改。**

```sql
-- 查看所有全局变量
SHOW GLOBAL VARIABLES;

-- 查看所有会话变量
SHOW SESSION VARIABLES;
或
SHOW VARIABLES;

-- 查看满足条件的部分系统变量。
SHOW GLOBAL VARIABLES LIKE '%标识符%';

#查看满足条件的部分会话变量
SHOW SESSION VARIABLES LIKE '%标识符%';
SHOW GLOBAL VARIABLES LIKE 'admin_%';
```

> 作为 MySQL 编码规范，MySQL 中的系统变量以两个“@” 开头，其中“@@global”仅用于标记全局系统变量，“@@session”仅用于标记会话系统变量。“@@”首先标记会话系统变量，如果会话系统变量不存在，则标记全局系统变量。

```sql
#查看指定的系统变量的值
SELECT @@global.变量名;

#查看指定的会话变量的值
SELECT @@session.变量名;

#或者
SELECT @@变量名;
```

```sql
-- 修改最大连接
SELECT @@global.max_connections;
SET GLOBAL max_connections = 1000;
SELECT @@global.max_connections;
```

#### （2）自定义变量

**用户变量是用户自己定义的，作为 MySQL 编码规范，MySQL 中的用户变量以**一个“@” **开头。根据作用范围不同，又分为**会话用户变量**和**局部变量。

* **会话用户变量：作用域和会话变量一样，只对**当前连接**会话有效。**
* **局部变量：只在 BEGIN 和 END 语句块中有效。局部变量只能在**存储过程和函数**中使用。**

```sql
#方式1：“=”或“:=”
SET @用户变量 = 值;
SET @用户变量 := 值;

#方式2：“:=” 或 INTO关键字
SELECT @用户变量 := 表达式 [FROM 等子句];
SELECT 表达式 INTO @用户变量 [FROM 等子句];
```

```sql
SET @a = 1;
SELECT @a;
SELECT @big; #查看某个未声明的变量时，将得到NULL值
```

```sql
BEGIN
	-- 声明局部变量
	DECLARE 变量名1 变量数据类型 [DEFAULT 变量默认值];
	DECLARE 变量名2,变量名3,... 变量数据类型 [DEFAULT 变量默认值];

	-- 为局部变量赋值
	SET 变量名1 = 值;
	SELECT 值 INTO 变量名2 [FROM 子句];

	-- 查看局部变量的值
	SELECT 变量1,变量2,变量3;
END
```

```sql
DECLARE 变量名 类型 [default 值]; # 如果没有DEFAULT子句，初始值为NULL
```

#### （3）流程控制

略

#### （4）游标

> 游标，提供了一种灵活的操作方式，让我们能够对结果集中的每一条记录进行定位，并对指向的记录中的数据进行操作的数据结构。游标让 SQL 这种面向集合的语言有了面向过程开发的能力。
>
> **在 SQL 中，游标是一种临时的数据库对象，可以指向存储在数据库表中的数据行指针。这里游标**充当了指针的作用，我们可以通过操作游标来对数据行进行操作。

- 声明游标
  ```sql
  DECLARE cursor_name CURSOR FOR select_statement;
  ```

> 要使用 SELECT 语句来获取数据结果集，而此时还没有开始遍历数据，这里 select\_statement 代表的是SELECT 语句，返回一个用于创建游标的结果集。

```sql
DECLARE cur_emp CURSOR FOR
SELECT id,salary FROM employees;
```

- 打开游标

```sql
OPEN cursor_name
```

> **当我们定义好游标之后，如果想要使用游标，必须先打开游标。打开游标的时候 SELECT 语句的查询结果集就会送到游标工作区，为后面游标的**逐条读取结果集中的记录做准备。

- 使用游标

```sql
FETCH cursor_name INTO var_name [, var_name] ...
```

> 这句的作用是使用 cursor\_name 这个游标来读取当前行，并且将数据保存到 var\_name 这个变量中，游标指针指到下一行。如果游标读取的数据行有多个列名，则在 INTO 关键字后面赋值给多个变量名即可。

- 关闭游标

```sql
CLOSE cursor_name
```

> **有 OPEN 就会有 CLOSE，也就是打开和关闭游标。当我们使用完游标后需要关闭掉该游标。因为游标会**占用系统资源，如果不及时关闭，****游标会一直保持到存储过程结束**，影响系统运行的效率。而关闭游标** 的操作，会释放游标占用的系统资源。

👍 MySQL 8.0版本新增了SET PERSIST 命令。**MySQL会将该命令的配置保存到数据目录下的** mysqld-auto.cnf 文件中，下次启动时会读取该文件，用其中的配置来覆盖默认的配置文件。(全局变量的持久化)

```sql
SET PERSIST global max_connections = 1000;
```

### 6. 触发器

MySQL从5.0.2 版本开始支持触发器。MySQL的触发器和存储过程一样，都是嵌入到MySQL服务器的一段程序。

> 触发器是由事件来触发某个操作，这些事件包括INSERT、UPDATE、DELETE 事件。所谓事件就是指用户的动作或者触发某项行为。如果定义了触发程序，当数据库执行这些语句时候，就相当于事件发生了，就会自动激发触发器执行相应的操作。
>
> 当对数据表中的数据执行插入、更新和删除操作，需要自动执行一些数据库逻辑时，可以使用触发器来实现。

- 创建触发器
  ```sql
  CREATE TRIGGER 触发器名称
  {BEFORE|AFTER} {INSERT|UPDATE|DELETE} ON 表名
  FOR EACH ROW
  触发器执行的语句块;
  ```

> - 表名: 表示触发器监控的对象
> - BEFORE|AFTER: 表示触发的时间。BEFORE 表示在事件之前触发; AFTER 表示在事件之后触发。
> - INSERT|UPDATE|DELETE: 表示触发的事件
>   - INSERT 表示插入记录时触发;
>   - UPDATE 表示更新记录时触发;
>   - DELETE 表示删除记录时触发。
> - 触发器执行的语句块: 可以是单条SQL语句，也可以是由BEGIN...END结构组成的复合语句块。

- 删除触发器

```sql
DROP TRIGGER IF EXISTS 触发器名称;
```

- 优缺点
- > - 触发器可以确保数据的完整性
  > - 触发器可以帮助我们记录操作日志
  > - 触发器还可以用在操作数据前，对数据进行合法性检查
  >
  > 缺点：
  >
- > - 可读性差
  > - 相关数据的变更(如数据表结构的变更)，可能会导致触发器出错
  >

### 7. 索引

#### （1）存储引擎

- 存储引擎就是存储数据、建立索引、更新/查询数据等技术的实现方式。
- 存储引擎是基于表的，而不是基于库的，所以存储引擎也可被称为表类型。❤️
- 我们可以在创建表的时候，来指定选择的存储引擎，如果没有指定将自动选择默认的存储引擎。

```sql
CREATE TABLE 表名(
  
字段1 字段1类型 [ COMMENT 字段1注释 ] ,
......
字段n 字段n类型 [COMMENT 字段n注释 ]
  
) -- ENGINE = INNODB/myisam [ COMMENT 表注释 ] ;
```

```sql
show engines; -- 查询当前数据库支持的存储引擎
SHOW CREATE TABLE student; -- 查询建表语句
```

```sql
create table my_myisam(
id int,
name varchar(10)
) engine = MyISAM ;
```

#### （2）各个引擎的特点

- InnoDB是一种兼顾高可靠性和高性能的通用存储引擎，在 MySQL 5.5 之后，InnoDB是默认的MySQL 存储引擎。
  * **DML操作遵循ACID模型，支持事务；**
  * **行级锁**，提高并发访问性能；
  * **支持外键FOREIGN KEY约束**，保证数据的完整性和正确性；
- MyISAM是MySQL早期的默认存储引擎。
  * 不支持事务，不支持外键
  * 支持表锁，不支持行锁
  * 访问速度快
- Memory引擎的表数据时存储在内存中的，由于受到硬件问题、或断电问题的影响，只能将这些表作为临时表或缓存使用。
  * **内存存放**
  * **hash索引（默认）**

> **面试题:**
>
> **InnoDB引擎与MyISAM引擎的区别 ?**
>
> **①. InnoDB引擎, 支持事务, 而MyISAM不支持。**
>
> **②. InnoDB引擎, 支持行锁和表锁, 而MyISAM仅支持表锁, 不支持行锁。**
>
> **③. InnoDB引擎, 支持外键, 而MyISAM是不支持的。**
>
> **主要是上述三点区别，当然也可以从索引结构、存储限制等方面，更加深入的回答，具体参考如下官方文档：**

#### （3）索引语法

- 创建索引

  ```sql
  CREATE [ UNIQUE | FULLTEXT ] INDEX index_name ON table_name (
  	index_col_name,... 
  ) ;
  ```
- 查看索引

```sql
SHOW INDEX FROM table_name;
```

- 删除索引

```sql
DROP INDEX index_name ON table_name;
```

### 8. 事务与锁

#### （1）事务

事务是一组操作的集合，它是一个不可分割的工作单位，事务会把所有的操作作为一个整体一起向系统提交或撤销操作请求，即这些操作要么同时成功，要么同时失败。

```sql
-- 开启事务
start transaction/ BEGIN;

-- 1. 查询张三余额
select * from account where name = '张三';

-- 2. 张三的余额减少1000
update account set money = money - 1000 where name = '张三';

出错了。。。
-- 3. 李四的余额增加1000
update account set money = money + 1000 where name = '李四';

-- 如果正常执行完毕, 则提交事务
commit;

-- 如果执行过程中报错, 则回滚事务
-- rollback;
```

- 事务四大特性 ACID

  - 原子性(Atomicity): 事务是不可分割的最小操作单元，要么全部成功，要么全部失败。
  - 一致性(Consistency): 事务完成时，必须使所有的数据都保持一致状态
  - 隔离性(Isolation): 数据库系统提供的隔离机制，保证事务在不受外部并发操作影响的独立环境下运行。
  - 持久性(Durability): 事务一旦提交或回滚，它对数据库中的数据的改变就是永久的。
- 事务隔离级别
- 事务原理 - redo log / undo log
- MVCC (Multi-Version Concurrency Control)

#### （2）锁机制

> 锁是计算机协调多个进程或线程并发访问某一资源的机制。

- 按锁的粒度分类

  - 全局锁：全局锁就是对整个数据库实例加锁，加锁后整个实例就处于只读状态，后续的DML的写语句，DDL语句，已经更新操作的事务提交语句都将被阻塞。
  - 表级锁
  - 行级锁
  - 页锁：页锁是MySQL中锁定粒度介于行级锁和表级锁中间的一种锁。表级锁速度快，但冲突多，行级冲突少，但速度慢。所以取了折衷的页级，一次锁定相邻的一组记录
- 按数据操作类型分类

  - 读锁 / 共享锁
  - 写锁 / 排他锁
- 全局锁

```sql
flush tables with read lock; -- 加锁
unlock tables; -- 释放锁
```

- 表锁

```sql
lock table 表名字 read(write),表名字2 read(write) -- 加锁
unlock tables; -- 释放锁
show open tables -- 查看表上加过的锁的命令
```

- 元数据锁

meta data lock , 元数据锁，简写MDL。MDL加锁过程是系统自动控制，无需显式使用，在访问一张表的时候会自动加上。MDL锁主要作用是维护表元数据的数据一致性，在表上有活动事务的时候，不可以对元数据进行写入操作。为了避免DML与DDL冲突，保证读写的正确性。

- 行锁

![image.png](assets/image15.png)



11
