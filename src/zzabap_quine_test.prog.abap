REPORT ztest_abap_quine
       LINE-SIZE 255 NO STANDARD PAGE HEADING.

CLASS cl_abap_char_utilities DEFINITION LOAD.
DATA: hash1(32), hash2 LIKE hash1.
DATA:a(255) OCCURS 0 WITH HEADER LINE,
     b(255) OCCURS 0 WITH HEADER LINE,
     o TYPE TABLE OF abaplist,
     t TYPE trdir,
     cnt_lines TYPE i, cnt_chars TYPE i, cnt_total TYPE i,
     lines_b TYPE i, lines_min TYPE i,
     s1 TYPE string,
     s2 TYPE string,
     msgv(200),
     i_textpool TYPE TABLE OF textpool.


SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (30) txt_001 FOR FIELD p_name.
SELECTION-SCREEN POSITION pos_low.
PARAMETERS: p_name TYPE trdir-name OBLIGATORY
*                   DEFAULT 'ZQUINE'
                   .
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS p_header AS CHECKBOX DEFAULT 'X'.
SELECTION-SCREEN COMMENT (50) txt_002 FOR FIELD p_header.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN SKIP.
SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS p_list RADIOBUTTON GROUP r1 DEFAULT 'X'.
SELECTION-SCREEN COMMENT (50) txt_003 FOR FIELD p_list.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS p_diff RADIOBUTTON GROUP r1.
SELECTION-SCREEN COMMENT (50) txt_004 FOR FIELD p_diff.
SELECTION-SCREEN END OF LINE.

TOP-OF-PAGE.
  IF p_header EQ 'X'.
    WRITE: / 'Test'(t01), p_name.
    ULINE.
  ENDIF.

INITIALIZATION.
  PERFORM INITIALIZATION.

START-OF-SELECTION.
  SET TITLEBAR '%_T' OF PROGRAM 'RSSYSTDB' WITH p_name.
  SELECT SINGLE * FROM trdir INTO t
         WHERE name EQ p_name.
  IF sy-subrc NE 0.
    MESSAGE e000(38) WITH p_name 'doesn''t exist'.
  ELSEIF t-subc NE '1'.
    MESSAGE e000(38) WITH 'SUBC of' p_name 'is' t-subc.
  ENDIF.
  READ REPORT p_name INTO a STATE 'A'.
  CASE sy-subrc.
    WHEN 0.
    WHEN OTHERS.
*     avoid an empty list being counted as a correct result:
      MESSAGE e000(38)
         WITH 'SY-SUBRC' sy-subrc 'after READ REPORT'.
  ENDCASE.

* free the clipboard contents using a function module
* (you can also use CL_GUI_FRONTEND_SERVICES=>CLIPBOARD_EXPORT
* instead):
  CALL FUNCTION 'CLPB_EXPORT'
    TABLES
      data_tab   = b[]
    EXCEPTIONS
      clpb_error = 1
      OTHERS     = 99.
  IF sy-subrc NE 0.
    MESSAGE i000(38) WITH 'RC' sy-subrc 'after CLBP_EXPORT'.
  ENDIF.
* Run the report:
  SUBMIT (p_name) AND RETURN EXPORTING LIST TO MEMORY.

  CALL FUNCTION 'LIST_FROM_MEMORY'
    TABLES
      listobject = o[]
    EXCEPTIONS
      not_found  = 1
      OTHERS     = 99.
  IF sy-subrc <> 0.
    MESSAGE i000(38) WITH 'RC' sy-subrc 'after LIST_FROM_MEMORY'.
    STOP.
  ENDIF.
  CALL FUNCTION 'LIST_TO_ASCI'
*   EXPORTING
*     LIST_INDEX               = -1
*     WITH_LINE_BREAK          = ' '
    TABLES
      listasci                 = b[]
      listobject               = o[]
    EXCEPTIONS
      empty_list               = 1
      list_index_invalid       = 2
      OTHERS                   = 99.
  IF sy-subrc <> 0.
    MESSAGE i000(38) WITH 'RC' sy-subrc 'after LIST_TO_ASCI'.
    STOP.
  ENDIF.

  IF p_header EQ 'X'. " Try to eliminate default list header
    READ TABLE b INDEX 2.
    IF sy-subrc IS INITIAL AND b(8) CO '-' AND b CO ' -'.
      DELETE b FROM 1 TO 2.
    ELSE.
      MESSAGE i000(38)
         WITH 'List doesn''t seem to contain a default header'.
*      STOP.
      CLEAR p_header.
    ENDIF.
  ENDIF.

  DESCRIBE TABLE a LINES cnt_lines. " cnt_lines = LINES( a ).
  LOOP AT a.
    CONCATENATE s1 a INTO s1 " Unix
                SEPARATED BY cl_abap_char_utilities=>newline.
    CONCATENATE s2 a INTO s2 " Windows
                SEPARATED BY cl_abap_char_utilities=>cr_lf.
    cnt_chars = cnt_chars + STRLEN( a ).
  ENDLOOP.
  SHIFT s1 LEFT.                      " no trailing newline
  SHIFT s2 BY 2 PLACES LEFT. " CIRCULAR. ... for trailing CR/LF?

  cnt_total = STRLEN( s1 ).
  cnt_lines = - cnt_lines.
  cnt_chars = - cnt_chars.
  WRITE: cnt_lines TO msgv(10),
         cnt_chars TO msgv+11(10),
         cnt_total TO msgv+22(10).
  TRANSLATE msgv USING '. , -/'.
  CONDENSE msgv NO-GAPS.
  cnt_lines = - cnt_lines.
  cnt_chars = - cnt_chars.

  cnt_total = STRLEN( s1 ).

  PERFORM calculate_hash USING s1 CHANGING hash1.
  PERFORM calculate_hash USING s2 CHANGING hash2.

  FREE: s1, s2.

  CASE b[].
    WHEN a[].
      CASE p_header.
        WHEN space.
          MESSAGE i000(38)
                  WITH 'correct output'
                        msgv hash1 hash2.
        WHEN OTHERS.
          MESSAGE i000(38)
             WITH 'correct output (with header)'
                      msgv hash1 hash2.
      ENDCASE.
    WHEN OTHERS.
      MESSAGE i000(38)
         WITH 'INCORRECT OUTPUT'
              msgv hash1 hash2.
  ENDCASE.

  EDITOR-CALL FOR b[].

  SET BLANK LINES ON.
  CASE 'X'.
    WHEN p_list.
      LOOP AT a.
        WRITE: / a.
      ENDLOOP.
    WHEN p_diff.
      FORMAT RESET.

      DESCRIBE TABLE b LINES lines_b.
      IF lines_b LT cnt_lines.
        lines_min = lines_b.
      ELSE.
        lines_min = cnt_lines.
      ENDIF.

      DO lines_min TIMES.
        READ TABLE a INDEX sy-index.
        READ TABLE b INDEX sy-index.
        IF a EQ b.
          WRITE: / a.
        ELSE.
          WRITE: / a COLOR COL_POSITIVE, / b COLOR COL_NEGATIVE.
        ENDIF.
      ENDDO.
      ADD 1 TO lines_min.
      IF cnt_lines GE lines_min.
        FORMAT COLOR COL_POSITIVE.
        LOOP AT a FROM lines_min.
          WRITE: / a.
        ENDLOOP.
      ELSEIF lines_b GE lines_min.
        FORMAT COLOR COL_NEGATIVE.
        LOOP AT b FROM lines_min.
          WRITE: / b.
        ENDLOOP.
      ENDIF.
  ENDCASE.

*
FORM INITIALIZATION.
  txt_001 = 'ABAP program name (quine)'(001).
  txt_002 = 'Program doesn''t suppress list header'(002).
  txt_003 = 'List ABAP code'(003).
  txt_004 = 'Primitive diff recocnition'(004).

* I know there's an easier way to suppress the default
* list header...
  READ TEXTPOOL sy-repid INTO i_textpool.
  DELETE i_textpool WHERE id EQ 'R'.
  IF sy-subrc IS INITIAL.
    msgv = '1'.
    IF i_textpool[] IS INITIAL.
      DELETE TEXTPOOL sy-repid.
    ELSE.
      INSERT TEXTPOOL sy-repid FROM i_textpool.
    ENDIF.
  ENDIF.
  DELETE FROM trdirt
         WHERE name EQ sy-repid.
  IF sy-subrc IS INITIAL.
    msgv+1(1) = '2'.
  ENDIF.
  IF NOT msgv IS INITIAL.
    COMMIT WORK.
    SUBMIT (sy-repid).
  ENDIF.
ENDFORM.

*&--------------------------------------------------------------------*
*&      Form  calculate_hash
*&--------------------------------------------------------------------*
*       calculates MD5 hash
*---------------------------------------------------------------------*
FORM calculate_hash
     USING    p_string TYPE string
     CHANGING p_hash   LIKE hash1.

  DATA: i_strlen TYPE i,
        c65535(65535) TYPE c.

  CLEAR p_hash.
  c65535 = p_string.
  i_strlen = STRLEN( p_string ).
  IF i_strlen GT 65535.
    i_strlen = 65535.
  ENDIF.

  CALL FUNCTION 'MD5_CALCULATE_HASH_FOR_CHAR'
    EXPORTING
      data   = c65535
      length = i_strlen
*     VERSION              = 1
    IMPORTING
      hash                 = p_hash
*   TABLES
*     DATA_TAB             =
    EXCEPTIONS
*      no_data              = 0
*      internal_error       = 0
      OTHERS               = 0 . " initial hash in case of error
ENDFORM.                    "calculate_hash
