report zquine no standard page heading
              line-size 72.
data: begin of sc,
        hyphen(1)       type c,
        doublehyphen(2) type c,
        komma(1)        type c,
        length          type syfdpos,
        outer(72)       type c,
        inner(72)       type c,
        n4(4)           type n,
        a0001(72) type c value 'report zquine no standard page heading',
        a0002(72) type c value '              line-size 72.',
        a0003(72) type c value 'data: begin of sc,',
        a0004(72) type c value '        hyphen(1)       type c,',
        a0005(72) type c value '        doublehyphen(2) type c,',
        a0006(72) type c value '        komma(1)        type c,',
        a0007(72) type c value '        length          type syfdpos,',
        a0008(72) type c value '        outer(72)       type c,',
        a0009(72) type c value '        inner(72)       type c,',
        a0010(72) type c value '        n4(4)           type n,',
        a0011(72) type c value '        atypecvalue(72) type c,',
        a0012(72) type c value '      end of sc.',
        a0013(72) type c value 'sc-hyphen = " Anführungsstriche',
        a0014(72) type c value '''''',
        a0015(72) type c value '&',
        a0016(72) type c value '''''',
        a0017(72) type c value '.',
        a0018(72) type c value 'concatenate sc-hyphen sc-hyphen',
        a0019(72) type c value '    into sc-doublehyphen.',
        a0020(72) type c value 'do 0056 times varying sc-outer',
        a0021(72) type c value '              from sc-a0001',
        a0022(72) type c value '              next sc-a0002.',
        a0023(72) type c value '  if sy-index = 0011.',
        a0024(72) type c value '    sc-length = strlen( sc-outer )',
        a0025(72) type c value '              - 1.',
        a0026(72) type c value '    sc-komma = sc-outer+sc-length(1).',
        a0027(72) type c value '    do 0056 times varying sc-inner',
        a0028(72) type c value '                  from sc-a0001',
        a0029(72) type c value '                  next sc-a0002.',
        a0030(72) type c value '      sc-n4 = sy-index.',
        a0031(72) type c value '      if sc-inner = sc-doublehyphen.',
        a0032(72) type c value '        concatenate sc-doublehyphen',
        a0033(72) type c value '                    sc-doublehyphen',
        a0034(72) type c value '            into sc-inner.',
        a0035(72) type c value '      endif.',
        a0036(72) type c value '      sc-length = strlen( sc-inner ).',
        a0037(72) type c value '      write:/',
        a0038(72) type c value '        sc-outer(9) no-gap,',
        a0039(72) type c value '        sc-n4 no-gap,',
        a0040(72) type c value '        sc-outer+19(4),',
        a0041(72) type c value '        sc-outer+9(4),',
        a0042(72) type c value '        sc-outer+13(1),',
        a0043(72) type c value '        sc-outer+14(5),',
        a0044(72) type c value '        sc-hyphen no-gap,',
        a0045(72) type c value '        sc-inner(sc-length) no-gap,',
        a0046(72) type c value '        sc-hyphen no-gap,',
        a0047(72) type c value '        sc-komma no-gap.',
        a0048(72) type c value '    enddo.',
        a0049(72) type c value '  endif.',
        a0050(72) type c value '  if sc-outer = sc-doublehyphen.',
        a0051(72) type c value '    concatenate sc-doublehyphen',
        a0052(72) type c value '                sc-doublehyphen',
        a0053(72) type c value '        into sc-outer.',
        a0054(72) type c value '  endif.',
        a0055(72) type c value '  write:/ sc-outer.',
        a0056(72) type c value 'enddo.',
        atypecvalue(72) type c,
      end of sc.
sc-hyphen = " Anführungsstriche
''''
&
''''
.
concatenate sc-hyphen sc-hyphen
    into sc-doublehyphen.
do 0056 times varying sc-outer
              from sc-a0001
              next sc-a0002.
  if sy-index = 0011.
    sc-length = strlen( sc-outer )
              - 1.
    sc-komma = sc-outer+sc-length(1).
    do 0056 times varying sc-inner
                  from sc-a0001
                  next sc-a0002.
      sc-n4 = sy-index.
      if sc-inner = sc-doublehyphen.
        concatenate sc-doublehyphen
                    sc-doublehyphen
            into sc-inner.
      endif.
      sc-length = strlen( sc-inner ).
      write:/
        sc-outer(9) no-gap,
        sc-n4 no-gap,
        sc-outer+19(4),
        sc-outer+9(4),
        sc-outer+13(1),
        sc-outer+14(5),
        sc-hyphen no-gap,
        sc-inner(sc-length) no-gap,
        sc-hyphen no-gap,
        sc-komma no-gap.
    enddo.
  endif.
  if sc-outer = sc-doublehyphen.
    concatenate sc-doublehyphen
                sc-doublehyphen
        into sc-outer.
  endif.
  write:/ sc-outer.
enddo.
