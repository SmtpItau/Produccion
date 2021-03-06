USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_LIN_CONTABLE]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_LIN_CONTABLE]( 
                             @Rut_Cliente         NUMERIC(09)   ,
                             @Codigo_Cliente      NUMERIC(09)   ,
                             @fMonto_SinRiesgo    FLOAT         OUTPUT   ,
                             @fMonto_ConRiesgo    FLOAT         OUTPUT   ,
                             @fMonto_Pesos        FLOAT         OUTPUT
                                             )
AS
BEGIN
        SET NOCOUNT OFF
        SET DATEFORMAT dmy

        SELECT @fMonto_SinRiesgo    = 0.0   ,
               @fMonto_ConRiesgo    = 0.0   ,
               @fMonto_Pesos        = 0.0

                  SELECT  @fMonto_SinRiesgo = ISNULL(SUM(cpvptirc),0.0) FROM VIEW_CARTERA_DISPONIBLE, EMISOR, VIEW_CARTERA_PROPIA P
                                                        WHERE emgeneric = digenemi
							 AND  emrut     = @Rut_Cliente
                                                         AND  dinumdocu = cpnumdocu
							 AND  dicorrela = cpcorrela
							 AND  P.Laminas   = 'L'



                  SELECT  @fMonto_SinRiesgo = @fMonto_SinRiesgo + ISNULL(SUM(civptirc),0.0) FROM VIEW_CARTERA_COMPRA_PACTO
                                                        WHERE cirutcli = @Rut_Cliente
                                                          AND cicodcli = @Codigo_Cliente
                                                          AND Laminas = 'L'

                  SELECT  @fMonto_Pesos = @fMonto_Pesos + ISNULL(SUM(civptirc),0.0) FROM VIEW_CARTERA_COMPRA_PACTO
                                                        WHERE cirutcli = @Rut_Cliente
                                                          AND cicodcli = @Codigo_Cliente
                                                          AND cimascara = 'ICOL'


                  SELECT  @fMonto_ConRiesgo = ISNULL(SUM(civptirc),0.0) FROM VIEW_CARTERA_COMPRA_PACTO
                                                        WHERE  cirutcli = @Rut_Cliente
                                                          AND cicodcli = @Codigo_Cliente
                                                          AND Laminas = 'C'

	SET NOCOUNT ON

END




GO
