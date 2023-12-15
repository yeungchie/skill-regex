;--------------------------
; Program  : skill-regex(ycRegExCase.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

defmacro( ycRegExCase (var \@key options sub("\\0") dontMapObj \@rest body)
    `let((_ycRegExCase_clauses _ycRegExCase_clause _ycRegExCase_return)
        unless(_ycRegExCase_clauses = '(,@body)
            ycError("too few arguments, expression body undefined - %A" list(,var _ycRegExCase_clauses))
        )
        ; foreach(_ycRegExCase_clause _ycRegExCase_clauses
        while(_ycRegExCase_clause = car(_ycRegExCase_clauses)
            let((_ycRegExCase_result _ycRegExCase_patterns _ycRegExCase_expression _ycRegExCase_last)
                _ycRegExCase_result = funcall(_ycRegExCase.clauseExtract _ycRegExCase_clause)
                _ycRegExCase_patterns = car(_ycRegExCase_result)
                _ycRegExCase_expression = cdr(_ycRegExCase_result)
                case(ycRegEx(,var _ycRegExCase_patterns nil ,options ,sub ,dontMapObj)
                    (nil
                        ; nil 匹配失败继续下一个 clause
                    )
                    ('t
                        ; 目标 pattern 为 t
                        _ycRegExCase_last = t
                        _ycRegExCase_return = if(_ycRegExCase_expression
                            car(last(mapcar('eval _ycRegExCase_expression)))
                            ,var    ; 空表达式时返回原字符串
                        )
                    )
                    (t
                        ; 匹配成功处理返回值
                        _ycRegExCase_last = t
                        _ycRegExCase_return = if(_ycRegExCase_expression
                            car(last(mapcar('eval _ycRegExCase_expression)))
                            ycRegExSub(,sub)
                        )
                    )
                )
                _ycRegExCase_clauses = if(_ycRegExCase_last
                    nil
                    cdr(_ycRegExCase_clauses)
                )
            ); let
        )
        _ycRegExCase_return
    ); let
)

_ycRegExCase.clauseExtract = lambda((clause)
    let((patterns expression result)
        patterns = car(clause)
        expression = cdr(clause)
        patterns = if(listp(patterns)
            ; 列表判断是否可以作为表达式
            if(symbolp(car(patterns))
            then
                ; 表示式
                result = eval(patterns)
                unless(listp(result)
                    result = list(result)
                )
                result
            else
                ; 非表达式
                patterns
            )
            ; 非列表判断是否可以作为变量
            if(symbolp(patterns)
            then
                ; 变量
                result = eval(patterns)
                unless(listp(result)
                    result = list(result)
                )
                result
            else
                ; 非变量
                list(patterns)
            )
        )
        cons(patterns expression)
    )
); lambda

; END