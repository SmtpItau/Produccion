USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDPEGrabar]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_MDPEGrabar]
       (
        @ncodigo	NUMERIC(03)   , -- C«digo
	@cperiodo     	CHAR(6)		, -- Tipo de Perðodo
	@nnumero	NUMERIC(04)	, -- Intervalo de Tiempo
	@ctipo 		CHAR(1)		, -- Tipo
	@cglosa         CHAR(15)	,  -- Glosa 	
        @primera_vez    CHAR(1)
       )
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON
   /*=======================================================================*/
   /*=======================================================================*/

   IF @primera_vez = 'S'
--	   DELETE BIDASK WHERE NOT EXISTS(SELECT 1 FROM PERIODO_TASA_BIDASK WHERE peperiodo = pecodigo)
	   DELETE PERIODO_TASA_BIDASK WHERE NOT EXISTS(SELECT 1 FROM BIDASK WHERE periodo = pecodigo)


   IF NOT EXISTS(SELECT 1 FROM PERIODO_TASA_BIDASK WHERE pecodigo = @ncodigo) 
	   INSERT INTO PERIODO_TASA_BIDASK ( pecodigo, peperiodo, penumero, petipo, peglosa )
        			 VALUES    ( @ncodigo, @cperiodo, @nnumero, @ctipo, @cglosa )


   IF @@ERROR <> 0  BEGIN
 	     select 1
   END


SET NOCOUNT OFF
SELECT 0
END





GO
