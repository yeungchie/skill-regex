;--------------------------
; Program  : skill-regex(ycRegEx.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycRegEx(_ycRegEx_str _ycRegEx_pattern \@optional _ycRegEx_replace _ycRegEx_options _ycRegEx_substitute("\\0") _ycRegEx_dontMapObj "Sgggtg")
    let((_ycRegEx_Result _ycRegEx_Params)
        _ycRegEx_Result = prog((str pattern replace options substitute dontMapObj replaceType cmp index cmpOpt char undef result)
            ; 变量保护
            foreach(sym '(str pattern replace options substitute dontMapObj)
                set(sym eval(concat("_ycRegEx_" sym)))
            )

            ; pattern 为 t 时直接返回 t
            when(pattern == t
                return(t)
            )

            ; pattern 必须为字符串或非空列表
            unless(stringp(pattern) || pairp(pattern)
                ycError("argument #2 should be either a string or a list of non-nil or t - %A" pattern)
            )

            ; 模式检测
            cond(
                (stringp(pattern) && !replace
                    ; 单模式匹配
                    t
                )
                (stringp(pattern) && !listp(replace)
                    ; 单模式替换
                    t
                )
                (pairp(pattern) && !replace
                    ; 多模式匹配
                    foreach(p pattern
                        when(_ycRegEx_Result = ycRegEx(str p nil options substitute dontMapObj)
                            return(_ycRegEx_Result)
                        )
                    )
                    return()
                )
                (pairp(pattern) && pairp(replace)
                    ; 多模式替换
                    let((_ycRegEx_last)
                        _ycRegEx_last = str
                        foreach((p r) pattern replace
                            _ycRegEx_last = ycRegEx(_ycRegEx_last p r options substitute dontMapObj)
                        )
                        return(_ycRegEx_last)
                    )
                )
                (pairp(pattern) && !pairp(replace)
                    ; 多模式单替换
                    let((_ycRegEx_last)
                        _ycRegEx_last = str
                        foreach(p pattern
                            _ycRegEx_last = ycRegEx(_ycRegEx_last p replace options substitute dontMapObj)
                        )
                        return(_ycRegEx_last)
                    )
                )
                (t
                    ycError("if you want to use multi-pattern mode, argument #2 should be a list of non-nil and elements non-list - %A" pattern)
                )
            )

            when(replace
                replaceType = type(replace)
            )
            unless(member(replaceType '(string symbol funobj list nil))
                ycError("if you want to use replace mode, the argument #3 should be either a string of replacement, symbol of function name, variable of function object or list, else nil - %A" replace)
            )
            when((replaceType == 'symbol) && !fboundp(replace)
                ycError("undefined function - %A" replace)
            )

            index = 1
            cmpOpt = 0
            options = case(type(options)
                (string options)
                (symbol symbolToString(options))
                (t
                    if(options
                        ycError("argument #4 should be a string or a symbol - %A" options)
                        ""
                    )
                )
            )
            for(i 1 strlen(options)
                char = getchar(options i)
                case(char
                    (" "    t)
                    (g      index = 0)                                              ; 全局匹配
                    (i      cmpOpt = cmpOpt | pcreGenCompileOptBits(?caseLess  t))  ; 忽略英文大小写
                    (s      cmpOpt = cmpOpt | pcreGenCompileOptBits(?dotAll    t))  ; 单行匹配
                    (m      cmpOpt = cmpOpt | pcreGenCompileOptBits(?multiLine t))  ; 多行匹配
                    (t      undef = strcat(undef || "" char))
                )
            )

            when(undef
                ycWarn("skip undefined options char - %s" undef)
            )

            unless(cmp = pcreCompile(pattern cmpOpt)
                return()
            )

            unless(dontMapObj
                ycRegExSetCompileObject(pattern cmp)
            )

            when(symbolp(str)
                str = symbolToString(str)
            )

            if(replaceType == 'string
            then
                result = pcreReplace(cmp str replace index)
            else
                when(pcreExecute(cmp str)
                    result = pcreSubstitute(cmp substitute)
                )
                when(member(replaceType '(symbol funobj))
                    _ycRegEx_Params = list(replace list(nil
                        'source     str
                        'pattern    pattern
                        'replace    replace
                        'options    options
                        'result     result
                    ))
                )
            )

            return(result)
        ); prog

        if(_ycRegEx_Params
            apply('funcall _ycRegEx_Params)
            _ycRegEx_Result
        )
    ); let
); ycRegEx

; END
