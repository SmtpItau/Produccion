USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SERVICIO_MENSAJE_LIBRE]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SERVICIO_MENSAJE_LIBRE]
   (   @Id_Sistema       CHAR(3)      = ''
   ,   @Num_Operacion    NUMERIC(10)  = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @RutEntidad      NUMERIC(10)
   ,       @CodEntidad      NUMERIC(10)
   ,       @NombreEntidad   VARCHAR(50)
   ,       @DirecEntidad    VARCHAR(50)
   ,       @CodSinacofi     VARCHAR(04)

   ,       @SwiftEntidad    VARCHAR(20)
   ,       @CtaCteEntidad   VARCHAR(20)
   ,       @CorespEntidad   VARCHAR(30)

   SELECT  @RutEntidad      = cl.clrut
   ,       @CodEntidad      = cl.clcodigo
   ,       @NombreEntidad   = cl.clnombre
   ,       @DirecEntidad    = cl.cldirecc
   ,       @CodSinacofi     = si.clnumsinacofi
   FROM    bactradersuda..MDAC    ac
   ,       bacparamsuda..CLIENTE  cl
   ,       bacparamsuda..SINACOFI si
   WHERE   ac.acrutprop     =   cl.clrut
   AND     cl.clrut         =   si.clrut
   AND     cl.clcodigo      =   si.clcodigo

   SELECT  @SwiftEntidad    = codigo_swift
   ,       @CtaCteEntidad   = cuenta_corriente
   ,       @CorespEntidad   = nombre
   FROM    bacparamsuda..CORRESPONSAL
   WHERE   rut_cliente    = @RutEntidad
   AND     codigo_cliente = @CodEntidad
   AND     codigo_moneda  = 999

   --     EXECUTE Servicio_Mensaje_Libre 'BTR' , 48953
   --     EXECUTE Servicio_Mensaje_Libre 'BTR' , 48944
   --     EXECUTE Servicio_Mensaje_Libre 'BCC' , 107205

IF @Id_Sistema = 'BTR'
BEGIN
   IF NOT EXISTS(SELECT 1 FROM bactradersuda..MDMO WHERE monumoper = @Num_Operacion AND moforpagi IN(128,129,130))
   BEGIN
      RETURN
   END

   SELECT 'E02INFUSR'   = mousuario
   ,      'E02INFEXA'   = 'MDIR'
   ,      'E02INFTYP'   = 0
   ,      'E02INFTCD'   = CASE WHEN cltipcli = 1 THEN 'BCO'
                               WHEN cltipcli = 2 THEN 'BCO'
                               WHEN cltipcli = 3 THEN 'BCO'
                               WHEN cltipcli = 4 THEN 'CCBB'
                               WHEN cltipcli = 5 THEN 'BCO'
                               WHEN cltipcli = 6 THEN 'AFP'
                               WHEN cltipcli = 7 THEN 'BCO'
                               WHEN cltipcli = 8 THEN 'PPNN'
                               ELSE                   '     '  
                           END
   ,      'E02INFTDM'   = 00
   ,      'E02INFTDD'   = 00
   ,      'E02INFTDY'   = 00
   ,      'E02INFTTM'   = 000000
   ,      'E02INFVDM'   = CASE WHEN DATEPART(MONTH,mofecpro) <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(MONTH,mofecpro))
                               ELSE                                          CONVERT(CHAR(2),DATEPART(MONTH,mofecpro))
                          END
   ,      'E02INFVDD'   = CASE WHEN DATEPART(DAY,mofecpro)   <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(DAY,mofecpro))
                               ELSE                                          CONVERT(CHAR(2),DATEPART(DAY,mofecpro))
                          END
   ,      'E02INFVDY'   = SUBSTRING(CONVERT(CHAR(4),DATEPART(YEAR,mofecpro)),3,2)
   ,      'E02INFVTM'   = 0900
   ,      'E02INFNUM'   = ' '
   ,      'E02INFCDE'   = ' '
   ,      'E02INFSID'   = ltrim(rtrim(@SwiftEntidad))
   ,      'E02INFRID'   = ' '
   ,      'E02INFSRF'   = ltrim(rtrim(@CodSinacofi))
                        + CASE WHEN motipoper = 'CP'   THEN 'CDEF'
                               WHEN motipoper = 'CI'   THEN 'CPAC'
                               WHEN motipoper = 'VP'   THEN 'VDEF'
                               WHEN motipoper = 'VI'   THEN 'VPAC'
                               WHEN motipoper = 'ICAP' THEN 'ICAP'
                               WHEN motipoper = 'ICOL' THEN 'ICOL'
                               WHEN motipoper = 'RV'   THEN 'REVTA'
                               WHEN motipoper = 'RC'   THEN 'RECOMP'
                          END
                        + REPLICATE('0', 6 - LEN(monumoper)) + LTRIM(RTRIM(CONVERT(CHAR(6),monumoper)))
   ,      'E02INFTHF'   = ' '
   ,      'E02INFFMT'   = CASE WHEN motipoper = 'CP'   THEN 'MT298'
                               WHEN motipoper = 'VI'   THEN 'MT298'
                               WHEN motipoper = 'ICAP' THEN 'MT298'
                               WHEN motipoper = 'VP'   THEN 'MT299'
                               WHEN motipoper = 'CI'   THEN 'MT299'
                               WHEN motipoper = 'ICOL' THEN 'MT299'
                               ELSE                         '     '
                          END
   ,      'E02INFDPT'   = ' '
   ,      'E02INFDSQ'   = ' '
   ,      'E02INFIDM'   = CASE WHEN DATEPART(MONTH,mofecven) <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(MONTH,mofecven))
                               ELSE                                          CONVERT(CHAR(2),DATEPART(MONTH,mofecven))
                          END
   ,      'E02INFIDD'   = CASE WHEN DATEPART(DAY,mofecven)   <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(DAY,mofecven))
                               ELSE                                          CONVERT(CHAR(2),DATEPART(DAY,mofecven))
                          END
   ,      'E02INFIDY'   = SUBSTRING(CONVERT(CHAR(4),DATEPART(YEAR,mofecven)),3,2)
   ,      'E02INFOID'   = @RutEntidad
   ,      'E02INFRBI'   = morutcli
   ,      'E02INFACI'   = ' '
   ,      'E02INFPTY'   = 0
   ,      'E02INFSMT'   = ' '
   ,      'E02INFLNO'   = 0
   ,      'E02INFTAG'   = ' '
   ,      'E02INFM01'   = ' '
   ,      'xxxxx'       = ' '
   ,      'yyyyy'       = ' '
   ,      'E02INFM40'   = ' '
   FROM   bactradersuda..MDMO
   ,      bacparamsuda..CLIENTE
   WHERE  monumoper     = @Num_Operacion
   AND    morutcli      = clrut
   AND    mocodcli      = clcodigo
END

IF @Id_Sistema = 'BCC'
BEGIN
   IF NOT EXISTS(SELECT 1 FROM baccamsuda..MEMO WHERE monumope = @Num_Operacion AND ( motipope = 'C' AND moentre IN(128,129,130) ) OR ( motipope = 'V' AND morecib IN(128,129,130) ))
   BEGIN
      RETURN
   END

   SELECT 'E02INFUSR'   = mooper
   ,      'E02INFEXA'   = 'MDIR'
   ,      'E02INFTYP'   = 0
   ,      'E02INFTCD'   = CASE WHEN cltipcli = 1 THEN 'BCO'
                               WHEN cltipcli = 2 THEN 'BCO'
                               WHEN cltipcli = 3 THEN 'BCO'
                               WHEN cltipcli = 4 THEN 'CCBB'
                               WHEN cltipcli = 5 THEN 'BCO'
                               WHEN cltipcli = 6 THEN 'AFP'
                               WHEN cltipcli = 7 THEN 'BCO'
                               WHEN cltipcli = 8 THEN 'PPNN'
                               ELSE                   '     '  
                           END
   ,      'E02INFTDM'   = 00
   ,      'E02INFTDD'   = 00
   ,      'E02INFTDY'   = 00
   ,      'E02INFTTM'   = 000000
   ,      'E02INFVDM'   = CASE WHEN DATEPART(MONTH,mofech) <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(MONTH,mofech))
                               ELSE                                        CONVERT(CHAR(2),DATEPART(MONTH,mofech))
                          END
   ,      'E02INFVDD'   = CASE WHEN DATEPART(DAY,mofech)   <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(DAY,mofech))
                               ELSE                                        CONVERT(CHAR(2),DATEPART(DAY,mofech))
                          END
   ,      'E02INFVDY'   = SUBSTRING(CONVERT(CHAR(4),DATEPART(YEAR,mofech)),3,2)
   ,      'E02INFVTM'   = 0900
   ,      'E02INFNUM'   = ' '
   ,      'E02INFCDE'   = ' '
   ,      'E02INFSID'   = ltrim(rtrim(@SwiftEntidad))
   ,      'E02INFRID'   = ' '
   ,      'E02INFSRF'   = ltrim(rtrim(@CodSinacofi))
                        + CASE WHEN motipope = 'C'   THEN 'CSPOT'
                               WHEN motipope = 'V'   THEN 'VSPOT'
                          END
                        + REPLICATE('0', 6 - LEN(monumope)) + LTRIM(RTRIM(CONVERT(CHAR(6),monumope)))
   ,      'E02INFTHF'   = ' '
   ,      'E02INFFMT'   = CASE WHEN motipope = 'V' THEN 'MT298'
 WHEN motipope = 'C' THEN 'MT299'
                          END
   ,      'E02INFDPT'   = ' '
   ,      'E02INFDSQ'   = ' '
   ,      'E02INFIDM'   = CASE WHEN motipope = 'C' AND DATEPART(MONTH,movaluta1) <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(MONTH,movaluta1))
                               WHEN motipope = 'C' AND DATEPART(MONTH,movaluta1) >  9 THEN       CONVERT(CHAR(2),DATEPART(MONTH,movaluta1))
                               WHEN motipope = 'V' AND DATEPART(MONTH,movaluta2) <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(MONTH,movaluta2))
                               WHEN motipope = 'V' AND DATEPART(MONTH,movaluta2) >  9 THEN       CONVERT(CHAR(2),DATEPART(MONTH,movaluta2))
                          END
   ,      'E02INFIDD'   = CASE WHEN motipope = 'C' AND DATEPART(DAY,movaluta1)   <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(DAY,movaluta1))
                               WHEN motipope = 'C' AND DATEPART(DAY,movaluta1)   >  9 THEN       CONVERT(CHAR(2),DATEPART(DAY,movaluta1))
                               WHEN motipope = 'V' AND DATEPART(DAY,movaluta2)   <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(DAY,movaluta2))
                               WHEN motipope = 'V' AND DATEPART(DAY,movaluta2)   >  9 THEN       CONVERT(CHAR(2),DATEPART(DAY,movaluta2))
                          END
   ,      'E02INFIDY'   = CASE WHEN motipope = 'C' THEN SUBSTRING(CONVERT(CHAR(4),DATEPART(YEAR,movaluta1)),3,2)
                               WHEN motipope = 'V' THEN SUBSTRING(CONVERT(CHAR(4),DATEPART(YEAR,movaluta2)),3,2)
                          END
   ,      'E02INFOID'   = @RutEntidad
   ,      'E02INFRBI'   = morutcli
   ,      'E02INFACI'   = ' '
   ,      'E02INFPTY'   = 0
   ,      'E02INFSMT'   = ' '
   ,      'E02INFLNO'   = 0
   ,      'E02INFTAG'   = ' '
   ,      'E02INFM01'   = ' '
   ,      'xxxxx'       = ' '
   ,      'yyyyy'       = ' '
   ,      'E02INFM40'   = ' '
   FROM   baccamsuda..MEMO
   ,      bacparamsuda..CLIENTE
   WHERE  monumope      = @Num_Operacion
   AND    morutcli      = clrut
   AND    mocodcli      = clcodigo
END

IF @Id_Sistema = 'BFW'
BEGIN
   

   SELECT 'E02INFUSR'   = mooperador
   ,      'E02INFEXA'   = 'MDIR'
   ,      'E02INFTYP'   = 0
   ,      'E02INFTCD'   = CASE WHEN cltipcli = 1 THEN 'BCO'
                               WHEN cltipcli = 2 THEN 'BCO'
                               WHEN cltipcli = 3 THEN 'BCO'
                               WHEN cltipcli = 4 THEN 'CCBB'
                               WHEN cltipcli = 5 THEN 'BCO'
                               WHEN cltipcli = 6 THEN 'AFP'
                               WHEN cltipcli = 7 THEN 'BCO'
                               WHEN cltipcli = 8 THEN 'PPNN'
                               ELSE                   '     '  
                           END
   ,      'E02INFTDM'   = 00
   ,      'E02INFTDD'   = 00
   ,      'E02INFTDY'   = 00
   ,      'E02INFTTM'   = 000000
   ,      'E02INFVDM'   = CASE WHEN DATEPART(MONTH,mofecha) <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(MONTH,mofecha))
                               ELSE                                         CONVERT(CHAR(2),DATEPART(MONTH,mofecha))
                          END
   ,      'E02INFVDD'   = CASE WHEN DATEPART(DAY,mofecha)   <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(DAY,mofecha))
                               ELSE                                         CONVERT(CHAR(2),DATEPART(DAY,mofecha))
                          END
   ,      'E02INFVDY'   = SUBSTRING(CONVERT(CHAR(4),DATEPART(YEAR,mofecha)),3,2)
   ,      'E02INFVTM'   = 0900
   ,      'E02INFNUM'   = ' '
   ,      'E02INFCDE'   = ' '
   ,      'E02INFSID'   = ltrim(rtrim(@SwiftEntidad))
   ,      'E02INFRID'   = ' '
   ,      'E02INFSRF'   = ltrim(rtrim(@CodSinacofi))
                        + CASE WHEN motipoper = 'C'   THEN 'CFUT'
                               WHEN motipoper = 'V'   THEN 'VFUT'
                          END
                        + REPLICATE('0', 6 - LEN(monumoper)) + LTRIM(RTRIM(CONVERT(CHAR(6),monumoper)))
   ,      'E02INFTHF'   = ' '
   ,      'E02INFFMT'   = CASE WHEN motipoper = 'V' THEN 'MT298'
                               ELSE ' '
                          END 
   ,      'E02INFDPT'   = ' '
   ,      'E02INFDSQ'   = ' '
   ,      'E02INFIDM'   = CASE WHEN DATEPART(MONTH,mofecvcto) <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(MONTH,mofecvcto))
                               ELSE                                           CONVERT(CHAR(2),DATEPART(MONTH,mofecvcto))
                          END
   ,      'E02INFIDD'   = CASE WHEN DATEPART(DAY,mofecvcto)   <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(DAY,mofecvcto))
                               ELSE                                           CONVERT(CHAR(2),DATEPART(DAY,mofecvcto))
                          END
   ,      'E02INFIDY'   = SUBSTRING(CONVERT(CHAR(4),DATEPART(YEAR,mofecvcto)),3,2)
   ,      'E02INFOID'   = @RutEntidad
   ,      'E02INFRBI'   = mocodigo
   ,      'E02INFACI'   = ' '
   ,      'E02INFPTY'   = 0
   ,      'E02INFSMT'   = ' '
   ,      'E02INFLNO'   = 0
   ,      'E02INFTAG'   = ' '
   ,      'E02INFM01'   = ' '
   ,      'xxxxx'       = ' '
   ,      'yyyyy'       = ' '
   ,      'E02INFM40'   = ' '
   FROM   bacfwdsuda..MFMO
   ,      bacparamsuda..CLIENTE
   WHERE  monumoper     = @Num_Operacion
   AND    mocodigo      = clrut
   AND    mocodcli      = clcodigo
END
END
GO
