;--------------------------
; Program  : skill-regex(compile/set.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycRegExSetCompileObject(pattern object "to")
    unless(tablep(_ycRegEx.objects)
        _ycRegEx.objects = makeTable("Compile-Objects" nil)
    )
    unless(pcreObjectp(object)
        ycError("argument #2 should be a pcreObject - %A" object)
    )
    _ycRegEx.objects[pattern] = object
    t
)

; END