USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_MDMO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACTUALIZA_MDMO]
AS  
BEGIN  
 SET NOCOUNT ON  
 DECLARE @nrutctr    NUMERIC(10,0)  
 SELECT @nrutctr = 97029000  -- OJO  
 UPDATE mdmo  
 SET motipobono  = '',  
  mocondpacto = ''  
 IF @@error <> 0 BEGIN  
  PRINT 'ERROR_PROC FALLA ACTUALIZANDO MOVIMIENTOS 0.'  
  RETURN 1  
 END  
   /*========================================================================*/  
   /* Tipos de BONOS                                                         */  
   /*========================================================================*/  
   /* BONOS Empresas                                                         */  
   /*========================================================================*/  
 UPDATE mdmo  
 SET motipobono = '1'     
 FROM VIEW_EMISOR , VIEW_INSTRUMENTO  
 WHERE inserie    = 'BONOS'  
 AND emtipo     <> '2'  
 AND morutemi   = emrut  
 AND mocodigo   = incodigo  
  
 IF @@error <> 0 BEGIN  
  PRINT 'ERROR_PROC FALLA ACTUALIZANDO MOVIMIENTOS 1.'  
  RETURN 1  
 END  
   /*========================================================================*/  
   /* BONOS BANCARIOS                                               */  
   /*========================================================================*/  
 UPDATE mdmo  
 SET motipobono = '2'  
 FROM VIEW_EMISOR , VIEW_INSTRUMENTO  
 WHERE inserie    = 'BONOS'  
 AND emtipo     = '2'  
 AND morutemi   = emrut  
 AND mocodigo   = incodigo  
 IF @@error <> 0 BEGIN  
  PRINT 'ERROR_PROC FALLA ACTUALIZANDO MOVIMIENTOS 2.'  
  RETURN 1  
 END  
   /*========================================================================*/  
   /* Condiciones de Compra Definitiva                                       */  
   /*========================================================================*/  
   /* Compra Definitiva                                                      */  
   /* A menos de un año                                                      */  
   /*========================================================================*/  
 UPDATE mdmo  
 SET mocondpacto = '1'  
 FROM VIEW_CLIENTE  
 WHERE motipoper = 'CP'  
 OR DATEDIFF( YEAR, fecha_compra_original, mofecven) <= 1  
 IF @@error <> 0 BEGIN  
  PRINT 'ERROR_PROC FALLA ACTUALIZANDO MOVIMIENTOS 3.'  
  RETURN 1  
 END  
   /*========================================================================*/  
   /* Compra Definitiva                                                      */  
   /* A mas de un año                                                        */  
   /*========================================================================*/  
 UPDATE mdmo  
 SET mocondpacto = '2'  
 FROM VIEW_CLIENTE  
 WHERE motipoper = 'CP'  
 OR DATEDIFF( YEAR, fecha_compra_original, mofecven)      > 1  
 IF @@error <> 0 BEGIN  
  PRINT 'ERROR_PROC FALLA ACTUALIZANDO MOVIMIENTOS 4.'  
  RETURN 1  
 END  
   /*========================================================================*/  
   /* Condiciones de Compra con Pacto                                        */  
   /*========================================================================*/  
--  select * from view_tabla_general_detalle where tbcateg = 405 order by convert(integer,tbcodigo1)  
 UPDATE mdmo  
 SET mocondpacto = CASE  
  WHEN DATEDIFF(  DAY, mofecinip, mofecvenp) > 365  
  AND cltipcli in (4,6,7,8,9,13)  
  THEN  '1'  
  WHEN DATEDIFF(  DAY, mofecinip, mofecvenp) > 365  
  AND cltipcli in (1,2,3)  
  THEN  '2'  
  WHEN DATEDIFF(  DAY, mofecinip, mofecvenp) <= 365  
  AND cltipcli in (4,5,6,7,8,9,13)  
  THEN  '3'  
  WHEN DATEDIFF(  DAY, mofecinip, mofecvenp) <= 365  
  AND cltipcli in (1,2,3)  
  THEN  '4'  
  END  
 FROM VIEW_CLIENTE  
 WHERE motipoper IN ('CI','RV','RVA' )  
 AND morutcli = clrut  
 AND mocodcli = clcodigo  
   /*========================================================================*/  
   /* Condiciones de Venta con Pacto/Recompra/Recompra Anticipada            */  
   /*========================================================================*/  
-- select * from view_TABLA_GENERAL_DETALLE where tbcateg = 406 order by convert(integer,tbcodigo1)  
   
  
 UPDATE mdmo  
 SET mocondpacto = CASE  
  WHEN DATEDIFF(  DAY, mofecinip, mofecvenp) >= 0  
  AND  DATEDIFF(  DAY, mofecinip, mofecvenp) <= 29  
  AND cltipcli in (4,5,6,7,8,9,13,11)  
  AND clrut<>@nrutctr    
  AND motipopero<>'CI'  
  THEN  '1'  
  WHEN DATEDIFF(  DAY, mofecinip, mofecvenp) >= 30  
  AND  DATEDIFF(  DAY, mofecinip, mofecvenp) <= 89  
  AND cltipcli in (4,5,6,7,8,9,13,11)  
  AND clrut<>@nrutctr    
  AND motipopero<>'CI'  
  THEN  '2'  
  WHEN DATEDIFF(  DAY, mofecinip, mofecvenp) >= 90  
  AND  DATEDIFF(  DAY, mofecinip, mofecvenp) <= 365  
  AND cltipcli in (4,5,6,7,8,9,13,11)  
  AND clrut<>@nrutctr    
  AND motipopero<>'CI'  
  THEN  '3'  
  WHEN DATEDIFF(  DAY, mofecinip, mofecvenp) >= 366  
  AND cltipcli in (4,5,6,7,8,9,13,11)  
  AND clrut<>@nrutctr    
  AND motipopero<>'CI'  
  THEN  '4'  
  WHEN DATEDIFF(  DAY, mofecinip, mofecvenp) >= 0  
  AND  DATEDIFF(  DAY, mofecinip, mofecvenp) <= 29  
  AND cltipcli in (1,2,3)  
  AND clrut<>@nrutctr    
  AND motipopero<>'CI'  
  THEN  '5'  
  WHEN DATEDIFF(  DAY, mofecinip, mofecvenp) >= 30  
  AND  DATEDIFF(  DAY, mofecinip, mofecvenp) <= 89  
  AND cltipcli in (1,2,3)  
  AND clrut<>@nrutctr    
  AND motipopero<>'CI'  
  THEN  '6'  
  WHEN DATEDIFF(  DAY, mofecinip, mofecvenp) >= 90  
  AND  DATEDIFF(  DAY, mofecinip, mofecvenp) <= 365  
  AND cltipcli in (1,2,3)  
  AND clrut<>@nrutctr    
  AND motipopero<>'CI'  
  THEN  '7'  
  WHEN DATEDIFF(  DAY, mofecinip, mofecvenp) >= 366  
  AND cltipcli in (1,2,3)  
  AND clrut<>@nrutctr    
  AND motipopero<>'CI'  
  THEN  '8'  
  WHEN clrut=@nrutctr    
  THEN  '20'  
  WHEN motipopero='CI'  
  AND cltipcli in (4,5,6,7,8,9,13,11 )  
  THEN  '21'  
  WHEN motipopero='CI'  
  AND cltipcli in (1,2,3)  
  THEN  '22'  
  END  
 FROM VIEW_CLIENTE  
 WHERE motipoper IN('VI','RC','RCA' )  
 AND morutcli     = clrut  
 AND mocodcli     = clcodigo  
  
 IF @@error <> 0 BEGIN  
  PRINT 'ERROR_PROC FALLA ACTUALIZANDO MOVIMIENTOS 22.'  
  RETURN 1  
 END  
 RETURN 0  
  END
GO
