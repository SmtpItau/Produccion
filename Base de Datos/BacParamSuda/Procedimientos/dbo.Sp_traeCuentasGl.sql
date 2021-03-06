USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_traeCuentasGl]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE  PROCEDURE [dbo].[Sp_traeCuentasGl] ( @nCodTr INT ) -- , @nCodCampo Char(12) )
AS 
/***********************************************************************
NOMBRE         : Sp_traeCuentasGl
DESCRIPCION    : Obtiene datos para CBX en Mantenedor Cuentas GL (BacMntGL)
**********************************************************************/

BEGIN

  DECLARE @ctabla   CHAR(250),
		  @cCondic  CHAR(250),
		  @cCampos  CHAR(250),
		  @cExecute VARCHAR(255)

  IF EXISTS(SELECT * FROM tabla_glcode WHERE Codigo_Transaccion = @nCodTr)
     SELECT 'Estatus'= 'SI' --1
            , Codigo_Campo_Condicion  --2
            , Codigo_Condicion --3
            , Descripcion  --4
            , Cuenta_Glcode      -- 5 
            , Cuenta_Supoer      -- 6 
            , Cuenta_Altamira	 -- 7
            , Cuenta_Altamira_per -- 8
            , Cuenta_Cosif        --  9
            , Cuenta_Cosif_Ger   -- 10
            , Cuenta_Glcode_INT  -- 11
            , Cuenta_Glcode_REA  -- 12
            , Cuenta_Altamira_per -- 13
			, cuentaGL_GRM
			, cuentaSbifGRM
      FROM tabla_glcode
     WHERE Codigo_Transaccion = @nCodTr

  ELSE 
  BEGIN
     SELECT 'NO',0,'','','',''
  END

END

GO
