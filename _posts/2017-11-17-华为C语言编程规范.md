# 学习之用

## 前言
  为提高产品代码质量，指导广大软件开发人员编写出简洁、可维护、可靠、可测试、高效、可移植的代码，编程规范修订工作组分析、总结了我司的各种典型编码问题，并参考了业界编程规范近年来的成果，重新对我司1999年版编程规范进行了梳理、优化、刷新，编写了本规范。
  
本规范将分为完整版和精简版，完整版将包括更多的样例、规范的解释以及参考材料(what & why)，而精简版将只包含规则部分(what)以便查阅。

在本规范的最后，列出了一些业界比较优秀的编程规范，作为延伸阅读参考材料。

## 代码总体原则
### 1、清晰第一
清晰性是易于维护、易于重构的程序必需具备的特征。代码首先是给人读的，好的代码应当可以像文章一样发声朗诵出来。

目前软件维护期成本占整个生命周期成本的40%~90%。根据业界经验，维护期变更代码的成本，小型系统是开发期的5倍，大型系统（100万行代码以上）可以达到100倍。业界的调查指出，开发组平均大约一半的人力用于弥补过去的错误，而不是添加新的功能来帮助公司提高竞争力。

“程序必须为阅读它的人而编写，只是顺便用于机器执行。”——Harold Abelson 和 Gerald Jay
Sussman

“编写程序应该以人为本，计算机第二。”——Steve McConnell

本规范通过后文中的原则（如头优秀的代码可以自我解释，不通过注释即可轻易读懂/头文件中适合放置接口的声明，不适合放置实现/除了常见的通用缩写以外，不使用单词缩写，不得使用汉语拼音）、规则（如防止局部变量与全局变量同名）等说明清晰的重要性。

**一般情况下，代码的可阅读性高于性能，只有确定性能是瓶颈时，才应该主动优化。**

### 2、简洁为美
简洁就是易于理解并且易于实现。代码越长越难以看懂，也就越容易在修改时引入错误。写的代码越多，意味着出错的地方越多，也就意味着代码的可靠性越低。因此，我们提倡大家通过编写简洁明了的代码来提升代码可靠性。

废弃的代码(没有被调用的函数和全局变量)要及时清除，重复代码应该尽可能提炼成函数。

本规范通过后文中的原则（如文件应当职责单一/一个函数仅完成一件功能）、规则（重复代码应该尽可能提炼成函数/避免函数过长，新增函数不超过50行）等说明简洁的重要性。

### 3、选择合适的风格，与代码原有风格保持一致
产品所有人共同分享同一种风格所带来的好处，远远超出为了统一而付出的代价。在公司已有编码规范的指导下，审慎地编排代码以使代码尽可能清晰，是一项非常重要的技能。

如果重构/修改其他风格的代码时，比较明智的做法是根据现有代码的现有风格继续编写代码，或者使用格式转换工具进行转换

# 排版

### 1-1：程序块要采用缩进风格编写，缩进的空格数为4个。
说明：对于由开发工具自动生成的代码可以有不一致。
### 1-2：相对独立的程序块之间、变量说明之后必须加空行。
示例：如下例子不符合规范。
```
if (!valid_ni(ni))
{
    ... // program code
}
repssn_ind = ssn_data[index].repssn_index;
repssn_ni  = ssn_data[index].ni;
```
应如下书写
```
if (!valid_ni(ni))
{
    ... // program code
}

repssn_ind = ssn_data[index].repssn_index;
repssn_ni  = ssn_data[index].ni;
```

### 1-3：较长的语句（>80字符）要分成多行书写，长表达式要在低优先级操作符处划分新行，操作符放在新行之首，划分出的新行要进行适当的缩进，使排版整齐，语句可读。
示例：
```
perm_count_msg.head.len = NO7_TO_STAT_PERM_COUNT_LEN
                          + STAT_SIZE_PER_FRAM * sizeof( _UL );
 
act_task_table[frame_id * STAT_TASK_CHECK_NUMBER + index].occupied
              = stat_poi[index].occupied;
 
act_task_table[taskno].duration_true_or_false
              = SYS_get_sccp_statistic_state( stat_item );
 
report_or_not_flag = ((taskno < MAX_ACT_TASK_NUMBER)
                      && (n7stat_stat_item_valid (stat_item))
                      && (act_task_table[taskno].result_data != 0));
```
### 1-4：循环、判断等语句中若有较长的表达式或语句，则要进行适应的划分，长表达式要在低优先级操作符处划分新行，操作符放在新行之首。
示例：
```
if ((taskno < max_act_task_number)
    && (n7stat_stat_item_valid (stat_item)))
{
    ... // program code
}
 
for (i = 0, j = 0; (i < BufferKeyword[word_index].word_length)
                    && (j < NewKeyword.word_length); i++, j++)
{
    ... // program code
}
 
for (i = 0, j = 0;  
     (i < first_word_length) && (j < second_word_length);  
     i++, j++)
{
    ... // program code
}
```

### 1-5：若函数或过程中的参数较长，则要进行适当的划分。
示例：
```
n7stat_str_compare((BYTE *) & stat_object,
                   (BYTE *) & (act_task_table[taskno].stat_object),
                   sizeof (_STAT_OBJECT));
 
n7stat_flash_act_duration( stat_item, frame_id *STAT_TASK_CHECK_NUMBER
                                      + index, stat_object );
```

### 1-6：不允许把多个短语句写在一行中，即一行只写一条语句。
示例：如下例子不符合规范。
```
rect.length = 0;  rect.width = 0;
```
 应如下书写
 ```
rect.length = 0;
rect.width  = 0;
```
### 1-7：if、for、do、while、case、switch、default等语句自占一行，且if、for、do、while等语句的执行语句部分无论多少都要加括号{}。 
示例：如下例子不符合规范。
```
if (pUserCR == NULL) return;
```
应如下书写：
```
if (pUserCR == NULL)
{
    return;
}
```
### 1-8：对齐只使用空格键，不使用TAB键。
说明：以免用不同的编辑器阅读程序时，因TAB键所设置的空格数目不同而造成程序布局不整齐，不要使用BC作为编辑器合版本，因为BC会自动将8个空格变为一个TAB键，因此使用BC合入的版本大多会将缩进变乱。
### 1-9：函数或过程的开始、结构的定义及循环、判断等语句中的代码都要采用缩进风格，case语句下的情况处理语句也要遵从语句缩进要求。

### 1-10：程序块的分界符（如C/C++语言的大括号‘{’和‘}’）应各独占一行并且位于同一列，同时与引用它们的语句左对齐。在函数体的开始、类的定义、结构的定义、枚举的定义以及if、for、do、while、switch、case语句中的程序都要采用如上的缩进方式。
示例：如下例子不符合规范。
```
for (...) {
    ... // program code
}
 
if (...)
    {
    ... // program code
    }
 
void example_fun( void )
    {
    ... // program code
    }
 ```
应如下书写。
```
for (...)
{
    ... // program code
}
 
if (...)
{
    ... // program code
}
 
void example_fun( void )
{
    ... // program code
}
```
### 1-11：在两个以上的关键字、变量、常量进行对等操作时，它们之间的操作符之前、之后或者前后要加空格；进行非对等操作时，如果是关系密切的立即操作符（如－>），后不应加空格。
说明：采用这种松散方式编写代码的目的是使代码更加清晰。
由于留空格所产生的清晰性是相对的，所以，在已经非常清晰的语句中没有必要再留空格，如果语句已足够清晰则括号内侧(即左括号后面和右括号前面)不需要加空格，多重括号间不必加空格，因为在C/C++语言中括号已经是最清晰的标志了。
在长语句中，如果需要加的空格非常多，那么应该保持整体清晰，而在局部不加空格。给操作符留空格时不要连续留两个以上空格。
 
示例：
##### (1) 逗号、分号只在后面加空格。
```
int a, b, c;
```
##### (2)比较操作符, 赋值操作符"="、 "+="，算术操作符"+"、"%"，逻辑操作符"&&"、"&"，位域操作符"<<"、"^"等双目操作符的前后加空格。
```
if (current_time >= MAX_TIME_VALUE)
a = b + c;
a *= 2;
a = b ^ 2;
```
##### (3)"!"、"~"、"++"、"--"、"&"（地址运算符）等单目操作符前后不加空格。
```
*p = 'a';        // 内容操作"*"与内容之间
flag = !isEmpty; // 非操作"!"与内容之间
p = &mem;        // 地址操作"&" 与内容之间
i++;             // "++","--"与内容之间
```
##### (4)"->"、"."前后不加空格。
```
p->id = pid;     // "->"指针前后不加空格
```
##### (5) if、for、while、switch等与后面的括号间应加空格，使if等关键字更为突出、明显。
```
if (a >= b && c > d)
```  
## 1-12：一行程序以小于80字符为宜，不要写得过长。



# 2 注释

### 2-1:一般情况下,源程序有效注释量必须在20%以上。
说明:注释的原则是有助于对程序的阅读理解,在该加的地方都加了,注释不宜太多也不 能太少,注释语言必须准确、易懂、简洁。

### 2-2:说明性文件(如头文件.h文件、.inc文件、.def文件、编译说明文件.cfg等)头部应 进行注释,注释必须列出:版权说明、版本号、生成日期、作者、内容、功能、与其它文件的关系、修改日志等,头文件的注释中还应有函数功能简要说明。

示例:下面这段头文件的头注释比较标准,当然,并不局限于此格式,但上述信息建议要包含在内。

````
/*************************************************
  Copyright (C), 1988-1999, Huawei Tech. Co., Ltd.
  File name : // 文件名
  Author:       Version:      Date: // 作者、版本及完成日期
  Description     //用于详细说明此程序文件完成的主要功能,与其他模块
                  // 或函数的接口,输出值、取值范围、含义及参数间的控
                  // 制、顺序、独立或依赖等关系
  Function List
    1. ....
  History: // 修改历史记录列表,每条修改记录应包括修改日期、修改
           // 者及修改内容简述
    1. Date:
      Author:
      Modification:
    2. ...
*************************************************/
````

### 2-3:源文件头部应进行注释,列出:版权说明、版本号、生成日期、作者、模块目的/功能、 主要函数及其功能、修改日志等。

示例:下面这段源文件的头注释比较标准,当然,并不局限于此格式,但上述信息建议要包含在内。

```
/************************************************************   Copyright (C), 1988-1999, Huawei Tech. Co., Ltd.   
FileName: test.cpp    
Author:        Version :          Date:   
Description:     // 模块描述   
Version:         // 版本信息    
Function List:   // 主要函数及其功能     
    1. ...    
History:         // 历史修改记录       
    <author>  <time>   <version >   <desc>        
    David    96/10/12     1.0     build this moudle
***********************************************************/
```
说明: Description 一项描述本文件的内容、功能、内部各部分之间的关系及本文件与其它文件关系等。History是修改历史记录列表,每条修改记录应包括修改日期、修改者及修改内容简述。

### 2-4: 函数头部应进行注释,列出:函数的目的/功能、输入参数、输出参数、返回值、调用 关系(函数、表)等。

示例:下面这段函数的注释比较标准,当然,并不局限于此格式,但上述信息建议要包含在内。
```
/*************************************************   
  Function:       // 函数名称    
  Description:    // 函数功能、性能等的描述   
  Calls:          // 被本函数调用的函数清单   
  Called By:      // 调用本函数的函数清单    
  Table Accessed: // 被访问的表(此项仅对于牵扯到数据库操作的程序)   Table Updated:  // 被修改的表(此项仅对于牵扯到数据库操作的程序)   Input:          // 输入参数说明, 包括每个参数的作                                 // 用、取值说明及参数间关系。   
  Output:         // 对输出参数的说明。   
  Return:         // 函数返回值的说明   
  Others:         // 其它说明
  *************************************************/
```

### 2-5: 边写代码边注释,修改代码同时修改相应的注释,以保证注释与代码的一致性。不再有用的注释要删除。

### 2-6: 注释的内容要清楚、明了,含义准确,防止注释二义性。

说明:错误的注释不但无益反而有害。

### 规则2-7: 避免在注释中使用缩写,特别是非常用缩写。

说明:在使用缩写时或之前,应对缩写进行必要的说明.


### 2-8:注释应与其描述的代码相近,对代码的注释应放在其上方或右方(对单条语句的注释) 相邻位置,不可放在下面,如放于上方则需与其上面的代码用空行隔开。

示例:如下例子不符合规范。

例1:
```
/* get replicate sub system index and net indicator */

repssn_ind = ssn_data[index].repssn_index;
repssn_ni = ssn_data[index].ni;
```
例2:
```
repssn_ind = ssn_data[index].repssn_index;
repssn_ni = ssn_data[index].ni;
/* get replicate sub system index and net indicator */
```
应如下书写
```
/* get replicate sub system index and net indicator */
repssn_ind = ssn_data[index].repssn_index;
repssn_ni = ssn_data[index].ni;
```

### 2-9:对于所有有物理含义的变量、常量,如果其命名不是充分自注释的,在声明时都必须加 以注释,说明其物理含义。变量、常量、宏的注释应放在其上方相邻位置或右方。

示例:
```
/* active statistic task number */
#define MAX_ACT_TASK_NUMBER 1000

#define MAX_ACT_TASK_NUMBER 1000 /* active statistic task number */
```

### 2-10:数据结构声明(包括数组、结构、类、枚举等),如果其命名不是充分自注释的,必须 加以注释。对数据结构的注释应放在其上方相邻位置,不可放在下面;对结构中的每个域的注 释放在此域的右方。

示例:可按如下形式说明枚举/数据/联合结构。
```
/* sccp interface with sccp user primitive message name */

enum SCCP_USER_PRIMITIVE {
    N_UNITDATA_IND, /* sccp notify sccp user unit data come */ N_NOTICE_IND,   /* sccp notify user the No.7 network can not */
                    /* transmission this message */
    N_UNITDATA_REQ, /* sccp user's unit data transmission request*/
};
```

### 2-11:全局变量要有较详细的注释,包括对其功能、取值范围、哪些函数或过程存取它以及存取时注意事项等的说明。
 
示例:
```
/* The ErrorCode when SCCP translate */
/* Global Title failure, as follows */         //变量作用、含义
/* 0 － SUCCESS   1 － GT Table error */ 
/* 2 － GT error  Others － no use  */         //变量取值范围
/* only  function  SCCPTranslate() in */
/* this modual can modify it, and  other */ 
/* module can visit it through call */ 
/* the  function GetGTTransErrorCode() */      //使用方法
BYTE g_GTTranErrorCode; 
```


### 2-12:注释与所描述内容进行同样的缩排。

说明:可使程序排版整齐,并方便注释的阅读与理解。

示例:如下例子,排版不整齐,阅读稍感不方便。

```
void example_fun( void )
{
/* code one comments */
    CodeBlock One
    
        /* code two comments */
    CodeBlock Two
}
```

应改为如下布局。
```
void example_fun( void )
{
    /* code one comments */
    CodeBlock One
    /* code two comments */
    CodeBlock Two
}
```

### 2-13: 将注释与其上面的代码用空行隔开。

示例:如下例子,显得代码过于紧凑。
```
/* code one comments */ 
program code one
/* code two comments */
program code two
```
应如下书写
```
/* code one comments */
program code one

/* code two comments */
program code two
```

### 2-14: 对变量的定义和分支语句(条件分支、循环语句等)必须编写注释。 
说明:这些语句往往是程序实现某一特定功能的关键,对于维护人员来说,良好的注释帮助更好的理解程序,有时甚至优于看设计文档。

### 2-15: 对于switch语句下的case语句,如果因为特殊情况需要处理完一个case后进入下一 个case处理,必须在该case语句处理完、下一个case语句前加上明确的注释。

说明:这样比较清楚程序编写者的意图,有效防止无故遗漏 break 语句。

示例(注意斜体加粗部分):
```
case CMD_UP:
    ProcessUp();
    break;
   
case CMD_DOWN:
    ProcessDown();
    break;
   
case CMD_FWD:
    ProcessFwd();
    
    
if (...) {
    ...
    break;
}
else 
{
    ProcessCFW_B();   // now jump into case CMD_A
}

 
case CMD_A:
    ProcessA();
    break;
    
case CMD_B:
    ProcessB();
    break;
    
case CMD_C:
    ProcessC();
    break;
    
case CMD_D:
    ProcessD();
    break;
...
```
### 1⁄2 2-1:避免在一行代码或表达式的中间插入注释。

说明:除非必要,不应在代码或表达中间插入注释,否则容易使代码可理解性变差。

###  1⁄2 2-2:通过对函数或过程、变量、结构等正确的命名以及合理地组织代码的结构,使代码成为 自注释的。

  说明:清晰准确的函数、变量等的命名,可增加代码可读性,并减少不必要的注释。
  
### 1⁄2 2-3: 在代码的功能、意图层次上进行注释,提供有用、额外的信息。

说明:注释的目的是解释代码的目的、功能和采用的方法,提供代码以外的信息,帮助读者理解代码,防止没必要的重复注释信息。

示例:如下注释意义不大。
```
/* if receive_flag is TRUE */
if (receive_flag)
```
而如下的注释则给出了额外有用的信息。
```
/* if mtp receive a message from links */
if (receive_flag)
```

### 1⁄2 2-4:在程序块的结束行右方加注释标记,以表明某程序块的结束。

说明:当代码段较长,特别是多重嵌套时,这样做可以使代码更清晰,更便于阅读。

示例:参见如下例子。
```
if (...) {
    // program code

    while (index < MAX_INDEX)
    {
        // program code
    } /* end of while (index < MAX_INDEX) */ // 指明该条 while 语句结束
} /* end of if (...)*/ // 指明是哪条 if 语句结束
```

###  1⁄2 2-5: 注释格式尽量统一,建议使用“/* ...... */”。

### 1⁄2 2-6: 注释应考虑程序易读及外观排版的因素,使用的语言若是中、英兼有的,建议多使用中文,除非能用非常流利准确的英文表达。

说明:注释语言不统一,影响程序易读性和外观排版,出于对维护人员的考虑,建议使用中文。

# 3 标识符命名

 ### 3-1: 标识符的命名要清晰、明了,有明确含义,同时使用完整的单词或大家基本可以理解的 缩写,避免使人产生误解。
 
说明:较短的单词可通过去掉“元音”形成缩写;较长的单词可取单词的头几个字母形成 缩写;一些单词有大家公认的缩写。

示例:如下单词的缩写能够被大家基本认可。

```
temp 可缩写为 tmp;
flag 可缩写为 flg; 
statistic 可缩写为 stat; 
increment 可缩写为 inc; 
message 可缩写为 msg;
```
### 3-2:命名中若使用特殊约定或缩写,则要有注释说明。

说明:应该在源文件的开始之处,对文件中所使用的缩写或约定,特别是特殊的缩写,进行必要的注释说明。

### 3-3:自己特有的命名风格,要自始至终保持一致,不可来回变化。

说明:个人的命名风格,在符合所在项目组或产品组的命名规则的前提下,才可使用。(即 命名规则中没有规定到的地方才可有个人命名风格)。

### 3-4:对于变量命名,禁止取单个字符(如i、j、k...),建议除了要有具体含义外,还能 表明其变量类型、数据类型等,但i、j、k作局部循环变量是允许的。

说明:变量,尤其是局部变量,如果用单个字符表示,很容易敲错(如 i 写成 j),而编 译时又检查不出来,有可能为了这个小小的错误而花费大量的查错时间。 示例:下面所示的局部变量名的定义方法可以借鉴。
```
int liv_Width
```
其变量名解释如下:
```
l 局部变量(Local) (其它:g 全局变量(Global)...) 
i 数据类型(Interger)
v 变量(Variable) (其它:c 常量(Const)...) 
Width 变量含义
```
 这样可以防止局部变量与全局变量重名。
 
#### 3-5:命名规范必须与所使用的系统风格保持一致,并在同一项目中统一,比如采用UNIX的 全小写加下划线的风格或大小写混排的方式,不要使用大小写与下划线混排的方式,用作特殊 标识如标识成员变量或全局变量的m_和g_,其后加上大小写混排的方式是允许的。
示例: 
```
Add_User 不允许,add_user、AddUser、m_AddUser 允许。
```
### 1⁄2 3-1:除非必要,不要用数字或较奇怪的字符来定义标识符。 示例:如下命名,使人产生疑惑。
```
#define _EXAMPLE_0_TEST_
#define _EXAMPLE_1_TEST_

void set_sls00( BYTE sls );
```
应改为有意义的单词命名
```
#define _EXAMPLE_UNIT_TEST_
#define _EXAMPLE_ASSERT_TEST_

void set_udt_msg_sls( BYTE sls );
```
### 1⁄2 3-2:在同一软件产品内,应规划好接口部分标识符(变量、结构、函数及常量)的命名,防 止编译、链接时产生冲突。

说明:对接口部分的标识符应该有更严格限制,防止冲突。如可规定接口部分的变量与常 量之前加上“模块”标识等。

### 1⁄2 3-3:用正确的反义词组命名具有互斥意义的变量或相反动作的函数等。 
说明:下面是一些在软件中常用的反义词组。
```
add / remove 
begin / end 
insert / delete 
first / last 
increment / decrement
create / destroy
get / release
put / get
open / close
start / stop
show / hide
add / delete 
min / max
next / previous 
send / receive 
cut / paste 
```
示例:
```
int min_sum;
lock / unlock
old / new
source / target
source / destination
up / down
int max_sum;
int add_user( BYTE *user_name ); 
int delete_user( BYTE *user_name );
```

### 1⁄2 3-4:除了编译开关/头文件等特殊应用,应避免使用_EXAMPLE_TEST_之类以下划线开始和结尾的定义。


# 4 可读性
 ### 4-1:注意运算符的优先级,并用括号明确表达式的操作顺序,避免使用默认优先级。 说明:防止阅读程序时产生误解,防止因默认的优先级与设计思想不符而导致程序出错。 示例:下列语句中的表达式
```
word = (high << 8) | low (1) 
if ((a | b) && (a & c))  (2) 
if ((a | b) < (c & d))   (3) 
```
如果书写为
```
high << 8 | low 
a | b && a & c 
a | b < c & d 
```
由于
```
high << 8 | low = ( high << 8) | low,

a | b && a & c = (a | b) && (a & c),
```
(1)(2)不会出错,但语句不易理解;
```
a | b < c & d = a | (b < c) & d, (3)造成了判断条件出错。
```

###  4-2:避免使用不易理解的数字,用有意义的标识来替代。涉及物理状态或者含有物理意义的 常量,不应直接使用数字,必须用有意义的枚举或宏来代替。
  示例:如下的程序可读性差。
  ```
if (Trunk[index].trunk_state == 0)
{
    Trunk[index].trunk_state = 1;
    ... // program code 
    
}
```
应改为如下形式。
```
#define TRUNK_IDLE 0
#define TRUNK_BUSY 1

if (Trunk[index].trunk_state == TRUNK_IDLE)
{
    Trunk[index].trunk_state = TRUNK_BUSY;
    ... // program code 
}
```
### 1⁄2 4-1:源程序中关系较为紧密的代码应尽可能相邻。 说明:便于程序阅读和查找。 示例:以下代码布局不太合理。
```
rect.length = 10;
char_poi = str;
rect.width = 5;
```
  若按如下形式书写,可能更清晰一些。
```
rect.length = 10;
rect.width = 5; // 矩形的长与宽关系较密切,放在一起。 
char_poi = str;
```
### 1⁄2 4-2:不要使用难懂的技巧性很高的语句,除非很有必要时。

说明:高技巧语句不等于高效率的程序,实际上程序的效率关键在于算法。

示例:如下表达式,考虑不周就可能出问题,也较难理解。
```
* stat_poi ++ += 1;
* ++ stat_poi += 1;
```
应分别改为如下。
```
*stat_poi += 1;
stat_poi++; // 此二语句功能相当于“ *stat_poi ++ += 1; ”

++ stat_poi;
*stat_poi += 1; // 此二语句功能相当于“ *++ stat_poi += 1; ”
```