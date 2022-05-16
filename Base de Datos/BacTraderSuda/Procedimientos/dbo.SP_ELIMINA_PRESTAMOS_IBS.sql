USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_PRESTAMOS_IBS]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ELIMINA_PRESTAMOS_IBS]
  (@nArchivo   NUMERIC(1))
AS
BEGIN

	SET NOCOUNT ON

    IF @nArchivo = 1 
        TRUNCATE TABLE TBL_PRESTAMOS_IBS
    ELSE
       IF @nArchivo = 2
           TRUNCATE TABLE TBL_ANTICIPOS_IBS
       ELSE
           TRUNCATE TABLE TBL_PAGOS_IBS
       
   
   
END
GO
