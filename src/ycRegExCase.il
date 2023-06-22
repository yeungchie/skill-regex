;--------------------------
; Program  : skill-regex(ycRegExCase.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

defmacro( ycRegExCase (var \@key replace options sub("\\0") \@rest body)
    `prog( nil
        foreach(_ycRegExCase_var '(,@body)
            when(ycRegEx(,var car(_ycRegExCase_var) ,replace ,options ,sub)
                return(
                    cadr(_ycRegExCase_var)
                      && eval(cadr(_ycRegExCase_var))
                      || ycRegExSub(,sub)
                )
            )
        )
    )
)

; END