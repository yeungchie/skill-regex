;--------------------------
; Program  : skill-regex(ycRegExSplit.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycRegExSplit(str \@optional pattern("\\s+") options "Stg")
    cond(
        (ycRegEx("" pattern nil options "\\0" t)
            ; "abc" -//-> ( "a" "b" "c" )
            parseString(str "")
        )
        (!ycRegEx(str pattern nil options  "\\0" t)
            ; "abcdef" -/;;/-> ( "abcdef" )
            list(str)
        )
        (ycRegEx(str strcat("^" pattern) nil options  "\\0" t)
            ; ";;abc;;def" -/;;/-> ( "" "abc;;def" )
            cons("" ycRegExSplit(ycRegEx(str strcat("^" pattern) "" options  "\\0" t) pattern options))
        )
        (ycRegEx(str strcat("^(.+?)" pattern "(.*)") nil options "\\0" t)
            ; "abc;;def" -/;;/-> ( "abc" "def" )
            cons(ycRegExSub(1) ycRegExSplit(ycRegExSub(2) pattern options))
        )
    ); cond
); ycRegExSplit

; END