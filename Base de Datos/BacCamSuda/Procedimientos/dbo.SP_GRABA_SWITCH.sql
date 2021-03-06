USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_SWITCH]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_SWITCH]( @Pos     NUMERIC(2) ,
                                  @Val        CHAR(1) ,
                                  @Entidad NUMERIC(3) )
AS
BEGIN
SET NOCOUNT ON
----<< Valida la existencia de la Entidad
IF NOT EXISTS (SELECT aclogdig FROM meac WHERE accodigo = @Entidad)   BEGIN
   SELECT -1, 'No existe Entidad # ' + LTRIM(CONVERT(CHAR(3), @Entidad))
   RETURN
END
----<< Actualiza Switch de Entidad
UPDATE meac
   SET aclogdig = CASE @pos WHEN 1 THEN                         @Val+SUBSTRING(aclogdig,2,9) -- Inicio de Dia
                            WHEN 2 THEN SUBSTRING(aclogdig,1,1)+@Val+SUBSTRING(aclogdig,3,8) -- Parametros Financieros
                            WHEN 3 THEN SUBSTRING(aclogdig,1,2)+@Val+SUBSTRING(aclogdig,4,7) -- Paridades Diarias
                            WHEN 4 THEN SUBSTRING(aclogdig,1,3)+@Val+SUBSTRING(aclogdig,5,6) -- Paridades Mensuales del BCCH
                            WHEN 5 THEN SUBSTRING(aclogdig,1,4)+@Val+SUBSTRING(aclogdig,6,5) -- Posiciones Iniciales
                            WHEN 6 THEN SUBSTRING(aclogdig,1,5)+@Val+SUBSTRING(aclogdig,7,4) -- Cierre Mesa
                            WHEN 7 THEN SUBSTRING(aclogdig,1,6)+@Val+SUBSTRING(aclogdig,8,3) -- Valorizacion Posicion de Cambio
                            WHEN 8 THEN SUBSTRING(aclogdig,1,7)+@Val+SUBSTRING(aclogdig,9,2) -- Contabilidad
                            WHEN 9 THEN SUBSTRING(aclogdig,1,8)+@Val+SUBSTRING(aclogdig,10,1)-- Fin de Dia
                            WHEN 10 THEN SUBSTRING(aclogdig,1,9)+@Val                        -- Rentabilidad
                  END
 WHERE accodigo = @Entidad
IF @@ERROR <> 0   
   SELECT -1, 'No se puede actualizar switch para Entidad # ' + LTRIM(CONVERT(CHAR(3), @Entidad))
       
END

GO
