;--------------------------
; Program  : skill-regex(ycRegExSplit.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycRegExSplit(str pattern \@optional options "ttg")
    cond(
        (ycRegEx("" pattern nil options)    ; "abc" -//-> ( "a" "b" "c" )
            parseString(str "")
        )
        (!ycRegEx(str pattern nil options)  ; "abcdef" -/;;/-> ( "abcdef" )
            list(str)
        )
        (ycRegEx(str strcat("^" pattern) nil options)   ; ";;abc;;def" -/;;/-> ( "" "abc;;def" )
            cons("" ycRegExSplit(ycRegEx(str strcat("^" pattern) "" options) pattern options))
        )
        (ycRegEx(str strcat("^(.+?)" pattern "(.*)") nil options)   ; "abc;;def" -/;;/-> ( "abc" "def" )
            cons(ycRegExSub(1) ycRegExSplit(ycRegExSub(2) pattern options))
        )
    ); cond
); ycRegExSplit

; END