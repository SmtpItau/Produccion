USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Tasestdevdo]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** Objeto:  procedimiento  almacenado dbo.SP_TASESTDEVDO    fecha de la secuencia de comandos: 05/04/2001 13:13:52 ******/
CREATE PROCEDURE [dbo].[Sp_Tasestdevdo]
    (
    @dFecha DATETIME
    )
AS
BEGIN
 DECLARE @fEstiPCDUF FLOAT ,
  @fEstiPCDUS FLOAT ,
  @fEstiPTF FLOAT
 SELECT @fEstiPCDUF = ISNULL(vmvalor,0.0) FROM VIEW_VALOR_MONEDA (INDEX=VM01) WHERE vmcodigo=301 AND vmfecha=@dFecha
 SELECT @fEstiPCDUS = ISNULL(vmvalor,0.0) FROM VIEW_VALOR_MONEDA (INDEX=Vm01) WHERE vmcodigo=300 AND vmfecha=@dFecha
 SELECT @fEstiPTF = ISNULL(vmvalor,0.0) FROM VIEW_VALOR_MONEDA (INDEX=Vm01) WHERE vmcodigo=302 AND vmfecha=@dFecha
 SELECT @fEstiPCDUF,@fEstiPCDUS,@fEstiPTF
END
-- SP_TASESTDEVDO '10/26/2000'
GO
