USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Filtra_Bloqueo_Linea]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Filtra_Bloqueo_Linea]
               (  @Estado          CHAR(1)      = 0
               ,  @Tipo_Cliente    NUMERIC(2)
               )
AS
BEGIN

   SET TRANSACTION ISOLATION LEVEL READ COMMITTED
   SET NOCOUNT ON
   SET DATEFORMAT dmy
   
      SELECT 'cliente'      = CONVERT(VARCHAR(10),G.rut_cliente) + ' - ' +  cldv
         ,   'Codigo'       = G.codigo_cliente
         ,   'Nombre'       = clnombre
         ,   'Bloqueado'    = G.bloqueado 
      FROM   LINEA_GENERAL   G WITH (NOLOCK)
         ,   CLIENTE
      WHERE  rut_cliente               = clrut
      AND    codigo_cliente            = clcodigo
      AND    ( G.bloqueado             = @Estado OR @Estado = ''            )
      AND    ( CLIENTE.cltipcli        = @Tipo_Cliente OR @Tipo_Cliente = 0 )
      ORDER BY clnombre


END







GO
