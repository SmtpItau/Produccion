USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Graba_Relacion_Cliente]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[Sp_Graba_Relacion_Cliente](  @rut1      NUMERIC(10),
		                             @codigo1   NUMERIC( 3),
                		             @rut2      NUMERIC(10),
					     @codigo2   NUMERIC( 3),
					     @porc      FLOAT      )

AS
BEGIN

      SET NOCOUNT ON
      SET DATEFORMAT dmy

    IF EXISTS(SELECT 1 FROM CLIENTE_RELACIONADO WHERE @rut1 = clrut_padre AND @codigo1 = clcodigo_padre  AND @rut2 = clrut_hijo  AND @codigo2 = clcodigo_hijo) BEGIN  
       UPDATE CLIENTE_RELACIONADO SET clrut_padre    = @rut1    ,
                       		clcodigo_padre = @codigo1 ,
			        clrut_hijo     = @rut2    ,
		   	        clcodigo_hijo  = @codigo2 ,
		                clporcentaje   = @porc


       WHERE @rut1 = clrut_padre AND @codigo1 = clcodigo_padre  AND @rut2 = clrut_hijo  AND @codigo2 = clcodigo_hijo

    END ELSE BEGIN
       INSERT INTO CLIENTE_RELACIONADO(clrut_padre    ,
                       		 clcodigo_padre ,
			         clrut_hijo     ,
		   	         clcodigo_hijo  ,
		                 clporcentaje   
                             ) 
                        VALUES ( @rut1    ,
                       		 @codigo1 ,
			         @rut2    ,
		   	         @codigo2 ,
		                 @porc
			)

    END

    SET NOCOUNT OFF
    SELECT "OK"
    RETURN
END




GO
