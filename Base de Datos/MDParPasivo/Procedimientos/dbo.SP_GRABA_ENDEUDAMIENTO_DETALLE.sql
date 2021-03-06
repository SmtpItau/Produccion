USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_ENDEUDAMIENTO_DETALLE]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GRABA_ENDEUDAMIENTO_DETALLE](
                                                   @rut_cliente         NUMERIC(09)
                                                ,  @codigo_cliente      NUMERIC(09)
                                                ,  @codigo_Grupo        CHAR(10)
                                                ,  @totalocupado        NUMERIC(19,4)
                                                )
AS
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

            INSERT LINEA_ENDEUDAMIENTO_BANCO_DETALLE(
                                                      rut_cliente
                                                   ,  codigo_cliente
                                                   ,  codigo_Grupo
                                                   ,  totalocupado
                                                    )
                        VALUES                      (
                                                      @rut_cliente
                                                   ,  @codigo_cliente
                                                   ,  @codigo_Grupo
                                                   ,  @totalocupado
                                                    )
END
GO
