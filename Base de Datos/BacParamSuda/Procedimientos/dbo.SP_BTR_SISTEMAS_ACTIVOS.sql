USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BTR_SISTEMAS_ACTIVOS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_BTR_SISTEMAS_ACTIVOS]
   (   @MiTag   CHAR(1)   = ''   )
AS
BEGIN

   IF @MiTag = ''
   BEGIN
      SELECT id_sistema
      ,      nombre_sistema 
      FROM   SISTEMA_CNT		   with(nolock)
      WHERE  operativo = 'S'
      AND    gestion   = 'N'
      UNION
      
      SELECT Nemo
		,	 Descripcion 
		FROM SADP_MODULOS_EXTERNOS with(nolock)
      
      RETURN
   END 

   IF @MiTag = 'M'
   BEGIN
      SELECT mncodmon , mnnemo , mnglosa 
      FROM   MONEDA   with (nolock)
      WHERE  mntipmon = 2
      or     mncodmon IN(999,998,994)
   END
   IF @MiTag = 'E'
   BEGIN
      SELECT 'A' as Estado, 'ANULADO' as Descri
         union
      SELECT 'E' , 'ENVIADO'
         union
      SELECT 'R' , 'RECIBIDO'
         union
      SELECT 'I' , 'IMPRESO'
         union
      SELECT 'P' , 'PENDIENTE'
   END

END
GO
