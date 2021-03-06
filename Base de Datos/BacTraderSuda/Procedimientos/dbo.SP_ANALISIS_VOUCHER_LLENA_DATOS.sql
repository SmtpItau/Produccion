USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ANALISIS_VOUCHER_LLENA_DATOS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ANALISIS_VOUCHER_LLENA_DATOS] ( @TIPO   CHAR (10),
         @ID_SISTEMA         CHAR(3))
AS
BEGIN
 SET NOCOUNT ON
 
 IF @TIPO = 'SISTEMA' BEGIN
   SELECT  id_sistema,
    nombre_sistema
   FROM    VIEW_SISTEMA_CNT
    WHERE operativo = 'S'
                                      AND GESTION = 'N'
     ORDER BY nombre_sistema
    
 END 
 IF @TIPO = 'PRODUCTO' AND @ID_SISTEMA<>'' BEGIN
   SELECT  codigo_producto,
    descripcion
   FROM VIEW_PRODUCTO  
   WHERE  id_sistema = @ID_SISTEMA
 END
 IF @TIPO = 'CUENTA' BEGIN
   SELECT  cuenta,
    descripcion, 
    glosa 
   FROM VIEW_PLAN_DE_CUENTA
   ORDER BY descripcion
  
 END
 SET NOCOUNT OFF
END


GO
