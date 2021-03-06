USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_CLIENTE_PTA]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_BUSCA_CLIENTE_PTA]( @Nombre VARCHAR(40) = '' )
AS
BEGIN
     SET NOCOUNT ON
     IF EXISTS (SELECT * FROM abreviatura_cliente, view_cliente
                        WHERE (claglosa  = @Nombre OR @Nombre = '')
            AND  clarutcli = clrut     
                   AND  clacodigo = clcodigo)   BEGIN
        SELECT claglosa, clrut, cldv, clcodigo, clnombre, cltipcli
  
          FROM abreviatura_cliente, 
               view_cliente
         WHERE (claglosa  = @Nombre OR @Nombre = '')
           AND  clarutcli = clrut     
           AND  clacodigo = clcodigo
         ORDER BY claglosa
     END ELSE BEGIN
         ----<< Busca en base de Clientes si no encontro Sinonimo
         SELECT @Nombre, clrut, cldv, clcodigo, clnombre, cltipcli
           FROM view_cliente     
          WHERE clnombre LIKE '%' + @Nombre + '%' 
             OR clnemo   LIKE '%' + @Nombre + '%' 
            AND (clcodigo > 0 AND clcodigo < 4)
          ORDER BY clnombre
     END
END



GO
