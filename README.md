# skill-regex

二次封装 Skill 中的正则表达式相关函数 ( PCRE )，简化使用方式。

## 项目依赖

+ 加载时依赖
  + skill-loader [ [GitHub](https://github.com/yeungchie/skill-loader "https://github.com/yeungchie/skill-loader") / [Gitee](https://gitee.com/yeungchie/skill-loader "https://gitee.com/yeungchie/skill-loader") ]

## 函数

### ycRegEx

```text
ycRegEx(
    S_string
    t_pattern
    [ g_replace ]
    [ g_options ]
    [ t_substitute ]
)
```

> alias: `rex`

### ycRegExSub

```text
ycRegExSub(
    [ g_bodyString ... ]
    [ ?join t_joinString ]
)
```

> alias: `rexsub`

### ycRegExSplit

```text
ycRegExSplit(
    t_string
    t_pattern
    [ g_options ]
)
```

> alias: `rexsplit`
