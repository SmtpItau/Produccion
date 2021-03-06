USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_CamposXproducto_Combo]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_CamposXproducto_Combo]
               (      @Tipo      VARCHAR(50)
               )

AS
BEGIN
   
   SET NOCOUNT ON
   SET DATEFORMAT dmy

   IF @Tipo = 'TIPO EMISOR' BEGIN

      SELECT codigo_tipo
           , descripcion
      FROM TIPO_EMISOR 
            
   END  

   IF @Tipo = 'PLAZO' BEGIN

      SELECT codigo_plazo
           , descripcion
      FROM PLAZO_PACTO
            
   END  

   IF @Tipo = 'TIPO CLIENTE' BEGIN

      SELECT Codigo_Tipo_Cliente,
	     Descripcion
      FROM   TIPO_CLIENTE
      ORDER BY Codigo_Tipo_Cliente
            
   END  

   IF @Tipo = 'CARTERA SUPER' BEGIN

      SELECT *
      FROM   CATEGORIA_CARTERASUPER
            
   END  

   IF @Tipo = 'PRODUCTO INTERFAZ' BEGIN

      SELECT producto_interfaz 
           , descripcion
      FROM   PRODUCTO_CUENTA
            
   END  

   SET NOCOUNT OFF

END




GO
