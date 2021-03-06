USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIBERA_LINEAS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LIBERA_LINEAS]( @FecProceso CHAR(8) )
AS 
BEGIN
 SET NOCOUNT ON
 DECLARE @Contador INTEGER
               ,@sw  CHAR(1)
               ,@NumOpe         INTEGER
 DECLARE cursor_eli SCROLL CURSOR FOR
 SELECT  NumeroOperacion
     FROM view_Linea_Transaccion
         WHERE  Id_Sistema = 'BCC' AND
                FechaVencimiento <= @FecProceso 
 OPEN cursor_eli
 WHILE (1=1)
 BEGIN
  FETCH NEXT FROM cursor_eli
  INTO @NumOpe
  IF (@@fetch_status <> 0)
  BEGIN
                BREAK
  END
                EXECUTE Sp_Lineas_Anula @FecProceso,'BCC',@NumOpe
 END
 CLOSE cursor_eli
 DEALLOCATE cursor_eli
             
 SET NOCOUNT OFF
END



GO
