USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_AyudaCliente_Linea_Transaccion]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_AyudaCliente_Linea_Transaccion]

AS BEGIN

	SET NOCOUNT ON
        SET DATEFORMAT dmy

        SELECT DISTINCT Rut_Cliente
            ,  Codigo_Cliente
        INTO  #LINEA_TRANSACCION
        FROM  LINEA_TRANSACCION

	SELECT 'RUT' = STR(Rut_Cliente) + '-' + cldv
            ,  Codigo_Cliente
            ,  clnombre
            ,  STR(Rut_Cliente)
            ,  cldv  
        FROM   CLIENTE C
           ,   #LINEA_TRANSACCION

        WHERE  Rut_Cliente       = clrut
          AND  Codigo_Cliente    = clcodigo
        ORDER BY clnombre

	SET NOCOUNT OFF

END





GO
