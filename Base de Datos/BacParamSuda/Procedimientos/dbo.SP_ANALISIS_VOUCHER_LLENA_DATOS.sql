USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ANALISIS_VOUCHER_LLENA_DATOS]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Analisis_Voucher_Llena_Datos    fecha de la secuencia de comandos: 03/04/2001 15:17:56 ******/
CREATE PROCEDURE [dbo].[SP_ANALISIS_VOUCHER_LLENA_DATOS] 
      ( 
       @tipo   CHAR (10),
       @id_sistema CHAR(3)
      )
AS
BEGIN
 SET NOCOUNT ON
 
 IF @tipo = 'SISTEMA' BEGIN
   SELECT  id_sistema,
    nombre_sistema
   FROM    SISTEMA_CNT
    WHERE operativo = 'S'
     ORDER BY nombre_sistema
    
 END 
 IF @tipo = 'PRODUCTO' AND @id_sistema <> '' BEGIN
   SELECT  codigo_producto,
    descripcion
   FROM PRODUCTO  
   WHERE  id_sistema = @id_sistema
 END
 IF @tipo = 'CUENTA' BEGIN
   SELECT  cuenta,
    descripcion, 
    glosa 
   FROM PLAN_DE_CUENTA
   ORDER BY descripcion
  
 END
 SET NOCOUNT OFF
END
GO
