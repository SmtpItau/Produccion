USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ABRESWOPERACIONESCORREDORA]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  Stored Procedure dbo.sp_AbreSwOperacionesCorredora    Script Date: 06-01-2011 16:41:22 ******/
CREATE PROCEDURE [dbo].[SP_ABRESWOPERACIONESCORREDORA]
(	
	 @AbrirCerrar	int
	,@Operacion     float = 0

)
AS
BEGIN
	SET nocount ON
	
	UPDATE MEAC 
	   SET swOpeCalceCorredora = @AbrirCerrar
	
	DECLARE @oEstado	CHAR(1)
	    SET @oEstado	= ''
	    SET @oEstado	= (SELECT moestatus FROM MEMO with(nolock) WHERE monumope = @Operacion)

	IF @@ERROR <> 0
		SELECT 'ERROR'
	ELSE
		SELECT 'OK'

	IF @Operacion > 0  AND @oEstado <> 'A'
		UPDATE memo
		   SET moestatus = ''
         WHERE MONUMOPE = @Operacion
           AND MOTERM = 'CORREDORA'
           AND MORUTCLI = 97023000
		   AND MOCODCLI = 1

	SET nocount OFF

END





GO
