USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_DocPagoMoneda]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Leer_DocPagoMoneda]
			( @CodMon   INTEGER =  0 ,
                                            @MonPago  INTEGER =  0 ,
                                            @FPago    INTEGER =  0 ,
                                            @Activo   CHAR(1) = '1',
                                            @iSistema CHAR(3) = ' ')
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON
     SELECT mfcodmon            	,  -- 1
            ISNULL(a.mnglosa,' ')	,  -- 2
            mfmonpag            	,  -- 3
            ISNULL(b.mnglosa,' ')	,  -- 4
            mfcodfor            	,  -- 5
            ISNULL(glosa,' ')    	,  -- 6
            mfestado             	   -- 7

     FROM MONEDA_FORMA_DE_PAGO  ,
            MONEDA a,
            MONEDA b,
            FORMA_DE_PAGO

      WHERE (mfcodmon = @CodMon  OR @CodMon  =  0)
        AND (mfmonpag = @MonPago OR @MonPago =  0)
        AND (mfcodfor = @FPago   OR @FPago   =  0)
        AND (mfestado = @Activo  OR @Activo  = ' ')
        AND (mfsistema = @iSistema OR @iSistema = ' ')
        AND  mfcodmon = a.mncodmon
        AND  mfmonpag = b.mncodmon
        AND  mfcodfor = codigo
        AND FORMA_DE_PAGO.ESTADO<>'A'

      ORDER BY mfcodmon, mfmonpag, mfcodfor
SET NOCOUNT OFF
END


GO
