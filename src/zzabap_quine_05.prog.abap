REPORT R NO STANDARD PAGE HEADING LINE-SIZE 66.
DATA:A(666),B,N(3) TYPE N,I TYPE I.
A+000 ='REPORT R NO STANDARD PAGE HEADING LINE-SIZE 66.0DATA:A(6'.
A+056 ='66),B,N(\3) TYPE N,I TYPE I.?0DO \577 TIMES.1CASE B.2WHE'.
A+112 ='N`\?`.3N = \0.3DO \1\0 TIMES.4WRITE:/`A+` NO-GAP,N,`=```'.
A+168 =' NO-GAP,A+N(\56) NO-GAP,```.`.4N = N + \56.3ENDDO.3B =``'.
A+224 ='.2WHEN`\0` OR`\1` OR`\2` OR`\3` OR`\4` OR`\5`.3N = \2 * '.
A+280 ='B + \1.3WRITE AT /N A+I(\1) NO-GAP.3B =``.2WHEN`\\`.3WRI'.
A+336 ='TE A+I(\1) NO-GAP.3B =``.2WHEN``.3CASE A+I(\1).4WHEN`\?`'.
A+392 =' OR`\\` OR`\0` OR`\1` OR`\2` OR`\3` OR`\4` OR`\5`.5B = A'.
A+448 ='+I.4WHEN`\``.5WRITE```` NO-GAP.4WHEN OTHERS.5WRITE A+I(\'.
A+504 ='1) NO-GAP.3ENDCASE.1ENDCASE.1I = I + \1.0ENDDO.         '.
DO 577 TIMES.
  CASE B.
    WHEN'?'.
      N = 0.
      DO 10 TIMES.
        WRITE:/'A+' NO-GAP,N,'=''' NO-GAP,A+N(56) NO-GAP,'''.'.
        N = N + 56.
      ENDDO.
      B =''.
    WHEN'0' OR'1' OR'2' OR'3' OR'4' OR'5'.
      N = 2 * B + 1.
      WRITE AT /N A+I(1) NO-GAP.
      B =''.
    WHEN'\'.
      WRITE A+I(1) NO-GAP.
      B =''.
    WHEN''.
      CASE A+I(1).
        WHEN'?' OR'\' OR'0' OR'1' OR'2' OR'3' OR'4' OR'5'.
          B = A+I.
        WHEN'`'.
          WRITE'''' NO-GAP.
        WHEN OTHERS.
          WRITE A+I(1) NO-GAP.
      ENDCASE.
  ENDCASE.
  I = I + 1.
ENDDO.
