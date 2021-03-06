USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_TWB]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_TWB]
                (
    @bookname   char(20)        , 
                         @tradedate  datetime = null 
         )
AS
BEGIN
IF @tradedate IS NULL
   SELECT @tradedate = acfecproc FROM MDAC
IF @bookname = 'REPO'
BEGIN
   IF EXISTS(SELECT acfecproc FROM MDAC WHERE @tradedate = acfecproc)
      SELECT 'SECURITYNAME'  = 'REPO',
             'BOOKNAME'      = 'BACBNK',
             'STRIKE'        = motaspact,
             'EFFECTIVEDATE' = CONVERT(CHAR(8),mofecpro,112),
             'STATUS'        = (CASE WHEN mostatreg = 'A' THEN '102' ELSE '2' END),
             'TRADEDATE'     = CONVERT(CHAR(8),mofecpro,112),
             'TICKETID'      = monumoper,
             'CCYONE'        = VIEW_VALOR_MONEDA.mnsimbol,
             'AMTOME'        = ROUND(movpresen / (CASE WHEN momonpact=999 or momonpact = 13 THEN 1.0 ELSE (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor,1.0) FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA WHERE vmfecha=mofecpro AND vmcodigo=momonpact) END ) , 2),  -- VB+- Cambio por tipo cambio para distinta de 999 o 13
             'ENDDATE'       = CONVERT(CHAR(8),mofecvenp,112),
             'BONDNAME'      = moinstser,
             'BONDCODE'      = SPACE(20),
             'RATEBASIS'     = mobaspact,
             'COUNTERPARTY'  = VIEW_CLIENTE.clnombre,
             'HAIRCUT'       = 0.0,
             'ASSETTYPE'     = 'FI'
        FROM MDMO, VIEW_CLIENTE, VIEW_MONEDA VIEW_VALOR_MONEDA
       WHERE (motipoper = 'CI' OR motipoper = 'VI')
         AND morutcli  = VIEW_CLIENTE.clrut
         and mocodcli  = VIEW_CLIENTE.clcodigo
         and momonpact = VIEW_VALOR_MONEDA.mncodmon
   ELSE
      SELECT 'SECURITYNAME'  = 'REPO',
             'BOOKNAME'      = 'BACBNK',
             'STRIKE'        = motaspact,
             'EFFECTIVEDATE' = CONVERT(CHAR(8),mofecpro,112),
             'STATUS'        = (CASE WHEN mostatreg = 'A' THEN '102' ELSE '2' END),
             'TRADEDATE'     = convert(char(8),mofecpro,112),
             'TICKETID'      = monumoper,
             'CCYONE'        = VIEW_MONEDA.mnsimbol,
             'AMTOME'        = round(movpresen / (CASE WHEN momonpact=999 OR momonpact = 13 THEN 1.0 ELSE (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor,1.0) FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA WHERE vmfecha=mofecpro AND vmcodigo=momonpact) END ) , 2), 
             'ENDDATE'       = CONVERT(CHAR(8),MOFECVENP,112),
             'BONDNAME'      = MOINSTSER,
             'BONDCODE'      = SPACE(20),
             'RATEBASIS'     = MOBASPACT,
             'COUNTERPARTY'  = VIEW_CLIENTE.clnombre,
             'HAIRCUT'       = 0.0,
             'ASSETTYPE'     = 'FI'
        FROM MDMO, VIEW_CLIENTE,VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA, VIEW_MONEDA 
       WHERE (MOTIPOPER = 'CI' OR MOTIPOPER = 'VI')
         AND morutcli  = VIEW_CLIENTE.clrut
         AND mocodcli  = VIEW_CLIENTE.clcodigo
         AND momonpact = VIEW_MONEDA.mncodmon
         AND mofecpro  = @tradedate
END
END   /* FIN PROCEDIMIENTO */
-- SP_INTERFAZ_TWB 'REPO', '20001003'
------------------ hasta aca adrian ------------------------------ 16:30 --------------------------------------


GO
