REPORT A NO STANDARD PAGE HEADING LINE-SIZE 72.DATA:C(72),A(72) OCCURS
0,BEGIN OF V OCCURS 0,I TYPE VARI-CLUSTR,J(34) TYPE X,END OF V.V-I =
34.DEFINE A.V-J ='&1'.APPEND V. END-OF-DEFINITION.
DEFINE B.LOOP AT A INTO C &1 &2.WRITE C.ENDLOOP. END-OF-DEFINITION.
A FF06010102028000313130300000000015020000121F9D02D44136B909C340144ED5 .
A AAE778AB0424C785900A0989C5247112A360478E497F8E58A93D4169AF563B06D405 .
A BCC58CE599F9C6CFF79157EBC35D7445F439A5F623A4AF907EA230F3F8ED0F46F4DA .
A 581094C6604955642AF4D408B4822AA91A7452897490EF02EB8C57646953CED6D99C .
A 918FD065793003709C680B5688462AE81AE3B9B46012F6AD1718C9C8B4EC0E83356C .
A 375BE5F370FDCA84AAA6093EA6125BE04C5BE5BC12B55B0F72A51DB649BC4C38F5BD .
A 1F18395C4A759D4E3DD24AAD38AE2AD04EA882775AF720EF592AAB51225E22CEF88B .
A 9156A0E48EEA3B6EE2034DEE4FFF561BBDF720611475B05474CE292FE0C8F965D56D .
A 05DA18B66F9E124A98B3CA129E5C1E52841DCF37DCFDD7F1F7E10F00630100000000 .
IMPORT A FROM INTERNAL TABLE V.B TO 4.LOOP AT
V.WRITE:/'A',V-J,'.'.ENDLOOP.B FROM 5.
