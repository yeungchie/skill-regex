;--------------------------
; Program  : skill-regex(ycRegExCase.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

defmacro( ycRegExCase (var body1 \@key replace options sub("\\0") \@rest body)
    `prog( nil
        foreach(_ycRegExCase_var cons(',body1 '(,@body))
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