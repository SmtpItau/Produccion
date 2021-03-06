USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_DOCPAGOMONEDA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEER_DOCPAGOMONEDA]( @CodMon   INTEGER =  0 ,
                                        @MonPago  INTEGER =  0 ,
                                        @FPago    INTEGER =  0 ,
                                        @Activo   CHAR(1) = '1')
AS
BEGIN
set nocount on
     SELECT mfcodmon            ,  -- 1
            ISNULL(a.mnglosa,''),  -- 2
            mfmonpag            ,  -- 3
            ISNULL(b.mnglosa,''),  -- 4
            mfcodfor            ,  -- 5
            ISNULL(glosa,'')    ,  -- 6
            mfestado               -- 7
       FROM MONEDA_FORMA_DE_PAGO  ,
            MONEDA a,
            MONEDA b,
            FORMA_DE_PAGO
      WHERE (mfcodmon = @CodMon  OR @CodMon  =  0)
        AND (mfmonpag = @MonPago OR @MonPago =  0)
        AND (mfcodfor = @FPago   OR @FPago   =  0)
        AND (mfestado = @Activo  OR @Activo  = '')
        AND  mfcodmon = a.mncodmon
        AND  mfmonpag = b.mncodmon
        AND  mfcodfor = codigo
      ORDER BY mfcodmon, mfmonpag, mfcodfor
END
-- sp_helptext Sp_Leer_DocPagoMoneda 0,0,0,'1'

GO
