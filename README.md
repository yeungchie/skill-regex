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

### rexsub

```text
rexsub(
    [ g_bodyString ... ]
    [ ?join S_joinString ]
)
```

> alias to `ycRegExSub`

### rexsplit

```text
rexsplit(
    S_string
    t_pattern
    [ g_options ]
)
```

> alias to `ycRegExSplit`

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
