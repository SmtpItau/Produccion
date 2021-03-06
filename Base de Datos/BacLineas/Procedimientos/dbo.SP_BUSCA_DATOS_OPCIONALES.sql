USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_DATOS_OPCIONALES]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_DATOS_OPCIONALES]
               (
               @Busqueda CHAR(1)
               )
AS
BEGIN
   
   IF @Busqueda = '1' 
      BEGIN
         SELECT mncodmon
         ,      mnnemo
         ,      mnglosa
          FROM VIEW_MONEDA
      END

   IF @Busqueda = '2' 
      BEGIN
         SELECT codigo 
         ,      glosa
          FROM VIEW_FORMA_DE_PAGO
      END

   IF @Busqueda = '3' 
      BEGIN
         SELECT emnombre
         ,      emrut
	 ,      emdv
	 ,      SUBSTRING(ISNULL((select tbglosa from bacparamsuda..tabla_general_detalle where tbcateg=210 and emtipo=tbcodigo1),'S/T'),1,30)
	 ,      ISNULL((select tbcodigo1 from bacparamsuda..tabla_general_detalle where tbcateg=210 and emtipo=tbcodigo1),'')
          FROM VIEW_EMISOR order by emnombre
      END

   IF @Busqueda = '4' 
      BEGIN
         SELECT nombre_sistema
         ,      id_sistema
          FROM VIEW_SISTEMA_CNT WHERE OPERATIVO='S' AND GESTION='N' order by nombre_sistema
      END

   IF @Busqueda = '5' 
      BEGIN
         SELECT incodigo
         ,      inglosa
         ,      inserie
          FROM VIEW_INSTRUMENTO order by inglosa
      END

   IF @Busqueda = '6' 
      BEGIN
         SELECT tbcodigo1
         ,      tbglosa

          FROM BACPARAMSUDA..TABLA_GENERAL_DETALLE
          WHERE tbcateg =210
          order by tbglosa
      END
END
GO
