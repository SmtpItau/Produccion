USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_VALORES_VALORIZA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_VALORES_VALORIZA]
       (
	@FechaProc   DATETIME,
        @Moneda      INTEGER
       )
AS
BEGIN

   SET NOCOUNT ON 	

   SELECT  ISNULL( vmValor ,   0 ) 	   
     FROM  VIEW_VALOR_MONEDA 
     WHERE vmFecha   = @FechaProc AND
	   VMCODIGO  = @Moneda
	   

    SET NOCOUNT off

END
GO
