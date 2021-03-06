USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_REFRENCIA_MERCADO]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MNT_REFRENCIA_MERCADO]
	(   @iTag     INTEGER
	,   @Codigo   INTEGER       = 0
	,   @Glosa    VARCHAR(50)   = ''
	)
AS
BEGIN
   SET NOCOUNT ON
   IF @iTag = 0
   BEGIN
      SELECT Codigo, Glosa, Estado FROM REFERENCIA_MERCADO WHERE estado = 0
   END
   IF @iTag = 1
   BEGIN
      IF EXISTS(SELECT 1 FROM REFERENCIA_MERCADO WHERE Codigo = @Codigo)
         UPDATE REFERENCIA_MERCADO 
            SET Glosa  = @Glosa
            ,   Estado = 0
          WHERE Codigo = @Codigo
      ELSE
         INSERT INTO REFERENCIA_MERCADO (Codigo,  Glosa,  Estado ) 
                                 VALUES (@Codigo, @Glosa, 0)
   END
   IF @iTag = 2
   BEGIN
      UPDATE REFERENCIA_MERCADO 
         SET Estado = -1 
       WHERE Codigo = @Codigo
   END   
   IF @iTag = 3
   BEGIN
      INSERT INTO REFERENCIA_MERCADO (Codigo,  Glosa,  Estado ) 
      SELECT MAX(Codigo) + 1, '', 1 
        FROM REFERENCIA_MERCADO
      SELECT MAX(Codigo)
        FROM REFERENCIA_MERCADO
   END
   IF @iTag = 4
   BEGIN
      DELETE FROM REFERENCIA_MERCADO 
            WHERE Estado = 1
   END

/******** PRD_21657,INFORMACIÓN UTILIZADA EN: Private Sub LeerReferencias
		  DE  CÓDIGO VB6 (SISTEMA BACSWAP), MANIPULADA POR LA CLASE CLSREFMERCADO****/
	IF @iTag = -1
	BEGIN
		SELECT 'REF'=0,'MOD'='','DIAS'=0,'TIPO'=0,'GLO'='NO APLICA','COD'=0
		UNION
		SELECT RMP.producto,RMP.modalidad,RMP.diasvalor,RMP.idtipocambio,RM.glosa,RM.Codigo 
		FROM Bacparamsuda.dbo.REFERENCIA_MERCADO_PRODUCTO RMP
		left join  BacParamSuda.dbo.REFERENCIA_MERCADO RM 
		ON RMP.Referencia = RM.Codigo 
		WHERE id_sistema = 'PCS'
   END
END
GO
