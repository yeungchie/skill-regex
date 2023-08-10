;--------------------------
; Program  : skill-regex(compile/ycGetCompileObject.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycGetCompileObject(pattern "t")
    _ycRegEx.objects && pcreObjectp(_ycRegEx.objects[pattern]) && _ycRegEx.objects[pattern]
)

; END