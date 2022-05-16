USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDACION_CLIENTE]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_VALIDACION_CLIENTE]
   (   @clRut      NUMERIC(9)
   ,   @clCodigo   INT
   )
AS
BEGIN

   SET NOCOUNT ON

   IF EXISTS( SELECT 1 FROM BacParamSuda.dbo.CLIENTE WHERE clrut = @clRut and clcodigo = @clCodigo)
      SELECT -1
   ELSE
      SELECT 0

END

GO
