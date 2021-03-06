USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_RISTRA_CONTABLE]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_ACT_RISTRA_CONTABLE]  (
                                            @iRistra    CHAR(69),
                                            @iCuenta    CHAR(15)
                                        )
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


    IF EXISTS( SELECT 1 FROM PLAN_CUENTA_CONTABLE WHERE RISTRA_CONTABLE = @iRistra ) BEGIN

        UPDATE PLAN_CUENTA_CONTABLE
        SET CUENTA_CONTABLE = @iCuenta
        WHERE RISTRA_CONTABLE = @iRistra

    END ELSE BEGIN

        INSERT PLAN_CUENTA_CONTABLE
            ( 
                 RISTRA_CONTABLE
                ,CUENTA_CONTABLE
                ,CODIGO_INVERSION
                ,TIPO_PRODUCTO
            )
        
        VALUES
            ( 
                 @iRistra 
                ,@iCuenta 
                ,0
                ,0
            )

    END

    SELECT 0 , 'OK'

END


GO
