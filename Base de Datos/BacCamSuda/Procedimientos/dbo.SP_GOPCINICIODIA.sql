USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GOPCINICIODIA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GOPCINICIODIA]
                 ( @POS     NUMERIC(2),
                   @VALP    CHAR(1)   ,
                   @ENTIDAD CHAR(2)   )
AS
BEGIN
set nocount on 
    IF @POS > 0 
    BEGIN
       BEGIN TRANSACTION
          IF EXISTS (SELECT aclogdig FROM MEAC WHERE acentida = @ENTIDAD )
          BEGIN
               UPDATE MEAC
                  SET aclogdig = CASE @POS
                                 WHEN 1 THEN                          @VALP + SUBSTRING(aclogdig,2,8)    -- Inicio de Dia
                                 WHEN 2 THEN SUBSTRING(aclogdig,1,1)+ @VALP + SUBSTRING(aclogdig,3,7)    -- Parametros Financieros
                                 WHEN 3 THEN SUBSTRING(aclogdig,1,2)+ @VALP + SUBSTRING(aclogdig,4,6)    -- Paridades Diarias
                                 WHEN 4 THEN SUBSTRING(aclogdig,1,3)+ @VALP + SUBSTRING(aclogdig,5,5)    -- Posiciones Iniciales
                                 WHEN 5 THEN SUBSTRING(aclogdig,1,4)+ @VALP + SUBSTRING(aclogdig,6,4)    -- Paridades Mensuales del BCCH
                                 WHEN 6 THEN SUBSTRING(aclogdig,1,5)+ @VALP + SUBSTRING(aclogdig,7,3)    -- Control Oper ???
                                 WHEN 7 THEN SUBSTRING(aclogdig,1,6)+ @VALP + SUBSTRING(aclogdig,8,2)    -- Control Oper ???
                                 WHEN 8 THEN SUBSTRING(aclogdig,1,7)+ @VALP + SUBSTRING(aclogdig,9,1)    -- Pre-Cierre Mesa 
                                 WHEN 9 THEN SUBSTRING(aclogdig,1,8)+ @VALP                             -- Cierre Mesa - Fin de Dia
                                 END
                WHERE acentida = @ENTIDAD
          END
                
          IF @@ERROR<>0
          BEGIN
               ROLLBACK TRANSACTION
               SELECT  'NO'
               RETURN
          END
           
       COMMIT TRANSACTION 
    END
       
    SELECT aclogdig FROM MEAC WHERE acentida = @ENTIDAD
set nocount off
END

GO
