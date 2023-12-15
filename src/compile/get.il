;--------------------------
; Program  : skill-regex(compile/get.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycRegExGetCompileObject(pattern "t")
    _ycRegEx.objects && pcreObjectp(_ycRegEx.objects[pattern]) && _ycRegEx.objects[pattern]
)

; END