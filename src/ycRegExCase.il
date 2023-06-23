;--------------------------
; Program  : skill-regex(ycRegExCase.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

defmacro( ycRegExCase (var body1 \@key replace options sub("\\0") \@rest body)
    `prog( nil
        foreach(_ycRegExCase_var cons(',body1 '(,@body))
            when((car(_ycRegExCase_var) == t)
              || ycRegEx(,var car(_ycRegExCase_var) ,replace ,options ,sub)
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