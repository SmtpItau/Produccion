USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[INFORMACION_VALE_VISTA]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INFORMACION_VALE_VISTA]
as
CREATE TABLE #VALE(
   fechageneracion  datetime,
   fechaemision  datetime,
   formapago  numeric(5)      NOT NULL DEFAULT(0),  
   idsistema  CHAR(3)  NOT NULL DEFAULT(''),
   codigoproducto   CHAR(5)  NOT NULL DEFAULT(''),
         numerooperacion   NUMERIC(9) NOT NULL DEFAULT(0),
   rutcliente  NUMERIC(9) NOT NULL DEFAULT (0),
   dvcliente  CHAR(1)  NOT NULL DEFAULT (''),
          nombrecliente  CHAR(10) NOT NULL DEFAULT (''),
   documentomonto  NUMERIC(9) NOT NULL DEFAULT (0),
   documentonumero  NUMERIC(9) NOT NULL DEFAULT(0), 
   documentoestado  CHAR(1)  NOT NULL DEFAULT(''),
   documentoprotege CHAR(1)  NOT NULL DEFAULT('')
           )
DECLARE @fechageneracion datetime
DECLARE @fechaemision  datetime
DECLARE @formapago  numeric(5)     
DECLARE @idsistema  CHAR(3)  
DECLARE @codigoproducto  CHAR(5)  
DECLARE @numerooperacion   NUMERIC(9)
DECLARE @rutcliente  NUMERIC(9)
DECLARE @dvcliente  CHAR(1)  
DECLARE @nombrecliente  CHAR(10) 
DECLARE @documentomonto  NUMERIC(9) 
DECLARE @documentonumero NUMERIC(9) 
DECLARE @documentoestado CHAR(1) 
DECLARE @documentoprotege CHAR(1) 
          
begin
 select 
  @formapago= moforpagi,  
   @codigoproducto=motipoper,  
   @numerooperacion=monumoper,   
   @rutcliente=morutcli, 
  @dvcliente=(select cldv from view_cliente,mdmo where morutcli=clrut and mocodigo=clcodigo), 
   @nombrecliente=(select clnombre from view_cliente,mdmo where morutcli=clrut and mocodigo=clcodigo),  
  @documentomonto=movalcomp
 from 
  MDMO
  
 where
  (moforpagi=2 or moforpagi=11)
 and  (motipoper='CP' or motipoper='RC' or motipoper='ICAP')
 and  (mostatreg<>'A')
 --and  morutcli=clrut
 --and  mocodcli=clcodigo 
 
 INSERT INTO #VALE(
    formapago ,
     codigoproducto  ,
     numerooperacion ,
     rutcliente ,
    dvcliente ,
     nombrecliente ,
    documentomonto
      )
 VALUES (
  
    ISNULL(@formapago,0)     ,
     ISNULL(@codigoproducto,'')  ,
     ISNULL(@numerooperacion,0)  ,
     ISNULL(@rutcliente,0)     ,
    ISNULL(@dvcliente,'')     ,
     ISNULL(@nombrecliente,'')   ,
    ISNULL(@documentomonto,0)
   )
 SELECT * FROM #VALE
end
 
--select * from mdmo where (moforpagi=2 or moforpagi=11 ) and (motipoper='CP' or motipoper='RC' or motipoper='ICAP')AND MOSTATREG<>'A'
 

GO
