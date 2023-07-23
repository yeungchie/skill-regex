;--------------------------
; Program  : skill-regex(ycRegExCase.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

defmacro( ycRegExCase (var \@key replace options sub("\\0") \@rest body)
    `prog( nil
        unless('(,@body)
            ycError("too few arguments, expression body undefined - %A" list(,var '(,@body)))
        )
        foreach(_ycRegExCase_var '(,@body)
            when((car(_ycRegExCase_var) == t)
              || ycRegEx(,var eval(car(_ycRegExCase_var)) ,replace ,options ,sub)
                return(
                    if(length(_ycRegExCase_var) > 1
                        car(last(mapcar('eval cdr(_ycRegExCase_var))))
                        ycRegExSub(,sub)
                    )
                )
            )
        )
    )
)

; END