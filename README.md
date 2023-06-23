# skill-regex

二次封装 Skill 中的正则表达式相关函数 ( PCRE )，简化使用方式。

## 项目依赖

+ skill-loader [ [GitHub](https://github.com/yeungchie/skill-loader "https://github.com/yeungchie/skill-loader") / [Gitee](https://gitee.com/yeungchie/skill-loader "https://gitee.com/yeungchie/skill-loader") ]

## 函数

### rex

```text
rex(
    S_string
    t_pattern
    [ g_replace ]
    [ g_options ]
    [ t_substitute ]
)
```

> alias to `ycRegEx`

1. S_string
    + 被匹配的字符。
    + 类型限制：string, symbol

2. t_pattern
    + 正则表达式。
    + 类型限制：string

3. g_replace
    + 可选项。
    + 如果需要启用替换，则这里指定替换匹配的子串，默认只替换一次。
    + 默认值为 nil，不启用替换模式。
    + 如果有更加复杂的替换逻辑，可以指定 symbol 作为函数名，也可以指定一个 lambda 对象（funobj），匹配结束后会继续运行指定的 replace 逻辑函数，并将其返回值作为这次匹配的返回值，函数需要指定一个 dpl 输入参数。
    + 类型限制：nil, string, symbol, funobj

4. g_options
    + 可选项。
    + 如果需要启用额外条件，则可以用 "i" 代表忽略大小写差异，"g" 代表匹配替换多次， "m" 代表多行匹配。
    + 可以指定多个条件，例如使用 "igm" 同时开启上面三个条件。
    + 默认值为 nil，代表没有额外的条件。
    + 类型限制：nil, string

5. t_substitute
    + 可选项。
    + 如果你使用了分组匹配的 pattern 则可以指定返回具体的组。
    + 例如 "\\1" 代表第一组，"\\2" 代表第二组，其他字符串则会原封不动返回。
    + 默认值为 "\\0"，代表返回匹配到的字符。
    + 类型限制：string

+ 简单匹配

```skill
rex( "NET<3:0>" "NET<\\d:\\d>" )
; "NET<3:0>"
```

+ 匹配并替换

```skill
rex( "NET<3:0>" "NET" "ABC" )
; "ABC<3:0>"
```

+ 指定条件

```skill
rex( "NET<3:0>" "net" )
; nil
rex( "NET<3:0>" "net" nil "i" )  ; 忽略大小写
; NET
```

+ 分组匹配

```skill
rex( "NET<3:0>" "(net)<(\\d):(\\d)>" nil "i" "bus:\\1 high:\\2 low:\\3")
"bus:NET high:3 low:0"
```

+ 自定义替换逻辑

```skill
procedure(addNumAndBit(arg)
    let((net num bit)
        net = rexsub(1)
        num = rexsub(2)
        bit = rexsub(3)
        sprintf(nil "%s_%d<%d>" net atoi(num)+1 atoi(bit)+1)
    )
)

rex( "PIN_1<0>" "(PIN)_(\\d)<(\\d)>" 'addNumAndBit )
; "PIN_2<1>"
```

### rexsub

```text
rexsub(
    [ g_bodyString ... ]
    [ ?join S_joinString ]
)
```

> alias to `ycRegExSub`

1. g_bodyString
    + 可选项。
    + 捕获在上一次分组匹配中的第几个组作为返回值。
    + 可以直接使用整数数字来代表组的顺序，例如 1 代表第一组。
    + 也可以使用 字符串 "\\" 后加数字来代表组的顺序，例如 "\\2" 代表第二组。
    + 如果置顶了其他内容，则会原封不动返回。
    + 类型限制：all

2. ?join S_joinString
    + 可选项。
    + 作为多个字符串的连接符，默认值为 " "。
    + 类型限制：string

```skill
rex( "2023-02-23" "(\\d+)-(\\d+)-(\\d+)" )
rexsub( 1 2 3 ?join ",")
"2023,02,23"
```

### rexsplit

```text
rexsplit(
    S_string
    t_pattern
    [ g_options ]
)
```

> alias to `ycRegExSplit`

相对于 `parseString` 函数，`rexsplit` 可以利用正则匹配做字符串切片。

```skill
parseString( "A-B--C-D" "--" )
; ("A" "B" "C" "D")

rexsplit( "A-B--C-D" "--" )
; ("A-B" "C-D")

rexsplit( "A1-B2-C3-D4" "[\\d-]+" )
; ("A" "B" "C" "D" "")
```

### rexcase

```text
rexcase(
    S_string
    ( t_pattern1 g_body1 )
    [ ( t_pattern2 g_body2 ) ... ]
    [ ?replace g_replace ]
    [ ?options g_options ]
    [ ?sub t_sub ]
)
```

> alias to `ycRegExCase`

和 `case` 函数一样的使用格式，只不过判断相等变成判断是否匹配。

```skill
rexcase( "net<3:0>"
    ("<\\d+>"
        printf( "This is a single signal in the bus signal\n" )
    )
    ("<\\d+:\\d+>"
        printf( "This is a set of bus signals\n" )
    )
    (t
        printf( "This is not a bus signal\n" )
    )
)
; This is a set of bus signals
```
