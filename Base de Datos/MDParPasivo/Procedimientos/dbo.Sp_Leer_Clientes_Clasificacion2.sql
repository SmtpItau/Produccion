USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_Clientes_Clasificacion2]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_Leer_Clientes_Clasificacion2]
                     @codigo_clas    VARCHAR   (5)     
AS BEGIN
SET DATEFORMAT dmy   
SET NOCOUNT ON
   
IF @codigo_clas = '01'
BEGIN
      IF NOT EXISTS( SELECT 1 FROM TIPO_MERCADO ) BEGIN

         SELECT 'NO EXISTE'
   
      END ELSE BEGIN

         SELECT Codigo_Mercado
            ,   descripcion
         FROM   TIPO_MERCADO
      END
END

IF @codigo_clas = '02'
BEGIN
      IF NOT EXISTS( SELECT 1 FROM CALIDAD_JURIDICA ) BEGIN

         SELECT 'NO EXISTE'
   
      END ELSE BEGIN

         SELECT Codigo_Calidad
            ,   descripcion
         FROM   CALIDAD_JURIDICA
      END
END

IF @codigo_clas = '03'
BEGIN
      IF NOT EXISTS( SELECT 1 FROM RELACION_IF ) BEGIN

         SELECT 'NO EXISTE'
   
      END ELSE BEGIN

         SELECT Codigo_Relacion_IF
            ,   descripcion
         FROM   RELACION_IF
      END
END

IF @codigo_clas = '04'
BEGIN
      IF NOT EXISTS( SELECT 1 FROM RELACION_BANCO ) BEGIN

         SELECT 'NO EXISTE'
   
      END ELSE BEGIN

         SELECT Codigo_Relacion_Banco
            ,   descripcion
         FROM   RELACION_BANCO
      END
END

IF @codigo_clas = '05'
BEGIN
      IF NOT EXISTS( SELECT 1 FROM CATEGORIA_DEUDOR ) BEGIN

         SELECT 'NO EXISTE'
   
      END ELSE BEGIN

         SELECT Codigo_Deudor
            ,   descripcion
         FROM   CATEGORIA_DEUDOR
      END
END

IF @codigo_clas = '06'
BEGIN
      IF NOT EXISTS( SELECT 1 FROM TIPO_CLIENTE ) BEGIN

         SELECT 'NO EXISTE'
   
      END ELSE BEGIN

         SELECT Codigo_Tipo_Cliente
            ,   descripcion
         FROM   TIPO_CLIENTE
      END
END

IF @codigo_clas = '07'
BEGIN
      IF NOT EXISTS( SELECT 1 FROM SECTOR_ECONOMICO ) BEGIN

         SELECT 'NO EXISTE'
   
      END ELSE BEGIN

         SELECT Codigo_Sector
            ,   descripcion
         FROM   SECTOR_ECONOMICO
      END
END

IF @codigo_clas = '08'
BEGIN
      IF NOT EXISTS( SELECT 1 FROM ACTIVIDAD_ECONOMICA ) BEGIN

         SELECT 'NO EXISTE'
   
      END ELSE BEGIN

         SELECT Codigo_Actividad
            ,   descripcion
         FROM   ACTIVIDAD_ECONOMICA
      END
END

IF @codigo_clas = '09'
BEGIN
      IF NOT EXISTS( SELECT 1 FROM CLASIFICACION_CARTERA_DEUDOR ) BEGIN

         SELECT 'NO EXISTE'
   
      END ELSE BEGIN

         SELECT Codigo_Cartera_Deudor
            ,   descripcion
         FROM   CLASIFICACION_CARTERA_DEUDOR
      END
END

IF @codigo_clas = '10'
BEGIN
      IF NOT EXISTS( SELECT 1 FROM ESTADO_LETRA_HIPOTECARIA ) BEGIN

         SELECT 'NO EXISTE'
   
      END ELSE BEGIN

         SELECT Codigo_Letra
            ,   descripcion
         FROM   ESTADO_LETRA_HIPOTECARIA
      END
END



   SET NOCOUNT OFF
END

GO
