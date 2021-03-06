USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_OPERACIONES]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CONSULTA_OPERACIONES]
   (
   @cCodigo CHAR (02),
   @cTipo  CHAR (01)
   )
AS
BEGIN
 SET NOCOUNT ON 
 SELECT DISTINCT 'numoper'  = CANUMOPER   ,
   'tipoper'  = CATIPOPER   ,
   'Instrumento'  = CAINSTSER   ,
   'rutcli'  = CARUTCLIC   ,
   'Contraparte'  = CLNOMBRE   ,
   'codcli'  = CACODCLIC   , 
   'Tipo_cartera'  = CAINSTSER   , 
   'Nominal'  = CANOMINAL   ,    
   'Tir'   = CATIRCOMP   ,
   'Valor_Presente' = CAVPRESEN   ,  
   'Instrumento'   = CAINST
 FROM  MDCA 
  ,VIEW_CLIENTE
 WHERE     CARUTCLIC  = Clrut
       AND CATIPOPER  = @cCodigo
       
 
--  Sp_Consulta_Operaciones 'CP', ''
--  select *  from mdca    where CANUMOPER = 48481
-- select *  from MDMO
--  select * from VIEW_INSTRUMENTO where incodigo = 111 
--  select * from view_cliente 
  
/* WHERE (CATIPOPER = 'CP' OR CATIPOPER = 'CI' OR CATIPOPER = 'VP'  OR CATIPOPER = 'VI'  OR
   CATIPOPER = 'IB' OR CATIPOPER = 'ST' OR CATIPOPER = 'RCA' OR CATIPOPER = 'RVA' OR
   CATIPOPER = 'IC' OR CATIPOPER = 'AIC') 
   AND  CARUTCLIC    = Clrut 
   AND  CACODCLIC    = Clcodigo
*/
   SET NOCOUNT OFF
END
-- select * from mdca
-- Sp_Consulta_Operaciones 'N', 'T'
-- update MDPA set papapimp=0,paconimp=0
-- select * from MDMO where monumoper = 19
-- select 1051463.0571*15400
-- sp_papeletaantic 7
-- sp_autoriza_ejecutar 'bacuser'


GO
