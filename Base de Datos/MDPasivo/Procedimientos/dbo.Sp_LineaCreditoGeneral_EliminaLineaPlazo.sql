USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LineaCreditoGeneral_EliminaLineaPlazo]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_LineaCreditoGeneral_EliminaLineaPlazo]
         (      @rut_cliente     NUMERIC(9)
         ,      @codigo_cliente  NUMERIC(9)
         )

AS
BEGIN
 
   SET TRANSACTION ISOLATION LEVEL READ COMMITTED
   SET NOCOUNT ON
   SET DATEFORMAT dmy

	IF EXISTS(SELECT 1  FROM LINEA_POR_PLAZO WITH (NOLOCK)
	                          where rut_cliente     =  @rut_cliente 
   		                    AND codigo_cliente	=  @codigo_cliente  )
 	 BEGIN

            DELETE FROM LINEA_POR_PLAZO
	          where rut_cliente= @rut_cliente
   		    AND codigo_cliente	=  @codigo_cliente 

                           

         END

END







GO
