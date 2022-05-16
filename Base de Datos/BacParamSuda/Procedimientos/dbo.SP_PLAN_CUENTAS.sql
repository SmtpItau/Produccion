USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PLAN_CUENTAS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_PLAN_CUENTAS] 
AS
BEGIN
  SET NOCOUNT ON 
  SELECT cuenta ,
     descripcion,
     glosa,
     tipo_cuenta,
     'hora'   = CONVERT(VARCHAR(10),GETDATE(),108),
    'entidad'  = acnomprop,
	'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
  FROM PLAN_DE_CUENTA , VIEW_MDAC
END
--  SELECT * FROM PLAN_DE_CUENTA
--  SELECT * FROM VIEW_MDAC


GO
