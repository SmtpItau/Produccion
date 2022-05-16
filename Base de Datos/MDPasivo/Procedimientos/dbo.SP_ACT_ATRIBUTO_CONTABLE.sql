USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_ATRIBUTO_CONTABLE]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ACT_ATRIBUTO_CONTABLE]
                                                 @campo_atributo    CHAR(20)
                                            ,    @orden             NUMERIC(5)
                                            ,    @estado            CHAR(1)
AS



    UPDATE ATRIBUTO_CONTABLE SET    orden = @orden
                               ,    estado= @estado
                    WHERE campo_atributo = @campo_atributo
GO
