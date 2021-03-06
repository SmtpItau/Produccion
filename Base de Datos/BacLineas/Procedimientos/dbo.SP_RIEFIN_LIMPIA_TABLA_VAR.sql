USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_LIMPIA_TABLA_VAR]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_LIMPIA_TABLA_VAR] 
      ( @Fecha DATETIME, 
        @Rut numeric(15) = 0, 
        @Codigo numeric(5) = 0,
        @Vehiculo Varchar(15) = 'CORPBANCA'  )  
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DELETE
		TBL_RIEFIN_Tabla_VaR90D   --- select * from TBL_RIEFIN_Tabla_VaR90D
	WHERE 
         Fecha   = @Fecha
    and  ( Rut    = @Rut or @Rut = 0 )
    and  ( Codigo = @Codigo or @Codigo = 0 )
    and  ( Vehiculo = @Vehiculo )
    
END

GO
