USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_DETALLE_ATRIBUTO_CONTABLE]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ACT_DETALLE_ATRIBUTO_CONTABLE]
                                                        @icampo_atributo        CHAR(20)
                                                    ,   @icodigo_utilizacion    VARCHAR(15)
                                                    ,   @icodigo_relacion       VARCHAR(15)
AS
BEGIN


	SET DATEFORMAT DMY
	SET NOCOUNT ON


            UPDATE ATRIBUTO_CONTABLE_DETALLE SET codigo_relacion   = @icodigo_relacion
                                    WHERE campo_atributo     = @icampo_atributo
                                      AND codigo_utilizacion = @icodigo_utilizacion

END
GO
