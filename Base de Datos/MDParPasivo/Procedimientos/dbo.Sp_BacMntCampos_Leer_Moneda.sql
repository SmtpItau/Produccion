USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacMntCampos_Leer_Moneda]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_BacMntCampos_Leer_Moneda] 
            (
            @mpproducto      CHAR(5) = ' '
            )


AS 
BEGIN
   
      SET NOCOUNT ON
      SET DATEFORMAT dmy

      IF @mpproducto <> ' ' BEGIN

            SELECT 

                         M.mncodmon 
                  ,      M.mnnemo   
                  ,      M.mnglosa

            FROM      MONEDA M
                  ,   PRODUCTO_MONEDA P
      
            WHERE       
                  M.mncodmon       = P.mpcodigo
            AND   P.mpproducto     = @mpproducto 
            AND   M.ESTADO<>'A'
            
            
            ORDER BY 
                      M.mnglosa 

      END 
      ELSE BEGIN

            SELECT 

                         mncodmon 
                  ,      mnnemo   
                  ,      mnglosa

            FROM      MONEDA 
      
            ORDER BY 
                      mnglosa 
      

      END

      SET NOCOUNT OFF
END


GO
