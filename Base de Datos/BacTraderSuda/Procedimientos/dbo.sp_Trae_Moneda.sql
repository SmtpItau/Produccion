USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_Trae_Moneda]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[sp_Trae_Moneda]  
                           (@xCodigo  NUMERIC(3))  
AS  
/***********************************************************************  
NOMBRE         : sp_Trae_Moneda.StoredProcedure  
AUTOR          : SONDA (Unidad de Desarrollo)  
FECHA CREACION : 11/08/2011  
DESCRIPCION    : Migracion a SQL 2008  
HISTORICO DE CAMBIOS  
FECHA        AUTOR           DESCRIPCION     
----------------------------------------------------------------------  
  
  
**********************************************************************/  
  
BEGIN  
set nocount on  
  DECLARE @mnglosa   CHAR(35)  
  DECLARE @mnnemo    CHAR(5)  
  DECLARE @codfox    CHAR(3)  
  DECLARE @mnbase    NUMERIC(3)  
  DECLARE @dias      NUMERIC(5)  
  SELECT @mnglosa  = mnglosa,  
         @mnnemo   = mnnemo,  
         @mnbase   = mnbase,    
         @codfox   = isnull(mncodfox,' ')  
    FROM VIEW_MONEDA  
   WHERE mncodmon = @xCodigo  
  SELECT @dias = 30  
  SELECT @dias = ISNULL(Folio,30) FROM GEN_FOLIOS WHERE Codigo = 'CAP' + RTRIM(@mnnemo)  
  SELECT @mnglosa,  
         @mnnemo,  
         @mnbase,  
         @dias  
set nocount off  
END  /* FIN PROCEDIMIENTO */  

GO
