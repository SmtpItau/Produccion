USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FLUJO_CAJA_LEERMES]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Flujo_Caja_LeerMes    fecha de la secuencia de comandos: 03/04/2001 15:18:03 ******/
CREATE PROCEDURE [dbo].[SP_FLUJO_CAJA_LEERMES] (@feano1   NUMERIC (04,0))
AS
BEGIN
SET NOCOUNT ON
       SELECT feano,
              feplaza,
              feene,
              fefeb,
              femar, 
              feabr,
              femay,
              fejun,
              fejul,
              feago, 
              fesep,
              feoct,
              fenov,
              fedic
        FROM  
              FERIADO
        WHERE 
              feano     = @feano1  
        RETURN
SET NOCOUNT OFF
END
GO
