;--------------------------
; Program  : skill-regex(ycRegEx.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycRegEx(_ycRegEx_str _ycRegEx_pattern \@optional _ycRegEx_replace _ycRegEx_options _ycRegEx_substitute("\\0") "Stggt")
    let((_ycRegEx_Result _ycRegEx_Params)
        _ycRegEx_Result = prog((app str pattern replace options substitute replaceType cmp index cmpOpt char undef result)
            app = getCallingFunction(0)
            foreach(sym '(str pattern replace options substitute)
                set(sym eval(concat("_ycRegEx_" sym)))
            )
            when(replace
                replaceType = type(replace)
            )
            unless(member(replaceType '(string symbol funobj nil))
                error("%s: if you want to use replace mode, the argument #3 should be a string of replacement, symbol of function name or variable of function object, else nil - %A" app replace)
            )
            when((replaceType == 'symbol) && !procedurep(replace)
                error("%s: undefined function - %A" app replace)
            )

            index = 1
            cmpOpt = 0
            options = case(type(options)
                (string options)
                (symbol symbolToString(options))
                (t
                    if(options
                        error("%s: argument #4 should be a string or a symbol - %A" app options)
                        ""
                    )
                )
            )
            for(i 1 strlen(options)
                char = getchar(options i)
                case(char
                    (" "    t)
                    (g      index = 0)
                    (i      cmpOpt = cmpOpt | pcreGenCompileOptBits(?caseLess  t))
                    (m      cmpOpt = cmpOpt | pcreGenCompileOptBits(?multiLine t))
                    (t      undef = strcat(undef || "" char))
                )
            )

            when(undef
                warn("%s: skip undefined options char - %s" app undef)
            )

            unless(cmp = pcreCompile(pattern cmpOpt)
                return()
            )
            when(symbolp(str)
                str = symbolToString(str)
            )

            if(replaceType == 'string
            then
                result = pcreReplace(cmp str replace index)
            else
                when(pcreExecute(cmp str)
                    result = pcreSubstitute(cmp substitute)
                )
                when(member(replaceType '(symbol funobj))
                    _ycRegEx_Params = list(replace list(nil
                        'source     str
                        'pattern    pattern
                        'replace    replace
                        'options    options
                        'result     result
                    ))
                )
            )

            return(result)
        ); prog

        if(_ycRegEx_Params
            apply('funcall _ycRegEx_Params)
            _ycRegEx_Result
        )
    ); let
); ycRegEx

; END
