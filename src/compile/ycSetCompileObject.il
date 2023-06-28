;--------------------------
; Program  : skill-regex(compile/ycSetCompileObject.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycSetCompileObject(pattern object "to")
    let((hash)
        unless(tablep(_ycRegEx.objects)
            _ycRegEx.objects = makeTable("Compile Objects" nil)
        )
        unless(pcreObjectp(object)
            ycError("argument #2 should be a pcreObject - %A" object)
        )
        hash = _ycRegEx.objects
        hash[pattern] = object
        t
    )
)

; END