;--------------------------
; Program  : skill-regex(ycRegExSub.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
; Version  : 2023.06.09
;--------------------------

procedure(ycRegExSub(\@key join(" ") \@rest body "tl")
    let((strings)
        strings = foreach(mapcar x body
            case(type(x)
                (fixnum
                    pcreSubstitute(sprintf(nil "\\%d" x))
                )
                (string
                    pcreSubstitute(sprintf(nil "%s" x))
                )
                (t
                    sprintf(nil "%A" x)
                )
            ) || ""
        )
        buildString(strings join)
    )
); ycRegExSub

; END
