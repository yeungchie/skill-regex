;--------------------------
; Program  : skill-regex(compile/ycGetCompileObject.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycGetCompileObject(pattern "t")
    let((obj)
        (hash = _ycRegEx.objects) && pcreObjectp(obj = hash[pattern]) && obj
    )
)

; END