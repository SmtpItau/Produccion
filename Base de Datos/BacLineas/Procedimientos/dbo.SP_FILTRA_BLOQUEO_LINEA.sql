USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_FILTRA_BLOQUEO_LINEA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_FILTRA_BLOQUEO_LINEA]
   (   @Estado         CHAR(1)    = ''
   ,   @Tipo_Cliente   NUMERIC(2) = 0
               )
AS
BEGIN

   SET NOCOUNT ON
   
   SELECT 'Cliente'   = CONVERT(VARCHAR(15), client.clrut) + '-' + CONVERT(CHAR(1), client.cldv )
      ,   'Codigo'    = client.clcodigo
      ,   'Nombre'    = ltrim(rtrim( client.clnombre ))
      ,   'Bloqueado' = isnull(lingen.bloqueado, 'N')
      ,   'Motivo'    = CASE WHEN client.motivo_bloqueo = ''  AND lingen.bloqueado = 'S' THEN ' '
                             ELSE ltrim(rtrim( client.motivo_bloqueo ))
END
   FROM   BacLineas.dbo.LINEA_GENERAL      lingen with(nolock)
          INNER JOIN BacParamSuda.dbo.CLIENTE client with(nolock) ON client.clrut    = lingen.rut_cliente 
                                                              AND client.clcodigo = lingen.codigo_cliente

   WHERE (lingen.bloqueado = @Estado       OR @Estado       = '')
   AND   (client.cltipcli  = @Tipo_Cliente OR @Tipo_Cliente = 0 )
   ORDER BY client.clnombre

END
GO
