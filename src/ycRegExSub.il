;--------------------------
; Program  : skill-regex(ycRegExSub.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycRegExSub(\@key join(" ") pattern \@rest body "Sgl")
    let((strings object)
        when(pattern
            if(stringp(pattern)
                unless(object = ycRegExGetCompileObject(pattern)
                    ycWarn("failed to get pcreObject for pattern %A" pattern)
                )
                ycError("argument for keyword ?pattern shoule be either a string or nil - %A" pattern)
            )
        )
        strings = foreach(mapcar x body
            case(type(x)
                (fixnum
                    if(object
                        pcreSubstitute(object sprintf(nil "\\%d" x))
                        pcreSubstitute(       sprintf(nil "\\%d" x))
                    )
                )
                (string
                    if(object
                        pcreSubstitute(object sprintf(nil "%s" x))
                        pcreSubstitute(       sprintf(nil "%s" x))
                    )
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
