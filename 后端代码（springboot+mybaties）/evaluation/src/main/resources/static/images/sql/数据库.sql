create table if not exists subject
(
    subject_id   int auto_increment
        primary key,
    subject_name varchar(20)  not null,
    subject_logo varchar(100) null
)
    comment '题目集';

create table if not exists question_type
(
    type_id         int auto_increment
        primary key,
    type_name       varchar(20) null,
    type_subject_id int         null comment '该类型的知识点所属科目',
    constraint question_type_subject_subject_id_fk
        foreign key (type_subject_id) references subject (subject_id)
)
    comment '存放所有题目的知识点类型';

create table if not exists question_choice
(
    question_id       int auto_increment
        primary key,
    question_name     varchar(500) null,
    question_choice_a varchar(100) null,
    question_choice_b varchar(100) null,
    question_choice_c varchar(100) null,
    question_choice_d varchar(100) null,
    question_type_id  int          null,
    question_answer   varchar(5)   null,
    question_level    int          null comment '题目难度等级',
    constraint question_choice_question_type_type_id_fk
        foreign key (question_type_id) references question_type (type_id)
)
    comment '存放所有选择题';

create table if not exists question_judge
(
    question_id      int auto_increment
        primary key,
    question_name    varchar(200) null,
    question_answer  varchar(5)   null,
    question_level   int          null,
    question_type_id int          null,
    constraint question_judge_question_type_type_id_fk
        foreign key (question_type_id) references question_type (type_id)
)
    comment '存放所有判断题';

create table if not exists user_login
(
    user_id       int auto_increment
        primary key,
    user_name     varchar(20) null,
    user_password varchar(20) not null,
    user_phone    varchar(20) not null
)
    comment '存放用户登录信息';

create table if not exists test
(
    test_id         int auto_increment
        primary key,
    test_user_id    int       null,
    test_subject_id int       null,
    test_score      int       null,
    test_time       timestamp null,
    test_userlevel  int       null,
    constraint test_subject_subject_id_fk
        foreign key (test_subject_id) references subject (subject_id),
    constraint test_user_user_id_fk
        foreign key (test_user_id) references user_login (user_id)
)
    comment '存放所有测试记录';

create table if not exists everytest
(
    everytest_id          int auto_increment
        primary key,
    everytest_test_id     int        null comment '存放哪一次测试',
    everytest_no          int        null comment '存放测试题目号',
    everytest_question_id int        null comment '索引到题目集',
    everytest_type        int        null comment '1表示选择题，0表示判断题',
    everytest_user_answer varchar(5) null comment '用户选择的答案（选择题用ABCD表示，判断题用T/F）',
    everytest_is_correct  tinyint    null comment '1表示用户答案正确，0表示用户答案错误',
    constraint everytest_test_test_id_fk
        foreign key (everytest_test_id) references test (test_id)
)
    comment '存放每次具体测题目索引和用户答案';

create table if not exists user_information
(
    user_information_id int auto_increment
        primary key,
    user_id             int          not null,
    user_sex            tinyint      null comment '0表示女，1表示男',
    user_nickname       varchar(20)  not null comment '用户昵称',
    user_logo           varchar(100) null comment '用户头像',
    user_signature      varchar(100) null,
    user_school         varchar(20)  null,
    user_birthday       varchar(20)  null,
    constraint user_information_user_login_user_id_fk
        foreign key (user_id) references user_login (user_id)
)
    comment '存放用户基本信息';

create table if not exists user_level
(
    id         int auto_increment
        primary key,
    user_id    int null,
    user_rank  int null,
    subject_id int null,
    constraint user_level_subject_subject_id_fk
        foreign key (subject_id) references subject (subject_id),
    constraint user_level_user_login_user_id_fk
        foreign key (user_id) references user_login (user_id)
)
    comment '存放用户各个科目等级';



INSERT INTO evaluation.subject (subject_id, subject_name, subject_logo) VALUES (1, 'C语言基础', 'http://106.54.212.158:8888/images/c++.png');
INSERT INTO evaluation.subject (subject_id, subject_name, subject_logo) VALUES (2, '数据结构', 'http://106.54.212.158:8888/images/datastructure.png');
INSERT INTO evaluation.subject (subject_id, subject_name, subject_logo) VALUES (3, 'Java语言程序设计', 'http://106.54.212.158:8888/images/java.png');
INSERT INTO evaluation.subject (subject_id, subject_name, subject_logo) VALUES (4, 'python语言程序设计', 'http://106.54.212.158:8888/images/python.png');



INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (1, '结构', 1);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (2, '基本语法', 1);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (3, '函数', 1);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (4, '变量和运算符', 1);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (5, '循环结构', 1);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (6, '数据类型和表达式', 1);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (7, '数组', 1);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (8, '指针', 1);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (9, '结构体与共用体', 1);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (10, '条件判断', 1);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (11, '选择排序', 2);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (12, '图', 2);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (13, '散列查找', 2);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (14, '贪心算法', 2);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (15, '堆', 2);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (16, '二叉树', 2);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (17, '树基础', 2);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (18, '队列应用', 2);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (19, '堆栈应用及队列基础', 2);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (20, '线性表及堆栈基础', 2);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (21, '线性表', 2);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (22, '数据结构基本概念', 2);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (23, '归并排序', 2);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (24, '动态规划', 2);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (25, '分治算法', 2);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (26, '桶排序和基数排序', 2);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (27, '内存管理', 2);
INSERT INTO evaluation.question_type (type_id, type_name, type_subject_id) VALUES (28, '文件操作', 1);




INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (1, '线性表采用链式存储表示时，所有结点之间的存储单元地址可以连续也可以不连续。', 'T', 2, 21);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (2, '将N个数据按照从小到大顺序组织存放在一个单向链表中。如果采用二分查找，那么查找的平均时间复杂度是O(logN)。', 'F', 1, 21);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (3, '顺序存储方式插入和删除时效率太低，因此它不如链式存储方式好。 ', 'F', 3, 21);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (4, '在单链表中，要访问某个结点，只要知道该结点的指针即可。因此，单链表是一种随机存取结构。 ', 'F', 1, 21);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (5, '链式存储的优点是插入、删除元素时不会引起后续元素的移动，缺点是只能顺序访问各元素。 ', 'T', 2, 21);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (6, '(neuDS)在线性表的顺序存储结构中可实现快速的随机存取，而在链式存储结构中则只能进行顺序存取。 ', 'T', 3, 20);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (7, '取线性表的第i个元素的时间同i的大小有关。', 'F', 1, 20);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (8, '在具有头结点的链式存储结构中，头指针指向链表中的第一个元素结点。', 'F', 3, 20);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (9, '在一个设有头指针和尾指针的单链表中，执行删除该单链表中最后一个元素的操作与链表的长度无关。', 'F', 1, 20);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (10, '链式存储的优点是插入、删除元素时不会引起后续元素的移动，缺点是只能顺序访问各元素。', 'T', 3, 20);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (11, '通过对堆栈S操作：Push(S,1), Push(S,2), Pop(S), Push(S,3), Pop(S), Pop(S)。输出的序列为：123。', 'F', 2, 20);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (12, '若一个栈的输入序列为1，2，3，…，N，输出序列的第一个元素是i，则第j个输出元素是j−i−1。', 'F', 1, 20);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (13, 'Run the following operations on a stack S: Push(S,1), Push(S,2), Pop(S), Push(S,3), Pop(S), Pop(S). The output sequence must be {1, 2, 3}.', 'F', 2, 20);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (14, '若一个栈的输入序列为{1, 2, 3, 4, 5}，则不可能得到{3, 4, 1, 2, 5}这样的出栈序列。', 'T', 3, 20);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (15, '栈结构不会出现溢出现象。', 'F', 3, 20);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (16, 'If keys are pushed onto a stack in the order {1, 2, 3, 4, 5}, then it is impossible to obtain the output sequence {3, 4, 1, 2, 5}.', 'T', 2, 19);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (17, 'If keys are pushed onto a stack in the order abcde, then it\'s impossible to obtain the output sequence cedab. ', 'T', 1, 19);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (18, '通过对堆栈S操作：Push(S,1), Push(S,2), Pop(S), Push(S,3), Pop(S), Pop(S)。输出的序列为：123。', 'F', 3, 19);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (19, 'Suppose that an array is used to store a circular queue, the value of front must be less than or equal to the value of rear.', 'F', 1, 19);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (20, '队列适合解决处理顺序与输入顺序相同的问题。', 'T', 2, 19);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (21, 'An algorithm to check for balancing symbols in an expression uses a queue to store the partial expression. ', 'F', 3, 19);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (22, '栈和队列的存储方式，既可以是顺序方式，也可以是链式方式。 ', 'T', 2, 18);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (23, '栈是插入和删除只能在一端进行的线性表；队列是插入在一端进行，删除在另一端进行的线性表。 ', 'T', 3, 18);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (24, '若用data[1..m]表示顺序栈的存储空间，则对栈的进栈、出栈操作最多只能进行m次。 ', 'F', 2, 18);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (25, '栈是一种对进栈、出栈操作总次数做了限制的线性表。 ', 'F', 1, 18);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (26, '不论是入队列操作还是入栈操作,在顺序存储结构上都需要考虑"溢出"情况。 ', 'T', 3, 18);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (27, '队列是一种插入和删除操作分别在表的两端进行的线性表，是一种先进后出的结构。 ', 'F', 2, 18);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (28, '环形队列中有多少个元素可以根据队首指针和队尾指针的值来计算。 ', 'T', 1, 18);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (29, '在用数组表示的循环队列中，front值一定小于等于rear值。', 'F', 3, 18);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (30, '若采用“队首指针和队尾指针的值相等”作为环形队列为空的标志，则在设置一个空队时只需将队首指针和队尾指针赋同一个值，不管什么值都可以。 ', 'T', 1, 18);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (31, '存在一棵总共有2016个结点的二叉树，其中有16个结点只有一个孩子。', 'F', 2, 17);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (32, '设只包含根结点的二叉树高度为0，则高度为k的二叉树最小结点数为k+1。 ', 'T', 3, 17);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (33, '二叉树就是度为 2 的树。', 'F', 3, 17);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (34, '具有10个叶结点的二叉树中，有9个度为2的结点。 ', 'R', 1, 17);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (35, '在含有n个结点的树中，边数只能是n-1条。', 'T', 2, 17);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (36, '完全二叉树中，若一个结点没有左孩子，则它必是树叶。 ', 'T', 1, 17);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (37, '设深度为d（只有一个根结点时，d为1）的二叉树只有度为0和2的结点，则此类二叉树的结点数至少为2d-1 ', 'T', 3, 17);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (38, '在任意一棵二叉树中，分支结点的数目一定少于叶结点的数目。 ', 'F', 1, 17);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (39, '一棵有n个结点的二叉树，从上至下，从左到右用自然数依次编号，则编号为i的结点的左儿子的编号为2i(2i<n）,右儿子的编号是2i+1(2i+1<n)。 ', 'F', 1, 17);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (40, '已知一棵二叉树的先序遍历结果是ABC,　则CAB不可能是中序遍历结果。', 'T', 2, 16);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (41, '某二叉树的后序和中序遍历序列正好一样，则该二叉树中的任何结点一定都无右孩子。', 'T', 1, 16);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (42, '若A和B都是一棵二叉树的叶子结点，则存在这样的二叉树，其前序遍历序列为...A...B...，而中序遍历序列为...B...A...。', 'F', 3, 16);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (43, '若一个结点是某二叉树的中序遍历序列的最后一个结点，则它必是该树的前序遍历序列中的最后一个结点。', 'F', 2, 16);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (44, '将一棵完全二叉树存于数组中（根结点的下标为1）。则下标为23和24的两个结点是兄弟。 ', 'F', 1, 16);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (45, '一棵有124个结点的完全二叉树，其叶结点个数是确定的。', 'T', 3, 16);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (46, '某二叉树的前序和中序遍历序列正好一样，则该二叉树中的任何结点一定都无右孩子。', 'F', 2, 16);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (47, '某二叉树的后序和中序遍历序列正好一样，则该二叉树中的任何结点一定都无左孩子。', 'F', 2, 16);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (48, '某二叉树的后序和中序遍历序列正好一样，则该二叉树中的任何结点一定都无右孩子。 ', 'T', 1, 16);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (49, '完全二叉树的前序序列中，若结点u在结点v之前，则u一定是v的祖先。', 'F', 3, 16);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (50, '任何最小堆中从根结点到任一叶结点路径上的所有结点是有序的（从小到大）。', 'T', 3, 15);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (51, '在有N个元素的最大堆中，随机访问任意键值的操作可以在O(logN)时间完成', 'F', 1, 15);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (52, '最大堆（大顶堆、max-heap）的前序遍历结果是从大到小排列的。 ', 'F', 2, 15);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (53, 'For binary heaps with N elements, the BuildHeap function (which adjust an array of elements into a heap in linear time) does at most N−log(N+1) comparisons between elements. ', 'F', 1, 15);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (54, 'Store M elements in a hash table which is represented by an array of size S, the loading density is then M/S. ', 'T', 3, 13);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (55, 'In hashing, functions "insert" and "find" have the same time complexity.', 'T', 1, 13);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (56, 'Hash表的平均查找长度与处理冲突的方法无关。 ', 'F', 2, 13);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (57, '负载因子 (装填因子)是散列表的一个重要参数，它反映散列表的装满程度。', 'T', 3, 13);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (58, '当记录个数小于哈希表长度时，哈希查找平均查找长度必然为0。 ', 'F', 3, 13);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (59, 'There must be a collision if we insert a new element into a hash table with the loading density being 1. ', 'T', 1, 13);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (60, 'In a hash table, "synonyms"(同义词) means two elements being hashed into the same slot by two different hash functions.', 'F', 3, 13);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (61, 'It is still possible to have a collision even if we hash only 2 elements into a hash table of 100 cells.', 'T', 3, 13);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (62, '在散列检索中，“比较”操作一般也是不可避免的。 ', 'T', 1, 13);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (63, '将 10 个元素散列到 100 000 个单元的哈希表中，一定不会产生冲突。 ', 'F', 3, 13);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (64, '在散列表中，所谓同义词就是具有相同散列地址的两个元素。', 'T', 1, 13);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (65, '采用平方探测冲突解决策略（hi​(k)=(H(k)+i2)%11, 注意：不是±i2），将一批散列值均等于2的对象连续插入一个大小为11的散列表中，那么第4个对象一定位于下标为0的位置。', 'T', 2, 13);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (66, '若用平方探测法解决冲突，则插入新元素时，若散列表容量为质数，插入就一定可以成功。', 'F', 3, 13);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (67, 'If 7 elements have been stored in a hash table of size 13 at positions { 0, 1, 3, 4, 9, 10, 12 }, and the hash function is H(x)=x%13. Then an empty spot can\'t be found when inserting the element 26 wi', 'T', 2, 13);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (68, '当采用线性探测冲突解决策略时，非空且有空闲空间的散列表中无论有多少元素，不成功情况下的期望查找次数总是大于成功情况下的期望查找次数。', 'T', 3, 13);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (69, '将 10 个元素散列到 100 000 个单元的哈希表中，一定不会产生冲突。 ', 'F', 3, 13);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (70, 'Given a hash table with size 13. If only the positions with odd (奇数) indices are occupied (the index starts from 0), then when the quadratic probing is used, insertion of a new key into this hash tabl', 'T', 3, 13);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (71, 'If quadratic probing is used to resolve collisions, then a new insertion must be successful if the size of the hash table is a prime.', 'F', 1, 13);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (72, 'Linear probing is equivalent to double hashing with a secondary hash function of Hash2​(k)=1 . ', 'T', 3, 13);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (73, 'Quadratic probing is equivalent to double hashing with a secondary hash function of Hash2​(k)=k. ', 'F', 2, 13);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (74, 'If quadratic probing (hi​(k)=(H(k)+i2)%11. Note: it\'s not ±i2) is used to resolve collisions, to insert several elements, all with hash value being 2, into a hash table of size 11, then the 4th elemen', 'T', 3, 13);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (75, '无向连通图边数一定大于顶点个数减1。', 'F', 1, 12);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (76, '无向连通图所有顶点的度之和为偶数。', 'T', 2, 12);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (77, '无向连通图至少有一个顶点的度为1。', 'F', 3, 12);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (78, '用邻接表法存储图，占用的存储空间数只与图中结点个数有关，而与边数无关。', 'F', 1, 12);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (79, '用邻接矩阵法存储图，占用的存储空间数只与图中结点个数有关，而与边数无关。', 'T', 2, 12);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (80, '在一个有向图中，所有顶点的入度与出度之和等于所有边之和的2倍。', 'T', 1, 12);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (81, '在任一有向图中，所有顶点的入度之和等于所有顶点的出度之和。', 'T', 2, 12);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (82, '用一维数组G[]存储有4个顶点的无向图如下：G[] = { 0, 1, 0, 1, 1, 0, 0, 0, 1, 0 }', 'T', 2, 12);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (83, '如果表示图的邻接矩阵是对称矩阵，则该图一定是无向图。', 'F', 2, 12);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (84, '如果表示有向图的邻接矩阵是对称矩阵，则该有向图一定是完全有向图。', 'F', 3, 12);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (85, 'For a graph, if each vertex has an even degree or only two vertexes have odd degree, we can find a cycle that visits every edge exactly once ', 'F', 2, 12);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (86, '图的深度优先遍历非递归算法通常采用队列实现，广度优先遍历非递归算法通常采用堆栈实现。 ', 'F', 3, 12);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (87, '如果无向图G必须进行3次深度优先搜索才能访问其所有顶点，则G一定有3个连通分量。 ', 'T', 3, 12);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (88, '图的深度优先遍历非递归算法通常采用栈实现，广度优先遍历非递归算法通常采用队列实现。 ', 'T', 3, 12);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (89, '如果无向图G必须进行两次广度优先搜索才能访问其所有顶点，则G中一定有回路。', 'F', 2, 12);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (90, '如果无向图G必须进行两次广度优先搜索才能访问其所有顶点，则G一定有2个连通分量。', 'T', 3, 12);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (91, '广度优先搜索遍历图的时间复杂度和深度优先探索遍历相同。 ', 'T', 1, 12);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (92, '对N个记录进行简单选择排序，比较次数和移动次数分别为O(N2)和O(N)。', 'T', 3, 11);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (93, '直接选择排序算法在最好情况下的时间复杂度为O（N）。 ', 'F', 3, 11);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (94, '直接选择排序的时间复杂度为O(n2)，不受数据初始排列的影响。 ', 'T', 3, 11);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (95, '(neuDS)排序的稳定性是指排序算法中的比较次数保持不变，且算法能够终止。 ', 'F', 3, 11);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (96, '(neuDS)直接插入排序算法在最好情况下的时间复杂度为O(n)。 ', 'T', 2, 11);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (97, '内排序要求数据一定要以顺序方式存储', 'F', 2, 11);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (98, '堆排序是稳定的排序算法。（ ） ', 'F', 1, 11);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (99, '堆是完全二叉树，完全二叉树不一定是堆。（ ） ', 'T', 2, 11);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (100, '（101,88,46,70,34,39,45,58,66,10）是堆。 ', 'T', 1, 11);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (101, '有一大根堆，堆中任意结点的关键字均大于它的左右孩子关键字，则其具有最小值的结点一定是一个叶子结点并可能在堆的最后两层中。 ', 'T', 1, 11);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (102, 'C程序可以省略main( )函数。', 'F', 2, 2);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (103, '在C语言中，一个语句可以书写在不同行上。', 'T', 2, 2);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (104, 'C语言源程序文件通过了编译、连接之后，生成一个后缀为.EXE的文件。  ', 'T', 1, 2);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (105, 'C编译器可以找出C源程序中所有的语法错误和逻辑错误。', 'F', 2, 2);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (106, 'C 语言的标识符由字母、数字和其他任意字符组成。', 'F', 2, 2);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (107, '不同类型的变量，在内存中占用相同大小的空间。', 'F', 3, 2);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (108, '在C语言中，标识符中的英文字母是区分大小写的。', 'T', 3, 2);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (109, '程序调试就是找出并改正C源程序中的语法错误。', 'F', 3, 2);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (110, 'C语言的源程序是可以直接运行的。', 'F', 1, 2);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (111, '在 C 程序中，APH 和 aph 代表不同的变量。', 'T', 2, 2);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (112, '单步跟踪（Trace Step by Step）是常用的程序调试方法，即一步一步跟踪程序的执行过程，同时观察变量的变化情况。', 'T', 1, 2);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (113, '程序设计语言必须具备数据表达和流程控制的功能。', 'T', 2, 2);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (114, '在C语言中，一行可以书写多个语句。  ', 'T', 2, 2);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (115, '在C程序运行过程中，其值不能被改变的量称为常量，其值可以改变的量称为变量。', 'T', 1, 4);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (116, '在C语言的数据类型中，float的含义是单精度浮点型，double的含义是双精度浮点型。', 'T', 3, 4);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (117, '以下程序段符合C语言语法。k = 1;
int k; ', 'F', 2, 4);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (118, 'C程序中定义的变量，代表内存中的一个存储单元。', 'T', 2, 4);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (119, '在 C 程序中，APH 和 aph 代表不同的变量。', 'T', 2, 4);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (120, '在C语言中，单目运算符需要2个操作数。', 'F', 2, 4);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (121, '若变量定义为int fahr; ，则5(fahr-32)/9是符合C语言语法的表达式。', 'F', 1, 4);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (122, '若变量定义为double x;，则x % 2是符合C语言语法的表达式。', 'F', 3, 4);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (123, '若变量定义为int n;，当n的绝对值大于1时，则表达式1/n的值恒为 0。', 'T', 1, 4);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (124, '若变量定义为int fahr; ，则表达式5 * (fahr - 32) / 9和表达式5 / 9 * (fahr - 32)是等价的。', 'F', 2, 4);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (125, '若变量定义为int x, y; ，则x + y = 22是符合C语言语法的表达式。', 'F', 3, 4);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (126, '假设赋值运算符的优先级比算术运算符高，执行以下程序段后，n的值为10。int n; 
n = 10 + 2;', 'T', 3, 4);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (127, '假设某段C语言程序中定义了三个变量a、b和c并且三个变量都不为0，则表达式a / b * c和a * c / b是等价的，其值相同。', 'F', 1, 4);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (128, '执行以下程序段后，输出 i = 10, j = 20。
int i, j;  
i = 10; 
j = 20; 
printf("i = %d, j = %d", j, i);', 'F', 1, 4);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (129, 'if-else语句的一般形式如下，其中的语句1、语句2只能是一条语句。
if (表达式) 
    语句1
else 
    语句2  ', 'T', 3, 10);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (130, '为了检查以下if-else语句的两个分支是否正确，至少需要设计2组测试用例，即number的取值至少有两组（偶数和奇数）。
if(number % 2 == 0){
    printf("Tne number is even.\\n");
}else{ 
    printf("Tne number is odd.\\n");
}
', 'T', 1, 10);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (131, '省略else的if语句的一般形式如下，若表达式的值为“真”，则执行语句1；否则，就什么也不做。
if (表达式) 
   语句1 ', 'T', 1, 10);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (132, '为了检查以下省略else的if语句的分支是否正确，至少需要设计3组测试用例，即grade的取值至少有三组（小于60、等于60、大于60）。
if(grade < 60){    
    printf("Fail\\n"); 
}', 'T', 2, 10);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (133, '执行以下程序段后，y的值为-1。
x = -1; 
if (x < 0){
    y = -1; 
}
y = 0;', 'F', 2, 10);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (134, '以下程序段的功能是：将变量a、b的最大值赋给max。 
max = a;
if ( max < b ){ 
    max = b;
}', 'T', 2, 10);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (135, '如果变量已经正确定义，则执行以下程序段后，x的值不变。
x = 4; 
if (x < 0){ 
    y = -1;
}else if (x = 0){
    y = 0;
}else{ 
    y = 1;
}  ', 'F', 3, 10);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (136, '为了检查以下else-if语句的三个分支是否正确，至少需要设计5组测试用例，即x的取值至少有五组（小于0的数、0、大于0且小于15的数、15和大于15的数）。
if (x < 0){
    y = 0;
}else if (x <= 15){
    y = 4 * x / 3;
} else{ 
    y = 2.5 * x - 10.5;
}   ', 'T', 1, 10);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (137, 'while语句的一般形式如下，当表达式的值为“真”时，循环执行，直到表达式的值为“假”，循环中止并继续执行while的下一条语句。
while (表达式)
    循环体语句', 'T', 2, 5);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (138, 'while语句的一般形式如下，其中的循环体语句只能是一条语句。
while (表达式)
    循环体语句', 'T', 2, 5);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (139, '若变量已正确定义，以下while循环结束时，i的值为11。
i = 1;
while (i <= 10){
    printf("%d\\n", i);
}', 'F', 1, 5);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (140, '若变量已正确定义，执行以下while语句将陷入死循环。
i = 1;
while (i <= 10) ;
    i++;', 'T', 3, 5);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (141, '若变量已正确定义，执行以下程序段，输入负数时，循环结束。
total = 0;
scanf ("%d", &score);
while(score >= 0){   
    total = total + score; 
    scanf ("%d", &score); 
}', 'T', 3, 5);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (142, '若变量已正确定义，执行以下程序段，输入0或者负数时，循环结束。
total = 0;
scanf ("%d", &score);
while(score > 0){   
    total = total + score; 
    scanf ("%d", &score); 
}', 'T', 2, 5);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (143, '执行以下程序段，将输出10。
int i = 10;
while (i < 10){
    printf("%d\\n", i);
}', 'F', 3, 5);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (144, 'do - while语句的一般形式如下，第一次进入循环时，首先执行循环体语句，然后再检查循环控制条件，即计算表达式，若值为“真”，继续循环，直到表达式的值为“假”，循环结束，执行do - while的下一条语句。
do{
    循环体语句
}while(表达式);', 'T', 3, 5);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (145, 'do - while语句的一般形式如下，其中的循环体语句至少执行一次。
do{
    循环体语句
}while(表达式);', 'T', 2, 5);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (146, 'do-while循环的while后的分号可以省略。', 'F', 2, 5);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (147, 'do-while循环至少要执行一次循环语句。', 'T', 1, 5);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (148, '在循环中使用break语句或者continue语句，其作用是相同的。', 'F', 2, 5);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (149, '函数的实参和形参都可以是变量、常量和表达式。', 'F', 2, 3);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (150, '按照C语言的规定，在参数传递过程中，既可以将实参的值传递给形参，也可以将形参的值传递给实参，这种参数传递是双向的。', 'F', 2, 3);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (151, '按照C语言的规定，实参和形参的命名不得重复。', 'F', 1, 3);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (152, '在C语言中，可以将主调函数放在被调函数的后面，省略函数的声明。', 'T', 3, 3);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (153, '在C语言的函数定义中，如果不需要返回结果，就可以省略return语句。', 'T', 3, 3);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (154, '在C语言的函数定义中，如果省略了return语句，函数就无法返回主调函数。', 'F', 2, 3);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (155, '全局变量只能定义在程序的最前面，即第一个函数的前面。', 'F', 3, 3);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (156, '全局变量与局部变量的作用范围相同，不允许它们同名。', 'F', 3, 3);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (157, '为了便于计算机存储管理，C语言把保存所有变量的数据区，分成动态存储区和静态存储区，静态局部变量被存放在动态存储区。', 'F', 1, 3);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (158, '自动变量如果没有赋值，其值被自动赋为0。', 'F', 1, 3);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (159, '静态局部变量如果没有赋值，其存储单元中将是随机值。', 'F', 3, 3);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (160, 'C的double类型数据可以精确表示任何实数。', 'F', 1, 6);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (161, '在C 语言中，常量和变量都有数据类型。', 'T', 1, 6);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (162, '与float型数据相比，double型数据的精度高，取值范围大。', 'T', 1, 6);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (163, '08是正确的整型常量。', 'F', 3, 6);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (164, '表达式0195是一个八进制整数。', 'F', 3, 6);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (165, '表达式 !x 等价于x != 1。', 'F', 1, 6);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (166, '运算符“+”不能作为单目运算符。', 'F', 3, 6);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (167, '如果运算符“*”和“/”都是右结合的，则表达式 10 *6 / 5 值是10。', 'T', 1, 6);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (168, 's(s-a)(s-b)(s-c) 是合法的C语言表达式。', 'F', 3, 6);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (169, '表达式 !!6的值是6。', 'F', 1, 6);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (170, '表达式 ~(~2<<1)的值是5。', 'T', 3, 6);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (171, '表达式 !(x>0||y>0) 等价于!(x>0)&&!(y>0)。', 'T', 1, 6);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (172, '若表达式sizeof(int)的值为4，则int类型数据可以表示的最大整数为231−1。', 'T', 2, 6);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (173, '表达式 (z=0, (x=2)||(z=1),z) 的值是1。', 'F', 3, 6);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (174, 'C 语言的运算符只有单目运算符和双目运算符两种。', 'F', 3, 6);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (175, '在所有的关系运算符（>=、>、==、!=、<=、<）中，优先级最低的运算符是“==、!=”。', 'T', 2, 6);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (176, '一维数组定义的一般形式如下，其中的类型名指定数组中每个元素的类型。
类型名 数组名[数组长度]；', 'T', 3, 7);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (177, '一维数组定义的一般形式如下，其中的类型名指定数组变量的类型。
类型名 数组名[数组长度]；', 'F', 3, 7);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (178, '一维数组定义的一般形式如下，其中的数组长度是一个整型常量表达式，给定数组的大小。
类型名 数组名[数组长度]；', 'T', 1, 7);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (179, '数组定义中，数组名后是用方括号括起来的常量表达式，不能用圆括号。', 'T', 1, 7);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (180, '以下定义了一个一维数组str，该数组可以存放81个字符型数据。 
char str[81]; ', 'T', 3, 7);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (181, '同一个数组中的每个元素都具有相同的数据类型，有统一的标识符即数组名，用不同的序号即下标来区分数组中的各元素。', 'T', 2, 7);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (182, '在定义数组之后，根据数组中元素的类型及个数，在内存中分配一段连续存储单元用于存放数组中的各个元素。', 'T', 3, 7);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (183, '数组定义后，数组名表示该数组所分配连续内存空间中第一个单元的地址，即首地址。', 'T', 3, 7);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (184, '数组定义后，数组名的值是一个地址，可以被修改。', 'F', 1, 7);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (185, '数组定义后，只能引用单个的数组元素，而不能一次引用整个数组。', 'T', 1, 7);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (186, '一维数组定义的一般形式如下：
类型名 数组名[数组长度]；
数组元素引用的一般形式如下：
数组名[下标]
在引用数组元素时，下标的合理取值范围是[0，数组长度-1]，下标不能越界。
  
', 'T', 3, 7);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (187, '变量初始化的含义，就是在定义变量时对变量赋值。', 'T', 3, 7);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (188, '一维数组初始化的一般形式如下，即在定义数组时，对数组元素赋初值。其中初值表中依次放着数组元素的初值。
类型名 数组名[数组长度] = {初值表}；', 'T', 1, 7);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (189, '二维数组定义的一般形式如下，其中的类型名指定数组中每个元素的类型。 
类型名 数组名[行长度][列长度]；', 'T', 3, 7);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (190, '二维数组定义的一般形式如下，其中的类型名指定数组名的类型。
类型名 数组名[行长度][列长度]；', 'F', 2, 7);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (191, '二维数组定义的一般形式如下，其中的行长度和列长度都是整型常量表达式。 
类型名 数组名[行长度] [列长度]；', 'T', 3, 7);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (192, '以下定义了一个三维数组array_day。 
int array_day[10][10][10]；', 'T', 1, 7);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (193, '以下定义了一个二维数组tab，该数组可以存放7个整型数据。
int tab[3][4]; ', 'F', 3, 7);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (194, '执行语句int *p = 1000;后，指针变量p指向地址为1000的变量。', 'F', 3, 8);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (195, '语句int *p, q, r; 定义了3个指针变量。', 'F', 1, 8);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (196, '执行语句int *p; 后，指针变量p只能指向int类型的变量。', 'T', 1, 8);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (197, '不同类型的指针变量是可以直接相互赋值的。', 'F', 3, 8);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (198, '语句int *p; *p = 50;执行时，不会有任何错误。', 'F', 2, 8);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (199, '要通过函数调用来改变主调函数中某个变量的值，可以把指针作为函数的参数。', 'T', 1, 8);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (200, '只要将多个指针作为函数的参数，函数就一定会返回多个值。', 'F', 2, 8);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (201, '数组的基地址是在内存中存储数组的起始位置，数组名本身就是一个地址即指针值。', 'T', 1, 8);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (202, '对于定义int a[10],*p=a; 语句p=a+1;和a=a+1;都是合法的。', 'F', 2, 8);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (203, '两个任意类型的指针可以使用关系运算符比较大小。  ', 'F', 2, 8);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (204, '冒泡排序效率较高，因为它只需要约你n^2/2次比较。  ', 'F', 3, 8);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (205, '字符串常量在内存中的存放位置由系统自动安排。', 'T', 1, 8);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (206, '字符串常量实质上是一个指向该字符串首字符的指针常量。', 'T', 1, 8);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (207, '调用printf函数，%s的格式输出字符串时，字符数组名、字符指针和字符串常量都可以作为输出参数。', 'T', 1, 8);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (208, '调用strcmp函数比较字符串大小时，通常较长的字符串会较大。', 'F', 3, 8);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (209, '结构是变量的集合，可以按照对基本数据类型的操作方法单独使用其成员变量。', 'T', 3, 1);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (210, '结构是变量的集合，可以按照对同类型变量的操作方法单独使用其成员变量。', 'F', 1, 1);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (211, '在定义嵌套的结构类型时，必须先定义成员的结构类型，再定义主结构类型。', 'T', 3, 1);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (212, '一个结构类型变量所占的内存空间是其各个成员所占内存空间之和。', 'T', 2, 1);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (213, '不同类型的结构变量之间也可以直接赋值。  ', 'F', 1, 1);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (214, '结构数组是结构与数组的结合体，与普通数组的不同之处在于每个数组元素都是一个结构类型的数据，包括多个成员项。', 'T', 2, 1);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (215, '对于结构数组s，既可以引用数组的元素s[i]，也可以引用s[i]中的结构成员。', 'T', 2, 1);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (216, '结构指针就是指向结构类型变量的指针。  ', 'T', 2, 1);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (217, '假设结构指针p已定义并正确赋值，其指向的结构变量有一个成员是int型的num，则语句 *p.num = 100; 是正确的。  ', 'F', 1, 1);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (218, '使用结构指针作为函数参数只要传递一个地址值,因此,能够提高参数传递的效率。', 'T', 2, 1);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (219, '语句 int *p[5]; 定义了一个指针数组p，用于指向一个有5个元素的数组。', 'F', 3, 8);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (220, '对于 int 型的二级指针变量，它既可以指向同类型的一级指针变量，也可以指向同类型的普通（非指针）变量。', 'F', 2, 8);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (221, '定义一个指针数组并初始化赋值若干个字符串常量，则指针数组并不存放这些字符串，而仅仅指向各个字符串。', 'T', 3, 8);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (222, '如果函数的返回类型是指针，则可以返回函数内部任意变量的地址。', 'F', 2, 8);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (223, '如果函数的返回类型是指针，则可以返回0。', 'T', 2, 8);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (224, '堆是一种完全二叉树，可以是最大堆或最小堆', 'T', 2, 15);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (225, ' 在最大堆中，每个父节点的值都大于等于其子节点的值', 'T', 3, 15);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (226, '堆是一个线性数据结构。', 'F', 1, 15);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (227, '插入一个元素到堆时，时间复杂度为O(log n)', 'T', 2, 15);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (228, '堆通常用数组来实现，父节点的索引为i时，左子节点的索引为2i，右子节点的索引为2i+1', 'T', 3, 15);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (229, ' 堆不适合用于快速查找最小值。', 'T', 3, 15);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (230, '线性表是一种数据元素按线性关系排列的数据结构，每个数据元素最多只有一个前驱和一个后继元素', 'T', 2, 20);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (231, '线性表是一种数据元素按线性关系排列的数据结构，每个数据元素最多只有一个前驱和一个后继元素', 'T', 3, 21);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (232, '线性表的基本操作包括插入、删除、查找和更新', 'T', 1, 21);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (233, ' 线性表只能用数组实现，不能用链表实现', 'F', 2, 21);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (234, '在顺序表中，插入或删除元素的时间复杂度是O(n)，因为需要移动其他元素', 'T', 3, 21);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (235, '在链表中，插入或删除元素的时间复杂度是O(1)，前提是已知操作位置', 'T', 3, 21);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (236, ' 数据结构是计算机存储、组织数据的方式，是计算机科学的基础学科之一。', 'T', 1, 22);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (237, '数据结构中的“数据”指的是数据项的集合', 'T', 2, 22);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (238, ' 数据结构中的“操作”包括插入、删除、查找、修改等对数据的基本操作。', 'T', 1, 22);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (239, ' 链式存储结构是一种按顺序存储元素的数据结构，元素在内存中是连续存储的。', 'F', 3, 22);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (240, ' 数据结构的基本操作是线性的，任何操作的时间复杂度都是O(1)。', 'F', 3, 22);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (241, '数据结构只包括线性结构和非线性结构，线性结构包括数组、链表、栈和队列。', 'T', 2, 22);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (242, ' 数据结构的选择对程序的效率有直接影响，合理的数据结构可以提高算法的时间复杂度和空间复杂度。', 'T', 1, 22);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (243, ' 顺序存储结构的优点是支持高效的随机访问，但其缺点是插入和删除元素时需要移动大量数据。', 'T', 2, 22);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (259, 'C语言中，文件操作函数 fopen() 的作用是打开一个文件。', 'T', 1, 28);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (260, 'C语言中，文件操作函数 fclose() 用于打开文件。', 'F', 2, 28);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (261, 'C语言中，fopen() 函数的第二个参数可以是 "r"、"w" 或 "a"。', 'T', 3, 28);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (262, 'C语言中，文件指针的类型是 FILE*。', 'T', 1, 28);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (263, 'C语言中，fprintf() 函数用于输出到文件，printf() 函数用于输出到屏幕。', 'T', 2, 28);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (264, 'C语言中，使用 fopen() 打开文件时，如果文件不存在，返回 NULL。', 'T', 3, 28);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (265, 'C语言中，fread() 函数用于从文件中读取数据。', 'T', 2, 28);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (266, 'C语言中，使用 fseek() 函数可以定位到文件的末尾。', 'T', 1, 28);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (267, 'C语言中，向文件末尾追加数据时，可以使用 "a" 模式打开文件。', 'T', 3, 28);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (268, 'C语言中，fread() 和 fwrite() 函数可以用于读取和写入二进制数据。', 'T', 2, 28);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (269, 'C语言中，fscanf() 与 scanf() 的不同之处在于，前者用于从文件中读取数据。', 'T', 3, 28);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (270, 'C语言中，remove() 函数可以删除一个文件。', 'T', 3, 28);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (271, 'C语言中，rename() 函数用于重命名文件。', 'T', 1, 28);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (272, 'C语言中，fopen() 函数返回 NULL 表示文件打开失败。', 'T', 2, 28);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (273, 'C语言中，ftell() 函数可以获取文件的当前位置。', 'T', 3, 28);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (274, 'C语言中的 malloc() 函数用于动态分配内存。', 'T', 1, 27);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (275, 'C语言中的 free() 函数用于释放内存。', 'T', 1, 27);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (276, 'C语言中的 calloc() 函数与 malloc() 函数不同，它会初始化分配的内存块。', 'T', 2, 27);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (277, 'C语言中的 realloc() 函数可以改变已分配内存的大小。', 'T', 2, 27);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (278, 'C语言中，malloc() 分配的内存不初始化，内容是随机的。', 'T', 3, 27);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (279, 'C语言中的 free() 函数只能释放通过 malloc() 分配的内存。', 'F', 2, 27);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (280, 'C语言中，使用指针时需要手动释放内存，否则会导致内存泄漏。', 'T', 1, 27);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (281, 'C语言中，数组和指针的内存管理是相同的，可以通过 free() 函数释放数组的内存。', 'F', 3, 27);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (282, 'C语言中的内存泄漏指的是程序中未释放的内存。', 'T', 2, 27);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (283, 'C语言中，指针类型与所指向数据类型相关，必须匹配才能正确访问内存。', 'T', 1, 27);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (284, 'C语言中，未初始化的指针称为野指针，使用野指针可能会导致程序崩溃。', 'T', 3, 27);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (285, 'C语言中的堆内存和栈内存的分配是由程序员控制的。', 'F', 2, 27);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (286, 'C语言中，使用 realloc() 时，如果重新分配内存失败，它会返回 NULL。', 'T', 2, 27);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (287, 'C语言中，动态分配的内存如果没有通过 free() 释放，会造成内存泄漏。', 'T', 1, 27);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (288, 'C语言中，malloc() 返回的内存地址是指向已分配内存块的指针。', 'T', 3, 27);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (289, '桶排序是一种基于比较的排序算法。', 'F', 1, 26);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (290, '基数排序是一种稳定的排序算法。', 'T', 1, 26);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (291, '桶排序适用于对数据进行范围划分后排序的情况。', 'T', 2, 26);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (292, '基数排序需要多个桶，每个桶只包含单个元素。', 'F', 3, 26);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (293, '桶排序的时间复杂度取决于数据的分布情况。', 'T', 2, 26);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (294, '基数排序是通过比较数字的每一位来进行排序的。', 'T', 3, 26);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (295, '桶排序不需要进行比较操作，而是通过数据分布进行排序。', 'T', 2, 26);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (296, '桶排序的空间复杂度通常较高，因为它需要创建多个桶。', 'T', 3, 26);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (297, '基数排序无法处理负数数据。', 'F', 2, 26);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (298, '桶排序的适用场景主要是数值范围较小且分布均匀的情况。', 'T', 1, 26);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (299, '基数排序与计数排序类似，但基数排序使用的是每一位的数字。', 'T', 3, 26);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (300, '基数排序可以应用于字符串排序。', 'T', 1, 26);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (301, '桶排序的稳定性取决于桶内排序算法的稳定性。', 'T', 2, 26);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (302, '基数排序的时间复杂度通常是 O(nk)，其中 n 是元素个数，k 是数字的最大位数。', 'T', 3, 26);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (303, '基数排序可以用于处理浮点数数据。', 'F', 1, 26);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (304, '分治算法将问题分解为若干个子问题，通过递归求解这些子问题。', 'T', 1, 25);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (305, '分治算法的关键思想是通过将问题不断分割，直到问题足够简单。', 'T', 2, 25);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (306, '在分治算法中，所有的子问题都必须是相互独立的。', 'F', 3, 25);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (307, '分治算法的时间复杂度通常可以通过递归树分析得到。', 'T', 2, 25);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (308, '分治算法适用于具有重叠子问题的情况。', 'F', 1, 25);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (309, '分治算法通过合并操作将子问题的解结合成原问题的解。', 'T', 3, 25);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (310, '归并排序是一种典型的分治算法。', 'T', 1, 25);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (311, '快速排序是一种分治算法，通过选择一个基准元素进行分割。', 'T', 2, 25);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (312, '分治算法的“分”操作和“合”操作是相互独立的。', 'F', 3, 25);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (313, '分治算法适用于所有类型的问题，无论问题的规模如何。', 'F', 2, 25);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (314, '分治算法通常需要递归函数来处理子问题。', 'T', 1, 25);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (315, '在分治算法中，合并操作的复杂度通常是 O(n)。', 'T', 3, 25);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (316, '动态规划和分治算法的主要区别是动态规划需要记忆化子问题的结果，而分治算法不需要。', 'T', 2, 25);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (317, '分治算法不适合用于求解最短路径问题。', 'F', 3, 25);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (318, '分治算法的核心是分而治之。', 'T', 1, 25);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (319, '动态规划是一种通过分解问题来解决最优化问题的算法。', 'T', 1, 24);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (320, '动态规划的核心思想是将问题分解为相互独立的子问题。', 'F', 1, 24);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (321, '动态规划通过记忆化存储子问题的解，避免重复计算。', 'T', 2, 24);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (322, '动态规划和分治算法的主要区别在于，动态规划会记录并重用子问题的解，而分治算法则不记录。', 'T', 3, 24);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (323, '动态规划适用于有重叠子问题的最优化问题。', 'T', 2, 24);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (324, '动态规划只能用于求解最大值或最小值问题，不能用于其他类型的问题。', 'F', 3, 24);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (325, '动态规划常常用于解决背包问题、最长公共子序列问题等。', 'T', 1, 24);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (326, '动态规划通过从小问题到大问题的顺序求解，逐步构建最终解。', 'T', 2, 24);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (327, '动态规划的状态转移方程是解决问题的关键。', 'T', 1, 24);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (328, '动态规划的时间复杂度通常与问题的规模成正比。', 'F', 3, 24);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (329, '动态规划中，每个子问题的解只能计算一次，然后存储以供后续使用。', 'T', 2, 24);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (330, '动态规划的状态可以通过递归来定义，但通常通过迭代方式实现。', 'T', 1, 24);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (331, '动态规划的优化通常通过减少状态空间来降低时间复杂度。', 'T', 3, 24);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (332, '在动态规划中，解决子问题时需要确保所有子问题的解是先计算的。', 'T', 2, 24);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (333, '动态规划可以应用于具有无后效性的问题。', 'F', 3, 24);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (334, '归并排序是一种基于比较的排序算法。', 'T', 1, 23);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (335, '归并排序的时间复杂度始终是 O(n log n)。', 'T', 2, 23);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (336, '归并排序是一种稳定的排序算法。', 'T', 2, 23);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (337, '归并排序是非递归的排序算法。', 'F', 3, 23);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (338, '归并排序适用于大规模数据的排序。', 'T', 1, 23);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (339, '归并排序通过递归方式将数组分割成较小的子数组，并将其合并。', 'T', 2, 23);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (340, '归并排序在最坏情况下的空间复杂度是 O(n)。', 'T', 3, 23);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (341, '归并排序的核心思想是将两个已排序的子数组合并为一个有序数组。', 'T', 2, 23);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (342, '归并排序对数据的初始排列方式没有依赖，始终表现出 O(n log n) 的时间复杂度。', 'T', 3, 23);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (343, '归并排序可以通过原地排序方式实现，无需额外空间。', 'F', 2, 23);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (344, '归并排序适用于链表排序，因为它不依赖于随机访问。', 'T', 1, 23);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (345, '归并排序比快速排序更适合排序几乎有序的数据。', 'F', 3, 23);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (346, '归并排序的最坏时间复杂度为 O(n log n)，不会退化为 O(n^2)。', 'T', 2, 23);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (347, '归并排序是一种稳定的排序算法，意味着相等的元素排序后顺序不变。', 'T', 1, 23);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (348, '归并排序需要 O(n) 的额外空间来合并两个子数组。', 'T', 3, 23);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (349, '栈是一种先进后出（LIFO）的数据结构。', 'T', 1, 19);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (350, '队列是一种先进先出（FIFO）的数据结构。', 'T', 1, 19);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (351, '栈和队列都可以使用数组或链表实现。', 'T', 2, 19);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (352, '在栈中，元素可以在任何位置插入或删除。', 'F', 2, 19);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (353, '队列的插入操作总是发生在队列的尾部，删除操作总是发生在队列的头部。', 'T', 1, 19);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (354, '栈常用于递归问题的求解和表达式的计算。', 'T', 2, 19);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (355, '队列可以用于实现任务调度和生产者消费者问题。', 'T', 2, 19);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (356, '栈和队列都支持常数时间复杂度的插入和删除操作。', 'T', 1, 19);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (357, '在队列中，元素的删除操作是通过指向头部指针进行的。', 'T', 3, 19);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (358, '队列支持双端插入和删除操作，称为双端队列。', 'T', 3, 19);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (359, '贪心算法每次选择当前看起来最优的解。', 'T', 1, 14);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (360, '贪心算法通常能够得到全局最优解。', 'F', 2, 14);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (361, '贪心算法不需要回溯。', 'T', 1, 14);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (362, '贪心算法适用于所有问题，尤其是最优化问题。', 'F', 3, 14);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (363, '贪心算法要求每次选择局部最优解，且每次选择后无法回退。', 'T', 2, 14);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (364, '在贪心算法中，选择局部最优解时不考虑后续的选择。', 'T', 3, 14);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (365, '贪心算法的选择性步骤与动态规划不同，后者需要存储中间结果。', 'T', 1, 14);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (366, '贪心算法适用于有“贪心选择性质”和“最优子结构”的问题。', 'T', 2, 14);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (367, '贪心算法可以用于解决背包问题。', 'F', 3, 14);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (368, '贪心算法能保证得到最优解的前提是“无后效性”。', 'T', 2, 14);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (369, '贪心算法无法应用于图的最短路径问题。', 'F', 3, 14);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (370, '在解决最小生成树问题时，贪心算法能给出正确的最优解。', 'T', 1, 14);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (371, '贪心算法是一种适用于全局最优化的算法。', 'F', 3, 14);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (372, '贪心算法在每一步选择时，只关心局部解，忽略全局解的影响。', 'T', 2, 14);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (373, '贪心算法通常需要递归或迭代来实现问题求解。', 'T', 1, 14);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (388, '结构体是一种用户自定义的数据类型，用来组合不同类型的数据。', 'T', 1, 9);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (389, '结构体中的成员变量占用的内存空间是连续的。', 'T', 2, 9);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (390, '共用体中的所有成员共享同一块内存。', 'T', 1, 9);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (391, '在结构体中，每个成员变量都有独立的内存空间。', 'T', 2, 9);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (392, '结构体和共用体的主要区别在于内存分配方式。', 'T', 3, 9);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (393, '结构体和共用体的每个成员变量都有自己的名称和内存位置。', 'F', 3, 9);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (394, '在共用体中，任何一个成员的改变都会影响其他成员。', 'T', 2, 9);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (395, '结构体和共用体都可以包含指针类型的成员。', 'T', 1, 9);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (396, '共用体的大小等于最大成员变量的大小。', 'T', 2, 9);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (397, '结构体和共用体都支持嵌套使用，即一个结构体可以包含另一个结构体，或共用体可以包含结构体。', 'T', 1, 9);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (398, '结构体的初始化可以通过指定每个成员的值进行，甚至可以跳过某些成员。', 'T', 2, 9);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (399, '结构体变量的大小等于所有成员大小之和，不考虑内存对齐。', 'F', 3, 9);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (400, '共用体只能存储一种数据类型的值。', 'T', 2, 9);
INSERT INTO evaluation.question_judge (question_id, question_name, question_answer, question_level, question_type_id) VALUES (401, '共用体的成员变量可以有不同的数据类型。', 'T', 1, 9);




INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (1, '上机运行【例1-1】，当输入13时，会输出一个错误的结果，其原因是（ ）。', 'printf( )使用了错误的格式控制符', 'for循环语句多执行了一次，计算结果是14的阶乘', 'for循环语句少执行了一次，计算结果是12的阶乘', '运算结果超出了整数的取值范围', 2, 'D', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (2, '在【例1-1】中，C程序从（ ）函数开始运行。', 'factorial( )', 'main( )', '第一个', '无法确定', 2, 'B', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (3, '以下说法中正确的是( )。', 'C语言程序总是从第一个定义的函数开始执行', '总是从main（）函数开始执行', 'C语言程序中，要调用的函数必须在main（）中定义', 'main（）函数必须放在程序的最开始部分', 2, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (4, '程序与数据一样，共同存储在存储器中。当程序要运行时，当前准备运行的指令从内存被调入CPU中，由CPU处理这条指令。这种将程序与数据共同存储的思想就是目前绝大多数计算机采用的（ ）模型的存储程序概念。', '冯•诺伊曼', '阿兰•图灵', '克劳德•香农', '西蒙•克雷', 2, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (5, '下列( )不是C语言所表现出来的不足之处。', '数据类型检查不严格', '表达式容易出现二义性', '可移植性差', '不能自动检查数据越界', 2, 'C', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (6, '程序员要想调用输入输出函数，需要在程序的开头写上语句( )。', '#include <stdlib.h>', '#include <stdio.h>', '#include <math.h>', '#include <string.h>', 2, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (9, '若变量已正确定义，对以下while循环结束条件的准确描述是（）。
flag = 1;
denominator = 1;
item = 1.0;
pi = 0;
while(fabs(item) >= 0.0001){
     item = flag * 1.0 / denominator;
     pi = pi + item;
     flag = -flag;
     denominator = denominator + 2;
}', 'item的绝对值小于0.0001', 'item的绝对值大于0.0001', 'item的绝对值等于0.0001', 'item的绝对值不等于0.0001

', 5, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (10, '若变量已正确定义，以下while循环正常结束时，累加到pi的最后一项item的值满足（ ）。
flag = 1;
denominator = 1;
item = 1.0;
pi = 0;
while(fabs(item) >= 0.0001){
  item = flag * 1.0 / denominator;
  pi = pi + item;
  flag = -flag;
  denominator = denominator + 2;
}', 'item的绝对值小于0.0001', 'item的绝对值大于0.0001

', 'item的绝对值大于等于0.0001', 'item的绝对值小于等于0.0001

', 5, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (11, 'C语言中while和do-while循环的主要区别是（）。   ', 'do-while的循环体至少无条件执行一次', 'while的循环控制条件比do-while的循环控制条件严格', 'do-while允许从外部转到循环体内', 'do-while的循环体不能是复合语句', 5, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (12, '下列叙述中正确的是（）。', 'break 语句只能用于 switch 语句体中 ', 'continue语句的作用是使程序的执行流程跳出包含它的所有循环', 'break 语句只能用在循环体内和 switch 语句体内', '在循环体内使用 break语句和 continue 语句的作用相同', 5, 'C', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (13, '下列叙述中正确的是（）。', 'do-while语句构成的循环不能用其他语句构成的循环来代替', 'do-while语句构成的循环只能用break语句退出', '用do-while语句构成的循环，在while后的表达式为非零时结束循环', '用do-while语句构成的循环，在while后的表达式为零时结束循环', 5, 'D', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (14, '执行以下循环语句时，下列说法正确的是（）。
x = -1; 
do { 
      x = x * x; 
} while (x == 0); ', '循环体将执行一次', '循环体将执行两次', '循环体将执行无限次', '系统将提示有语法错误', 5, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (15, '假设变量s、a、b、c均已定义为整型变量，且a、c均已赋值（c大于0），则与以下程序段功能等价的赋值语句是（）。
s = a;  
for(b = 1; b <= c; b++) 
      s = s + 1; ', 's = a + b;', 's = a + c;', 's = s + c;', 's = b + c;', 5, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (16, '下列计算三角形面积函数的声明中，（  ）是正确的。', 'double area(double a, double b, double c);', 'double area(int a, b, c);', 'int area(double a, double b, double c)', 'double area(double a, b, c)', 3, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (17, 'C语言中函数返回值的类型是由以下（ ）决定的。', '函数定义时指定的类型', 'return语句中的表达式类型', '调用该函数时的实参的数据类型', '形参的数据类型', 3, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (18, '以下关于函数叙述中，错误的是（ ）。', '函数未被调用时，系统将不为形参分配内存单元', '实参与形参的个数必须相等，且实参与形参的类型必须对应一致', '当形参是变量时，实参可以是变量、常量或表达式', '如函数调用时，实参与形参都为变量，则这两个变量不可能占用同一内存空间', 3, 'B', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (19, '有以下函数定义：
void fun(int n, double x){......}
下列选项中的变量都已正确定义并赋值，则对函数fun的正确调用语句是（  ）。', 'fun(int y, double m);', 'k=fun(10,12.5);', 'fun(x,n);', 'void fun(x,n);', 3, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (20, '在C语言程序中，若对函数类型未加显式说明，则函数的隐含类型为（）。', 'void', 'double', 'char', 'int', 3, 'D', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (21, '建立自定义函数的目的之一是（）。', '提高程序的执行效率', '提高程序的可读性', '减少程序的篇幅', '减少程序文件所占内存', 3, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (22, '以下正确的函数定义形式是（）。', 'double fun(int x, int y)', 'double fun(int x ; int y)', 'double fun(int x, int y);', 'double fun(int x, y)', 3, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (23, '以下不正确的说法是（）。', '实参可以是常量、变量或表达式', '实参可以是任何类型', '形参可以是常量、变量或表达式', '形参应与对应的实参类型一致', 3, 'C', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (24, '以下正确的说法是（）。', '实参与其对应的形参共同占用一个存储单元', '实参与其对应的形参各占用独立的存储单元', '只有当实参与其对应的形参同名时才占用一个共同的存储单元', '形参是虚拟的，不占用内存单元', 3, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (25, '下面合法的C语言字符常量是（）。', '\'\\t\'', '"A"', '\'xx\'', 'A', 6, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (26, '下面程序段的输出是（ ）。
int x=023;
printf("%d\\n",--x);', '17', '18', '23', '24', 6, 'B', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (27, '下面的程序段输出是（ ）。
int k=11;
printf("k=%d,k=%o,k=%x\\n",k,k,k);', 'k=11,k=12,k=11
', 'k=11,k=13,k=13
', 'k=11,k=013;k=0xb', 'k=11,k=13,k=b', 6, 'D', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (28, '下面的程序段输出是（ ）。
short int a;
int b = 65536;

a = b;
printf("%d\\n", a);', '65536', '0', '-1', '1', 6, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (29, '已知字符\'c\' 的ASCII码为99，语句printf ("%d,%c",\'c\',\'c\'+1); 的输出为（ ）。', '99,c', '99100', '99,d', '语句不合法', 6, 'C', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (30, '阅读以下程序段，如果从键盘上输入1234567<回车>，则程序的运行结果是（ ）。
int i,j;
scanf("%3d%2d",&i,&j);
printf("i = %d, j = %d\\n",i,j);', 'i = 123, j = 4567', 'i = 1234, j = 567', 'i = 1, j = 2', 'i = 123, j = 45', 6, 'D', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (31, '阅读以下程序段，如果从键盘上输入abc<回车>，则程序的运行结果是（ ）。
char ch;

scanf("%3c",&ch);
printf("%c",ch);', 'a', 'b', 'c', '语法出错', 6, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (32, '已知字母A的ASCII码为十进制的65，下面程序段的输出是（ ）。
char ch1,ch2;
ch1=\'A\'+\'5\'-\'3\';
ch2=\'A\'+\'6\'-\'3\';
printf("%d,%c\\n",ch1,ch2);', '67,D', 'B,C
', 'C,D', '不确定的值', 6, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (33, '设整型变量a=2，则执行下列语句后，浮点型变量b的值不为0.5的是（ ）。', 'b=1.0/a;', 'b=(float) (1/a);', 'b=1/(float)a;', 'b=1/(a*1.0);', 6, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (34, '若" int n; float f=13.8; "，则执行"n=(int)f%3"后，n的值是（ ）。', '1', '4', '4.333333', '4.6', 6, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (35, '下面（ ）表达式的值为4。', '11/3', '11.0/3', '(float)11/3', '(int)(11.0/3+0.5)', 6, 'D', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (36, '若有定义int x=3, y=2和float a=2.5, b=3.5，则表达式：(x+y)%2+(int)a/(int)b的值是（ ）。', '0', '2', '1.5', '1', 6, 'D', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (37, '计算变量x（x大于1）整数部分位数的表达式，可以写作( )。', '(int)log10(x)', 'log10(x)', 'log10(x)+1', '(int)log10(x)+1', 6, 'D', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (38, '假定char类型变量占用1个字节，且数组定义如下，则数组str在内存中所占字节数是（ ）。
char  str[81];', '0', '10', '80', '81', 7, 'D', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (39, '假定double类型变量占用8个字节，且数组定义如下，则数组length在内存中所占字节数是（ ）。
double  length [10];', '0', '10', '80', '160', 7, 'C', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (40, '假定char类型变量占用1个字节，且数组定义如下，则数组tab_str在内存中所占字节数是（ ）。
char  tab_str [10][81];', '810', '10', '81', '0', 7, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (41, '假定double类型变量占用8个字节，且数组定义如下，则数组point在内存中所占字节数是（ ）。
double  point [10][10];', '0', '800', '10', '20', 7, 'B', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (42, '如果变量定义如下，则正确的语句是（ ）。
int i, j, tab[3][4];', 'tab[0][ ] = 0;', 'tab[ ][3] = 3;', 'tab = 100;', 'for(i = 0; i < 3; i++){
     for(j = 0; j < 4; j++){
          printf("%4d", tab[i][j]);
        }
 ', 7, 'D', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (43, '假定int类型变量占用两个字节，其有定义：int x[10]={0, 2, 4}; 则数组x在内存中所占字节数是（）。', '3', '6', '10', '20', 7, 'D', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (44, '以下能正确定义数组并正确赋初值的语句是（）。', 'int N=5, b[N][N];', 'int a[1][2]={{1}, {3}};', 'int c[2][ ]={{1, 2}, {3, 4}};', 'int d[3][2]={{1, 2}, {34}};', 7, 'D', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (45, '若有定义：int a[2][3]; 以下选项中对数组元素正确引用的是（）。', 'a[2][0]', 'a[2][3]', 'a [0][3]', 'a[1>2][1]', 7, 'D', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (46, '设有数组定义：char array [ ]="China"; 则数组 array所占的空间为（）。', '4个字节', '5个字节', '6个字节', '7个字节', 7, 'C', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (47, '下述对C语言字符数组的描述中错误的是（）。', '字符数组可以存放字符串
', '字符数组中的字符串可以整体输入、输出', '可以在赋值语句中通过赋值运算符"="对字符数组整体赋值
', '可以在赋值语句中通过赋值运算符"="对字符数组整体赋值', 7, 'C', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (48, '有以下定义：char x[ ]="abcdefg"; char y[ ]={\'a\', \'b\', \'c\', \'d\', \'e\', \'f\', \'g\'}; 则正确的叙述为（）。', '数组x和数组y等价', '数组x和数组y的长度相同', '数组x的长度大于数组y的长度', '数组x的长度小于数组y的长度', 7, 'C', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (49, '以下程序的输出结果是（）。
int main(void)
{
      int  m[ ][3] = { 1, 4, 7, 2, 5, 8, 3, 6, 9 };
      int  i, j, k=2;

      for (i=0; i<3; i++)
            printf ("%d ", m[k][i]);

      return 0;
}', '4 5 6
', '2 5 8', '3 6 9', '7 8 9', 7, 'C', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (50, '以下程序的输出结果是（）。
int main(void)
{
      int aa[4][4]={ {1, 2, 3, 4}, {5, 6, 7, 8}, {3, 9, 10, 2}, {4, 2, 9, 6} };
      int i, s=0;

      for(i=0; i<4; i++)
            s += aa[i][1];
      printf("%d\\n", s);

     return 0;
}', '11', '19', '13', '20', 7, 'B', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (51, '下列程序段的功能是：计算数组x中相邻两个元素的和，依次存放到 a 数组中，然后输出a数组。程序段中待填空的（1）和（2）的正确选项是（ ）。

int i;
int a[9], x[10];

for(i = 0; i < 10; i++){
   scanf("%d", &x[i]);
}
for(    (1)    ; i < 10; i++ ) { /* 此处待填空（1） */
    a[i-1] = x[i] +    (2)    ;  /* 此处待填空（2） */
}
for(i = 0; i < 9; i++){
   printf("%d ",a[i]);
}
printf("\\n");', '(1) i = 1
(2) x[i+1]', '(1) i = 0
(2) x[i-1]', '(1)  i = 1
(2) x[i-1]', '(1) i = 0
(2) x[i+1]', 7, 'C', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (52, '如果有定义：int m, n = 5, *p = &m; 与m = n 等价的语句是 （） 。', 'm = *p;', '*p = *&n;', 'm = &n;
', 'm = **p;
', 8, 'B', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (53, '下面程序的输出结果是(  )。
# include <stdio.h> 
void fun (int *x, int *y)
{
    printf("%d%d", *x, *y);
    *x = 3;
    *y = 4;
} 
int main(void)
{
    int x=1, y=2;  
    
    fun(&x, &y);  
    printf("%d%d", x, y);

    return 0;
}', '2134
', '1212', '1234
', '2112', 8, 'C', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (54, '下面程序的输出结果是(  )。

#include <stdio.h>

void fun (int *x,  int y)
{
    printf("%d%d", *x, y);
    *x=3;  
    y=4;
}
int main(void)
{
    int x = 1, y = 2;
        
    fun(&y, x);
    printf("%d%d", x, y);
        
    return 0;
}', '1234', '1221', '2131', '2113', 8, 'D', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (55, '用冒泡排序对4，5，6，3，2，1进行从小到大排序，第三趟排序后的状态为(      )。', '4  5  3  2  1  6
', '4 3 2 1 5 6', '3 2 1 4 5 6', '2 1 3 4 5 6', 8, 'C', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (56, '下列程序的输出结果是(      )。

# include <stdio.h> 
int main(void)
{
    int a[10] = {0,1,2,3,4,5,6,7,8,9}, *p = a+3;
        
    printf("%d", p[2]);
        
    return 0;
}', '3', '4', '5', '非法', 8, 'C', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (57, '以下程序的输出结果是（      ）。

int main(void)
{
   char a[ ] = "programming",  b[ ] = "language";
   char *p1 = a, *p2 = b; 
   int i;
     
   for(i = 0; i < 7; i++){
       if( *(p1+i) == *(p2+i) ){
           printf("%c", *(p1+i));
       }
   }
        
   return 0;
}', 'gm', 'rg', 'or', 'ga', 8, 'D', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (58, '以下程序的输出结果是(      )。

int fun(char s[ ])
{    
    int n = 0;
        
    while ( *s <= \'9\' && *s >= \'0\'){
         n = 10 * n + *s - \'0\';  
         s++;
    }

    return(n);    
}

int main( )
{
       char s[10]={\'6\', \'1\', \'*\' , \'4\', \'*\', \'9\', \'*\', \'0\', \'*\'};
             
       printf("%d\\n", fun(s));
             
       return 0;
}', '9', '61490', '61', '5', 8, 'c', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (59, '下列语句定义 x 为指向 int 类型变量 a 的指针，正确的是（）。', 'int a, *x = a;', 'int a, *x = &a;', 'int *x = &a, a;
', 'int a, x = a;
', 8, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (60, '若有以下说明，且0<=i<10，则对数组元素的错误引用是（）。

int a[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}, *p = a, i;', '*(a+i)
', 'a[p-a+i]', 'p+i', '*(&a[i])', 8, 'C', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (61, '下列程序的输出结果是（）。

int main(void)
{
      int a[10] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 }, *p = a+3;

      printf(“%d”, *++p);

      return 0;
}', '3', '4', 'a[4]的地址', '非法
', 8, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (62, '对于下列程序，正确的是（） 。

void f(int *p)
{
      *p = 5;
}
int main(void)
{
      int a, *p;

      a = 10;
      p = &a;
      f(p);
      printf(“%d”, (*p)++);

      return 0;
}', '5', '6', '10', '11', 8, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (63, '变量的指针，其含义是指该变量的（  ）。', '值', '地址', '名', '一个标志', 8, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (64, '已有定义int k=2; int *ptr1, *ptr2; 且ptr1和ptr2均已指向变量k，下面不能正确执行的赋值语句是(  )。', 'k = *ptr1 + *ptr2;', 'ptr2 = k;', 'ptr1 = ptr2;', 'k = *ptr1 *(*ptr2);', 8, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (65, '以下程序的运行结果是（  ）。

#include <stdio.h>
void sub(int x, int y, int *z)
{  
  *z = y-x;
}
int main()
{   
     int a,b,c;
         
     sub(10, 5, &a);
     sub(7, a, &b);
     sub(a, b, &c);
     printf("%d,%d,%d\\n", a, b, c);
         
     return 0;
}', '5,2,3', '-5,-12,-7', '-5,-12,-17
', '5,-2,-7
', 8, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (66, '对于以下程序段，则叙述正确的是（  ）。

char s[ ]="china"; 
char *p; 
p = s;', 's和p完全相同
', '数组s中的内容和指针变量p中的内容相等', '数组s的长度和p所指向的字符串长度相等', '*p与s[0]相等', 8, 'D', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (67, '下面程序段的运行结果是（  ）。

char a[]=”language”, *p;
p = a;
while( *p != \'u\') { printf("%c", *p - 32); p++; }
', 'LANGUAGE', 'language', 'LANG', 'langUAGE', 8, 'C', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (68, '若程序中有下面的说明和定义，则会发生的情况是（   ）。

struct abc { 
  int x; 
  char y; 
};
struct abc s1, s2;', '编译出错
', '程序将顺利编译、连接、执行', '能顺利通过编译、连接，但不能执行', '能顺利通过编译，但连接出错', 1, 'B', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (69, '对于以下定义，不正确的叙述是（     ）。
struct  ex { 
  int x;
  float y;
  char z ;
} example;', 'struct是定义结构类型的关键字
', 'example是结构类型名', 'x, y, z都是结构成员名', 'struct ex是结构类型名', 1, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (70, '以下程序段的输出结果为（      ）。

struct {
  int x;
  int y;
} s[2] = { { 1, 3 }, { 2, 7 } };

printf("%d", s[0].y/s[1].x ); ', '0', '1', '2', '3', 1, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (71, '对于以下定义，错误的scanf函数调用语句是（）。

struct pupil{ 
  char name[20];
  int age;
  int sex;
}pup[5];', 'scanf("%s", &pup[0].name);
', 'scanf("%d", &pup[1].age);', 'scanf("%d", &pup[2].sex);', 'scanf("%s", pup[4].name);', 1, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (72, '设有如下定义，则错误的输入语句是（   ）。

struct  ss{ 
  char  name[10];
  int age;  
  char sex;
} std[3], *p = std;', 'scanf("%d", &(*p).age);', 'scanf("%d", p->&age);
', 'scanf("%c", &std[0].sex);', 'scanf("%c", &(p->sex));', 1, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (73, '下列程序的输出结果是(   )。

struct stu{ 
  char num[10];  
  float score[3];
};

int main( )
{ 
  struct stu s[3] = {{ "20021",90,95,85},{"20022",95,80,75},{"20023",100,95,90}};
  struct stu *p = s;
  int i;   
  float sum = 0;
    
  for(i=0; i<3; i++){
    sum = sum + p->score[i];
  }
  printf("%6.2f", sum);
    
  return 0;
}', '260.00
', '270.00
', '280.00
', '285', 1, 'B', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (74, '下面定义结构变量的语句中错误的是（）。', 'struct student{ int num; char name[20]; } s;', 'struct { int num; char name[20]; } s;
', 'struct student{ int num; char name[20]; }; struct student s;
', 'struct student{ int num; char name[20]; }; student s;
', 1, 'D', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (75, '如果有以下定义语句，则输出结果为（）。

struct {
      int x, y;
} s[2] = { { 1, 3 }, { 2, 7 } };
printf(“%d\\n”, s[0].y/s[1].x );', '0', '1', '2', '3', 1, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (76, '根据下面的定义，能打印出字母M的语句是（）。

struct person{
      char name[10];
      int age;
} c[10] = { “John”, 17, “Paul”, 19, “Mary”, 18, “Adam”, 16 };', 'printf(“%c”, c[3].name);
', 'printf(“%c”, c[3].name[1]);', 'printf(“%c”, c[2].name[0]);', 'printf(“%c”, c[2].name[1]);
', 1, 'C', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (77, '设有如下定义，则对data中的a成员的正确引用是（）。

struct sk{ int a; float b; } data, *p=&data;', '(*p).data.a
', '(*p).a', 'p->data.a', 'p.data.a', 1, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (78, '对于以下结构定义，(*p)->str++中的++加在（）。

struct { int len; char *str; } *p;', '指针str上', '指针p上', 'str指向的内容上', '语法错误', 1, 'D', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (79, '当定义一个结构变量时，系统分配给它的内存空间大小是（  ）。', '各成员所需内存量的总和
', '结构中第一个成员所需内存量
', '成员中占内存量最大者所需容量
', '结构中最后一个成员所需内存量
', 1, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (80, '如果结构变量s中的生日是“1984年11月11日”，下列对其生日的正确赋值是（）。

struct student
{  
  int no;
  char name[20];
  char sex;
  struct{
    int year;
    int month;
    int day;
  }birth;
};
struct student s;', 'year = 1984; month = 11; day = 11;', 'birth.year = 1984; birth.month = 11; birth.day = 11;', 's.year = 1984; s.month = 11; s.day = 11;
', 's.birth.year = 1984; s.birth.month = 11; s.birth.day=11;
', 1, 'D', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (81, 'C语言中结构类型变量在程序执行期间（  ）。', '所有成员一直驻留在内存中
', '只有一个成员驻留在内存中', '部分成员驻留在内存中', '没有成员驻留在内存中
', 1, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (82, '若有下列定义，则以下不合法的表达式是（  ）。

struct student{
   int num;
   int age;
};
struct student stu[3] = {{101, 20}, {102, 19}, {103, 20}}, *p = stu;', '(p++)->num', 'p++', '(*p).num
', 'p = &stu.age
', 1, 'D', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (83, '以下程序的输出结果是（  ）。

struct stu{
  int x; 
  int *y;
} *p;
int dt[4] = {10, 20, 30, 40};
struct stu a[4] = {50, &dt[0], 60, &dt[1], 70, &dt[2], 80, &dt[3]};

int main( )
{ 
   p=a;
   printf("%d,", ++p->x);
   printf("%d,", (++p)->x);
   printf("%d", ++(*p->y));
     
   return 0;
}', '10,20,20', '50,60,21', '51,60,21', '60,70,31', 1, 'C', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (84, '若有定义：int *p[3]; 则以下叙述中正确的是（    ）。', '定义了一个基类型为 int 的指针变量 p，该变量具有3个指针', '定义了一个指针数组 p，该数组含有3个元素，每个元素都是基类型为 int 的指针', '定义了一个名为 *p 的整型数组，该数组含有3个 int 类型元素', '定义了一个可指向一维数组的指针变量 p ，所指一维数组应具有3个 int 类型元素', 8, 'B', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (85, '对于以下程序，能够正确表示二维数组 t 的元素地址的表达式是（    ）。

int main(void)
{
    int k, t[3][2], *pt[3];
        
    for ( k = 0; k < 3; k++) {
        pt[k] = t[k];
        }
                
    return 0;
}', '&t[3][2]
', '*pt[0]', '*(pt+1)
', '&pt[2]', 8, 'C', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (86, '如果有函数char *func(char *p, char ch)，则下面说法错误的是（  ）。', '函数返回一个字符指针', '可以通过语句return NULL;返回函数结果', '可以通过语句return -1;返回函数结果', '可以通过语句return p;返回函数结果
', 8, 'C', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (87, '以下数据结构中，（ ）是非线性数据结构。', '树', '字符串', '队列', '栈', 22, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (88, '下面的这个循环的循环次数是（ ） for(int i=0,j=10; i=j=10; i++,j--)', '语法错误，不能执行', '无限次', '10', '1', 22, 'B', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (89, '若有char w; int x; float y; double z; 则表达式w*x+z-y值的数据类型为（ ）。', 'float', 'char', 'int ', 'double', 22, 'D', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (90, '以下关于数据结构的说法中错误的是（ ）。', '数据结构相同，对应的存储结构也相同', '数据结构涉及数据的逻辑结构、存储结构和施加其上的操作3个方面', '数据结构操作的实现与存储结构有关', '定义逻辑结构时可不考虑存储结构', 22, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (91, '以下选项中属于非线性结构的是（ ）。', '广义表', '队列', '优先队列', '栈', 22, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (92, '下列属于非线性数据结构的是( )。', '线性表', '图', '栈', '队列', 22, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (93, '下列属于线性数据结构的是( )。', '图', '集合', '栈', '队列', 22, 'C', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (94, '在 Data_Structure = (D，R)中，D 是（ ）的有限集合。', '数据元素', '算法', '数据操作', '数据对象', 22, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (95, '计算机所处理的数据一般具有某种关系，这是指（ ）。', '数据与数据之间存在的某种关系', '数据元素与数据元素之间存在的某种关系', '元素内数据项与数据项之间存在的某种关系', '数据文件内记录与记录之间存在的某种关系', 22, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (96, '以下属于逻辑结构的是（ ）。', '顺序表', '散列表', '散列表', '单链表', 22, 'C', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (97, '以下关于数据结构的说法中正确的是____。', '数据结构的逻辑结构独立于其存储结构', '数据结构的存储结构独立于该数据结构的逻辑结构', '数据结构的逻辑结构唯一地决定了该数据结构的存储结构', '数据结构仅由其逻辑结构和存储结构决定', 22, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (98, '算法的时间复杂度取决于（ ）。', '问题的规模', '待处理数据的初态', '计算机的配置', 'A和B', 22, 'D', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (99, '一个完整的算法应该具有（ ）等特性。', '可执行性、可修改性和可维护性', '可行性、确定性和有穷性', '确定性、有穷性和可靠性', '正确性、可读性和有效性', 22, 'B', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (100, '给定N×N×N的三维数组A，则在不改变数组的前提下，查找最小元素的时间复杂度是：', 'O(N2)', 'O(NlogN)', 'O(N2logN)', 'O(N3)', 22, 'D', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (101, '若p1、p2都是整型指针，p1已经指向变量x，要使p2也指向x, ____是正确的。', 'p2=p1', 'p2=**p1', 'p2=&p1', 'p2=*p1', 22, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (102, '一个递归算法必须包括（ ）。', '递归部分', '终止条件和递归部分', '迭代部分', '终止条件和迭代部分', 22, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (103, '若有以下说明，且0<=i<10，则对数组元素的错误引用是（）。
int a[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}, *p = a, i;', '*(a+i)', 'a[p-a+i]', 'p+i', '*(&a[i])', 22, 'B', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (104, '有以下定义：char x[ ]="abcdefg"; char y[ ]={\'a\', \'b\', \'c\', \'d\', \'e\', \'f\', \'g\'}; 则正确的叙述为（）。', '数组x和数组y等价', '数组x和数组y的长度相同', '数组x的长度大于数组y的长度', '数组x的长度小于数组y的长度', 22, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (105, '单链表又称为线性链表，在单链表上实施插入和删除操作（ ）。', '不需移动结点，不需改变结点指针', '不需移动结点，只需改变结点指针', '只需移动结点，不需改变结点指针', '既需移动结点，又需改变结点指针', 22, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (106, '链表不具有的特点是（）。', '插入、删除不需要移动元素。', '可随机访问任一元素。', '不必事先估计存储空间。', '所需空间与线性表长度成正比。', 22, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (107, '带头结点的单链表h为空的判定条件是：', 'h == NULL;', 'h->next == NULL;', 'h->next == h;', 'h != NULL;', 22, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (108, '下列函数中，哪个函数具有最快的增长速度？', 'N2logN', 'N(logN)4', 'N3', 'NlogN2', 22, 'C', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (109, '如果变量 x、y 已经正确定义，下列哪个选项的语句不能正确将x、y的值进行交换？', 'x=x+y, y=x-y, x=x-y; ', 't=x, x=y; y=t;', 't=y, y=x, x=t;', 'x=t, t=y, y=x;', 21, 'D', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (110, '单链表又称为线性链表，在单链表上实施插入和删除操作（ ）。', '不需移动结点，不需改变结点指针', '不需移动结点，只需改变结点指针', '只需移动结点，不需改变结点指针', '既需移动结点，又需改变结点指针', 21, 'B', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (111, '下列程序段的输出是____。
int c[]={1, 3, 5};
int *k=c+1;
printf("%d", *++k);', '3', '4', '5', '6', 21, 'D', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (112, '在具有N个结点的单链表中，实现下列哪个操作，其算法的时间复杂度是O(N)？', '在地址为p的结点之后插入一个结点', '删除开始结点', '遍历链表和求链表的第i个结点', '删除地址为p的结点的后继结点', 21, 'C', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (113, '若某表最常用的操作是在最后一个结点之后插入一个结点或删除最后一个结点。则采用哪种存储方式最节省运算时间？', '单链表', '双链表', '单循环链表', '带头结点的双循环链表', 21, 'D', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (114, '对于一个具有N个结点的单链表，在给定值为x的结点后插入一个新结点的时间复杂度为', 'O(1)', 'O(N/2)', 'O(N)', 'O(N2)', 21, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (115, '设h为不带头结点的单向链表。在h的头上插入一个新结点t的语句是：', 'h=t; t->next=h->next;', 't->next=h->next; h=t;', 'h=t; t->next=h;', 't->next=h; h=t;', 21, 'D', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (116, '在单链表中，若p所指的结点不是最后结点，在p之后插入s所指结点，则执行', 's->next=p; p->next=s;', 's->next=p->next; p=s;', 's->next=p->next; p->next=s;', 'p->next=s; s->next=p;', 21, 'C', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (117, '采用多项式的非零项链式存储表示法，如果两个多项式的非零项分别为N1​和N2​个，最高项指数分别为M1​和M2​，则实现两个多项式相加的时间复杂度是：', 'O(N1​+N2​)', 'O(M1​+M2​)', 'O(N1​×N2​)', 'O(M1​×M2​)', 21, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (118, '将两个结点数都为N且都从小到大有序的单向链表合并成一个从小到大有序的单向链表，那么可能的最少比较次数是：', '1', 'N', '2N', 'NlogN', 21, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (119, '采用多项式的非零项链式存储表示法，如果两个多项式的非零项分别为N1​和N2​个，最高项指数分别为M1​和M2​，则实现两个多项式相乘的时间复杂度是：', 'O(N1​+N2​)', 'O(M1​+M2​)', 'O(N1​×N2​)', 'O(M1​×M2​)', 21, 'C', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (120, '线性表若采用链式存储结构时，要求内存中可用存储单元的地址（）。', '必须是连续的', '部分地址必须是连续的', '一定是不连续的', '连续或不连续都可以', 21, 'D', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (121, '对线性表，在下列情况下应当采用链表表示的是（）。', '经常需要随机地存取元素', '经常需要进行插入和删除操作', '表中元素需要占据一片连续的存储空间', '表中的元素个数不变', 21, 'B', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (122, '在单链表中，要删除某一指定结点，必须先找到该结点的（）。', '直接前驱', '自身位置', '直接后继', '直接后继的后继', 21, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (123, '在单链表中，指针p指向元素为x的结点，实现“删除x的后继”的语句是（）。', 'p=p->next', 'p->next=p->next->next', 'p->next=p', 'p=p->next->next', 21, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (124, '已知有如下C语言代码：
struct node {
    int val;
    struct node *next;
} p[3] = { 4, &p[2], 6, &p[0], 5, &p[1] };
其中值为6的表达式是：', 'p[1].next->val', '(&p[0])->next->val', 'p[2].val', 'p[2].next->val', 21, 'D', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (125, '在N个结点的顺序表中，算法的时间复杂度为O(1)的操作是：', '访问第i个结点（1≤i≤N）和求第i个结点的直接前驱（2≤i≤N）', '在第i个结点后插入一个新结点（1≤i≤N）', '删除第i个结点（1≤i≤N）', '将N个结点从小到大排序', 20, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (126, '用数组表示线性表的优点是（）。', '便于插入和删除操作', '便于随机存取', '可以动态地分配存储空间', '不需要占用一片相邻的存储空间', 20, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (127, '对线性表，在下列情况下应当采用链表表示的是（）。', '经常需要随机地存取元素', '经常需要进行插入和删除操作', '表中元素需要占据一片连续的存储空间', '表中的元素个数不变', 20, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (128, 'Suppose that five numbers are pushed onto a stack in the order {1, 2, 3, 4, 5}, and the pop sequence is {3, 5, 4, 2, 1}. To obtain such a result, the minimum size of the stack must be:', '2', '3', '4', '5', 20, 'C', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (129, 'Given top as the top pointer of a stack S. To check if S (m is its capacity) is empty, the test condition must be:', 'S->top == 0', 'S->top == -1', 'S->top == -1', 'S->top == m-1', 20, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (130, '给定一个堆栈的入栈序列为{ 1, 2, ⋯, n }，出栈序列为{ p1​, p2​, ⋯, pn​ }。如果p2​=n，则存在多少种不同的出栈序列？', 'n', 'n-1', '2', '1', 20, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (131, 'Given the popping sequence of a stack as {1, 2, 3, 4, 5}. Among the following, the impossible pushing sequence is:', '3 2 1 5 4', '5 1 2 3 4', '4 5 1 3 2', '5 4 1 2 3', 20, 'C', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (132, 'If keys are pushed onto a stack in the order abcdef, then it\'s impossible to obtain the output sequence ( ).', 'fedcba', 'bcafed', 'dcefba', 'cabdef', 20, 'D', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (133, '令P代表入栈，O代表出栈。若利用堆栈将中缀表达式3*2+8/4转为后缀表达式，则相应的堆栈操作序列是：', 'PPPOOO', 'POPOPO', 'POPPOO', 'PPOOPO', 20, 'C', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (134, '在长度为n的（）上，删除第一个元素，其算法的时间复杂度为O(n)。', '只有表头指针的不带表头结点的循环单链表', '只有表尾指针的不带表头结点的循环单链表', '只有表尾指针的带表头结点的循环单链表', '只有表头指针的带表头结点的循环单链表', 19, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (135, '对于顺序存储的长度为N的线性表，访问结点和增加结点的时间复杂度为：', 'O(1), O(1)', 'O(1), O(N)', 'O(N), O(1)', 'O(N), O(N)', 19, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (136, '链表不具有的特点是( )。', '可随机访问任一个元素', '插入删除不需要移动元素', '不必事先估计存储空间', '所需空间与线性表长度成正比', 19, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (137, '若某线性表最常用的操作是存取任一指定序号的元素和在最后进行插入和删除运算，则利用哪种存储方式最节省时间？', '双链表', '单循环链表', '带头结点的双循环链表', '顺序表', 19, 'D', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (138, '一个栈的入栈序列是a,b,c,d,e，则出栈序列不可能是( )。', 'e,d,c,b,a', 'd,e,c,b,a', 'd,c,e,a,b', 'a,b,c,d,e', 19, 'C', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (139, '若已知一个进栈序列是1,2,3,……,n,其输出序列是p1,p2,p3,……pn, 若p1=n, 则pi(1<i<n)为( )。', 'i', 'n-i', 'n-i+1', '不确定', 19, 'C', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (140, '设栈s的初始状态为空,6个元素的入栈顺序为e1,e2,e3,e4,e5和e6。若出栈的顺序是e2,e4, e3,e6,e5,e1,则栈s的容量至少应该是( )。', '6', '4', '3', '2', 19, 'C', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (141, '栈的插入和删除操作在（ ）进行。', '栈顶', '栈底', '任意位置', '指定位置', 19, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (142, '若已知一队列用单向链表表示，该单向链表的当前状态（含3个对象）是：1->2->3，其中x->y表示x的下一节点是y。此时，如果将对象4入队，然后队列头的对象出队，则单向链表的状态是：', '1->2->3', '2->3->4', '4->1->2', '答案不唯一', 19, 'B', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (143, '某队列允许在其两端进行入队操作，但仅允许在一端进行出队操作。若元素a、b、c、d、e依次入此队列后再进行出队操作，则不可能得到的出队序列是：', 'b a c d e', 'd b a c e', 'e c b a d', 'd b c a e', 19, 'C', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (144, '在一个不带头结点的非空链式队列中,假设f和r分别为队头和队尾指针,则插入s所指的结点运算是( )。', 'f->next=s; f=s;', 'r->next=s; r=s;', 's->next=s; r=s;', 's->next=f; f=s;', 19, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (145, '有六个元素以6、5、4、3、2、1的顺序进栈，问哪个不是合法的出栈序列？', '2 3 4 1 5 6', '3 4 6 5 2 1', '5 4 3 6 1 2', '4 5 3 1 2 6', 19, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (146, '在利用堆栈将下列哪个中缀表达式转换为后缀表达式过程中，堆栈的操作系列为:
push(\'*\') 、push(\'(\')、 push(\'+\')、pop()、pop()、pop()、push(\'*\')、pop()、push(\'+\')、pop()', '2*(3+4)*5+6', '2*(3+4*5)+6', '2*(3+4*5+6)', '以上都是', 18, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (147, '元素a, b, c, d, e依次进入初始为空的栈中，若元素进栈后可停留、可出栈，直到所有元素都出栈，则在所有可能的出栈序列中，以元素d开头的序列个数是（ ）。', '3', '4', '5', '6', 18, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (148, '表达式a*(b+c)-d的后缀表达式是____。', 'a b c + * d -', 'a b c d * + -', 'a b c * + d -', '- + * a b c d', 18, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (149, '利用栈对表达式1+9/(8-5)*4求值的过程中，操作数栈的最大容量是多少？（ ）。', '3', '4', '5', '2', 18, 'B', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (150, 'Suppose that an array of size 6 is used to store a circular queue, and the values of front and rear are 0 and 4, respectively. Now after 2 dequeues and 2 enqueues, what will the values of front and rear be?', '2 and 0', '2 and 2', '2 and 4', '2 and 6', 18, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (151, '循环队列存储在数组A[0..n-1]中，其头尾指针分别为f和r，头指针f总是指向队头元素，尾指针r总是指向队尾元素的下一个位置，则元素e入队时的操作为（ ）', 'A[r]=e; r=r+1', 'A[r]=e; r=(r+1)%n', 'A[r]=e;r=(r+1)%(n+1)', 'r=(r+1)%n; A[r]=e;', 18, 'B', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (152, '设循环队列中数组的下标范围是0—n-1，其头尾指针分别为f和r，头指针f总是指向队头元素，尾指针r总是指向队尾元素的下一个位置，则队空的条件是( )。', '(r+1)%n==f', 'r==f', 'r+1==f', '(r-l)%n==f', 18, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (153, '设循环队列中数组的下标范围是0—n-1，其头尾指针分别为f和r，头指针f总是指向队头元素，尾指针r总是指向队尾元素的下一个位置，则队满的条件是( )。', 'r+1==f', 'r==f', '(r+1)%n==f', '(r-l)%n==f', 18, 'C', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (154, '树最适合于用来表示', '有序数据元素', '无序数据元素', '元素之间无联系的数据', '元素之间具有分支层次关系的数据', 17, 'D', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (155, '设树T的度为4，其中度为1、2、3、4的结点个数分别为4、2、1、1。则T中有多少个叶子结点？', '4', '6', '8', '10', 17, 'C', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (156, '三叉树中，度为1的结点有5个，度为2的结点3个，度为3的结点2个，问该树含有几个叶结点？', '8', '10', '12', '13', 17, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (157, '设每个d叉树的结点有d个指针指向子树，有n个结点的d叉树有多少空链域？', 'nd', 'n(d−1)', 'n(d−1)+1', '以上都不是', 17, 'C', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (158, '有一个四叉树，度2的结点数为2，度3的结点数为3，度4的结点数为4。问该树的叶结点个数是多少？', '10', '12', '20', '21', 17, 'D', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (159, '有关树和二叉树的叙述错误的是（）。', '树中的最大度数没有限制，而二叉树结点的最大度数为2；', '树的结点无左右之分，而二叉树的结点有左右之分；', '树的每个结点的孩子数为0到多个, 而二叉树每个结点均有两个孩子；', '树和二叉树均为树形结构', 17, 'C', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (160, '一棵二叉树中，双分支结点数为15，单分支结点数为30，则叶子结点数为（）个。', '15', '16', '17', '47', 17, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (161, '以二叉链表作为二叉树的存储结构，在具有 n 个结点的二叉链表中（n>0），空链域的个数为 __', 'n+1', 'n', 'n-1', '无法确定', 17, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (162, '对于任意一棵高度为 5 且有 10 个结点的二叉树，若采用顺序存储结构保存，每个结点占 1 个存储单元（仅存放结点的数据信息），则存放该二叉树需要的存储单元的数量至少是：', '31', '16', '15', '10', 17, 'D', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (163, '一棵度为4的树T中，若有20个度为4的结点，10个度为3的结点，1个度为2的结点，10个度为1的结点，则树T的叶子结点个数是( )。 ', '41', '82', '113', '122', 17, 'B', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (164, '假定有K个关键字互为同义词，若用线性探测法把这K个关键字存入散列表中，至少要进行多少次探测？', 'K−1', 'K', 'K+1', 'K(K+1)/2', 13, 'D', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (165, '采用线性探测法解决冲突时所产生的一系列后继散列地址：', '必须大于等于原散列地址', '必须小于等于原散列地址', '可以大于或小于但不等于原散列地址', '对地址在何处没有限制', 13, 'C', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (166, '将元素序列{18，23，11，20，2，7，27，33，42，15}按顺序插入一个初始为空的、大小为11的散列表中。散列函数为：H(Key)=Key%11，采用线性探测法处理冲突。问：当第一次发现有冲突时，散列表的装填因子大约是多少？', '0.27', '0.45', '0.64', '0.73', 13, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (167, '给定散列表大小为11，散列函数为H(Key)=Key%11。按照线性探测冲突解决策略连续插入散列值相同的4个元素。问：此时该散列表的平均不成功查找次数是多少？', '1', '4/11', '21/11', '不确定', 13, 'C', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (168, '从一个具有N个结点的单链表中查找其值等于X的结点时，在查找成功的情况下，需平均比较多少个结点？', 'N/2', 'N', '(N−1)/2', '(N+1)/2', 13, 'D', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (169, '给定输入序列 {4371, 1323, 6173, 4199, 4344, 9679, 1989} 以及散列函数 h(X)=X%10。如果用大小为10的散列表，并且用线性探测解决冲突，则输入各项经散列后在表中的下标为：（-1表示相应的插入无法成功）', '1, 3, 3, 9, 4, 9, 9', '1, 3, 4, 9, 7, 5, -1', '1, 3, 4, 9, 5, 0, 8', '1, 3, 4, 9, 5, 0, 2', 13, 'D', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (170, '将元素序列{18, 23, 4, 26, 31, 33, 17, 39}按顺序插入一个初始为空的、大小为13的散列表中。散列函数为：H(Key)=Key%13，采用线性探测法处理冲突。问：当第一次发现有冲突时，散列表的装填因子大约是多少？', '0.54', '0.63', '0.31', '0.62', 13, 'C', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (171, '给定散列表大小为11，散列函数为H(Key)=Key%11。按照线性探测冲突解决策略连续插入散列值相同的5个元素。问：此时该散列表的平均不成功查找次数是多少？', '不确定', '26/11', '5/11', '1', 13, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (172, '假定有k个关键字互为同义词，若用线性探测法把这k个关键字存入散列表中，至少要进行多少次探测？(    )', 'k-1次', 'k次', 'k+1次', 'k（k+1）/2次', 13, 'D', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (173, '现有长度为 11 且初始为空的散列表 HT，散列函数是 H(key)=key%7，采用线性探查（线性探测再散列）法解决冲突。将关键字序列 87,40,30,6,11,22,98,20 依次插入到 HT 后，HT 查找失败的平均查找长度是：', '4', '5.25', '6', '6.29', 13, 'C', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (174, 'Suppose that the range of a hash table is [0, 18], and the hash function is H(Key)=Key%17. If linear probing is used to resolve collisions, then after inserting { 16, 32, 14, 34, 48 } one by one into the hash table, the index of 48 is:', '14', '0', '17', '1', 13, 'C', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (175, '对哈希(HASH)函数H(k)= k MOD m, 一般来说,m应取', '素数', '很大的数', '偶数', '奇数', 13, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (176, '9.设有一组记录的关键字为{19，14，23，1，68，20，84，27，55，11，10，79}，用链接法构造散列表，散列函数为H（key）=key MOD 13,散列地址为1的链中有（）个记录。', '3', '2', '1', '4', 13, 'D', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (177, '哈希表的平均查找长度是（）的函数。', '哈希表的长度', '哈希表的装填因子', '哈希函数', '表中元素的多少', 13, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (178, '(neuDS)哈希表的地址区间为0～17，哈希函数为h(key)=K%17。采用线性探测法处理冲突，并将关键字序列{26，25，72，38，8，18,59}依次存储到哈希表中，则在哈希表中查找元素59需要搜索的次数为( )。', '2', '3', '4', '5', 13, 'C', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (179, '设哈希表长为14，哈希函数是H(key)=key%11，表中已有数据的关键字为15，38，61，84共四个，现要将关键字为49的元素加到表中，用二次探测法解决冲突，则放入的位置是（ ）。', '8', '3', '5', '9', 13, 'D', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (180, '假定有K个关键字互为同义词，若用线性探测法把这K个关键字存入散列表中，至少要进行多少次探测？', 'K−1', 'K', 'K+1', 'K(K+1)/2', 13, 'D', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (181, '设有一组关键字 { 29，01， 13，15，56，20，87，27，69，9，10，74 }，散列函数为 H(key)=key%17，采用平方探测方法解决冲突。试在 0 到 18 的散列地址空间中对该关键字序列构造散列表，则成功查找的平均查找长度为 __', '0.33', '1.17', '1.25', '1.33', 13, 'C', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (182, '设有一组关键字 { 92，81， 58，21，57，45，161，38，117 }，散列函数为 h(key)=key%13，采用下列双散列探测方法解决第 i 次冲突：h(key)=(h(key)+i×h2​(key))%13，其中 h2​(key)=(key%11)+1。试在 0 到 12 的散列地址空间中对该关键字序列构造散列表，则成功查找的平均查找长度为 __', '1.67', '1.56', '1.44', '1.33', 13, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (183, '将关键字序列 { 7，8，30，11，18，9，14 }，散列存储到散列列表中，散列表的存储空间是一个下标从 0 开始的一维数组。处理冲突采用线性探测法。散列函数为 h(key)=(key×3)% 表长，要求装入因子为 0.7。则成功查找的平均查找长度为 __', '1.57', '1.00', '1.14', '1.29', 13, 'C', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (184, '将元素序列{18，23，11，20，2，7，27，33，42，15}按顺序插入一个初始为空的、大小为11的散列表中。散列函数为：H(Key)=Key%11，采用线性探测法处理冲突。问：当第一次发现有冲突时，散列表的装填因子大约是多少？', null, '0.45', '0.64', '0.73', 13, 'B', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (185, '给定散列表大小为11，散列函数为H(Key)=Key%11。按照线性探测冲突解决策略连续插入散列值相同的4个元素。问：此时该散列表的平均不成功查找次数是多少？', '1', '4/11', '21/11', '不确定', 13, 'C', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (186, '给定输入序列 {4371, 1323, 6173, 4199, 4344, 9679, 1989} 以及散列函数 h(X)=X%10。如果用大小为10的散列表，并且用平方探测解决冲突，则输入各项经散列后在表中的下标为：（-1表示相应的插入无法成功）', '1, 3, 3, 9, 4, 9, 9', '1, 3, 4, 9, 7, 5, -1', '1, 3, 4, 9, 5, 0, 8', '1, 3, 4, 9, 5, 0, 2', 13, 'C', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (187, '设散列表的地址区间为[0,16]，散列函数为H(Key)=Key%17。采用线性探测法处理冲突，并将关键字序列{ 26，25，72，38，8，18，59 }依次存储到散列表中。元素59存放在散列表中的地址是：', '8', '9', '10', '11', 13, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (188, '给定散列表大小为11，散列函数为H(Key)=Key%11。采用平方探测法处理冲突：hi​(k)=(H(k)±i2)%11将关键字序列{ 6，25，39，61 }依次插入到散列表中。那么元素61存放在散列表中的位置是：', '5', '6', '7', '8', 13, 'C', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (189, '若用平方探测法解决冲突，则插入新元素时，以下陈述正确的是：', '插入一定可以成功', '插入不一定能成功', '插入一定不能成功', '若散列表容量为质数，插入就一定可以成功', 13, 'B', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (190, '若N个关键词被散列映射到同一个单元，并且用分离链接法解决冲突，则找到这N个关键词所用的比较次数为：', 'N(N+1)/2', 'N(N−1)/2', 'N+1', 'N', 13, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (191, '选取哈希函数Ｈ（key）=key mod 7,用链地址法解决冲突。试在０-６的散列地址空间内对关键字序列｛31,23,17,27,19,11,13,91,61,41｝构造哈希表，并计算在等概率下成功查找的平均查找长度。', '15/10', '15/8', '17/10', '15/6', 13, 'B', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (192, 'Given a hash table of size 13 and the hash function h(x)=x%13. Assume that quadratic probing is used to solve collisions. After filling in the hash table one by one with input sequence { 10, 23, 1, 36, 19, 5 }, which number is placed in the position of index 6?', '5', '19', '36', 'none', 13, 'C', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (193, '设无向图的顶点个数为N，则该图最多有多少条边？', 'N−1', 'N(N−1)/2', 'N(N+1)/2', 'N^2', 12, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (194, '下列说法不正确的是：', '图的遍历是从给定的源点出发每一个顶点仅被访问一次', '遍历的基本算法有两种：深度遍历和广度遍历', '图的深度遍历是一个递归过程', '图的深度遍历不适用于有向图', 12, 'D', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (195, '在用邻接表表示有N个结点E条边的图时，深度优先遍历算法的时间复杂度为：', 'O(N)', 'O(N+E)', 'O(N2)', 'O(N2×E)', 12, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (196, '给定无向图G，从V0出发进行深度优先遍历访问的边集合为： {(V0,V1), (V0,V4), (V1,V2), (V1,V3), (V4,V5), (V5,V6)}。则下面哪条边不可能出现在G中？', '(V0,V2)', '(V0,V6)', '(V1,V5)', '(V4,V6)', 12, 'C', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (197, '如果从无向图的任一顶点出发进行一次深度优先搜索可访问所有顶点，则该图一定是：', '连通图', '完全图', '有回路的图', '一棵树', 12, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (198, '如果无向图G必须进行两次广度优先搜索才能访问其所有顶点，则下列说法中不正确的是：', 'G肯定不是完全图', 'G中一定有回路', 'G一定不是连通图', 'G有2个连通分量', 12, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (199, '图的广度优先遍历类似于二叉树的：', '先序遍历', '中序遍历', '后序遍历', '层次遍历', 12, 'D', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (200, '对N个元素采用简单选择排序，比较次数和移动次数分别为：', 'O(N2), O(N)', 'O(N), O(logN)', 'O(logN), O(N2)', 'O(NlogN), O(NlogN)', 11, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (201, '对于10个数的简单选择排序，最坏情况下需要交换元素的次数为：', '9', '36', '45', '100', 11, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (202, '排序算法的效率
选择排序的时间复杂度为▁▁▁▁▁ 。', 'O(n2)', 'O(nn​)', 'O(nlog2​n)', 'O(2n)', 11, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (203, '有组记录的排序码为{ 46，79，56，38，40，84 }，则利用堆排序的方法建立的初始堆为：', '79，46，56，38，40，80', '84，79，56，46，40，38', '84，56，79，40，46，38', '84，79，56，38，40，46', 11, 'D', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (204, '对N个记录进行堆排序，最坏的情况下时间复杂度是：', 'O(logN)', 'O(N)', 'O(NlogN)', 'O(N2)', 11, 'C', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (205, '对N个记录进行堆排序，需要的额外空间为：', 'O(1)', 'O(logN)', 'O(N)', 'O(NlogN)', 11, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (206, '以下序列不可以构成小根堆的是（ ）。', '12， 9， 7， 5， 3， 1', '1， 3， 5， 9， 7， 12', '1， 5， 3， 7， 9， 12', '1， 5， 3， 9， 12， 7', 11, 'D', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (207, '下列关键字序列中，构成大根堆的是（ ）。', '5，8，1，3，9，6，2，7', '9，8，1，7，5，6，2，3', '9，8，6，3，5，1，2，7', '9，8，6，7，5，1，2，3', 11, 'D', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (208, '下列四个序列中，哪一个是堆（ ）。', '75，65，30，15，25，45，20，10', '75，65，45，10，30，25，20，15', '75，45，65，30，15，25，20，10', '75，45，65，10，25，30，20，15', 11, 'C', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (209, '如果二叉树的后序遍历结果是FDEBGCA，中序遍历结果是FDBEACG，那么该二叉树的前序遍历结果是什么？', 'ABCDEFG', 'ABDFEGC', 'ABDFECG', 'ABDEFCG', 16, 'C', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (210, '设高为h的二叉树（规定叶子结点的高度为1）只有度为0和2的结点，则此类二叉树的最少结点数和最多结点数分别为：', '2h, 2h−1', '2h−1, 2h−1', '2h−1, 2h−1−1', '2h−1+1, 2h−1', 16, 'D', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (211, '在下述结论中，正确的是：

①只有一个结点的二叉树的度为0;

②二叉树的度为2；

③二叉树的左右子树可任意交换；

④深度为K的完全二叉树的结点个数小于或等于深度相同的满二叉树。', '①④', '②④', '①②③', '②③④', 16, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (212, '按照二叉树的定义，具有3个结点的二叉树有几种？', '3', '4', '5', '6', 16, 'C', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (213, '二叉树中第5层（根的层号为1）上的结点个数最多为：', '8', '15', '16', '32', 16, 'C', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (214, '如果二叉树的前序遍历结果是12345，后序遍历结果是32541，那么该二叉树的中序遍历结果是什么？', '23145', '23154', '24135', '无法确定', 16, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (215, '要使一棵非空二叉树的先序序列与中序序列相同，其所有非叶结点须满足的条件是：', '只有左子树', '只有右子树', '结点的度均为1', '结点的度均为2', 16, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (216, '已知二叉树的先序遍历序列为ABCDEFGH，中序遍历序列为CBEDFAGH，则该二叉树形态中，父节点的右子节点为（）。', 'D', 'H', 'G', 'F', 16, 'D', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (217, '若一棵二叉树的前序遍历序列是{ 4, 2, 1, 3, 6, 5, 7 }，中序遍历序列是{ 1, 2, 3, 4, 5, 6, 7 }，则下列哪句是错的？', '这是一棵完全二叉树', '所有的奇数都在叶子结点上', '6是3的父结点', '这是一棵二叉搜索树', 16, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (218, '若一棵二叉树的后序遍历序列是{ 1, 3, 2, 6, 5, 7, 4 }，中序遍历序列是{ 1, 2, 3, 4, 5, 6, 7 }，则下列哪句是错的？', '这是一棵完全二叉树', '2是1和3的父结点', '这是一棵二叉搜索树', '7是5的父结点', 16, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (219, '已知二叉树的前序遍历序列为 ABDCEFG，中序遍历序列为 DBCAFEG，则后序遍历序列为 __', 'BDACEFG', 'DCBFGEA', 'ABCDEFG', 'GFEDCBA', 16, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (220, '如果A和B都是二叉树的叶结点，那么下面判断中哪个是对的？', '存在一种二叉树结构，其前序遍历结果是…A…B…，而中序遍历结果是…B…A…', '存在一种二叉树结构，其中序遍历结果是…A…B…，而后序遍历结果是…B…A…', '存在一种二叉树结构，其前序遍历结果是…A…B…，而后序遍历结果是…B…A…', '以上三种都是错的', 16, 'C', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (221, '设n、m为一棵二叉树上的两个结点，在中序遍历时，n在m前的条件是', 'n在m左方', 'n在m右方', 'n是m祖先', 'n是m子孙', 16, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (222, '以下算法的功能是（）。
void test(bitree *t)
{
   if (t)
   {
      test(t->lchild);
      test(t->rchild);
      cout<<t->data;
   }
}', '输出二叉树的根结点值', '前序遍历二叉树', '中序遍历二叉树', '后序遍历二叉树', 16, 'D', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (223, '堆的形状是一棵：', '二叉搜索树', '满二叉树', '非二叉树', '完全二叉树', 15, 'D', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (224, '将10、12、1、14、6、5、8、15、3、9、7逐个按顺序插入到初始为空的最小堆（小根堆）中，然后连续执行两次删除最小元素操作（DeleteMin），此后堆顶的元素是什么？', '5', '6', '7', '9', 15, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (225, '对最小堆（小顶堆）{1,3,2,6,7,5,4,15,14,12,9,10,11,13,8} 进行三次删除最小元的操作后，结果序列为：', '4,5,6,7,8,9,10,11,12,13,14,15', '4,6,5,13,7,10,8,15,14,12,9,11', '4,6,5,12,7,10,8,15,14,9,13,11', '4,5,6,12,7,10,8,15,14,13,9,11', 15, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (226, '将d叉树堆存储在数组中。则对任意下标为i的单元，其父结点、第一个孩子结点、最后一个孩子结点的下标为：', '⌈(i+d−2)/d⌉、(i−2)d+2、(i−1)d+1', '⌈(i+d−1)/d⌉、(i−2)d+1、(i−1)d', '⌊(i+d−2)/d⌋、(i−1)d+2、id+1', '⌊(i+d−1)/d⌋、(i−1)d+1、id', 15, 'D', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (227, '设最小堆（小根堆）的层序遍历结果为{5, 18, 15, 28, 22, 42, 40}。用线性时间复杂度的算法将该堆调整为最大堆（大根堆），则该树的中序遍历结果为：', '18, 28, 22, 15, 40, 5, 42', '18, 28, 22, 42, 15, 40, 5', '5, 22, 18, 42, 15, 40, 28', '22, 5, 18, 42, 40, 15, 28', 15, 'B', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (228, '设最小堆（小根堆）的层序遍历结果为{1, 3, 2, 5, 4, 7, 6}。用线性时间复杂度的算法将该堆调整为最大堆（大根堆），则该树的中序遍历结果为：', '3, 5, 4, 2, 6, 1, 7', '1, 4, 3, 7, 2, 6, 5', '3, 5, 4, 7, 2, 6, 1', '4, 1, 3, 7, 6, 2, 5', 15, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (229, '在有n（>1）个元素的最大堆（大根堆）中，最小元的数组下标可以是：', '1', '⌊n/2⌋−1', '⌊n/2⌋+2', '⌊n/2⌋', 15, 'C', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (230, '以下各组序列不属于堆的是（）。', '(100,85,98,77,80,60,82,40,20,10,66)', '(10,20,40,60,66,77,80,82,85,98,100)', '(100,85,40,77,80,60,66,98,82,10,20)', '(100,98,85,82,80,77,66,60,40,20,10)', 15, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (231, '将6、4、3、5、8、9顺序插入初始为空的最大堆（大根堆）中，那么插入完成后堆顶的元素为：', '3', '5', '6', '9', 15, 'D', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (232, '在一个有2333个元素的最小堆中，下列哪个下标不可能是最大元的位置？', '50, 60, 98, 65, 72, 86', '98, 60, 65, 50, 86, 72', '98, 60, 50, 65, 86, 72', '72, 60, 65, 50, 98, 86', 15, 'D', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (233, '利用过滤法将关键字序列 { 37, 66, 48, 29, 31, 75 } 建成的最大堆为 __', '75, 66, 48, 37, 31, 29', '75, 37, 66, 29, 31, 48', '75, 66, 48, 29, 31, 37', '75, 48, 66, 37, 29, 31', 15, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (234, '下列关于大根堆（至少含 2 个元素）的叙述中，正确的是：

(I). 可以将堆看成一棵完全二叉树
(II). 可以采用顺序存储方式保存堆
(III). 可以将堆看成一棵二叉排序树
(IV). 堆中的次大值一定在根的下一层', '仅 I、II', '仅 II、III', '仅 I、II、IV', '仅 I、III、IV', 15, 'C', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (235, '以下哪项是 C 语言中合法的变量声明', 'int 123abc', 'float $value', 'double 3.14value', 'char myVar', 4, 'D', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (236, 'int x = 5;
x = x + 2 * 3;
执行以上代码后，x的值为多少', '5', '11', '10', '7', 4, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (237, ' 在 C 语言中，以下哪个运算符的优先级最高？', '+', '*', '=', '++', 4, 'D', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (238, ' 以下表达式的计算结果是什么？
 int a = 5;
int b = 3;
int result = a++ * b--;', '15', '5', '8', '20', 4, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (239, '以下哪个运算符用于计算两个数的余数', '+', '/', '%', '*', 4, 'C', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (240, ' 以下哪个表达式会导致语法错误', 'int x = 10 + 2;', 'float y = 3.14;', 'double 5value = 3.14;', 'char ch = \'A\';', 4, 'C', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (241, '以下哪种声明方式可以同时声明多个变量？', ' int x, y, z;', 'int x; int y; int z;', 'int x = 5, y = 10;', '以上全部', 4, 'D', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (242, '以下代码的输出是什么？
int x = 5;
if (x > 3) {
    printf("Hello");
} else {
    printf("World");
}', 'Hello', 'World', 'Nothing', '编译错误', 10, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (243, '以下代码的输出是什么？
int x = 2;
if (x == 2) {
    printf("Equal");
} else {
    printf("Not Equal");
}', 'Equal', 'Not Equal', 'Error', 'Nothing', 10, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (244, '以下代码的输出是什么？
int x = 0;
if (x) {
    printf("True");
} else {
    printf("False");
}', 'True', 'False', 'Nothing', '编译错误', 10, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (245, '以下代码的输出是什么？
int x = 10;
if (x > 20) {
    printf("Greater");
} else {
    printf("Smaller");
}', 'Greater', 'Smaller', 'Equal', 'Error', 10, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (246, '以下代码的输出是什么？
int x = 15;
if (x != 15) {
    printf("Not 15");
} else {
    printf("15");
}', 'Not 15', '15', 'Error', 'Nothing', 10, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (247, '以下代码的输出是什么？
int x = -1;
if (x) {
    printf("True");
} else {
    printf("False");
}', 'True', 'False', 'Nothing', '编译错误', 10, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (248, '以下代码的输出是什么？
int x = 0;
if (x == 0) {
    printf("Zero");
} else {
    printf("Not Zero");
}', 'Zero', 'Not Zero', 'Error', 'Nothing', 10, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (249, '以下代码的输出是什么？
int x = 5, y = 3;
if (x > y) {
    printf("True");
} else {
    printf("False");
}', 'True', 'False', 'Error', 'Nothing', 10, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (250, '以下代码的输出是什么？
int x = 10;
if (x >= 10) {
    printf("Greater or Equal");
} else {
    printf("Less");
}', 'Greater or Equal', 'Less', 'Nothing', 'Error', 10, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (251, '以下代码的输出是什么？
int x = 5;
if (x == 5) {
    if (x > 3) {
        printf("Correct");
} else {
        printf("Wrong");
} }', 'Correct', 'Wrong', 'Error', 'Nothing', 10, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (252, '在图的邻接矩阵表示中，若图中不存在从顶点i到顶点j的边，则邻接矩阵的元素A[i][j]的值为？', '0', '1', 'NULL', '无穷大', 12, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (253, '以下关于图的深度优先搜索（DFS）描述正确的是？', 'DFS 是一个递归过程，从某个顶点出发，遍历所有可达的顶点', 'DFS 每次访问一个顶点时，都访问它的所有邻接顶点', 'DFS 不使用栈或递归', 'DFS 是按广度进行搜索的', 12, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (254, '图的广度优先搜索（BFS）算法适用于以下哪种情况？', '找到从起点到终点的最短路径', '找到所有路径的长度', '判断图是否有环', '计算图的连通分量', 12, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (255, '以下关于图的表示方法错误的是？', '邻接矩阵适用于稠密图', '邻接表适用于稀疏图', '邻接矩阵需要更多的内存空间', '邻接表不需要存储边的个数', 12, 'D', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (256, '无向图的邻接矩阵和有向图的邻接矩阵区别是？', '无向图的邻接矩阵是对称的，而有向图的邻接矩阵不一定对称', '有向图的邻接矩阵是对称的，而无向图的邻接矩阵不一定对称', '无向图的邻接矩阵和有向图的邻接矩阵没有区别', '有向图的邻接矩阵需要比无向图的邻接矩阵多存储一个维度', 12, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (257, '图的最短路径算法中，Dijkstra算法的时间复杂度是？', 'O(V^2)', 'O(E + V)', 'O(V log V)', 'O(E log V)', 12, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (258, '在图的深度优先搜索中，何时将一个顶点标记为已访问？', '每当该顶点被栈弹出时', '每当该顶点被访问并且所有邻接点都访问过时', '每当该顶点被邻接点访问时', '每当该顶点的所有邻接点都被访问过时', 12, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (259, '在有向图中，以下哪种情况可以说明图中存在环？', '有某些顶点的入度为 0', '所有顶点的入度都为 1', '存在某些顶点的出度为 0', '图的深度优先搜索出现了回溯', 12, 'D', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (260, '在图的最小生成树算法中，以下哪种算法可以通过贪心策略求解？', 'Prim算法', 'Dijkstra算法', 'Bellman-Ford算法', 'Kruskal算法', 12, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (261, '在图的邻接表表示法中，对于每个顶点，存储的是：', '该顶点的所有邻接顶点的地址或索引', '该顶点与其他顶点的权重值', '该顶点的度', '该顶点是否被访问过', 12, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (262, '以下代码的输出是什么？
struct Person {
    int age;
    float height;
};
struct Person p = {25, 5.9};
printf("%d", p.age);', '25', '5.9', 'Error', 'Nothing', 9, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (263, '以下代码的输出是什么？
union Data {
    int i;
    float f;
};
union Data d;
d.i = 10;
d.f = 3.14;
printf("%d", d.i);', '10', '3.14', 'Error', 'Nothing', 9, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (264, '在 C 语言中，结构体变量的内存分配方式是：', '每个成员都有独立的内存空间', '所有成员共享同一块内存空间', '成员按顺序排列，空间紧凑', '结构体变量没有内存分配', 9, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (265, '在 C 语言中，使用 `union` 时，只有：', '最后一个成员会占用内存', '所有成员共享同一块内存空间', '每个成员都有独立的内存空间', '每个成员按顺序分配内存', 9, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (266, '以下代码中，哪个语句可以正确定义一个结构体类型？
struct student {
    char name[50];
    int age;
};', 'struct student { char name[50]; int age; };', 'student { char name[50]; int age; };', 'struct student name[50];', 'struct { char name[50]; int age; } student;', 9, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (267, '以下哪个选项描述了共用体（`union`）的特点？', '所有成员共享同一块内存空间，并且同一时刻只能存储一个成员的值', '每个成员有独立的内存空间，可以同时存储多个成员的值', '共用体的大小等于最大成员的大小', '共用体的大小等于所有成员的大小之和', 9, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (268, '以下代码的输出是什么？
union Data {
    int i;
    float f;
};
union Data d;
d.i = 10;
printf("%f", d.f);', '10.000000', '0.000000', '3.14', 'Error', 9, 'B', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (269, 'C 语言中结构体与共用体的主要区别在于：', '结构体中所有成员都有独立的内存空间，而共用体的成员共享同一块内存空间', '结构体和共用体没有区别，只有名称不同', '结构体和共用体都共享同一块内存空间', '结构体没有内存，而共用体分配内存', 9, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (270, '在 C 语言中，共用体的大小是由哪个成员决定的？', '最大成员的大小', '最小成员的大小', '所有成员大小的和', '没有大小限制', 9, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (271, '以下代码的输出是什么？
struct Person {
    int age;
    float height;
} p = {25, 5.9};
p.height = 6.1;
printf("%f", p.height);', '5.9', '6.1', 'Error', 'Nothing', 9, 'B', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (282, '归并排序的基本操作是什么？', '分割并合并', '交换元素', '插入元素', '选择元素', 23, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (283, '归并排序是一种什么类型的排序算法？', '分治排序算法', '插入排序算法', '选择排序算法', '冒泡排序算法', 23, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (284, '归并排序的空间复杂度是多少？', 'O(n)', 'O(n^2)', 'O(logn)', 'O(1)', 23, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (285, '归并排序的时间复杂度是多少？', 'O(nlogn)', 'O(n^2)', 'O(n)', 'O(logn)', 23, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (286, '在归并排序中，最小的子问题规模是多少？', '1', '2', '3', '4', 23, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (287, '归并排序的稳定性如何？', '稳定排序', '不稳定排序', '无法确定', '仅对某些情况稳定', 23, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (288, '归并排序与快速排序的主要区别是什么？', '归并排序是稳定的，快速排序不是', '快速排序比归并排序更稳定', '归并排序更适合小数据量', '快速排序不能用于大数据量', 23, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (289, '如何优化归并排序中的合并操作？', '使用线性归并', '减少递归深度', '减少空间复杂度', '改用插入排序', 23, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (290, '归并排序中递归调用的终止条件是什么？', '子数组长度为1', '数组排序完成', '数组为空', '递归次数达到最大', 23, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (291, '归并排序的平均时间复杂度是多少？', 'O(nlogn)', 'O(n^2)', 'O(n)', 'O(logn)', 23, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (292, '动态规划算法的核心思想是什么？', '将大问题分解为小问题', '贪心选择最优解', '使用分治法', '不断交换子问题结果', 24, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (293, '以下哪种问题最适合使用动态规划求解？', '斐波那契数列', '快速排序', '二分查找', '堆排序', 24, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (294, '动态规划的时间复杂度通常是如何表示的？', 'O(n^2)', 'O(nlogn)', 'O(n)', 'O(2^n)', 24, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (295, '在动态规划中，最常见的优化技术是？', '记忆化搜索', '剪枝', '贪心算法', '回溯法', 24, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (296, '求解背包问题时，动态规划算法的空间复杂度是？', 'O(nW)', 'O(n)', 'O(W)', 'O(n^2)', 24, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (297, '动态规划中的状态转移方程是什么？', '描述问题解法的递推关系', '描述最优解的选择策略', '描述问题的分解方式', '描述子问题的性质', 24, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (298, '动态规划的最优子结构指的是？', '问题可以分解为多个子问题且子问题的解可以组合成原问题的解', '问题的解可以通过直接比较获得', '子问题不需要重叠', '解可以通过动态更新获得', 24, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (299, '如何通过动态规划解决最长公共子序列问题？', '构建一个二维数组来保存子序列的长度', '递归地求解所有子序列', '直接从字符串中提取子序列', '动态构建所有子序列', 24, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (300, '动态规划和贪心算法的主要区别是什么？', '动态规划考虑所有可能性，贪心算法只考虑当前最优解', '贪心算法比动态规划更复杂', '动态规划有时会比贪心算法更高效', '动态规划是递归的，贪心算法是迭代的', 24, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (301, '以下哪种方法不属于动态规划的基本思想？', '通过递归计算所有子问题', '通过记忆化存储已经计算过的结果', '通过贪心算法选择局部最优解', '通过状态转移方程描述解法', 24, 'C', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (302, '分治算法的核心思想是什么？', '将问题分解为若干个子问题', '通过不断选择最优解', '每次选择一个最小的子问题', '直接求解问题', 25, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (303, '以下哪个算法使用了分治策略？', '归并排序', '快速排序', '插入排序', '冒泡排序', 25, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (304, '在分治算法中，子问题的解如何组合？', '通过合并或其他操作得到原问题的解', '直接使用子问题的解', '通过迭代获得解', '每个子问题都有独立的解', 25, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (305, '分治算法和动态规划的主要区别是什么？', '分治算法将问题分解，动态规划重用子问题的解', '动态规划不分解问题', '分治算法不需要递归', '动态规划不能用于分治问题', 25, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (306, '快速排序属于哪种类型的算法？', '分治算法', '贪心算法', '回溯算法', '动态规划算法', 25, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (307, '以下哪项是分治算法的典型应用？', '归并排序', '深度优先搜索', '广度优先搜索', '堆排序', 25, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (308, '分治算法的时间复杂度通常是多少？', 'O(nlogn)', 'O(n^2)', 'O(n)', 'O(logn)', 25, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (309, '在分治算法中，递归的终止条件通常是什么？', '子问题的规模足够小', '递归次数达到上限', '子问题无法继续分解', '子问题解无法合并', 25, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (310, '分治算法如何保证问题分解的正确性？', '通过定义合理的分解策略和合并方式', '通过不断测试每个子问题', '通过逐步减少问题规模', '通过贪心策略选择合适的解', 25, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (311, '分治算法应用的一个关键优势是什么？', '能够在大规模问题中提高效率', '无需考虑子问题的重复计算', '容易设计迭代版本', '能够避免递归调用', 25, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (312, '桶排序的核心思想是什么？', '将元素分配到不同的桶中，分别排序', '直接将元素按顺序排序', '通过交换元素实现排序', '先按位排序，再按桶排序', 26, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (313, '基数排序和桶排序的主要区别是什么？', '基数排序通过位数排序，桶排序按范围分配', '桶排序比基数排序更稳定', '基数排序只能用于整数，桶排序不行', '桶排序的空间复杂度更高', 26, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (314, '基数排序的时间复杂度通常是多少？', 'O(nk)', 'O(nlogn)', 'O(n^2)', 'O(n)', 26, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (315, '以下哪种情况适合使用桶排序？', '数据范围大且均匀分布', '数据范围小且分布不均匀', '数据排序元素较少', '数据是负数', 26, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (316, '基数排序可以处理负数吗？', '不可以', '可以', '只能处理正数', '只适用于整数', 26, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (317, '在基数排序中，每次排序的依据是什么？', '数字的某一位', '数字的大小', '数字的正负', '数字的范围', 26, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (318, '桶排序和计数排序有什么相似之处？', '都依赖于数据的范围和分布', '都需要排序元素', '都可以用于负数', '都要求数据是整数', 26, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (319, '桶排序的空间复杂度通常是多少？', 'O(n)', 'O(n^2)', 'O(nlogn)', 'O(nk)', 26, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (320, '基数排序适用于哪些数据类型？', '整数和字符串', '浮点数和字符', '整数和负数', '浮点数和数字', 26, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (321, '桶排序的平均时间复杂度是多少？', 'O(n)', 'O(nlogn)', 'O(n^2)', 'O(logn)', 26, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (322, '基数排序的缺点是什么？', '需要大量的额外空间', '适用于负数排序', '只能处理有限范围的数值', '不适用于重复数据', 26, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (323, '桶排序的稳定性如何？', '稳定排序', '不稳定排序', '无法确定', '仅对某些数据稳定', 26, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (324, '基数排序是否为稳定排序？', '是', '不是', '不一定', '不能确定', 26, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (325, '在基数排序中，如何确保排序的稳定性？', '通过使用稳定的子排序算法', '通过先排序大的数字', '通过分配不同的桶', '通过计数排序实现稳定性', 26, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (326, '以下哪种排序算法不是基于比较的排序算法？', '桶排序', '冒泡排序', '插入排序', '归并排序', 26, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (327, '贪心算法的核心思想是什么？', '每一步选择当前最优解', '分治求解子问题', '通过递归求解', '动态规划逐步求解', 14, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (328, '以下哪种问题最适合使用贪心算法？', '最小生成树', '背包问题', '最长公共子序列', '图的最短路径', 14, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (329, '贪心算法的缺点是什么？', '可能无法得到全局最优解', '计算量大', '需要大量的空间', '无法应用于所有问题', 14, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (330, '贪心算法与动态规划的主要区别是什么？', '贪心算法不考虑未来的选择', '动态规划不关心局部最优解', '贪心算法是递归的，动态规划是迭代的', '动态规划不能应用于分解问题', 14, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (331, '以下哪个问题无法通过贪心算法解决？', '最小路径问题', '活动选择问题', '背包问题', '单源最短路径问题', 14, 'C', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (332, '贪心算法常用的选择策略是？', '每次选择最小的元素', '每次选择最大的元素', '每次选择最优解', '每次选择当前未选择的元素', 14, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (333, '在贪心算法中，选择的局部最优解必须满足什么条件？', '保证能得到全局最优解', '不会影响后续决策', '比其他选择更好', '能够减少问题规模', 14, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (334, '贪心算法的应用场景是什么？', '适合能通过局部最优解得到全局最优解的问题', '适合所有可以分解为子问题的问题', '适合计算复杂度较低的问题', '适合有确定解的问题', 14, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (335, '活动选择问题的贪心策略是什么？', '选择结束时间最早的活动', '选择持续时间最长的活动', '选择开始时间最早的活动', '选择最耗费时间的活动', 14, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (336, '在贪心算法中，选择的顺序对结果的影响是什么？', '选择顺序可能会影响结果的最优性', '选择顺序不影响最终解', '选择顺序总是对最优解有影响', '选择顺序决定了问题的复杂度', 14, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (337, '贪心算法应用于最短路径算法中，常用的算法是？', 'Dijkstra算法', 'Floyd算法', 'Bellman-Ford算法', 'A*算法', 14, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (338, '在贪心算法中，选择策略的关键是？', '如何确保每步选择都能推动问题进展', '如何通过递归进行优化', '如何将问题分解为子问题', '如何获得全局最优解', 14, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (339, '以下哪种排序算法是贪心算法？', '选择排序', '快速排序', '归并排序', '堆排序', 14, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (340, '贪心算法能否应用于图的最短路径问题？', '能，尤其是Dijkstra算法', '不能，只能用动态规划', '能，使用Bellman-Ford算法', '不能，贪心算法不适合图问题', 14, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (341, '以下哪一项不属于贪心算法的特点？', '每一步选择当前最优解', '全局最优解通过局部最优解获得', '通常需要动态规划来补充决策', '计算复杂度较低', 14, 'C', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (342, 'C语言中的malloc函数用于什么？', '动态分配内存', '释放内存', '初始化内存', '判断内存是否已分配', 27, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (343, 'free函数的作用是什么？', '释放malloc分配的内存', '动态分配内存', '重新分配内存', '检查内存分配状态', 27, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (344, 'C语言中如何声明一个指向整数的指针？', 'int *ptr;', 'ptr int;', 'int ptr;', 'pointer int;', 27, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (345, 'C语言中指针和数组有什么关系？', '指针可以指向数组的首元素', '数组是指针的别名', '数组和指针没有关系', '指针可以改变数组的大小', 27, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (346, '如何避免在C语言中出现内存泄漏？', '每次malloc后使用free释放内存', '增加内存分配次数', '将内存分配放在栈上', '不使用指针', 27, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (347, '在C语言中，指针可以指向哪些数据类型？', '任意类型的数据', '只能指向整数', '只能指向字符', '只能指向结构体', 27, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (348, 'C语言中的calloc函数与malloc函数有什么区别？', 'calloc初始化内存，malloc不初始化', 'calloc用于释放内存，malloc用于分配内存', 'calloc用于数组，malloc用于单一变量', 'calloc比malloc更慢', 27, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (349, '在C语言中，指针数组是什么？', '数组的每个元素都是指针', '数组的指针', '指针的数组元素', '数组中包含指针地址', 27, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (350, 'C语言中的realloc函数作用是什么？', '重新分配内存大小', '释放内存', '初始化内存', '检查内存分配情况', 27, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (351, 'C语言中，栈内存和堆内存的主要区别是什么？', '栈内存由系统管理，堆内存由程序员管理', '栈内存更大', '堆内存更小', '栈内存用于数据存储，堆内存用于指针', 27, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (352, 'C语言中的内存对齐是什么意思？', '确保数据在内存中按特定规则对齐', '优化内存分配', '将数据存储在内存的最前面', '保证内存中的数据按大小排序', 27, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (353, '如何处理C语言中的野指针？', '在指针使用前初始化为NULL', '避免使用malloc', '指针指向常量', '指针不指向局部变量', 27, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (354, '在C语言中，NULL指针的值是什么？', '0', '-1', '不确定', '无效值', 27, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (355, 'C语言中的指针常量和常量指针有何区别？', '指针常量指针不可改变，常量指针值不可改变', '常量指针指针不可改变，指针常量值不可改变', '两者相同', '指针常量无法释放内存', 27, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (356, 'C语言中，如何判断指针是否为空？', '通过检查指针是否等于NULL', '通过检查指针的地址值', '通过解引用指针', '通过查看指针所指向的数据', 27, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (357, '在C语言中，如何打开一个文件？', '使用fopen函数', '使用open函数', '使用file_open函数', '使用create_file函数', 28, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (358, 'fopen函数的返回值是？', '文件指针', '文件描述符', '布尔值', '文件路径', 28, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (359, 'C语言中，如何读取文件中的一行内容？', '使用fgets函数', '使用getchar函数', '使用scanf函数', '使用fread函数', 28, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (360, 'C语言中，如何写入数据到文件？', '使用fprintf函数', '使用fputc函数', '使用fwrite函数', '使用fscanf函数', 28, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (361, '以下哪项操作是正确的关闭文件的方式？', '使用fclose函数', '使用close函数', '使用fcloseall函数', '使用exit函数', 28, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (362, 'C语言中，如何检查文件是否成功打开？', '使用fopen返回值', '使用file_status函数', '使用isopen函数', '使用check_file函数', 28, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (363, '在C语言中，如何读取文件中的一个字符？', '使用fgetc函数', '使用getchar函数', '使用fgets函数', '使用fscanf函数', 28, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (364, '如何在C语言中向文件写入一个字符？', '使用fputc函数', '使用putchar函数', '使用fprintf函数', '使用fwrite函数', 28, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (365, 'C语言中，fscanf和scanf有什么区别？', 'fscanf从文件读取数据，scanf从标准输入读取数据', 'fscanf从标准输入读取数据，scanf从文件读取数据', 'fscanf和scanf没有区别', 'fscanf只能读取整型数据', 28, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (366, 'C语言中，如何定位文件读取指针的位置？', '使用fseek函数', '使用ftell函数', '使用rewind函数', '使用fgetpos函数', 28, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (367, 'C语言中，如何确定文件指针当前的位置？', '使用ftell函数', '使用fseek函数', '使用fgetpos函数', '使用feof函数', 28, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (368, 'C语言中，如何清空文件内容？', '使用freopen函数', '使用fclose函数', '使用fseek函数', '使用fwrite函数', 28, 'A', 1);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (369, '如何判断文件指针是否已到达文件结尾？', '使用feof函数', '使用ferror函数', '使用fseek函数', '使用fgets函数', 28, 'A', 2);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (370, '在C语言中，如何以二进制模式打开文件？', '在fopen中使用"rb"或"wb"模式', '在fopen中使用"txt"模式', '在open中使用"binary"模式', '使用fopen后调用set_binary模式', 28, 'A', 3);
INSERT INTO evaluation.question_choice (question_id, question_name, question_choice_a, question_choice_b, question_choice_c, question_choice_d, question_type_id, question_answer, question_level) VALUES (371, 'C语言中，如何判断文件是否发生错误？', '使用ferror函数', '使用feof函数', '使用fclose函数', '使用fseek函数', 28, 'A', 2);
