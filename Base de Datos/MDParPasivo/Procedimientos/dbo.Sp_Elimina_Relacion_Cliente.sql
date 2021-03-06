USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Elimina_Relacion_Cliente]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Elimina_Relacion_Cliente]  
                                              (@rut1      NUMERIC(10),
		                               @codigo1   NUMERIC( 3),
                		               @rut2      NUMERIC(10),
					       @codigo2   NUMERIC( 3) )
AS BEGIN
SET DATEFORMAT dmy
      SET NOCOUNT ON

       DELETE  
         FROM CLIENTE_RELACIONADO
         WHERE @rut1 = clrut_padre AND
               @codigo1 = clcodigo_padre  AND 
               @rut2 = clrut_hijo  AND 
               @codigo2 = clcodigo_hijo

SET NOCOUNT OFF
	SELECT 'OK'
END

GO
